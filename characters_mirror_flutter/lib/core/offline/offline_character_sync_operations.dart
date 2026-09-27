import 'dart:convert';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_target_keys.dart';

List<CharacterSyncOperationData> buildCharacterSyncOperations({
  required CharacterData previous,
  required CharacterData next,
  required int localId,
  required int? serverId,
  required DateTime createdAt,
  required String Function() nextChangeId,
}) {
  if (serverId == null) {
    return [
      CharacterSyncOperationData(
        id: nextChangeId(),
        characterId: null,
        localCharacterId: localId,
        type: CharacterSyncOperationType.createCharacter,
        targetType: CharacterSyncTargetType.character,
        targetId: localId.toString(),
        itemPayload: CharacterSyncValueData(
          characterValue: next.copyWith(id: localId),
        ),
        createdAt: createdAt,
      ),
    ];
  }

  final builder = _OperationBuilder(
    previous: previous,
    next: next.copyWith(id: serverId),
    localId: localId,
    serverId: serverId,
    createdAt: createdAt,
    nextChangeId: nextChangeId,
  );
  return builder.build();
}

String characterSyncOperationTargetKey(CharacterSyncOperationData operation) {
  switch (operation.type) {
    case CharacterSyncOperationType.createCharacter:
    case CharacterSyncOperationType.deleteCharacter:
      return 'character:${operation.characterId ?? operation.localCharacterId ?? ''}';
    case CharacterSyncOperationType.setField:
      return characterSyncFieldTargetKey(operation.fieldPath ?? '');
    case CharacterSyncOperationType.setMapEntry:
    case CharacterSyncOperationType.removeMapEntry:
      return characterSyncMapTargetKey(
        operation.fieldPath ?? '',
        operation.targetId ?? '',
      );
    case CharacterSyncOperationType.upsertListItem:
    case CharacterSyncOperationType.removeListItem:
      if (operation.targetType == CharacterSyncTargetType.resource) {
        final parts = decodeCharacterSyncCompositeId(operation.targetId);
        if (parts.length == 3) {
          return characterSyncTargetKey('resource', parts);
        }
      }
      if (operation.targetType ==
          CharacterSyncTargetType.startingEquipmentResolution) {
        final parts = decodeCharacterSyncCompositeId(operation.targetId);
        if (parts.length == 2) {
          return characterSyncStartingEquipmentResolutionTargetKey(
            parts[0],
            parts[1],
          );
        }
      }
      return characterSyncItemTargetKey(
        operation.fieldPath ?? '',
        operation.targetId ?? '',
      );
    case CharacterSyncOperationType.addSetMember:
    case CharacterSyncOperationType.removeSetMember:
    case CharacterSyncOperationType.setMemberValue:
      return _memberOperationTargetKey(operation);
    case CharacterSyncOperationType.applyDamage:
    case CharacterSyncOperationType.heal:
    case CharacterSyncOperationType.grantTemporaryHp:
    case CharacterSyncOperationType.adjustSpellSlots:
    case CharacterSyncOperationType.castSpell:
    case CharacterSyncOperationType.adjustHitDice:
    case CharacterSyncOperationType.adjustResource:
    case CharacterSyncOperationType.adjustExperience:
    case CharacterSyncOperationType.applyRest:
      return 'semantic:${operation.id}';
  }
}

String _memberOperationTargetKey(CharacterSyncOperationData operation) {
  final field = operation.fieldPath ?? '';
  final targetId = operation.targetId ?? '';
  if (field == 'featureOverrides') {
    final parts = decodeCharacterSyncCompositeId(targetId);
    if (parts.length == 3) {
      return characterSyncTargetKey('featureOverride', parts);
    }
    if (parts.length == 4 && parts[2] == 'tag') {
      return characterSyncTargetKey('featureOverride', parts);
    }
  }
  return characterSyncMemberTargetKey(field, targetId);
}

