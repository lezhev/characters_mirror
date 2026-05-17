import 'dart:convert';
import 'dart:io';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
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

  test('saveLocal enqueues snapshot upsert change', () async {
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
    expect(changes.single.payload?.name, 'Queued');
    expect(saved.status, OfflineCharacterSyncStatus.dirty);
  });

  test('remaps a negative local id to the synced server id', () async {
    final local = await cache.saveLocal(7, CharacterData(name: 'Local'));

    await cache.markSynced(
      7,
      local.localId,
      CharacterData(id: 42, name: 'Remote', version: 3),
    );

    expect(await cache.getCharacter(7, local.localId), isNull);
    final synced = await cache.getCharacter(7, 42);
    expect(synced, isNotNull);
    expect(synced!.localId, 42);
    expect(synced.serverId, 42);
    expect(synced.character.name, 'Remote');
    expect(synced.baseCharacter?.name, 'Remote');
    expect(synced.baseVersion, 3);
    expect(synced.status, OfflineCharacterSyncStatus.clean);
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

  test('reads legacy skill class choice group type from reference cache',
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
                  'name': 'Skills',
                  'sourceBackgroundId': 42,
                  'type': 'skill',
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

    expect(cached?.choiceGroups?.single.group?.type, isNull);
  });
}
