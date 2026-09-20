part of '../character_data_endpoint.dart';

typedef _CharacterMutationBody<T> = Future<T> Function(Transaction transaction);

Future<T> _runCharacterMutationTransaction<T>(
  Session session,
  _CharacterMutationBody<T> body,
) async {
  // ignore: invalid_use_of_visible_for_testing_member
  final existingTransaction = session.transaction;
  if (existingTransaction != null) {
    final savepoint = await existingTransaction.createSavepoint();
    try {
      final result = await body(existingTransaction);
      await savepoint.release();
      return result;
    } catch (_) {
      await savepoint.rollback();
      rethrow;
    }
  }
  return session.db.transaction(body);
}

Future<CharacterData> _saveCharacterSnapshotInTransaction(
  Session session, {
  required CharacterData character,
  required int userId,
  required Transaction transaction,
  int? expectedVersion,
  bool requireExistingWhenIdPresent = false,
  String? syncChangeId,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  CharacterRecord? existingRecord;
  final characterId = character.id;
  if (characterId != null && characterId >= 0) {
    existingRecord = await _lockOwnedCharacterRecord(
      session,
      characterId: characterId,
      userId: userId,
      transaction: transaction,
    );
    if (existingRecord == null) {
      final existingById = await CharacterRecord.db.find(
        session,
        where: (t) => t.id.equals(characterId),
        limit: 1,
        transaction: transaction,
      );
      if (existingById.isNotEmpty) {
        throw Exception('Access denied to character id=$characterId.');
      }
      if (requireExistingWhenIdPresent) {
        throw const _SnapshotNotFound();
      }
    }
  }

  if (existingRecord == null) {
    await CharacterQuotaValidator.validateCanCreateCharacter(
      session,
      userId: userId,
      transaction: transaction,
    );
  } else if (expectedVersion != null &&
      existingRecord.version != expectedVersion) {
    throw _SnapshotVersionConflict(existingRecord);
  }

  CharacterSaveRateLimiter.instance.consume(
    userId: userId,
    characterId: existingRecord?.id,
  );
  final currentCharacter = existingRecord == null
      ? null
      : await _buildCharacterAggregate(
          session,
          existingRecord,
          transaction: transaction,
          resolveContext: context,
        );
  if (currentCharacter == null) {
    CharacterValidator.validate(character);
  } else {
    _validateSyncSnapshotChanges(
      current: currentCharacter,
      next: character,
    );
  }

  var normalizedCharacter = character.copyWith(
    id: existingRecord?.id,
    syncTargetRevisions: null,
    syncBarrierTokens: currentCharacter?.syncBarrierTokens,
    featureOverrides: await _pruneFeatureOverrides(
      session,
      character,
      transaction: transaction,
      resolveContext: context,
    ),
    resourceStates: await _pruneResourceStates(
      session,
      character,
      transaction: transaction,
      resolveContext: context,
    ),
  );
  if (_serverSnapshotIsNewer(existingRecord, normalizedCharacter)) {
    return _buildCharacterAggregate(
      session,
      existingRecord!,
      transaction: transaction,
      resolveContext: context,
    );
  }
  normalizedCharacter = normalizedCharacter.copyWith(version: null);

  normalizedCharacter = _normalizeIncomingCharacter(
    normalizedCharacter,
    fallbackUpdatedAt:
        normalizedCharacter.updatedAt ?? existingRecord?.updatedAt,
  );
  if (existingRecord == null && character.id == null) {
    normalizedCharacter = await _applyInitialEquipmentSnapshot(
      session,
      normalizedCharacter,
      transaction: transaction,
      resolveContext: context,
    );
  }

  final currentVersion = existingRecord?.version ?? currentCharacter?.version;
  final nextVersion = existingRecord == null ? 1 : (currentVersion ?? 0) + 1;
  final targetRevisions = existingRecord == null
      ? _materializedSyncTargetRevisions(
          normalizedCharacter,
          nextVersion,
        )
      : _materializedSyncTargetRevisions(
          currentCharacter!,
          currentVersion ?? 0,
        );
  final barrierTokens = <String, String>{
    ...?currentCharacter?.syncBarrierTokens,
  };
  if (existingRecord != null) {
    final changedTargets = _changedSyncTargetKeys(
      currentCharacter!,
      normalizedCharacter,
    );
    if (changedTargets.isEmpty) {
      return currentCharacter.copyWith(syncTargetRevisions: targetRevisions);
    }
    for (final targetKey in changedTargets) {
      targetRevisions[targetKey] = nextVersion;
      if (_isSemanticBarrierTarget(targetKey)) {
        barrierTokens[targetKey] = syncChangeId ?? 'snapshot:$nextVersion';
      }
    }
  }

  final stampedCharacter = normalizedCharacter.copyWith(
    id: existingRecord?.id,
    version: nextVersion,
    createdAt: existingRecord?.createdAt ?? normalizedCharacter.createdAt,
    syncTargetRevisions: targetRevisions,
    syncBarrierTokens: barrierTokens.isEmpty ? null : barrierTokens,
  );
  final savedRecord = await _upsertCharacterRecord(
    session,
    stampedCharacter,
    userId,
    transaction: transaction,
    exactVersion: nextVersion,
    lockedExistingRecord: existingRecord,
    syncTargetRevisions: targetRevisions,
  );
  await _upsertCharacterRelations(
    session,
    savedRecord,
    stampedCharacter,
    transaction: transaction,
  );

  final hydratedRecord = await _requireOwnedCharacterRecord(
    session,
    savedRecord.id!,
    userId: userId,
    transaction: transaction,
  );
  final savedCharacter = await _buildCharacterAggregate(
    session,
    hydratedRecord,
    transaction: transaction,
    resolveContext: context,
  );
  if (existingRecord != null) {
    await _recordCharacterSyncEvent(
      session,
      userId: userId,
      characterId: savedCharacter.id!,
      characterVersion: savedCharacter.version,
      eventType: _characterSyncEventUpdated,
      changeId: syncChangeId,
      transaction: transaction,
    );
    return savedCharacter;
  }

  final initialTargetRevisions = _materializedSyncTargetRevisions(
    savedCharacter,
    savedCharacter.version ?? 1,
  );
  final targetRecord =
      hydratedRecord.copyWith(syncTargetRevisions: initialTargetRevisions);
  await CharacterRecord.db.updateRow(
    session,
    targetRecord,
    columns: (t) => [t.syncTargetRevisions],
    transaction: transaction,
  );
  final created = await _buildCharacterAggregate(
    session,
    targetRecord,
    transaction: transaction,
    resolveContext: context,
  );
  await _recordCharacterSyncEvent(
    session,
    userId: userId,
    characterId: created.id!,
    characterVersion: created.version,
    eventType: _characterSyncEventCreated,
    changeId: syncChangeId,
    transaction: transaction,
  );
  return created;
}

class _SnapshotVersionConflict implements Exception {
  const _SnapshotVersionConflict(this.record);

  final CharacterRecord record;
}

class _SnapshotNotFound implements Exception {
  const _SnapshotNotFound();
}

Future<void> _deleteCharacterInTransaction(
  Session session,
  int id, {
  required Transaction transaction,
}) async {
  await _deleteStartingEquipmentRecords(
    session,
    id,
    transaction: transaction,
  );
  await CharacterSkillSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.characterId.equals(id),
    transaction: transaction,
  );
  await CharacterSpellSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.characterId.equals(id),
    transaction: transaction,
  );
  await CharacterChoiceRecord.db.deleteWhere(
    session,
    where: (t) => t.characterId.equals(id),
    transaction: transaction,
  );
  await CharacterClassEntryRecord.db.deleteWhere(
    session,
    where: (t) => t.characterId.equals(id),
    transaction: transaction,
  );
  await CharacterRecord.db.deleteWhere(
    session,
    where: (t) => t.id.equals(id),
    transaction: transaction,
  );
}
