import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/character_creation_ability_scores.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ability scores resolve selected generic option effects by identity',
      () {
    const groupKey = 'half_elf_ability_score_increase';
    final character = CharacterData(
      race: RaceData(id: 7, name: 'Half-Elf'),
      baseAbilityScores: const {'strength': 10, 'dexterity': 10},
    );
    final choices = [
      CharacterChoiceData(
        groupKey: groupKey,
        optionKey: 'strength_plus_one',
        selectionIndex: 0,
      ),
    ];
    final groups = [
      ChoiceGroupView(
        group: ChoiceGroupData(
          id: 11,
          referenceKey: groupKey,
          sourceRaceId: 7,
          type: ChoiceType.abilityIncrease,
          selectionCount: 1,
        ),
        options: [
          ChoiceOptionData(
            choiceGroupId: 11,
            optionKey: 'strength_plus_one',
            grantedAbilityBonuses: const {'strength': 1},
          ),
        ],
      ),
    ];

    final result = buildCharacterCreationAbilityScores(
      character,
      choices,
      choiceGroups: groups,
    );

    expect(result['strength'], 11);
    expect(result['dexterity'], 10);
  });

  test('flexible mode applies only active race option effects', () {
    final character = CharacterData(
      race: RaceData(id: 7, strengthBonus: 2),
      baseAbilityScores: const {
        'strength': 10,
        'dexterity': 10,
        'wisdom': 10,
        'charisma': 10,
      },
    );
    final choices = [
      CharacterChoiceData(
        groupKey: 'half_elf_ability_bonus_mode',
        optionKey: 'flexiblePlusTwoOne',
      ),
      CharacterChoiceData(
        groupKey: 'half_elf_ability_score_increase',
        optionKey: 'strength_plus_one',
      ),
      CharacterChoiceData(
        groupKey: 'race_flexible_bonus_plus2_half_elf',
        optionKey: 'charisma_plus_two',
      ),
      CharacterChoiceData(
        groupKey: 'race_flexible_bonus_plus1_half_elf',
        optionKey: 'wisdom_plus_one',
      ),
      CharacterChoiceData(
        groupKey: 'race_flexible_bonus_three_plus1_half_elf',
        optionKey: 'dexterity_plus_one',
      ),
    ];
    final groups = [
      ChoiceGroupView(
        group: ChoiceGroupData(
          id: 1,
          referenceKey: 'half_elf_ability_bonus_mode',
          sourceRaceId: 7,
          type: ChoiceType.custom,
        ),
        options: [
          ChoiceOptionData(choiceGroupId: 1, optionKey: 'flexiblePlusTwoOne'),
        ],
      ),
      ChoiceGroupView(
        group: ChoiceGroupData(
          id: 2,
          referenceKey: 'half_elf_ability_score_increase',
          sourceRaceId: 7,
          type: ChoiceType.abilityIncrease,
        ),
        options: [
          ChoiceOptionData(
            choiceGroupId: 2,
            optionKey: 'strength_plus_one',
            grantedAbilityBonuses: const {'strength': 1},
          ),
        ],
      ),
      ChoiceGroupView(
        group: ChoiceGroupData(
          id: 3,
          referenceKey: 'race_flexible_bonus_plus2_half_elf',
          sourceRaceId: 7,
          type: ChoiceType.abilityIncrease,
        ),
        options: [
          ChoiceOptionData(
            choiceGroupId: 3,
            optionKey: 'charisma_plus_two',
            grantedAbilityBonuses: const {'charisma': 2},
          ),
        ],
      ),
      ChoiceGroupView(
        group: ChoiceGroupData(
          id: 4,
          referenceKey: 'race_flexible_bonus_plus1_half_elf',
          sourceRaceId: 7,
          type: ChoiceType.abilityIncrease,
        ),
        options: [
          ChoiceOptionData(
            choiceGroupId: 4,
            optionKey: 'wisdom_plus_one',
            grantedAbilityBonuses: const {'wisdom': 1},
          ),
        ],
      ),
      ChoiceGroupView(
        group: ChoiceGroupData(
          id: 5,
          referenceKey: 'race_flexible_bonus_three_plus1_half_elf',
          sourceRaceId: 7,
          type: ChoiceType.abilityIncrease,
        ),
        options: [
          ChoiceOptionData(
            choiceGroupId: 5,
            optionKey: 'dexterity_plus_one',
            grantedAbilityBonuses: const {'dexterity': 1},
          ),
        ],
      ),
    ];

    final result = buildCharacterCreationAbilityScores(
      character,
      choices,
      choiceGroups: groups,
    );

    expect(result, {
      'strength': 10,
      'dexterity': 10,
      'wisdom': 11,
      'charisma': 12,
    });
  });
}
