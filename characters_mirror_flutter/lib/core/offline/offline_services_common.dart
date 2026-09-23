import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_dev_log.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_store.dart';
import 'package:characters_mirror_flutter/core/offline/memory_character_sync_store.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:characters_mirror_flutter/core/offline/offline_sync_rejection.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

OfflineCacheDatabase? offlineCacheDatabase;
CharacterSyncStore? characterSyncStore;
OfflineSyncCoordinator? offlineSyncCoordinator;
OfflineSyncLifecycleObserver? _offlineSyncLifecycleObserver;
VoidCallback? _sessionListener;

const _offlineSyncRetryDelays = [
  Duration(seconds: 2),
  Duration(seconds: 5),
  Duration(seconds: 10),
  Duration(seconds: 30),
  Duration(minutes: 1),
];
const _characterSyncProtocolVersion = characterSemanticSyncProtocolVersion;
const _foregroundPollInterval = Duration(seconds: 12);

bool get isAndroidOfflineCacheEnabled =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

Future<void> initializeOfflineServices() async {
  _offlineSyncLifecycleObserver?.dispose();
  offlineSyncCoordinator?.dispose();
  if (_sessionListener != null) {
    sessionManager.removeListener(_sessionListener!);
  }
  if (isAndroidOfflineCacheEnabled) {
    offlineCacheDatabase = await OfflineCacheDatabase.openDefault();
    characterSyncStore = SqliteCharacterSyncStore(offlineCacheDatabase!);
  } else {
    offlineCacheDatabase = null;
    characterSyncStore = MemoryCharacterSyncStore();
  }
  offlineSyncCoordinator = OfflineSyncCoordinator(
    store: characterSyncStore!,
    client: client,
    currentUserId: currentOfflineUserId,
  );
  _offlineSyncLifecycleObserver =
      OfflineSyncLifecycleObserver(offlineSyncCoordinator!);
  _sessionListener = () => offlineSyncCoordinator?.authenticationChanged();
  sessionManager.addListener(_sessionListener!);
  offlineSyncCoordinator!.start();
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
    CharacterSyncStore? store,
    OfflineCacheDatabase? cache,
    required Client client,
    required int? Function() currentUserId,
    Future<CharacterSyncResponse> Function(CharacterSyncRequest request)?
        syncCharacters,
    List<Duration> retryDelays = _offlineSyncRetryDelays,
  })  : assert(store != null || cache != null),
        _cache = store ?? SqliteCharacterSyncStore(cache!),
        _currentUserId = currentUserId,
        _syncCharacters = syncCharacters ?? client.characterData.syncCharacters,
        _retryDelays = retryDelays;

  final CharacterSyncStore _cache;
  final int? Function() _currentUserId;
  final Future<CharacterSyncResponse> Function(CharacterSyncRequest request)
      _syncCharacters;
  final List<Duration> _retryDelays;
  bool _isRunning = false;
  bool _rerunRequested = false;
  bool _isDisposed = false;
  int _retryAttempt = 0;
  Timer? _retryTimer;
  Timer? _pollTimer;
  int? _negotiatedSyncProtocolVersion;
  int? _activeUserId;
  bool _isForeground = true;

  void start() {
    _restartPolling();
    authenticationChanged();
  }

  void authenticationChanged() {
    final userId = _currentUserId();
    if (_activeUserId == userId) return;
    _activeUserId = userId;
    _negotiatedSyncProtocolVersion = null;
    _retryAttempt = 0;
    _cancelScheduledRetry();
    _restartPolling();
    if (userId != null) unawaited(syncNow());
  }

  void setForeground(bool foreground) {
    if (_isForeground == foreground) return;
    _isForeground = foreground;
    _restartPolling();
    if (foreground) unawaited(syncNow());
  }

  void _restartPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    if (!_isForeground || _isDisposed || _currentUserId() == null) return;
    _pollTimer = Timer.periodic(
      _foregroundPollInterval,
      (_) => unawaited(syncNow()),
    );
  }

  Future<void> syncNow() async {
    _cancelScheduledRetry();
    if (_isRunning) {
      _rerunRequested = true;
      return;
    }
    if (_currentUserId() == null) return;

    _isRunning = true;
    var result = const _SyncPassResult.succeeded();
    try {
      do {
        _rerunRequested = false;
        final userId = _currentUserId();
        if (userId == null) break;
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
      await _cache.markChangesProcessing(
        userId,
        coalesced.map((change) => change.id),
      );
      final pullSince = await _cache.getLastPulledAt(userId);
      final pullAfterEventId = await _cache.getSyncEventCursor(userId);
      final fullResync = pullAfterEventId == null;
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
          fullResync: operationChanges.isEmpty && fullResync,
        );
        shouldRetry |= await _reconcileResponse(
          userId,
          legacyChanges,
          response,
          fullResync: operationChanges.isEmpty && fullResync,
        );
        finalResponse = response;
      }
      if (operationChanges.isNotEmpty || legacyChanges.isEmpty) {
        final response = await _sendOperationChanges(
          operationChanges,
          pullSince: pullSince,
          pullAfterEventId: pullAfterEventId,
          fullResync: fullResync,
        );
        shouldRetry |= await _reconcileResponse(
          userId,
          operationChanges,
          response,
          fullResync: fullResync,
        );
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
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<CharacterSyncResponse> _sendLegacyChanges(
    List<OfflineCharacterChange> changes, {
    required DateTime? pullSince,
    required int? pullAfterEventId,
    required bool fullResync,
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
        fullResync: fullResync,
      ),
    );
  }

  Future<CharacterSyncResponse> _sendOperationChanges(
    List<OfflineCharacterChange> changes, {
    required DateTime? pullSince,
    required int? pullAfterEventId,
    required bool fullResync,
  }) async {
    final operations = [
      for (final change in changes)
        if (change.operationData != null) change.operationData!,
    ];
    CharacterSyncResponse? probe;
    final requiresNegotiation = operations.any(
      (operation) => _requiredProtocolVersion(operation.type) > 0,
    );
    if (requiresNegotiation && _negotiatedSyncProtocolVersion == null) {
      probe = await _syncCharacters(
        CharacterSyncRequest(
          pullSince: pullSince,
          pullAfterEventId: pullAfterEventId,
          fullResync: fullResync,
          syncProtocolVersion: _characterSyncProtocolVersion,
        ),
      );
      _negotiatedSyncProtocolVersion = probe.syncProtocolVersion ?? 0;
    }
    final negotiated = _negotiatedSyncProtocolVersion ?? 0;
    final supported = [
      for (final operation in operations)
        if (_requiredProtocolVersion(operation.type) <= negotiated) operation,
    ];
    final unsupported = [
      for (final operation in operations)
        if (_requiredProtocolVersion(operation.type) > negotiated) operation,
    ];
    CharacterSyncResponse response;
    if (supported.isEmpty && unsupported.isEmpty) {
      response = await _syncCharacters(
        CharacterSyncRequest(
          operations: const [],
          pullSince: pullSince,
          pullAfterEventId: pullAfterEventId,
          fullResync: fullResync,
          syncProtocolVersion: _characterSyncProtocolVersion,
        ),
      );
    } else if (supported.isEmpty) {
      response = probe ??
          CharacterSyncResponse(
            serverTime: DateTime.now().toUtc(),
            syncProtocolVersion: negotiated,
          );
    } else {
      response = await _syncCharacters(
        CharacterSyncRequest(
          operations: supported,
          pullSince: pullSince,
          pullAfterEventId: pullAfterEventId,
          fullResync: fullResync,
          syncProtocolVersion: negotiated,
        ),
      );
    }
    if (unsupported.isEmpty) return response;
    return CharacterSyncResponse(
      acknowledgedChangeIds: response.acknowledgedChangeIds,
      rejectedChanges: [
        ...?response.rejectedChanges,
        for (final operation in unsupported)
          CharacterRejectedChangeData(
            changeId: operation.id,
            reason: 'unsupported_sync_protocol',
            message: 'Server does not support this semantic operation.',
          ),
      ],
      characters: response.characters,
      changedCharacters: response.changedCharacters,
      serverTime: response.serverTime,
      pullCursor: response.pullCursor,
      deletedCharacterIds: response.deletedCharacterIds,
      syncProtocolVersion: response.syncProtocolVersion,
      capabilities: response.capabilities,
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
    for (final change in operationChanges) {
      if (supersededIds.contains(change.id)) {
        _logNoteChange(stage: 'queue-remove-coalesced', change: change);
      }
    }
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

  Future<bool> _reconcileResponse(int userId,
      List<OfflineCharacterChange> sentChanges, CharacterSyncResponse response,
      {required bool fullResync}) async {
    var shouldRetry = false;
    final sentById = {for (final change in sentChanges) change.id: change};
    final acknowledged =
        (response.acknowledgedChangeIds ?? const <String>[]).toSet();
    final canonicalById = <int, CharacterData>{};
    final canonicalSourceById = <int, String>{};
    final localHintByServerId = <int, int>{};
    final terminalIds = <String>{...acknowledged};
    final errorsByServerId = <int, String>{};

    void addCanonical(CharacterData? character, String source) {
      final id = character?.id;
      if (id == null || character == null) return;
      final existing = canonicalById[id];
      if (existing == null ||
          (character.version ?? 0) > (existing.version ?? 0)) {
        canonicalById[id] = character;
        canonicalSourceById[id] = source;
      }
    }

    for (final character in response.characters ?? const <CharacterData>[]) {
      addCanonical(character, 'pull');
    }
    for (final entry in (response.changedCharacters ?? const {}).entries) {
      addCanonical(entry.value, 'ack:${entry.key}');
      final change = sentById[entry.key];
      final serverId = entry.value.id;
      final localId = change?.operationData?.localCharacterId ??
          change?.payload?.id ??
          int.tryParse(change?.entityId ?? '');
      if (serverId != null && localId != null) {
        localHintByServerId[serverId] = localId;
      }
    }

    for (final change in sentChanges) {
      if (!acknowledged.contains(change.id)) continue;
      final operation = change.operationData;
      _logNoteChange(
        stage: 'server-ack',
        change: change,
        canonical: response.changedCharacters?[change.id],
      );
      if (operation?.type == CharacterSyncOperationType.deleteCharacter ||
          (operation == null &&
              change.changeType == CharacterChangeType.delete)) {
        final localId = operation?.localCharacterId ??
            operation?.characterId ??
            int.tryParse(change.entityId);
        if (localId != null) await _cache.markDeleteSynced(userId, localId);
      }
    }

    for (final rejection
        in response.rejectedChanges ?? const <CharacterRejectedChangeData>[]) {
      final change = sentById[rejection.changeId];
      final message =
          rejection.message ?? rejection.reason ?? 'Rejected by server';
      final operation = change?.operationData;
      addCanonical(rejection.character, 'rejection:${rejection.changeId}');
      if (change != null) {
        _logNoteChange(
          stage: 'server-rejection',
          change: change,
          canonical: rejection.character,
          reason: message,
        );
      }
      final serverId = operation?.characterId ?? rejection.character?.id;
      final localId =
          operation?.localCharacterId ?? int.tryParse(change?.entityId ?? '');
      if (serverId != null && localId != null) {
        localHintByServerId[serverId] = localId;
        errorsByServerId[serverId] = message;
      }
      if (change != null &&
          isRetryableUntouchedFieldValidationRejection(
            reason: rejection.reason,
            message: rejection.message,
            operationType: operation?.type,
            fieldPath: operation?.fieldPath,
          )) {
        await _cache.markChangeFailed(userId, rejection.changeId, message);
        await _markChangeSyncError(userId, change, message);
        shouldRetry = true;
      } else {
        terminalIds.add(rejection.changeId);
        if (change != null) {
          await _markChangeSyncError(userId, change, message);
        }
      }
    }

    for (final changeId in terminalIds) {
      final change = sentById[changeId];
      if (change != null) {
        _logNoteChange(stage: 'queue-remove', change: change);
      }
    }
    await _cache.removeChanges(userId, terminalIds);

    for (final serverId in response.deletedCharacterIds ?? const <int>[]) {
      canonicalById.remove(serverId);
      await _cache.applyRemoteDelete(userId, serverId);
    }

    final authoritativeFullResync = fullResync &&
        (response.capabilities ?? const <String>[])
            .contains('authoritative_full_resync');
    if (authoritativeFullResync) {
      final presentIds = canonicalById.keys.toSet();
      for (final record in await _cache.getCharacters(userId)) {
        final serverId = record.serverId;
        if (serverId != null && !presentIds.contains(serverId)) {
          await _cache.applyRemoteDelete(userId, serverId);
        }
      }
    }

    for (final canonical in canonicalById.values) {
      await _acceptCanonicalAndRebase(
        userId,
        canonical,
        localIdHint: localHintByServerId[canonical.id!],
        syncError: errorsByServerId[canonical.id!],
        reconciliationSource: canonicalSourceById[canonical.id!] ?? 'unknown',
      );
    }
    return shouldRetry;
  }

  Future<void> _acceptCanonicalAndRebase(
    int userId,
    CharacterData canonical, {
    int? localIdHint,
    String? syncError,
    required String reconciliationSource,
  }) async {
    final serverId = canonical.id;
    if (serverId == null) return;
    final existing = await _cache.getCharacterByServerId(userId, serverId) ??
        (localIdHint == null
            ? null
            : await _cache.getCharacter(userId, localIdHint));
    final pending = [
      for (final change in await _cache.getPendingChanges(userId))
        if (_changesReferToSameCharacter(
          change,
          localId: existing?.localId ?? localIdHint,
          serverId: serverId,
        ))
          change,
    ];
    await _cache.removeChanges(userId, pending.map((change) => change.id));
    await _cache.markSynced(
      userId,
      existing?.localId ?? localIdHint ?? serverId,
      canonical,
    );
    for (final note in canonical.notes ?? const <CharacterNoteData>[]) {
      logCharacterSyncLifecycle(
        stage: 'reconcile-canonical',
        characterId: serverId,
        noteId: note.id,
        noteText: note.text,
        serverVersion: canonical.version,
        localVersion: canonical.version,
        baseVersion: canonical.version,
        status: OfflineCharacterSyncStatus.clean.name,
        reconciliationSource: reconciliationSource,
        reason: syncError,
      );
    }

    for (final change in pending) {
      final operation = change.operationData;
      if (operation == null) continue;
      if (operation.type == CharacterSyncOperationType.deleteCharacter) {
        await _cache.markDeleting(userId, serverId, syncError);
        continue;
      }
      final current = await _cache.getCharacter(userId, serverId);
      if (current == null) break;
      final visible = replayCharacterSyncOperation(
        current.character,
        operation,
      );
      if (isCharacterSemanticOperation(operation.type)) {
        await _cache.saveSemanticLocal(userId, visible, operation);
      } else {
        await _cache.saveLocal(userId, visible);
      }
    }
    if (syncError != null) {
      await _cache.markSyncError(userId, serverId, syncError);
    } else {
      await _cache.clearSyncError(userId, serverId);
    }
  }

  void _logNoteChange({
    required String stage,
    required OfflineCharacterChange change,
    CharacterData? canonical,
    String? reason,
  }) {
    final operation = change.operationData;
    if (operation?.fieldPath != 'notes') return;
    final note = operation?.itemPayload?.noteValue;
    final canonicalNote = canonical?.notes
        ?.where((value) => value.id == operation?.targetId)
        .firstOrNull;
    logCharacterSyncLifecycle(
      stage: stage,
      characterId: operation?.characterId ??
          operation?.localCharacterId ??
          int.tryParse(change.entityId),
      noteId: operation?.targetId,
      noteText: canonicalNote?.text ?? note?.text,
      changeId: change.id,
      operationType: operation?.type.name,
      serverVersion: canonical?.version,
      baseVersion: operation?.baseCharacterRevision,
      reason: reason,
    );
  }

  bool _changesReferToSameCharacter(
    OfflineCharacterChange change, {
    required int? localId,
    required int? serverId,
  }) {
    final operation = change.operationData;
    return (serverId != null &&
            (change.entityId == serverId.toString() ||
                operation?.characterId == serverId)) ||
        (localId != null &&
            (change.entityId == localId.toString() ||
                operation?.localCharacterId == localId));
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
}

int _requiredProtocolVersion(CharacterSyncOperationType type) {
  if (isCharacterSemanticOperation(type)) return 4;
  return switch (type) {
    CharacterSyncOperationType.addSetMember ||
    CharacterSyncOperationType.removeSetMember ||
    CharacterSyncOperationType.setMemberValue =>
      3,
    _ => 0,
  };
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
    _coordinator.setForeground(state == AppLifecycleState.resumed);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }
}
