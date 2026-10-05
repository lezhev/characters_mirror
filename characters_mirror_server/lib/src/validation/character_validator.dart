import 'dart:convert';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

import 'package:characters_mirror_server/src/generated/protocol.dart';

import 'custom_content_validator.dart';
import 'item_validator.dart';
import 'rules.dart';
import 'character_proficiency_override_validator.dart';
import 'validation_exception.dart';

abstract final class CharacterValidator {
  static void validate(CharacterData character) {
    _validateTexts(character);
    _validateNumbers(character);
    _validateCollections(character);
    _validateRelations(character);

    ItemValidator.validateInventoryItems('equipment', character.equipment);
    ItemValidator.validateAttacks('attacks', character.attacks);
    CustomContentValidator.validateNotes('notes', character.notes);
    CustomContentValidator.validateFeatureOverrides(
      'featureOverrides',
      character.featureOverrides,
    );
    CustomContentValidator.validateResourceStates(
      'resourceStates',
      character.resourceStates,
    );
    CharacterProficiencyOverrideValidator.validate(character);
  }

  static void validateSyncRequest(CharacterSyncRequest request) {
    Rules.largeCollection('changes', request.changes);
    Rules.largeCollection('operations', request.operations);
    final changes = request.changes;
    final operations = request.operations;
    if ((changes?.isNotEmpty ?? false) && (operations?.isNotEmpty ?? false)) {
      throw InputValidationException(
        'sync',
        'changes and operations cannot be sent in the same request.',
      );
    }

    for (var index = 0; index < (changes?.length ?? 0); index++) {
      final change = changes![index];
      final prefix = 'changes[$index]';
      Rules.shortText('$prefix.id', change.id);
      Rules.shortText('$prefix.entityId', change.entityId);
    }

    for (var index = 0; index < (operations?.length ?? 0); index++) {
      final operation = operations![index];
      final prefix = 'operations[$index]';
      Rules.shortText('$prefix.id', operation.id);
      Rules.shortText('$prefix.targetId', operation.targetId);
      Rules.shortText('$prefix.fieldPath', operation.fieldPath);
      Rules.nonNegativeInt(
        '$prefix.baseCharacterRevision',
        operation.baseCharacterRevision,
      );
      Rules.nonNegativeInt(
        '$prefix.baseTargetRevision',
        operation.baseTargetRevision,
      );
    }
  }

  static void validateLegacySyncChanges(CharacterSyncRequest request) {
    final changes = request.changes;
    if (changes == null) return;

    for (var index = 0; index < changes.length; index++) {
      final change = changes[index];
      final prefix = 'changes[$index]';
      Rules.shortText('$prefix.id', change.id);
      Rules.shortText('$prefix.entityId', change.entityId);
    }
  }

  static void validateLogicalIdentities(
    CharacterData character, {
    required String? field,
  }) {
    switch (field) {
      case 'choices':
        _validateChoices('choices', character.choices);
        return;
      case 'skillSelections':
        _validateSkillSelections(
          'skillSelections',
          character.skillSelections,
        );
        return;
      case 'spellSelections':
        _validateSpellSelections(
          'spellSelections',
          character.spellSelections,
        );
        return;
      case 'startingEquipmentSelections':
        _validateStartingEquipmentSelections(
          'startingEquipmentSelections',
          character.startingEquipmentSelections,
        );
        return;
      case 'featureOverrides':
        _validateUniqueValues(
          'featureOverrides',
          character.featureOverrides,
          (value) => '${value.sourceType.name}:${value.sourceId}',
        );
        return;
      default:
        return;
    }
  }

  static void _validateTexts(CharacterData character) {
    Rules.shortText('characterName', character.name);
    Rules.shortText('age', character.age);
    Rules.shortText('height', character.height);
    Rules.shortText('weight', character.weight);
    Rules.shortText('eyes', character.eyes);
    Rules.shortText('skin', character.skin);
    Rules.shortText('hair', character.hair);
    Rules.shortText(
      'activeConcentrationSpellName',
      character.activeConcentrationSpellName,
    );

    Rules.longText('appearance', character.appearance);
    Rules.longText('backstory', character.backstory);
    Rules.longText('goals', character.goals);
    Rules.longText('alliesOrganizations', character.alliesOrganizations);
    Rules.longText('personalityTraits', character.personalityTraits);
    Rules.longText('ideals', character.ideals);
    Rules.longText('bonds', character.bonds);
    Rules.longText('flaws', character.flaws);
  }

