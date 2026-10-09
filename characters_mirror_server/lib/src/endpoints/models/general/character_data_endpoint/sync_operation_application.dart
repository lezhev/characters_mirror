part of '../character_data_endpoint.dart';

Future<CharacterSyncResponse> _syncCharacterOperations(
  Session session, {
  required int userId,
  required CharacterSyncRequest request,
  required _CharacterResolveContext resolveContext,
}) async {
  final acknowledgedChangeIds = <String>[];
  final rejectedChanges = <CharacterRejectedChangeData>[];
  final changedCharacters = <String, CharacterData>{};

  for (final operation
      in request.operations ?? const <CharacterSyncOperationData>[]) {
    _logServerNoteSync(session, stage: 'request', operation: operation);
    final minimumProtocolVersion =
        _minimumProtocolVersionForOperation(operation);
    if (minimumProtocolVersion > 0 &&
        (request.syncProtocolVersion ?? 0) < minimumProtocolVersion) {
      rejectedChanges.add(
        CharacterRejectedChangeData(
          changeId: operation.id,
          reason: 'unsupported_sync_protocol',
          message: 'Operation requires sync protocol version '
              '$minimumProtocolVersion or newer.',
        ),
      );
      _logServerNoteSync(
        session,
        stage: 'rejection',
        operation: operation,
        reason: 'unsupported_sync_protocol',
      );
      continue;
    }
    try {
      final result = await _applySyncOperationAtomically(
        session,
        userId: userId,
        operation: operation,
        resolveContext: resolveContext,
      );
      if (result.rejection != null) {
        rejectedChanges.add(result.rejection!);
        _logServerNoteSync(
          session,
          stage: 'rejection',
          operation: operation,
          character: result.rejection!.character,
          reason: result.rejection!.reason ?? result.rejection!.message,
        );
        continue;
      }
      acknowledgedChangeIds.add(operation.id);
      _logServerNoteSync(
        session,
        stage: 'ack',
        operation: operation,
        character: result.character,
      );
      if (result.character != null) {
        changedCharacters[operation.id] = result.character!;
      }
    } catch (error) {
      rejectedChanges.add(
        CharacterRejectedChangeData(
          changeId: operation.id,
          reason: 'invalid_operation',
          message: error.toString(),
        ),
      );
      _logServerNoteSync(
        session,
        stage: 'rejection',
        operation: operation,
        reason: 'invalid_operation:${error.runtimeType}',
      );
    }
  }

  final pullDelta = request.fullResync == true
      ? await _loadAuthoritativeCharacterFullResync(
          session,
          userId: userId,
          resolveContext: resolveContext,
        )
      : await _loadCharacterSyncDelta(
          session,
          userId: userId,
          pullAfterEventId: request.pullAfterEventId,
          pullSince: request.pullSince,
          resolveContext: resolveContext,
        );
  final charactersById = <int, CharacterData>{
    for (final character in changedCharacters.values)
      if (character.id != null) character.id!: character,
    for (final character in pullDelta.characters)
      if (character.id != null) character.id!: character,
  };

  return CharacterSyncResponse(
    acknowledgedChangeIds: acknowledgedChangeIds,
    rejectedChanges: rejectedChanges,
    characters: charactersById.values.toList(),
    changedCharacters: changedCharacters,
    serverTime: DateTime.now().toUtc(),
    pullCursor: pullDelta.cursor,
    deletedCharacterIds: pullDelta.deletedCharacterIds,
    syncProtocolVersion: _characterSyncProtocolVersion,
    capabilities: _characterSyncCapabilities,
  );
}

void _logServerNoteSync(
  Session session, {
  required String stage,
  required CharacterSyncOperationData operation,
  CharacterData? character,
  String? reason,
}) {
  if (session.server.runMode == ServerpodRunMode.production ||
      operation.fieldPath != 'notes') {
    return;
  }
  final operationNote = operation.itemPayload?.noteValue;
  final canonicalNote = character?.notes
      ?.where((note) => note.id == operation.targetId)
      .firstOrNull;
  final text = canonicalNote?.text ?? operationNote?.text;
  final fields = <String>[
    'stage=$stage',
    if (operation.characterId != null) 'characterId=${operation.characterId}',
    if (operation.targetId != null) 'noteId=${operation.targetId}',
    if (text != null) ...[
      'noteHash=${_syncTextHash(text)}',
      'noteLength=${text.length}',
    ],
    'changeId=${operation.id}',
    'operation=${operation.type.name}',
    if (character?.version != null) 'serverVersion=${character!.version}',
    if (operation.baseCharacterRevision != null)
      'baseVersion=${operation.baseCharacterRevision}',
    if (reason != null) 'reason=$reason',
  ];
  session.log('[character-sync] ${fields.join(' ')}');
}

