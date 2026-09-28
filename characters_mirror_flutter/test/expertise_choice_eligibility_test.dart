import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/application/expertise_choice_eligibility.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/application/expertise_owned_proficiencies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('shows only owned skill and tool expertise targets', () {
    final view = ChoiceGroupView(
      group: ChoiceGroupData(
        referenceKey: 'expertise',
        type: ChoiceType.expertise,
      ),
      options: [
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'stealth',
          requiredExistingSkill: Skill.stealth,
        ),
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'acrobatics',
          requiredExistingSkill: Skill.acrobatics,
        ),
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'thieves_tools',
          requiredExistingToolKey: 'thieves_tools',
        ),
      ],
    );

    final withoutTools = filterExpertiseChoiceOptions(
      view,
      ownedSkills: {Skill.stealth},
      ownedToolKeys: const {},
    );
    expect(
      withoutTools.options!.map((option) => option.optionKey),
      ['stealth'],
    );

    final withTools = filterExpertiseChoiceOptions(
      view,
      ownedSkills: {Skill.stealth},
      ownedToolKeys: {'thieves_tools'},
    );
    expect(
      withTools.options!.map((option) => option.optionKey),
      ['stealth', 'thieves_tools'],
    );
  });

  test('includes current background and class proficiencies in eligibility',
      () {
    final group = ChoiceGroupData(
      referenceKey: 'expertise',
      selectionCount: 2,
      type: ChoiceType.expertise,
    );
    final view = ChoiceGroupView(
      group: group,
      options: [
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'stealth',
          requiredExistingSkill: Skill.stealth,
        ),
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'persuasion',
          requiredExistingSkill: Skill.persuasion,
        ),
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'thieves_tools',
          requiredExistingToolKey: 'thieves_tools',
        ),
        ChoiceOptionData(
          choiceGroupId: 1,
          optionKey: 'acrobatics',
          requiredExistingSkill: Skill.acrobatics,
        ),
      ],
    );

    final eligible = resolveExpertiseEligibleOptionKeys(
      character: CharacterData(),
      selectedBackground: BackgroundData(
        skillProficiencies: const [Skill.persuasion],
        toolProficiencyKeys: const ['thieves_tools'],
      ),
      selectedClass: ClassData(),
      classSkillSelections: [
        CharacterSkillSelectionData(skill: Skill.stealth),
      ],
      backgroundSkillSelections: const [],
      selectedOptions: const {},
      choiceGroups: [view],
    );

    expect(eligible['expertise'], {
      'stealth',
      'persuasion',
      'thieves_tools',
    });

    final afterBackgroundChange = resolveExpertiseEligibleOptionKeys(
      character: CharacterData(),
      selectedBackground: BackgroundData(),
      selectedClass: ClassData(),
      classSkillSelections: [
        CharacterSkillSelectionData(skill: Skill.stealth),
      ],
      backgroundSkillSelections: const [],
      selectedOptions: const {},
      choiceGroups: [view],
    );
    expect(afterBackgroundChange['expertise'], {'stealth'});
  });
}
