import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';

abstract interface class CharacterSyncStore {
  Future<List<OfflineCharacterRecord>> getCharacters(int userId);

  Future<OfflineCharacterRecord?> getCharacter(int userId, int id);

  Future<OfflineCharacterRecord?> getCharacterByServerId(
    int userId,
    int serverId,
  );

  Future<List<OfflineCharacterChange>> getPendingChanges(int userId);

  Future<void> markChangesProcessing(
    int userId,
    Iterable<String> changeIds,
  );

  Future<OfflineCharacterRecord> saveLocal(
    int userId,
    CharacterData character,
  );

  Future<OfflineCharacterRecord> saveSemanticLocal(
    int userId,
    CharacterData character,
    CharacterSyncOperationData operation,
  );

  Future<void> markDeleting(int userId, int id, String? error);

  Future<void> upsertCleanFromServer(
    int userId,
    CharacterData character, {
    bool overwritePending = false,
  });

  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  );

  Future<void> markDeleteSynced(int userId, int localId);

  Future<void> markConflict(
    int userId,
    int localId,
    CharacterData conflictCharacter,
    String? message,
  );

  Future<void> markSyncError(int userId, int localId, Object error);

  Future<void> clearSyncError(int userId, int localId);

  Future<void> repairSyncQueue(int userId);

  Future<void> removeChanges(int userId, Iterable<String> changeIds);

  Future<void> markChangeFailed(
    int userId,
    String changeId,
    Object error,
  );

  Future<void> markChangeConflict(
    int userId,
    String changeId,
    CharacterData conflictCharacter,
    String? message,
  );

  Future<void> markChangeRejected(
    int userId,
    String changeId,
    String? message,
  );

  Future<void> applyRemoteDelete(int userId, int serverId);

  Future<void> deleteQueuedChangesForEntity(int userId, String entityId);

  Future<bool> hasQueuedChangesForEntity(int userId, String entityId);

  Future<DateTime?> getLastPulledAt(int userId);

  Future<void> setLastPulledAt(int userId, DateTime value);

  Future<int?> getSyncEventCursor(int userId);

  Future<void> setSyncEventCursor(int userId, int value);

  Future<void> clearSyncCursor(int userId);

  Future<void> clearUser(int userId);

  Future<bool> hasUnsyncedChanges(int userId);
}

class SqliteCharacterSyncStore implements CharacterSyncStore {
  const SqliteCharacterSyncStore(this.database);

  final OfflineCacheDatabase database;

  @override
  Future<void> applyRemoteDelete(int userId, int serverId) =>
      database.applyRemoteDelete(userId, serverId);

  @override
  Future<void> clearSyncError(int userId, int localId) =>
      database.clearSyncError(userId, localId);

  @override
  Future<void> clearSyncCursor(int userId) =>
      database.clearSyncEventCursor(userId);

  @override
  Future<void> clearUser(int userId) => database.clearUser(userId);

  @override
  Future<void> deleteQueuedChangesForEntity(int userId, String entityId) =>
      database.deleteQueuedChangesForEntity(userId, entityId);

  @override
  Future<OfflineCharacterRecord?> getCharacter(int userId, int id) =>
      database.getCharacter(userId, id);

  @override
  Future<OfflineCharacterRecord?> getCharacterByServerId(
    int userId,
    int serverId,
  ) =>
      database.getCharacterByServerId(userId, serverId);

  @override
  Future<List<OfflineCharacterRecord>> getCharacters(int userId) =>
      database.getCharacters(userId);

  @override
  Future<DateTime?> getLastPulledAt(int userId) =>
      database.getLastPulledAt(userId);

  @override
  Future<List<OfflineCharacterChange>> getPendingChanges(int userId) =>
      database.getPendingChanges(userId);

  @override
  Future<void> markChangesProcessing(
    int userId,
    Iterable<String> changeIds,
  ) =>
      database.markChangesProcessing(userId, changeIds);

  @override
  Future<int?> getSyncEventCursor(int userId) =>
      database.getSyncEventCursor(userId);

  @override
  Future<bool> hasQueuedChangesForEntity(int userId, String entityId) =>
      database.hasQueuedChangesForEntity(userId, entityId);

  @override
  Future<bool> hasUnsyncedChanges(int userId) =>
      database.hasUnsyncedChanges(userId);

  @override
  Future<void> markChangeConflict(
    int userId,
    String changeId,
    CharacterData conflictCharacter,
    String? message,
  ) =>
      database.markChangeConflict(
        userId,
        changeId,
        conflictCharacter,
        message,
      );

  @override
  Future<void> markChangeFailed(
    int userId,
    String changeId,
    Object error,
  ) =>
      database.markChangeFailed(userId, changeId, error);

  @override
  Future<void> markChangeRejected(
    int userId,
    String changeId,
    String? message,
  ) =>
      database.markChangeRejected(userId, changeId, message);

  @override
  Future<void> markConflict(
    int userId,
    int localId,
    CharacterData conflictCharacter,
    String? message,
  ) =>
      database.markConflict(userId, localId, conflictCharacter, message);

  @override
  Future<void> markDeleteSynced(int userId, int localId) =>
      database.markDeleteSynced(userId, localId);

  @override
  Future<void> markDeleting(int userId, int id, String? error) =>
      database.markDeleting(userId, id, error);

  @override
  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  ) =>
      database.markSynced(userId, oldLocalId, serverCharacter);

  @override
  Future<void> markSyncError(int userId, int localId, Object error) =>
      database.markSyncError(userId, localId, error);

  @override
  Future<void> removeChanges(int userId, Iterable<String> changeIds) =>
      database.removeChanges(userId, changeIds);

  @override
  Future<void> repairSyncQueue(int userId) => database.repairSyncQueue(userId);

  @override
  Future<OfflineCharacterRecord> saveLocal(
    int userId,
    CharacterData character,
  ) =>
      database.saveLocal(userId, character);

  @override
  Future<OfflineCharacterRecord> saveSemanticLocal(
    int userId,
    CharacterData character,
    CharacterSyncOperationData operation,
  ) =>
      database.saveSemanticLocal(userId, character, operation);

  @override
  Future<void> setLastPulledAt(int userId, DateTime value) =>
      database.setLastPulledAt(userId, value);

  @override
  Future<void> setSyncEventCursor(int userId, int value) =>
      database.setSyncEventCursor(userId, value);

  @override
  Future<void> upsertCleanFromServer(
    int userId,
    CharacterData character, {
    bool overwritePending = false,
  }) =>
      database.upsertCleanFromServer(
        userId,
        character,
        overwritePending: overwritePending,
      );
}
