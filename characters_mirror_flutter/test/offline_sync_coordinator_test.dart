import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services_native.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/reference_character_repository.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  test('syncNow requested while active runs one more pass', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Queued'));

    final enteredFirstCall = Completer<void>();
    final releaseFirstCall = Completer<void>();
    final requests = <CharacterSyncRequest>[];

    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        if (requests.length == 1) {
          enteredFirstCall.complete();
          await releaseFirstCall.future;
        }
        final operations =
            request.operations ?? const <CharacterSyncOperationData>[];
        final serverCharacter = operations.isEmpty
            ? null
            : CharacterData(id: 42, name: 'Queued', version: 2);
        return CharacterSyncResponse(
          acknowledgedChangeIds: [
            for (final operation in operations) operation.id,
          ],
          rejectedChanges: const [],
          characters: serverCharacter == null ? const [] : [serverCharacter],
          changedCharacters: serverCharacter == null
              ? const {}
              : {operations.single.id: serverCharacter},
          serverTime: DateTime.utc(2026, 4, 24, 4, requests.length),
          pullCursor: requests.length,
          deletedCharacterIds: const [],
        );
      },
    );
    addTearDown(coordinator.dispose);

    final firstSync = coordinator.syncNow();
    await enteredFirstCall.future;
    await coordinator.syncNow();
    releaseFirstCall.complete();
    await firstSync;

    expect(requests, hasLength(2));
    expect(requests.first.operations, isNotEmpty);
    expect(requests.last.operations, isEmpty);
    expect(await cache.getSyncEventCursor(7), 2);
  });

  test('retries pending changes after a transient sync failure', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Queued'));

    var callCount = 0;
    final retryFinished = Completer<void>();
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      retryDelays: const [Duration.zero],
      syncCharacters: (request) async {
        callCount += 1;
        if (callCount == 1) {
          throw Exception('Server restarting');
        }

        final operation = request.operations!.single;
        final serverCharacter = CharacterData(
          id: 42,
          name: 'Queued',
          version: 2,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          rejectedChanges: const [],
          characters: [serverCharacter],
          changedCharacters: {operation.id: serverCharacter},
          serverTime: DateTime.utc(2026, 4, 24, 5),
          pullCursor: 2,
          deletedCharacterIds: const [],
        );
      },
    );
    addTearDown(coordinator.dispose);
    coordinator.addListener(() {
      if (callCount == 2 && !retryFinished.isCompleted) {
        retryFinished.complete();
      }
    });

    await coordinator.syncNow();
    await retryFinished.future.timeout(const Duration(seconds: 1));

    expect(callCount, 2);
    expect(await cache.getPendingChanges(7), isEmpty);
    final record = await cache.getCharacter(7, 42);
    expect(record?.status, OfflineCharacterSyncStatus.clean);
    expect(record?.lastSyncError, isNull);
  });

  test('retries validation failure caused by an untouched legacy field',
      () async {
    final legacyName = 'x' * 491;
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: legacyName, currentHp: 5, version: 1),
    );
    await cache.saveLocal(
      7,
      CharacterData(id: 42, name: legacyName, currentHp: 4, version: 1),
    );

    var callCount = 0;
    final retryFinished = Completer<void>();
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      retryDelays: const [Duration.zero],
      syncCharacters: (request) async {
        callCount += 1;
        final operation = request.operations!.single;
        if (callCount == 1) {
          return CharacterSyncResponse(
            acknowledgedChangeIds: const [],
            rejectedChanges: [
              CharacterRejectedChangeData(
                changeId: operation.id,
                reason: 'invalid_operation',
                message: 'Validation failed for characterName: '
                    'shortText length 491 exceeds 120.',
              ),
            ],
            characters: const [],
            changedCharacters: const {},
            serverTime: DateTime.utc(2026, 4, 24, 5),
            pullCursor: 2,
            deletedCharacterIds: const [],
          );
        }

        final serverCharacter = CharacterData(
          id: 42,
          name: legacyName,
          currentHp: 4,
          version: 2,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          rejectedChanges: const [],
          characters: [serverCharacter],
          changedCharacters: {operation.id: serverCharacter},
          serverTime: DateTime.utc(2026, 4, 24, 6),
          pullCursor: 3,
          deletedCharacterIds: const [],
        );
      },
    );
    addTearDown(coordinator.dispose);
    coordinator.addListener(() {
      if (callCount == 2 && !retryFinished.isCompleted) {
        retryFinished.complete();
      }
    });

    await coordinator.syncNow();
    await retryFinished.future.timeout(const Duration(seconds: 1));

    expect(callCount, 2);
    expect(await cache.getPendingChanges(7), isEmpty);
    final record = await cache.getCharacter(7, 42);
    expect(record?.status, OfflineCharacterSyncStatus.clean);
    expect(record?.character.currentHp, 4);
    expect(record?.lastSyncError, isNull);
  });

  test('does not retry validation failure for the changed field', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 1),
    );
    await cache.saveLocal(
      7,
      CharacterData(id: 42, name: 'x' * 491, version: 1),
    );

    var callCount = 0;
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      retryDelays: const [Duration.zero],
      syncCharacters: (request) async {
        callCount += 1;
        return CharacterSyncResponse(
          acknowledgedChangeIds: const [],
          rejectedChanges: [
            CharacterRejectedChangeData(
              changeId: request.operations!.single.id,
              reason: 'invalid_operation',
              message: 'Validation failed for characterName: '
                  'shortText length 491 exceeds 120.',
            ),
          ],
          characters: const [],
          changedCharacters: const {},
          serverTime: DateTime.utc(2026, 4, 24, 7),
          pullCursor: 4,
          deletedCharacterIds: const [],
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(callCount, 1);
    expect(await cache.getPendingChanges(7), isEmpty);
    final record = await cache.getCharacter(7, 42);
    expect(record?.status, OfflineCharacterSyncStatus.dirty);
    expect(record?.lastSyncError, contains('characterName'));
  });

  test('refreshes a watched offline record after sync completes', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Queued'));

    final repository = _CacheCharacterRepository(cache, 7);
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        final operation = request.operations!.single;
        final serverCharacter = CharacterData(
          id: 42,
          name: 'Queued',
          version: 2,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          rejectedChanges: const [],
          characters: [serverCharacter],
          changedCharacters: {operation.id: serverCharacter},
          serverTime: DateTime.utc(2026, 4, 24, 6),
          pullCursor: 3,
          deletedCharacterIds: const [],
        );
      },
    );
    addTearDown(coordinator.dispose);

    final previousCoordinator = offlineSyncCoordinator;
    offlineSyncCoordinator = coordinator;
    addTearDown(() => offlineSyncCoordinator = previousCoordinator);

    final container = ProviderContainer(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      offlineCharacterRecordProvider(42),
      (_, __) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);

    final pending =
        await container.read(offlineCharacterRecordProvider(42).future);
    expect(pending?.status, OfflineCharacterSyncStatus.dirty);

    await coordinator.syncNow();

    final synced =
        await container.read(offlineCharacterRecordProvider(42).future);
    expect(synced?.status, OfflineCharacterSyncStatus.clean);
    expect(repository.getOfflineRecordCallCount, 2);
  });
}

class _CacheCharacterRepository extends CharacterRepository {
  _CacheCharacterRepository(this.cache, this.userId);

  final OfflineCacheDatabase cache;
  final int userId;
  int getOfflineRecordCallCount = 0;

  @override
  Future<OfflineCharacterRecord?> getOfflineRecord(int id) {
    getOfflineRecordCallCount += 1;
    return cache.getCharacter(userId, id);
  }
}
