import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_item_id.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_store.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';

class MemoryCharacterSyncStore implements CharacterSyncStore {
  final Map<int, Map<int, OfflineCharacterRecord>> _characters = {};
  final Map<int, List<OfflineCharacterChange>> _changes = {};
  final Map<int, DateTime> _lastPulledAt = {};
  final Map<int, int> _cursors = {};
  final Map<int, int> _nextLocalIds = {};

  Map<int, OfflineCharacterRecord> _userCharacters(int userId) =>
      _characters.putIfAbsent(userId, () => {});

  List<OfflineCharacterChange> _userChanges(int userId) =>
      _changes.putIfAbsent(userId, () => []);

  @override
  Future<List<OfflineCharacterRecord>> getCharacters(int userId) async => [
        for (final record in _userCharacters(userId).values)
          if (record.status != OfflineCharacterSyncStatus.deleting) record,
      ];

  @override
  Future<OfflineCharacterRecord?> getCharacter(int userId, int id) async {
    for (final record in _userCharacters(userId).values) {
      if (record.localId == id || record.serverId == id) return record;
    }
    return null;
  }

  @override
  Future<OfflineCharacterRecord?> getCharacterByServerId(
    int userId,
    int serverId,
  ) =>
      getCharacter(userId, serverId);

  @override
  Future<List<OfflineCharacterChange>> getPendingChanges(int userId) async => [
        for (final change in _userChanges(userId))
          if (change.status == OfflineCharacterChangeStatus.pending ||
              change.status == OfflineCharacterChangeStatus.failed)
            change,
      ];

  @override
  Future<void> markChangesProcessing(
    int userId,
    Iterable<String> changeIds,
  ) async {
    final ids = changeIds.toSet();
    for (final id in ids) {
      _replaceChange(
        userId,
        id,
        (change) => _copyChange(
          change,
          status: OfflineCharacterChangeStatus.processing,
          clearLastError: true,
        ),
      );
    }
  }

  @override
  Future<OfflineCharacterRecord> saveLocal(
    int userId,
    CharacterData character,
  ) async {
    final existing =
        character.id == null ? null : await getCharacter(userId, character.id!);
    final localId = existing?.localId ??
        (character.id != null && character.id! > 0
            ? character.id!
            : _allocateLocalId(userId));
    final serverId = existing?.serverId ??
        (character.id != null && character.id! > 0 ? character.id : null);
    final now = DateTime.now().toUtc();
    var localCharacter = stampCharacterMutation(
      previous: existing?.character ?? character.copyWith(id: localId),
      next: character.copyWith(id: localId),
      now: now,
    );
    final operations = buildCharacterSyncOperations(
      previous: existing?.character ?? localCharacter,
      next: localCharacter,
      localId: localId,
      serverId: serverId,
      createdAt: now,
      nextChangeId: createCharacterSyncItemId,
    );
    localCharacter = applyLocalAbsoluteBarrierTokens(
      localCharacter,
      operations,
      characterSyncOperationTargetKey,
    );
    if (serverId == null) {
      _userChanges(userId).removeWhere(
        (change) =>
            change.entityId == localId.toString() &&
            (change.status == OfflineCharacterChangeStatus.pending ||
                change.status == OfflineCharacterChangeStatus.failed),
      );
    }
    for (final operation in operations) {
      _userChanges(userId).add(
        OfflineCharacterChange(
          id: operation.id,
          userId: userId,
          changeType: CharacterChangeType.upsert,
          entityType: CharacterEntityType.character,
          entityId: (serverId ?? localId).toString(),
          payload: serverId == null ? localCharacter : null,
          operationData: operation,
          createdAt: now,
          baseUpdatedAt: existing?.baseUpdatedAt ?? character.updatedAt,
          status: OfflineCharacterChangeStatus.pending,
        ),
      );
    }
    final status = operations.isEmpty &&
            existing?.status == OfflineCharacterSyncStatus.clean
        ? OfflineCharacterSyncStatus.clean
        : OfflineCharacterSyncStatus.dirty;
    final record = OfflineCharacterRecord(
      userId: userId,
      localId: localId,
      serverId: serverId,
      character: localCharacter,
      baseVersion: existing?.baseVersion ?? character.version,
      baseUpdatedAt: existing?.baseUpdatedAt ?? character.updatedAt,
      baseCharacter: existing?.baseCharacter ?? character,
      status: status,
      operation: status == OfflineCharacterSyncStatus.clean
          ? null
          : OfflineCharacterSyncOperation.upsert,
    );
    _userCharacters(userId)[localId] = record;
    return record;
  }