List<CharacterSyncOperationData> coalesceCharacterSyncOperations(
  Iterable<CharacterSyncOperationData> operations,
) {
  final orderedKeys = <String>[];
  final byKey = <String, CharacterSyncOperationData>{};
  for (final operation in operations) {
    final characterKey =
        '${operation.characterId ?? operation.localCharacterId ?? ''}';
    if (operation.type == CharacterSyncOperationType.deleteCharacter) {
      final keysToRemove = [
        for (final key in byKey.keys)
          if (key.startsWith('$characterKey|')) key,
      ];
      for (final key in keysToRemove) {
        byKey.remove(key);
        orderedKeys.remove(key);
      }
    }
    final key = '$characterKey|${characterSyncOperationTargetKey(operation)}';
    if (!byKey.containsKey(key)) {
      orderedKeys.add(key);
    }
    byKey[key] = operation;
  }
  return [
    for (final key in orderedKeys)
      if (byKey[key] != null) byKey[key]!,
  ];
}

class _OperationBuilder {
  _OperationBuilder({
    required this.previous,
    required this.next,
    required this.localId,
    required this.serverId,
    required this.createdAt,
    required this.nextChangeId,
  });

  final CharacterData previous;
  final CharacterData next;
  final int localId;
  final int serverId;
  final DateTime createdAt;
  final String Function() nextChangeId;

  final List<CharacterSyncOperationData> _operations = [];

