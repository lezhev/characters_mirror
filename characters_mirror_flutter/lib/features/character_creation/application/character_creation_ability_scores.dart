import 'package:characters_mirror_client/characters_mirror_client.dart';

Map<String, int> buildCharacterCreationAbilityScores(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final scores = <String, int>{
    ...?character.baseAbilityScores,
  };

  final raceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.race,
    character.race?.id,
  );
  final subraceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.subrace,
    character.subrace?.id,
  );
  final activeBonusMode = _resolveActiveBonusMode(raceChoices);
  final usesFlexibleBonuses =
      activeBonusMode == _BonusMode.flexiblePlusTwoOne ||
          activeBonusMode == _BonusMode.flexibleThreePlusOne;

  if (!usesFlexibleBonuses) {
    _applyFixedRaceBonuses(scores, _abilityBonusesFromRace(character.race));
  }
  _applyRacialChoiceBonuses(
    scores,
    _filterChoicesForActiveBonusMode(raceChoices, activeBonusMode),
  );

  if (!usesFlexibleBonuses) {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromSubrace(character.subrace),
    );
  }
  _applyRacialChoiceBonuses(
    scores,
    _filterChoicesForActiveBonusMode(subraceChoices, activeBonusMode),
  );

  return scores;
}

enum _BonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

_BonusMode _resolveActiveBonusMode(List<CharacterChoiceData> raceChoices) {
  for (final choice in raceChoices) {
    if (choice.groupKey != 'race_bonus_mode') continue;

    switch (choice.selectedText) {
      case 'flexiblePlusTwoOne':
        return _BonusMode.flexiblePlusTwoOne;
      case 'flexibleThreePlusOne':
        return _BonusMode.flexibleThreePlusOne;
      case 'racial':
      default:
        return _BonusMode.racial;
    }
  }

  return _BonusMode.racial;
}

List<CharacterChoiceData> _filterChoicesForActiveBonusMode(
  List<CharacterChoiceData> choices,
  _BonusMode activeMode,
) {
  return choices.where((choice) {
    final groupKey = choice.groupKey;
    if (groupKey == null || groupKey == 'race_bonus_mode') {
      return false;
    }

    final isFlexible = groupKey.startsWith('race_flexible_bonus');
    switch (activeMode) {
      case _BonusMode.racial:
        return !isFlexible;
      case _BonusMode.flexiblePlusTwoOne:
        return groupKey == 'race_flexible_bonus_plus2' ||
            groupKey == 'race_flexible_bonus_plus1';
      case _BonusMode.flexibleThreePlusOne:
        return groupKey == 'race_flexible_bonus_three_plus1';
    }
  }).toList();
}

List<CharacterChoiceData> _racialChoicesForSource(
  List<CharacterChoiceData> choices,
  ChoiceSourceType sourceType,
  int? sourceId,
) {
  if (sourceId == null) {
    return const [];
  }

  return choices.where((choice) {
    return choice.sourceType == sourceType && choice.sourceId == sourceId;
  }).toList();
}

void _applyFixedRaceBonuses(Map<String, int> scores, Map<String, int> bonuses) {
  bonuses.forEach((key, value) {
    final score = scores[key];
    if (score == null) return;
    scores[key] = score + value;
  });
}

void _applyRacialChoiceBonuses(
  Map<String, int> scores,
  List<CharacterChoiceData> choices,
) {
  for (final choice in choices) {
    final bonus = choice.selectedCount ?? 0;
    final key = choice.selectedAbility?.name ?? choice.optionKey?.trim();
    if (key == null || key.isEmpty || bonus == 0) {
      continue;
    }

    final abilityKey = _normalizeAbilityKey(key);
    if (abilityKey == null) continue;

    final score = scores[abilityKey];
    if (score == null) continue;
    scores[abilityKey] = score + bonus;
  }
}

Map<String, int> _abilityBonusesFromRace(RaceData? race) {
  return {
    if (race?.strengthBonus != null)
      Ability.strength.name: race!.strengthBonus!,
    if (race?.dexterityBonus != null)
      Ability.dexterity.name: race!.dexterityBonus!,
    if (race?.constitutionBonus != null)
      Ability.constitution.name: race!.constitutionBonus!,
    if (race?.intelligenceBonus != null)
      Ability.intelligence.name: race!.intelligenceBonus!,
    if (race?.wisdomBonus != null) Ability.wisdom.name: race!.wisdomBonus!,
    if (race?.charismaBonus != null)
      Ability.charisma.name: race!.charismaBonus!,
  };
}

Map<String, int> _abilityBonusesFromSubrace(SubraceData? subrace) {
  return {
    if (subrace?.strengthBonus != null)
      Ability.strength.name: subrace!.strengthBonus!,
    if (subrace?.dexterityBonus != null)
      Ability.dexterity.name: subrace!.dexterityBonus!,
    if (subrace?.constitutionBonus != null)
      Ability.constitution.name: subrace!.constitutionBonus!,
    if (subrace?.intelligenceBonus != null)
      Ability.intelligence.name: subrace!.intelligenceBonus!,
    if (subrace?.wisdomBonus != null)
      Ability.wisdom.name: subrace!.wisdomBonus!,
    if (subrace?.charismaBonus != null)
      Ability.charisma.name: subrace!.charismaBonus!,
  };
}

String? _normalizeAbilityKey(String raw) {
  for (final ability in Ability.values) {
    if (ability.name == raw) {
      return ability.name;
    }
  }
  return null;
}
