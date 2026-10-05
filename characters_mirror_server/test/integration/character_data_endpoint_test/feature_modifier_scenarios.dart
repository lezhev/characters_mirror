part of '../character_data_endpoint_test.dart';

void _registerFeatureModifierScenarios(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder Function(int userId) authenticatedSession,
) {
  test('Jack of All Trades applies to unproficient checks and initiative only',
      () async {
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final bard = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        referenceKey: 'stage3_test_bard_$stamp',
        name: 'Stage 3 Test Bard',
        hitDieValue: 8,
      ),
    );
    final feature = await endpoints.classFeatureData.upsert(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: bard.id!,
        referenceKey: 'stage3_test_jack_$stamp',
        name: 'Jack test fixture',
        level: 2,
      ),
    );
    final session = sessionBuilder.build();
    try {
      await FeatureModifierData.db.insertRow(
        session,
        FeatureModifierData(
          referenceKey: 'stage3.test.jack.$stamp',
          classFeatureId: feature.id,
          target: FeatureModifierTarget.abilityCheck,
          operation: FeatureModifierOperation.add,
          value: FeatureModifierValueData(
            kind: FeatureModifierValueKind.proficiencyBonusFraction,
            numerator: 1,
            denominator: 2,
            rounding: FeatureModifierRounding.floor,
          ),
          conditions: [
            FeatureModifierConditionData(
              type: FeatureModifierConditionType.abilityCheckIsNotProficient,
            ),
          ],
        ),
      );
    } finally {
      await session.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(9201),
      CharacterData(
        name: 'Stage 3 Jack parity fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: bard,
            level: 2,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        manualSkillProficiencyOverrides: [
          CharacterSkillProficiencyState(
            skill: Skill.acrobatics,
            level: CharacterSkillProficiencyLevel.proficient,
          ),
          CharacterSkillProficiencyState(
            skill: Skill.stealth,
            level: CharacterSkillProficiencyLevel.expertise,
          ),
        ],
      ),
    );
    expect(saved.derived?.skillBonuses?[Skill.athletics], 1);
    expect(saved.derived?.skillBonuses?[Skill.acrobatics], 2);
    expect(saved.derived?.skillBonuses?[Skill.stealth], 4);
    expect(saved.derived?.initiative, 1);
    expect(saved.derived?.savingThrowBonuses?[Ability.dexterity], 0);
  });

  test('Monk movement uses Monk level and existing armor and shield state',
      () async {
    final stamp = DateTime.now().microsecondsSinceEpoch;
    final monk = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        referenceKey: 'stage3_test_monk_$stamp',
        name: 'Stage 3 Test Monk',
        hitDieValue: 8,
      ),
    );
    final fighter = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        referenceKey: 'stage3_test_fighter_$stamp',
        name: 'Stage 3 Test Fighter',
        hitDieValue: 10,
      ),
    );
    final feature = await endpoints.classFeatureData.upsert(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: monk.id!,
        referenceKey: 'stage3_test_movement_$stamp',
        name: 'Movement test fixture',
        level: 2,
      ),
    );
    final session = sessionBuilder.build();
    try {
      await FeatureModifierData.db.insertRow(
        session,
        FeatureModifierData(
          referenceKey: 'stage3.test.movement.$stamp',
          classFeatureId: feature.id,
          target: FeatureModifierTarget.speed,
          operation: FeatureModifierOperation.add,
          value: FeatureModifierValueData(
            kind: FeatureModifierValueKind.classLevelProgression,
            progression: const {2: 10, 6: 15, 10: 20, 14: 25, 18: 30},
          ),
          conditions: [
            FeatureModifierConditionData(
              type: FeatureModifierConditionType.unarmored,
            ),
            FeatureModifierConditionData(
              type: FeatureModifierConditionType.noShield,
            ),
          ],
        ),
      );
    } finally {
      await session.close();
    }

    Future<CharacterData> save({bool armor = false, bool shield = false}) =>
        endpoints.characterData.saveCharacter(
          authenticatedSession(9202),
          CharacterData(
            name: 'Stage 3 Monk movement parity fixture',
            classEntries: [
              CharacterClassEntryData(
                classData: monk,
                level: 2,
                isStartingClass: true,
                classOrder: 0,
              ),
              CharacterClassEntryData(
                classData: fighter,
                level: 8,
                isStartingClass: false,
                classOrder: 1,
              ),
            ],
            equippedArmor: armor
                ? CharacterEquipmentSelectionData(name: 'Leather armor')
                : null,
            equippedShield:
                shield ? CharacterEquipmentSelectionData(name: 'Shield') : null,
          ),
        );

    expect((await save()).derived?.speed, 40);
    expect((await save(armor: true)).derived?.speed, 30);
    expect((await save(shield: true)).derived?.speed, 30);
  });
}
