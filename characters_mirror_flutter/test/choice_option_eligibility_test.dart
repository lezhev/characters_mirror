import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/choice_option_eligibility.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('offline adapter returns reason and dependent choices become available',
      () {
    final dependentRequirement = ChoiceRequirementData(
      type: ChoiceRequirementType.selectedChoiceOption,
      choiceGroupKey: 'pact',
      optionKey: 'blade',
    );
    final group = ChoiceGroupView(
      group: ChoiceGroupData(referenceKey: 'invocations'),
      options: [
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'deepened_blade',
          requirements: [dependentRequirement],
        ),
      ],
    );

    final unavailable = evaluateChoiceGroupEligibility(
      group,
      ChoiceEligibilityContext(),
    );
    expect(unavailable.optionEligibility!.single.isEligible, isFalse);
    expect(
      unavailable.optionEligibility!.single.failedRequirements!.single.reason,
      'selectedChoiceOption',
    );

    final available = evaluateChoiceGroupEligibility(
      group,
      ChoiceEligibilityContext(
        selectedChoiceOptionKeys: {
          encodeSelectedChoiceOptionKey('pact', 'blade'),
        },
      ),
    );
    expect(available.optionEligibility!.single.isEligible, isTrue);
  });

  test('offline adapter applies every requirement and legacy proficiency', () {
    final option = ChoiceOptionData(
      choiceGroupId: 1,
      optionKey: 'expertise',
      requiredExistingToolKey: 'thieves_tools',
      requirements: [
        ChoiceRequirementData(
          type: ChoiceRequirementType.minimumCharacterLevel,
          value: 5,
        ),
        ChoiceRequirementData(
          type: ChoiceRequirementType.knownSpell,
          referenceKey: 'hex',
        ),
      ],
    );
    final context = ChoiceEligibilityContext(
      totalCharacterLevel: 5,
      knownSpellKeys: {'hex'},
    );
    final result = evaluateChoiceOptionData(option, context);
    expect(result.isEligible, isFalse);
    expect(result.failedRequirements.single.reason, 'existingTool');
    expect(
      evaluateChoiceOptionData(
        option,
        ChoiceEligibilityContext(
          totalCharacterLevel: 5,
          knownSpellKeys: {'hex'},
          toolKeys: {'thieves_tools'},
        ),
      ).isEligible,
      isTrue,
    );
  });
}