String _syncTextHash(String value) {
  var hash = 0x811c9dc5;
  for (final codeUnit in value.codeUnits) {
    hash ^= codeUnit;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}

bool _isMemberOperation(CharacterSyncOperationData operation) {
  return operation.type == CharacterSyncOperationType.addSetMember ||
      operation.type == CharacterSyncOperationType.removeSetMember ||
      operation.type == CharacterSyncOperationType.setMemberValue;
}

Future<CharacterAppliedChangeRecord?> _findAppliedChange(
  Session session,
  int userId,
  String changeId, {
  Transaction? transaction,
}) async {
  final rows = await CharacterAppliedChangeRecord.db.find(
    session,
    where: (t) => t.userId.equals(userId) & t.changeId.equals(changeId),
    limit: 1,
    transaction: transaction,
  );
  return rows.isEmpty ? null : rows.first;
}

Future<void> _recordAppliedChange(
  Session session,
  int userId,
  String changeId,
  CharacterData? character, {
  required Transaction transaction,
}) async {
  await CharacterAppliedChangeRecord.db.insertRow(
    session,
    CharacterAppliedChangeRecord(
      userId: userId,
      changeId: changeId,
      characterId: character?.id,
      revision: character?.version,
      createdAt: DateTime.now().toUtc(),
    ),
    transaction: transaction,
  );
}

Future<_OperationApplyResult> _applySyncOperationAtomically(
  Session session, {
  required int userId,
  required CharacterSyncOperationData operation,
  required _CharacterResolveContext resolveContext,
}) async {
  // Transaction boundary: idempotency, row lock, canonical mutation,
  // target revisions, and the applied-change record must commit or roll back
  // together. Do not move any write in this call path outside this transaction.
  return _runCharacterMutationTransaction(
    session,
    (transaction) async {
      await _lockOperationChangeId(
        session,
        userId: userId,
        changeId: operation.id,
        transaction: transaction,
      );
      final applied = await _findAppliedChange(
        session,
        userId,
        operation.id,
        transaction: transaction,
      );
      if (applied != null) {
        return _appliedChangeResult(
          session,
          userId: userId,
          operation: operation,
          applied: applied,
          transaction: transaction,
          resolveContext: resolveContext,
        );
      }

      final result = switch (operation.type) {
        CharacterSyncOperationType.createCharacter => _OperationApplyResult(
            character: await _applyCreateCharacterOperation(
              session,
              userId: userId,
              operation: operation,
              transaction: transaction,
              resolveContext: resolveContext,
            ),
          ),
        CharacterSyncOperationType.deleteCharacter =>
          await _applyDeleteCharacterOperation(
            session,
            userId: userId,
            operation: operation,
            transaction: transaction,
            resolveContext: resolveContext,
          ),
        CharacterSyncOperationType.setField ||
        CharacterSyncOperationType.setMapEntry ||
        CharacterSyncOperationType.removeMapEntry ||
        CharacterSyncOperationType.upsertListItem ||
        CharacterSyncOperationType.removeListItem ||
        CharacterSyncOperationType.addSetMember ||
        CharacterSyncOperationType.removeSetMember ||
        CharacterSyncOperationType.setMemberValue ||
        CharacterSyncOperationType.applyDamage ||
        CharacterSyncOperationType.heal ||
        CharacterSyncOperationType.grantTemporaryHp ||
        CharacterSyncOperationType.adjustSpellSlots ||
        CharacterSyncOperationType.castSpell ||
        CharacterSyncOperationType.adjustHitDice ||
        CharacterSyncOperationType.adjustResource ||
        CharacterSyncOperationType.adjustExperience ||
        CharacterSyncOperationType.recoverSpellSlots ||
        CharacterSyncOperationType.applyRest =>
          await _applyUpdateCharacterOperation(
            session,
            userId: userId,
            operation: operation,
            transaction: transaction,
            resolveContext: resolveContext,
          ),
      };

      if (result.rejection == null) {
        await _recordAppliedChange(
          session,
          userId,
          operation.id,
          result.character,
          transaction: transaction,
        );
      }
      return result;
    },
    userId: userId,
  );
}

Future<void> _lockOperationChangeId(
  Session session, {
  required int userId,
  required String changeId,
  required Transaction transaction,
}) async {
  await session.db.unsafeQuery(
    'SELECT pg_advisory_xact_lock(hashtext(@lockKey)::bigint)',
    transaction: transaction,
    parameters: QueryParameters.named({
      'lockKey': '$userId:$changeId',
    }),
  );
}

Future<_OperationApplyResult> _appliedChangeResult(
  Session session, {
  required int userId,
  required CharacterSyncOperationData operation,
  required CharacterAppliedChangeRecord applied,
  required Transaction transaction,
  required _CharacterResolveContext resolveContext,
}) async {
  final characterId = applied.characterId ?? operation.characterId;
  if (characterId == null || characterId < 0) {
    return const _OperationApplyResult();
  }
  final record = await _findOwnedCharacterRecord(
    session,
    characterId,
    userId,
    transaction: transaction,
  );
  if (record == null) {
    return const _OperationApplyResult();
  }
  return _OperationApplyResult(
    character: await _buildCharacterAggregate(
      session,
      record,
      transaction: transaction,
      resolveContext: resolveContext,
    ),
  );
}

Future<CharacterData> _applyCreateCharacterOperation(
  Session session, {
  required int userId,
  required CharacterSyncOperationData operation,
  required Transaction transaction,
  required _CharacterResolveContext resolveContext,
}) async {
  final payload =
      operation.itemPayload?.characterValue ?? operation.value?.characterValue;
  if (payload == null) {
    throw Exception('Create operation requires character payload.');
  }
  return _saveCharacterSnapshotInTransaction(
    session,
    character: payload.copyWith(id: null, version: null),
    userId: userId,
    transaction: transaction,
    syncChangeId: operation.id,
    resolveContext: resolveContext,
  );
}

Future<_OperationApplyResult> _applyDeleteCharacterOperation(
  Session session, {
  required int userId,
  required CharacterSyncOperationData operation,
  required Transaction transaction,
  required _CharacterResolveContext resolveContext,
}) async {
  final characterId = operation.characterId;
  if (characterId == null || characterId < 0) {
    return const _OperationApplyResult();
  }
  final record = await _lockOwnedCharacterRecord(
    session,
    characterId: characterId,
    userId: userId,
    transaction: transaction,
  );
  if (record == null) {
    return const _OperationApplyResult();
  }
  final baseRevision = operation.baseCharacterRevision;
  if (baseRevision != null && (record.version ?? 0) > baseRevision) {
    return _OperationApplyResult(
      rejection: CharacterRejectedChangeData(
        changeId: operation.id,
        reason: 'stale_delete',
        message: 'Stored character is newer than the delete base.',
        character: await _buildCharacterAggregate(
          session,
          record,
          transaction: transaction,
          resolveContext: resolveContext,
        ),
      ),
    );
  }
  CharacterSaveRateLimiter.instance.consume(
    userId: userId,
    characterId: record.id,
  );
  await _deleteCharacterInTransaction(
    session,
    characterId,
    transaction: transaction,
  );
  await _recordCharacterSyncEvent(
    session,
    userId: userId,
    characterId: characterId,
    characterVersion: record.version,
    eventType: _characterSyncEventDeleted,
    changeId: operation.id,
    transaction: transaction,
  );
  return const _OperationApplyResult();
}

Future<_OperationApplyResult> _applyUpdateCharacterOperation(
  Session session, {
  required int userId,
  required CharacterSyncOperationData operation,
  required Transaction transaction,
  required _CharacterResolveContext resolveContext,
}) async {
  final characterId = operation.characterId;
  if (characterId == null || characterId < 0) {
    return _OperationApplyResult(
      rejection: CharacterRejectedChangeData(
        changeId: operation.id,
        reason: 'missing_character_id',
        message: 'Update operation requires an existing server character id.',
      ),
    );
  }

  final record = await _lockOwnedCharacterRecord(
    session,
    characterId: characterId,
    userId: userId,
    transaction: transaction,
  );
  if (record == null) {
    return _OperationApplyResult(
      rejection: CharacterRejectedChangeData(
        changeId: operation.id,
        reason: 'not_found',
        message: 'Character was not found for this user.',
      ),
    );
  }

  final current = await _buildCharacterAggregate(
    session,
    record,
    transaction: transaction,
    resolveContext: resolveContext,
  );
  final baselineRevision = record.version ?? current.version ?? 0;
  final targetRevisions =
      _materializedSyncTargetRevisions(current, baselineRevision);
  final targetKey = _targetKeyForOperation(operation, current);
  final currentTargetRevision = _currentTargetRevisionForOperation(
    operation,
    current,
    targetRevisions,
    targetKey,
    baselineRevision,
  );
  final baseTargetRevision =
      operation.baseTargetRevision ?? operation.baseCharacterRevision ?? 0;
  if (_isSemanticOperation(operation)) {
    final failure = _semanticBarrierFailure(current, operation);
    if (failure != null) {
      return _OperationApplyResult(
        rejection: CharacterRejectedChangeData(
          changeId: operation.id,
          reason: failure.reason,
          message: failure.message,
          character: current.copyWith(syncTargetRevisions: targetRevisions),
        ),
      );
    }
  } else if (currentTargetRevision != baseTargetRevision) {
    if (_memberOperationAlreadySatisfied(operation, current)) {
      return _OperationApplyResult(
        character: current.copyWith(syncTargetRevisions: targetRevisions),
      );
    }
    return _OperationApplyResult(
      rejection: CharacterRejectedChangeData(
        changeId: operation.id,
        reason: 'target_conflict',
        message: 'Stored character target has changed.',
        character: current.copyWith(syncTargetRevisions: targetRevisions),
      ),
    );
  }

  final nextRevision = baselineRevision + 1;
  CharacterData appliedCharacter;
  try {
    appliedCharacter = _applyOperationToCharacter(current, operation);
    appliedCharacter =
        await CharacterEquipmentSelectionValidator.normalizeAndValidate(
      session,
      appliedCharacter,
      transaction: transaction,
    );
  } on _SemanticActionFailure catch (failure) {
    return _OperationApplyResult(
      rejection: CharacterRejectedChangeData(
        changeId: operation.id,
        reason: failure.reason,
        message: failure.message,
        character: current.copyWith(syncTargetRevisions: targetRevisions),
      ),
    );
  }
  var next = appliedCharacter.copyWith(
    id: characterId,
    version: nextRevision,
    createdAt: record.createdAt,
    updatedAt: DateTime.now().toUtc(),
    syncTargetRevisions: targetRevisions,
    syncBarrierTokens: current.syncBarrierTokens,
  );
  _validateSyncOperationResult(
    operation: operation,
    current: current,
    next: next,
  );
  next = _normalizeIncomingCharacter(
    next.copyWith(
      featureOverrides: await _pruneFeatureOverrides(
        session,
        next,
        transaction: transaction,
        resolveContext: resolveContext,
      ),
      resourceStates: await _pruneResourceStates(
        session,
        next,
        transaction: transaction,
        resolveContext: resolveContext,
      ),
    ),
    fallbackUpdatedAt: next.updatedAt,
  ).copyWith(
    id: characterId,
    version: nextRevision,
    createdAt: record.createdAt,
    updatedAt: next.updatedAt,
    syncTargetRevisions: targetRevisions,
  );
  final changedTargets = _changedSyncTargetKeys(current, next);
  next = await _preserveChoiceReplacementHistory(session, current, next,
      transaction: transaction);
  await _validateSpellSelectionFilters(session, next, transaction: transaction);
  for (final changedTarget in changedTargets) {
    targetRevisions[changedTarget] = nextRevision;
  }
  _updateCompatibilityTargetRevisions(
    operation: operation,
    changedTargets: changedTargets,
    revisions: targetRevisions,
    nextRevision: nextRevision,
  );
  next = next.copyWith(
    syncTargetRevisions: targetRevisions,
    syncBarrierTokens: _barrierTokensAfterOperation(
      current: current,
      operation: operation,
      changedTargets: changedTargets,
    ),
  );
  final savedRecord = await _upsertCharacterRecord(
    session,
    next,
    userId,
    transaction: transaction,
    exactVersion: nextRevision,
    lockedExistingRecord: record,
    syncTargetRevisions: targetRevisions,
  );
  await _upsertCharacterRelations(
    session,
    savedRecord,
    next,
    transaction: transaction,
  );
  final hydratedRecord = await _requireOwnedCharacterRecord(
    session,
    savedRecord.id!,
    userId: userId,
    transaction: transaction,
  );
  final saved = await _buildCharacterAggregate(
    session,
    hydratedRecord,
    transaction: transaction,
    resolveContext: resolveContext,
  );
  await _recordCharacterSyncEvent(
    session,
    userId: userId,
    characterId: saved.id!,
    characterVersion: saved.version,
    eventType: _characterSyncEventUpdated,
    changeId: operation.id,
    transaction: transaction,
  );
  return _OperationApplyResult(character: saved);
}

CharacterData _applyOperationToCharacter(
  CharacterData character,
  CharacterSyncOperationData operation,
) {
  if (_isSemanticOperation(operation)) {
    return _applySemanticActionToCharacter(character, operation);
  }
  final json = character.toJson();
  json.remove('derived');
  switch (operation.type) {
    case CharacterSyncOperationType.setField:
      _setJsonValue(json, operation.fieldPath, operation.value);
      break;
    case CharacterSyncOperationType.setMapEntry:
      _setMapEntryJsonValue(
          json, operation.fieldPath, operation.targetId, operation.value);
      break;
    case CharacterSyncOperationType.removeMapEntry:
      _removeMapEntryJsonValue(json, operation.fieldPath, operation.targetId);
      break;
    case CharacterSyncOperationType.upsertListItem:
      _upsertListItemJsonValue(json, operation);
      break;
    case CharacterSyncOperationType.removeListItem:
      _removeListItemJsonValue(json, operation);
      break;
    case CharacterSyncOperationType.addSetMember:
    case CharacterSyncOperationType.removeSetMember:
    case CharacterSyncOperationType.setMemberValue:
      _applyMemberJsonValue(json, operation);
      break;
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
    case CharacterSyncOperationType.applyDamage:
    case CharacterSyncOperationType.heal:
    case CharacterSyncOperationType.grantTemporaryHp:
    case CharacterSyncOperationType.adjustSpellSlots:
    case CharacterSyncOperationType.castSpell:
    case CharacterSyncOperationType.adjustHitDice:
    case CharacterSyncOperationType.adjustResource:
    case CharacterSyncOperationType.adjustExperience:
    case CharacterSyncOperationType.recoverSpellSlots:
    case CharacterSyncOperationType.applyRest:
      break;
  }
  return CharacterData.fromJson(json);
}

int _currentTargetRevisionForOperation(
  CharacterSyncOperationData operation,
  CharacterData current,
  Map<String, int> revisions,
  String targetKey,
  int baselineRevision,
) {
  final direct = revisions[targetKey];
  if (_isMemberOperation(operation)) {
    if (direct != null) return direct;
    final field = operation.fieldPath ?? '';
    return revisions[_memberBaselineTargetKey(field)] ??
        _legacyMemberRevision(operation, revisions) ??
        baselineRevision;
  }
  if (operation.fieldPath == 'featureOverrides') {
    return _maximumRevision(
          revisions,
          <String>[
            targetKey,
            _fieldTargetKey('featureOverrides'),
            ...revisions.keys
                .where((key) => key.startsWith('featureOverride:')),
          ],
        ) ??
        baselineRevision;
  }
  if (operation.fieldPath == 'startingEquipmentSelections') {
    final semanticKey = _semanticStartingEquipmentTargetKey(
      operation,
      current,
    );
    final legacyKey = _legacyStartingEquipmentTargetKey(operation);
    return _maximumRevision(
          revisions,
          [
            targetKey,
            if (semanticKey != null) semanticKey,
            if (legacyKey != null) legacyKey,
          ],
        ) ??
        baselineRevision;
  }
  return direct ?? baselineRevision;
}

bool _memberOperationAlreadySatisfied(
  CharacterSyncOperationData operation,
  CharacterData current,
) {
  if (!_isMemberOperation(operation)) return false;
  switch (operation.fieldPath) {
    case 'activeConditions':
      final condition = ConditionType.values
          .where((value) => value.name == operation.targetId)
          .firstOrNull;
      if (condition == null || condition == ConditionType.exhaustion) {
        return false;
      }
      return _setMembershipOperationSatisfied(
        operation,
        current.activeConditions?.contains(condition) ?? false,
      );
    case 'preparedSpellKeys':
      final member = _normalizedTextOrNull(operation.targetId);
      if (member == null) return false;
      return _setMembershipOperationSatisfied(
        operation,
        _normalizedPreparedSpellKeys(current.preparedSpellKeys)
                ?.contains(member) ??
            false,
      );
    case 'manualSkillProficiencyOverrides':
      if (operation.type != CharacterSyncOperationType.setMemberValue) {
        return false;
      }
      final target = operation.targetId;
      final currentValue = current.manualSkillProficiencyOverrides
          ?.where((value) => value.skill.name == target)
          .firstOrNull;
      return _syncJsonEquals(
        currentValue,
        operation.value?.skillProficiencyValue,
      );
    case 'manualSavingThrowProficiencyOverrides':
      if (operation.type != CharacterSyncOperationType.setMemberValue) {
        return false;
      }
      final target = operation.targetId;
      final currentValue = current.manualSavingThrowProficiencyOverrides
          ?.where((value) => value.ability.name == target)
          .firstOrNull;
      return _syncJsonEquals(
        currentValue,
        operation.value?.savingThrowProficiencyOverrideValue,
      );
    case 'featureOverrides':
      return _featureOverrideMemberOperationAlreadySatisfied(
        operation,
        current,
      );
  }
  return false;
}

bool _setMembershipOperationSatisfied(
  CharacterSyncOperationData operation,
  bool contains,
) {
  return switch (operation.type) {
    CharacterSyncOperationType.addSetMember => contains,
    CharacterSyncOperationType.removeSetMember => !contains,
    _ => false,
  };
}

bool _featureOverrideMemberOperationAlreadySatisfied(
  CharacterSyncOperationData operation,
  CharacterData current,
) {
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (parts.length != 3 && parts.length != 4) return false;
  final sourceType = CharacterFeatureSourceType.values
      .where((value) => value.name == parts[0])
      .firstOrNull;
  final sourceId = int.tryParse(parts[1]);
  if (sourceType == null || sourceId == null) return false;
  final item = current.featureOverrides
      ?.where(
        (value) => value.sourceType == sourceType && value.sourceId == sourceId,
      )
      .firstOrNull;
  if (parts.length == 3 &&
      operation.type == CharacterSyncOperationType.setMemberValue) {
    if (parts[2] == 'name') {
      return item?.name == operation.value?.stringValue;
    }
    if (parts[2] == 'description') {
      return item?.description == operation.value?.stringValue;
    }
    return false;
  }
  if (parts.length == 4 && parts[2] == 'tag') {
    final tag =
        FeatureTag.values.where((value) => value.name == parts[3]).firstOrNull;
    if (tag == null) return false;
    return _setMembershipOperationSatisfied(
      operation,
      item?.tags?.contains(tag) ?? false,
    );
  }
  return false;
}

int? _legacyMemberRevision(
  CharacterSyncOperationData operation,
  Map<String, int> revisions,
) {
  final field = operation.fieldPath ?? '';
  final legacyField = switch (field) {
    'manualSkillProficiencyOverrides' => 'manualSkillProficiencies',
    'manualSavingThrowProficiencyOverrides' => 'manualSavingThrowProficiencies',
    _ => field,
  };
  if (field == 'featureOverrides') {
    return _maximumRevision(
      revisions,
      revisions.keys.where((key) => key.startsWith('item:featureOverrides:')),
    );
  }
  return revisions[_fieldTargetKey(legacyField)];
}

String? _semanticStartingEquipmentTargetKey(
  CharacterSyncOperationData operation,
  CharacterData current,
) {
  if (operation.targetType ==
      CharacterSyncTargetType.startingEquipmentResolution) {
    final parts = _decodeCompositeTargetId(operation.targetId);
    if (parts.length != 2) return null;
    final selection = _findStartingEquipmentSelection(
      current,
      parts[0],
    );
    if (selection == null) return null;
    final lineId = operation
            .itemPayload?.startingEquipmentResolutionValue?.sourceLineEntryId
            ?.toString() ??
        _findStartingEquipmentResolution(selection, parts[1])
            ?.sourceLineEntryId
            ?.toString();
    if (lineId == null) return null;
    return _startingEquipmentResolutionTargetKey(
      _startingEquipmentSelectionTargetId(selection),
      lineId,
    );
  }
  final selection = _findStartingEquipmentSelection(
    current,
    operation.targetId ?? '',
  );
  if (selection == null) return null;
  return _itemTargetKey(
    'startingEquipmentSelections',
    _startingEquipmentSelectionTargetId(selection),
  );
}

String? _legacyStartingEquipmentTargetKey(
  CharacterSyncOperationData operation,
) {
  if (operation.targetType !=
      CharacterSyncTargetType.startingEquipmentResolution) {
    return null;
  }
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (parts.length != 2) return null;
  return _legacyStartingEquipmentResolutionTargetKey(parts[0], parts[1]);
}

void _updateCompatibilityTargetRevisions({
  required CharacterSyncOperationData operation,
  required Set<String> changedTargets,
  required Map<String, int> revisions,
  required int nextRevision,
}) {
  for (final field in const [
    'activeConditions',
    'preparedSpellKeys',
    'manualSkillProficiencyOverrides',
    'manualSavingThrowProficiencyOverrides',
  ]) {
    final prefix = _syncTargetKey('member', [field, '']);
    if (changedTargets.any((target) => target.startsWith(prefix))) {
      final legacyField = switch (field) {
        'manualSkillProficiencyOverrides' => 'manualSkillProficiencies',
        'manualSavingThrowProficiencyOverrides' =>
          'manualSavingThrowProficiencies',
        _ => field,
      };
      revisions[_fieldTargetKey(legacyField)] = nextRevision;
    }
  }
  if (changedTargets.any((target) => target.startsWith('featureOverride:'))) {
    revisions[_fieldTargetKey('featureOverrides')] = nextRevision;
  }
  if (operation.type == CharacterSyncOperationType.setField) {
    final fineField = switch (operation.fieldPath) {
      'manualSkillProficiencies' => 'manualSkillProficiencyOverrides',
      'manualSavingThrowProficiencies' =>
        'manualSavingThrowProficiencyOverrides',
      'activeConditions' => 'activeConditions',
      'preparedSpellKeys' => 'preparedSpellKeys',
      _ => null,
    };
    if (fineField != null) {
      revisions[_memberBaselineTargetKey(fineField)] = nextRevision;
    }
  }
}

void _applyMemberJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  switch (operation.fieldPath) {
    case 'activeConditions':
      _applyConditionMember(json, operation);
      return;
    case 'preparedSpellKeys':
      _applyPreparedSpellMember(json, operation);
      return;
    case 'manualSkillProficiencyOverrides':
      _applySkillProficiencyMember(json, operation);
      return;
    case 'manualSavingThrowProficiencyOverrides':
      _applySavingThrowProficiencyMember(json, operation);
      return;
    case 'featureOverrides':
      _applyFeatureOverrideMember(json, operation);
      return;
  }
  throw Exception('Unsupported member field "${operation.fieldPath}".');
}

