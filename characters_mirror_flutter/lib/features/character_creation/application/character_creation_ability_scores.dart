import 'package:characters_mirror_client/characters_mirror_client.dart';

Map<String, int> buildCharacterCreationAbilityScores(
    CharacterData character, List<CharacterChoiceData> choices,
    {List<ChoiceGroupView> choiceGroups = const []}) {
  final scores = <String, int>{
    ...?character.baseAbilityScores,
  };

  final raceChoices = _racialChoicesForSource(
    choices,
    choiceGroups,
    raceId: character.race?.id,
  );
  final subraceChoices = _racialChoicesForSource(
    choices,
    choiceGroups,
    subraceId: character.subrace?.id,
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
    character: character,
    choiceGroups: choiceGroups,
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
    character: character,
    choiceGroups: choiceGroups,
  );

  return scores;
}

enum _BonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

_BonusMode _resolveActiveBonusMode(List<CharacterChoiceData> raceChoices) {
  for (final choice in raceChoices) {
    if (choice.groupKey?.endsWith('_ability_bonus_mode') != true) continue;

    switch (choice.optionKey) {
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
    if (groupKey == null || groupKey.endsWith('_ability_bonus_mode')) {
      return false;
    }

    final isFlexible = groupKey.startsWith('race_flexible_bonus');
    switch (activeMode) {
      case _BonusMode.racial:
        return !isFlexible;
      case _BonusMode.flexiblePlusTwoOne:
        return groupKey.startsWith('race_flexible_bonus_plus2_') ||
            groupKey.startsWith('race_flexible_bonus_plus1_');
      case _BonusMode.flexibleThreePlusOne:
        return groupKey.startsWith('race_flexible_bonus_three_plus1_');
    }
  }).toList();
}

List<CharacterChoiceData> _racialChoicesForSource(
  List<CharacterChoiceData> choices,
  List<ChoiceGroupView> choiceGroups, {
  int? raceId,
  int? subraceId,
}) {
  final groupsByKey = {
    for (final view in choiceGroups)
      if (view.group case final group?) group.referenceKey: group,
  };
  return choices.where((choice) {
    final group = groupsByKey[choice.groupKey];
    return (raceId != null && group?.sourceRaceId == raceId) ||
        (subraceId != null && group?.sourceSubraceId == subraceId);
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
    Map<String, int> scores, List<CharacterChoiceData> choices,
    {required CharacterData character,
    required List<ChoiceGroupView> choiceGroups}) {
  final groupsByKey = {
    for (final view in choiceGroups)
      if (view.group case final group?) group.referenceKey: view,
  };
  for (final choice in choices) {
    final groupKey = choice.groupKey;
    final optionKey = choice.optionKey;
    if (groupKey == null || optionKey == null) continue;
    final group = groupsByKey[groupKey]?.group;
    final belongsToRace = group?.sourceRaceId == character.race?.id;
    final belongsToSubrace = group?.sourceSubraceId == character.subrace?.id;
    if (!belongsToRace && !belongsToSubrace) continue;
    final option = groupsByKey[groupKey]
        ?.options
        ?.where(
          (item) => item.optionKey == optionKey,
        )
        .firstOrNull;
    if (option == null) continue;
    final bonuses = option.grantedAbilityBonuses;
    if (bonuses == null) continue;
    for (final bonus in bonuses.entries) {
      final abilityKey = _normalizeAbilityKey(bonus.key);
      if (abilityKey == null) continue;
      final score = scores[abilityKey];
      if (score == null) continue;
      scores[abilityKey] = (score + bonus.value).round();
    }
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
