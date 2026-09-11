part of '../character_data_endpoint_test.dart';

void _registerCharacterDataSpellSlotScenarios(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
  TestSessionBuilder Function(int userId) authenticatedSession,
  Future<void> Function() seedCoreSpellSlotTables,
) {
  test('derived spell slots use standard progression for full casters',
      () async {
    await seedCoreSpellSlotTables();
    final ownerSession = authenticatedSession(406);
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Full Caster',
        hitDieValue: 6,
        spellcastingProgression: SpellcastingProgression.full,
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Full Slot Fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: classData,
            level: 5,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    expect(saved.derived?.spellSlots, const {1: 4, 2: 3, 3: 2});
    expect(saved.derived?.pactSlots, isNull);
  });

  test('derived spell slots round single half and third casters by class',
      () async {
    await seedCoreSpellSlotTables();
    final ownerSession = authenticatedSession(407);
    final halfCaster = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Half Caster',
        hitDieValue: 10,
        spellcastingProgression: SpellcastingProgression.half,
      ),
    );
    final thirdCaster = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Third Caster',
        hitDieValue: 8,
        spellcastingProgression: SpellcastingProgression.third,
      ),
    );

    final halfSaved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Half Slot Fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: halfCaster,
            level: 5,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );
    final thirdSaved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Third Slot Fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: thirdCaster,
            level: 7,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    expect(halfSaved.derived?.spellSlots, const {1: 4, 2: 2});
    expect(thirdSaved.derived?.spellSlots, const {1: 4, 2: 2});
  });

  test('derived spell slots sum multiclass standard caster levels', () async {
    await seedCoreSpellSlotTables();
    final ownerSession = authenticatedSession(408);
    final fullCaster = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Wizard',
        hitDieValue: 6,
        spellcastingProgression: SpellcastingProgression.full,
      ),
    );
    final halfCaster = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Paladin',
        hitDieValue: 10,
        spellcastingProgression: SpellcastingProgression.half,
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Multiclass Slot Fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: fullCaster,
            level: 3,
            isStartingClass: true,
            classOrder: 0,
          ),
          CharacterClassEntryData(
            classData: halfCaster,
            level: 4,
            isStartingClass: false,
            classOrder: 1,
          ),
        ],
      ),
    );

    expect(saved.derived?.spellSlots, const {1: 4, 2: 3, 3: 2});
  });

  test('derived pact magic slots stay separate from standard slots', () async {
    await seedCoreSpellSlotTables();
    final ownerSession = authenticatedSession(409);
    final pactCaster = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Warlock',
        hitDieValue: 8,
        spellcastingProgression: SpellcastingProgression.pactMagic,
      ),
    );

    final saved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        name: 'Pact Slot Fixture',
        classEntries: [
          CharacterClassEntryData(
            classData: pactCaster,
            level: 5,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
      ),
    );

    expect(saved.derived?.spellSlots, isNull);
    expect(saved.derived?.pactSlots, const {3: 2});
  });

  test('class step known spell max level uses slot progression table',
      () async {
    await seedCoreSpellSlotTables();
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Slot Step Wizard',
        hitDieValue: 6,
        spellcastingProgression: SpellcastingProgression.full,
      ),
    );
    await endpoints.classLevelData.upsert(
      sessionBuilder,
      ClassLevelData(
        classDataId: classData.id!,
        level: 3,
        knownSpells: 2,
      ),
    );
    final firstLevelSpell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'slot_step_magic_missile',
        name: 'Slot Step Magic Missile',
        level: 1,
        schoolValue: SpellSchool.evocation,
      ),
    );
    final secondLevelSpell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'slot_step_misty_step',
        name: 'Slot Step Misty Step',
        level: 2,
        schoolValue: SpellSchool.conjuration,
      ),
    );
    final thirdLevelSpell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'slot_step_fireball',
        name: 'Slot Step Fireball',
        level: 3,
        schoolValue: SpellSchool.evocation,
      ),
    );
    final session = sessionBuilder.build();
    try {
      for (final spell in [
        firstLevelSpell,
        secondLevelSpell,
        thirdLevelSpell,
      ]) {
        await SpellData.db.updateRow(
          session,
          spell.copyWith(availableForClassIds: [classData.id!]),
        );
      }
    } finally {
      await session.close();
    }

    final stepView = await endpoints.classData.getStepView(
      sessionBuilder,
      classData.id!,
      selectedLevel: 3,
      isStartingClass: true,
    );
    final knownSpellGroup = stepView.spellSelectionGroups!.singleWhere(
      (group) => group.kind == CharacterSpellSelectionKind.knownSpell,
    );

    expect(
      knownSpellGroup.options?.map((spell) => spell.referenceKey),
      containsAll(['slot_step_magic_missile', 'slot_step_misty_step']),
    );
    expect(
      knownSpellGroup.options?.map((spell) => spell.referenceKey),
      isNot(contains('slot_step_fireball')),
    );
  });

  test('class step prepared spells use server-side ability score formula',
      () async {
    await seedCoreSpellSlotTables();
    final classData = await endpoints.classData.upsert(
      sessionBuilder,
      ClassData(
        name: 'Prepared Step Cleric',
        hitDieValue: 8,
        spellcastingProgression: SpellcastingProgression.full,
      ),
    );
    await endpoints.classLevelData.upsert(
      sessionBuilder,
      ClassLevelData(
        classDataId: classData.id!,
        level: 3,
        preparedSpellFormula: 'wisdom modifier + cleric level',
      ),
    );
    final firstLevelSpell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'prepared_step_bless',
        name: 'Prepared Step Bless',
        level: 1,
        schoolValue: SpellSchool.enchantment,
      ),
    );
    final secondLevelSpell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'prepared_step_lesser_restoration',
        name: 'Prepared Step Lesser Restoration',
        level: 2,
        schoolValue: SpellSchool.abjuration,
      ),
    );
    final thirdLevelSpell = await endpoints.spellData.add(
      sessionBuilder,
      SpellData(
        referenceKey: 'prepared_step_spirit_guardians',
        name: 'Prepared Step Spirit Guardians',
        level: 3,
        schoolValue: SpellSchool.conjuration,
      ),
    );
    final session = sessionBuilder.build();
    try {
      for (final spell in [
        firstLevelSpell,
        secondLevelSpell,
        thirdLevelSpell,
      ]) {
        await SpellData.db.updateRow(
          session,
          spell.copyWith(availableForClassIds: [classData.id!]),
        );
      }
    } finally {
      await session.close();
    }

    final withoutScores = await endpoints.classData.getStepView(
      sessionBuilder,
      classData.id!,
      selectedLevel: 3,
      isStartingClass: true,
    );
    expect(
      (withoutScores.spellSelectionGroups ?? const []).where(
        (group) => group.kind == CharacterSpellSelectionKind.preparedSpell,
      ),
      isEmpty,
    );

    final stepView = await endpoints.classData.getStepView(
      sessionBuilder,
      classData.id!,
      selectedLevel: 3,
      isStartingClass: true,
      abilityScores: const {'wisdom': 16},
    );
    final preparedGroup = stepView.spellSelectionGroups!.singleWhere(
      (group) => group.kind == CharacterSpellSelectionKind.preparedSpell,
    );

    expect(preparedGroup.selectionCount, 6);
    expect(
      preparedGroup.options?.map((spell) => spell.referenceKey),
      containsAll([
        'prepared_step_bless',
        'prepared_step_lesser_restoration',
      ]),
    );
    expect(
      preparedGroup.options?.map((spell) => spell.referenceKey),
      isNot(contains('prepared_step_spirit_guardians')),
    );
  });

  test('feature override reset returns canonical feature text', () async {
    final ownerSession = authenticatedSession(404);
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
    final primaryEntry = CharacterClassEntryData(
      classData: fixture.classData,
      subclass: fixture.subclass,
      level: 1,
      isStartingClass: true,
      classOrder: 0,
    );

    final saved = await endpoints.characterData.saveCharacter(
      ownerSession,
      CharacterData(
        race: fixture.race,
        subrace: fixture.subrace,
        classEntries: [primaryEntry],
        featureOverrides: [
          CharacterFeatureOverrideData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: fixture.classFeature.id!,
            name: 'Temporary Override',
            tags: const [FeatureTag.utility],
          ),
        ],
      ),
    );

    final reset = await endpoints.characterData.saveCharacter(
      ownerSession,
      saved.copyWith(
        featureOverrides: const <CharacterFeatureOverrideData>[],
      ),
    );

    expect(reset.featureOverrides, isEmpty);
    final classFeatureView = reset.derived!.activeFeatures!.singleWhere(
      (feature) =>
          feature.sourceType == CharacterFeatureSourceType.classFeature &&
          feature.sourceId == fixture.classFeature.id,
    );
    expect(classFeatureView.name, 'Fighting Style');
    expect(classFeatureView.tags, [FeatureTag.combat]);
    expect(classFeatureView.isCustomized, isFalse);
  });

  test('background step view exposes variable background choices', () async {
    final fixture = await _seedCreationFixture(sessionBuilder, endpoints);

    final stepView = await endpoints.backgroundData.getStepView(
      sessionBuilder,
      fixture.background.id!,
    );

    expect(stepView.background?.id, fixture.background.id);
    expect(
      stepView.choiceGroups
          ?.map((groupView) => groupView.group?.exclusiveKey)
          .whereType<String>()
          .toSet(),
      contains('background_language_pick'),
    );
    final backgroundSkillGroup = stepView.skillSelectionGroups!.singleWhere(
      (group) => group.kind == CharacterSkillSelectionKind.backgroundSkill,
    );
    expect(backgroundSkillGroup.selectionCount, 1);
    expect(
      backgroundSkillGroup.options,
      containsAll([Skill.survival, Skill.history]),
    );
    expect(
      stepView.startingEquipmentBlocks
          ?.map((blockView) => blockView.block?.entryId)
          .whereType<int>()
          .toSet(),
      contains(fixture.equipment.backgroundItemPick.id),
    );
  });
}
