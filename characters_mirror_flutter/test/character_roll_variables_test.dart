import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_roll_variables.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('characterRollVariables', () {
    test('builds ability modifier and proficiency aliases', () {
      final variables = characterRollVariables(
        CharacterData(
          baseAbilityScores: const {
            'strength': 16,
            'dexterity': 8,
            'constitution': 10,
            'intelligence': 12,
            'wisdom': 14,
            'charisma': 18,
          },
          derived: CharacterDerivedData(
            proficiencyBonus: 3,
            abilityModifiers: const {
              'strength': 4,
              'dexterity': -1,
              'constitution': 0,
              'intelligence': 1,
              'wisdom': 2,
              'charisma': 5,
            },
          ),
        ),
      );

      expect(variables['сил'], 4);
      expect(variables['str'], 4);
      expect(variables['лов'], -1);
      expect(variables['dex'], -1);
      expect(variables['тел'], 0);
      expect(variables['con'], 0);
      expect(variables['инт'], 1);
      expect(variables['int'], 1);
      expect(variables['муд'], 2);
      expect(variables['wis'], 2);
      expect(variables['хар'], 5);
      expect(variables['cha'], 5);
      expect(variables['бм'], 3);
      expect(variables['pb'], 3);
    });

    test('falls back to ability scores when derived modifiers are missing', () {
      final variables = characterRollVariables(
        CharacterData(
          baseAbilityScores: const {
            'strength': 14,
          },
        ),
      );

      expect(variables['сил'], 2);
      expect(variables['str'], 2);
      expect(variables['pb'], 0);
    });
  });
}