void _applyConditionMember(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final condition = ConditionType.values.firstWhere(
    (value) => value.name == operation.targetId,
    orElse: () => throw Exception('Unknown condition member.'),
  );
  if (condition == ConditionType.exhaustion) {
    throw Exception('Exhaustion is stored as exhaustionLevel.');
  }
  final values = <ConditionType>{
    for (final raw in json['activeConditions'] as List? ?? const [])
      ConditionType.fromJson(raw),
  };
  if (operation.type == CharacterSyncOperationType.addSetMember) {
    values.add(condition);
  } else if (operation.type == CharacterSyncOperationType.removeSetMember) {
    values.remove(condition);
  } else {
    throw Exception('Condition requires addSetMember or removeSetMember.');
  }
  final sorted = values.toList()..sort((a, b) => a.name.compareTo(b.name));
  json['activeConditions'] =
      sorted.isEmpty ? null : sorted.map((value) => value.toJson()).toList();
}

void _applyPreparedSpellMember(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final member = _normalizedTextOrNull(operation.targetId);
  if (member == null) throw Exception('Prepared spell key is required.');
  final values = {
    for (final raw in json['preparedSpellKeys'] as List? ?? const [])
      if (_normalizedTextOrNull(raw.toString()) != null)
        _normalizedTextOrNull(raw.toString())!,
  };
  if (operation.type == CharacterSyncOperationType.addSetMember) {
    values.add(member);
  } else if (operation.type == CharacterSyncOperationType.removeSetMember) {
    values.remove(member);
  } else {
    throw Exception('Prepared spell requires a set member operation.');
  }
  final sorted = values.toList()..sort();
  json['preparedSpellKeys'] = sorted.isEmpty ? null : sorted;
}

