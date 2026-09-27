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
  final existingOverrides = character.manualSkillProficiencyOverrides;
  final values = existingOverrides == null
      ? character.manualSkillProficiencies == null
          ? <Skill, CharacterSkillProficiencyState>{}
          : {
              for (final candidate in Skill.values)
                candidate: CharacterSkillProficiencyState(
                  skill: candidate,
                  level: skillProficiencyLevelMap(
                    character.manualSkillProficiencies,
                  )[candidate]!,
                ),
            }
      : {for (final value in existingOverrides) value.skill: value};
  values[skill] = CharacterSkillProficiencyState(skill: skill, level: level);
  return [
    for (final candidate in Skill.values)
      if (values[candidate] != null) values[candidate]!
  ];
}

List<CharacterSavingThrowProficiencyOverrideData>
    buildManualSavingThrowProficiencies({
  required CharacterData character,
  required Ability ability,
  required bool proficient,
}) {
  final existingOverrides = character.manualSavingThrowProficiencyOverrides;
  final values = existingOverrides == null
      ? character.manualSavingThrowProficiencies == null
          ? <Ability, CharacterSavingThrowProficiencyOverrideData>{}
          : {
              for (final candidate in Ability.values)
                candidate: CharacterSavingThrowProficiencyOverrideData(
                  ability: candidate,
                  state: character.manualSavingThrowProficiencies!
                          .contains(candidate)
                      ? CharacterSavingThrowProficiencyOverride.add
                      : CharacterSavingThrowProficiencyOverride.remove,
                ),
            }
      : {for (final value in existingOverrides) value.ability: value};
  values[ability] = CharacterSavingThrowProficiencyOverrideData(
    ability: ability,
    state: proficient
        ? CharacterSavingThrowProficiencyOverride.add
        : CharacterSavingThrowProficiencyOverride.remove,
  );
  return [
    for (final candidate in Ability.values)
      if (values[candidate] != null) values[candidate]!,
  ];
}

CharacterData withOptimisticSkillProficiency({
  required CharacterData character,
  required List<CharacterSkillProficiencyState> manualSkillProficiencies,
}) {
  final derived = character.derived;
  if (derived == null) {
    return character.copyWith(
      manualSkillProficiencies: manualSkillProficiencies,
      manualSkillProficiencyOverrides: manualSkillProficiencies,
    );
  }

  final skillLevels = skillProficiencyLevelMap(
    derived.skillProficiencyLevels,
  );
  for (final value in manualSkillProficiencies) {
    skillLevels[value.skill] = value.level;
  }
  final skillBonuses = <Skill, int>{
    for (final skill in Skill.values)
      skill: optimisticSkillBonus(
        character: character,
        skill: skill,
        level: skillLevels[skill] ?? CharacterSkillProficiencyLevel.none,
      ),
  };

  return character.copyWith(
    manualSkillProficiencies: [
      for (final skill in Skill.values)
        CharacterSkillProficiencyState(
          skill: skill,
          level: skillLevels[skill] ?? CharacterSkillProficiencyLevel.none,
        ),
    ],
    manualSkillProficiencyOverrides: manualSkillProficiencies,
    derived: derived.copyWith(
      skillBonuses: skillBonuses,
      skillProficiencyLevels: [
        for (final skill in Skill.values)
          CharacterSkillProficiencyState(
            skill: skill,
            level: skillLevels[skill] ?? CharacterSkillProficiencyLevel.none,
          ),
      ],
      passivePerception: 10 + skillBonuses[Skill.perception]!,
      passiveInvestigation: 10 + skillBonuses[Skill.investigation]!,
      passiveInsight: 10 + skillBonuses[Skill.insight]!,
    ),
  );
}

CharacterData withOptimisticSavingThrowProficiency({
  required CharacterData character,
  required List<CharacterSavingThrowProficiencyOverrideData>
      manualSavingThrowProficiencies,
}) {
  final derived = character.derived;
  if (derived == null) {
    return character.copyWith(
      manualSavingThrowProficiencies: [
        for (final value in manualSavingThrowProficiencies)
          if (value.state == CharacterSavingThrowProficiencyOverride.add)
            value.ability,
      ],
      manualSavingThrowProficiencyOverrides: manualSavingThrowProficiencies,
    );
  }

  final proficiencies = savingThrowProficiencySet(
    derived.savingThrowProficiencies,
  );
  for (final value in manualSavingThrowProficiencies) {
    if (value.state == CharacterSavingThrowProficiencyOverride.add) {
      proficiencies.add(value.ability);
    } else {
      proficiencies.remove(value.ability);
    }
  }
  final savingThrowBonuses = <Ability, int>{
    for (final ability in Ability.values)
      ability: optimisticSavingThrowBonus(
        character: character,
        ability: ability,
        proficient: proficiencies.contains(ability),
      ),
  };

  return character.copyWith(
    manualSavingThrowProficiencies: [
      for (final ability in Ability.values)
        if (proficiencies.contains(ability)) ability,
    ],
    manualSavingThrowProficiencyOverrides: manualSavingThrowProficiencies,
    derived: derived.copyWith(
      savingThrowBonuses: savingThrowBonuses,
      savingThrowProficiencies: [
        for (final ability in Ability.values)
          if (proficiencies.contains(ability)) ability,
      ],
    ),
  );
}

int optimisticSkillBonus({
  required CharacterData character,
  required Skill skill,
  required CharacterSkillProficiencyLevel level,
}) {
  final modifier =
      character.derived?.abilityModifiers?[abilityForSkill(skill)] ?? 0;
  return modifier +
      characterProficiencyBonus(character) * _skillMultiplier(level);
}

int optimisticSavingThrowBonus({
  required CharacterData character,
  required Ability ability,
  required bool proficient,
}) {
  final modifier = character.derived?.abilityModifiers?[ability] ?? 0;
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
