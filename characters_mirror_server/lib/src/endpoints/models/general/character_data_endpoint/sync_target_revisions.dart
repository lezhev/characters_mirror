part of '../character_data_endpoint.dart';

const _characterScalarSyncFields = <String>[
  'name',
  'age',
  'height',
  'weight',
  'eyes',
  'skin',
  'hair',
  'appearance',
  'backstory',
  'goals',
  'alliesOrganizations',
  'personalityTraits',
  'ideals',
  'bonds',
  'flaws',
  'experience',
  'alignmentValue',
  'race',
  'subrace',
  'background',
  'useFlexibleAbilityBonuses',
  'temporaryHp',
  'currentHp',
  'deathSaveSuccesses',
  'deathSaveFailures',
  'hpPerLevelBonus',
  'hpFlatBonus',
  'activeConcentrationSpellName',
  'customInitiativeBonus',
  'customArmorClassBonus',
  'walkingSpeed',
  'swimmingSpeed',
  'climbingSpeed',
  'flyingSpeed',
  'displayedSpeedKind',
  'customSpellSaveDcBonus',
  'customSpellAttackBonus',
  'preparedSpellKeys',
  'activeConditions',
  'exhaustionLevel',
  'inspiration',
  'manualSkillProficiencies',
  'manualSavingThrowProficiencies',
  'manualLanguageOverrides',
  'manualToolProficiencyOverrides',
  'manualWeaponProficiencyOverrides',
  'manualArmorTrainingOverrides',
];

Map<String, int> _materializedSyncTargetRevisions(
  CharacterData character,
  int baselineRevision,
) {
  final revisions = <String, int>{
    ...?character.syncTargetRevisions,
  };
  for (final field in _characterScalarSyncFields) {
    revisions.putIfAbsent(_fieldTargetKey(field), () => baselineRevision);
  }
  _materializeMemberRevisions(
    revisions,
    field: 'activeConditions',
    members: character.activeConditions
        ?.where((condition) => condition != ConditionType.exhaustion)
        .map((condition) => condition.name),
    coarseField: 'activeConditions',
    baselineRevision: baselineRevision,
  );
  _materializeMemberRevisions(
    revisions,
    field: 'preparedSpellKeys',
    members: _normalizedPreparedSpellKeys(character.preparedSpellKeys),
    coarseField: 'preparedSpellKeys',
    baselineRevision: baselineRevision,
  );
  _materializeMemberRevisions(
    revisions,
    field: 'manualSkillProficiencyOverrides',
    members: _skillOverrideMemberNames(character),
    coarseField: 'manualSkillProficiencies',
    baselineRevision: baselineRevision,
  );
  _materializeMemberRevisions(
    revisions,
    field: 'manualSavingThrowProficiencyOverrides',
    members: _savingThrowOverrideMemberNames(character),
    coarseField: 'manualSavingThrowProficiencies',
    baselineRevision: baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'baseAbilityScores',
    character.baseAbilityScores,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'customAbilityBonuses',
    character.customAbilityBonuses,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'currentHitDice',
    character.currentHitDice,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'hitDiceMaxOverrides',
    character.hitDiceMaxOverrides,
    baselineRevision,
  );
  _addMapTargetRevisions(
    revisions,
    'currentSpellSlots',
    character.currentSpellSlots,
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'notes',
    character.notes?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'equipment',
    character.equipment?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'attacks',
    character.attacks?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'featureOverrides',
    character.featureOverrides?.map(_featureOverrideTargetId),
    baselineRevision,
  );
  _materializeFeatureOverrideRevisions(
    revisions,
    character.featureOverrides,
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'classEntries',
    character.classEntries?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'choices',
    character.choices?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'skillSelections',
    character.skillSelections?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'spellSelections',
    character.spellSelections?.map((item) => item.id),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'startingEquipmentSelections',
    character.startingEquipmentSelections
        ?.map(_startingEquipmentSelectionTargetId),
    baselineRevision,
  );
  _addItemTargetRevisions(
    revisions,
    'startingEquipmentSelections',
    character.startingEquipmentSelections?.map((item) => item.id),
    baselineRevision,
  );
  for (final state
      in character.resourceStates ?? const <CharacterResourceStateData>[]) {
    revisions.putIfAbsent(
      _resourceTargetKey(
        state.sourceType.name,
        state.sourceId,
        state.resourceKey,
      ),
      () => baselineRevision,
    );
  }
  for (final selection in character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[]) {
    final selectionId = _startingEquipmentSelectionTargetId(selection);
    for (final resolution in selection.resolutions ??
        const <CharacterStartingEquipmentResolutionData>[]) {
      final sourceLineEntryId = resolution.sourceLineEntryId?.toString();
      if (sourceLineEntryId != null) {
        revisions.putIfAbsent(
          _startingEquipmentResolutionTargetKey(
            selectionId,
            sourceLineEntryId,
          ),
          () => baselineRevision,
        );
      }
      if (selection.id != null && resolution.id != null) {
        revisions.putIfAbsent(
          _legacyStartingEquipmentResolutionTargetKey(
            selection.id!,
            resolution.id!,
          ),
          () => baselineRevision,
        );
      }
    }
  }
  return revisions;
}