void _applySkillProficiencyMember(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  if (operation.type != CharacterSyncOperationType.setMemberValue) {
    throw Exception('Skill proficiency requires setMemberValue.');
  }
  final target = Skill.values.firstWhere(
    (value) => value.name == operation.targetId,
    orElse: () => throw Exception('Unknown skill member.'),
  );
  final values = _skillOverridesFromJson(json)
    ..removeWhere((value) => value.skill == target);
  final next = operation.value?.skillProficiencyValue;
  if (next != null) values.add(next.copyWith(skill: target));
  values.sort((a, b) => a.skill.name.compareTo(b.skill.name));
  json['manualSkillProficiencyOverrides'] = values.isEmpty
      ? <dynamic>[]
      : values.map((value) => value.toJson()).toList();
  if (json['manualSkillProficiencies'] != null) {
    json['manualSkillProficiencies'] =
        values.map((value) => value.toJson()).toList();
  }
}

List<CharacterSkillProficiencyState> _skillOverridesFromJson(
  Map<String, dynamic> json,
) {
  final rawOverrides = json['manualSkillProficiencyOverrides'] as List?;
  if (rawOverrides != null) {
    return [
      for (final raw in rawOverrides)
        CharacterSkillProficiencyState.fromJson(
          Map<String, dynamic>.from(raw as Map),
        ),
    ];
  }
  final legacy = <Skill, CharacterSkillProficiencyLevel>{};
  for (final raw
      in json['manualSkillProficiencies'] as List? ?? const <dynamic>[]) {
    final value = CharacterSkillProficiencyState.fromJson(
      Map<String, dynamic>.from(raw as Map),
    );
    legacy[value.skill] = value.level;
  }
  if (json['manualSkillProficiencies'] == null) return [];
  return [
    for (final skill in Skill.values)
      CharacterSkillProficiencyState(
        skill: skill,
        level: legacy[skill] ?? CharacterSkillProficiencyLevel.none,
      ),
  ];
}

