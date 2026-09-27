part of '../character_data_endpoint_test.dart';

void _registerCharacterDataCreationScenarios(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder Function(int userId) authenticatedSession,
) {
  test('Charlatan background includes its canonical forgery kit grant',
      () async {
    final session = sessionBuilder.build();
    try {
      final background = await BackgroundData.db.findFirstRow(
        session,
        where: (row) => row.name.equals('Шарлатан'),
      );
      expect(background, isNotNull);

      final entries = await StartingEquipmentEntryData.db.find(
        session,
        where: (row) => row.sourceBackgroundId.equals(background!.id),
      );
      expect(
        entries.where(
          (entry) =>
              entry.kind == StartingEquipmentEntryKind.fixedLine &&
              entry.lineKind == StartingEquipmentLineKind.catalogRef &&
              entry.catalogType == EquipmentCatalogType.tool &&
              entry.referenceKey == 'forgery_kit',
        ),
        hasLength(1),
      );
    } finally {
      await session.close();
    }
  });

  test(
      'background starting equipment resolves canonical fixed and category grants',
      () async {
    final session = sessionBuilder.build();
    late BackgroundData background;
    late ItemData clothes;
    late ToolData tool;
    late StartingEquipmentEntryData fixedLine;
    late StartingEquipmentEntryData group;
    late StartingEquipmentEntryData option;
    late StartingEquipmentEntryData categoryLine;
    try {
      background = await BackgroundData.db.insertRow(
        session,
        BackgroundData(name: 'Stage 6 folk hero fixture', coins: 10),
      );
      clothes = await _ensureItemData(
        session,
        referenceKey: 'common_clothes',
        name: 'Common clothes fixture',
      );
      tool = await _ensureToolData(
        session,
        referenceKey: 'smith_tools',
        name: 'Smith tools fixture',
        category: ToolCategory.artisan,
      );
      fixedLine = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceBackgroundId: background.id,
          kind: StartingEquipmentEntryKind.fixedLine,
          orderIndex: 0,
          lineKind: StartingEquipmentLineKind.catalogRef,
          catalogType: EquipmentCatalogType.item,
          referenceKey: clothes.referenceKey,
          quantity: 1,
        ),
      );
      group = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceBackgroundId: background.id,
          kind: StartingEquipmentEntryKind.choiceGroup,
          orderIndex: 1,
          selectionCount: 1,
          referenceKey: 'folk_hero_artisan_tool',
        ),
      );
      option = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceBackgroundId: background.id,
          parentEntryId: group.id,
          kind: StartingEquipmentEntryKind.choiceOption,
          orderIndex: 0,
          referenceKey: 'artisan',
        ),
      );
      categoryLine = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceBackgroundId: background.id,
          parentEntryId: option.id,
          kind: StartingEquipmentEntryKind.optionLine,
          orderIndex: 0,
          lineKind: StartingEquipmentLineKind.itemCategory,
          catalogType: EquipmentCatalogType.tool,
          allowedItemCategories: [ToolCategory.artisan.name],
          quantity: 1,
        ),
      );
    } finally {
      await session.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(418),
      CharacterData(
        name: 'Stage 6 background equipment fixture',
        background: background,
        startingEquipmentSelections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.background,
            sourceId: background.id,
            sourceEntryId: group.id,
            choiceOptionEntryId: option.id,
            isSelected: true,
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                sourceLineEntryId: categoryLine.id,
                catalogType: EquipmentCatalogType.tool,
                referenceKey: tool.referenceKey,
              ),
            ],
          ),
        ],
      ),
    );

    expect(saved.background?.coins, 10);
    expect(
      saved.derived!.grantedEquipment
          ?.map((entry) => (entry.catalogType, entry.referenceKey))
          .toSet(),
      {
        (EquipmentCatalogType.item, clothes.referenceKey),
        (EquipmentCatalogType.tool, tool.referenceKey),
      },
    );
    expect(
        saved.derived!.grantedEquipment!.every((entry) => entry.quantity == 1),
        isTrue);
    expect(fixedLine.referenceKey, 'common_clothes');
  });

  test('bard starting instrument resolves from ToolData by category', () async {
    final session = sessionBuilder.build();
    late ClassData bard;
    late ToolData lute;
    late StartingEquipmentEntryData group;
    late StartingEquipmentEntryData option;
    late StartingEquipmentEntryData line;
    try {
      bard = await ClassData.db.insertRow(
        session,
        ClassData(name: 'Starting Equipment Bard Tool Fixture'),
      );
      lute = await _ensureToolData(
        session,
        referenceKey: 'lute',
        name: 'Lute Tool Fixture',
        category: ToolCategory.musicalInstrument,
      );
      group = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceClassId: bard.id,
          kind: StartingEquipmentEntryKind.choiceGroup,
          selectionCount: 1,
        ),
      );
      option = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceClassId: bard.id,
          parentEntryId: group.id,
          kind: StartingEquipmentEntryKind.choiceOption,
        ),
      );
      line = await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceClassId: bard.id,
          parentEntryId: option.id,
          kind: StartingEquipmentEntryKind.optionLine,
          lineKind: StartingEquipmentLineKind.itemCategory,
          catalogType: EquipmentCatalogType.tool,
          allowedItemCategories: [ToolCategory.musicalInstrument.name],
        ),
      );
    } finally {
      await session.close();
    }

    final classEntry = CharacterClassEntryData(
      id: 'bard-tool-equipment-entry',
      classData: bard,
      level: 1,
      isStartingClass: true,
      classOrder: 0,
    );
    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(416),
      CharacterData(
        name: 'Bard instrument choice',
        classEntries: [classEntry],
        startingEquipmentSelections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.classData,
            sourceId: bard.id,
            sourceEntryId: group.id,
            choiceOptionEntryId: option.id,
            isSelected: true,
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                sourceLineEntryId: line.id,
                catalogType: EquipmentCatalogType.tool,
                referenceKey: lute.referenceKey,
              ),
            ],
          ),
        ],
      ),
    );

    final selected = saved.derived!.grantedEquipment!.single;
    expect(selected.catalogType, EquipmentCatalogType.tool);
    expect(selected.referenceKey, lute.referenceKey);
    expect(selected.displayText, lute.name);
  });

  test('thieves tools starting grant resolves through ToolData', () async {
    final session = sessionBuilder.build();
    late ClassData rogue;
    late ToolData thievesTools;
    try {
      rogue = await ClassData.db.insertRow(
        session,
        ClassData(name: 'Starting Equipment Rogue Tool Fixture'),
      );
      thievesTools = await _ensureToolData(
        session,
        referenceKey: 'thieves_tools',
        name: 'Thieves’ Tools Fixture',
        category: ToolCategory.artisan,
      );
      await StartingEquipmentEntryData.db.insertRow(
        session,
        StartingEquipmentEntryData(
          sourceClassId: rogue.id,
          kind: StartingEquipmentEntryKind.fixedLine,
          lineKind: StartingEquipmentLineKind.catalogRef,
          catalogType: EquipmentCatalogType.tool,
          referenceKey: thievesTools.referenceKey,
        ),
      );
    } finally {
      await session.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(417),
      CharacterData(
        name: 'Rogue thieves tools grant',
        classEntries: [
          CharacterClassEntryData(
            id: 'rogue-tool-equipment-entry',
            classData: rogue,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    final selected = saved.derived!.grantedEquipment!.single;
    expect(selected.catalogType, EquipmentCatalogType.tool);
    expect(selected.referenceKey, thievesTools.referenceKey);
    expect(selected.displayText, thievesTools.name);
  });

  test(
      'racial ability choices stack with fixed race ability bonuses in racial mode',
      () async {
    final ownerSession = authenticatedSession(314);
    final fixture = await _seedMixedAbilityBonusRace(
      sessionBuilder,
      endpoints,
    );

    final saved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Mixed racial bonuses',
        race: fixture.race,
        baseAbilityScores: const {
          'strength': 10,
          'dexterity': 10,
          'constitution': 10,
          'intelligence': 10,
          'wisdom': 10,
          'charisma': 10,
        },
        useFlexibleAbilityBonuses: false,
        choices: [
          CharacterChoiceData(
            groupKey: fixture.anyBonusGroupKey,
            optionKey: Ability.dexterity.name,
          ),
        ],
      ),
    );

    final scores = saved.derived!.abilityScores!;
    expect(scores[Ability.charisma], 12);
    expect(scores[Ability.dexterity], 11);
  });

  test('flexible ability bonus mode replaces fixed race ability bonuses',
      () async {
    final ownerSession = authenticatedSession(315);
    final fixture = await _seedMixedAbilityBonusRace(
      sessionBuilder,
      endpoints,
    );

    final saved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Flexible mixed racial bonuses',
        race: fixture.race,
        baseAbilityScores: const {
          'strength': 10,
          'dexterity': 10,
          'constitution': 10,
          'intelligence': 10,
          'wisdom': 10,
          'charisma': 10,
        },
        useFlexibleAbilityBonuses: true,
        choices: [
          CharacterChoiceData(
            groupKey: 'race_bonus_mode',
            optionKey: 'flexible_plus_two_one',
          ),
          CharacterChoiceData(
            groupKey: 'race_flexible_bonus_plus2',
            optionKey: Ability.strength.name,
          ),
          CharacterChoiceData(
            groupKey: 'race_flexible_bonus_plus1',
            optionKey: Ability.dexterity.name,
          ),
          CharacterChoiceData(
            groupKey: fixture.anyBonusGroupKey,
            optionKey: Ability.wisdom.name,
          ),
        ],
      ),
    );

    final scores = saved.derived!.abilityScores!;
    expect(scores[Ability.charisma], 10);
    expect(scores[Ability.strength], 12);
    expect(scores[Ability.dexterity], 11);
    expect(scores[Ability.wisdom], 11);
  });

  test('generic class choice resolves its typed tool grant', () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    final entry = CharacterClassEntryData(
      id: 'generic-choice-class-entry',
      classData: fixture.classData,
      level: 1,
      classOrder: 0,
      isStartingClass: true,
    );
    final session = sessionBuilder.build();
    late ChoiceGroupData group;
    try {
      await _ensureToolData(
        session,
        referenceKey: 'thieves_tools',
        name: 'Thieves’ tools',
        category: ToolCategory.artisan,
      );
      group = await ChoiceGroupData.db.insertRow(
        session,
        ChoiceGroupData(
          referenceKey: 'test_class_tool_choice',
          name: 'Tool choice',
          sourceClassId: fixture.classData.id,
          level: 1,
          selectionCount: 1,
        ),
      );
      await ChoiceOptionData.db.insertRow(
        session,
        ChoiceOptionData(
          choiceGroupId: group.id!,
          optionKey: 'thieves_tools',
          name: 'Thieves’ tools',
          grantedToolKeys: const ['thieves_tools'],
        ),
      );
    } finally {
      await session.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(412),
      CharacterData(
        name: 'Generic class choice',
        classEntries: [entry],
        choices: [
          CharacterChoiceData(
            classEntry: entry,
            groupKey: 'test_class_tool_choice',
            optionKey: 'thieves_tools',
            selectionIndex: 0,
          ),
        ],
      ),
    );

    expect(saved.derived!.toolProficiencyKeys, ['thieves_tools']);
  });

  test('racial granted spell uses canonical SpellData referenceKey', () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    await endpoints.raceFeatureSpellGrantData.upsert(
      sessionBuilder,
      RaceFeatureSpellGrantData(
        featureId: fixture.raceFeature.id!,
        spellId: fixture.lightSpell.id!,
        grantedAtLevel: 1,
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(413),
      CharacterData(
        name: 'Canonical racial spell grant',
        race: fixture.race,
      ),
    );

    expect(
      saved.derived?.grantedSpellKeys,
      contains(fixture.lightSpell.referenceKey),
    );
    expect(
      saved.derived?.grantedSpellKeys,
      isNot(contains(fixture.lightSpell.name)),
    );
  });

  test('background choice effects include armor training and resistance',
      () async {
    final background = await endpoints.backgroundData.upsert(
      sessionBuilder,
      BackgroundData(name: 'Derived parity background choice'),
    );
    final session = sessionBuilder.build();
    late ChoiceGroupData group;
    try {
      await _ensureToolData(
        session,
        referenceKey: 'smith_tools',
        name: 'Smith tools',
      );
      group = await ChoiceGroupData.db.insertRow(
        session,
        ChoiceGroupData(
          referenceKey: 'derived_parity_background_choice',
          sourceBackgroundId: background.id,
          type: ChoiceType.custom,
          selectionCount: 1,
        ),
      );
      await ChoiceOptionData.db.insertRow(
        session,
        ChoiceOptionData(
          choiceGroupId: group.id!,
          optionKey: 'fire_guard',
          grantedArmorTraining: const [ArmorCategory.light],
          grantedToolKeys: const ['smith_tools'],
          damageType: DamageType.fire,
        ),
      );
    } finally {
      await session.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(414),
      CharacterData(
        name: 'Background choice derived parity',
        background: background,
        choices: [
          CharacterChoiceData(
            groupKey: 'derived_parity_background_choice',
            optionKey: 'fire_guard',
          ),
        ],
      ),
    );

    expect(
      {
        'armorTraining':
            saved.derived!.armorTraining!.map((value) => value.name).toList(),
        'resistances':
            saved.derived!.resistances!.map((value) => value.name).toList(),
        'toolProficiencyKeys': saved.derived!.toolProficiencyKeys,
      },
      backgroundChoiceDerivedParityContract,
    );
  });

  test('active feature resource effects match the derived resource contract',
      () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    final resourceFeature = await endpoints.classFeatureData.upsert(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: fixture.classData.id!,
        name: 'Parity resource feature',
        level: 1,
      ),
    );
    final resourceSession = sessionBuilder.build();
    try {
      await FeatureResourceDefinitionData.db.insertRow(
        resourceSession,
        FeatureResourceDefinitionData(
          classFeatureId: resourceFeature.id,
          key: 'uses',
          kind: FeatureResourceKind.uses,
          maxRule: FeatureResourceMaxRule.fixed,
          maxValue: 1,
        ),
      );
      await FeatureResourceEffectData.db.insertRow(
        resourceSession,
        FeatureResourceEffectData(
          classFeatureId: resourceFeature.id,
          type: FeatureResourceEffectType.modify,
          targetResourceKey: 'uses',
          addMaxValue: 2,
        ),
      );
    } finally {
      await resourceSession.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(415),
      CharacterData(
        name: 'Derived resource effect parity',
        classEntries: [
          CharacterClassEntryData(
            classData: fixture.classData,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    final feature = saved.derived!.activeFeatures!.singleWhere(
      (value) => value.sourceId == resourceFeature.id,
    );
    final resource = feature.resources!.single;
    expect((resource.key, resource.max, resource.current), ('uses', 3, 1));
  });

  test('feature override equal to defaults is not customized', () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(416),
      CharacterData(
        name: 'Unchanged feature override',
        classEntries: [
          CharacterClassEntryData(
            classData: fixture.classData,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        featureOverrides: [
          CharacterFeatureOverrideData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: fixture.classFeature.id!,
            name: fixture.classFeature.name,
            description: fixture.classFeature.shortDescription ??
                fixture.classFeature.description,
            tags: fixture.classFeature.tags,
          ),
        ],
      ),
    );

    final feature = saved.derived!.activeFeatures!.singleWhere(
      (value) => value.sourceId == fixture.classFeature.id,
    );
    expect(feature.isCustomized, isFalse);
  });

  test('generic racial choice applies its typed ability bonus', () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    final session = sessionBuilder.build();
    try {
      final group = await ChoiceGroupData.db.insertRow(
        session,
        ChoiceGroupData(
          referenceKey: 'test_race_dexterity_choice',
          sourceRaceId: fixture.race.id,
          type: ChoiceType.abilityIncrease,
          selectionCount: 1,
        ),
      );
      await ChoiceOptionData.db.insertRow(
        session,
        ChoiceOptionData(
          choiceGroupId: group.id!,
          optionKey: 'dexterity_plus_one',
          name: 'Dexterity +1',
          grantedAbilityBonuses: const {'dexterity': 1},
        ),
      );
    } finally {
      await session.close();
    }

    final saved = await endpoints.characterData.saveCharacter(
      authenticatedSession(413),
      CharacterData(
        name: 'Generic racial ability choice',
        race: fixture.race,
        baseAbilityScores: const {'dexterity': 10},
        choices: [
          CharacterChoiceData(
            groupKey: 'test_race_dexterity_choice',
            optionKey: 'dexterity_plus_one',
            selectionIndex: 0,
          ),
        ],
      ),
    );

      expect(saved.derived!.abilityScores![Ability.dexterity], 11);
  });

  test('generic choices reject grants for unknown tool reference keys',
      () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    final session = sessionBuilder.build();
    late ChoiceGroupData group;
    try {
      group = await ChoiceGroupData.db.insertRow(
        session,
        ChoiceGroupData(
          referenceKey: 'test_unknown_tool_grant',
          sourceClassId: fixture.classData.id,
          selectionCount: 1,
        ),
      );
      await ChoiceOptionData.db.insertRow(
        session,
        ChoiceOptionData(
          choiceGroupId: group.id!,
          optionKey: 'unknown_tool',
          grantedToolKeys: const ['not_a_tool_reference'],
        ),
      );
    } finally {
      await session.close();
    }

    await expectLater(
      endpoints.characterData.saveCharacter(
        authenticatedSession(414),
        CharacterData(
          name: 'Unknown generic tool grant',
          classEntries: [
            CharacterClassEntryData(
              id: 'unknown-tool-entry',
              classData: fixture.classData,
              level: 1,
              isStartingClass: true,
            ),
          ],
          choices: [
            CharacterChoiceData(
              groupKey: 'test_unknown_tool_grant',
              optionKey: 'unknown_tool',
            ),
          ],
        ),
      ),
      throwsA(isA<InputValidationException>()),
    );
  });

  test(
      'class step view includes subclass features and subclass feature choice groups when subclass is selected',
      () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);

    final stepView = await endpoints.classData.getStepView(
      sessionBuilder,
      fixture.classData.id!,
      selectedLevel: 1,
      isStartingClass: true,
      selectedSubclassId: fixture.subclass.id,
    );

    expect(
      stepView.currentSubclassFeatures?.map((feature) => feature.id),
      contains(fixture.subclassFeature.id),
    );
    expect(
      stepView.choiceGroups
          ?.map((groupView) => groupView.group?.exclusiveKey)
          .whereType<String>()
          .toSet(),
      containsAll({
        'subclass_tool_pick',
      }),
    );
    final classSkillGroup = stepView.skillSelectionGroups!.singleWhere(
      (group) => group.kind == CharacterSkillSelectionKind.classSkill,
    );
    expect(classSkillGroup.selectionCount, 2);
    expect(
      classSkillGroup.options,
      containsAll([
        Skill.acrobatics,
        Skill.athletics,
        Skill.perception,
      ]),
    );
    final cantripGroup = stepView.spellSelectionGroups!.singleWhere(
      (group) => group.kind == CharacterSpellSelectionKind.knownCantrip,
    );
    expect(cantripGroup.selectionCount, 1);
    expect(
      cantripGroup.options?.map((spell) => spell.referenceKey),
      contains('light'),
    );
    final spellGroup = stepView.spellSelectionGroups!.singleWhere(
      (group) => group.kind == CharacterSpellSelectionKind.knownSpell,
    );
    expect(spellGroup.selectionCount, 1);
    expect(
      spellGroup.options?.map((spell) => spell.referenceKey),
      contains('magic_missile'),
    );
    expect(
      spellGroup.options?.map((spell) => spell.referenceKey),
      isNot(contains('shield')),
    );
    expect(
      stepView.startingEquipmentBlocks
          ?.map((blockView) => blockView.block?.entryId)
          .whereType<int>()
          .toSet(),
      containsAll({
        fixture.equipment.classFixedPack.id,
        fixture.equipment.classWeaponPick.id,
        fixture.equipment.classFocusPick.id,
      }),
    );
    final classWeaponBlock = stepView.startingEquipmentBlocks!.singleWhere(
      (blockView) =>
          blockView.block?.entryId == fixture.equipment.classWeaponPick.id,
    );
    final simpleWeaponOption = classWeaponBlock.options!.singleWhere(
      (optionView) =>
          optionView.option?.entryId ==
          fixture.equipment.classSimpleWeaponOption.id,
    );
    expect(
      simpleWeaponOption.lines?.single.kind,
      StartingEquipmentLineKind.weaponCategory,
    );
  });

  test('class feature upsert stores nested spell grants by spell reference key',
      () async {
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Grant Authoring Class',
        hitDieValue: 8,
      ),
    );
    final spell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'grant_authoring_bless',
        name: 'Grant Authoring Bless',
        level: 1,
        schoolValue: SpellSchool.enchantment,
      ),
    );

    final feature = await endpoints.classFeatureData.upsert(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: classData.id!,
        name: 'Prepared Feature Spells',
        level: 2,
        spellGrants: [
          ClassSpellGrantData(
            spellReferenceKey: 'grant_authoring_bless',
            grantedAtLevel: 2,
            alwaysPrepared: true,
            notes: 'Feature spell.',
          ),
        ],
      ),
    );

    expect(feature.spellGrants, hasLength(1));
    expect(feature.spellGrants?.single.spellId, spell.id);
    expect(feature.spellGrants?.single.spell?.referenceKey,
        'grant_authoring_bless');

    final allGrants = await endpoints.classSpellGrantData.getAll(
      sessionBuilder,
    );
    final storedGrant = allGrants.singleWhere(
      (grant) => grant.sourceFeatureId == feature.id,
    );
    expect(storedGrant.spellId, spell.id);
    expect(storedGrant.alwaysPrepared, isTrue);
  });

  test(
      'class step view includes class and subclass feature spell grants with nested spells',
      () async {
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Grant View Class',
        hitDieValue: 8,
        subclassChoiceLevel: 1,
      ),
    );
    final subclass = await endpoints.subclassData.upsert(
      sessionBuilder,
      SubclassData(
        parentClassId: classData.id!,
        name: 'Grant View Subclass',
        levelRequired: 1,
      ),
    );
    final classFeature = await endpoints.classFeatureData.upsert(
      sessionBuilder,
      ClassFeatureData(
        parentClassId: classData.id!,
        name: 'Class Grant Feature',
        level: 2,
      ),
    );
    final subclassFeature = await endpoints.subclassFeatureData.upsert(
      sessionBuilder,
      SubclassFeatureData(
        parentSubclassId: subclass.id!,
        name: 'Subclass Grant Feature',
        level: 3,
      ),
    );
    final bless = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'grant_view_bless',
        name: 'Grant View Bless',
        level: 1,
        schoolValue: SpellSchool.enchantment,
      ),
    );
    final shield = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'grant_view_shield',
        name: 'Grant View Shield',
        level: 1,
        schoolValue: SpellSchool.abjuration,
      ),
    );

    await endpoints.classSpellGrantData.upsert(
      sessionBuilder,
      ClassSpellGrantData(
        sourceFeatureId: classFeature.id!,
        spellReferenceKey: 'grant_view_bless',
        grantedAtLevel: 2,
        alwaysPrepared: true,
      ),
    );
    await endpoints.classSpellGrantData.upsert(
      sessionBuilder,
      ClassSpellGrantData(
        sourceSubclassFeatureId: subclassFeature.id!,
        spellId: shield.id!,
        grantedAtLevel: 3,
        alwaysPrepared: true,
      ),
    );

    final stepView = await endpoints.classData.getStepView(
      sessionBuilder,
      classData.id!,
      selectedLevel: 3,
      isStartingClass: true,
      selectedSubclassId: subclass.id,
    );

    final nestedClassFeature = stepView.currentLevelFeatures!.singleWhere(
      (feature) => feature.id == classFeature.id,
    );
    expect(nestedClassFeature.spellGrants, hasLength(1));
    expect(nestedClassFeature.spellGrants?.single.spellId, bless.id);
    expect(nestedClassFeature.spellGrants?.single.spell?.referenceKey,
        'grant_view_bless');

    final nestedSubclassFeature = stepView.currentSubclassFeatures!.singleWhere(
      (feature) => feature.id == subclassFeature.id,
    );
    expect(nestedSubclassFeature.spellGrants, hasLength(1));
    expect(nestedSubclassFeature.spellGrants?.single.spell?.referenceKey,
        'grant_view_shield');
  });

  test(
      'derived data includes active always prepared class spell grants without saving them as selections',
      () async {
    final ownerSession = authenticatedSession(405);
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Fixture Cleric',
        hitDieValue: 8,
        subclassChoiceLevel: 1,
      ),
    );
    final firstSubclass = await endpoints.subclassData.upsert(
      sessionBuilder,
      SubclassData(
        parentClassId: classData.id!,
        name: 'Fixture Life Domain',
        levelRequired: 1,
      ),
    );
    final secondSubclass = await endpoints.subclassData.upsert(
      sessionBuilder,
      SubclassData(
        parentClassId: classData.id!,
        name: 'Fixture War Domain',
        levelRequired: 1,
      ),
    );
    final domainFeature = await endpoints.subclassFeatureData.upsert(
      sessionBuilder,
      SubclassFeatureData(
        parentSubclassId: firstSubclass.id!,
        name: 'Domain Spells',
        level: 3,
        tags: const [FeatureTag.spellcasting],
      ),
    );
    final otherDomainFeature = await endpoints.subclassFeatureData.upsert(
      sessionBuilder,
      SubclassFeatureData(
        parentSubclassId: secondSubclass.id!,
        name: 'Other Domain Spells',
        level: 3,
        tags: const [FeatureTag.spellcasting],
      ),
    );
    final lesserRestoration = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'lesser_restoration',
        name: 'Lesser Restoration',
        level: 2,
        schoolValue: SpellSchool.abjuration,
      ),
    );
    final spiritualWeapon = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'spiritual_weapon',
        name: 'Spiritual Weapon',
        level: 2,
        schoolValue: SpellSchool.evocation,
      ),
    );

    final session = sessionBuilder.build();
    try {
      await ClassSpellGrantData.db.insertRow(
        session,
        ClassSpellGrantData(
          spellId: lesserRestoration.id!,
          sourceSubclassFeatureId: domainFeature.id!,
          grantedAtLevel: 3,
          alwaysPrepared: true,
        ),
      );
      await ClassSpellGrantData.db.insertRow(
        session,
        ClassSpellGrantData(
          spellId: spiritualWeapon.id!,
          sourceSubclassFeatureId: otherDomainFeature.id!,
          grantedAtLevel: 3,
          alwaysPrepared: true,
        ),
      );
      await ClassSpellGrantData.db.insertRow(
        session,
        ClassSpellGrantData(
          spellId: spiritualWeapon.id!,
          sourceClassId: classData.id!,
          grantedAtLevel: 1,
          alwaysPrepared: false,
        ),
      );
    } finally {
      await session.close();
    }

    Future<CharacterData> saveAndLoad(SubclassData subclass, int level) async {
      final classEntry = CharacterClassEntryData(
        classData: classData,
        subclass: subclass,
        level: level,
        isStartingClass: true,
        classOrder: 0,
        hpMode: HitPointMode.fixed,
      );
      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Prepared Spell Fixture',
          classEntries: [classEntry],
          spellSelections: const [],
        ),
      );
      return endpoints.characterData.getCharacter(ownerSession, saved.id!);
    }

    final beforeRequiredLevel = await saveAndLoad(firstSubclass, 2);
    expect(
      beforeRequiredLevel.derived?.alwaysPreparedSpellKeys,
      isNot(contains('lesser_restoration')),
    );

    final matchingSubclass = await saveAndLoad(firstSubclass, 3);
    expect(
      matchingSubclass.derived?.alwaysPreparedSpellKeys,
      contains('lesser_restoration'),
    );
    expect(
      matchingSubclass.derived?.grantedSpellKeys,
      contains('lesser_restoration'),
    );
    expect(
      matchingSubclass.derived?.alwaysPreparedSpellKeys,
      isNot(contains('spiritual_weapon')),
    );
    expect(matchingSubclass.spellSelections, isEmpty);

    final changedSubclass = await saveAndLoad(secondSubclass, 3);
    expect(
      changedSubclass.derived?.alwaysPreparedSpellKeys,
      isNot(contains('lesser_restoration')),
    );
    expect(
      changedSubclass.derived?.alwaysPreparedSpellKeys,
      contains('spiritual_weapon'),
    );
  });
}
