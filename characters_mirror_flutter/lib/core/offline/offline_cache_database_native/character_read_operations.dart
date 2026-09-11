part of '../offline_cache_database_native.dart';

extension OfflineCacheCharacterReadOperations on OfflineCacheDatabase {
  Future<List<OfflineCharacterRecord>> getCharacters(int userId) async {
    final stmt = _db.prepare('''
SELECT * FROM characters_cache
WHERE user_id = ? AND sync_status != ?
ORDER BY local_updated_at DESC
''');
    try {
      return [
        for (final row
            in stmt.select([userId, OfflineCharacterSyncStatus.deleting.name]))
          _rowToCharacterRecord(row),
      ];
    } finally {
      stmt.dispose();
    }
  }

  Future<OfflineCharacterRecord?> getCharacter(int userId, int id) async {
    final stmt = _db.prepare('''
SELECT * FROM characters_cache
WHERE user_id = ? AND (local_id = ? OR server_id = ?)
LIMIT 1
''');
    try {
      final rows = stmt.select([userId, id, id]);
      if (rows.isEmpty) return null;
      return _rowToCharacterRecord(rows.first);
    } finally {
      stmt.dispose();
    }
  }

  Future<OfflineCharacterRecord?> getCharacterByServerId(
    int userId,
    int serverId,
  ) async {
    return getCharacter(userId, serverId);
  }

  Future<List<OfflineCharacterRecord>> getPendingCharacters(int userId) async {
    final stmt = _db.prepare('''
SELECT * FROM characters_cache
WHERE user_id = ? AND sync_status IN (?, ?)
ORDER BY local_updated_at ASC
''');
    try {
      return [
        for (final row in stmt.select([
          userId,
          OfflineCharacterSyncStatus.dirty.name,
          OfflineCharacterSyncStatus.deleting.name,
        ]))
          _rowToCharacterRecord(row),
      ];
    } finally {
      stmt.dispose();
    }
  }

  Future<List<OfflineCharacterChange>> getPendingChanges(int userId) async {
    final stmt = _db.prepare('''
SELECT * FROM character_changes
WHERE user_id = ? AND status IN (?, ?)
ORDER BY created_at ASC
''');
    try {
      return [
        for (final row in stmt.select([
          userId,
          OfflineCharacterChangeStatus.pending.name,
          OfflineCharacterChangeStatus.failed.name,
        ]))
          _rowToCharacterChange(row),
      ];
    } finally {
      stmt.dispose();
    }
  }
}