void _applySavingThrowProficiencyMember(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  if (operation.type != CharacterSyncOperationType.setMemberValue) {
    throw Exception('Saving throw proficiency requires setMemberValue.');
  }
  final target = Ability.values.firstWhere(
    (value) => value.name == operation.targetId,
    orElse: () => throw Exception('Unknown ability member.'),
  );
  final values = _savingThrowOverridesFromJson(json)
    ..removeWhere((value) => value.ability == target);
  final next = operation.value?.savingThrowProficiencyOverrideValue;
  if (next != null) values.add(next.copyWith(ability: target));
  values.sort((a, b) => a.ability.name.compareTo(b.ability.name));
  json['manualSavingThrowProficiencyOverrides'] = values.isEmpty
      ? <dynamic>[]
      : values.map((value) => value.toJson()).toList();
  if (json['manualSavingThrowProficiencies'] != null) {
    json['manualSavingThrowProficiencies'] = [
      for (final value in values)
        if (value.state == CharacterSavingThrowProficiencyOverride.add)
          value.ability.toJson(),
    ];
  }
}

List<CharacterSavingThrowProficiencyOverrideData> _savingThrowOverridesFromJson(
    Map<String, dynamic> json) {
  final rawOverrides = json['manualSavingThrowProficiencyOverrides'] as List?;
  if (rawOverrides != null) {
    return [
      for (final raw in rawOverrides)
        CharacterSavingThrowProficiencyOverrideData.fromJson(
          Map<String, dynamic>.from(raw as Map),
        ),
    ];
  }
  final rawLegacy = json['manualSavingThrowProficiencies'] as List?;
  if (rawLegacy == null) return [];
  final legacy = {
    for (final raw in rawLegacy) Ability.fromJson(raw),
  };
  return [
    for (final ability in Ability.values)
      CharacterSavingThrowProficiencyOverrideData(
        ability: ability,
        state: legacy.contains(ability)
            ? CharacterSavingThrowProficiencyOverride.add
            : CharacterSavingThrowProficiencyOverride.remove,
      ),
  ];
}

