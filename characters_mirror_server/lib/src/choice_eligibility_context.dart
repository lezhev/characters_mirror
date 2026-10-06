import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

/// Builds the shared facts used to evaluate options in a choice group.
ChoiceEligibilityContext buildChoiceEligibilityContext({
  required CharacterData character,
  required String evaluatingGroupKey,
  required Map<String, List<ChoiceOptionData>> selectedOptionsByGroupKey,
  required List<ChoiceGroupData> groups,
  required Map<String, int> abilityScores,
  required List<ClassFeatureData> currentClassFeatures,
  required List<SubclassFeatureData> currentSubclassFeatures,
}) {
  final ownedSkills = <Skill>{
    for (final feature in currentClassFeatures) ...?feature.grantedSkills,
    for (final feature in currentSubclassFeatures) ...?feature.grantedSkills,
    ...?character.race?.skillProficiencies,
    ...?character.subrace?.skillProficiencies,
    ...?character.background?.skillProficiencies,
    for (final selection
        in character.skillSelections ?? const <CharacterSkillSelectionData>[])
      if (selection.skill != null) selection.skill!,
  };
  final ownedToolKeys = <String>{
    for (final feature in currentClassFeatures) ...?feature.grantedToolKeys,
    for (final feature in currentSubclassFeatures) ...?feature.grantedToolKeys,
    ...?character.race?.toolProficiencyKeys,
    ...?character.subrace?.toolProficiencyKeys,
    ...?character.background?.toolProficiencyKeys,
  };
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
    ownedToolKeys.addAll(entry.isStartingClass == true
        ? entry.classData?.toolTrainingKeys ?? const <String>[]
        : entry.classData?.multiclassToolTrainingKeys ?? const <String>[]);
  }

  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final classLevelsByReferenceKey = <String, int>{};
  for (final entry in entries) {
    final key = _normalizedText(entry.classData?.referenceKey);
    if (key == null) continue;
    classLevelsByReferenceKey[key] =
        (classLevelsByReferenceKey[key] ?? 0) + (entry.level ?? 0);
  }
  final selectedOptionKeys = <String>{
    for (final entry in selectedOptionsByGroupKey.entries)
      for (final option in entry.value)
        encodeSelectedChoiceOptionKey(
            entry.key.trim(), option.optionKey.trim()),
  };
  final spellFacts = collectChoiceSpellFacts([
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (_normalizedText(selection.spellKey) ??
              _normalizedText(selection.spell?.referenceKey)
          case final key?)
        ChoiceSpellSelectionFact(key: key, kind: selection.kind?.name ?? ''),
  ]);
  final featureKeys = <String>{
    for (final feature in currentClassFeatures)
      if (_normalizedText(feature.referenceKey) case final key?) key,
    for (final feature in currentSubclassFeatures)
      if (_normalizedText(feature.referenceKey) case final key?) key,
  };

  final currentGroupId = groups
      .where((group) => group.referenceKey == evaluatingGroupKey)
      .map((group) => group.id)
      .firstOrNull;
  for (final entry in selectedOptionsByGroupKey.entries) {
    final otherGroupId = groups
        .where((group) => group.referenceKey == entry.key)
        .map((group) => group.id)
        .firstOrNull;
    if (otherGroupId == currentGroupId) continue;
    for (final option in entry.value) {
      ownedSkills.addAll(option.grantedSkills ?? const <Skill>[]);
      ownedToolKeys.addAll(option.grantedToolKeys ?? const <String>[]);
    }
  }

  final manualSkillOverrides = character.manualSkillProficiencyOverrides;
  final legacySkillOverrides = character.manualSkillProficiencies;
  if (manualSkillOverrides != null) {
    for (final state in manualSkillOverrides) {
      if (state.level == CharacterSkillProficiencyLevel.none) {
        ownedSkills.remove(state.skill);
      } else {
        ownedSkills.add(state.skill);
      }
    }
  } else if (legacySkillOverrides != null) {
    ownedSkills
      ..clear()
      ..addAll([
        for (final state in legacySkillOverrides)
          if (state.level != CharacterSkillProficiencyLevel.none) state.skill,
      ]);
  }
  ownedToolKeys
    ..removeAll(character.manualToolProficiencyOverrides?.removedKeys ?? [])
    ..addAll(character.manualToolProficiencyOverrides?.addedKeys ?? []);

  return ChoiceEligibilityContext(
    totalCharacterLevel:
        entries.fold<int>(0, (sum, item) => sum + (item.level ?? 0)),
    classLevelsByReferenceKey: classLevelsByReferenceKey,
    abilityScores: abilityScores,
    knownSpellKeys: spellFacts.knownSpellKeys,
    knownCantripKeys: spellFacts.knownCantripKeys,
    featureKeys: featureKeys,
    selectedChoiceOptionKeys: selectedOptionKeys,
    skillKeys: {for (final skill in ownedSkills) skill.name},
    toolKeys: ownedToolKeys,
  );
}

String? _normalizedText(String? value) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? null : normalized;
}