  List<CharacterSyncOperationData> build() {
    _addStringField('name', previous.name, next.name);
    _addStringField('age', previous.age, next.age);
    _addStringField('height', previous.height, next.height);
    _addStringField('weight', previous.weight, next.weight);
    _addStringField('eyes', previous.eyes, next.eyes);
    _addStringField('skin', previous.skin, next.skin);
    _addStringField('hair', previous.hair, next.hair);
    _addStringField('appearance', previous.appearance, next.appearance);
    _addStringField('backstory', previous.backstory, next.backstory);
    _addStringField('goals', previous.goals, next.goals);
    _addStringField(
      'alliesOrganizations',
      previous.alliesOrganizations,
      next.alliesOrganizations,
    );
    _addStringField(
      'personalityTraits',
      previous.personalityTraits,
      next.personalityTraits,
    );
    _addStringField('ideals', previous.ideals, next.ideals);
    _addStringField('bonds', previous.bonds, next.bonds);
    _addStringField('flaws', previous.flaws, next.flaws);
    _addIntField('experience', previous.experience, next.experience);
    _addField(
      'alignmentValue',
      previous.alignmentValue,
      next.alignmentValue,
      (value) => CharacterSyncValueData(alignmentValue: value),
    );
    _addIntField('race', previous.race?.id, next.race?.id);
    _addIntField('subrace', previous.subrace?.id, next.subrace?.id);
    _addIntField('background', previous.background?.id, next.background?.id);
    _addBoolField(
      'useFlexibleAbilityBonuses',
      previous.useFlexibleAbilityBonuses,
      next.useFlexibleAbilityBonuses,
    );
    _addIntField('temporaryHp', previous.temporaryHp, next.temporaryHp);
    _addIntField('currentHp', previous.currentHp, next.currentHp);
    _addIntField(
      'deathSaveSuccesses',
      previous.deathSaveSuccesses,
      next.deathSaveSuccesses,
    );
    _addIntField(
      'deathSaveFailures',
      previous.deathSaveFailures,
      next.deathSaveFailures,
    );
    _addIntField(
        'hpPerLevelBonus', previous.hpPerLevelBonus, next.hpPerLevelBonus);
    _addIntField('hpFlatBonus', previous.hpFlatBonus, next.hpFlatBonus);
    _addStringIntMap('baseAbilityScores', previous.baseAbilityScores,
        next.baseAbilityScores);
    _addStringIntMap(
      'customAbilityBonuses',
      previous.customAbilityBonuses,
      next.customAbilityBonuses,
    );
    _addStringIntMap(
        'currentHitDice', previous.currentHitDice, next.currentHitDice);
    _addStringIntMap(
      'hitDiceMaxOverrides',
      previous.hitDiceMaxOverrides,
      next.hitDiceMaxOverrides,
    );
    _addIntIntMap('currentSpellSlots', previous.currentSpellSlots,
        next.currentSpellSlots);
    _addStringField(
      'activeConcentrationSpellName',
      previous.activeConcentrationSpellName,
      next.activeConcentrationSpellName,
    );
    _addIntField(
      'customInitiativeBonus',
      previous.customInitiativeBonus,
      next.customInitiativeBonus,
    );
    _addIntField(
      'customArmorClassBonus',
      previous.customArmorClassBonus,
      next.customArmorClassBonus,
    );
    _addIntField('walkingSpeed', previous.walkingSpeed, next.walkingSpeed);
    _addIntField('swimmingSpeed', previous.swimmingSpeed, next.swimmingSpeed);
    _addIntField('climbingSpeed', previous.climbingSpeed, next.climbingSpeed);
    _addIntField('flyingSpeed', previous.flyingSpeed, next.flyingSpeed);
    _addField(
      'displayedSpeedKind',
      previous.displayedSpeedKind,
      next.displayedSpeedKind,
      (value) => CharacterSyncValueData(speedKindValue: value),
    );
    _addIntField(
      'customSpellSaveDcBonus',
      previous.customSpellSaveDcBonus,
      next.customSpellSaveDcBonus,
    );
    _addIntField(
      'customSpellAttackBonus',
      previous.customSpellAttackBonus,
      next.customSpellAttackBonus,
    );
    _addPreparedSpellMembers();
    _addConditionMembers();
    _addIntField(
        'exhaustionLevel', previous.exhaustionLevel, next.exhaustionLevel);
    _addBoolField('inspiration', previous.inspiration, next.inspiration);
    _addField(
      'equippedArmor',
      previous.equippedArmor,
      next.equippedArmor,
      (value) => CharacterSyncValueData(equipmentSelectionValue: value),
    );
    _addField(
      'equippedShield',
      previous.equippedShield,
      next.equippedShield,
      (value) => CharacterSyncValueData(equipmentSelectionValue: value),
    );
    _addSkillProficiencyMembers();
    _addSavingThrowProficiencyMembers();
    _addField(
      'manualLanguageOverrides',
      previous.manualLanguageOverrides,
      next.manualLanguageOverrides,
      (value) => CharacterSyncValueData(languageOverridesValue: value),
    );
    _addField(
      'manualToolProficiencyOverrides',
      previous.manualToolProficiencyOverrides,
      next.manualToolProficiencyOverrides,
      (value) => CharacterSyncValueData(toolProficiencyOverridesValue: value),
    );
    _addField(
      'manualWeaponProficiencyOverrides',
      previous.manualWeaponProficiencyOverrides,
      next.manualWeaponProficiencyOverrides,
      (value) => CharacterSyncValueData(weaponProficiencyOverridesValue: value),
    );
    _addField(
      'manualArmorTrainingOverrides',
      previous.manualArmorTrainingOverrides,
      next.manualArmorTrainingOverrides,
      (value) => CharacterSyncValueData(armorTrainingOverridesValue: value),
    );

    _addListItems(
      'notes',
      previous.notes,
      next.notes,
      (item) => item.id,
      (item) => CharacterSyncValueData(noteValue: item),
    );
    _addListItems(
      'equipment',
      previous.equipment,
      next.equipment,
      (item) => item.id,
      (item) => CharacterSyncValueData(equipmentValue: item),
    );
    _addListItems(
      'attacks',
      previous.attacks,
      next.attacks,
      (item) => item.id,
      (item) => CharacterSyncValueData(attackValue: item),
    );
    _addFeatureOverrideMembers();
    _addResourceStates();
    _addListItems(
      'classEntries',
      previous.classEntries,
      next.classEntries,
      (item) => item.id,
      (item) => CharacterSyncValueData(classEntryValue: item),
    );
    _addListItems(
      'choices',
      previous.choices,
      next.choices,
      (item) => item.id,
      (item) => CharacterSyncValueData(choiceValue: item),
    );
    _addListItems(
      'skillSelections',
      previous.skillSelections,
      next.skillSelections,
      (item) => item.id,
      (item) => CharacterSyncValueData(skillSelectionValue: item),
    );
    _addListItems(
      'spellSelections',
      previous.spellSelections,
      next.spellSelections,
      (item) => item.id,
      (item) => CharacterSyncValueData(spellSelectionValue: item),
    );
    _addStartingEquipmentSelections();
    return _operations;
  }

  void _addStringField(String field, String? left, String? right) {
    _addField(field, left, right,
        (value) => CharacterSyncValueData(stringValue: value));
  }

