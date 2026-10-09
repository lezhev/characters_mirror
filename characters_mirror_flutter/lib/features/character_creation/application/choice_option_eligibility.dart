import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

ChoiceOptionEligibility evaluateChoiceOptionData(
  ChoiceOptionData option,
  ChoiceEligibilityContext context,
) {
  final requirements = <ChoiceRequirement>[
    for (final requirement
        in option.requirements ?? const <ChoiceRequirementData>[])
      _fromProtocol(requirement),
    if (option.requiredExistingSkill case final skill?)
      ChoiceRequirement(
        kind: ChoiceRequirementKind.existingSkill,
        referenceKey: skill.name,
      ),
    if (option.requiredExistingToolKey case final toolKey?
        when toolKey.trim().isNotEmpty)
      ChoiceRequirement(
        kind: ChoiceRequirementKind.existingTool,
        referenceKey: toolKey.trim(),
      ),
  ];
  return evaluateChoiceOptionEligibility(
    requirements: requirements,
    context: context,
  );
}

ChoiceGroupView evaluateChoiceGroupEligibility(
  ChoiceGroupView groupView,
  ChoiceEligibilityContext context,
) =>
    groupView.copyWith(
      optionEligibility: [
        for (final option in groupView.options ?? const <ChoiceOptionData>[])
          () {
            final result = evaluateChoiceOptionData(option, context);
            return ChoiceOptionEligibilityView(
              optionKey: option.optionKey,
              isEligible: result.isEligible,
              failedRequirements: [
                for (final failure in result.failedRequirements)
                  ChoiceRequirementFailureView(
                    reason: failure.reason,
                    actualValue: failure.actualValue,
                  ),
              ],
            );
          }(),
      ],
    );

bool isChoiceGroupAvailable(
  ChoiceGroupData group,
  ChoiceEligibilityContext context,
) =>
    choiceRequirementsEligibilityFromProtocol(
      (group.requirements ?? const <ChoiceRequirementData>[])
          .map((requirement) => requirement.toJson()),
      context,
    ).isEligible;

ChoiceRequirement _fromProtocol(ChoiceRequirementData requirement) =>
    ChoiceRequirement(
      negate: requirement.negate == true,
      kind: switch (requirement.type) {
        ChoiceRequirementType.minimumClassLevel =>
          ChoiceRequirementKind.minimumClassLevel,
        ChoiceRequirementType.minimumCharacterLevel =>
          ChoiceRequirementKind.minimumCharacterLevel,
        ChoiceRequirementType.abilityScore =>
          ChoiceRequirementKind.abilityScore,
        ChoiceRequirementType.knownSpell => ChoiceRequirementKind.knownSpell,
        ChoiceRequirementType.knownCantrip =>
          ChoiceRequirementKind.knownCantrip,
        ChoiceRequirementType.feature => ChoiceRequirementKind.feature,
        ChoiceRequirementType.selectedChoiceOption =>
          ChoiceRequirementKind.selectedChoiceOption,
      },
      classKey: requirement.classKey,
      ability: requirement.ability?.name,
      value: requirement.value,
      referenceKey: requirement.referenceKey,
      choiceGroupKey: requirement.choiceGroupKey,
      optionKey: requirement.optionKey,
    );