Iterable<String>? _skillOverrideMemberNames(CharacterData character) {
  final overrides = character.manualSkillProficiencyOverrides;
  if (overrides != null) return overrides.map((state) => state.skill.name);
  if (character.manualSkillProficiencies != null) {
    return Skill.values.map((skill) => skill.name);
  }
  return null;
}

Iterable<String>? _savingThrowOverrideMemberNames(CharacterData character) {
  final overrides = character.manualSavingThrowProficiencyOverrides;
  if (overrides != null) return overrides.map((state) => state.ability.name);
  if (character.manualSavingThrowProficiencies != null) {
    return Ability.values.map((ability) => ability.name);
  }
  return null;
}

void _materializeMemberRevisions(
  Map<String, int> revisions, {
  required String field,
  required Iterable<String>? members,
  required String coarseField,
  required int baselineRevision,
}) {
  final coarseRevision =
      revisions[_fieldTargetKey(coarseField)] ?? baselineRevision;
  final memberBaselineKey = _memberBaselineTargetKey(field);
  final memberBaseline = revisions.putIfAbsent(
    memberBaselineKey,
    () => coarseRevision,
  );
  for (final member in members ?? const <String>[]) {
    revisions.putIfAbsent(
      _memberTargetKey(field, member),
      () => memberBaseline,
    );
  }
}

void _materializeFeatureOverrideRevisions(
  Map<String, int> revisions,
  List<CharacterFeatureOverrideData>? overrides,
  int baselineRevision,
) {
  final legacyRevision = _maximumRevision(
        revisions,
        revisions.keys.where((key) => key.startsWith('item:featureOverrides:')),
      ) ??
      baselineRevision;
  final memberBaseline = revisions.putIfAbsent(
    _memberBaselineTargetKey('featureOverrides'),
    () => legacyRevision,
  );
  for (final item in overrides ?? const <CharacterFeatureOverrideData>[]) {
    revisions.putIfAbsent(
      _featureOverrideFieldTargetKey(
        item.sourceType,
        item.sourceId,
        'name',
      ),
      () => memberBaseline,
    );
    revisions.putIfAbsent(
      _featureOverrideFieldTargetKey(
        item.sourceType,
        item.sourceId,
        'description',
      ),
      () => memberBaseline,
    );
    for (final tag in item.tags ?? const <FeatureTag>[]) {
      revisions.putIfAbsent(
        _featureOverrideTagTargetKey(item.sourceType, item.sourceId, tag),
        () => memberBaseline,
      );
    }
  }
}

void _addMapTargetRevisions<K>(
  Map<String, int> revisions,
  String field,
  Map<K, int>? values,
  int baselineRevision,
) {
  for (final key in values?.keys ?? const <Never>[]) {
    revisions.putIfAbsent(
      _mapTargetKey(field, key.toString()),
      () => baselineRevision,
    );
  }
}

