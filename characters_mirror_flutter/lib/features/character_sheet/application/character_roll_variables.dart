import 'package:characters_mirror_client/characters_mirror_client.dart';

Map<String, int> characterRollVariables(CharacterData character) {
  final variables = <String, int>{
    'бм': character.derived?.proficiencyBonus ?? 0,
    'pb': character.derived?.proficiencyBonus ?? 0,
  };

  void addAbility(
    Ability ability,
    int value,
    List<String> aliases,
  ) {
    for (final alias in aliases) {
      variables[alias] = value;
    }
  }

  addAbility(
    Ability.strength,
    _abilityModifierFor(character, Ability.strength),
    const ['сил', 'сила', 'str', 'strength'],
  );
  addAbility(
    Ability.dexterity,
    _abilityModifierFor(character, Ability.dexterity),
    const ['лов', 'ловкость', 'dex', 'dexterity'],
  );
  addAbility(
    Ability.constitution,
    _abilityModifierFor(character, Ability.constitution),
    const ['тел', 'телосложение', 'con', 'constitution'],
  );
  addAbility(
    Ability.intelligence,
    _abilityModifierFor(character, Ability.intelligence),
    const ['инт', 'интеллект', 'int', 'intelligence'],
  );
  addAbility(
    Ability.wisdom,
    _abilityModifierFor(character, Ability.wisdom),
    const ['муд', 'мдр', 'мудрость', 'wis', 'wisdom'],
  );
  addAbility(
    Ability.charisma,
    _abilityModifierFor(character, Ability.charisma),
    const ['хар', 'харизма', 'cha', 'charisma'],
  );

  return variables;
}

int _abilityModifierFor(CharacterData character, Ability ability) {
  return character.derived?.abilityModifiers?[ability.name] ??
      _abilityModifier(_abilityScore(character, ability));
}

int _abilityScore(CharacterData character, Ability ability) {
  return character.derived?.abilityScores?[ability.name] ??
      character.baseAbilityScores?[ability.name] ??
      10;
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();