  void _addIntField(String field, int? left, int? right) {
    _addField(
        field, left, right, (value) => CharacterSyncValueData(intValue: value));
  }

  void _addBoolField(String field, bool? left, bool? right) {
    _addField(field, left, right,
        (value) => CharacterSyncValueData(boolValue: value));
  }

  void _addField<T>(
    String field,
    T? left,
    T? right,
    CharacterSyncValueData Function(T? value) valueBuilder,
  ) {
    if (_jsonEquals(left, right)) return;
    _operations.add(
      _operation(
        type: CharacterSyncOperationType.setField,
        targetType: CharacterSyncTargetType.field,
        fieldPath: field,
        targetId: field,
        value: valueBuilder(right),
        baseTargetRevision: _baseRevision(characterSyncFieldTargetKey(field)),
      ),
    );
  }

  void _addStringIntMap(
    String field,
    Map<String, int>? left,
    Map<String, int>? right,
  ) {
    final keys = {...?left?.keys, ...?right?.keys}.toList()..sort();
    for (final key in keys) {
      _addMapEntry(field, key, left?[key], right?[key]);
    }
  }

  void _addIntIntMap(String field, Map<int, int>? left, Map<int, int>? right) {
    final keys = {...?left?.keys, ...?right?.keys}.toList()..sort();
    for (final key in keys) {
      _addMapEntry(field, key.toString(), left?[key], right?[key]);
    }
  }

  void _addMapEntry(String field, String key, int? left, int? right) {
    if (left == right) return;
    final targetKey = characterSyncMapTargetKey(field, key);
    _operations.add(
      _operation(
        type: right == null
            ? CharacterSyncOperationType.removeMapEntry
            : CharacterSyncOperationType.setMapEntry,
        targetType: CharacterSyncTargetType.mapEntry,
        fieldPath: field,
        targetId: key,
        value: right == null ? null : CharacterSyncValueData(intValue: right),
        baseTargetRevision: _baseRevision(targetKey),
      ),
    );
  }

  void _addListItems<T>(
    String field,
    List<T>? left,
    List<T>? right,
    String? Function(T item) idOf,
    CharacterSyncValueData Function(T item) payloadOf,
  ) {
    final leftById = _itemsById(left, idOf);
    final rightById = _itemsById(right, idOf);
    final ids = {...leftById.keys, ...rightById.keys}.toList()..sort();
    for (final id in ids) {
      final leftItem = leftById[id];
      final rightItem = rightById[id];
      if (_jsonEquals(leftItem, rightItem)) continue;
      final targetKey = characterSyncItemTargetKey(field, id);
      _operations.add(
        _operation(
          type: rightItem == null
              ? CharacterSyncOperationType.removeListItem
              : CharacterSyncOperationType.upsertListItem,
          targetType: CharacterSyncTargetType.listItem,
          fieldPath: field,
          targetId: id,
          itemPayload: rightItem == null ? null : payloadOf(rightItem),
          baseTargetRevision: _baseRevision(targetKey),
        ),
      );
    }
  }

  void _addResourceStates() {
    final leftById = {
      for (final state
          in previous.resourceStates ?? const <CharacterResourceStateData>[])
        _resourceTargetId(state): state,
    };
    final rightById = {
      for (final state
          in next.resourceStates ?? const <CharacterResourceStateData>[])
        _resourceTargetId(state): state,
    };
    final ids = {...leftById.keys, ...rightById.keys}.toList()..sort();
    for (final id in ids) {
      final leftItem = leftById[id];
      final rightItem = rightById[id];
      if (_jsonEquals(leftItem, rightItem)) continue;
      final targetKey = characterSyncTargetKey(
        'resource',
        decodeCharacterSyncCompositeId(id),
      );
      _operations.add(
        _operation(
          type: rightItem == null
              ? CharacterSyncOperationType.removeListItem
              : CharacterSyncOperationType.upsertListItem,
          targetType: CharacterSyncTargetType.resource,
          fieldPath: 'resourceStates',
          targetId: id,
          itemPayload: rightItem == null
              ? null
              : CharacterSyncValueData(resourceStateValue: rightItem),
          baseTargetRevision: _baseRevision(targetKey),
        ),
      );
    }
  }

