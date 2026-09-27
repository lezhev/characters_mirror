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
    var localCharacter = stampCharacterMutation(
      previous: existing?.character ?? character.copyWith(id: localId),
      next: character.copyWith(id: localId),
      now: now,
    );
    final basePayload = existing?._basePayloadJson ??
        jsonEncode(
          (existing?.baseCharacter ?? character).toJson(),
        );
    final operations = buildCharacterSyncOperations(
      previous: existing?.character ?? localCharacter,
      next: localCharacter,
      localId: localId,
      serverId: serverId,
      createdAt: now,
      nextChangeId: () => _generateChangeId(now),
    );
    localCharacter = applyLocalAbsoluteBarrierTokens(
      localCharacter,
      operations,
      characterSyncOperationTargetKey,
    );
    final payload = jsonEncode(localCharacter.toJson());
    final nextStatus = operations.isEmpty &&
            existing?.status == OfflineCharacterSyncStatus.clean
        ? OfflineCharacterSyncStatus.clean
        : OfflineCharacterSyncStatus.dirty;

    final stmt = _db.prepare('''
INSERT OR REPLACE INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  base_updated_at, sync_status, sync_operation, local_updated_at,
  server_updated_at, last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      _runTransaction(() {
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
          nextStatus.name,
          nextStatus == OfflineCharacterSyncStatus.clean
              ? null
              : OfflineCharacterSyncOperation.upsert.name,
          now.toIso8601String(),
          existing?._serverUpdatedAt,
          null,
          null,
        ]);

        if (serverId == null) {
          final deleteStmt = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ? AND entity_id = ? AND status IN (?, ?)
''');
          try {
            deleteStmt.execute([
              userId,
              localId.toString(),
              OfflineCharacterChangeStatus.pending.name,
              OfflineCharacterChangeStatus.failed.name,
            ]);
          } finally {
            deleteStmt.dispose();
          }
        }
        for (final operation in operations) {
          _enqueueChange(
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
      });
    } finally {
      stmt.dispose();
    }

    for (final operation in operations) {
      if (operation.fieldPath != 'notes') continue;
      final note = operation.itemPayload?.noteValue;
      logCharacterSyncLifecycle(
        stage: 'sqlite-commit-queue-insert',
        characterId: serverId ?? localId,
        noteId: operation.targetId,
        noteText: note?.text,
        changeId: operation.id,
        operationType: operation.type.name,
        localVersion: localCharacter.version,
        baseVersion: existing?.baseVersion ?? character.version,
        status: nextStatus.name,
      );
    }

    return (await getCharacter(userId, localId))!;
  }

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

    final now = operation.createdAt.toUtc();
    final rebasedOperation = rebaseCharacterSemanticOperation(
      existing.character,
      operation.copyWith(
        characterId: existing.serverId,
        localCharacterId: existing.localId,
      ),
    );
    var localCharacter = stampCharacterMutation(
      previous: existing.character,
      next: character.copyWith(id: existing.localId),
      now: now,
    );
    localCharacter = materializeLocalBarrierTokens(
      localCharacter,
      rebasedOperation,
    );
    final payload = jsonEncode(localCharacter.toJson());
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  base_updated_at, sync_status, sync_operation, local_updated_at,
  server_updated_at, last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      _runTransaction(() {
        stmt.execute([
          userId,
          existing.localId,
          existing.serverId,
          payload,
          existing._basePayloadJson ??
              jsonEncode(
                  (existing.baseCharacter ?? existing.character).toJson()),
          existing.baseVersion ?? existing.character.version,
          existing.baseUpdatedAt?.toUtc().toIso8601String(),
          OfflineCharacterSyncStatus.dirty.name,
          OfflineCharacterSyncOperation.upsert.name,
          now.toIso8601String(),
          existing._serverUpdatedAt,
          null,
          null,
        ]);
        _enqueueChange(
          OfflineCharacterChange(
            id: rebasedOperation.id,
            userId: userId,
            changeType: CharacterChangeType.upsert,
            entityType: CharacterEntityType.character,
            entityId: existing.serverId.toString(),
            operationData: rebasedOperation,
            createdAt: now,
            baseUpdatedAt: existing.baseUpdatedAt,
            status: OfflineCharacterChangeStatus.pending,
          ),
        );
      });
    } finally {
      stmt.dispose();
    }
    return (await getCharacter(userId, existing.localId))!;
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
    final deleteChanges = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ?
  AND (entity_id = ? OR operation_character_id = ?
       OR operation_local_character_id = ?)
''');
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
    try {
      _runTransaction(() {
        stmt.execute([
          OfflineCharacterSyncStatus.deleting.name,
          OfflineCharacterSyncOperation.delete.name,
          now.toIso8601String(),
          error,
          userId,
          existing.localId,
        ]);
        deleteChanges.execute([
          userId,
          existing.serverId.toString(),
          existing.serverId,
          existing.localId,
        ]);
        _enqueueChange(
          OfflineCharacterChange(
            id: operation.id,
            userId: userId,
            changeType: CharacterChangeType.delete,
            entityType: CharacterEntityType.character,
            entityId: existing.serverId.toString(),
            operationData: operation,
            createdAt: now,
            baseUpdatedAt:
                existing.character.updatedAt ?? existing.baseUpdatedAt,
            status: OfflineCharacterChangeStatus.pending,
          ),
        );
      });
    } finally {
      stmt.dispose();
      deleteChanges.dispose();
    }
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
    for (final note in character.notes ?? const <CharacterNoteData>[]) {
      logCharacterSyncLifecycle(
        stage: 'sqlite-canonical-clean',
        characterId: serverId,
        noteId: note.id,
        noteText: note.text,
        serverVersion: character.version,
        localVersion: character.version,
        baseVersion: character.version,
        status: OfflineCharacterSyncStatus.clean.name,
      );
    }
  }

  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  ) async {
    final serverId = serverCharacter.id;
    if (serverId == null) return;
    final localRecord = await getCharacter(userId, oldLocalId);
    if (localRecord != null && localRecord.localId == oldLocalId) {
      final now = DateTime.now().toUtc();
      final payload = jsonEncode(serverCharacter.toJson());
      _runTransaction(() {
        final deleteCanonical = _db.prepare('''
DELETE FROM characters_cache
WHERE user_id = ? AND server_id = ? AND local_id != ?
''');
        try {
          deleteCanonical.execute([userId, serverId, oldLocalId]);
        } finally {
          deleteCanonical.dispose();
        }

        final updateLocal = _db.prepare('''
UPDATE characters_cache
SET server_id = ?, payload_json = ?, base_payload_json = ?, base_version = ?,
    base_updated_at = ?, sync_status = ?, sync_operation = NULL,
    local_updated_at = ?, server_updated_at = ?, last_sync_error = NULL,
    conflict_payload_json = NULL
WHERE user_id = ? AND local_id = ?
''');
        try {
          updateLocal.execute([
            serverId,
            payload,
            payload,
            serverCharacter.version,
            serverCharacter.updatedAt?.toUtc().toIso8601String(),
            OfflineCharacterSyncStatus.clean.name,
            now.toIso8601String(),
            serverCharacter.updatedAt?.toUtc().toIso8601String() ??
                now.toIso8601String(),
            userId,
            oldLocalId,
          ]);
        } finally {
          updateLocal.dispose();
        }
      });
      return;
    }

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
