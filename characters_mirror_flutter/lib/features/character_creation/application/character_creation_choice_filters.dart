import 'package:characters_mirror_client/characters_mirror_client.dart';

List<CharacterChoiceData> withoutChoiceSources(
  List<CharacterChoiceData> choices,
  Set<ChoiceSourceType> sources,
) {
  return choices
      .where((choice) => !sources.contains(choice.sourceType))
      .toList();
}

List<CharacterChoiceData> withoutChoiceGroups(
  List<CharacterChoiceData> choices,
  Set<String> groups,
) {
  if (groups.isEmpty) {
    return choices;
  }

  return choices
      .where((choice) => !groups.contains(choice.groupKey))
      .toList();
}

Set<String> racialAttributeChoiceGroups(CharacterData character) {
  final groups = <String>{
    'race_bonus_mode',
    'race_flexible_bonus_plus2',
    'race_flexible_bonus_plus1',
    'race_flexible_bonus_three_plus1',
  };

  void addGroups(List<RaceFeatureData>? features) {
    for (final feature in features ?? const <RaceFeatureData>[]) {
      for (final choiceSet in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        if (choiceSet.kind != RaceChoiceKind.abilityBonusChoice) {
          continue;
        }

        final choiceSetId = choiceSet.id;
        if (choiceSetId == null) {
          continue;
        }

        final bonusValues = <int>{
          for (final option
              in choiceSet.choiceOptions ?? const <RaceChoiceOptionData>[])
            if ((option.bonusValue ?? 0) > 0) option.bonusValue!,
        };

        if (bonusValues.isEmpty) {
          groups.add('race_choice_$choiceSetId');
          continue;
        }

        for (final bonusValue in bonusValues) {
          groups.add('race_choice_${choiceSetId}_bonus_$bonusValue');
        }
      }
    }
  }

  addGroups(character.race?.features);
  addGroups(character.subrace?.features);
  return groups;
}

Set<String> racialNonAttributeChoiceGroups(CharacterData character) {
  final groups = <String>{};

  void addGroups(List<RaceFeatureData>? features) {
    for (final feature in features ?? const <RaceFeatureData>[]) {
      for (final choiceSet in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        if (choiceSet.kind == RaceChoiceKind.abilityBonusChoice) {
          continue;
        }
        final choiceSetId = choiceSet.id;
        if (choiceSetId == null) {
          continue;
        }
        groups.add('race_choice_$choiceSetId');
      }
    }
  }

  addGroups(character.race?.features);
  addGroups(character.subrace?.features);
  return groups;
}
