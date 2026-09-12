part of '../offline_cache_database_native.dart';

extension OfflineCacheCharacterWriteOperations on OfflineCacheDatabase {
  Future<OfflineCharacterRecord> saveLocal(
    int userId,
    CharacterData character,
  ) async {
    final existing =
        character.id == null ? null : await getCharacter(userId, character.id!);
    final localId = existing?.localId ??
        (character.id != null && character.id! > 0
            ? character.id!
            : await _allocateLocalId(userId));
    final serverId = existing?.serverId ??
        (character.id != null && character.id! > 0 ? character.id : null);
    final now = DateTime.now().toUtc();
    final localCharacter = stampCharacterMutation(
      previous: existing?.character ?? character.copyWith(id: localId),
      next: character.copyWith(id: localId),
      now: now,
    );
    final payload = jsonEncode(localCharacter.toJson());
    final basePayload = existing?._basePayloadJson ??
        jsonEncode(
          (existing?.baseCharacter ?? character).toJson(),
        );

    final stmt = _db.prepare('''
INSERT OR REPLACE INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  base_updated_at, sync_status, sync_operation, local_updated_at,
  server_updated_at, last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      stmt.execute([
        userId,
        localId,
        serverId,
        payload,
        basePayload,
        existing?.baseVersion ?? character.version,
        (existing?.baseUpdatedAt ?? character.updatedAt)
            ?.toUtc()
            .toIso8601String(),
        OfflineCharacterSyncStatus.dirty.name,
        OfflineCharacterSyncOperation.upsert.name,
        now.toIso8601String(),
        existing?._serverUpdatedAt,
        null,
        null,
      ]);
    } finally {
      stmt.dispose();
    }

    final operations = buildCharacterSyncOperations(
      previous: existing?.character ?? localCharacter,
      next: localCharacter,
      localId: localId,
      serverId: serverId,
      createdAt: now,
      nextChangeId: () => _generateChangeId(now),
    );
    if (serverId == null) {
      await deleteQueuedChangesForEntity(userId, localId.toString());
    }
    for (final operation in operations) {
      await _enqueueChange(
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

    return (await getCharacter(userId, localId))!;
  }

  Future<void> markDeleting(int userId, int id, String? error) async {
    final existing = await getCharacter(userId, id);
    if (existing == null) return;
    final now = DateTime.now().toUtc();
    if (existing.serverId == null) {
      await markDeleteSynced(userId, existing.localId);
      await deleteQueuedChangesForEntity(userId, existing.localId.toString());
      return;
    }
    final stmt = _db.prepare('''
UPDATE characters_cache
SET sync_status = ?, sync_operation = ?, local_updated_at = ?, last_sync_error = ?
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterSyncStatus.deleting.name,
        OfflineCharacterSyncOperation.delete.name,
        now.toIso8601String(),
        error,
        userId,
        existing.localId,
      ]);
    } finally {
      stmt.dispose();
    }

    await deleteQueuedChangesForEntity(userId, existing.serverId.toString());
    final operation = CharacterSyncOperationData(
      id: _generateChangeId(now),
      characterId: existing.serverId,
      localCharacterId: existing.localId,
      type: CharacterSyncOperationType.deleteCharacter,
      targetType: CharacterSyncTargetType.character,
      targetId: existing.serverId.toString(),
      baseCharacterRevision: existing.character.version ?? existing.baseVersion,
      baseTargetRevision: existing.character.version ?? existing.baseVersion,
      createdAt: now,
    );
    await _enqueueChange(
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

    final localId = serverId;
    final now = DateTime.now().toUtc();
    final payload = jsonEncode(character.toJson());
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  base_updated_at, sync_status, sync_operation, local_updated_at,
  server_updated_at, last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      stmt.execute([
        userId,
        localId,
        serverId,
        payload,
        payload,
        character.version,
        character.updatedAt?.toUtc().toIso8601String(),
        OfflineCharacterSyncStatus.clean.name,
        null,
        now.toIso8601String(),
        character.updatedAt?.toUtc().toIso8601String() ?? now.toIso8601String(),
        existing?.lastSyncError,
        null,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  ) async {
    final serverId = serverCharacter.id;
    if (serverId == null) return;
    final deleteStmt = _db.prepare('''
DELETE FROM characters_cache
WHERE user_id = ? AND local_id = ? AND local_id != ?
''');
    try {
      deleteStmt.execute([userId, oldLocalId, serverId]);
    } finally {
      deleteStmt.dispose();
    }
    await upsertCleanFromServer(
      userId,
      serverCharacter,
      overwritePending: true,
    );
  }

  Future<void> markDeleteSynced(int userId, int localId) async {
    final stmt = _db.prepare('''
DELETE FROM characters_cache
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([userId, localId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markConflict(
    int userId,
    int localId,
    CharacterData conflictCharacter,
    String? message,
  ) async {
    final stmt = _db.prepare('''
UPDATE characters_cache
SET sync_status = ?, last_sync_error = ?, conflict_payload_json = ?
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterSyncStatus.conflict.name,
        message,
        jsonEncode(conflictCharacter.toJson()),
        userId,
        localId,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markSyncError(int userId, int localId, Object error) async {
    final stmt = _db.prepare('''
UPDATE characters_cache
SET last_sync_error = ?
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([error.toString(), userId, localId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> clearSyncError(int userId, int localId) async {
    final stmt = _db.prepare('''
UPDATE characters_cache
SET last_sync_error = NULL
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([userId, localId]);
    } finally {
      stmt.dispose();
    }
  }
}
