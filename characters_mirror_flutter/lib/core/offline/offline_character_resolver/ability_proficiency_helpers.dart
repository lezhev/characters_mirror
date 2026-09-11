part of '../offline_character_resolver.dart';

Map<String, int> _abilityScores(CharacterData character) {
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
  for (final entry in character.customAbilityBonuses?.entries ??
      const Iterable<MapEntry<String, int>>.empty()) {
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
  final result = <Ability>{};
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
    result.addAll(entry.classData?.savingThrowProficiencies ?? const []);
  }
  result.addAll(character.manualSavingThrowProficiencies ?? const []);
  return result;
}

Map<Skill, CharacterSkillProficiencyLevel> _skillProficiencyLevels(
  CharacterData character,
) {
  final result = {
    for (final skill in Skill.values)
      skill: CharacterSkillProficiencyLevel.none,
  };
  for (final name in [
    ...?character.race?.skillProficiencies,
    ...?character.subrace?.skillProficiencies,
    ...?character.background?.skillProficiencies,
  ]) {
    final skill = _skillFromName(name);
    if (skill != null) {
      result[skill] = CharacterSkillProficiencyLevel.proficient;
    }
  }
  for (final selection
      in character.skillSelections ?? const <CharacterSkillSelectionData>[]) {
    final skill = selection.skill;
    if (skill != null) {
      result[skill] = CharacterSkillProficiencyLevel.proficient;
    }
  }
  for (final state in character.manualSkillProficiencies ??
      const <CharacterSkillProficiencyState>[]) {
    result[state.skill] = state.level;
  }
  return result;
}

Skill? _skillFromName(String value) {
  final normalized = value.trim();
  for (final skill in Skill.values) {
    if (skill.name == normalized) return skill;
  }
  return null;
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