void _applyFeatureOverrideMember(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (parts.length != 3 && parts.length != 4) {
    throw Exception('Invalid feature override member target.');
  }
  final sourceType = CharacterFeatureSourceType.values.firstWhere(
    (value) => value.name == parts[0],
    orElse: () => throw Exception('Unknown feature source type.'),
  );
  final sourceId = int.tryParse(parts[1]);
  if (sourceId == null) throw Exception('Invalid feature source id.');
  final values = <CharacterFeatureOverrideData>[
    for (final raw in json['featureOverrides'] as List? ?? const [])
      CharacterFeatureOverrideData.fromJson(
        Map<String, dynamic>.from(raw as Map),
      ),
  ];
  var index = values.indexWhere(
    (value) => value.sourceType == sourceType && value.sourceId == sourceId,
  );
  if (index == -1) {
    values.add(CharacterFeatureOverrideData(
      sourceType: sourceType,
      sourceId: sourceId,
    ));
    index = values.length - 1;
  }
  var item = values[index];
  if (parts.length == 3 && parts[2] == 'name') {
    item = item.copyWith(name: operation.value?.stringValue);
  } else if (parts.length == 3 && parts[2] == 'description') {
    item = item.copyWith(description: operation.value?.stringValue);
  } else if (parts.length == 4 && parts[2] == 'tag') {
    final tag = FeatureTag.values.firstWhere(
      (value) => value.name == parts[3],
      orElse: () => throw Exception('Unknown feature tag.'),
    );
    final tags = {...?item.tags};
    if (operation.type == CharacterSyncOperationType.addSetMember) {
      tags.add(tag);
    } else if (operation.type == CharacterSyncOperationType.removeSetMember) {
      tags.remove(tag);
    } else {
      throw Exception('Feature tag requires a set member operation.');
    }
    final sorted = tags.toList()..sort((a, b) => a.name.compareTo(b.name));
    item = item.copyWith(tags: sorted.isEmpty ? null : sorted);
  } else {
    throw Exception('Unsupported feature override member.');
  }
  values[index] = item;
  json['featureOverrides'] = values.map((value) => value.toJson()).toList();
}

void _setJsonValue(
  Map<String, dynamic> json,
  String? field,
  CharacterSyncValueData? value,
) {
  if (field == null || field.isEmpty) {
    throw Exception('Field operation requires fieldPath.');
  }
  final encoded = _encodedValueForField(field, value);
  if (encoded == null) {
    json.remove(field);
  } else {
    json[field] = encoded;
  }
  if (field == 'manualSkillProficiencies') {
    if (encoded == null) {
      json.remove('manualSkillProficiencyOverrides');
    } else {
      final legacy = <Skill, CharacterSkillProficiencyLevel>{};
      for (final raw in encoded as List) {
        final value = CharacterSkillProficiencyState.fromJson(
          Map<String, dynamic>.from(raw as Map),
        );
        legacy[value.skill] = value.level;
      }
      json['manualSkillProficiencyOverrides'] = [
        for (final skill in Skill.values)
          CharacterSkillProficiencyState(
            skill: skill,
            level: legacy[skill] ?? CharacterSkillProficiencyLevel.none,
          ).toJson(),
      ];
    }
  }
  if (field == 'manualSavingThrowProficiencies') {
    if (encoded == null) {
      json.remove('manualSavingThrowProficiencyOverrides');
    } else {
      final legacy = {
        for (final raw in encoded as List) Ability.fromJson(raw),
      };
      json['manualSavingThrowProficiencyOverrides'] = [
        for (final ability in Ability.values)
          CharacterSavingThrowProficiencyOverrideData(
            ability: ability,
            state: legacy.contains(ability)
                ? CharacterSavingThrowProficiencyOverride.add
                : CharacterSavingThrowProficiencyOverride.remove,
          ).toJson(),
      ];
    }
  }
}

void _setMapEntryJsonValue(
  Map<String, dynamic> json,
  String? field,
  String? key,
  CharacterSyncValueData? value,
) {
  if (field == null || key == null) {
    throw Exception('Map operation requires fieldPath and targetId.');
  }
  if (field == 'currentSpellSlots' || field == 'currentPactSlots') {
    final rawMap = _decodeIntKeyMap(json[field]);
    rawMap[int.parse(key)] = value?.intValue;
    json[field] = _encodeIntKeyMap(rawMap);
    return;
  }
  final rawMap = Map<String, dynamic>.from(json[field] as Map? ?? const {});
  final encoded = _encodedValueForField(field, value);
  rawMap[key] = encoded;
  json[field] = rawMap;
}

