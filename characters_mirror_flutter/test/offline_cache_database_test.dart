import 'dart:convert';
import 'dart:io';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  test('openDefault creates the v9 offline cache file', () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    final previousPlatform = PathProviderPlatform.instance;
    PathProviderPlatform.instance = _FakePathProviderPlatform(directory.path);
    addTearDown(() async {
      PathProviderPlatform.instance = previousPlatform;
      await directory.delete(recursive: true);
    });

    final defaultCache = await OfflineCacheDatabase.openDefault();
    addTearDown(defaultCache.close);

    expect(
      File(p.join(directory.path, 'characters_mirror_offline_v9.sqlite'))
          .existsSync(),
      isTrue,
    );
  });

  test('allocates negative local ids for offline-created characters', () async {
    final first = await cache.saveLocal(7, CharacterData(name: 'First'));
    final second = await cache.saveLocal(7, CharacterData(name: 'Second'));

    expect(first.localId, -1);
    expect(first.character.id, -1);
    expect(second.localId, -2);
    expect(second.character.id, -2);
    expect(first.status, OfflineCharacterSyncStatus.dirty);
    expect(first.operation, OfflineCharacterSyncOperation.upsert);
  });

  test('equipment selection survives offline cache close and reopen', () async {
    final directory =
        await Directory.systemTemp.createTemp('offline-equipment-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final persistent = await OfflineCacheDatabase.openAt(path);
    final saved = await persistent.saveLocal(
      7,
      CharacterData(
        name: 'Offline equipment',
        equippedArmor: CharacterEquipmentSelectionData(
          referenceKey: 'leather_armor',
          name: 'Leather Armor',
        ),
        equippedShield: CharacterEquipmentSelectionData(name: 'Wooden shield'),
      ),
    );
    persistent.close();

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);
    final restored = (await reopened.getCharacter(7, saved.localId))!.character;
    expect(restored.equippedArmor?.referenceKey, 'leather_armor');
    expect(restored.equippedArmor?.name, 'Leather Armor');
    expect(restored.equippedShield?.referenceKey, isNull);
    expect(restored.equippedShield?.name, 'Wooden shield');
  });

  test('saveLocal enqueues granular upsert operation for server characters',
      () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(
        id: 42,
        name: 'Base',
        updatedAt: DateTime.utc(2026, 4, 24),
        version: 1,
      ),
    );

    final saved = await cache.saveLocal(
      7,
      CharacterData(
        id: 42,
        name: 'Queued',
        updatedAt: DateTime.utc(2026, 4, 24),
      ),
    );

    final changes = await cache.getPendingChanges(7);

    expect(changes, hasLength(1));
    expect(changes.single.changeType, CharacterChangeType.upsert);
    expect(changes.single.entityType, CharacterEntityType.character);
    expect(changes.single.entityId, '42');
    expect(changes.single.payload, isNull);
    expect(changes.single.operationData?.type,
        CharacterSyncOperationType.setField);
    expect(changes.single.operationData?.fieldPath, 'name');
    expect(changes.single.operationData?.value?.stringValue, 'Queued');
    expect(saved.status, OfflineCharacterSyncStatus.dirty);
  });

  test('offline-created character keeps one final create snapshot', () async {
    final local = await cache.saveLocal(7, CharacterData(name: 'Draft'));
    await cache.saveLocal(7, local.character.copyWith(name: 'Final'));

    final changes = await cache.getPendingChanges(7);

    expect(changes, hasLength(1));
    expect(changes.single.operationData?.type,
        CharacterSyncOperationType.createCharacter);
    expect(changes.single.operationData?.characterId, local.localId);
    expect(changes.single.operationData?.localCharacterId, local.localId);
    expect(
      changes.single.operationData?.itemPayload?.characterValue?.name,
      'Final',
    );
  });

  test('keeps the local id addressable after syncing to a server id', () async {
    final local = await cache.saveLocal(7, CharacterData(name: 'Local'));

    await cache.markSynced(
      7,
      local.localId,
      CharacterData(id: 42, name: 'Remote', version: 3),
    );

    final byLocalId = await cache.getCharacter(7, local.localId);
    expect(byLocalId, isNotNull);
    expect(byLocalId!.localId, local.localId);
    expect(byLocalId.serverId, 42);
    final synced = await cache.getCharacter(7, 42);
    expect(synced, isNotNull);
    expect(synced!.localId, local.localId);
    expect(synced.serverId, 42);
    expect(synced.character.name, 'Remote');
    expect(synced.baseCharacter?.name, 'Remote');
    expect(synced.baseVersion, 3);
    expect(synced.status, OfflineCharacterSyncStatus.clean);
  });

  test('canonical server refresh can move cache identity off the temp id',
      () async {
    final local = await cache.saveLocal(7, CharacterData(name: 'Local'));
    final canonical = CharacterData(id: 42, name: 'Remote', version: 3);
    await cache.markSynced(7, local.localId, canonical);
    expect(await cache.getCharacter(7, local.localId), isNotNull);

    await cache.upsertCleanFromServer(7, canonical.copyWith(version: 4));

    expect(await cache.getCharacter(7, local.localId), isNull);
    final byServerId = await cache.getCharacter(7, 42);
    expect(byServerId?.localId, 42);
    expect(byServerId?.serverId, 42);
    expect(byServerId?.character.version, 4);
  });

  test('server refresh does not overwrite pending local edits', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Remote', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Local edit'));

    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Remote refresh', version: 2),
    );

    final cached = await cache.getCharacter(7, 42);
    expect(cached!.character.name, 'Local edit');
    expect(cached.status, OfflineCharacterSyncStatus.dirty);
  });

  test('semantic action payload survives SQLite restart', () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final persistent = await OfflineCacheDatabase.openAt(path);
    final base = CharacterData(
      id: 42,
      currentHp: 10,
      version: 2,
      syncTargetRevisions: const {'field:currentHp': 2},
    );
    await persistent.upsertCleanFromServer(7, base);
    final operation = createCharacterSemanticOperation(
      character: base,
      localId: 42,
      serverId: 42,
      type: CharacterSyncOperationType.applyDamage,
      action: CharacterSemanticActionData(amount: 3),
      changeId: 'durable-damage',
      createdAt: DateTime.utc(2026, 9, 14),
    );
    await persistent.saveSemanticLocal(
      7,
      base.copyWith(currentHp: 7),
      operation,
    );
    persistent.close();

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);
    final pending = await reopened.getPendingChanges(7);

    expect(pending, hasLength(1));
    expect(pending.single.operationData?.type,
        CharacterSyncOperationType.applyDamage);
    expect(
      pending.single.operationData?.value?.semanticActionValue?.amount,
      3,
    );
    expect(
      pending
          .single.operationData?.value?.semanticActionValue?.baseBarrierTokens,
      const {
        'field:currentHp': 'revision:2',
        'field:temporaryHp': 'revision:0',
      },
    );
    expect((await reopened.getCharacter(7, 42))?.character.currentHp, 7);
  });

  test('repair retries an operation left processing by a process restart',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final persistent = await OfflineCacheDatabase.openAt(path);
    await persistent.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 1),
    );
    await persistent.saveLocal(7, CharacterData(id: 42, name: 'Pending'));
    final change = (await persistent.getPendingChanges(7)).single;
    await persistent.markChangesProcessing(7, [change.id]);
    expect(await persistent.getPendingChanges(7), isEmpty);
    persistent.close();

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);
    await reopened.repairSyncQueue(7);

    final pending = await reopened.getPendingChanges(7);
    expect(pending, hasLength(1));
    expect(pending.single.id, change.id);
    expect(pending.single.status, OfflineCharacterChangeStatus.failed);
  });

  test('accepted remote delete removes clean and pending rows', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Remote', version: 1),
    );

    await cache.applyRemoteDelete(7, 42);
    expect(await cache.getCharacter(7, 42), isNull);

    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 43, name: 'Remote', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 43, name: 'Local edit'));

    await cache.applyRemoteDelete(7, 43);

    expect(await cache.getCharacter(7, 43), isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
  });

  test('markDeleting enqueues delete change', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(
        id: 42,
        name: 'Remote',
        updatedAt: DateTime.utc(2026, 4, 24),
      ),
    );

    await cache.markDeleting(7, 42, null);
    final changes = await cache.getPendingChanges(7);

    expect(changes, hasLength(1));
    expect(changes.single.changeType, CharacterChangeType.delete);
    expect(changes.single.entityId, '42');
    expect(
      changes.single.operationData?.type,
      CharacterSyncOperationType.deleteCharacter,
    );
  });

  test('offline-created character deleted before sync sends nothing', () async {
    final local = await cache.saveLocal(7, CharacterData(name: 'Draft'));

    await cache.markDeleting(7, local.localId, null);

    expect(await cache.getCharacter(7, local.localId), isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
  });

  test('conflicts preserve the queued operation', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Remote', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Local edit'));

    await cache.markConflict(
      7,
      42,
      CharacterData(id: 42, name: 'Conflict', version: 2),
      'conflict',
    );

    final cached = await cache.getCharacter(7, 42);
    expect(cached!.status, OfflineCharacterSyncStatus.conflict);
    expect(cached.operation, OfflineCharacterSyncOperation.upsert);
    expect(cached.baseCharacter?.name, 'Remote');
    expect(cached.character.name, 'Local edit');
    expect(cached.conflictCharacter?.name, 'Conflict');
  });

  test('delete conflicts preserve the queued operation and base character',
      () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Remote', version: 1),
    );
    await cache.markDeleting(7, 42, null);

    await cache.markConflict(
      7,
      42,
      CharacterData(id: 42, name: 'Conflict', version: 2),
      'conflict',
    );

    final cached = await cache.getCharacter(7, 42);
    expect(cached!.status, OfflineCharacterSyncStatus.conflict);
    expect(cached.operation, OfflineCharacterSyncOperation.delete);
    expect(cached.baseCharacter?.name, 'Remote');
    expect(cached.conflictCharacter?.name, 'Conflict');
  });

  test('reads legacy string notes payloads as note lists', () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute(
        '''
INSERT INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  sync_status, sync_operation, local_updated_at, server_updated_at,
  last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''',
        [
          7,
          42,
          42,
          jsonEncode({'id': 42, 'name': 'Local', 'notes': 'Local note'}),
          jsonEncode({'id': 42, 'name': 'Base', 'notes': 'Base note'}),
          1,
          OfflineCharacterSyncStatus.conflict.name,
          OfflineCharacterSyncOperation.upsert.name,
          DateTime.utc(2026, 4, 22).toIso8601String(),
          null,
          'conflict',
          jsonEncode({
            'id': 42,
            'name': 'Conflict',
            'notes': 'Conflict note',
          }),
        ],
      );
    } finally {
      db.dispose();
    }

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);

    final cached = await reopened.getCharacter(7, 42);

    expect(
      cached?.character.notes?.map((note) => note.text).toList(),
      const ['Local note'],
    );
    expect(
      cached?.baseCharacter?.notes?.map((note) => note.text).toList(),
      const ['Base note'],
    );
    expect(
      cached?.conflictCharacter?.notes?.map((note) => note.text).toList(),
      const ['Conflict note'],
    );
  });

  test('legacy string notes decode to stable ids across cache opens', () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute(
        '''
INSERT INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  sync_status, sync_operation, local_updated_at, server_updated_at,
  last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''',
        [
          7,
          42,
          42,
          jsonEncode({'id': 42, 'name': 'Local', 'notes': 'Local note'}),
          null,
          1,
          OfflineCharacterSyncStatus.clean.name,
          null,
          DateTime.utc(2026, 4, 22).toIso8601String(),
          null,
          null,
          null,
        ],
      );
    } finally {
      db.dispose();
    }

    final firstOpen = await OfflineCacheDatabase.openAt(path);
    final firstId =
        (await firstOpen.getCharacter(7, 42))?.character.notes?.single.id;
    firstOpen.close();

    final secondOpen = await OfflineCacheDatabase.openAt(path);
    addTearDown(secondOpen.close);
    final secondId =
        (await secondOpen.getCharacter(7, 42))?.character.notes?.single.id;

    expect(firstId, isNotNull);
    expect(secondId, firstId);
  });

  test('reads legacy string equipment payloads as structured inventory items',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute(
        '''
INSERT INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  sync_status, sync_operation, local_updated_at, server_updated_at,
  last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''',
        [
          7,
          42,
          42,
          jsonEncode({'id': 42, 'name': 'Local', 'equipment': 'Короткий меч'}),
          null,
          1,
          OfflineCharacterSyncStatus.clean.name,
          null,
          DateTime.utc(2026, 4, 22).toIso8601String(),
          null,
          null,
          null,
        ],
      );
    } finally {
      db.dispose();
    }

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);

    final cached = await reopened.getCharacter(7, 42);
    final item = cached?.character.equipment?.single;

    expect(item?.name, 'Короткий меч');
    expect(item?.quantity, 1);
    expect(item?.type, CharacterInventoryItemType.custom);
  });

  test('reads generic choice group from reference cache', () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute(
        '''
INSERT INTO reference_cache(kind, cache_key, payload_json, fetched_at)
VALUES (?, ?, ?, ?)
''',
        [
          offlineBackgroundStepKind,
          offlineBackgroundStepKey(42),
          jsonEncode({
            'choiceGroups': [
              {
                'group': {
                  'id': 1,
                  'referenceKey': 'background_language_choice',
                  'name': 'Skills',
                  'sourceBackgroundId': 42,
                  'type': 'language',
                  'selectionCount': 2,
                  'exclusiveKey': 'background_42_skill_pick',
                },
                'options': [],
              },
            ],
          }),
          DateTime.utc(2026, 4, 22).toIso8601String(),
        ],
      );
    } finally {
      db.dispose();
    }

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);

    final cached = await reopened.getReference<BackgroundStepView>(
      offlineBackgroundStepKind,
      offlineBackgroundStepKey(42),
      BackgroundStepView.fromJson,
    );

    expect(
      cached?.choiceGroups?.single.group?.type,
      ChoiceType.language,
    );
  });

  test('reads legacy queued snapshot rows after operation migration', () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute(
        '''
INSERT INTO character_changes(
  id, user_id, change_type, entity_type, entity_id, payload_json,
  created_at, base_updated_at, status, last_error
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''',
        [
          'legacy-change',
          7,
          CharacterChangeType.upsert.name,
          CharacterEntityType.character.name,
          '42',
          jsonEncode({'id': 42, 'name': 'Legacy'}),
          DateTime.utc(2026, 4, 22).toIso8601String(),
          null,
          OfflineCharacterChangeStatus.pending.name,
          null,
        ],
      );
    } finally {
      db.dispose();
    }

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);

    final changes = await reopened.getPendingChanges(7);

    expect(changes, hasLength(1));
    expect(changes.single.id, 'legacy-change');
    expect(changes.single.payload?.name, 'Legacy');
    expect(changes.single.operationData, isNull);
  });

  test('reads legacy primitive sync value rows after operation migration',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute(
        '''
INSERT INTO character_changes(
  id, user_id, change_type, entity_type, entity_id, payload_json,
  created_at, base_updated_at, status, last_error, operation_type,
  target_type, target_id, field_path, value_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''',
        [
          'legacy-primitive-value',
          7,
          CharacterChangeType.upsert.name,
          CharacterEntityType.character.name,
          '42',
          null,
          DateTime.utc(2026, 4, 22).toIso8601String(),
          null,
          OfflineCharacterChangeStatus.pending.name,
          null,
          CharacterSyncOperationType.setField.name,
          CharacterSyncTargetType.field.name,
          'name',
          'name',
          jsonEncode('Queued'),
        ],
      );
    } finally {
      db.dispose();
    }

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);

    final changes = await reopened.getPendingChanges(7);

    expect(changes, hasLength(1));
    expect(changes.single.operationData?.characterId, 42);
    expect(changes.single.operationData?.localCharacterId, 42);
    expect(changes.single.operationData?.value?.stringValue, 'Queued');
  });

  test('repair removes legacy rows and rebuilds missing v2 operations',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final initialCache = await OfflineCacheDatabase.openAt(path);

    final base = CharacterData(
      id: 42,
      name: 'Base',
      version: 1,
      alignmentValue: CharacterAlignment.lawfulGood,
      equipment: [
        CharacterInventoryItemData(
          id: 'item-1',
          name: 'Rope',
          quantity: 1,
          type: CharacterInventoryItemType.custom,
        ),
      ],
    );
    await initialCache.upsertCleanFromServer(
      7,
      base,
    );
    final local = base.copyWith(
      equipment: [
        CharacterInventoryItemData(
          id: 'item-1',
          name: 'Rope and torch',
          quantity: 1,
          type: CharacterInventoryItemType.custom,
        ),
      ],
    );
    await initialCache.saveLocal(
      7,
      local,
    );
    initialCache.close();

    final db = sqlite3.open(path);
    try {
      db.execute("DELETE FROM character_changes WHERE user_id = 7");
      db.execute(
        '''
INSERT INTO character_changes(
  id, user_id, change_type, entity_type, entity_id, payload_json,
  created_at, base_updated_at, status, last_error
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''',
        [
          'legacy-rejected-snapshot',
          7,
          CharacterChangeType.upsert.name,
          CharacterEntityType.character.name,
          '42',
          jsonEncode(local.toJson()),
          DateTime.utc(2026, 4, 22).toIso8601String(),
          null,
          OfflineCharacterChangeStatus.failed.name,
          'Legacy sync failure',
        ],
      );
    } finally {
      db.dispose();
    }

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);
    await reopened.repairSyncQueue(7);
    final pending = await reopened.getPendingChanges(7);

    expect(pending, hasLength(1));
    expect(pending.single.operationData, isNotNull);
    expect(pending.single.operationData?.fieldPath, 'equipment');
    expect(
      pending.single.operationData?.itemPayload?.equipmentValue?.name,
      'Rope and torch',
    );
    expect(pending.single.id, isNot('legacy-rejected-snapshot'));
  });

  test('note edit and queue survive an immediate SQLite close and reopen',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final persistent = await OfflineCacheDatabase.openAt(path);
    final base = CharacterData(
      id: 42,
      name: 'Hero',
      version: 1,
      notes: [CharacterNoteData(id: 'note-1', text: 'Old note')],
      syncTargetRevisions: const {'item:notes:note-1': 1},
    );
    await persistent.upsertCleanFromServer(7, base);
    await persistent.saveLocal(
      7,
      base.copyWith(
        notes: [CharacterNoteData(id: 'note-1', text: 'Quick edit')],
      ),
    );
    persistent.close();

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);
    final record = await reopened.getCharacter(7, 42);
    final queued = await reopened.getPendingChanges(7);

    expect(record?.status, OfflineCharacterSyncStatus.dirty);
    expect(record?.character.notes?.single.text, 'Quick edit');
    expect(record?.baseCharacter?.notes?.single.text, 'Old note');
    expect(queued, hasLength(1));
    expect(queued.single.operationData?.targetId, 'note-1');
    expect(queued.single.operationData?.localCharacterId, 42);
    expect(queued.single.operationData?.characterId, 42);
    expect(
      queued.single.operationData?.itemPayload?.noteValue?.text,
      'Quick edit',
    );
  });

  test('repair does not retry a dirty row with a terminal sync error',
      () async {
    final directory = await Directory.systemTemp.createTemp('offline-cache-');
    addTearDown(() => directory.delete(recursive: true));
    final cache = await OfflineCacheDatabase.openAt(
      '${directory.path}/cache.sqlite',
    );
    addTearDown(cache.close);

    final base = CharacterData(id: 42, name: 'Base', version: 1);
    await cache.upsertCleanFromServer(7, base);
    await cache.saveLocal(7, base.copyWith(name: 'Rejected'));
    final change = (await cache.getPendingChanges(7)).single;
    await cache.markChangeConflict(7, change.id, base, 'Validation failed');
    await cache.markSyncError(7, 42, 'Validation failed');

    await cache.repairSyncQueue(7);

    expect(await cache.getPendingChanges(7), isEmpty);
    final record = await cache.getCharacter(7, 42);
    expect(record?.status, OfflineCharacterSyncStatus.dirty);
    expect(record?.lastSyncError, 'Validation failed');
  });
}

class _FakePathProviderPlatform extends PathProviderPlatform {
  _FakePathProviderPlatform(this.applicationSupportPath);

  final String applicationSupportPath;

  @override
  Future<String?> getApplicationSupportPath() async => applicationSupportPath;
}