  void _addConditionMembers() {
    final left = {
      for (final condition
          in previous.activeConditions ?? const <ConditionType>[])
        if (condition != ConditionType.exhaustion) condition.name: condition,
    };
    final right = {
      for (final condition in next.activeConditions ?? const <ConditionType>[])
        if (condition != ConditionType.exhaustion) condition.name: condition,
    };
    for (final member in {...left.keys, ...right.keys}.toList()..sort()) {
      if (left.containsKey(member) == right.containsKey(member)) continue;
      _operations.add(
        _operation(
          type: right.containsKey(member)
              ? CharacterSyncOperationType.addSetMember
              : CharacterSyncOperationType.removeSetMember,
          targetType: CharacterSyncTargetType.member,
          fieldPath: 'activeConditions',
          targetId: member,
          value: right[member] == null
              ? null
              : CharacterSyncValueData(conditionValue: right[member]),
          baseTargetRevision: _baseMemberRevision(
            'activeConditions',
            member,
          ),
        ),
      );
    }
  }

  void _addPreparedSpellMembers() {
    final left = _preparedSpellKeySet(previous.preparedSpellKeys);
    final right = _preparedSpellKeySet(next.preparedSpellKeys);
    for (final member in {...left, ...right}.toList()..sort()) {
      if (left.contains(member) == right.contains(member)) continue;
      _operations.add(
        _operation(
          type: right.contains(member)
              ? CharacterSyncOperationType.addSetMember
              : CharacterSyncOperationType.removeSetMember,
          targetType: CharacterSyncTargetType.member,
          fieldPath: 'preparedSpellKeys',
          targetId: member,
          value: right.contains(member)
              ? CharacterSyncValueData(stringValue: member)
              : null,
          baseTargetRevision: _baseMemberRevision(
            'preparedSpellKeys',
            member,
          ),
        ),
      );
    }
  }

  void _addSkillProficiencyMembers() {
    if (previous.manualSkillProficiencyOverrides == null &&
        next.manualSkillProficiencyOverrides == null) {
      _addField(
        'manualSkillProficiencies',
        previous.manualSkillProficiencies,
        next.manualSkillProficiencies,
        (value) => CharacterSyncValueData(
          skillProficiencyListValue: value,
        ),
      );
      return;
    }
    final left = _skillOverridesForSync(previous);
    final right = _skillOverridesForSync(next);
    for (final member in {...left.keys, ...right.keys}.toList()..sort()) {
      if (_jsonEquals(left[member], right[member])) continue;
      _operations.add(
        _operation(
          type: CharacterSyncOperationType.setMemberValue,
          targetType: CharacterSyncTargetType.member,
          fieldPath: 'manualSkillProficiencyOverrides',
          targetId: member,
          value: CharacterSyncValueData(
            skillProficiencyValue: right[member],
          ),
          baseTargetRevision: _baseMemberRevision(
            'manualSkillProficiencyOverrides',
            member,
            legacyField: 'manualSkillProficiencies',
          ),
        ),
      );
    }
  }

  void _addSavingThrowProficiencyMembers() {
    if (previous.manualSavingThrowProficiencyOverrides == null &&
        next.manualSavingThrowProficiencyOverrides == null) {
      _addField(
        'manualSavingThrowProficiencies',
        previous.manualSavingThrowProficiencies,
        next.manualSavingThrowProficiencies,
        (value) => CharacterSyncValueData(abilityListValue: value),
      );
      return;
    }
    final left = _savingThrowOverridesForSync(previous);
    final right = _savingThrowOverridesForSync(next);
    for (final member in {...left.keys, ...right.keys}.toList()..sort()) {
      if (_jsonEquals(left[member], right[member])) continue;
      _operations.add(
        _operation(
          type: CharacterSyncOperationType.setMemberValue,
          targetType: CharacterSyncTargetType.member,
          fieldPath: 'manualSavingThrowProficiencyOverrides',
          targetId: member,
          value: CharacterSyncValueData(
            savingThrowProficiencyOverrideValue: right[member],
          ),
          baseTargetRevision: _baseMemberRevision(
            'manualSavingThrowProficiencyOverrides',
            member,
            legacyField: 'manualSavingThrowProficiencies',
          ),
        ),
      );
    }
  }