void _removeMapEntryJsonValue(
  Map<String, dynamic> json,
  String? field,
  String? key,
) {
  if (field == null || key == null) {
    throw Exception('Map operation requires fieldPath and targetId.');
  }
  if (field == 'currentSpellSlots' || field == 'currentPactSlots') {
    final rawMap = _decodeIntKeyMap(json[field]);
    rawMap.remove(int.parse(key));
    json[field] = rawMap.isEmpty ? null : _encodeIntKeyMap(rawMap);
    return;
  }
  final rawMap = Map<String, dynamic>.from(json[field] as Map? ?? const {});
  rawMap.remove(key);
  json[field] = rawMap.isEmpty ? null : rawMap;
}

Map<int, int?> _decodeIntKeyMap(Object? value) {
  if (value is List<dynamic>) {
    return {
      for (final item in value)
        if (item is Map<String, dynamic>) item['k'] as int: item['v'] as int?,
    };
  }
  return const {};
}

List<Map<String, int>> _encodeIntKeyMap(Map<int, int?> value) {
  final keys = value.keys.toList()..sort();
  return [
    for (final key in keys)
      if (value[key] != null) {'k': key, 'v': value[key]!},
  ];
}

void _upsertListItemJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final field = operation.fieldPath;
  if (field == null || field.isEmpty) {
    throw Exception('List operation requires fieldPath.');
  }
  if (operation.targetType == CharacterSyncTargetType.resource) {
    _upsertResourceStateJsonValue(json, operation);
    return;
  }
  if (operation.targetType ==
      CharacterSyncTargetType.startingEquipmentResolution) {
    _upsertStartingEquipmentResolutionJsonValue(json, operation);
    return;
  }
  final targetId = operation.targetId;
  final item = _encodedItemForField(field, operation.itemPayload);
  if (targetId == null || item == null) {
    throw Exception('List operation requires targetId and item payload.');
  }
  final list = List<dynamic>.from(json[field] as List? ?? const []);
  final index = list.indexWhere((entry) =>
      entry is Map<String, dynamic> &&
      _listItemMatchesTargetId(field, entry, targetId));
  if (index == -1) {
    list.add(item);
  } else {
    if (field == 'startingEquipmentSelections') {
      item['resolutions'] = (list[index] as Map)['resolutions'];
    }
    list[index] = item;
  }
  json[field] = list;
}

void _removeListItemJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final field = operation.fieldPath;
  if (field == null || field.isEmpty) {
    throw Exception('List operation requires fieldPath.');
  }
  if (operation.targetType == CharacterSyncTargetType.resource) {
    _removeResourceStateJsonValue(json, operation);
    return;
  }
  if (operation.targetType ==
      CharacterSyncTargetType.startingEquipmentResolution) {
    _removeStartingEquipmentResolutionJsonValue(json, operation);
    return;
  }
  final targetId = operation.targetId;
  if (targetId == null) {
    throw Exception('List operation requires targetId.');
  }
  final list = List<dynamic>.from(json[field] as List? ?? const []);
  list.removeWhere((entry) =>
      entry is Map<String, dynamic> &&
      _listItemMatchesTargetId(field, entry, targetId));
  json[field] = list.isEmpty ? null : list;
}

bool _listItemMatchesTargetId(
  String field,
  Map<String, dynamic> item,
  String targetId,
) {
  if (item['id']?.toString() == targetId) {
    return true;
  }
  if (field == 'startingEquipmentSelections') {
    return _startingEquipmentSelectionJsonMatches(item, targetId);
  }
  if (field != 'featureOverrides') {
    return false;
  }
  final parts = _decodeCompositeTargetId(targetId);
  return parts.length == 2 &&
      item['sourceType']?.toString() == parts[0] &&
      item['sourceId']?.toString() == parts[1];
}

void _upsertResourceStateJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final item = operation.itemPayload?.resourceStateValue;
  if (item == null) {
    throw Exception('Resource operation requires resource state payload.');
  }
  final list = List<dynamic>.from(json['resourceStates'] as List? ?? const []);
  final index = list.indexWhere((entry) =>
      entry is Map<String, dynamic> &&
      entry['sourceType'] == item.sourceType.toJson() &&
      entry['sourceId'] == item.sourceId &&
      entry['resourceKey'] == item.resourceKey);
  final encoded = item.toJson();
  if (index == -1) {
    list.add(encoded);
  } else {
    list[index] = encoded;
  }
  json['resourceStates'] = list;
}

void _removeResourceStateJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (parts.length != 3) {
    throw Exception(
        'Resource operation requires sourceType:sourceId:key targetId.');
  }
  final sourceId = int.tryParse(parts[1]);
  final list = List<dynamic>.from(json['resourceStates'] as List? ?? const []);
  list.removeWhere((entry) =>
      entry is Map<String, dynamic> &&
      entry['sourceType'] == parts[0] &&
      entry['sourceId'] == sourceId &&
      entry['resourceKey'] == parts[2]);
  json['resourceStates'] = list.isEmpty ? null : list;
}

void _upsertStartingEquipmentResolutionJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final item = operation.itemPayload?.startingEquipmentResolutionValue;
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (item == null || parts.length != 2) {
    throw Exception(
      'Starting equipment resolution operation requires targetId and payload.',
    );
  }
  final selections = List<dynamic>.from(
    json['startingEquipmentSelections'] as List? ?? const [],
  );
  final selectionIndex = selections.indexWhere((entry) =>
      entry is Map<String, dynamic> &&
      _startingEquipmentSelectionJsonMatches(entry, parts[0]));
  if (selectionIndex == -1) {
    throw Exception('Starting equipment selection was not found.');
  }
  final selection = Map<String, dynamic>.from(
    selections[selectionIndex] as Map<String, dynamic>,
  );
  final resolutions = List<dynamic>.from(
    selection['resolutions'] as List? ?? const [],
  );
  final resolutionIndex = resolutions.indexWhere((entry) =>
      entry is Map<String, dynamic> &&
      (entry['sourceLineEntryId']?.toString() == parts[1] ||
          entry['id']?.toString() == parts[1]));
  if (resolutionIndex == -1) {
    resolutions.add(item.toJson());
  } else {
    resolutions[resolutionIndex] = item.toJson();
  }
  selection['resolutions'] = resolutions;
  selections[selectionIndex] = selection;
  json['startingEquipmentSelections'] = selections;
}