void _addItemTargetRevisions(
  Map<String, int> revisions,
  String collection,
  Iterable<String?>? ids,
  int baselineRevision,
) {
  for (final id in ids ?? const <String?>[]) {
    if (id == null) continue;
    revisions.putIfAbsent(
        _itemTargetKey(collection, id), () => baselineRevision);
  }
}

String _targetKeyForOperation(
  CharacterSyncOperationData operation, [
  CharacterData? current,
]) {
  switch (operation.type) {
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
      return 'character:${operation.characterId ?? operation.localCharacterId ?? ''}';
    case CharacterSyncOperationType.setField:
      return _fieldTargetKey(operation.fieldPath ?? '');
    case CharacterSyncOperationType.setMapEntry:
    case CharacterSyncOperationType.removeMapEntry:
      return _mapTargetKey(operation.fieldPath ?? '', operation.targetId ?? '');
    case CharacterSyncOperationType.upsertListItem:
    case CharacterSyncOperationType.removeListItem:
      if (operation.targetType == CharacterSyncTargetType.resource) {
        final parts = _decodeCompositeTargetId(operation.targetId);
        if (parts.length == 3) {
          return _resourceTargetKey(
              parts[0], int.tryParse(parts[1]) ?? 0, parts[2]);
        }
      }
      if (operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution) {
        final parts = _decodeCompositeTargetId(operation.targetId);
        if (parts.length == 2) {
          return _startingEquipmentResolutionTargetKey(parts[0], parts[1]);
        }
      }
      return _itemTargetKey(
          operation.fieldPath ?? '', operation.targetId ?? '');
    case CharacterSyncOperationType.addSetMember:
    case CharacterSyncOperationType.removeSetMember:
    case CharacterSyncOperationType.setMemberValue:
      return _memberTargetKeyForOperation(operation);
    case CharacterSyncOperationType.applyDamage:
    case CharacterSyncOperationType.heal:
    case CharacterSyncOperationType.grantTemporaryHp:
    case CharacterSyncOperationType.adjustSpellSlots:
    case CharacterSyncOperationType.castSpell:
    case CharacterSyncOperationType.adjustHitDice:
    case CharacterSyncOperationType.adjustResource:
    case CharacterSyncOperationType.adjustExperience:
    case CharacterSyncOperationType.applyRest:
      final targets = _semanticActionTargetKeys(
        current ?? CharacterData(),
        operation,
      );
      return targets.isEmpty
          ? _syncTargetKey('action', [operation.type.name])
          : targets.first;
  }
}

String _memberTargetKeyForOperation(CharacterSyncOperationData operation) {
  final field = operation.fieldPath ?? '';
  final targetId = operation.targetId ?? '';
  if (field == 'featureOverrides') {
    final parts = _decodeCompositeTargetId(targetId);
    if (parts.length == 3 || (parts.length == 4 && parts[2] == 'tag')) {
      return _syncTargetKey('featureOverride', parts);
    }
  }
  return _memberTargetKey(field, targetId);
}