  @override
  Future<OfflineCharacterRecord> saveSemanticLocal(
    int userId,
    CharacterData character,
    CharacterSyncOperationData operation,
  ) async {
    final existing =
        character.id == null ? null : await getCharacter(userId, character.id!);
    if (existing == null || existing.serverId == null) {
      return saveLocal(userId, character);
    }
    final rebased = rebaseCharacterSemanticOperation(
      existing.character,
      operation.copyWith(
        characterId: existing.serverId,
        localCharacterId: existing.localId,
      ),
    );
    var localCharacter = stampCharacterMutation(
      previous: existing.character,
      next: character.copyWith(id: existing.localId),
      now: operation.createdAt.toUtc(),
    );
    localCharacter = materializeLocalBarrierTokens(localCharacter, rebased);
    final record = _copyRecord(
      existing,
      character: localCharacter,
      status: OfflineCharacterSyncStatus.dirty,
      operation: OfflineCharacterSyncOperation.upsert,
      clearLastSyncError: true,
    );
    _userCharacters(userId)[existing.localId] = record;
    _userChanges(userId).add(
      OfflineCharacterChange(
        id: rebased.id,
        userId: userId,
        changeType: CharacterChangeType.upsert,
        entityType: CharacterEntityType.character,
        entityId: existing.serverId.toString(),
        operationData: rebased,
        createdAt: rebased.createdAt,
        baseUpdatedAt: existing.baseUpdatedAt,
        status: OfflineCharacterChangeStatus.pending,
      ),
    );
    return record;
  }

  @override
  Future<void> markDeleting(int userId, int id, String? error) async {
    final existing = await getCharacter(userId, id);
    if (existing == null) return;
    if (existing.serverId == null) {
      await markDeleteSynced(userId, existing.localId);
      return;
    }
    final now = DateTime.now().toUtc();
    _userChanges(userId).removeWhere(
      (change) => _changeMatchesRecord(change, existing),
    );
    final operation = CharacterSyncOperationData(
      id: createCharacterSyncItemId(),
      characterId: existing.serverId,
      localCharacterId: existing.localId,
      type: CharacterSyncOperationType.deleteCharacter,
      targetType: CharacterSyncTargetType.character,
      targetId: existing.serverId.toString(),
      baseCharacterRevision: existing.character.version ?? existing.baseVersion,
      baseTargetRevision: existing.character.version ?? existing.baseVersion,
      createdAt: now,
    );
    _userCharacters(userId)[existing.localId] = _copyRecord(
      existing,
      status: OfflineCharacterSyncStatus.deleting,
      operation: OfflineCharacterSyncOperation.delete,
      lastSyncError: error,
    );
    _userChanges(userId).add(
      OfflineCharacterChange(
        id: operation.id,
        userId: userId,
        changeType: CharacterChangeType.delete,
        entityType: CharacterEntityType.character,
        entityId: existing.serverId.toString(),
        operationData: operation,
        createdAt: now,
        baseUpdatedAt: existing.character.updatedAt ?? existing.baseUpdatedAt,
        status: OfflineCharacterChangeStatus.pending,
      ),
    );
  }

  @override
  Future<void> upsertCleanFromServer(
    int userId,
    CharacterData character, {
    bool overwritePending = false,
  }) async {
    final serverId = character.id;
    if (serverId == null) return;
    final existing = await getCharacterByServerId(userId, serverId);
    if (!overwritePending &&
        existing != null &&
        existing.status != OfflineCharacterSyncStatus.clean) {
      return;
    }
    if (existing != null && existing.localId != serverId) {
      _userCharacters(userId).remove(existing.localId);
    }
    _userCharacters(userId)[serverId] = OfflineCharacterRecord(
      userId: userId,
      localId: serverId,
      serverId: serverId,
      character: character,
      baseVersion: character.version,
      baseUpdatedAt: character.updatedAt,
      baseCharacter: character,
      status: OfflineCharacterSyncStatus.clean,
      lastSyncError: existing?.lastSyncError,
    );
  }

