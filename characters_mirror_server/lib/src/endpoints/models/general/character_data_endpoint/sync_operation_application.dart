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
    try {
      final result = await _applySyncOperationAtomically(
        session,
        userId: userId,
        operation: operation,
        resolveContext: resolveContext,
      );
      if (result.rejection != null) {
        rejectedChanges.add(result.rejection!);
        continue;
      }
      acknowledgedChangeIds.add(operation.id);
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
    }
  }

  final pullDelta = await _loadCharacterSyncDelta(
    session,
    userId: userId,
    pullAfterEventId: request.pullAfterEventId,
    pullSince: request.pullSince,
    resolveContext: resolveContext,
  );
  final charactersById = <int, CharacterData>{
    for (final character in pullDelta.characters)
      if (character.id != null) character.id!: character,
    for (final character in changedCharacters.values)
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
  );
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
        CharacterSyncOperationType.removeListItem =>
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
  final targetKey = _targetKeyForOperation(operation);
  final currentTargetRevision = targetRevisions[targetKey] ?? 0;
  final baseTargetRevision =
      operation.baseTargetRevision ?? operation.baseCharacterRevision ?? 0;
  if (currentTargetRevision != baseTargetRevision) {
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
  targetRevisions[targetKey] = nextRevision;
  var next = _applyOperationToCharacter(current, operation).copyWith(
    id: characterId,
    version: nextRevision,
    createdAt: record.createdAt,
    updatedAt: DateTime.now().toUtc(),
    syncTargetRevisions: targetRevisions,
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
  final saved = await _buildCharacterAggregate(
    session,
    savedRecord,
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
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
      break;
  }
  return CharacterData.fromJson(json);
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
  if (field == 'currentSpellSlots') {
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
  if (field == 'currentSpellSlots') {
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
      entry is Map<String, dynamic> && entry['id']?.toString() == parts[0]);
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
      entry is Map<String, dynamic> && entry['id']?.toString() == parts[1]);
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
      entry is Map<String, dynamic> && entry['id']?.toString() == parts[0]);
  if (selectionIndex == -1) return;
  final selection = Map<String, dynamic>.from(
    selections[selectionIndex] as Map<String, dynamic>,
  );
  final resolutions = List<dynamic>.from(
    selection['resolutions'] as List? ?? const [],
  )..removeWhere((entry) =>
      entry is Map<String, dynamic> && entry['id']?.toString() == parts[1]);
  selection['resolutions'] = resolutions.isEmpty ? null : resolutions;
  selections[selectionIndex] = selection;
  json['startingEquipmentSelections'] = selections;
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