  void _addFeatureOverrideMembers() {
    final left = {
      for (final item in previous.featureOverrides ??
          const <CharacterFeatureOverrideData>[])
        characterSyncFeatureOverrideId(item): item,
    };
    final right = {
      for (final item
          in next.featureOverrides ?? const <CharacterFeatureOverrideData>[])
        characterSyncFeatureOverrideId(item): item,
    };
    for (final id in {...left.keys, ...right.keys}.toList()..sort()) {
      final leftItem = left[id];
      final rightItem = right[id];
      final identity = rightItem ?? leftItem!;
      _addFeatureOverrideTextMember(
        identity,
        'name',
        leftItem?.name,
        rightItem?.name,
      );
      _addFeatureOverrideTextMember(
        identity,
        'description',
        leftItem?.description,
        rightItem?.description,
      );
      final leftTags = {...?leftItem?.tags};
      final rightTags = {...?rightItem?.tags};
      final tags = {...leftTags, ...rightTags}.toList()
        ..sort((a, b) => a.name.compareTo(b.name));
      for (final tag in tags) {
        if (leftTags.contains(tag) == rightTags.contains(tag)) continue;
        final targetId = encodeCharacterSyncCompositeId([
          identity.sourceType.name,
          identity.sourceId.toString(),
          'tag',
          tag.name,
        ]);
        final targetKey = characterSyncFeatureOverrideTagTargetKey(
          identity.sourceType,
          identity.sourceId,
          tag,
        );
        _operations.add(
          _operation(
            type: rightTags.contains(tag)
                ? CharacterSyncOperationType.addSetMember
                : CharacterSyncOperationType.removeSetMember,
            targetType: CharacterSyncTargetType.member,
            fieldPath: 'featureOverrides',
            targetId: targetId,
            value: rightTags.contains(tag)
                ? CharacterSyncValueData(featureTagValue: tag)
                : null,
            baseTargetRevision: _featureOverrideBaseRevision(
              targetKey,
              identity,
            ),
          ),
        );
      }
    }
  }

  void _addFeatureOverrideTextMember(
    CharacterFeatureOverrideData identity,
    String field,
    String? left,
    String? right,
  ) {
    if (left == right) return;
    final targetId = encodeCharacterSyncCompositeId([
      identity.sourceType.name,
      identity.sourceId.toString(),
      field,
    ]);
    final targetKey = characterSyncFeatureOverrideFieldTargetKey(
      identity.sourceType,
      identity.sourceId,
      field,
    );
    _operations.add(
      _operation(
        type: CharacterSyncOperationType.setMemberValue,
        targetType: CharacterSyncTargetType.member,
        fieldPath: 'featureOverrides',
        targetId: targetId,
        value: CharacterSyncValueData(stringValue: right),
        baseTargetRevision: _featureOverrideBaseRevision(targetKey, identity),
      ),
    );
  }

