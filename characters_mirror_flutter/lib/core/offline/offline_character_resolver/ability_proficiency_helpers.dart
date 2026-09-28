part of '../offline_character_resolver.dart';

Map<String, int> _abilityScores(
  CharacterData character,
  List<ChoiceOptionData> selectedOptions,
) {
  final scores = {
    for (final ability in Ability.values) ability.name: 10,
    ...?character.baseAbilityScores,
  };
  if (character.useFlexibleAbilityBonuses != true) {
    _addBonus(scores, Ability.strength, character.race?.strengthBonus);
    _addBonus(scores, Ability.dexterity, character.race?.dexterityBonus);
    _addBonus(scores, Ability.constitution, character.race?.constitutionBonus);
    _addBonus(scores, Ability.intelligence, character.race?.intelligenceBonus);
    _addBonus(scores, Ability.wisdom, character.race?.wisdomBonus);
    _addBonus(scores, Ability.charisma, character.race?.charismaBonus);
    _addBonus(scores, Ability.strength, character.subrace?.strengthBonus);
    _addBonus(scores, Ability.dexterity, character.subrace?.dexterityBonus);
    _addBonus(
        scores, Ability.constitution, character.subrace?.constitutionBonus);
    _addBonus(
        scores, Ability.intelligence, character.subrace?.intelligenceBonus);
    _addBonus(scores, Ability.wisdom, character.subrace?.wisdomBonus);
    _addBonus(scores, Ability.charisma, character.subrace?.charismaBonus);
  }
  for (final option in selectedOptions) {
    for (final bonus in option.grantedAbilityBonuses?.entries ??
        const <MapEntry<String, int>>[]) {
      if (!Ability.values.any((ability) => ability.name == bonus.key) ||
          bonus.value == 0) {
        continue;
      }
      scores[bonus.key] = (scores[bonus.key] ?? 10) + bonus.value;
    }
  }
  for (final entry in character.customAbilityBonuses?.entries ??
      const Iterable<MapEntry<String, int>>.empty()) {
    if (!Ability.values.any((ability) => ability.name == entry.key)) continue;
    scores[entry.key] = (scores[entry.key] ?? 10) + entry.value;
  }
  return scores;
}

void _addBonus(Map<String, int> scores, Ability ability, int? bonus) {
  if (bonus == null) return;
  scores[ability.name] = (scores[ability.name] ?? 10) + bonus;
}

int _modifier(int score) => ((score - 10) / 2).floor();

Set<Ability> _savingThrowProficiencies(CharacterData character) {
  final startingEntry = _startingClassEntry(
    character.classEntries ?? const <CharacterClassEntryData>[],
  );
  final result = <Ability>{
    ...?startingEntry?.classData?.savingThrowProficiencies,
  };
  final overrides = character.manualSavingThrowProficiencyOverrides;
  if (overrides != null) {
    for (final value in overrides) {
      if (value.state == CharacterSavingThrowProficiencyOverride.add) {
        result.add(value.ability);
      } else {
        result.remove(value.ability);
      }
    }
    return result;
  }
  final legacy = character.manualSavingThrowProficiencies;
  if (legacy != null) {
    return {...legacy};
  }
  return result;
}

Map<Skill, CharacterSkillProficiencyLevel> _skillProficiencyLevels(
  CharacterData character,
  List<ChoiceOptionData> selectedOptions,
) {
  final result = {
    for (final skill in Skill.values)
      skill: CharacterSkillProficiencyLevel.none,
  };
  for (final skill in [
    ...?character.race?.skillProficiencies,
    ...?character.subrace?.skillProficiencies,
    ...?character.background?.skillProficiencies,
  ]) {
    result[skill] = CharacterSkillProficiencyLevel.proficient;
  }
  for (final selection
      in character.skillSelections ?? const <CharacterSkillSelectionData>[]) {
    final skill = selection.skill;
    if (skill != null) {
      result[skill] = CharacterSkillProficiencyLevel.proficient;
    }
  }
  for (final option in selectedOptions) {
    for (final skill in option.grantedSkills ?? const <Skill>[]) {
      result[skill] = CharacterSkillProficiencyLevel.proficient;
    }
    for (final skill in option.grantedExpertiseSkills ?? const <Skill>[]) {
      if (result[skill] != CharacterSkillProficiencyLevel.none) {
        result[skill] = CharacterSkillProficiencyLevel.expertise;
      }
    }
  }
  final overrides = character.manualSkillProficiencyOverrides;
  final legacy = character.manualSkillProficiencies;
  if (overrides == null && legacy != null) {
    for (final skill in Skill.values) {
      result[skill] = CharacterSkillProficiencyLevel.none;
    }
  }
  for (final state
      in overrides ?? legacy ?? const <CharacterSkillProficiencyState>[]) {
    result[state.skill] = state.level;
  }
  return result;
}

int _skillMultiplier(CharacterSkillProficiencyLevel level) {
  switch (level) {
    case CharacterSkillProficiencyLevel.none:
      return 0;
    case CharacterSkillProficiencyLevel.proficient:
      return 1;
    case CharacterSkillProficiencyLevel.expertise:
      return 2;
  }
}