  @override
  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  ) async {
    _userCharacters(userId).remove(oldLocalId);
    await upsertCleanFromServer(
      userId,
      serverCharacter,
      overwritePending: true,
    );
  }

  @override
  Future<void> markDeleteSynced(int userId, int localId) async {
    final record = await getCharacter(userId, localId);
    if (record == null) return;
    _userCharacters(userId).remove(record.localId);
    _userChanges(userId).removeWhere(
      (change) => _changeMatchesRecord(change, record),
    );
  }

  @override
  Future<void> markConflict(
    int userId,
    int localId,
    CharacterData conflictCharacter,
    String? message,
  ) async {
    final existing = await getCharacter(userId, localId);
    if (existing == null) return;
    _userCharacters(userId)[existing.localId] = _copyRecord(
      existing,
      status: OfflineCharacterSyncStatus.conflict,
      lastSyncError: message,
      conflictCharacter: conflictCharacter,
    );
  }

  @override
  Future<void> markSyncError(int userId, int localId, Object error) async {
    final existing = await getCharacter(userId, localId);
    if (existing == null) return;
    _userCharacters(userId)[existing.localId] =
        _copyRecord(existing, lastSyncError: error.toString());
  }

  @override
  Future<void> clearSyncError(int userId, int localId) async {
    final existing = await getCharacter(userId, localId);
    if (existing == null) return;
    _userCharacters(userId)[existing.localId] =
        _copyRecord(existing, clearLastSyncError: true);
  }

  @override
  Future<void> repairSyncQueue(int userId) async {
    final changes = _userChanges(userId);
    for (var index = 0; index < changes.length; index++) {
      if (changes[index].status == OfflineCharacterChangeStatus.processing) {
        changes[index] = _copyChange(
          changes[index],
          status: OfflineCharacterChangeStatus.failed,
        );
      }
    }
  }

  @override
  Future<void> removeChanges(int userId, Iterable<String> changeIds) async {
    final ids = changeIds.toSet();
    _userChanges(userId).removeWhere((change) => ids.contains(change.id));
  }

  @override
  Future<void> markChangeFailed(
    int userId,
    String changeId,
    Object error,
  ) async {
    _replaceChange(
      userId,
      changeId,
      (change) => _copyChange(
        change,
        status: OfflineCharacterChangeStatus.failed,
        lastError: error.toString(),
      ),
    );
  }

  @override
  Future<void> markChangeConflict(
    int userId,
    String changeId,
    CharacterData conflictCharacter,
    String? message,
  ) async {
    _replaceChange(
      userId,
      changeId,
      (change) => _copyChange(
        change,
        status: OfflineCharacterChangeStatus.conflict,
        lastError: message,
      ),
    );
  }

  @override
  Future<void> markChangeRejected(
    int userId,
    String changeId,
    String? message,
  ) =>
      markChangeConflict(
        userId,
        changeId,
        CharacterData(),
        message,
      );

  @override
  Future<void> applyRemoteDelete(int userId, int serverId) async {
    final existing = await getCharacterByServerId(userId, serverId);
    if (existing == null) return;
    await markDeleteSynced(userId, existing.localId);
  }

  @override
  Future<void> deleteQueuedChangesForEntity(
    int userId,
    String entityId,
  ) async {
    _userChanges(userId).removeWhere((change) => change.entityId == entityId);
  }

  @override
  Future<bool> hasQueuedChangesForEntity(
    int userId,
    String entityId,
  ) async =>
      _userChanges(userId).any((change) => change.entityId == entityId);

  @override
  Future<DateTime?> getLastPulledAt(int userId) async => _lastPulledAt[userId];

  @override
  Future<void> setLastPulledAt(int userId, DateTime value) async {
    _lastPulledAt[userId] = value.toUtc();
  }

  @override
  Future<int?> getSyncEventCursor(int userId) async => _cursors[userId];

  @override
  Future<void> setSyncEventCursor(int userId, int value) async {
    _cursors[userId] = value;
  }

  @override
  Future<void> clearSyncCursor(int userId) async {
    _cursors.remove(userId);
  }

  @override
  Future<void> clearUser(int userId) async {
    _characters.remove(userId);
    _changes.remove(userId);
    _lastPulledAt.remove(userId);
    _cursors.remove(userId);
    _nextLocalIds.remove(userId);
  }

  @override
  Future<bool> hasUnsyncedChanges(int userId) async =>
      _userCharacters(userId).values.any(
            (record) => record.status != OfflineCharacterSyncStatus.clean,
          );

  int _allocateLocalId(int userId) {
    final next = _nextLocalIds[userId] ?? -1;
    _nextLocalIds[userId] = next - 1;
    return next;
  }

  void _replaceChange(
    int userId,
    String changeId,
    OfflineCharacterChange Function(OfflineCharacterChange change) replace,
  ) {
    final changes = _userChanges(userId);
    final index = changes.indexWhere((change) => change.id == changeId);
    if (index != -1) changes[index] = replace(changes[index]);
  }
}

bool _changeMatchesRecord(
  OfflineCharacterChange change,
  OfflineCharacterRecord record,
) {
  final operation = change.operationData;
  return change.entityId == record.localId.toString() ||
      change.entityId == record.serverId?.toString() ||
      operation?.localCharacterId == record.localId ||
      operation?.characterId == record.serverId;
}

OfflineCharacterRecord _copyRecord(
  OfflineCharacterRecord record, {
  CharacterData? character,
  OfflineCharacterSyncStatus? status,
  OfflineCharacterSyncOperation? operation,
  String? lastSyncError,
  bool clearLastSyncError = false,
  CharacterData? conflictCharacter,
}) {
  return OfflineCharacterRecord(
    userId: record.userId,
    localId: record.localId,
    serverId: record.serverId,
    character: character ?? record.character,
    baseVersion: record.baseVersion,
    baseUpdatedAt: record.baseUpdatedAt,
    baseCharacter: record.baseCharacter,
    status: status ?? record.status,
    operation: operation ?? record.operation,
    lastSyncError:
        clearLastSyncError ? null : lastSyncError ?? record.lastSyncError,
    conflictCharacter: conflictCharacter ?? record.conflictCharacter,
  );
}

OfflineCharacterChange _copyChange(
  OfflineCharacterChange change, {
  OfflineCharacterChangeStatus? status,
  String? lastError,
  bool clearLastError = false,
}) {
  return OfflineCharacterChange(
    id: change.id,
    userId: change.userId,
    changeType: change.changeType,
    entityType: change.entityType,
    entityId: change.entityId,
    payload: change.payload,
    operationData: change.operationData,
    createdAt: change.createdAt,
    baseUpdatedAt: change.baseUpdatedAt,
    status: status ?? change.status,
    lastError: clearLastError ? null : lastError ?? change.lastError,
  );
}