  static void _validateNumbers(CharacterData character) {
    Rules.nonNegativeInt('version', character.version);
    Rules.nonNegativeInt('experience', character.experience);
    Rules.nonNegativeInt('temporaryHp', character.temporaryHp);
    Rules.nonNegativeInt('currentHp', character.currentHp);
    Rules.rangeInt('deathSaveSuccesses', character.deathSaveSuccesses,
        min: 0, max: 3);
    Rules.rangeInt('deathSaveFailures', character.deathSaveFailures,
        min: 0, max: 3);
    Rules.boundedInt('hpPerLevelBonus', character.hpPerLevelBonus);
    Rules.boundedInt('hpFlatBonus', character.hpFlatBonus);
    Rules.boundedInt('customInitiativeBonus', character.customInitiativeBonus);
    Rules.boundedInt('customArmorClassBonus', character.customArmorClassBonus);
    Rules.nonNegativeInt('walkingSpeed', character.walkingSpeed);
    Rules.nonNegativeInt('swimmingSpeed', character.swimmingSpeed);
    Rules.nonNegativeInt('climbingSpeed', character.climbingSpeed);
    Rules.nonNegativeInt('flyingSpeed', character.flyingSpeed);
    Rules.boundedInt(
      'customSpellSaveDcBonus',
      character.customSpellSaveDcBonus,
    );
    Rules.boundedInt(
      'customSpellAttackBonus',
      character.customSpellAttackBonus,
    );
    Rules.rangeInt('exhaustionLevel', character.exhaustionLevel,
        min: 0, max: 6);

    _validateStringIntMap(
      'baseAbilityScores',
      character.baseAbilityScores,
      valueRule: Rules.nonNegativeInt,
    );
    _validateStringIntMap(
      'customAbilityBonuses',
      character.customAbilityBonuses,
      valueRule: Rules.boundedInt,
    );
    _validateStringIntMap(
      'currentHitDice',
      character.currentHitDice,
      valueRule: Rules.nonNegativeInt,
    );
    _validateStringIntMap(
      'hitDiceMaxOverrides',
      character.hitDiceMaxOverrides,
      valueRule: Rules.nonNegativeInt,
    );
    _validateSpellSlotMap('currentSpellSlots', character.currentSpellSlots);
  }

  static void _validateCollections(CharacterData character) {
    Rules.mediumCollection('preparedSpellKeys', character.preparedSpellKeys);
    final preparedSpellKeys = character.preparedSpellKeys;
    if (preparedSpellKeys != null) {
      for (var index = 0; index < preparedSpellKeys.length; index++) {
        Rules.shortText(
          'preparedSpellKeys[$index]',
          preparedSpellKeys[index],
        );
      }
    }

    Rules.smallCollection('activeConditions', character.activeConditions);
    Rules.mediumCollection(
      'manualSkillProficiencies',
      character.manualSkillProficiencies,
    );
    Rules.mediumCollection(
      'manualSavingThrowProficiencies',
      character.manualSavingThrowProficiencies,
    );
    Rules.mediumCollection(
      'manualSkillProficiencyOverrides',
      character.manualSkillProficiencyOverrides,
    );
    Rules.mediumCollection(
      'manualSavingThrowProficiencyOverrides',
      character.manualSavingThrowProficiencyOverrides,
    );
    _validateUniqueValues(
      'manualSkillProficiencyOverrides',
      character.manualSkillProficiencyOverrides,
      (value) => value.skill.name,
    );
    _validateUniqueValues(
      'manualSavingThrowProficiencyOverrides',
      character.manualSavingThrowProficiencyOverrides,
      (value) => value.ability.name,
    );
  }

  static void _validateRelations(CharacterData character) {
    Rules.nonNegativeInt('race.id', character.race?.id);
    Rules.nonNegativeInt('subrace.id', character.subrace?.id);
    Rules.nonNegativeInt('background.id', character.background?.id);

    _validateClassEntries('classEntries', character.classEntries);
    _validateChoices('choices', character.choices);
    _validateSkillSelections('skillSelections', character.skillSelections);
    _validateSpellSelections('spellSelections', character.spellSelections);
    _validateStartingEquipmentSelections(
      'startingEquipmentSelections',
      character.startingEquipmentSelections,
    );
  }

