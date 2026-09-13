import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:characters_mirror_flutter/core/offline/offline_sync_rejection.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

OfflineCacheDatabase? offlineCacheDatabase;
OfflineSyncCoordinator? offlineSyncCoordinator;
OfflineSyncLifecycleObserver? _offlineSyncLifecycleObserver;

const _offlineSyncRetryDelays = [
  Duration(seconds: 2),
  Duration(seconds: 5),
  Duration(seconds: 10),
  Duration(seconds: 30),
  Duration(minutes: 1),
];

bool get isAndroidOfflineCacheEnabled =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

Future<void> initializeOfflineServices() async {
  if (!isAndroidOfflineCacheEnabled) {
    return;
  }
  _offlineSyncLifecycleObserver?.dispose();
  offlineSyncCoordinator?.dispose();
  offlineCacheDatabase = await OfflineCacheDatabase.openDefault();
  offlineSyncCoordinator = OfflineSyncCoordinator(
    cache: offlineCacheDatabase!,
    client: client,
    currentUserId: currentOfflineUserId,
  );
  _offlineSyncLifecycleObserver =
      OfflineSyncLifecycleObserver(offlineSyncCoordinator!);
}

int? currentOfflineUserId() {
  try {
    return sessionManager.signedInUser?.id;
  } catch (_) {
    return null;
  }
}

class OfflineSyncCoordinator extends ChangeNotifier {
  OfflineSyncCoordinator({
    required OfflineCacheDatabase cache,
    required Client client,
    required int? Function() currentUserId,
    Future<CharacterSyncResponse> Function(CharacterSyncRequest request)?
        syncCharacters,
    List<Duration> retryDelays = _offlineSyncRetryDelays,
  })  : _cache = cache,
        _currentUserId = currentUserId,
        _syncCharacters = syncCharacters ?? client.characterData.syncCharacters,
        _retryDelays = retryDelays;

  final OfflineCacheDatabase _cache;
  final int? Function() _currentUserId;
  final Future<CharacterSyncResponse> Function(CharacterSyncRequest request)
      _syncCharacters;
  final List<Duration> _retryDelays;
  bool _isRunning = false;
  bool _rerunRequested = false;
  bool _isDisposed = false;
  int _retryAttempt = 0;
  Timer? _retryTimer;

  Future<void> syncNow() async {
    _cancelScheduledRetry();
    if (_isRunning) {
      _rerunRequested = true;
      return;
    }
    final userId = _currentUserId();
    if (userId == null) return;

    _isRunning = true;
    var result = const _SyncPassResult.succeeded();
    try {
      do {
        _rerunRequested = false;
        result = await _runSyncPass(userId);
      } while (_rerunRequested);
    } finally {
      _isRunning = false;
      if (!_isDisposed) {
        notifyListeners();
      }
    }

    if (result.succeeded) {
      _retryAttempt = 0;
    } else if (result.shouldRetry) {
      _scheduleRetry();
    }
  }

