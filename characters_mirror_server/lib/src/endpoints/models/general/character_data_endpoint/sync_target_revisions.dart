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
    character.featureOverrides?.map((item) => item.id),
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
    final selectionId = selection.id;
    if (selectionId == null) continue;
    for (final resolution in selection.resolutions ??
        const <CharacterStartingEquipmentResolutionData>[]) {
      final resolutionId = resolution.id;
      if (resolutionId == null) continue;
      revisions.putIfAbsent(
        _startingEquipmentResolutionTargetKey(selectionId, resolutionId),
        () => baselineRevision,
      );
    }
  }
  return revisions;
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

String _targetKeyForOperation(CharacterSyncOperationData operation) {
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
        final parts = (operation.targetId ?? '').split(':');
        if (parts.length == 3) {
          return _resourceTargetKey(
              parts[0], int.tryParse(parts[1]) ?? 0, parts[2]);
        }
      }
      if (operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution) {
        final parts = (operation.targetId ?? '').split(':');
        if (parts.length == 2) {
          return _startingEquipmentResolutionTargetKey(parts[0], parts[1]);
        }
      }
      return _itemTargetKey(
          operation.fieldPath ?? '', operation.targetId ?? '');
  }
}

String _fieldTargetKey(String field) => 'field:$field';

String _mapTargetKey(String field, String key) => 'map:$field:$key';

String _itemTargetKey(String collection, String id) => 'item:$collection:$id';

String _resourceTargetKey(String sourceType, int sourceId, String resourceKey) {
  return 'resource:$sourceType:$sourceId:$resourceKey';
}

String _startingEquipmentResolutionTargetKey(
  String selectionId,
  String resolutionId,
) {
  return 'item:startingEquipmentSelections:$selectionId:resolution:$resolutionId';
}