Set<String> _changedSyncTargetKeys(
  CharacterData previous,
  CharacterData next,
) {
  final changed = <String>{};
  final previousJson = previous.toJson()..remove('derived');
  final nextJson = next.toJson()..remove('derived');

  for (final field in _characterScalarSyncFields) {
    if (!_syncJsonEquals(
      _syncScalarFieldValue(previousJson, field),
      _syncScalarFieldValue(nextJson, field),
    )) {
      changed.add(_fieldTargetKey(field));
    }
  }

  _addChangedMapTargets(
    changed,
    'baseAbilityScores',
    previous.baseAbilityScores,
    next.baseAbilityScores,
  );

  _addChangedSetMemberTargets(
    changed,
    'activeConditions',
    previous.activeConditions
        ?.where((condition) => condition != ConditionType.exhaustion)
        .map((condition) => condition.name),
    next.activeConditions
        ?.where((condition) => condition != ConditionType.exhaustion)
        .map((condition) => condition.name),
  );
  _addChangedSetMemberTargets(
    changed,
    'preparedSpellKeys',
    _normalizedPreparedSpellKeys(previous.preparedSpellKeys),
    _normalizedPreparedSpellKeys(next.preparedSpellKeys),
  );
  _addChangedValueMemberTargets(
    changed,
    'manualSkillProficiencyOverrides',
    previous.manualSkillProficiencyOverrides,
    next.manualSkillProficiencyOverrides,
    (state) => state.skill.name,
  );
  _addChangedValueMemberTargets(
    changed,
    'manualSavingThrowProficiencyOverrides',
    previous.manualSavingThrowProficiencyOverrides,
    next.manualSavingThrowProficiencyOverrides,
    (state) => state.ability.name,
  );
  _addChangedMapTargets(
    changed,
    'customAbilityBonuses',
    previous.customAbilityBonuses,
    next.customAbilityBonuses,
  );
  _addChangedMapTargets(
    changed,
    'currentHitDice',
    previous.currentHitDice,
    next.currentHitDice,
  );
  _addChangedMapTargets(
    changed,
    'hitDiceMaxOverrides',
    previous.hitDiceMaxOverrides,
    next.hitDiceMaxOverrides,
  );
  _addChangedMapTargets(
    changed,
    'currentSpellSlots',
    previous.currentSpellSlots,
    next.currentSpellSlots,
  );

  _addChangedItemTargets(
    changed,
    'notes',
    previous.notes,
    next.notes,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'equipment',
    previous.equipment,
    next.equipment,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'attacks',
    previous.attacks,
    next.attacks,
    (item) => item.id,
  );
  _addChangedFeatureOverrideTargets(
    changed,
    previous.featureOverrides,
    next.featureOverrides,
  );
  _addChangedResourceTargets(
      changed, previous.resourceStates, next.resourceStates);
  _addChangedItemTargets(
    changed,
    'classEntries',
    previous.classEntries,
    next.classEntries,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'choices',
    previous.choices,
    next.choices,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'skillSelections',
    previous.skillSelections,
    next.skillSelections,
    (item) => item.id,
  );
  _addChangedItemTargets(
    changed,
    'spellSelections',
    previous.spellSelections,
    next.spellSelections,
    (item) => item.id,
  );
  _addChangedStartingEquipmentSelectionTargets(
    changed,
    previous.startingEquipmentSelections,
    next.startingEquipmentSelections,
  );
  _addChangedStartingEquipmentResolutionTargets(
    changed,
    previous.startingEquipmentSelections,
    next.startingEquipmentSelections,
  );

  return changed;
}

void _addChangedSetMemberTargets(
  Set<String> changed,
  String field,
  Iterable<String>? previous,
  Iterable<String>? next,
) {
  final previousSet = {...?previous};
  final nextSet = {...?next};
  for (final member in {...previousSet, ...nextSet}) {
    if (previousSet.contains(member) != nextSet.contains(member)) {
      changed.add(_memberTargetKey(field, member));
    }
  }
}

void _addChangedValueMemberTargets<T>(
  Set<String> changed,
  String field,
  List<T>? previous,
  List<T>? next,
  String Function(T value) memberOf,
) {
  final previousByMember = {
    for (final value in previous ?? <T>[]) memberOf(value): value,
  };
  final nextByMember = {
    for (final value in next ?? <T>[]) memberOf(value): value,
  };
  for (final member in {...previousByMember.keys, ...nextByMember.keys}) {
    if (!_syncJsonEquals(previousByMember[member], nextByMember[member])) {
      changed.add(_memberTargetKey(field, member));
    }
  }
}

void _addChangedFeatureOverrideTargets(
  Set<String> changed,
  List<CharacterFeatureOverrideData>? previous,
  List<CharacterFeatureOverrideData>? next,
) {
  final previousById = {
    for (final item in previous ?? const <CharacterFeatureOverrideData>[])
      _featureOverrideTargetId(item): item,
  };
  final nextById = {
    for (final item in next ?? const <CharacterFeatureOverrideData>[])
      _featureOverrideTargetId(item): item,
  };
  for (final id in {...previousById.keys, ...nextById.keys}) {
    final left = previousById[id];
    final right = nextById[id];
    final identity = right ?? left!;
    if (left?.name != right?.name) {
      changed.add(_featureOverrideFieldTargetKey(
        identity.sourceType,
        identity.sourceId,
        'name',
      ));
    }
    if (left?.description != right?.description) {
      changed.add(_featureOverrideFieldTargetKey(
        identity.sourceType,
        identity.sourceId,
        'description',
      ));
    }
    final leftTags = {...?left?.tags};
    final rightTags = {...?right?.tags};
    for (final tag in {...leftTags, ...rightTags}) {
      if (leftTags.contains(tag) != rightTags.contains(tag)) {
        changed.add(_featureOverrideTagTargetKey(
          identity.sourceType,
          identity.sourceId,
          tag,
        ));
      }
    }
  }
}