  Future<_SyncPassResult> _runSyncPass(int userId) async {
    var hadPendingChanges = false;
    var shouldRetry = false;
    var pending = const <OfflineCharacterChange>[];
    try {
      await _cache.repairSyncQueue(userId);
      pending = await _cache.getPendingChanges(userId);
      final coalesced = await _coalescePendingChanges(userId, pending);
      hadPendingChanges = coalesced.isNotEmpty;
      final pullSince = await _cache.getLastPulledAt(userId);
      final pullAfterEventId = await _cache.getSyncEventCursor(userId);
      final legacyChanges = [
        for (final change in coalesced)
          if (change.operationData == null) change,
      ];
      final operationChanges = [
        for (final change in coalesced)
          if (change.operationData != null) change,
      ];

      CharacterSyncResponse? finalResponse;
      if (legacyChanges.isNotEmpty) {
        final response = await _sendLegacyChanges(
          legacyChanges,
          pullSince: operationChanges.isEmpty ? pullSince : null,
          pullAfterEventId: operationChanges.isEmpty ? pullAfterEventId : null,
        );
        await _applyAcknowledgements(userId, legacyChanges, response);
        shouldRetry |= await _applyRejections(
          userId,
          legacyChanges,
          response.rejectedChanges,
        );
        await _applyRemoteChanges(userId, response);
        finalResponse = response;
      }
      if (operationChanges.isNotEmpty || legacyChanges.isEmpty) {
        final response = await _sendOperationChanges(
          operationChanges,
          pullSince: pullSince,
          pullAfterEventId: pullAfterEventId,
        );
        await _applyAcknowledgements(userId, operationChanges, response);
        shouldRetry |= await _applyRejections(
          userId,
          operationChanges,
          response.rejectedChanges,
        );
        await _applyRemoteChanges(userId, response);
        finalResponse = response;
      }
      if (finalResponse?.serverTime != null) {
        await _cache.setLastPulledAt(userId, finalResponse!.serverTime!);
      }
      if (finalResponse?.pullCursor != null) {
        await _cache.setSyncEventCursor(userId, finalResponse!.pullCursor!);
      }
      return shouldRetry
          ? const _SyncPassResult.failed(shouldRetry: true)
          : const _SyncPassResult.succeeded();
    } catch (_) {
      for (final change in pending) {
        await _cache.markChangeFailed(userId, change.id, 'Sync request failed');
        final localId = int.tryParse(change.entityId);
        if (localId != null) {
          await _cache.markSyncError(userId, localId, 'Sync request failed');
        }
      }
      return _SyncPassResult.failed(shouldRetry: hadPendingChanges);
    }
  }

  void _scheduleRetry() {
    if (_retryDelays.isEmpty || _isDisposed || _retryTimer != null) {
      return;
    }
    final retryIndex = _retryAttempt < _retryDelays.length
        ? _retryAttempt
        : _retryDelays.length - 1;
    _retryAttempt += 1;
    _retryTimer = Timer(_retryDelays[retryIndex], () {
      _retryTimer = null;
      unawaited(syncNow());
    });
  }

  void _cancelScheduledRetry() {
    _retryTimer?.cancel();
    _retryTimer = null;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _cancelScheduledRetry();
    super.dispose();
  }

  Future<CharacterSyncResponse> _sendLegacyChanges(
    List<OfflineCharacterChange> changes, {
    required DateTime? pullSince,
    required int? pullAfterEventId,
  }) {
    return _syncCharacters(
      CharacterSyncRequest(
        changes: [
          for (final change in changes)
            CharacterChangeData(
              id: change.id,
              changeType: change.changeType,
              entityType: change.entityType,
              entityId: change.entityId,
              payload: _serverPayloadForChange(change),
              createdAt: change.createdAt,
              baseUpdatedAt: change.baseUpdatedAt,
            ),
        ],
        pullSince: pullSince,
        pullAfterEventId: pullAfterEventId,
      ),
    );
  }

  Future<CharacterSyncResponse> _sendOperationChanges(
    List<OfflineCharacterChange> changes, {
    required DateTime? pullSince,
    required int? pullAfterEventId,
  }) {
    return _syncCharacters(
      CharacterSyncRequest(
        operations: [
          for (final change in changes)
            if (change.operationData != null) change.operationData!,
        ],
        pullSince: pullSince,
        pullAfterEventId: pullAfterEventId,
      ),
    );
  }

