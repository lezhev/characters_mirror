part of '../character_data_endpoint_test.dart';

void _registerCharacterDataProficiencyScenarios(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder Function(int userId) authenticatedSession,
) {
  for (final fixture in <({
    String name,
    List<String>? training,
    List<String>? multiclassTraining,
  })>[
    (name: 'null', training: null, multiclassTraining: null),
    (name: 'empty', training: const [], multiclassTraining: const []),
    (
      name: 'mixed categories and keys',
      training: const ['simpleMelee', 'dagger'],
      multiclassTraining: const ['martialRanged', 'shortsword'],
    ),
  ]) {
    test('class weapon training persists ${fixture.name}', () async {
      final inserted = await endpoints.classData.upsert(
        sessionBuilder,
        ClassData(
          name: 'Weapon Training ${fixture.name}',
          weaponTraining: fixture.training,
          multiclassWeaponTraining: fixture.multiclassTraining,
        ),
      );
      final loaded = (await endpoints.classData.getAll(sessionBuilder))
          .singleWhere((classData) => classData.id == inserted.id);
      expect(loaded.weaponTraining, fixture.training);
      expect(loaded.multiclassWeaponTraining, fixture.multiclassTraining);

      await endpoints.classData.upsert(
        sessionBuilder,
        loaded.copyWith(
          weaponTraining: fixture.multiclassTraining,
          multiclassWeaponTraining: fixture.training,
        ),
      );
      final updated = (await endpoints.classData.getAll(sessionBuilder))
          .singleWhere((classData) => classData.id == inserted.id);
      expect(updated.weaponTraining, fixture.multiclassTraining);
      expect(updated.multiclassWeaponTraining, fixture.training);
    });
  }

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
          'simpleMelee',
          'martialMelee',
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
        weaponTraining: const ['martialMelee'],
        multiclassWeaponTraining: const ['simpleMelee'],
      ),
    );
    final wizard = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Multiclass Weapon Wizard',
        weaponTraining: const ['simpleRanged'],
        multiclassWeaponTraining: const ['martialRanged'],
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
        weaponTraining: const ['simpleRanged'],
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
    final group = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'choice_weapon_training',
        name: 'Weapon training choice',
        sourceClassId: classData.id!,
        exclusiveKey: 'choice_weapon_training',
        level: 1,
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
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
        toolProficiencyKeys: const ['smith_tools', 'dice_set'],
      ),
    );
    final fixtureSession = sessionBuilder.build();
    try {
      for (final key in const [
        'smith_tools',
        'thieves_tools',
        'lute',
        'dice_set',
        'navigator_tools',
        'vehicle_land',
      ]) {
        await _ensureToolData(
          fixtureSession,
          referenceKey: key,
          name: key,
          category: ToolCategory.artisan,
        );
      }
    } finally {
      await fixtureSession.close();
    }
    final backgroundToolGroup = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'background_tool_choice',
        name: 'Background tool choice',
        sourceBackgroundId: background.id,
        type: ChoiceType.tool,
        selectionCount: 1,
        allowDuplicates: false,
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: backgroundToolGroup.id!,
        optionKey: 'lute',
        name: 'Lute',
        grantedToolKeys: const ['lute'],
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
    final choiceGroup = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'tool_choice',
        name: 'Tool choice',
        sourceClassId: startingClass.id!,
        type: ChoiceType.tool,
        exclusiveKey: 'tool_choice',
        level: 1,
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
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
            groupKey: 'tool_choice',
            optionKey: 'tools',
          ),
          CharacterChoiceData(
            groupKey: 'background_tool_choice',
            optionKey: 'lute',
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
      await _ensureToolData(
        session,
        referenceKey: 'thieves_tools',
        name: 'Воровские инструменты',
      );
      await _ensureToolData(
        session,
        referenceKey: 'lute',
        name: 'Лютня',
        category: ToolCategory.musicalInstrument,
      );
    } finally {
      await session.close();
    }

    final tools = await endpoints.toolData.getAll(sessionBuilder);

    expect(
      tools
          .singleWhere((tool) => tool.referenceKey == 'thieves_tools')
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
      await _ensureToolData(
        session,
        referenceKey: 'thieves_tools',
        name: 'Воровские инструменты',
      );
      await _ensureToolData(
        session,
        referenceKey: 'smith_tools',
        name: 'Инструменты кузнеца',
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
        weaponTraining: const ['martialMelee'],
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
        manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
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
          manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
            addedKeys: const ['not_in_tool_data'],
          ),
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );
  });

  test('class feature languages join automatic grants and manual overrides',
      () async {
    final druid = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Language grant druid'),
    );
    final rogue = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Language grant rogue'),
    );
    await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: druid.id!,
        name: 'Druidic language fixture',
        level: 1,
        grantedLanguages: const [Language.druidic],
      ),
    );
    await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: rogue.id!,
        name: 'Thieves Cant language fixture',
        level: 1,
        grantedLanguages: const [Language.thievesCant],
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(711),
      CharacterData(
        name: 'Class language grants',
        classEntries: [
          CharacterClassEntryData(
            classData: druid,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
          CharacterClassEntryData(
            classData: rogue,
            level: 1,
            isStartingClass: false,
            classOrder: 1,
          ),
        ],
        manualLanguageOverrides: CharacterLanguageOverridesData(
          added: const [Language.elvish],
          removed: const [Language.druidic],
        ),
      ),
    );

    expect(
      saved.derived?.languages,
      containsAll([Language.thievesCant, Language.elvish]),
    );
    expect(saved.derived?.languages, isNot(contains(Language.druidic)));
    expect(
      saved.derived!.languages!.toSet().length,
      saved.derived!.languages!.length,
    );

    final fighter = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'No language grant class'),
    );
    final withoutGrant = await endpoints.characterData.saveCharacter(
      authenticatedSession(712),
      CharacterData(
        name: 'No special language grants',
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
    expect(withoutGrant.derived?.languages, isNot(contains(Language.druidic)));
    expect(
      withoutGrant.derived?.languages,
      isNot(contains(Language.thievesCant)),
    );
  });

  test('class unarmored defense rules respect armor and shield conditions',
      () async {
    final barbarian = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Unarmored defense barbarian'),
    );
    await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: barbarian.id!,
        name: 'Barbarian defense fixture',
        level: 1,
        unarmoredDefenseRule: UnarmoredDefenseRule.dexterityConstitution,
      ),
    );
    final shield = await endpoints.armorData.upsert(
      sessionBuilder,
      ArmorData(
        referenceKey: 'test_unarmored_shield',
        name: 'Unarmored defense shield fixture',
        categoryValue: ArmorCategory.shield,
        bonusAC: 3,
      ),
    );
    final barbarianCharacter = await endpoints.characterData.saveCharacter(
      authenticatedSession(713),
      CharacterData(
        name: 'Barbarian defense fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: barbarian,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        baseAbilityScores: {'dexterity': 16, 'constitution': 14},
        equippedShield: CharacterEquipmentSelectionData(
          name: shield.name!,
          referenceKey: shield.referenceKey,
        ),
        customArmorClassBonus: 1,
      ),
    );
    expect(barbarianCharacter.derived?.armorClass, 19);

    final monk = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Unarmored defense monk'),
    );
    await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: monk.id!,
        name: 'Monk defense fixture',
        level: 1,
        unarmoredDefenseRule: UnarmoredDefenseRule.dexterityWisdom,
      ),
    );
    final chainMail = await endpoints.armorData.upsert(
      sessionBuilder,
      ArmorData(
        referenceKey: 'test_unarmored_chain_mail',
        name: 'Unarmored defense chain mail fixture',
        categoryValue: ArmorCategory.heavy,
        baseAC: 16,
        dexBonus: false,
      ),
    );
    final monkShield = await endpoints.armorData.upsert(
      sessionBuilder,
      ArmorData(
        referenceKey: 'test_monk_shield_plus_two',
        name: 'Monk shield fixture',
        categoryValue: ArmorCategory.shield,
        bonusAC: 2,
      ),
    );
    final unshieldedMonk = await endpoints.characterData.saveCharacter(
      authenticatedSession(716),
      CharacterData(
        name: 'Unshielded monk fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: monk,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        baseAbilityScores: {'dexterity': 16, 'wisdom': 20},
      ),
    );
    final shieldedMonk = await endpoints.characterData.saveCharacter(
      authenticatedSession(714),
      CharacterData(
        name: 'Shielded monk fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: monk,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        baseAbilityScores: {'dexterity': 16, 'wisdom': 20},
        equippedShield: CharacterEquipmentSelectionData(
          name: monkShield.name!,
          referenceKey: monkShield.referenceKey,
        ),
      ),
    );
    final armoredMonk = await endpoints.characterData.saveCharacter(
      authenticatedSession(715),
      CharacterData(
        name: 'Armored monk fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: monk,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        baseAbilityScores: {'dexterity': 16, 'wisdom': 20},
        equippedArmor: CharacterEquipmentSelectionData(
          name: chainMail.name!,
          referenceKey: chainMail.referenceKey,
        ),
      ),
    );
    expect(unshieldedMonk.derived?.armorClass, 18);
    expect(unshieldedMonk.derived?.armorClassSource, 'Защита без доспехов');
    expect(unshieldedMonk.derived?.armorClassFormula, contains('Мудрость (5)'));
    expect(shieldedMonk.derived?.armorClass, 15);
    expect(shieldedMonk.derived?.armorClassSource, 'Без доспеха');
    expect(shieldedMonk.derived?.armorClassFormula, contains('Щит (2)'));
    expect(armoredMonk.derived?.armorClass, 16);
    expect(armoredMonk.derived?.armorClassSource, chainMail.name);
    expect(armoredMonk.derived?.armorClassFormula, '16');
  });

  test('expertise choices require existing skill proficiency', () async {
    final rogue = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Expertise eligibility rogue'),
    );
    final feature = await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: rogue.id!,
        name: 'Expertise eligibility feature',
        level: 1,
      ),
    );
    final session = sessionBuilder.build();
    late ChoiceGroupData group;
    try {
      group = await ChoiceGroupData.db.insertRow(
        session,
        ChoiceGroupData(
          referenceKey: 'test_expertise_eligibility',
          name: 'Expertise eligibility fixture',
          sourceFeatureId: feature.id,
          level: 1,
          type: ChoiceType.expertise,
          selectionCount: 2,
          minimumSelectionCount: 2,
        ),
      );
      for (final skill in [Skill.stealth, Skill.perception]) {
        await ChoiceOptionData.db.insertRow(
          session,
          ChoiceOptionData(
            choiceGroupId: group.id!,
            optionKey: skill.name,
            name: skill.name,
            grantedExpertiseSkills: [skill],
            requiredExistingSkill: skill,
          ),
        );
      }
    } finally {
      await session.close();
    }

    await expectLater(
      endpoints.characterData.saveCharacter(
        authenticatedSession(716),
        CharacterData(
          name: 'Invalid expertise choices',
          classEntries: [
            CharacterClassEntryData(
              classData: rogue,
              level: 1,
              isStartingClass: true,
              classOrder: 0,
            ),
          ],
          choices: [
            CharacterChoiceData(
              groupKey: group.referenceKey,
              optionKey: Skill.stealth.name,
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              groupKey: group.referenceKey,
              optionKey: Skill.perception.name,
              selectionIndex: 1,
            ),
          ],
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );
  });

  test('expertise allows incomplete choices and doubles only selected bonuses',
      () async {
    final rogue = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Expertise derived rogue'),
    );
    final feature = await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: rogue.id!,
        name: 'Expertise derived feature',
        level: 1,
      ),
    );
    final background = await endpoints.backgroundData.upsert(
      sessionBuilder,
      BackgroundData(
        name: 'Expertise skills background',
        skillProficiencies: const [
          Skill.stealth,
          Skill.perception,
          Skill.athletics,
        ],
      ),
    );
    final group = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'test_expertise_derived',
        name: 'Компетентность',
        sourceFeatureId: feature.id,
        level: 1,
        type: ChoiceType.expertise,
        selectionCount: 2,
        minimumSelectionCount: 2,
      ),
    );
    for (final skill in const [
      Skill.stealth,
      Skill.perception,
      Skill.athletics,
      Skill.acrobatics,
    ]) {
      await _insertGenericChoiceOption(
        sessionBuilder,
        ChoiceOptionData(
          choiceGroupId: group.id!,
          optionKey: skill.name,
          name: skill.name,
          grantedExpertiseSkills: [skill],
          requiredExistingSkill: skill,
        ),
      );
    }
    final toolFixtureSession = sessionBuilder.build();
    try {
      await _ensureToolData(
        toolFixtureSession,
        referenceKey: 'thieves_tools',
        name: 'Thieves’ Tools Expertise Fixture',
        category: ToolCategory.artisan,
      );
    } finally {
      await toolFixtureSession.close();
    }
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: group.id!,
        optionKey: 'thieves_tools',
        name: 'Воровские инструменты',
        requiredExistingToolKey: 'thieves_tools',
        grantedExpertiseToolKeys: const ['thieves_tools'],
      ),
    );

    final valid = await endpoints.characterData.saveCharacter(
      authenticatedSession(717),
      CharacterData(
        name: 'Expertise selected skills',
        background: background,
        baseAbilityScores: const {
          'dexterity': 10,
          'wisdom': 10,
          'strength': 10
        },
        classEntries: [
          CharacterClassEntryData(
            classData: rogue,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            groupKey: group.referenceKey,
            optionKey: Skill.stealth.name,
            selectionIndex: 0,
          ),
          CharacterChoiceData(
            groupKey: group.referenceKey,
            optionKey: Skill.perception.name,
            selectionIndex: 1,
          ),
        ],
      ),
    );

    expect(
      valid.derived!.skillProficiencyLevels!
          .singleWhere((state) => state.skill == Skill.stealth)
          .level,
      CharacterSkillProficiencyLevel.expertise,
    );
    expect(valid.derived!.skillBonuses![Skill.stealth], 4);
    expect(valid.derived!.skillBonuses![Skill.perception], 4);
    expect(
      valid.derived!.skillProficiencyLevels!
          .singleWhere((state) => state.skill == Skill.athletics)
          .level,
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(valid.derived!.skillBonuses![Skill.athletics], 2);

    final ownedToolsBackground = await endpoints.backgroundData.upsert(
      sessionBuilder,
      BackgroundData(
        name: 'Expertise thieves tools background',
        skillProficiencies: const [Skill.stealth],
        toolProficiencyKeys: const ['thieves_tools'],
      ),
    );
    final toolExpertise = await endpoints.characterData.saveCharacter(
      authenticatedSession(724),
      CharacterData(
        name: 'Expertise selected thieves tools',
        background: ownedToolsBackground,
        classEntries: [
          CharacterClassEntryData(
            classData: rogue,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            groupKey: group.referenceKey,
            optionKey: 'thieves_tools',
            selectionIndex: 0,
          ),
          CharacterChoiceData(
            groupKey: group.referenceKey,
            optionKey: Skill.stealth.name,
            selectionIndex: 1,
          ),
        ],
      ),
    );
    expect(toolExpertise.derived!.toolExpertiseKeys, contains('thieves_tools'));

    await expectLater(
      endpoints.characterData.saveCharacter(
        authenticatedSession(725),
        CharacterData(
          name: 'Unproficient thieves tools expertise',
          background: background,
          classEntries: [
            CharacterClassEntryData(
              classData: rogue,
              level: 1,
              isStartingClass: true,
              classOrder: 0,
            ),
          ],
          choices: [
            CharacterChoiceData(
              groupKey: group.referenceKey,
              optionKey: 'thieves_tools',
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              groupKey: group.referenceKey,
              optionKey: Skill.stealth.name,
              selectionIndex: 1,
            ),
          ],
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );

    await expectLater(
      endpoints.characterData.saveCharacter(
        authenticatedSession(718),
        CharacterData(
          name: 'Non proficient expertise target',
          background: background,
          classEntries: [
            CharacterClassEntryData(
              classData: rogue,
              level: 1,
              isStartingClass: true,
              classOrder: 0,
            ),
          ],
          choices: [
            CharacterChoiceData(
              groupKey: group.referenceKey,
              optionKey: Skill.acrobatics.name,
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              groupKey: group.referenceKey,
              optionKey: Skill.stealth.name,
              selectionIndex: 1,
            ),
          ],
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );

    final noExpertise = await endpoints.characterData.saveCharacter(
      authenticatedSession(729),
      CharacterData(
        name: 'No expertise selected',
        background: background,
        classEntries: [
          CharacterClassEntryData(
            classData: rogue,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );
    expect(
        noExpertise.derived!.skillProficiencyLevels!
            .singleWhere((state) => state.skill == Skill.stealth)
            .level,
        CharacterSkillProficiencyLevel.proficient);
    final reloadedNoExpertise = await endpoints.characterData.getCharacter(
      authenticatedSession(729),
      noExpertise.id!,
    );
    expect(
      reloadedNoExpertise.choices
          ?.where((choice) => choice.groupKey == group.referenceKey),
      isEmpty,
    );

    final partialExpertise = await endpoints.characterData.saveCharacter(
      authenticatedSession(730),
      CharacterData(
        name: 'One expertise selected',
        background: background,
        classEntries: [
          CharacterClassEntryData(
            classData: rogue,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            groupKey: group.referenceKey,
            optionKey: Skill.stealth.name,
            selectionIndex: 0,
          ),
        ],
      ),
    );
    expect(
        partialExpertise.derived!.skillProficiencyLevels!
            .singleWhere((state) => state.skill == Skill.stealth)
            .level,
        CharacterSkillProficiencyLevel.expertise);
    expect(
        partialExpertise.derived!.skillProficiencyLevels!
            .singleWhere((state) => state.skill == Skill.perception)
            .level,
        CharacterSkillProficiencyLevel.proficient);
    final reloadedPartialExpertise = await endpoints.characterData.getCharacter(
      authenticatedSession(730),
      partialExpertise.id!,
    );
    expect(
      reloadedPartialExpertise.choices
          ?.where((choice) => choice.groupKey == group.referenceKey)
          .map((choice) => choice.optionKey),
      [Skill.stealth.name],
    );
    final reloadedCompleteExpertise = await endpoints.characterData.getCharacter(
      authenticatedSession(717),
      valid.id!,
    );
    expect(
      reloadedCompleteExpertise.choices
          ?.where((choice) => choice.groupKey == group.referenceKey)
          .map((choice) => choice.optionKey),
      containsAll([Skill.stealth.name, Skill.perception.name]),
    );

    await expectLater(
      endpoints.characterData.saveCharacter(
        authenticatedSession(731),
        CharacterData(
          name: 'Too many expertise selections',
          background: background,
          classEntries: [
            CharacterClassEntryData(
              classData: rogue,
              level: 1,
              isStartingClass: true,
              classOrder: 0,
            ),
          ],
          choices: [
            for (var index = 0; index < 3; index++)
              CharacterChoiceData(
                groupKey: group.referenceKey,
                optionKey: [
                  Skill.stealth,
                  Skill.perception,
                  Skill.athletics,
                ][index]
                    .name,
                selectionIndex: index,
              ),
          ],
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );
  });

  test('feature choices persist and resolve their selected language', () async {
    final ranger = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Favored Enemy persistence ranger'),
    );
    final feature = await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: ranger.id!,
        name: 'Избранный враг',
        level: 1,
      ),
    );
    final enemyGroup = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'test_favored_enemy_type',
        name: 'Избранный враг',
        sourceFeatureId: feature.id,
        level: 1,
        type: ChoiceType.featureOption,
        sortOrder: 10,
        selectionCount: 1,
        minimumSelectionCount: 1,
      ),
    );
    final languageGroup = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'test_favored_enemy_language',
        name: 'Язык избранного врага',
        sourceFeatureId: feature.id,
        level: 1,
        type: ChoiceType.language,
        sortOrder: 20,
        selectionCount: 1,
        minimumSelectionCount: 1,
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: enemyGroup.id!,
        optionKey: 'undead',
        name: 'Нежить',
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: enemyGroup.id!,
        optionKey: 'beasts',
        name: 'Звери',
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: languageGroup.id!,
        optionKey: Language.undercommon.name,
        name: 'Подземный',
        grantedLanguages: const [Language.undercommon],
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: languageGroup.id!,
        optionKey: Language.dwarvish.name,
        name: 'Дварфийский',
        grantedLanguages: const [Language.dwarvish],
      ),
    );

    Future<void> expectInvalidChoices(
      int userId,
      List<CharacterChoiceData> choices,
    ) async {
      await expectLater(
        endpoints.characterData.saveCharacter(
          authenticatedSession(userId),
          CharacterData(
            name: 'Invalid Favored Enemy choices $userId',
            classEntries: [
              CharacterClassEntryData(
                classData: ranger,
                level: 1,
                isStartingClass: true,
                classOrder: 0,
              ),
            ],
            choices: choices,
          ),
        ),
        throwsA(isA<InputValidationException>()),
      );
    }

    final partial = await endpoints.characterData.saveCharacter(
      authenticatedSession(726),
      CharacterData(
        name: 'Partial Favored Enemy choice',
        classEntries: [
          CharacterClassEntryData(
            classData: ranger,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            groupKey: enemyGroup.referenceKey,
            optionKey: 'undead',
          ),
        ],
      ),
    );
    expect(partial.choices, hasLength(1));
    await expectInvalidChoices(727, [
      CharacterChoiceData(
        groupKey: enemyGroup.referenceKey,
        optionKey: 'undead',
      ),
      CharacterChoiceData(
        groupKey: enemyGroup.referenceKey,
        optionKey: 'beasts',
      ),
      CharacterChoiceData(
        groupKey: languageGroup.referenceKey,
        optionKey: Language.undercommon.name,
      ),
    ]);
    await expectInvalidChoices(728, [
      CharacterChoiceData(
        groupKey: enemyGroup.referenceKey,
        optionKey: 'undead',
      ),
      CharacterChoiceData(
        groupKey: languageGroup.referenceKey,
        optionKey: Language.undercommon.name,
      ),
      CharacterChoiceData(
        groupKey: languageGroup.referenceKey,
        optionKey: Language.dwarvish.name,
      ),
    ]);

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(723),
      CharacterData(
        name: 'Favored Enemy saved choices',
        classEntries: [
          CharacterClassEntryData(
            classData: ranger,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            groupKey: enemyGroup.referenceKey,
            optionKey: 'undead',
          ),
          CharacterChoiceData(
            groupKey: languageGroup.referenceKey,
            optionKey: Language.undercommon.name,
          ),
        ],
      ),
    );
    final loaded = await endpoints.characterData.getCharacter(
      authenticatedSession(723),
      saved.id!,
    );

    expect(loaded.choices, hasLength(2));
    expect(
      loaded.choices!.map((choice) => (choice.groupKey, choice.optionKey)),
      containsAll([
        (enemyGroup.referenceKey, 'undead'),
        (languageGroup.referenceKey, Language.undercommon.name),
      ]),
    );
    expect(loaded.derived!.languages, contains(Language.undercommon));
    expect(
      loaded.derived!.languages!.length,
      loaded.derived!.languages!.toSet().length,
    );
    expect(
      loaded.derived!.activeFeatures!
          .singleWhere((active) => active.sourceId == feature.id)
          .selectedChoices,
      ['Избранный враг: Нежить', 'Язык избранного врага: Подземный'],
    );
  });

  test('Natural Explorer terrain is required, nested and persists on reload',
      () async {
    final ranger = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(name: 'Natural Explorer ranger fixture', hitDieValue: 10),
    );
    final feature = await endpoints.classFeatureData.add(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: ranger.id!,
        name: 'Исследователь природы',
        level: 1,
      ),
    );
    final group = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: 'test_natural_explorer_terrain',
        name: 'Избранная местность',
        sourceFeatureId: feature.id,
        level: 1,
        type: ChoiceType.featureOption,
        selectionCount: 1,
        minimumSelectionCount: 1,
        allowDuplicates: false,
      ),
    );
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: group.id!,
        optionKey: 'forest',
        name: 'Леса',
      ),
    );
    final stepView = await endpoints.classData.getStepView(
      sessionBuilder,
      ranger.id!,
      selectedLevel: 1,
      isStartingClass: true,
    );
    expect(
      stepView.choiceGroups
          ?.singleWhere(
            (view) => view.group?.referenceKey == group.referenceKey,
          )
          .group
          ?.sourceFeatureId,
      feature.id,
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(729),
      CharacterData(
        name: 'Natural Explorer saved terrain',
        classEntries: [
          CharacterClassEntryData(
            classData: ranger,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            groupKey: group.referenceKey,
            optionKey: 'forest',
          ),
        ],
      ),
    );
    final loaded = await endpoints.characterData.getCharacter(
      authenticatedSession(729),
      saved.id!,
    );
    expect(loaded.choices?.single.optionKey, 'forest');
    expect(
      loaded.derived!.activeFeatures!
          .singleWhere((active) => active.sourceId == feature.id)
          .selectedChoices,
      ['Избранная местность: Леса'],
    );
  });
}