void _addChangedStartingEquipmentSelectionTargets(
  Set<String> changed,
  List<CharacterStartingEquipmentSelectionData>? previous,
  List<CharacterStartingEquipmentSelectionData>? next,
) {
  final previousById = _syncItemsById(
    previous,
    _startingEquipmentSelectionTargetId,
  );
  final nextById = _syncItemsById(
    next,
    _startingEquipmentSelectionTargetId,
  );
  for (final id in {...previousById.keys, ...nextById.keys}) {
    final left = previousById[id]?.copyWith(resolutions: null);
    final right = nextById[id]?.copyWith(resolutions: null);
    if (!_syncJsonEquals(left, right)) {
      changed.add(_itemTargetKey('startingEquipmentSelections', id));
      if (previousById[id]?.id != null) {
        changed.add(_itemTargetKey(
          'startingEquipmentSelections',
          previousById[id]!.id!,
        ));
      }
      if (nextById[id]?.id != null) {
        changed.add(_itemTargetKey(
          'startingEquipmentSelections',
          nextById[id]!.id!,
        ));
      }
    }
  }
}

Object? _syncScalarFieldValue(Map<String, dynamic> json, String field) {
  final value = json[field];
  if (field == 'race' || field == 'subrace' || field == 'background') {
    if (value is Map<String, dynamic>) {
      return value['id'];
    }
  }
  return value;
}

void _addChangedMapTargets<K>(
  Set<String> changed,
  String field,
  Map<K, int>? previous,
  Map<K, int>? next,
) {
  final keys = {...?previous?.keys, ...?next?.keys};
  for (final key in keys) {
    if (previous?[key] != next?[key]) {
      changed.add(_mapTargetKey(field, key.toString()));
    }
  }
}

void _addChangedItemTargets<T>(
  Set<String> changed,
  String collection,
  List<T>? previous,
  List<T>? next,
  String? Function(T item) idOf,
) {
  final previousById = _syncItemsById(previous, idOf);
  final nextById = _syncItemsById(next, idOf);
  final ids = {...previousById.keys, ...nextById.keys};
  for (final id in ids) {
    if (!_syncJsonEquals(previousById[id], nextById[id])) {
      changed.add(_itemTargetKey(collection, id));
    }
  }
}

void _addChangedResourceTargets(
  Set<String> changed,
  List<CharacterResourceStateData>? previous,
  List<CharacterResourceStateData>? next,
) {
  final previousById = {
    for (final state in previous ?? const <CharacterResourceStateData>[])
      _resourceTargetId(state): state,
  };
  final nextById = {
    for (final state in next ?? const <CharacterResourceStateData>[])
      _resourceTargetId(state): state,
  };
  for (final id in {...previousById.keys, ...nextById.keys}) {
    if (!_syncJsonEquals(previousById[id], nextById[id])) {
      final parts = _decodeCompositeTargetId(id);
      if (parts.length == 3) {
        changed.add(_resourceTargetKey(
          parts[0],
          int.tryParse(parts[1]) ?? 0,
          parts[2],
        ));
      }
    }
  }
}