  Future<List<OfflineCharacterChange>> _coalescePendingChanges(
    int userId,
    List<OfflineCharacterChange> pending,
  ) async {
    final effectiveLegacy = <OfflineCharacterChange>[];
    final operationChanges = <OfflineCharacterChange>[];
    for (final change in pending) {
      final localId = int.tryParse(change.entityId);
      if (change.changeType == CharacterChangeType.delete && localId != null) {
        final record = await _cache.getCharacter(userId, localId);
        if (record?.serverId == null) {
          await _cache.markDeleteSynced(userId, localId);
          await _cache.deleteQueuedChangesForEntity(userId, change.entityId);
          continue;
        }
      }

      if (change.operationData != null) {
        operationChanges.add(change);
        continue;
      }

      if (effectiveLegacy.isNotEmpty) {
        final last = effectiveLegacy.last;
        if (last.entityId == change.entityId &&
            last.entityType == change.entityType) {
          if (last.changeType == CharacterChangeType.upsert &&
              change.changeType == CharacterChangeType.upsert) {
            effectiveLegacy[effectiveLegacy.length - 1] = change;
            continue;
          }
          if (change.changeType == CharacterChangeType.delete) {
            effectiveLegacy[effectiveLegacy.length - 1] = change;
            continue;
          }
        }
      }
      effectiveLegacy.add(change);
    }
    final changesById = {
      for (final change in operationChanges) change.id: change
    };
    final coalescedOperations = coalesceCharacterSyncOperations(
      operationChanges.map((change) => change.operationData!),
    );
    final retainedIds = {
      for (final operation in coalescedOperations) operation.id,
    };
    final supersededIds = [
      for (final change in operationChanges)
        if (!retainedIds.contains(change.id)) change.id,
    ];
    await _cache.removeChanges(userId, supersededIds);
    return [
      ...effectiveLegacy,
      for (final operation in coalescedOperations) changesById[operation.id]!,
    ];
  }

  CharacterData? _serverPayloadForChange(OfflineCharacterChange change) {
    final payload = change.payload;
    if (payload == null) return null;
    final parsedId = int.tryParse(change.entityId);
    if (parsedId == null || parsedId < 0) {
      return payload.copyWith(id: null);
    }
    return payload.copyWith(id: parsedId);
  }

  Future<void> _applyAcknowledgements(
    int userId,
    List<OfflineCharacterChange> sentChanges,
    CharacterSyncResponse response,
  ) async {
    final acknowledged =
        (response.acknowledgedChangeIds ?? const <String>[]).toSet();
    if (acknowledged.isEmpty) {
      return;
    }

    final characterById = {
      for (final character in response.characters ?? const <CharacterData>[])
        if (character.id != null) character.id!.toString(): character,
    };
    final changedByChangeId = response.changedCharacters ?? const {};
    final syncedUpdates =
        <({int localId, String entityId, CharacterData character})>[];

    for (final change in sentChanges) {
      if (!acknowledged.contains(change.id)) {
        continue;
      }
      final operation = change.operationData;
      if (operation != null) {
        switch (operation.type) {
          case CharacterSyncOperationType.createCharacter:
          case CharacterSyncOperationType.setField:
          case CharacterSyncOperationType.setMapEntry:
          case CharacterSyncOperationType.removeMapEntry:
          case CharacterSyncOperationType.upsertListItem:
          case CharacterSyncOperationType.removeListItem:
            final serverCharacter = changedByChangeId[change.id] ??
                (operation.characterId == null
                    ? null
                    : characterById[operation.characterId.toString()]);
            final localId = operation.localCharacterId ??
                operation.characterId ??
                int.tryParse(change.entityId);
            if (localId != null && serverCharacter != null) {
              syncedUpdates.add((
                localId: localId,
                entityId: change.entityId,
                character: serverCharacter,
              ));
            }
            break;
          case CharacterSyncOperationType.deleteCharacter:
            final localId = operation.localCharacterId ??
                operation.characterId ??
                int.tryParse(change.entityId);
            if (localId != null) {
              await _cache.markDeleteSynced(userId, localId);
            }
            break;
        }
        continue;
      }

      switch (change.changeType) {
        case CharacterChangeType.upsert:
          final localId = change.payload?.id;
          final serverCharacter = characterById[change.entityId];
          if (localId != null && serverCharacter != null) {
            syncedUpdates.add((
              localId: localId,
              entityId: change.entityId,
              character: serverCharacter,
            ));
          }
          break;
        case CharacterChangeType.delete:
          final localId = int.tryParse(change.entityId);
          if (localId != null) {
            await _cache.markDeleteSynced(userId, localId);
          }
          break;
      }
    }

    await _cache.removeChanges(userId, acknowledged);
    for (final update in syncedUpdates) {
      final serverId = update.character.id;
      final hasMoreChanges = await _cache.hasQueuedChangesForEntity(
        userId,
        serverId?.toString() ?? update.entityId,
      );
      if (!hasMoreChanges) {
        await _cache.markSynced(userId, update.localId, update.character);
        if (serverId != null) {
          await _cache.clearSyncError(userId, serverId);
        }
      }
    }
  }

