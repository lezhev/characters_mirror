import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_flutter/core/offline/memory_character_sync_store.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('two independent clients converge through cursors and operations',
      () async {
    final server = _FakeCanonicalServer();
    final windows = _LogicalClient(server);
    final android = _LogicalClient(server);
    addTearDown(windows.dispose);
    addTearDown(android.dispose);

    await windows.pull();
    await android.pull();
    expect(windows.store, isNot(same(android.store)));

    final localCreate = await windows.store.saveLocal(
      _LogicalClient.userId,
      CharacterData(
        name: 'Hero',
        currentHp: 20,
        derived: CharacterDerivedData(maxHp: 20),
      ),
    );
    await windows.pushAndPull();
    await android.pull();
    expect(server.characters, hasLength(1));
    expect(await android.characters(), hasLength(1));
    final syncedLocal = await windows.store.getCharacter(
      _LogicalClient.userId,
      localCreate.localId,
    );
    expect(syncedLocal?.localId, localCreate.localId);
    expect(syncedLocal?.serverId, isNotNull);

    await windows.semantic(
      CharacterSyncOperationType.applyDamage,
      CharacterSemanticActionData(amount: 4),
    );
    await android.pull();
    expect((await android.single()).currentHp, 16);

    await android.edit(
      (character) => character.copyWith(
        notes: [CharacterNoteData(id: 'note-a', text: 'From Android')],
      ),
    );
    await windows.pull();
    expect((await windows.single()).notes?.single.text, 'From Android');

    await windows.edit((character) => character.copyWith(name: 'Independent'));
    await android.edit(
      (character) => character.copyWith(customArmorClassBonus: 2),
      synchronize: false,
    );
    await android.pushAndPull();
    await windows.pull();
    await android.pull();
    await _expectConverged(server, windows, android);
    expect(server.characters.single.name, 'Independent');
    expect(server.characters.single.customArmorClassBonus, 2);

    for (var index = 0; index < 6; index++) {
      final writer = index.isEven ? windows : android;
      final reader = index.isEven ? android : windows;
      await writer.edit(
        (character) => character.copyWith(experience: index + 1),
      );
      await reader.pull();
    }
    await _expectConverged(server, windows, android);

    final id = server.characters.single.id!;
    await windows.store.markDeleting(_LogicalClient.userId, id, null);
    await windows.pushAndPull();
    await android.pull();
    await _expectConverged(server, windows, android);
    expect(server.characters, isEmpty);
  });

  test('same-target rejection makes canonical server value win', () async {
    final server = _FakeCanonicalServer();
    final first = _LogicalClient(server);
    final second = _LogicalClient(server);
    addTearDown(first.dispose);
    addTearDown(second.dispose);

    await first.store.saveLocal(
      _LogicalClient.userId,
      CharacterData(name: 'Base'),
    );
    await first.pushAndPull();
    await second.pull();

    await first.edit(
      (character) => character.copyWith(name: 'First wins'),
      synchronize: false,
    );
    await second.edit(
      (character) => character.copyWith(name: 'Second loses'),
      synchronize: false,
    );
    await first.pushAndPull();
    await second.pushAndPull();
    await first.pull();

    await _expectConverged(server, first, second);
    expect(server.characters.single.name, 'First wins');
  });

  test('cursor loss performs an authoritative full resync', () async {
    final server = _FakeCanonicalServer();
    final first = _LogicalClient(server);
    final second = _LogicalClient(server);
    addTearDown(first.dispose);
    addTearDown(second.dispose);

    await first.store.saveLocal(
      _LogicalClient.userId,
      CharacterData(name: 'Recovered'),
    );
    await first.pushAndPull();
    await second.pull();
    await second.store.clearSyncCursor(_LogicalClient.userId);

    await second.pull();

    expect(server.requests.last.fullResync, isTrue);
    await _expectConverged(server, first, second);
  });
}

class _LogicalClient {
  _LogicalClient(this.server) : store = MemoryCharacterSyncStore() {
    coordinator = OfflineSyncCoordinator(
      store: store,
      client: Client('http://localhost:8083/'),
      currentUserId: () => userId,
      syncCharacters: server.sync,
    );
  }

  static const userId = 7;
  final _FakeCanonicalServer server;
  final MemoryCharacterSyncStore store;
  late final OfflineSyncCoordinator coordinator;

  Future<void> pull() => coordinator.syncNow();

  Future<void> pushAndPull() => coordinator.syncNow();

  Future<List<CharacterData>> characters() async => [
        for (final record in await store.getCharacters(userId))
          record.character,
      ];

  Future<CharacterData> single() async => (await characters()).single;

  Future<void> edit(
    CharacterData Function(CharacterData character) update, {
    bool synchronize = true,
  }) async {
    final current = await single();
    await store.saveLocal(userId, update(current));
    if (synchronize) await pushAndPull();
  }

  Future<void> semantic(
    CharacterSyncOperationType type,
    CharacterSemanticActionData action,
  ) async {
    final record = (await store.getCharacters(userId)).single;
    final operation = createCharacterSemanticOperation(
      character: record.character,
      localId: record.localId,
      serverId: record.serverId!,
      type: type,
      action: action,
      changeId: 'semantic-${server.nextClientChangeId++}',
      createdAt: DateTime.utc(2026, 9, 21),
    );
    final visible = replayCharacterSyncOperation(record.character, operation);
    await store.saveSemanticLocal(userId, visible, operation);
    await pushAndPull();
  }

