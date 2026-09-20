import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/widgets/proficiency_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('character proficiency state', () {
    test('creates a sparse skill override over derived levels', () {
      final character = CharacterData(
        derived: CharacterDerivedData(
          skillProficiencyLevels: [
            CharacterSkillProficiencyState(
              skill: Skill.acrobatics,
              level: CharacterSkillProficiencyLevel.proficient,
            ),
          ],
        ),
      );

      final updated = buildManualSkillProficiencies(
        character: character,
        skill: Skill.stealth,
        level: CharacterSkillProficiencyLevel.expertise,
      );
      expect(updated, hasLength(1));
      expect(updated.single.skill, Skill.stealth);
      expect(
        updated.single.level,
        CharacterSkillProficiencyLevel.expertise,
      );
    });

    test('manual skill snapshot replaces derived levels when present', () {
      final character = CharacterData(
        manualSkillProficiencies: [
          CharacterSkillProficiencyState(
            skill: Skill.acrobatics,
            level: CharacterSkillProficiencyLevel.none,
          ),
        ],
        derived: CharacterDerivedData(
          skillProficiencyLevels: [
            CharacterSkillProficiencyState(
              skill: Skill.acrobatics,
              level: CharacterSkillProficiencyLevel.proficient,
            ),
          ],
        ),
      );

      final updated = buildManualSkillProficiencies(
        character: character,
        skill: Skill.athletics,
        level: CharacterSkillProficiencyLevel.proficient,
      );
      final levels = skillProficiencyLevelMap(updated);

      expect(levels[Skill.acrobatics], CharacterSkillProficiencyLevel.none);
      expect(
        levels[Skill.athletics],
        CharacterSkillProficiencyLevel.proficient,
      );
    });

    test('creates a tri-state saving throw override over derived levels', () {
      final character = CharacterData(
        derived: CharacterDerivedData(
          savingThrowProficiencies: const [
            Ability.strength,
            Ability.constitution,
          ],
        ),
      );

      final updated = buildManualSavingThrowProficiencies(
        character: character,
        ability: Ability.dexterity,
        proficient: true,
      );

      expect(updated, hasLength(1));
      expect(updated.single.ability, Ability.dexterity);
      expect(
        updated.single.state,
        CharacterSavingThrowProficiencyOverride.add,
      );
    });

    test('skill proficiency cycles through expertise', () {
      expect(
        nextSkillProficiencyLevel(CharacterSkillProficiencyLevel.none),
        CharacterSkillProficiencyLevel.proficient,
      );
      expect(
        nextSkillProficiencyLevel(CharacterSkillProficiencyLevel.proficient),
        CharacterSkillProficiencyLevel.expertise,
      );
      expect(
        nextSkillProficiencyLevel(CharacterSkillProficiencyLevel.expertise),
        CharacterSkillProficiencyLevel.none,
      );
    });

    test('optimistic skill bonus uses modifier and proficiency multiplier', () {
      final character = CharacterData(
        derived: CharacterDerivedData(
          proficiencyBonus: 3,
          abilityModifiers: const {
            'strength': 1,
            'wisdom': 2,
          },
          skillBonuses: const {
            'athletics': 1,
            'perception': 2,
          },
        ),
      );
      final manual = buildManualSkillProficiencies(
        character: character,
        skill: Skill.athletics,
        level: CharacterSkillProficiencyLevel.expertise,
      );

      final updated = withOptimisticSkillProficiency(
        character: character,
        manualSkillProficiencies: manual,
      );

      expect(updated.derived?.skillBonuses?[Skill.athletics.name], 7);
      expect(updated.derived?.skillBonuses?[Skill.perception.name], 2);
      expect(
        skillProficiencyLevelMap(
            updated.derived?.skillProficiencyLevels)[Skill.athletics],
        CharacterSkillProficiencyLevel.expertise,
      );
    });

    test('optimistic saving throw bonus uses modifier and proficiency', () {
      final character = CharacterData(
        derived: CharacterDerivedData(
          proficiencyBonus: 2,
          abilityModifiers: const {
            'strength': 1,
            'dexterity': 3,
          },
          savingThrowBonuses: const {
            'strength': 1,
            'dexterity': 3,
          },
        ),
      );
      final manual = buildManualSavingThrowProficiencies(
        character: character,
        ability: Ability.dexterity,
        proficient: true,
      );

      final updated = withOptimisticSavingThrowProficiency(
        character: character,
        manualSavingThrowProficiencies: manual,
      );

      expect(updated.derived?.savingThrowBonuses?[Ability.strength.name], 1);
      expect(updated.derived?.savingThrowBonuses?[Ability.dexterity.name], 5);
      expect(updated.derived?.savingThrowProficiencies, [Ability.dexterity]);
    });

    test('optimistic skill update refreshes passive checks', () {
      final character = CharacterData(
        derived: CharacterDerivedData(
          proficiencyBonus: 2,
          abilityModifiers: const {
            'intelligence': 1,
            'wisdom': 2,
          },
        ),
      );
      final manual = [
        for (final skill in Skill.values)
          CharacterSkillProficiencyState(
            skill: skill,
            level: skill == Skill.perception
                ? CharacterSkillProficiencyLevel.proficient
                : skill == Skill.investigation
                    ? CharacterSkillProficiencyLevel.expertise
                    : CharacterSkillProficiencyLevel.none,
          ),
      ];

      final updated = withOptimisticSkillProficiency(
        character: character,
        manualSkillProficiencies: manual,
      );

      expect(updated.derived?.passivePerception, 14);
      expect(updated.derived?.passiveInvestigation, 15);
      expect(updated.derived?.passiveInsight, 12);
    });
  });

  group('ProficiencyToggle', () {
    testWidgets('skill mode advances proficient to expertise', (tester) async {
      CharacterSkillProficiencyLevel? changed;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProficiencyToggle(
              level: CharacterSkillProficiencyLevel.proficient,
              onChanged: (level) => changed = level,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ProficiencyToggle));

      expect(changed, CharacterSkillProficiencyLevel.expertise);
    });

    testWidgets('saving throw mode skips expertise', (tester) async {
      CharacterSkillProficiencyLevel? changed;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProficiencyToggle(
              level: CharacterSkillProficiencyLevel.proficient,
              allowExpertise: false,
              onChanged: (level) => changed = level,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ProficiencyToggle));

      expect(changed, CharacterSkillProficiencyLevel.none);
    });
  });
}
