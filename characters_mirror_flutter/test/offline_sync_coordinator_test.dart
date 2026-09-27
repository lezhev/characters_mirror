import 'dart:async';
import 'dart:io';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/reference_character_repository.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_sheet_settings_page.dart';
import 'package:flutter/material.dart';
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

  test('rerun after an authentication change uses the current user', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Seven', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Seven queued'));
    await cache.upsertCleanFromServer(
      8,
      CharacterData(id: 84, name: 'Eight', version: 1),
    );
    await cache.saveLocal(8, CharacterData(id: 84, name: 'Eight queued'));
    var currentUserId = 7;
    final firstRequestStarted = Completer<void>();
    final releaseFirstRequest = Completer<void>();
    final requestedCharacterIds = <int?>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => currentUserId,
      syncCharacters: (request) async {
        final operation = request.operations!.single;
        requestedCharacterIds.add(operation.characterId);
        if (requestedCharacterIds.length == 1) {
          firstRequestStarted.complete();
          await releaseFirstRequest.future;
        }
        final character = CharacterData(
          id: operation.characterId,
          name: operation.characterId == 42 ? 'Seven queued' : 'Eight queued',
          version: 2,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: character},
          characters: [character],
          pullCursor: 1,
        );
      },
    );
    addTearDown(coordinator.dispose);

    final firstSync = coordinator.syncNow();
    await firstRequestStarted.future;
    currentUserId = 8;
    await coordinator.syncNow();
    releaseFirstRequest.complete();
    await firstSync;

    expect(requestedCharacterIds, [42, 84]);
    expect((await cache.getCharacter(8, 84))?.status,
        OfflineCharacterSyncStatus.clean);
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

  testWidgets(
      'transport failure stays pending and successful reconnect becomes clean',
      (tester) async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 1),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Offline edit'));

    var transportAvailable = false;
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      retryDelays: const [],
      syncCharacters: (request) async {
        if (!transportAvailable) {
          throw Exception('No connection');
        }
        final operation = request.operations!.single;
        final canonical = CharacterData(
          id: 42,
          name: 'Offline edit',
          version: 2,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: canonical},
          characters: [canonical],
          pullCursor: 2,
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    final pendingRecord = await cache.getCharacter(7, 42);
    expect(pendingRecord?.status, OfflineCharacterSyncStatus.dirty);
    expect(pendingRecord?.lastSyncError, isNull);
    expect(await cache.getPendingChanges(7), hasLength(1));

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: darkTheme,
          home: Scaffold(
            body: CharacterSheetSettingsSection(
              characterId: 42,
              offlineRecord: AsyncValue.data(pendingRecord),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Ожидает синхронизации'), findsOneWidget);

    transportAvailable = true;
    await coordinator.syncNow();

    final cleanRecord = await cache.getCharacter(7, 42);
    expect(cleanRecord?.status, OfflineCharacterSyncStatus.clean);
    expect(cleanRecord?.lastSyncError, isNull);
    expect(cleanRecord?.conflictCharacter, isNull);
    expect(await cache.getPendingChanges(7), isEmpty);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: darkTheme,
          home: Scaffold(
            body: CharacterSheetSettingsSection(
              characterId: 42,
              offlineRecord: AsyncValue.data(cleanRecord),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Синхронизировано'), findsOneWidget);
    expect(find.text('Серверная версия новее'), findsNothing);
  });

  test('simple remote delete removes the local character on reconnect',
      () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Remote', version: 1),
    );
    var callCount = 0;
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        callCount += 1;
        if (callCount == 1) {
          return CharacterSyncResponse(
            characters: [CharacterData(id: 42, name: 'Remote', version: 1)],
            pullCursor: 1,
            capabilities: const ['authoritative_full_resync'],
          );
        }
        return CharacterSyncResponse(
          characters: const [],
          pullCursor: 2,
          deletedCharacterIds: const [42],
          capabilities: const ['authoritative_full_resync'],
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();
    await coordinator.syncNow();

    expect(callCount, 2);
    expect(await cache.getCharacter(7, 42), isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
  });

  test('not_found rejection removes stale local edit without a tombstone',
      () async {
    final base = CharacterData(id: 42, name: 'Remote', version: 1);
    await cache.upsertCleanFromServer(7, base);
    var callCount = 0;
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        callCount += 1;
        if (callCount == 1) {
          return CharacterSyncResponse(
            characters: [base],
            pullCursor: 2,
            capabilities: const ['authoritative_full_resync'],
          );
        }
        final operation = request.operations!.single;
        return CharacterSyncResponse(
          rejectedChanges: [
            CharacterRejectedChangeData(
              changeId: operation.id,
              reason: 'not_found',
            ),
          ],
          characters: const [],
          pullCursor: 2,
          deletedCharacterIds: const [],
          capabilities: const ['authoritative_full_resync'],
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();
    await cache.saveLocal(7, base.copyWith(name: 'Stale local edit'));
    await coordinator.syncNow();

    expect(callCount, 2);
    expect(await cache.getCharacter(7, 42), isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
  });

  test('restart recovery cannot promote an unverified ghost to clean',
      () async {
    final directory = await Directory.systemTemp.createTemp('sync-ghost-');
    addTearDown(() => directory.delete(recursive: true));
    final path = '${directory.path}/cache.sqlite';
    final persistent = await OfflineCacheDatabase.openAt(path);
    final base = CharacterData(id: 42, name: 'Remote', version: 1);
    await persistent.upsertCleanFromServer(7, base);
    await persistent.saveLocal(7, base.copyWith(name: 'Stale local edit'));
    final queued = await persistent.getPendingChanges(7);
    await persistent.removeChanges(7, queued.map((change) => change.id));
    await persistent.setSyncEventCursor(7, 9);
    persistent.close();

    final reopened = await OfflineCacheDatabase.openAt(path);
    addTearDown(reopened.close);
    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: reopened,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        expect(
          (await reopened.getCharacter(7, 42))?.status,
          OfflineCharacterSyncStatus.dirty,
        );
        return CharacterSyncResponse(
          characters: const [],
          pullCursor: 9,
          capabilities: const ['authoritative_full_resync'],
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    expect(requests, hasLength(1));
    expect(requests.single.fullResync, isTrue);
    expect(await reopened.getCharacter(7, 42), isNull);
    expect(await reopened.getPendingChanges(7), isEmpty);
  });

  test('first sync validates a clean persisted cache authoritatively',
      () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Clean ghost', version: 1),
    );
    await cache.setSyncEventCursor(7, 12);
    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        return CharacterSyncResponse(
          characters: const [],
          pullCursor: 12,
          capabilities: const ['authoritative_full_resync'],
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    expect(requests.single.fullResync, isTrue);
    expect(await cache.getCharacter(7, 42), isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
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

  test('terminal semantic rejection restores canonical server state', () async {
    final canonical = CharacterData(
      id: 42,
      currentHp: 10,
      version: 1,
      syncTargetRevisions: const {'field:currentHp': 1},
    );
    await cache.upsertCleanFromServer(7, canonical);
    final operation = createCharacterSemanticOperation(
      character: canonical,
      localId: 42,
      serverId: 42,
      type: CharacterSyncOperationType.applyDamage,
      action: CharacterSemanticActionData(amount: 5),
      changeId: 'damage-rejected',
      createdAt: DateTime.utc(2026, 9, 14),
    );
    await cache.saveSemanticLocal(
      7,
      canonical.copyWith(currentHp: 5),
      operation,
    );

    var callCount = 0;
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        callCount += 1;
        if (request.operations?.isEmpty ?? true) {
          return CharacterSyncResponse(
            characters: [canonical],
            syncProtocolVersion: characterSemanticSyncProtocolVersion,
          );
        }
        return CharacterSyncResponse(
          rejectedChanges: [
            CharacterRejectedChangeData(
              changeId: operation.id,
              reason: 'insufficient_resource',
              character: canonical,
            ),
          ],
          characters: [canonical],
          syncProtocolVersion: characterSemanticSyncProtocolVersion,
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    expect(callCount, 2);
    expect(await cache.getPendingChanges(7), isEmpty);
    final record = await cache.getCharacter(7, 42);
    expect(record?.status, OfflineCharacterSyncStatus.clean);
    expect(record?.character.currentHp, 10);
    expect(record?.lastSyncError, isNull);
    expect(record?.conflictCharacter, isNull);
  });

  test('does not send semantic operations to a protocol v3 server', () async {
    final canonical = CharacterData(id: 42, currentHp: 10, version: 1);
    await cache.upsertCleanFromServer(7, canonical);
    final operation = createCharacterSemanticOperation(
      character: canonical,
      localId: 42,
      serverId: 42,
      type: CharacterSyncOperationType.applyDamage,
      action: CharacterSemanticActionData(amount: 5),
      changeId: 'unsupported-damage',
      createdAt: DateTime.utc(2026, 9, 14),
    );
    await cache.saveSemanticLocal(
      7,
      canonical.copyWith(currentHp: 5),
      operation,
    );

    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        return CharacterSyncResponse(
          characters: [canonical],
          syncProtocolVersion: 3,
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    expect(requests, hasLength(1));
    expect(requests.single.operations, isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
    expect((await cache.getCharacter(7, 42))?.character.currentHp, 10);
  });

  test('rebases a newer local edit made while the previous edit is in flight',
      () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', currentHp: 10, version: 1),
    );
    await cache.saveLocal(
      7,
      CharacterData(id: 42, name: 'A', currentHp: 10, version: 1),
    );

    final firstRequestStarted = Completer<void>();
    final releaseFirstRequest = Completer<void>();
    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        if (requests.length == 1) {
          firstRequestStarted.complete();
          await releaseFirstRequest.future;
          final operation = request.operations!.single;
          final canonical = CharacterData(
            id: 42,
            name: 'A',
            currentHp: 10,
            version: 2,
          );
          return CharacterSyncResponse(
            acknowledgedChangeIds: [operation.id],
            changedCharacters: {operation.id: canonical},
            characters: [canonical],
            pullCursor: 2,
          );
        }
        final operation = request.operations!.single;
        final canonical = CharacterData(
          id: 42,
          name: 'A',
          currentHp: 8,
          version: 3,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: canonical},
          characters: [canonical],
          pullCursor: 3,
        );
      },
    );
    addTearDown(coordinator.dispose);

    final firstSync = coordinator.syncNow();
    await firstRequestStarted.future;
    final visible = (await cache.getCharacter(7, 42))!.character;
    await cache.saveLocal(7, visible.copyWith(currentHp: 8));
    await coordinator.syncNow();
    releaseFirstRequest.complete();
    await firstSync;

    expect(requests, hasLength(2));
    expect(requests.first.operations!.single.fieldPath, 'name');
    expect(requests.last.operations!.single.fieldPath, 'currentHp');
    final record = await cache.getCharacter(7, 42);
    expect(record?.character.name, 'A');
    expect(record?.character.currentHp, 8);
    expect(record?.character.version, 3);
    expect(record?.status, OfflineCharacterSyncStatus.clean);
  });

  test('edit during an in-flight create keeps its local identity', () async {
    final local = await cache.saveLocal(7, CharacterData(name: 'A'));
    final firstRequestStarted = Completer<void>();
    final releaseFirstRequest = Completer<void>();
    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        final operation = request.operations!.single;
        if (requests.length == 1) {
          firstRequestStarted.complete();
          await releaseFirstRequest.future;
          final created = CharacterData(id: 123, name: 'A', version: 1);
          return CharacterSyncResponse(
            acknowledgedChangeIds: [operation.id],
            changedCharacters: {operation.id: created},
            characters: [created],
            pullCursor: 1,
          );
        }
        final updated = CharacterData(
          id: 123,
          name: requests.length == 2 ? 'B' : 'C',
          version: requests.length,
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: updated},
          characters: [updated],
          pullCursor: 2,
        );
      },
    );
    addTearDown(coordinator.dispose);

    final firstSync = coordinator.syncNow();
    await firstRequestStarted.future;
    await cache.saveLocal(7, local.character.copyWith(name: 'B'));
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 123, name: 'A', version: 1),
    );
    await coordinator.syncNow();
    releaseFirstRequest.complete();
    await firstSync;

    expect(requests, hasLength(2));
    expect(
      requests.first.operations!.single.type,
      CharacterSyncOperationType.createCharacter,
    );
    expect(
      requests.last.operations!.single.type,
      CharacterSyncOperationType.setField,
    );
    expect(requests.last.operations!.single.characterId, 123);
    final byLocalId = await cache.getCharacter(7, local.localId);
    expect(byLocalId?.localId, local.localId);
    expect(byLocalId?.serverId, 123);
    final record = await cache.getCharacter(7, 123);
    expect(record?.localId, local.localId);
    expect(record?.character.name, 'B');
    expect(record?.status, OfflineCharacterSyncStatus.clean);

    await cache.saveLocal(7, local.character.copyWith(name: 'C'));
    final afterEdit = await cache.getCharacter(7, local.localId);
    expect(afterEdit?.localId, local.localId);
    expect(afterEdit?.serverId, 123);
    expect(afterEdit?.character.name, 'C');
    expect(await cache.getCharacters(7), hasLength(1));
    final edit = (await cache.getPendingChanges(7)).single.operationData!;
    expect(edit.type, CharacterSyncOperationType.setField);
    expect(edit.characterId, 123);

    await coordinator.syncNow();
    expect(requests, hasLength(3));
    expect(
      requests.last.operations!.single.type,
      CharacterSyncOperationType.setField,
    );
    expect(requests.last.operations!.single.characterId, 123);
    expect(await cache.getCharacters(7), hasLength(1));
    expect(
      (await cache.getCharacter(7, local.localId))?.character.name,
      'C',
    );
  });

  test('keeps the highest version when ack and pull overlap', () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(id: 42, name: 'Base', version: 100),
    );
    await cache.saveLocal(7, CharacterData(id: 42, name: 'Local'));
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        final operation = request.operations!.single;
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {
            operation.id: CharacterData(id: 42, name: 'Ack', version: 101),
          },
          characters: [CharacterData(id: 42, name: 'Pull', version: 102)],
          pullCursor: 5,
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    final record = await cache.getCharacter(7, 42);
    expect(record?.character.name, 'Pull');
    expect(record?.character.version, 102);
    expect(await cache.getSyncEventCursor(7), 5);
  });

  test('terminal rejection preserves a newer independent pending operation',
      () async {
    await cache.upsertCleanFromServer(
      7,
      CharacterData(
        id: 42,
        name: 'Base',
        currentHp: 10,
        version: 1,
        syncTargetRevisions: const {
          'field:name': 1,
          'field:currentHp': 1,
        },
      ),
    );
    await cache.saveLocal(
      7,
      CharacterData(id: 42, name: 'Local', currentHp: 10, version: 1),
    );
    final firstRequestStarted = Completer<void>();
    final releaseFirstRequest = Completer<void>();
    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        final operation = request.operations!.single;
        if (requests.length == 1) {
          firstRequestStarted.complete();
          await releaseFirstRequest.future;
          final canonical = CharacterData(
            id: 42,
            name: 'Remote',
            currentHp: 10,
            version: 2,
            syncTargetRevisions: const {
              'field:name': 2,
              'field:currentHp': 1,
            },
          );
          return CharacterSyncResponse(
            rejectedChanges: [
              CharacterRejectedChangeData(
                changeId: operation.id,
                reason: 'target_conflict',
                character: canonical,
              ),
            ],
            characters: [canonical],
            pullCursor: 2,
          );
        }
        final canonical = CharacterData(
          id: 42,
          name: 'Remote',
          currentHp: 8,
          version: 3,
          syncTargetRevisions: const {
            'field:name': 2,
            'field:currentHp': 3,
          },
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: canonical},
          characters: [canonical],
          pullCursor: 3,
        );
      },
    );
    addTearDown(coordinator.dispose);

    final firstSync = coordinator.syncNow();
    await firstRequestStarted.future;
    final visible = (await cache.getCharacter(7, 42))!.character;
    await cache.saveLocal(7, visible.copyWith(currentHp: 8));
    await coordinator.syncNow();
    releaseFirstRequest.complete();
    await firstSync;

    expect(requests, hasLength(2));
    expect(requests.last.operations!.single.fieldPath, 'currentHp');
    final record = await cache.getCharacter(7, 42);
    expect(record?.character.name, 'Remote');
    expect(record?.character.currentHp, 8);
    expect(record?.status, OfflineCharacterSyncStatus.clean);
  });

  test('note edit is durable, acknowledged, clean, and reloadable', () async {
    final base = CharacterData(
      id: 42,
      name: 'Hero',
      version: 1,
      notes: [CharacterNoteData(id: 'note-1', text: 'Old note')],
      syncTargetRevisions: const {'item:notes:note-1': 1},
    );
    await cache.upsertCleanFromServer(7, base);
    await cache.saveLocal(
      7,
      base.copyWith(
        notes: [CharacterNoteData(id: 'note-1', text: 'Edited note')],
      ),
    );

    final queued = await cache.getPendingChanges(7);
    expect(queued, hasLength(1));
    expect(queued.single.operationData?.targetId, 'note-1');
    expect(
      queued.single.operationData?.itemPayload?.noteValue?.text,
      'Edited note',
    );
    final dirty = await cache.getCharacter(7, 42);
    expect(dirty?.status, OfflineCharacterSyncStatus.dirty);
    expect(dirty?.character.notes?.single.text, 'Edited note');
    expect(dirty?.baseCharacter?.notes?.single.text, 'Old note');

    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        final operation = request.operations!.single;
        final canonical = CharacterData(
          id: 42,
          name: 'Hero',
          version: 2,
          notes: [CharacterNoteData(id: 'note-1', text: 'Edited note')],
          syncTargetRevisions: const {'item:notes:note-1': 2},
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: canonical},
          characters: [canonical],
          pullCursor: 2,
        );
      },
    );
    addTearDown(coordinator.dispose);

    await coordinator.syncNow();

    final reloaded = await cache.getCharacter(7, 42);
    expect(reloaded?.status, OfflineCharacterSyncStatus.clean);
    expect(reloaded?.character.notes?.single.text, 'Edited note');
    expect(reloaded?.baseCharacter?.notes?.single.text, 'Edited note');
    expect(reloaded?.character.version, 2);
    expect(reloaded?.baseVersion, 2);
    expect(await cache.getPendingChanges(7), isEmpty);
  });

  test(
      'note edit made while pull reconciliation is in flight is not rolled back',
      () async {
    final base = CharacterData(
      id: 42,
      name: 'Hero',
      version: 1,
      notes: [CharacterNoteData(id: 'note-1', text: 'Old note')],
      syncTargetRevisions: const {'item:notes:note-1': 1},
    );
    await cache.upsertCleanFromServer(7, base);
    final firstRequestStarted = Completer<void>();
    final releaseFirstRequest = Completer<void>();
    final requests = <CharacterSyncRequest>[];
    final coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        requests.add(request);
        if (requests.length == 1) {
          firstRequestStarted.complete();
          await releaseFirstRequest.future;
          return CharacterSyncResponse(
            characters: [base],
            pullCursor: 1,
          );
        }
        final operation = request.operations!.single;
        final canonical = base.copyWith(
          version: 2,
          notes: [CharacterNoteData(id: 'note-1', text: 'Edited note')],
          syncTargetRevisions: const {'item:notes:note-1': 2},
        );
        return CharacterSyncResponse(
          acknowledgedChangeIds: [operation.id],
          changedCharacters: {operation.id: canonical},
          characters: [canonical],
          pullCursor: 2,
        );
      },
    );
    addTearDown(coordinator.dispose);

    final firstSync = coordinator.syncNow();
    await firstRequestStarted.future;
    await cache.saveLocal(
      7,
      base.copyWith(
        notes: [CharacterNoteData(id: 'note-1', text: 'Edited note')],
      ),
    );
    await coordinator.syncNow();
    releaseFirstRequest.complete();
    await firstSync;

    expect(requests, hasLength(2));
    expect(requests.last.operations?.single.targetId, 'note-1');
    final record = await cache.getCharacter(7, 42);
    expect(record?.status, OfflineCharacterSyncStatus.clean);
    expect(record?.character.notes?.single.text, 'Edited note');
    expect(record?.baseCharacter?.notes?.single.text, 'Edited note');
  });

  test('terminal note rejection reconciles controller before clean is visible',
      () async {
    final base = CharacterData(
      id: 42,
      name: 'Hero',
      version: 1,
      notes: [CharacterNoteData(id: 'note-1', text: 'Server note')],
      syncTargetRevisions: const {'item:notes:note-1': 1},
    );
    await cache.upsertCleanFromServer(7, base);
    late final OfflineSyncCoordinator coordinator;
    coordinator = OfflineSyncCoordinator(
      cache: cache,
      client: Client('http://localhost:8083/'),
      currentUserId: () => 7,
      syncCharacters: (request) async {
        final operation = request.operations!.single;
        final canonical = base.copyWith(
          version: 2,
          syncTargetRevisions: const {'item:notes:note-1': 2},
        );
        return CharacterSyncResponse(
          rejectedChanges: [
            CharacterRejectedChangeData(
              changeId: operation.id,
              reason: 'target_conflict',
              character: canonical,
            ),
          ],
          characters: [canonical],
          pullCursor: 2,
        );
      },
    );
    addTearDown(coordinator.dispose);
    final previousCoordinator = offlineSyncCoordinator;
    offlineSyncCoordinator = coordinator;
    addTearDown(() => offlineSyncCoordinator = previousCoordinator);
    final repository = _SyncingCacheCharacterRepository(
      cache,
      7,
      coordinator,
    );
    final container = ProviderContainer(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      characterSheetControllerProvider(42),
      (_, __) {},
      fireImmediately: true,
    );
    addTearDown(subscription.close);
    await container.read(characterSheetControllerProvider(42).future);
    final controller = container.read(
      characterSheetControllerProvider(42).notifier,
    );
    final prematureCleanValues = <String?>[];
    final pendingSubscription = container.listen(
      characterSheetLocalSavePendingProvider(42),
      (previous, next) {
        if (previous == true && !next) {
          final visibleNote = container
              .read(characterSheetControllerProvider(42))
              .valueOrNull
              ?.notes
              ?.single
              .text;
          if (visibleNote != 'Server note') {
            prematureCleanValues.add(visibleNote);
          }
        }
      },
    );
    addTearDown(pendingSubscription.close);

    final update = controller.updateNote('note-1', 'Rejected note');
    expect(
      container
          .read(characterSheetControllerProvider(42))
          .valueOrNull
          ?.notes
          ?.single
          .text,
      'Rejected note',
    );
    expect(container.read(characterSheetLocalSavePendingProvider(42)), isTrue);
    await controller.flushPendingSave();
    await update;
    for (var attempt = 0; attempt < 20; attempt++) {
      final visible = container
          .read(characterSheetControllerProvider(42))
          .valueOrNull
          ?.notes
          ?.single
          .text;
      if (visible == 'Server note') break;
      await Future<void>.delayed(Duration.zero);
    }

    final visible =
        container.read(characterSheetControllerProvider(42)).valueOrNull;
    final local = await cache.getCharacter(7, 42);
    expect(visible?.notes?.single.text, 'Server note');
    expect(container.read(characterSheetLocalSavePendingProvider(42)), isFalse);
    expect(local?.status, OfflineCharacterSyncStatus.clean);
    expect(local?.character.notes?.single.text, 'Server note');
    expect(local?.baseCharacter?.notes?.single.text, 'Server note');
    expect(local?.lastSyncError, isNull);
    expect(local?.conflictCharacter, isNull);
    expect(await cache.getPendingChanges(7), isEmpty);
    expect(prematureCleanValues, isEmpty);
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

class _SyncingCacheCharacterRepository extends CharacterRepository {
  _SyncingCacheCharacterRepository(
    this.cache,
    this.userId,
    this.coordinator,
  );

  final OfflineCacheDatabase cache;
  final int userId;
  final OfflineSyncCoordinator coordinator;

  @override
  Future<CharacterData> getCharacter(int characterId) async {
    return (await cache.getCharacter(userId, characterId))!.character;
  }

  @override
  Future<OfflineCharacterRecord?> getOfflineRecord(int id) {
    return cache.getCharacter(userId, id);
  }

  @override
  Future<CharacterData> saveCharacter(CharacterData character) async {
    final savedBeforeSync = await cache.saveLocal(userId, character);
    await coordinator.syncNow();
    return savedBeforeSync.character;
  }
}