  Future<bool> _applyRejections(
    int userId,
    List<OfflineCharacterChange> sentChanges,
    List<CharacterRejectedChangeData>? rejectedChanges,
  ) async {
    var shouldRetry = false;
    final sentById = {for (final change in sentChanges) change.id: change};
    for (final rejection
        in rejectedChanges ?? const <CharacterRejectedChangeData>[]) {
      final change = sentById[rejection.changeId];
      final message =
          rejection.message ?? rejection.reason ?? 'Rejected by server';
      final serverCharacter = rejection.character;
      if (serverCharacter != null && serverCharacter.id != null) {
        final localId = change?.operationData?.localCharacterId ??
            int.tryParse(change?.entityId ?? '') ??
            serverCharacter.id!;
        await _cache.markConflict(
          userId,
          localId,
          serverCharacter,
          message,
        );
        await _cache.markChangeConflict(
          userId,
          rejection.changeId,
          serverCharacter,
          message,
        );
      } else if (change != null &&
          isRetryableUntouchedFieldValidationRejection(
            reason: rejection.reason,
            message: rejection.message,
            operationType: change.operationData?.type,
            fieldPath: change.operationData?.fieldPath,
          )) {
        await _cache.markChangeFailed(userId, rejection.changeId, message);
        await _markChangeSyncError(userId, change, message);
        shouldRetry = true;
      } else {
        await _cache.markChangeRejected(
          userId,
          rejection.changeId,
          message,
        );
        if (change != null) {
          await _markChangeSyncError(userId, change, message);
        }
      }
    }
    return shouldRetry;
  }

  Future<void> _markChangeSyncError(
    int userId,
    OfflineCharacterChange change,
    String message,
  ) async {
    final operation = change.operationData;
    final localId = operation?.localCharacterId ??
        operation?.characterId ??
        int.tryParse(change.entityId);
    if (localId != null) {
      await _cache.markSyncError(userId, localId, message);
    }
  }

  Future<void> _applyRemoteChanges(
    int userId,
    CharacterSyncResponse response,
  ) async {
    await _applyRemoteDeletes(userId, response.deletedCharacterIds);
    await _applyPulledCharacters(userId, response.characters);
  }

  Future<void> _applyRemoteDeletes(
    int userId,
    List<int>? deletedCharacterIds,
  ) async {
    for (final id in deletedCharacterIds ?? const <int>[]) {
      await _cache.applyRemoteDelete(userId, id);
    }
  }

  Future<void> _applyPulledCharacters(
    int userId,
    List<CharacterData>? characters,
  ) async {
    for (final character in characters ?? const <CharacterData>[]) {
      await _cache.upsertCleanFromServer(userId, character);
    }
  }
}

class _SyncPassResult {
  const _SyncPassResult.succeeded()
      : succeeded = true,
        shouldRetry = false;

  const _SyncPassResult.failed({required this.shouldRetry}) : succeeded = false;

  final bool succeeded;
  final bool shouldRetry;
}

class OfflineSyncLifecycleObserver with WidgetsBindingObserver {
  OfflineSyncLifecycleObserver(this._coordinator) {
    WidgetsBinding.instance.addObserver(this);
  }

  final OfflineSyncCoordinator _coordinator;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _coordinator.syncNow();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
