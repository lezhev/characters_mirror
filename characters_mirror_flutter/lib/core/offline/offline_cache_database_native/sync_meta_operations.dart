part of '../offline_cache_database_native.dart';

extension OfflineCacheSyncMetaOperations on OfflineCacheDatabase {
  Future<void> repairSyncQueue(int userId) async {
    final legacyRows = _db.select('''
SELECT DISTINCT entity_id
FROM character_changes
WHERE user_id = ? AND operation_type IS NULL
''', [userId]);
    final legacyEntityIds = {
      for (final row in legacyRows) row['entity_id'] as String,
    };

    for (final row in legacyRows) {
      final entityId = row['entity_id'] as String;
      final parsedId = int.tryParse(entityId);
      final record =
          parsedId == null ? null : await getCharacter(userId, parsedId);
      final hasV2Changes = _hasAnyV2ChangesForEntity(userId, entityId);
      if (!hasV2Changes &&
          record?.status == OfflineCharacterSyncStatus.conflict &&
          record?.conflictCharacter != null) {
        await markSynced(
          userId,
          record!.localId,
          record.conflictCharacter!,
        );
      }

      final deleteLegacy = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ? AND entity_id = ? AND operation_type IS NULL
''');
      try {
        deleteLegacy.execute([userId, entityId]);
      } finally {
        deleteLegacy.dispose();
      }
    }

    for (final record in await getPendingCharacters(userId)) {
      final entityId = (record.serverId ?? record.localId).toString();
      if (_hasV2ChangesForEntity(userId, entityId)) {
        continue;
      }
      if (record.lastSyncError != null && !legacyEntityIds.contains(entityId)) {
        continue;
      }

      final now = DateTime.now().toUtc();
      if (record.status == OfflineCharacterSyncStatus.deleting) {
        final serverId = record.serverId;
        if (serverId == null) {
          await markDeleteSynced(userId, record.localId);
          continue;
        }
        final operation = CharacterSyncOperationData(
          id: _generateChangeId(now),
          characterId: serverId,
          localCharacterId: record.localId,
          type: CharacterSyncOperationType.deleteCharacter,
          targetType: CharacterSyncTargetType.character,
          targetId: serverId.toString(),
          baseCharacterRevision: record.character.version ?? record.baseVersion,
          baseTargetRevision: record.character.version ?? record.baseVersion,
          createdAt: now,
        );
        _enqueueChange(
          OfflineCharacterChange(
            id: operation.id,
            userId: userId,
            changeType: CharacterChangeType.delete,
            entityType: CharacterEntityType.character,
            entityId: entityId,
            operationData: operation,
            createdAt: now,
            baseUpdatedAt: record.character.updatedAt ?? record.baseUpdatedAt,
            status: OfflineCharacterChangeStatus.pending,
          ),
        );
        continue;
      }

      final operations = buildCharacterSyncOperations(
        previous: record.baseCharacter ?? record.character,
        next: record.character,
        localId: record.localId,
        serverId: record.serverId,
        createdAt: now,
        nextChangeId: () => _generateChangeId(now),
      );
      if (operations.isEmpty) {
        final base = record.baseCharacter;
        if (base != null) {
          await markSynced(userId, record.localId, base);
        } else {
          await markSyncError(
            userId,
            record.localId,
            'Unable to rebuild pending sync operations.',
          );
        }
        continue;
      }

      for (final operation in operations) {
        _enqueueChange(
          OfflineCharacterChange(
            id: operation.id,
            userId: userId,
            changeType: CharacterChangeType.upsert,
            entityType: CharacterEntityType.character,
            entityId: entityId,
            payload: record.serverId == null ? record.character : null,
            operationData: operation,
            createdAt: now,
            baseUpdatedAt: record.baseUpdatedAt,
            status: OfflineCharacterChangeStatus.pending,
          ),
        );
      }
      await clearSyncError(userId, record.localId);
    }
  }

  bool _hasAnyV2ChangesForEntity(int userId, String entityId) {
    final stmt = _db.prepare('''
SELECT 1 FROM character_changes
WHERE user_id = ? AND entity_id = ? AND operation_type IS NOT NULL
LIMIT 1
''');
    try {
      return stmt.select([userId, entityId]).isNotEmpty;
    } finally {
      stmt.dispose();
    }
  }

  bool _hasV2ChangesForEntity(int userId, String entityId) {
    final stmt = _db.prepare('''
SELECT 1 FROM character_changes
WHERE user_id = ? AND entity_id = ? AND operation_type IS NOT NULL
  AND status IN (?, ?)
LIMIT 1
''');
    try {
      return stmt.select([
        userId,
        entityId,
        OfflineCharacterChangeStatus.pending.name,
        OfflineCharacterChangeStatus.failed.name,
      ]).isNotEmpty;
    } finally {
      stmt.dispose();
    }
  }

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

  Future<void> applyRemoteDelete(int userId, int serverId) async {
    final existing = await getCharacterByServerId(userId, serverId);
    if (existing == null) return;

    if (existing.status == OfflineCharacterSyncStatus.clean ||
        existing.status == OfflineCharacterSyncStatus.deleting) {
      await markDeleteSynced(userId, existing.localId);
      await deleteQueuedChangesForEntity(userId, serverId.toString());
      return;
    }

    final stmt = _db.prepare('''
UPDATE characters_cache
SET sync_status = ?, last_sync_error = ?, conflict_payload_json = NULL
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterSyncStatus.conflict.name,
        'Character was deleted on another device.',
        userId,
        existing.localId,
      ]);
    } finally {
      stmt.dispose();
    }

    final changes = await getPendingChanges(userId);
    for (final change in changes) {
      final operation = change.operationData;
      final matches = change.entityId == serverId.toString() ||
          operation?.characterId == serverId ||
          operation?.localCharacterId == existing.localId;
      if (matches) {
        await markChangeRejected(
          userId,
          change.id,
          'Character was deleted on another device.',
        );
      }
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

  Future<int?> getSyncEventCursor(int userId) async {
    final value = _readMeta(userId, 'sync_event_cursor');
    return value == null ? null : int.tryParse(value);
  }

  Future<void> setSyncEventCursor(int userId, int value) async {
    _writeMeta(userId, 'sync_event_cursor', value.toString());
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
