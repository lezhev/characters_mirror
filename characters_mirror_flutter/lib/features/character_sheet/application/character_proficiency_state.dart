import 'package:characters_mirror_client/characters_mirror_client.dart';

Map<Skill, CharacterSkillProficiencyLevel> skillProficiencyLevelMap(
  List<CharacterSkillProficiencyState>? states,
) {
  final levels = {
    for (final skill in Skill.values)
      skill: CharacterSkillProficiencyLevel.none,
  };
  for (final state in states ?? const <CharacterSkillProficiencyState>[]) {
    levels[state.skill] = state.level;
  }
  return levels;
}

Set<Ability> savingThrowProficiencySet(List<Ability>? abilities) {
  return {
    for (final ability in abilities ?? const <Ability>[]) ability,
  };
}

List<CharacterSkillProficiencyState> buildManualSkillProficiencies({
  required CharacterData character,
  required Skill skill,
  required CharacterSkillProficiencyLevel level,
}) {
  final levels = skillProficiencyLevelMap(
    character.manualSkillProficiencies ??
        character.derived?.skillProficiencyLevels,
  );
  levels[skill] = level;
  return [
    for (final skill in Skill.values)
      CharacterSkillProficiencyState(
        skill: skill,
        level: levels[skill] ?? CharacterSkillProficiencyLevel.none,
      ),
  ];
}

List<Ability> buildManualSavingThrowProficiencies({
  required CharacterData character,
  required Ability ability,
  required bool proficient,
}) {
  final abilities = savingThrowProficiencySet(
    character.manualSavingThrowProficiencies ??
        character.derived?.savingThrowProficiencies,
  );
  if (proficient) {
    abilities.add(ability);
  } else {
    abilities.remove(ability);
  }
  return [
    for (final ability in Ability.values)
      if (abilities.contains(ability)) ability,
  ];
}

CharacterSkillProficiencyLevel nextSkillProficiencyLevel(
  CharacterSkillProficiencyLevel level,
) {
  switch (level) {
    case CharacterSkillProficiencyLevel.none:
      return CharacterSkillProficiencyLevel.proficient;
    case CharacterSkillProficiencyLevel.proficient:
      return CharacterSkillProficiencyLevel.expertise;
    case CharacterSkillProficiencyLevel.expertise:
      return CharacterSkillProficiencyLevel.none;
  }
}

bool nextSavingThrowProficiency(bool proficient) => !proficient;

Ability abilityForSkill(Skill skill) {
  switch (skill) {
    case Skill.acrobatics:
    case Skill.sleightOfHand:
    case Skill.stealth:
      return Ability.dexterity;
    case Skill.animalHandling:
    case Skill.insight:
    case Skill.medicine:
    case Skill.perception:
    case Skill.survival:
      return Ability.wisdom;
    case Skill.arcana:
    case Skill.history:
    case Skill.investigation:
    case Skill.nature:
    case Skill.religion:
      return Ability.intelligence;
    case Skill.athletics:
      return Ability.strength;
    case Skill.deception:
    case Skill.intimidation:
    case Skill.performance:
    case Skill.persuasion:
      return Ability.charisma;
  }
}