  static void _validateClassEntries(
    String field,
    List<CharacterClassEntryData>? entries,
  ) {
    Rules.mediumCollection(field, entries);
    if (entries == null) return;

    for (var index = 0; index < entries.length; index++) {
      final entry = entries[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', entry.id);
      if (entry.classData != null && entry.classData?.id == null) {
        throw InputValidationException(
          '$prefix.classData.id',
          'is required when classData is provided.',
        );
      }
      Rules.nonNegativeInt('$prefix.classData.id', entry.classData?.id);
      Rules.nonNegativeInt('$prefix.subclass.id', entry.subclass?.id);
      Rules.nonNegativeInt('$prefix.level', entry.level);
      Rules.nonNegativeInt('$prefix.classOrder', entry.classOrder);
      Rules.smallCollection('$prefix.hpRolledValues', entry.hpRolledValues);
      final hpRolledValues = entry.hpRolledValues;
      if (hpRolledValues != null) {
        for (var valueIndex = 0;
            valueIndex < hpRolledValues.length;
            valueIndex++) {
          Rules.nonNegativeInt(
            '$prefix.hpRolledValues[$valueIndex]',
            hpRolledValues[valueIndex],
          );
        }
      }
      Rules.mediumText('$prefix.notes', entry.notes);
    }
  }

  static void _validateChoices(
    String field,
    List<CharacterChoiceData>? choices,
  ) {
    Rules.mediumCollection(field, choices);
    if (choices == null) return;

    final logicalSlots = <String>{};
    for (var index = 0; index < choices.length; index++) {
      final choice = choices[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', choice.id);
      Rules.shortText('$prefix.classEntry.id', choice.classEntry?.id);
      Rules.shortText('$prefix.groupKey', choice.groupKey);
      Rules.shortText('$prefix.optionKey', choice.optionKey);
      Rules.nonNegativeInt('$prefix.selectionIndex', choice.selectionIndex);
      final slotKey = _choiceSlotKey(choice);
      if (slotKey != null && !logicalSlots.add(slotKey)) {
        throw InputValidationException(
          prefix,
          'duplicates logical choice slot "$slotKey".',
        );
      }
    }
  }

  static void _validateSkillSelections(
    String field,
    List<CharacterSkillSelectionData>? selections,
  ) {
    Rules.mediumCollection(field, selections);
    if (selections == null) return;

    final logicalSlots = <String>{};
    for (var index = 0; index < selections.length; index++) {
      final selection = selections[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', selection.id);
      Rules.shortText('$prefix.classEntry.id', selection.classEntry?.id);
      Rules.nonNegativeInt('$prefix.classDataId', selection.classDataId);
      Rules.nonNegativeInt(
        '$prefix.backgroundDataId',
        selection.backgroundDataId,
      );
      Rules.nonNegativeInt('$prefix.selectionIndex', selection.selectionIndex);
      final slotKey = _skillSelectionSlotKey(selection);
      if (slotKey != null && !logicalSlots.add(slotKey)) {
        throw InputValidationException(
          prefix,
          'duplicates logical skill selection slot "$slotKey".',
        );
      }
    }
  }

  static void _validateSpellSelections(
    String field,
    List<CharacterSpellSelectionData>? selections,
  ) {
    Rules.mediumCollection(field, selections);
    if (selections == null) return;

    final logicalSlots = <String>{};
    final members = <String>{};
    for (var index = 0; index < selections.length; index++) {
      final selection = selections[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', selection.id);
      Rules.shortText('$prefix.classEntry.id', selection.classEntry?.id);
      Rules.nonNegativeInt('$prefix.classDataId', selection.classDataId);
      Rules.nonNegativeInt('$prefix.spellId', selection.spellId);
      Rules.nonNegativeInt('$prefix.spell.id', selection.spell?.id);
      Rules.shortText('$prefix.spellKey', selection.spellKey);
      Rules.shortText(
          '$prefix.spell.referenceKey', selection.spell?.referenceKey);
      Rules.shortText('$prefix.spell.name', selection.spell?.name);
      Rules.nonNegativeInt('$prefix.selectionIndex', selection.selectionIndex);
      final key = selection.spellKey ??
          selection.spell?.referenceKey ??
          selection.spell?.name;
      if (key != null &&
          selection.kind != null &&
          !members.add(spellSelectionIdentity(
              classEntryId: selection.classEntry?.id,
              classDataId:
                  selection.classDataId ?? selection.classEntry?.classData?.id,
              kind: selection.kind?.name,
              spellKey: key))) {
        throw InputValidationException(
            prefix, 'duplicates spell selection for the same source and kind.');
      }
      final slotKey = _spellSelectionLogicalKey(selection);
      if (slotKey != null && !logicalSlots.add(slotKey)) {
        throw InputValidationException(
          prefix,
          'duplicates logical spell selection "$slotKey".',
        );
      }
    }
  }

  static void _validateStartingEquipmentSelections(
    String field,
    List<CharacterStartingEquipmentSelectionData>? selections,
  ) {
    Rules.mediumCollection(field, selections);
    if (selections == null) return;

    final logicalSlots = <String>{};
    for (var index = 0; index < selections.length; index++) {
      final selection = selections[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', selection.id);
      Rules.nonNegativeInt('$prefix.sourceId', selection.sourceId);
      Rules.nonNegativeInt('$prefix.sourceEntryId', selection.sourceEntryId);
      Rules.nonNegativeInt(
        '$prefix.choiceOptionEntryId',
        selection.choiceOptionEntryId,
      );
      Rules.nonNegativeInt('$prefix.selectionIndex', selection.selectionIndex);
      final slotKey = _startingEquipmentSelectionSlotKey(selection);
      if (!logicalSlots.add(slotKey)) {
        throw InputValidationException(
          prefix,
          'duplicates logical starting equipment slot "$slotKey".',
        );
      }
      _validateStartingEquipmentResolutions(
        '$prefix.resolutions',
        selection.resolutions,
      );
    }
  }

  static void _validateStartingEquipmentResolutions(
    String field,
    List<CharacterStartingEquipmentResolutionData>? resolutions,
  ) {
    Rules.smallCollection(field, resolutions);
    if (resolutions == null) return;

    final sourceLineIds = <int>{};
    for (var index = 0; index < resolutions.length; index++) {
      final resolution = resolutions[index];
      final prefix = '$field[$index]';
      Rules.shortText('$prefix.id', resolution.id);
      Rules.nonNegativeInt(
        '$prefix.sourceLineEntryId',
        resolution.sourceLineEntryId,
      );
      Rules.shortText('$prefix.referenceKey', resolution.referenceKey);
      Rules.nonNegativeInt('$prefix.quantity', resolution.quantity);
      final sourceLineEntryId = resolution.sourceLineEntryId;
      if (sourceLineEntryId != null && !sourceLineIds.add(sourceLineEntryId)) {
        throw InputValidationException(
          prefix,
          'duplicates sourceLineEntryId $sourceLineEntryId.',
        );
      }
    }
  }

  static void _validateStringIntMap(
    String field,
    Map<String, int>? values, {
    required void Function(String field, int? value) valueRule,
  }) {
    Rules.smallCollection(field, values);
    if (values == null) return;

    for (final entry in values.entries) {
      Rules.shortText('$field.key', entry.key);
      valueRule('$field.${entry.key}', entry.value);
    }
  }

  static void _validateSpellSlotMap(String field, Map<int, int>? values) {
    Rules.smallCollection(field, values);
    if (values == null) return;

    for (final entry in values.entries) {
      Rules.rangeInt('$field.level', entry.key, min: 0, max: 100);
      Rules.nonNegativeInt('$field.${entry.key}', entry.value);
    }
  }

  static void _validateUniqueValues<T>(
    String field,
    List<T>? values,
    String Function(T value) keyOf,
  ) {
    final keys = <String>{};
    for (var index = 0; index < (values?.length ?? 0); index++) {
      final key = keyOf(values![index]);
      if (!keys.add(key)) {
        throw InputValidationException(
          '$field[$index]',
          'duplicates logical key "$key".',
        );
      }
    }
  }

  static String? _choiceSlotKey(CharacterChoiceData choice) {
    if (choice.groupKey == null || choice.selectionIndex == null) {
      return null;
    }
    return _logicalKey([
      choice.classEntry?.id,
      choice.groupKey,
      choice.selectionIndex,
    ]);
  }

  static String? _skillSelectionSlotKey(
    CharacterSkillSelectionData selection,
  ) {
    if (selection.kind == null || selection.selectionIndex == null) {
      return null;
    }
    return _logicalKey([
      selection.kind!.name,
      selection.classEntry?.id,
      selection.classDataId,
      selection.backgroundDataId,
      selection.selectionIndex,
    ]);
  }

  static String? _spellSelectionLogicalKey(
    CharacterSpellSelectionData selection,
  ) {
    final kind = selection.kind;
    final spellKey = selection.spellKey ??
        selection.spell?.referenceKey ??
        selection.spell?.name;
    if (kind == null || spellKey == null) return null;
    final source = [
      selection.classEntry?.id != null ? 'entry' : 'class',
      selection.classEntry?.id ??
          selection.classDataId ??
          selection.classEntry?.classData?.id,
    ];
    if (selection.selectionIndex == null) {
      return _logicalKey([...source, kind.name, 'member', spellKey.trim()]);
    }
    return _logicalKey([
      ...source,
      kind.name,
      'slot',
      selection.selectionIndex,
    ]);
  }

  static String _startingEquipmentSelectionSlotKey(
    CharacterStartingEquipmentSelectionData selection,
  ) {
    return _logicalKey([
      selection.sourceType?.name,
      selection.sourceId,
      selection.sourceEntryId,
      selection.selectionIndex,
    ]);
  }

  static String _logicalKey(List<Object?> parts) => jsonEncode(parts);
}