  void dispose() => coordinator.dispose();
}

class _FakeCanonicalServer {
  final Map<int, CharacterData> _characters = {};
  final Map<String, CharacterData?> _applied = {};
  final List<_FakeEvent> _events = [];
  final List<CharacterSyncRequest> requests = [];
  int _nextCharacterId = 1;
  int nextClientChangeId = 1;

  List<CharacterData> get characters => _characters.values.toList();

  Future<CharacterSyncResponse> sync(CharacterSyncRequest request) async {
    requests.add(request);
    final acknowledged = <String>[];
    final rejected = <CharacterRejectedChangeData>[];
    final changed = <String, CharacterData>{};

    for (final operation
        in request.operations ?? const <CharacterSyncOperationData>[]) {
      if (_applied.containsKey(operation.id)) {
        acknowledged.add(operation.id);
        final previous = _applied[operation.id];
        if (previous != null) changed[operation.id] = previous;
        continue;
      }
      if (operation.type == CharacterSyncOperationType.createCharacter) {
        final payload = operation.itemPayload?.characterValue;
        if (payload == null) continue;
        final created = payload.copyWith(
          id: _nextCharacterId++,
          version: 1,
          syncTargetRevisions: const {
            'field:name': 1,
            'field:currentHp': 1,
            'field:customArmorClassBonus': 1,
            'field:experience': 1,
          },
        );
        _characters[created.id!] = created;
        _record(created.id!, false);
        _applied[operation.id] = created;
        acknowledged.add(operation.id);
        changed[operation.id] = created;
        continue;
      }

      final id = operation.characterId;
      final current = id == null ? null : _characters[id];
      if (current == null) {
        rejected.add(CharacterRejectedChangeData(
          changeId: operation.id,
          reason: 'not_found',
        ));
        continue;
      }
      if (operation.type == CharacterSyncOperationType.deleteCharacter) {
        _characters.remove(id);
        _record(id!, true);
        _applied[operation.id] = null;
        acknowledged.add(operation.id);
        continue;
      }

      final targetKey = characterSyncOperationTargetKey(operation);
      final targetRevision =
          current.syncTargetRevisions?[targetKey] ?? current.version ?? 0;
      if (!isCharacterSemanticOperation(operation.type) &&
          operation.baseTargetRevision != targetRevision) {
        rejected.add(CharacterRejectedChangeData(
          changeId: operation.id,
          reason: 'target_conflict',
          character: current,
        ));
        continue;
      }

      final nextVersion = (current.version ?? 0) + 1;
      final next = replayCharacterSyncOperation(current, operation).copyWith(
        id: id,
        version: nextVersion,
        syncTargetRevisions: {
          ...?current.syncTargetRevisions,
          targetKey: nextVersion,
        },
      );
      _characters[id!] = next;
      _record(id, false);
      _applied[operation.id] = next;
      acknowledged.add(operation.id);
      changed[operation.id] = next;
    }

    final deleted = <int>[];
    final pulled = <int, CharacterData>{};
    if (request.fullResync == true) {
      pulled.addAll(_characters);
    } else {
      final cursor = request.pullAfterEventId ?? 0;
      final latest = <int, _FakeEvent>{};
      for (final event in _events.where((event) => event.id > cursor)) {
        latest[event.characterId] = event;
      }
      for (final event in latest.values) {
        final character = _characters[event.characterId];
        if (event.deleted || character == null) {
          deleted.add(event.characterId);
        } else {
          pulled[event.characterId] = character;
        }
      }
    }
    for (final character in changed.values) {
      final id = character.id!;
      final existing = pulled[id];
      if (existing == null ||
          (character.version ?? 0) > (existing.version ?? 0)) {
        pulled[id] = character;
      }
    }
    return CharacterSyncResponse(
      acknowledgedChangeIds: acknowledged,
      rejectedChanges: rejected,
      characters: pulled.values.toList(),
      changedCharacters: changed,
      pullCursor: _events.isEmpty ? 0 : _events.last.id,
      deletedCharacterIds: deleted,
      syncProtocolVersion: characterSemanticSyncProtocolVersion,
      capabilities: const ['authoritative_full_resync'],
      serverTime: DateTime.utc(2026, 9, 21),
    );
  }

  void _record(int characterId, bool deleted) {
    _events.add(_FakeEvent(_events.length + 1, characterId, deleted));
  }
}

class _FakeEvent {
  const _FakeEvent(this.id, this.characterId, this.deleted);

  final int id;
  final int characterId;
  final bool deleted;
}

Future<void> _expectConverged(
  _FakeCanonicalServer server,
  _LogicalClient first,
  _LogicalClient second,
) async {
  expect(await first.store.getPendingChanges(_LogicalClient.userId), isEmpty);
  expect(await second.store.getPendingChanges(_LogicalClient.userId), isEmpty);
  expect(
    _persisted(first: await first.characters()),
    _persisted(first: server.characters),
  );
  expect(
    _persisted(first: await second.characters()),
    _persisted(first: server.characters),
  );
}

List<Map<String, dynamic>> _persisted({required List<CharacterData> first}) {
  final values = [
    for (final character in first)
      Map<String, dynamic>.from(character.toJson())..remove('derived'),
  ];
  values.sort((left, right) =>
      (left['id'] as int? ?? 0).compareTo(right['id'] as int? ?? 0));
  return values;
}