  void _addStartingEquipmentSelections() {
    final previousById = _itemsById(
      previous.startingEquipmentSelections,
      characterSyncStartingEquipmentSelectionId,
    );
    final nextById = _itemsById(
      next.startingEquipmentSelections,
      characterSyncStartingEquipmentSelectionId,
    );
    for (final selectionId in {...previousById.keys, ...nextById.keys}) {
      final leftSelection = previousById[selectionId];
      final rightSelection = nextById[selectionId];
      final leftParent = leftSelection?.copyWith(resolutions: null);
      final rightParent = rightSelection?.copyWith(resolutions: null);
      if (!_jsonEquals(leftParent, rightParent)) {
        final targetKey = characterSyncItemTargetKey(
          'startingEquipmentSelections',
          selectionId,
        );
        _operations.add(
          _operation(
            type: rightParent == null
                ? CharacterSyncOperationType.removeListItem
                : CharacterSyncOperationType.upsertListItem,
            targetType: CharacterSyncTargetType.listItem,
            fieldPath: 'startingEquipmentSelections',
            targetId: selectionId,
            itemPayload: rightParent == null
                ? null
                : CharacterSyncValueData(
                    startingEquipmentSelectionValue: rightParent,
                  ),
            baseTargetRevision: _baseRevision(
              targetKey,
              aliases: [
                if (leftSelection?.id != null)
                  characterSyncItemTargetKey(
                    'startingEquipmentSelections',
                    leftSelection!.id!,
                  ),
              ],
            ),
          ),
        );
      }
      final leftResolutions = _itemsById(
        leftSelection?.resolutions,
        (item) => item.sourceLineEntryId?.toString(),
      );
      final rightResolutions = _itemsById(
        rightSelection?.resolutions,
        (item) => item.sourceLineEntryId?.toString(),
      );
      final resolutionIds = {
        ...leftResolutions.keys,
        ...rightResolutions.keys,
      }.toList()
        ..sort();
      for (final sourceLineEntryId in resolutionIds) {
        final leftItem = leftResolutions[sourceLineEntryId];
        final rightItem = rightResolutions[sourceLineEntryId];
        if (_jsonEquals(leftItem, rightItem)) continue;
        final targetId = encodeCharacterSyncCompositeId(
          [selectionId, sourceLineEntryId],
        );
        final targetKey = characterSyncStartingEquipmentResolutionTargetKey(
          selectionId,
          sourceLineEntryId,
        );
        _operations.add(
          _operation(
            type: rightItem == null
                ? CharacterSyncOperationType.removeListItem
                : CharacterSyncOperationType.upsertListItem,
            targetType: CharacterSyncTargetType.startingEquipmentResolution,
            fieldPath: 'startingEquipmentSelections',
            targetId: targetId,
            itemPayload: rightItem == null
                ? null
                : CharacterSyncValueData(
                    startingEquipmentResolutionValue: rightItem,
                  ),
            baseTargetRevision: _baseRevision(
              targetKey,
              aliases: [
                if (leftSelection?.id != null && leftItem?.id != null)
                  characterSyncTargetKey('item', [
                    'startingEquipmentSelections',
                    leftSelection!.id!,
                    'resolution',
                    leftItem!.id!,
                  ]),
              ],
            ),
          ),
        );
      }
    }
  }

  CharacterSyncOperationData _operation({
    required CharacterSyncOperationType type,
    required CharacterSyncTargetType targetType,
    required String fieldPath,
    required String targetId,
    CharacterSyncValueData? value,
    CharacterSyncValueData? itemPayload,
    required int baseTargetRevision,
  }) {
    return CharacterSyncOperationData(
      id: nextChangeId(),
      characterId: serverId,
      localCharacterId: localId,
      type: type,
      targetType: targetType,
      targetId: targetId,
      fieldPath: fieldPath,
      value: value,
      itemPayload: itemPayload,
      baseCharacterRevision: previous.version ?? 0,
      baseTargetRevision: baseTargetRevision,
      createdAt: createdAt,
    );
  }

  int _baseRevision(String targetKey, {Iterable<String> aliases = const []}) {
    final revisions = previous.syncTargetRevisions;
    return revisions?[targetKey] ??
        _maxRevision(revisions, aliases) ??
        previous.version ??
        0;
  }

  int _baseMemberRevision(
    String field,
    String member, {
    String? legacyField,
  }) {
    final revisions = previous.syncTargetRevisions;
    return revisions?[characterSyncMemberTargetKey(field, member)] ??
        revisions?[characterSyncMemberBaselineTargetKey(field)] ??
        revisions?[characterSyncFieldTargetKey(legacyField ?? field)] ??
        previous.version ??
        0;
  }

  int _featureOverrideBaseRevision(
    String targetKey,
    CharacterFeatureOverrideData item,
  ) {
    final revisions = previous.syncTargetRevisions;
    final oldNaturalId = characterSyncFeatureOverrideId(item);
    final memberBaseline =
        revisions?[characterSyncMemberBaselineTargetKey('featureOverrides')];
    final oldKeys = <String>[
      characterSyncItemTargetKey('featureOverrides', oldNaturalId),
      if (item.id != null)
        characterSyncItemTargetKey('featureOverrides', item.id!),
      for (final key in revisions?.keys ?? const <String>[])
        if (key.startsWith('item:featureOverrides:')) key,
    ];
    return revisions?[targetKey] ??
        memberBaseline ??
        _maxRevision(revisions, oldKeys) ??
        revisions?[characterSyncFieldTargetKey('featureOverrides')] ??
        previous.version ??
        0;
  }
}

