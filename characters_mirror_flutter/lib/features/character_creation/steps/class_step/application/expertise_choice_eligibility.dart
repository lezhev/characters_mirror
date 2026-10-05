import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/choice_option_eligibility.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

ChoiceGroupView filterExpertiseChoiceOptions(
  ChoiceGroupView groupView, {
  required Set<Skill> ownedSkills,
  required Set<String> ownedToolKeys,
}) {
  if (groupView.group?.type != ChoiceType.expertise) return groupView;
  return groupView.copyWith(
    options: [
      for (final option in groupView.options ?? const <ChoiceOptionData>[])
        if (evaluateChoiceOptionData(
          option,
          ChoiceEligibilityContext(
            skillKeys: {for (final skill in ownedSkills) skill.name},
            toolKeys: ownedToolKeys,
          ),
        ).isEligible)
          option,
    ],
  );
}
