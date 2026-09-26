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

  test('racial weapon proficiency keys stay separate from weapon training',
      () async {
    final dwarf = await endpoints.raceData.upsert(
      sessionBuilder,
      RaceData(
        name: 'Weapon Proficiency Dwarf',
        weaponProficiencyKeys: const [
          'battleaxe',
          'handaxe',
          'light_hammer',
          'warhammer',
        ],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(703),
      CharacterData(name: 'Dwarf Weapon Keys', race: dwarf),
    );

    expect(saved.derived?.weaponTraining, isEmpty);
    expect(
      saved.derived?.weaponProficiencyKeys,
      unorderedEquals([
        'battleaxe',
        'handaxe',
        'light_hammer',
        'warhammer',
      ]),
    );
  });

  test('starting class weapon training remains typed categories', () async {
    final fighter = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Starting Weapon Fighter',
        weaponTraining: const [
          WeaponCategory.simpleMelee,
          WeaponCategory.martialMelee,
        ],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(704),
      CharacterData(
        name: 'Starting Weapon Training',
        classEntries: [
          CharacterClassEntryData(
            classData: fighter,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    expect(
      saved.derived?.weaponTraining,
      unorderedEquals([
        WeaponCategory.simpleMelee,
        WeaponCategory.martialMelee,
      ]),
    );
    expect(saved.derived?.weaponProficiencyKeys, isEmpty);
  });

  test('multiclass weapon training uses multiclass categories only', () async {
    final fighter = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Multiclass Weapon Fighter',
        weaponTraining: const [WeaponCategory.martialMelee],
        multiclassWeaponTraining: const [WeaponCategory.simpleMelee],
      ),
    );
    final wizard = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Multiclass Weapon Wizard',
        weaponTraining: const [WeaponCategory.simpleRanged],
        multiclassWeaponTraining: const [WeaponCategory.martialRanged],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(705),
      CharacterData(
        name: 'Multiclass Weapon Training',
        classEntries: [
          CharacterClassEntryData(
            classData: fighter,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
          CharacterClassEntryData(
            classData: wizard,
            level: 1,
            isStartingClass: false,
            classOrder: 1,
          ),
        ],
      ),
    );

    expect(
      saved.derived?.weaponTraining,
      unorderedEquals([
        WeaponCategory.martialMelee,
        WeaponCategory.martialRanged,
      ]),
    );
  });

  test('race keys and class weapon training are aggregated independently',
      () async {
    final race = await endpoints.raceData.upsert(
      sessionBuilder,
      RaceData(
        name: 'Combined Weapon Race',
        weaponProficiencyKeys: const ['battleaxe'],
      ),
    );
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Combined Weapon Class',
        weaponTraining: const [WeaponCategory.simpleRanged],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(706),
      CharacterData(
        name: 'Combined Weapon Proficiencies',
        race: race,
        classEntries: [
          CharacterClassEntryData(
            classData: classData,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    expect(saved.derived?.weaponTraining, [WeaponCategory.simpleRanged]);
    expect(saved.derived?.weaponProficiencyKeys, ['battleaxe']);
  });

  test('supported class choice weapon training is included', () async {
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Choice Weapon Class'),
    );
    final group = await endpoints.classChoiceGroupData.upsert(
      sessionBuilder,
      ClassChoiceGroupData(
        name: 'Weapon training choice',
        sourceClassId: classData.id!,
        exclusiveKey: 'choice_weapon_training',
        level: 1,
      ),
    );
    await endpoints.classChoiceOptionData.upsert(
      sessionBuilder,
      ClassChoiceOptionData(
        choiceGroupId: group.id!,
        optionKey: 'martial',
        grantedWeaponTraining: const [WeaponCategory.martialMelee],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(707),
      CharacterData(
        name: 'Class Choice Weapon Training',
        classEntries: [
          CharacterClassEntryData(
            classData: classData,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            sourceType: ChoiceSourceType.classData,
            sourceId: classData.id,
            groupKey: 'choice_weapon_training',
            optionKey: 'martial',
          ),
        ],
      ),
    );

    expect(saved.derived?.weaponTraining, [WeaponCategory.martialMelee]);
  });

  test('fixed tool grants merge canonical keys and ignore category markers',
      () async {
    final race = await endpoints.raceData.upsert(
      sessionBuilder,
      RaceData(
        name: 'Tool Race',
        toolProficiencyKeys: const ['smith_tools', 'thieves_tools'],
      ),
    );
    final subrace = await endpoints.subraceData.upsert(
      sessionBuilder,
      SubraceData(
        name: 'Tool Subrace',
        parentRaceId: race.id!,
        toolProficiencyKeys: const ['lute'],
      ),
    );
    final background = await endpoints.backgroundData.upsert(
      sessionBuilder,
      BackgroundData(
        name: 'Tool Background',
        toolProficiencies: const [
          'Музыкальный инструмент',
          'Игровой набор',
          'Инструменты ремесленника',
        ],
        toolProficiencyKeys: const ['smith_tools', 'dice_set'],
      ),
    );
    final startingClass = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Tool Starting Class',
        toolTrainingKeys: const ['navigator_tools', 'smith_tools'],
      ),
    );
    final multiclass = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Tool Multiclass',
        toolTrainingKeys: const ['not_a_multiclass_grant'],
        multiclassToolTrainingKeys: const ['vehicle_land'],
      ),
    );
    final choiceGroup = await endpoints.classChoiceGroupData.upsert(
      sessionBuilder,
      ClassChoiceGroupData(
        name: 'Tool choice',
        sourceClassId: startingClass.id!,
        exclusiveKey: 'tool_choice',
        level: 1,
      ),
    );
    await endpoints.classChoiceOptionData.upsert(
      sessionBuilder,
      ClassChoiceOptionData(
        choiceGroupId: choiceGroup.id!,
        optionKey: 'tools',
        grantedToolKeys: const ['lute', 'dice_set'],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(708),
      CharacterData(
        name: 'Canonical Tool Grants',
        race: race,
        subrace: subrace,
        background: background,
        classEntries: [
          CharacterClassEntryData(
            classData: startingClass,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
          CharacterClassEntryData(
            classData: multiclass,
            level: 1,
            isStartingClass: false,
            classOrder: 1,
          ),
        ],
        choices: [
          CharacterChoiceData(
            sourceType: ChoiceSourceType.classData,
            sourceId: startingClass.id,
            groupKey: 'tool_choice',
            optionKey: 'tools',
          ),
        ],
      ),
    );

    expect(
      saved.derived?.toolProficiencyKeys,
      unorderedEquals([
        'dice_set',
        'lute',
        'navigator_tools',
        'smith_tools',
        'thieves_tools',
        'vehicle_land',
      ]),
    );
    expect(saved.derived?.toJson(), isNot(contains('toolProficiencies')));
  });

  test('ToolData reference endpoint exposes canonical names and categories',
      () async {
    final session = sessionBuilder.build();
    try {
      await ToolData.db.insertRow(
        session,
        ToolData(
          referenceKey: 'thieves_tools',
          name: 'Воровские инструменты',
        ),
      );
      await ToolData.db.insertRow(
        session,
        ToolData(
          referenceKey: 'lute',
          name: 'Лютня',
          category: ToolCategory.musicalInstrument,
        ),
      );
    } finally {
      await session.close();
    }

    final tools = await endpoints.toolData.getAll(sessionBuilder);

    expect(tools, hasLength(2));
    expect(
      tools.singleWhere((tool) => tool.referenceKey == 'thieves_tools')
          .category,
      isNull,
    );
    expect(
      tools.singleWhere((tool) => tool.referenceKey == 'lute').category,
      ToolCategory.musicalInstrument,
    );
  });

  test('proficiency overrides affect effective state and normalize custom text',
      () async {
    final session = sessionBuilder.build();
    try {
      await ToolData.db.insertRow(
        session,
        ToolData(referenceKey: 'thieves_tools', name: 'Воровские инструменты'),
      );
      await ToolData.db.insertRow(
        session,
        ToolData(referenceKey: 'smith_tools', name: 'Инструменты кузнеца'),
      );
      await WeaponData.db.insertRow(
        session,
        WeaponData(
          referenceKey: 'battleaxe',
          name: 'Боевой топор',
          category: WeaponCategory.martialMelee,
        ),
      );
      await WeaponData.db.insertRow(
        session,
        WeaponData(
          referenceKey: 'longsword',
          name: 'Длинный меч',
          category: WeaponCategory.martialMelee,
        ),
      );
    } finally {
      await session.close();
    }

    final race = await endpoints.raceData.upsert(
      sessionBuilder,
      RaceData(
        name: 'Override Race',
        languages: const [Language.common],
        armorProficiencies: const [ArmorCategory.light],
        toolProficiencyKeys: const ['smith_tools'],
        weaponProficiencyKeys: const ['battleaxe'],
      ),
    );
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Override Class',
        weaponTraining: const [WeaponCategory.martialMelee],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(709),
      CharacterData(
        name: 'Proficiency Overrides',
        race: race,
        classEntries: [
          CharacterClassEntryData(
            classData: classData,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        manualLanguageOverrides: CharacterLanguageOverridesData(
          added: const [Language.elvish],
          removed: const [Language.common],
          custom: const ['  River speech  ', 'river SPEECH'],
        ),
        manualToolProficiencyOverrides:
            CharacterToolProficiencyOverridesData(
          addedKeys: const ['thieves_tools'],
          removedKeys: const ['smith_tools'],
          custom: const [' Clockwork tools '],
        ),
        manualWeaponProficiencyOverrides:
            CharacterWeaponProficiencyOverridesData(
          addedCategories: const [WeaponCategory.simpleRanged],
          removedCategories: const [WeaponCategory.martialMelee],
          addedKeys: const ['longsword'],
          removedKeys: const ['battleaxe'],
          custom: const [' Moonblade '],
        ),
        manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
          addedCategories: const [ArmorCategory.shield],
          removedCategories: const [ArmorCategory.light],
          custom: const [' Bone armor '],
        ),
      ),
    );

    expect(saved.derived?.languages, [Language.elvish]);
    expect(saved.derived?.customLanguages, ['River speech']);
    expect(saved.derived?.toolProficiencyKeys, ['thieves_tools']);
    expect(saved.derived?.customToolProficiencies, ['Clockwork tools']);
    expect(saved.derived?.weaponTraining, [WeaponCategory.simpleRanged]);
    expect(saved.derived?.weaponProficiencyKeys, ['longsword']);
    expect(saved.derived?.customWeaponProficiencies, ['Moonblade']);
    expect(saved.derived?.armorTraining, [ArmorCategory.shield]);
    expect(saved.derived?.customArmorTraining, ['Bone armor']);
    expect(saved.manualLanguageOverrides?.custom, ['River speech']);
  });

  test('proficiency overrides reject unknown canonical reference keys',
      () async {
    await expectLater(
      endpoints.characterData.saveCharacter(
        authenticatedSession(710),
        CharacterData(
          name: 'Unknown Tool Grant',
          manualToolProficiencyOverrides:
              CharacterToolProficiencyOverridesData(
            addedKeys: const ['not_in_tool_data'],
          ),
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );
  });

}
