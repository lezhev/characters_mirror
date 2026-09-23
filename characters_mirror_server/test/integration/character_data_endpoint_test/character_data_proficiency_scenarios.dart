part of '../character_data_endpoint_test.dart';

void _registerCharacterDataProficiencyScenarios(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder Function(int userId) authenticatedSession,
) {
  test('multiclass saving throws use only the starting class and overrides',
      () async {
    final fighter = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Saving Throw Fighter',
        savingThrowProficiencies: const [
          Ability.strength,
          Ability.constitution,
        ],
      ),
    );
    final wizard = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Saving Throw Wizard',
        savingThrowProficiencies: const [
          Ability.intelligence,
          Ability.wisdom,
        ],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(701),
      CharacterData(
        name: 'Multiclass Saving Throws',
        classEntries: [
          CharacterClassEntryData(
            classData: wizard,
            level: 1,
            isStartingClass: false,
            classOrder: 1,
          ),
          CharacterClassEntryData(
            classData: fighter,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        manualSavingThrowProficiencyOverrides: [
          CharacterSavingThrowProficiencyOverrideData(
            ability: Ability.constitution,
            state: CharacterSavingThrowProficiencyOverride.remove,
          ),
          CharacterSavingThrowProficiencyOverrideData(
            ability: Ability.dexterity,
            state: CharacterSavingThrowProficiencyOverride.add,
          ),
        ],
      ),
    );

    expect(
      saved.derived?.savingThrowProficiencies,
      unorderedEquals([Ability.strength, Ability.dexterity]),
    );
  });

  test('saving throw starting class fallback uses the lowest class order',
      () async {
    final fighter = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Fallback Fighter',
        savingThrowProficiencies: const [
          Ability.strength,
          Ability.constitution,
        ],
      ),
    );
    final wizard = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Fallback Wizard',
        savingThrowProficiencies: const [
          Ability.intelligence,
          Ability.wisdom,
        ],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(702),
      CharacterData(
        name: 'Fallback Saving Throws',
        classEntries: [
          CharacterClassEntryData(
            classData: wizard,
            level: 1,
            classOrder: 2,
          ),
          CharacterClassEntryData(
            classData: fighter,
            level: 1,
            classOrder: 1,
          ),
        ],
      ),
    );

    expect(
      saved.derived?.savingThrowProficiencies,
      unorderedEquals([Ability.strength, Ability.constitution]),
    );
  });
}