void _addChangedStartingEquipmentResolutionTargets(
  Set<String> changed,
  List<CharacterStartingEquipmentSelectionData>? previous,
  List<CharacterStartingEquipmentSelectionData>? next,
) {
  final previousById =
      _syncItemsById(previous, _startingEquipmentSelectionTargetId);
  final nextById = _syncItemsById(next, _startingEquipmentSelectionTargetId);
  for (final selectionId in {...previousById.keys, ...nextById.keys}) {
    final previousSelection = previousById[selectionId];
    final nextSelection = nextById[selectionId];
    final previousResolutions = _syncItemsById(
      previousSelection?.resolutions,
      (item) => item.sourceLineEntryId?.toString(),
    );
    final nextResolutions = _syncItemsById(
      nextSelection?.resolutions,
      (item) => item.sourceLineEntryId?.toString(),
    );
    for (final sourceLineEntryId in {
      ...previousResolutions.keys,
      ...nextResolutions.keys
    }) {
      if (!_syncJsonEquals(
        previousResolutions[sourceLineEntryId],
        nextResolutions[sourceLineEntryId],
      )) {
        changed.add(_startingEquipmentResolutionTargetKey(
          selectionId,
          sourceLineEntryId,
        ));
        final previousResolution = previousResolutions[sourceLineEntryId];
        final nextResolution = nextResolutions[sourceLineEntryId];
        if (previousSelection?.id != null && previousResolution?.id != null) {
          changed.add(_legacyStartingEquipmentResolutionTargetKey(
            previousSelection!.id!,
            previousResolution!.id!,
          ));
        }
        if (nextSelection?.id != null && nextResolution?.id != null) {
          changed.add(_legacyStartingEquipmentResolutionTargetKey(
            nextSelection!.id!,
            nextResolution!.id!,
          ));
        }
      }
    }
    _addChangedLegacyStartingEquipmentResolutionTargets(
      changed,
      previousSelection,
      nextSelection,
    );
  }
}

void _addChangedLegacyStartingEquipmentResolutionTargets(
  Set<String> changed,
  CharacterStartingEquipmentSelectionData? previous,
  CharacterStartingEquipmentSelectionData? next,
) {
  final previousById = _syncItemsById(
    previous?.resolutions,
    (item) => item.id,
  );
  final nextById = _syncItemsById(next?.resolutions, (item) => item.id);
  for (final id in {...previousById.keys, ...nextById.keys}) {
    if (_syncJsonEquals(previousById[id], nextById[id])) continue;
    if (previous?.id != null) {
      changed.add(_legacyStartingEquipmentResolutionTargetKey(
        previous!.id!,
        id,
      ));
    }
    if (next?.id != null) {
      changed.add(_legacyStartingEquipmentResolutionTargetKey(
        next!.id!,
        id,
      ));
    }
  }
}

int? _maximumRevision(Map<String, int> revisions, Iterable<String> keys) {
  int? result;
  for (final key in keys) {
    final value = revisions[key];
    if (value != null && (result == null || value > result)) {
      result = value;
    }
  }
  return result;
}

Map<String, T> _syncItemsById<T>(
  List<T>? items,
  String? Function(T item) idOf,
) {
  return {
    for (final item in items ?? <T>[])
      if (idOf(item) != null) idOf(item)!: item,
  };
}

bool _syncJsonEquals(Object? left, Object? right) {
  return jsonEncode(_normalizeSyncJson(left)) ==
      jsonEncode(_normalizeSyncJson(right));
}

Object? _normalizeSyncJson(Object? value) {
  if (value == null || value is num || value is bool || value is String) {
    return value;
  }
  if (value is DateTime) {
    return value.toUtc().toIso8601String();
  }
  if (value is SerializableModel) {
    final json = Map<String, dynamic>.from(value.toJson());
    json.remove('updatedAt');
    json.remove('derived');
    json.remove('version');
    json.remove('syncTargetRevisions');
    json.remove('syncBarrierTokens');
    return _normalizeSyncJson(json);
  }
  if (value is Iterable) {
    return [for (final item in value) _normalizeSyncJson(item)];
  }
  if (value is Map) {
    final normalized = <String, Object?>{};
    final keys = value.keys.map((key) => key.toString()).toList()..sort();
    for (final key in keys) {
      if (key == 'updatedAt' ||
          key == 'derived' ||
          key == 'version' ||
          key == 'syncTargetRevisions' ||
          key == 'syncBarrierTokens') {
        continue;
      }
      normalized[key] = _normalizeSyncJson(value[key]);
    }
    return normalized;
  }
  return value.toString();
}
