import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/mechanics/widgets/proficiency_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('character proficiency state', () {
    test('initializes full manual skill snapshot from derived levels', () {
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
      final levels = skillProficiencyLevelMap(updated);

      expect(updated, hasLength(Skill.values.length));
      expect(
        levels[Skill.acrobatics],
        CharacterSkillProficiencyLevel.proficient,
      );
      expect(levels[Skill.stealth], CharacterSkillProficiencyLevel.expertise);
      expect(levels[Skill.athletics], CharacterSkillProficiencyLevel.none);
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

    test('initializes manual saving throw snapshot from derived levels', () {
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

      expect(updated, [
        Ability.strength,
        Ability.dexterity,
        Ability.constitution,
      ]);
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
