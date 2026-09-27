import 'package:characters_mirror_client/characters_mirror_client.dart';

List<CharacterChoiceData> withoutChoiceGroups(
  List<CharacterChoiceData> choices,
  Set<String> groups,
) {
  if (groups.isEmpty) {
    return choices;
  }

  return choices.where((choice) => !groups.contains(choice.groupKey)).toList();
}

Set<String> racialAttributeChoiceGroups(
  CharacterData character,
  List<ChoiceGroupView> choiceGroups,
) {
  return {
    for (final view in choiceGroups)
      if ((view.group?.type == ChoiceType.abilityIncrease ||
              view.group?.referenceKey.endsWith('_ability_bonus_mode') ==
                  true) &&
          (view.group?.sourceRaceId == character.race?.id ||
              view.group?.sourceSubraceId == character.subrace?.id))
        view.group!.referenceKey,
  };
}

Set<String> racialNonAttributeChoiceGroups(
  CharacterData character,
  List<ChoiceGroupView> choiceGroups,
) {
  return {
    for (final view in choiceGroups)
      if (view.group?.type != ChoiceType.abilityIncrease &&
          (view.group?.sourceRaceId == character.race?.id ||
              view.group?.sourceSubraceId == character.subrace?.id))
        view.group!.referenceKey,
  };
}