Map<String, T> _itemsById<T>(List<T>? items, String? Function(T item) idOf) {
  return {
    for (final item in items ?? <T>[])
      if (idOf(item) != null) idOf(item)!: item,
  };
}

String _resourceTargetId(CharacterResourceStateData state) {
  return encodeCharacterSyncCompositeId([
    state.sourceType.name,
    state.sourceId.toString(),
    state.resourceKey,
  ]);
}

int? _maxRevision(Map<String, int>? revisions, Iterable<String> keys) {
  int? result;
  for (final key in keys) {
    final revision = revisions?[key];
    if (revision != null && (result == null || revision > result)) {
      result = revision;
    }
  }
  return result;
}

Set<String> _preparedSpellKeySet(List<String>? values) {
  return {
    for (final value in values ?? const <String>[])
      if (value.trim().isNotEmpty) value.trim(),
  };
}

Map<String, CharacterSkillProficiencyState> _skillOverridesByName(
  List<CharacterSkillProficiencyState>? values,
) {
  return {
    for (final value in values ?? const <CharacterSkillProficiencyState>[])
      value.skill.name: value,
  };
}

Map<String, CharacterSkillProficiencyState> _skillOverridesForSync(
  CharacterData character,
) {
  final overrides = character.manualSkillProficiencyOverrides;
  if (overrides != null) return _skillOverridesByName(overrides);
  final legacy = character.manualSkillProficiencies;
  if (legacy == null) return const {};
  final legacyBySkill = _skillOverridesByName(legacy);
  return {
    for (final skill in Skill.values)
      skill.name: CharacterSkillProficiencyState(
        skill: skill,
        level: legacyBySkill[skill.name]?.level ??
            CharacterSkillProficiencyLevel.none,
      ),
  };
}

Map<String, CharacterSavingThrowProficiencyOverrideData>
    _savingThrowOverridesByName(
  List<CharacterSavingThrowProficiencyOverrideData>? values,
) {
  return {
    for (final value
        in values ?? const <CharacterSavingThrowProficiencyOverrideData>[])
      value.ability.name: value,
  };
}

Map<String, CharacterSavingThrowProficiencyOverrideData>
    _savingThrowOverridesForSync(CharacterData character) {
  final overrides = character.manualSavingThrowProficiencyOverrides;
  if (overrides != null) return _savingThrowOverridesByName(overrides);
  final legacy = character.manualSavingThrowProficiencies;
  if (legacy == null) return const {};
  return {
    for (final ability in Ability.values)
      ability.name: CharacterSavingThrowProficiencyOverrideData(
        ability: ability,
        state: legacy.contains(ability)
            ? CharacterSavingThrowProficiencyOverride.add
            : CharacterSavingThrowProficiencyOverride.remove,
      ),
  };
}

bool _jsonEquals(Object? left, Object? right) {
  return jsonEncode(_normalizeJson(left)) == jsonEncode(_normalizeJson(right));
}

Object? _normalizeJson(Object? value) {
  if (value == null || value is num || value is bool || value is String) {
    return value;
  }
  if (value is DateTime) {
    return value.toUtc().toIso8601String();
  }
  if (value is SerializableModel) {
    final json = value.toJson();
    if (json is Map) {
      final normalizedMap = Map<String, dynamic>.from(json);
      normalizedMap.remove('updatedAt');
      normalizedMap.remove('derived');
      normalizedMap.remove('version');
      normalizedMap.remove('syncTargetRevisions');
      normalizedMap.remove('syncBarrierTokens');
      return _normalizeJson(normalizedMap);
    }
    return _normalizeJson(json);
  }
  if (value is Iterable) {
    return [for (final item in value) _normalizeJson(item)];
  }
  if (value is Map) {
    final normalized = <String, Object?>{};
    final keys = value.keys.map((key) => key.toString()).toList()..sort();
    for (final key in keys) {
      normalized[key] = _normalizeJson(value[key]);
    }
    return normalized;
  }
  return value.toString();
}