void _removeStartingEquipmentResolutionJsonValue(
  Map<String, dynamic> json,
  CharacterSyncOperationData operation,
) {
  final parts = _decodeCompositeTargetId(operation.targetId);
  if (parts.length != 2) {
    throw Exception(
        'Starting equipment resolution operation requires targetId.');
  }
  final selections = List<dynamic>.from(
    json['startingEquipmentSelections'] as List? ?? const [],
  );
  final selectionIndex = selections.indexWhere((entry) =>
      entry is Map<String, dynamic> &&
      _startingEquipmentSelectionJsonMatches(entry, parts[0]));
  if (selectionIndex == -1) return;
  final selection = Map<String, dynamic>.from(
    selections[selectionIndex] as Map<String, dynamic>,
  );
  final resolutions = List<dynamic>.from(
    selection['resolutions'] as List? ?? const [],
  )..removeWhere((entry) =>
      entry is Map<String, dynamic> &&
      (entry['sourceLineEntryId']?.toString() == parts[1] ||
          entry['id']?.toString() == parts[1]));
  selection['resolutions'] = resolutions.isEmpty ? null : resolutions;
  selections[selectionIndex] = selection;
  json['startingEquipmentSelections'] = selections;
}

bool _startingEquipmentSelectionJsonMatches(
  Map<String, dynamic> item,
  String targetId,
) {
  if (item['id']?.toString() == targetId) return true;
  return _encodeCompositeTargetId([
        item['sourceType']?.toString() ?? '',
        item['sourceId']?.toString() ?? '',
        item['sourceEntryId']?.toString() ?? '',
        item['selectionIndex']?.toString() ?? '',
      ]) ==
      targetId;
}

CharacterStartingEquipmentSelectionData? _findStartingEquipmentSelection(
  CharacterData character,
  String targetId,
) {
  for (final selection in character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[]) {
    if (selection.id == targetId ||
        _startingEquipmentSelectionTargetId(selection) == targetId) {
      return selection;
    }
  }
  return null;
}

CharacterStartingEquipmentResolutionData? _findStartingEquipmentResolution(
  CharacterStartingEquipmentSelectionData selection,
  String targetId,
) {
  for (final resolution in selection.resolutions ??
      const <CharacterStartingEquipmentResolutionData>[]) {
    if (resolution.id == targetId ||
        resolution.sourceLineEntryId?.toString() == targetId) {
      return resolution;
    }
  }
  return null;
}

Object? _encodedValueForField(String field, CharacterSyncValueData? value) {
  if (value == null) return null;
  switch (field) {
    case 'name':
    case 'age':
    case 'height':
    case 'weight':
    case 'eyes':
    case 'skin':
    case 'hair':
    case 'appearance':
    case 'backstory':
    case 'goals':
    case 'alliesOrganizations':
    case 'personalityTraits':
    case 'ideals':
    case 'bonds':
    case 'flaws':
    case 'activeConcentrationSpellName':
      return value.stringValue;
    case 'experience':
    case 'temporaryHp':
    case 'currentHp':
    case 'deathSaveSuccesses':
    case 'deathSaveFailures':
    case 'hpPerLevelBonus':
    case 'hpFlatBonus':
    case 'customInitiativeBonus':
    case 'customArmorClassBonus':
    case 'walkingSpeed':
    case 'swimmingSpeed':
    case 'climbingSpeed':
    case 'flyingSpeed':
    case 'customSpellSaveDcBonus':
    case 'customSpellAttackBonus':
    case 'exhaustionLevel':
    case 'baseAbilityScores':
    case 'customAbilityBonuses':
    case 'currentHitDice':
    case 'hitDiceMaxOverrides':
    case 'currentSpellSlots':
    case 'currentPactSlots':
      return value.intValue;
    case 'useFlexibleAbilityBonuses':
    case 'inspiration':
      return value.boolValue;
    case 'alignmentValue':
      return value.alignmentValue?.toJson();
    case 'displayedSpeedKind':
      return value.speedKindValue?.toJson();
    case 'preparedSpellKeys':
      return value.stringListValue;
    case 'activeConditions':
      return value.conditionListValue
          ?.map((condition) => condition.toJson())
          .toList();
    case 'manualSkillProficiencies':
      return value.skillProficiencyListValue
          ?.map((proficiency) => proficiency.toJson())
          .toList();
    case 'manualSavingThrowProficiencies':
      return value.abilityListValue
          ?.map((ability) => ability.toJson())
          .toList();
    case 'manualLanguageOverrides':
      return value.languageOverridesValue?.toJson();
    case 'manualToolProficiencyOverrides':
      return value.toolProficiencyOverridesValue?.toJson();
    case 'manualWeaponProficiencyOverrides':
      return value.weaponProficiencyOverridesValue?.toJson();
    case 'manualArmorTrainingOverrides':
      return value.armorTrainingOverridesValue?.toJson();
    case 'equippedArmor':
    case 'equippedShield':
      return value.equipmentSelectionValue?.toJson();
    case 'race':
      return value.intValue == null ? null : {'id': value.intValue};
    case 'subrace':
      return value.intValue == null ? null : {'id': value.intValue};
    case 'background':
      return value.intValue == null ? null : {'id': value.intValue};
  }
  throw Exception('Unsupported field "$field".');
}

Map<String, dynamic>? _encodedItemForField(
  String field,
  CharacterSyncValueData? payload,
) {
  switch (field) {
    case 'notes':
      return payload?.noteValue?.toJson();
    case 'equipment':
      return payload?.equipmentValue?.toJson();
    case 'attacks':
      return payload?.attackValue?.toJson();
    case 'featureOverrides':
      return payload?.featureOverrideValue?.toJson();
    case 'classEntries':
      return payload?.classEntryValue?.toJson();
    case 'choices':
      return payload?.choiceValue?.toJson();
    case 'skillSelections':
      return payload?.skillSelectionValue?.toJson();
    case 'spellSelections':
      return payload?.spellSelectionValue?.toJson();
    case 'startingEquipmentSelections':
      return payload?.startingEquipmentSelectionValue?.toJson();
  }
  throw Exception('Unsupported list field "$field".');
}

class _OperationApplyResult {
  const _OperationApplyResult({
    this.character,
    this.rejection,
  });

  final CharacterData? character;
  final CharacterRejectedChangeData? rejection;
}
