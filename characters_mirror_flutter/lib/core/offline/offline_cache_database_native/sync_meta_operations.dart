part of '../offline_cache_database_native.dart';

extension OfflineCacheSyncMetaOperations on OfflineCacheDatabase {
  Future<void> acceptServerVersion(int userId, int localId) async {
    final local = await getCharacter(userId, localId);
    final conflict = local?.conflictCharacter;
    if (conflict == null) return;
    await markSynced(userId, localId, conflict);
  }

  Future<void> removeChanges(int userId, Iterable<String> changeIds) async {
    final ids = changeIds.toSet();
    if (ids.isEmpty) return;
    final stmt = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ? AND id = ?
''');
    try {
      for (final id in ids) {
        stmt.execute([userId, id]);
      }
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markChangeFailed(
      int userId, String changeId, Object error) async {
    final stmt = _db.prepare('''
UPDATE character_changes
SET status = ?, last_error = ?
WHERE user_id = ? AND id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterChangeStatus.failed.name,
        error.toString(),
        userId,
        changeId,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markChangeConflict(
    int userId,
    String changeId,
    CharacterData conflictCharacter,
    String? message,
  ) async {
    final stmt = _db.prepare('''
UPDATE character_changes
SET status = ?, last_error = ?, conflict_payload_json = ?, rejected_at = ?
WHERE user_id = ? AND id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterChangeStatus.conflict.name,
        message,
        jsonEncode(conflictCharacter.toJson()),
        DateTime.now().toUtc().toIso8601String(),
        userId,
        changeId,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markChangeRejected(
    int userId,
    String changeId,
    String? message,
  ) async {
    final stmt = _db.prepare('''
UPDATE character_changes
SET status = ?, last_error = ?, rejected_at = ?
WHERE user_id = ? AND id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterChangeStatus.conflict.name,
        message,
        DateTime.now().toUtc().toIso8601String(),
        userId,
        changeId,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> deleteQueuedChangesForEntity(int userId, String entityId) async {
    final stmt = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ? AND entity_id = ?
''');
    try {
      stmt.execute([userId, entityId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<bool> hasQueuedChangesForEntity(int userId, String entityId) async {
    final stmt = _db.prepare('''
SELECT 1 FROM character_changes
WHERE user_id = ? AND entity_id = ?
LIMIT 1
''');
    try {
      return stmt.select([userId, entityId]).isNotEmpty;
    } finally {
      stmt.dispose();
    }
  }

  Future<DateTime?> getLastPulledAt(int userId) async {
    final value = _readMeta(userId, 'last_pulled_at');
    return value == null ? null : DateTime.tryParse(value)?.toUtc();
  }

  Future<void> setLastPulledAt(int userId, DateTime value) async {
    _writeMeta(userId, 'last_pulled_at', value.toUtc().toIso8601String());
  }

  Future<void> clearUser(int userId) async {
    final deleteCharacters =
        _db.prepare('DELETE FROM characters_cache WHERE user_id = ?');
    final deleteMeta =
        _db.prepare('DELETE FROM offline_meta WHERE user_id = ?');
    final deleteChanges =
        _db.prepare('DELETE FROM character_changes WHERE user_id = ?');
    try {
      deleteCharacters.execute([userId]);
      deleteMeta.execute([userId]);
      deleteChanges.execute([userId]);
    } finally {
      deleteCharacters.dispose();
      deleteMeta.dispose();
      deleteChanges.dispose();
    }
  }

  Future<bool> hasUnsyncedChanges(int userId) async {
    final stmt = _db.prepare('''
SELECT 1 FROM characters_cache
WHERE user_id = ? AND sync_status IN (?, ?, ?)
LIMIT 1
''');
    try {
      return stmt.select([
        userId,
        OfflineCharacterSyncStatus.dirty.name,
        OfflineCharacterSyncStatus.deleting.name,
        OfflineCharacterSyncStatus.conflict.name,
      ]).isNotEmpty;
    } finally {
      stmt.dispose();
    }
  }
}
