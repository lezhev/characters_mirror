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

CharacterData withOptimisticSkillProficiency({
  required CharacterData character,
  required List<CharacterSkillProficiencyState> manualSkillProficiencies,
}) {
  final derived = character.derived;
  if (derived == null) {
    return character.copyWith(
        manualSkillProficiencies: manualSkillProficiencies);
  }

  final skillLevels = skillProficiencyLevelMap(manualSkillProficiencies);
  final skillBonuses = {
    for (final skill in Skill.values)
      skill.name: optimisticSkillBonus(
        character: character,
        skill: skill,
        level: skillLevels[skill] ?? CharacterSkillProficiencyLevel.none,
      ),
  };

  return character.copyWith(
    manualSkillProficiencies: manualSkillProficiencies,
    derived: derived.copyWith(
      skillBonuses: skillBonuses,
      skillProficiencyLevels: manualSkillProficiencies,
      passivePerception: 10 + (skillBonuses[Skill.perception.name] ?? 0),
      passiveInvestigation: 10 + (skillBonuses[Skill.investigation.name] ?? 0),
      passiveInsight: 10 + (skillBonuses[Skill.insight.name] ?? 0),
    ),
  );
}

CharacterData withOptimisticSavingThrowProficiency({
  required CharacterData character,
  required List<Ability> manualSavingThrowProficiencies,
}) {
  final derived = character.derived;
  if (derived == null) {
    return character.copyWith(
      manualSavingThrowProficiencies: manualSavingThrowProficiencies,
    );
  }

  final proficiencies = savingThrowProficiencySet(
    manualSavingThrowProficiencies,
  );
  final savingThrowBonuses = {
    for (final ability in Ability.values)
      ability.name: optimisticSavingThrowBonus(
        character: character,
        ability: ability,
        proficient: proficiencies.contains(ability),
      ),
  };

  return character.copyWith(
    manualSavingThrowProficiencies: manualSavingThrowProficiencies,
    derived: derived.copyWith(
      savingThrowBonuses: savingThrowBonuses,
      savingThrowProficiencies: manualSavingThrowProficiencies,
    ),
  );
}

int optimisticSkillBonus({
  required CharacterData character,
  required Skill skill,
  required CharacterSkillProficiencyLevel level,
}) {
  final modifier =
      character.derived?.abilityModifiers?[abilityForSkill(skill).name] ?? 0;
  return modifier +
      characterProficiencyBonus(character) * _skillMultiplier(level);
}

int optimisticSavingThrowBonus({
  required CharacterData character,
  required Ability ability,
  required bool proficient,
}) {
  final modifier = character.derived?.abilityModifiers?[ability.name] ?? 0;
  return modifier + (proficient ? characterProficiencyBonus(character) : 0);
}

int characterProficiencyBonus(CharacterData character) {
  return character.derived?.proficiencyBonus ?? 2;
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
