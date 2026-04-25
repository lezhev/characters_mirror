import 'package:characters_mirror_client/characters_mirror_client.dart';

enum OfflineCharacterSyncStatus {
  clean,
  dirty,
  deleting,
  conflict,
}

enum OfflineCharacterSyncOperation {
  upsert,
  delete,
}

enum OfflineCharacterChangeStatus {
  pending,
  processing,
  failed,
}

class OfflineCharacterRecord {
  const OfflineCharacterRecord({
    required this.userId,
    required this.localId,
    required this.character,
    required this.status,
    this.serverId,
    this.baseVersion,
    this.baseUpdatedAt,
    this.baseCharacter,
    this.operation,
    this.lastSyncError,
    this.conflictCharacter,
  });

  final int userId;
  final int localId;
  final int? serverId;
  final CharacterData character;
  final int? baseVersion;
  final DateTime? baseUpdatedAt;
  final CharacterData? baseCharacter;
  final OfflineCharacterSyncStatus status;
  final OfflineCharacterSyncOperation? operation;
  final String? lastSyncError;
  final CharacterData? conflictCharacter;

  bool get isPending =>
      status == OfflineCharacterSyncStatus.dirty ||
      status == OfflineCharacterSyncStatus.deleting;
  bool get isConflict => status == OfflineCharacterSyncStatus.conflict;
}

class OfflineCharacterChange {
  const OfflineCharacterChange({
    required this.id,
    required this.userId,
    required this.changeType,
    required this.entityType,
    required this.entityId,
    required this.createdAt,
    required this.status,
    this.payload,
    this.baseUpdatedAt,
    this.lastError,
  });

  final String id;
  final int userId;
  final CharacterChangeType changeType;
  final CharacterEntityType entityType;
  final String entityId;
  final CharacterData? payload;
  final DateTime createdAt;
  final DateTime? baseUpdatedAt;
  final OfflineCharacterChangeStatus status;
  final String? lastError;
}

class OfflineCacheDatabase {
  OfflineCacheDatabase._();

  static Future<OfflineCacheDatabase> openDefault() async =>
      throw UnsupportedError('Offline SQLite cache is only available on IO.');

  static Future<OfflineCacheDatabase> openAt(String path) async =>
      throw UnsupportedError('Offline SQLite cache is only available on IO.');

  static OfflineCacheDatabase openInMemory() =>
      throw UnsupportedError('Offline SQLite cache is only available on IO.');

  void close() {}

  Future<void> putReference<T>(
    String kind,
    String cacheKey,
    T value,
    Map<String, dynamic> Function(T value) toJson,
  ) async {}

  Future<void> putReferenceList<T>(
    String kind,
    String cacheKey,
    List<T> values,
    Map<String, dynamic> Function(T value) toJson,
  ) async {}

  Future<T?> getReference<T>(
    String kind,
    String cacheKey,
    T Function(Map<String, dynamic> json) fromJson,
  ) async =>
      null;

  Future<List<T>?> getReferenceList<T>(
    String kind,
    String cacheKey,
    T Function(Map<String, dynamic> json) fromJson,
  ) async =>
      null;

  Future<List<OfflineCharacterRecord>> getCharacters(int userId) async =>
      const [];

  Future<OfflineCharacterRecord?> getCharacter(int userId, int id) async =>
      null;

  Future<OfflineCharacterRecord?> getCharacterByServerId(
    int userId,
    int serverId,
  ) async =>
      null;

  Future<List<OfflineCharacterRecord>> getPendingCharacters(int userId) async =>
      const [];

  Future<List<OfflineCharacterChange>> getPendingChanges(int userId) async =>
      const [];

  Future<OfflineCharacterRecord> saveLocal(
    int userId,
    CharacterData character,
  ) async =>
      throw UnsupportedError('Offline SQLite cache is only available on IO.');

  Future<void> markDeleting(int userId, int id, String? error) async {}

  Future<void> upsertCleanFromServer(
    int userId,
    CharacterData character, {
    bool overwritePending = false,
  }) async {}

  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  ) async {}

  Future<void> markDeleteSynced(int userId, int localId) async {}

  Future<void> markConflict(
    int userId,
    int localId,
    CharacterData conflictCharacter,
    String? message,
  ) async {}

  Future<void> markSyncError(int userId, int localId, Object error) async {}

  Future<void> clearSyncError(int userId, int localId) async {}

  Future<void> acceptServerVersion(int userId, int localId) async {}

  Future<void> removeChanges(int userId, Iterable<String> changeIds) async {}

  Future<void> markChangeFailed(int userId, String changeId, Object error) async {}

  Future<void> deleteQueuedChangesForEntity(int userId, String entityId) async {}

  Future<DateTime?> getLastPulledAt(int userId) async => null;

  Future<void> setLastPulledAt(int userId, DateTime value) async {}

  Future<void> clearUser(int userId) async {}

  Future<bool> hasUnsyncedChanges(int userId) async => false;
}
