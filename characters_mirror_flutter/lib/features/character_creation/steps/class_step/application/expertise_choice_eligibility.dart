import 'package:characters_mirror_client/characters_mirror_client.dart';

ChoiceGroupView filterExpertiseChoiceOptions(
  ChoiceGroupView groupView, {
  required Set<Skill> ownedSkills,
  required Set<String> ownedToolKeys,
}) {
  if (groupView.group?.type != ChoiceType.expertise) return groupView;
  return groupView.copyWith(
    options: [
      for (final option in groupView.options ?? const <ChoiceOptionData>[])
        if ((option.requiredExistingSkill == null ||
                ownedSkills.contains(option.requiredExistingSkill)) &&
            (option.requiredExistingToolKey == null ||
                ownedToolKeys.contains(option.requiredExistingToolKey)))
          option,
    ],
  );
}
