part of '../character_data_endpoint_test.dart';

void _registerCharacterDataEndpointTests() {
  withServerpod('CharacterDataEndpoint', (sessionBuilder, endpoints) {
    TestSessionBuilder authenticatedSession(int userId) {
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          userId,
          <Scope>{},
        ),
      );
    }

    Future<void> seedCoreSpellSlotTables() async {
      const standardRows = <int, Map<int, int>>{
        1: {1: 2},
        2: {1: 3},
        3: {1: 4, 2: 2},
        4: {1: 4, 2: 3},
        5: {1: 4, 2: 3, 3: 2},
      };
      for (final entry in standardRows.entries) {
        await endpoints.spellSlotProgressionData.upsert(
          sessionBuilder,
          SpellSlotProgressionData(
            tableKey: 'standard',
            level: entry.key,
            spellSlots: entry.value,
          ),
        );
      }
      await endpoints.spellSlotProgressionData.upsert(
        sessionBuilder,
        SpellSlotProgressionData(
          tableKey: 'pact_magic',
          level: 5,
          spellSlots: const {3: 2},
        ),
      );
    }

    test('saveCharacter assigns ownership to authenticated user', () async {
      final ownerSession = authenticatedSession(101);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Первый герой'),
      );

      expect(saved.id, isNotNull);

      final session = ownerSession.build();
      try {
        final records = await CharacterRecord.db.find(
          session,
          where: (t) => t.id.equals(saved.id),
          limit: 1,
        );

        expect(records, hasLength(1));
        expect(records.first.userId, 101);
      } finally {
        await session.close();
      }
    });

    test('getCharacter returns saved character for owner', () async {
      final ownerSession = authenticatedSession(101);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Второй герой'),
      );

      final loaded = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );

      expect(loaded.id, saved.id);
      expect(loaded.name, 'Второй герой');
    });

    test('getAll returns only characters owned by current user', () async {
      final firstUserSession = authenticatedSession(101);
      final secondUserSession = authenticatedSession(202);

      await endpoints.characterData.saveCharacter(
        firstUserSession,
        CharacterData(name: 'Герой игрока 1'),
      );
      await endpoints.characterData.saveCharacter(
        secondUserSession,
        CharacterData(name: 'Герой игрока 2'),
      );

      final ownedCharacters =
          await endpoints.characterData.getAll(firstUserSession);

      expect(ownedCharacters, hasLength(1));
      expect(ownedCharacters.first.name, 'Герой игрока 1');
    });

    test('getCharacter rejects access for another authenticated user',
        () async {
      final ownerSession = authenticatedSession(101);
      final otherSession = authenticatedSession(202);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Чужой герой'),
      );

      await expectLater(
        () => endpoints.characterData.getCharacter(otherSession, saved.id!),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('Access denied'),
          ),
        ),
      );
    });

    test('delete removes owned character from subsequent getAll results',
        () async {
      final ownerSession = authenticatedSession(101);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Удаляемый герой'),
      );

      await endpoints.characterData.delete(ownerSession, saved.id!);

      final ownedCharacters =
          await endpoints.characterData.getAll(ownerSession);

      expect(ownedCharacters, isEmpty);
    });

    test('delete removes class-linked skill and spell selections', () async {
      final ownerSession = authenticatedSession(101);
      final classData = await endpoints.classData.upsert(
        sessionBuilder,
        ClassData(name: 'Delete Cascade Class'),
      );
      final primaryEntry = CharacterClassEntryData(
        classData: classData,
        level: 1,
        isStartingClass: true,
        classOrder: 0,
      );

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Delete Cascade Hero',
          classEntries: [primaryEntry],
          skillSelections: [
            CharacterSkillSelectionData(
              classEntry: primaryEntry,
              classDataId: classData.id,
              skill: Skill.arcana,
              kind: CharacterSkillSelectionKind.classSkill,
              selectionIndex: 0,
            ),
          ],
          spellSelections: [
            CharacterSpellSelectionData(
              classEntry: primaryEntry,
              classDataId: classData.id,
              spellKey: 'delete_cascade_spell',
              kind: CharacterSpellSelectionKind.knownCantrip,
              selectionIndex: 0,
            ),
          ],
        ),
      );

      var session = ownerSession.build();
      try {
        expect(
          await CharacterClassEntryRecord.db.find(
            session,
            where: (t) => t.characterId.equals(saved.id),
          ),
          hasLength(1),
        );
        expect(
          await CharacterSkillSelectionRecord.db.find(
            session,
            where: (t) => t.characterId.equals(saved.id),
          ),
          hasLength(1),
        );
        expect(
          await CharacterSpellSelectionRecord.db.find(
            session,
            where: (t) => t.characterId.equals(saved.id),
          ),
          hasLength(1),
        );
      } finally {
        await session.close();
      }

      await endpoints.characterData.delete(ownerSession, saved.id!);

      session = ownerSession.build();
      try {
        expect(
          await CharacterSkillSelectionRecord.db.find(
            session,
            where: (t) => t.characterId.equals(saved.id),
          ),
          isEmpty,
        );
        expect(
          await CharacterSpellSelectionRecord.db.find(
            session,
            where: (t) => t.characterId.equals(saved.id),
          ),
          isEmpty,
        );
        expect(
          await CharacterClassEntryRecord.db.find(
            session,
            where: (t) => t.characterId.equals(saved.id),
          ),
          isEmpty,
        );
        expect(
          await CharacterRecord.db.find(
            session,
            where: (t) => t.id.equals(saved.id),
          ),
          isEmpty,
        );
      } finally {
        await session.close();
      }
    });

    test('delete rejects access for another authenticated user', () async {
      final ownerSession = authenticatedSession(101);
      final otherSession = authenticatedSession(202);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(name: 'Чужой удаляемый герой'),
      );

      await expectLater(
        () => endpoints.characterData.delete(otherSession, saved.id!),
        throwsA(
          isA<Exception>().having(
            (error) => error.toString(),
            'message',
            contains('Access denied'),
          ),
        ),
      );

      final ownedCharacters =
          await endpoints.characterData.getAll(ownerSession);
      expect(ownedCharacters, hasLength(1));
      expect(ownedCharacters.first.id, saved.id);
    });

    test(
        'save/get preserves attack damage parts and syncs legacy damage fields',
        () async {
      final ownerSession = authenticatedSession(306);

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Multi Damage Fighter',
          attacks: [
            CharacterAttackData(
              name: 'Flame Strike',
              leadingAbility: Ability.charisma,
              damage: 'legacy',
              damageType: DamageType.force,
              damageParts: [
                DamagePartData(
                  formula: '4d6',
                  damageType: DamageType.fire,
                ),
                DamagePartData(
                  formula: '4d6',
                  damageType: DamageType.radiant,
                ),
              ],
            ),
          ],
        ),
      );

      final loaded = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );
      final attack = loaded.attacks!.single;

      expect(attack.damage, '4d6');
      expect(attack.damageType, DamageType.fire);
      expect(attack.damageParts, hasLength(2));
      expect(attack.damageParts?.first.formula, '4d6');
      expect(attack.damageParts?.first.damageType, DamageType.fire);
      expect(attack.damageParts?.last.damageType, DamageType.radiant);
    });

    test('spell data preserves multiple damage parts in order', () async {
      final saved = await endpoints.spellData.add(
        sessionBuilder,
        SpellData(
          referenceKey: 'multi_damage_spell',
          name: 'Multi Damage Spell',
          damageDice: 'legacy',
          damageType: DamageType.force,
          damageParts: [
            DamagePartData(
              formula: '4d6',
              damageType: DamageType.fire,
              scaling: SpellScalingData(
                mode: SpellScalingMode.slotLevel,
                scalingBySlotLevel: const {6: '5d6'},
              ),
            ),
            DamagePartData(
              formula: '4d6',
              damageType: DamageType.radiant,
            ),
          ],
        ),
      );

      final session = sessionBuilder.build();
      final loaded = await SpellData.db.findById(session, saved.id!);
      await session.close();

      expect(loaded?.damageDice, 'legacy');
      expect(loaded?.damageType, DamageType.force);
      expect(loaded?.damageParts, hasLength(2));
      expect(loaded?.damageParts?.first.damageType, DamageType.fire);
      expect(
        loaded?.damageParts?.first.scaling?.scalingBySlotLevel,
        const {6: '5d6'},
      );
      expect(loaded?.damageParts?.last.damageType, DamageType.radiant);
    });

    test(
        'save/get roundtrip preserves class and background choices and rebuilds derived data from canonical options',
        () async {
      final ownerSession = authenticatedSession(303);
      final fixture = await _seedCreationFixture(sessionBuilder, endpoints);

      final primaryEntry = CharacterClassEntryData(
        classData: fixture.classData,
        subclass: fixture.subclass,
        level: 1,
        isStartingClass: true,
        classOrder: 0,
        hpMode: HitPointMode.fixed,
      );

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Канонический герой',
          race: fixture.race,
          subrace: fixture.subrace.copyWith(
            features: [fixture.subraceFeature],
          ),
          background: fixture.background,
          attacks: [
            CharacterAttackData(
              name: 'Длинный меч',
              leadingAbility: Ability.strength,
              damage: '1d8',
              customAttackBonus: 1,
              damageType: DamageType.slashing,
              tags: const ['versatile', 'martial'],
              description: 'Основная атака оружием.',
            ),
          ],
          customSpellSaveDcBonus: 1,
          customSpellAttackBonus: -1,
          preparedSpellKeys: const ['light'],
          customInitiativeBonus: 2,
          customArmorClassBonus: 1,
          walkingSpeed: 30,
          swimmingSpeed: 15,
          climbingSpeed: 15,
          flyingSpeed: 60,
          displayedSpeedKind: CharacterSpeedKind.flying,
          featureOverrides: [
            CharacterFeatureOverrideData(
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: fixture.classFeature.id!,
              name: 'Custom Fighting Style',
              description: 'Custom class text.',
            ),
            CharacterFeatureOverrideData(
              sourceType: CharacterFeatureSourceType.subraceFeature,
              sourceId: fixture.subraceFeature.id!,
              name: 'Shadow Step',
              description: 'Custom subrace text.',
              tags: const [FeatureTag.combat],
            ),
            CharacterFeatureOverrideData(
              sourceType: CharacterFeatureSourceType.raceFeature,
              sourceId: fixture.raceFeature.id!,
              name: fixture.raceFeature.name,
              description: fixture.raceFeature.description,
            ),
          ],
          classEntries: [primaryEntry],
          baseAbilityScores: const {
            'strength': 10,
            'dexterity': 16,
            'constitution': 10,
            'intelligence': 10,
            'wisdom': 10,
            'charisma': 10,
          },
          useFlexibleAbilityBonuses: false,
          choices: [
            CharacterChoiceData(
              classEntry: primaryEntry,
              sourceType: ChoiceSourceType.subclassFeature,
              sourceId: fixture.subclassFeature.id,
              groupKey: 'subclass_tool_pick',
              optionKey: 'smith_tools',
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              sourceType: ChoiceSourceType.background,
              sourceId: fixture.background.id,
              groupKey: 'background_language_pick',
              optionKey: 'celestial_language',
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              sourceType: ChoiceSourceType.race,
              sourceId: fixture.race.id,
              groupKey: 'race_choice_${fixture.raceChoiceSet.id}',
              optionKey: 'skilled_feat',
              selectionIndex: 0,
              selectedFeatId: fixture.feat.id,
            ),
          ],
          skillSelections: [
            CharacterSkillSelectionData(
              classEntry: primaryEntry,
              classDataId: fixture.classData.id,
              skill: Skill.acrobatics,
              kind: CharacterSkillSelectionKind.classSkill,
              selectionIndex: 0,
            ),
            CharacterSkillSelectionData(
              classEntry: primaryEntry,
              classDataId: fixture.classData.id,
              skill: Skill.athletics,
              kind: CharacterSkillSelectionKind.classSkill,
              selectionIndex: 1,
            ),
            CharacterSkillSelectionData(
              backgroundDataId: fixture.background.id,
              skill: Skill.survival,
              kind: CharacterSkillSelectionKind.backgroundSkill,
              selectionIndex: 0,
            ),
          ],
          spellSelections: [
            CharacterSpellSelectionData(
              classEntry: primaryEntry,
              classDataId: fixture.classData.id,
              spell: fixture.lightSpell,
              spellId: fixture.lightSpell.id,
              spellKey: fixture.lightSpell.referenceKey,
              kind: CharacterSpellSelectionKind.knownCantrip,
              selectionIndex: 0,
            ),
          ],
          startingEquipmentSelections: [
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.background,
              sourceId: fixture.background.id,
              sourceEntryId: fixture.equipment.backgroundItemPick.id,
              choiceOptionEntryId:
                  fixture.equipment.backgroundHolySymbolPack.id,
              selectionIndex: 0,
            ),
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              sourceEntryId: fixture.equipment.classWeaponPick.id,
              choiceOptionEntryId: fixture.equipment.classSimpleWeaponOption.id,
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  sourceLineEntryId: fixture.equipment.classWeaponAnySimple.id,
                  catalogType: EquipmentCatalogType.weapon,
                  referenceKey: 'club',
                  quantity: 1,
                ),
              ],
            ),
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              sourceEntryId: fixture.equipment.classFocusPick.id,
              choiceOptionEntryId: fixture.equipment.classFocusOption.id,
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  sourceLineEntryId: fixture.equipment.classFocusAnyFocus.id,
                  catalogType: EquipmentCatalogType.item,
                  referenceKey: 'crystal_focus',
                  quantity: 1,
                ),
              ],
            ),
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              sourceEntryId: fixture.equipment.classFixedAnySimple.id,
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  sourceLineEntryId: fixture.equipment.classFixedAnySimple.id,
                  catalogType: EquipmentCatalogType.weapon,
                  referenceKey: 'club',
                  quantity: 1,
                ),
              ],
            ),
          ],
        ),
      );

      final loaded = await endpoints.characterData.getCharacter(
        ownerSession,
        saved.id!,
      );

      expect(loaded.useFlexibleAbilityBonuses, isFalse);
      expect(loaded.customSpellSaveDcBonus, 1);
      expect(loaded.customSpellAttackBonus, -1);
      expect(loaded.preparedSpellKeys, ['light']);
      expect(loaded.customInitiativeBonus, 2);
      expect(loaded.customArmorClassBonus, 1);
      expect(loaded.walkingSpeed, 30);
      expect(loaded.swimmingSpeed, 15);
      expect(loaded.climbingSpeed, 15);
      expect(loaded.flyingSpeed, 60);
      expect(loaded.displayedSpeedKind, CharacterSpeedKind.flying);
      expect(loaded.classEntries, hasLength(1));
      final loadedEntry = loaded.classEntries!.single;
      expect(loadedEntry.classData?.id, fixture.classData.id);
      expect(loadedEntry.subclass?.id, fixture.subclass.id);

      final classSkillSelections = loaded.skillSelections!
          .where(
            (selection) =>
                selection.kind == CharacterSkillSelectionKind.classSkill,
          )
          .toList()
        ..sort(
            (a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));
      expect(classSkillSelections, hasLength(2));
      expect(classSkillSelections.map((selection) => selection.skill), [
        Skill.acrobatics,
        Skill.athletics,
      ]);
      expect(
        classSkillSelections
            .every((selection) => selection.classEntry?.id == loadedEntry.id),
        isTrue,
      );
      final backgroundSkillSelections = loaded.skillSelections!
          .where(
            (selection) =>
                selection.kind == CharacterSkillSelectionKind.backgroundSkill,
          )
          .toList();
      expect(backgroundSkillSelections, hasLength(1));
      expect(backgroundSkillSelections.single.skill, Skill.survival);
      expect(
        backgroundSkillSelections.single.backgroundDataId,
        fixture.background.id,
      );
      final spellSelections = loaded.spellSelections ?? const [];
      expect(spellSelections, hasLength(1));
      expect(spellSelections.single.classDataId, fixture.classData.id);
      expect(spellSelections.single.spell?.id, fixture.lightSpell.id);
      expect(spellSelections.single.spellKey, 'light');
      expect(
        spellSelections.single.kind,
        CharacterSpellSelectionKind.knownCantrip,
      );

      final backgroundChoices = loaded.choices!
          .where((choice) => choice.sourceType == ChoiceSourceType.background)
          .toList();
      expect(backgroundChoices.map((choice) => choice.groupKey).toSet(), {
        'background_language_pick',
      });

      final startingEquipmentSelections =
          loaded.startingEquipmentSelections ?? const [];
      expect(startingEquipmentSelections, hasLength(4));
      final loadedWeaponSelection = startingEquipmentSelections.singleWhere(
        (selection) =>
            selection.sourceEntryId == fixture.equipment.classWeaponPick.id,
      );
      expect(
        loadedWeaponSelection.choiceOptionEntryId,
        fixture.equipment.classSimpleWeaponOption.id,
      );
      expect(
        loadedWeaponSelection.resolutions?.single.referenceKey,
        'club',
      );

      final raceFeatChoice = loaded.choices!.singleWhere(
        (choice) =>
            choice.groupKey == 'race_choice_${fixture.raceChoiceSet.id}',
      );
      expect(raceFeatChoice.selectedFeatId, fixture.feat.id);

      final derived = loaded.derived;
      expect(derived, isNotNull);
      expect(loaded.featureOverrides, hasLength(2));
      expect(derived!.languages, contains('celestial'));
      expect(derived.initiative, 5);
      expect(derived.armorClass, 14);
      expect(derived.speed, 60);
      expect(derived.toolProficiencies, contains('smith_tools'));
      expect(derived.grantedSpellKeys, contains('light'));
      expect(
        derived.grantedEquipment?.map((entry) => entry.referenceKey),
        containsAll([
          'holy_symbol',
          'club',
          'crystal_focus',
          'dagger',
          'leather_armor',
        ]),
      );
      final clubEntry = derived.grantedEquipment!.singleWhere(
        (entry) => entry.referenceKey == 'club',
      );
      expect(clubEntry.quantity, 2);
      final daggerEntry = derived.grantedEquipment!.singleWhere(
        (entry) => entry.referenceKey == 'dagger',
      );
      expect(daggerEntry.quantity, 2);
      expect(derived.featIds, contains(fixture.feat.id));
      expect(
          derived.featureTags,
          containsAll([
            FeatureTag.combat,
            FeatureTag.exploration,
            FeatureTag.utility,
          ]));
      expect(derived.abilityScores?['strength'], 10);
      expect(derived.abilityModifiers?['strength'], 0);
      expect(derived.skillBonuses?['acrobatics'], 5);
      expect(derived.skillBonuses?['athletics'], 2);
      expect(derived.skillBonuses?['insight'], 2);
      expect(derived.skillBonuses?['religion'], 2);
      expect(derived.skillBonuses?['survival'], 2);
      expect(derived.savingThrowProficiencies, contains(Ability.strength));
      expect(derived.savingThrowProficiencies, contains(Ability.constitution));
      final acrobaticsLevel = derived.skillProficiencyLevels!.singleWhere(
        (state) => state.skill == Skill.acrobatics,
      );
      expect(
        acrobaticsLevel.level,
        CharacterSkillProficiencyLevel.proficient,
      );
      expect(
        derived.activeFeatures?.map((feature) => feature.sourceType).toSet(),
        containsAll({
          CharacterFeatureSourceType.classFeature,
          CharacterFeatureSourceType.subclassFeature,
          CharacterFeatureSourceType.raceFeature,
          CharacterFeatureSourceType.subraceFeature,
        }),
      );

      final classFeatureView = derived.activeFeatures!.singleWhere(
        (feature) =>
            feature.sourceType == CharacterFeatureSourceType.classFeature &&
            feature.sourceId == fixture.classFeature.id,
      );
      expect(classFeatureView.defaultName, 'Fighting Style');
      expect(classFeatureView.name, 'Custom Fighting Style');
      expect(classFeatureView.defaultDescription, isNull);
      expect(classFeatureView.description, 'Custom class text.');
      expect(classFeatureView.defaultTags, [FeatureTag.combat]);
      expect(classFeatureView.tags, [FeatureTag.combat]);
      expect(classFeatureView.isCustomized, isTrue);

      final subclassFeatureView = derived.activeFeatures!.singleWhere(
        (feature) =>
            feature.sourceType == CharacterFeatureSourceType.subclassFeature &&
            feature.sourceId == fixture.subclassFeature.id,
      );
      expect(
        subclassFeatureView.sourceName,
        'Fixture Archetype Fixture Champion',
      );

      final subraceFeatureView = derived.activeFeatures!.singleWhere(
        (feature) =>
            feature.sourceType == CharacterFeatureSourceType.subraceFeature &&
            feature.sourceId == fixture.subraceFeature.id,
      );
      expect(subraceFeatureView.defaultName, 'Shadow Sight');
      expect(subraceFeatureView.name, 'Shadow Step');
      expect(
        subraceFeatureView.defaultDescription,
        'See through darkness more clearly.',
      );
      expect(subraceFeatureView.description, 'Custom subrace text.');
      expect(subraceFeatureView.defaultTags, [FeatureTag.utility]);
      expect(subraceFeatureView.tags, [FeatureTag.combat]);
      expect(subraceFeatureView.isCustomized, isTrue);

      final raceFeatureView = derived.activeFeatures!.singleWhere(
        (feature) =>
            feature.sourceType == CharacterFeatureSourceType.raceFeature &&
            feature.sourceId == fixture.raceFeature.id,
      );
      expect(raceFeatureView.defaultName, fixture.raceFeature.name);
      expect(raceFeatureView.name, fixture.raceFeature.name);
      expect(raceFeatureView.isCustomized, isFalse);

      expect(loaded.equipment, isNotNull);
      final loadedEquipment = loaded.equipment!;
      expect(
        loadedEquipment.singleWhere((item) => item.name == 'Club').quantity,
        2,
      );
      expect(
        loadedEquipment.singleWhere((item) => item.name == 'Dagger').quantity,
        2,
      );
      expect(
        loadedEquipment.map((item) => item.name),
        containsAll([
          'Leather Armor',
          'Holy Symbol',
          'Crystal Focus',
        ]),
      );

      expect(loaded.attacks, hasLength(3));
      final manualAttack = loaded.attacks!.singleWhere(
        (attack) => attack.name == 'Длинный меч',
      );
      expect(manualAttack.leadingAbility, Ability.strength);
      expect(manualAttack.damage, '1d8');
      expect(manualAttack.customAttackBonus, 1);
      expect(manualAttack.damageType, DamageType.slashing);
      expect(manualAttack.tags, containsAll(['versatile', 'martial']));
      expect(manualAttack.description, 'Основная атака оружием.');

      final clubAttack = loaded.attacks!.singleWhere(
        (attack) => attack.name == 'Club',
      );
      expect(clubAttack.leadingAbility, Ability.strength);
      expect(clubAttack.damage, '1d4');
      expect(clubAttack.customAttackBonus, 0);
      expect(clubAttack.damageType, DamageType.bludgeoning);
      expect(clubAttack.tags, ['light']);

      final daggerAttack = loaded.attacks!.singleWhere(
        (attack) => attack.name == 'Dagger',
      );
      expect(daggerAttack.leadingAbility, Ability.dexterity);
      expect(daggerAttack.damage, '1d4');
      expect(daggerAttack.customAttackBonus, 0);
      expect(daggerAttack.damageType, DamageType.piercing);
      expect(daggerAttack.tags, containsAll(['finesse', 'light', 'thrown']));

      final resaved = await endpoints.characterData.saveCharacter(
        ownerSession,
        loaded.copyWith(
          equipment: [
            CharacterInventoryItemData(
              name: 'Manual equipment text',
              quantity: 1,
              type: CharacterInventoryItemType.custom,
            ),
          ],
        ),
      );
      expect(resaved.equipment, hasLength(1));
      expect(resaved.equipment?.single.name, 'Manual equipment text');
      expect(resaved.attacks, hasLength(3));
    });

    test('save/get roundtrip preserves hit point tuning fields', () async {
      final ownerSession = authenticatedSession(304);
      final classData = await endpoints.classData.upsert(
        sessionBuilder,
        ClassData(name: 'HP Tuning Class', hitDieValue: 10),
      );

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'HP Tuning Hero',
          deathSaveSuccesses: 2,
          deathSaveFailures: 1,
          hpPerLevelBonus: 1,
          hpFlatBonus: 3,
          currentHitDice: const {'d10': 1},
          hitDiceMaxOverrides: const {'d10': 4},
          classEntries: [
            CharacterClassEntryData(
              classData: classData,
              level: 3,
              isStartingClass: true,
              classOrder: 0,
              hpMode: HitPointMode.manual,
              hpRolledValues: const [8, 7, 6],
            ),
          ],
        ),
      );
      final loaded =
          await endpoints.characterData.getCharacter(ownerSession, saved.id!);

      expect(loaded.deathSaveSuccesses, 2);
      expect(loaded.deathSaveFailures, 1);
      expect(loaded.hpPerLevelBonus, 1);
      expect(loaded.hpFlatBonus, 3);
      expect(loaded.currentHitDice, const {'d10': 1});
      expect(loaded.hitDiceMaxOverrides, const {'d10': 4});
      expect(loaded.classEntries?.single.hpRolledValues, const [8, 7, 6]);
    });

    test('derived hp uses per-level gains, bonuses, and hit dice overrides',
        () async {
      final ownerSession = authenticatedSession(305);
      final classData = await endpoints.classData.upsert(
        sessionBuilder,
        ClassData(name: 'HP Derived Class', hitDieValue: 10),
      );

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'HP Derived Hero',
          baseAbilityScores: const {
            'constitution': 14,
          },
          hpPerLevelBonus: 1,
          hpFlatBonus: 2,
          hitDiceMaxOverrides: const {'d10': 5},
          classEntries: [
            CharacterClassEntryData(
              classData: classData,
              level: 3,
              isStartingClass: true,
              classOrder: 0,
              hpMode: HitPointMode.manual,
              hpRolledValues: const [8, 7, 6],
            ),
          ],
        ),
      );

      expect(saved.derived?.maxHp, 32);
      expect(saved.derived?.hitDiceSummary, const {'d10': 5});
    });

    test('manual skill and saving throw proficiencies fully replace defaults',
        () async {
      final ownerSession = authenticatedSession(313);
      final fixture = await _seedCreationFixture(sessionBuilder, endpoints);
      final primaryEntry = CharacterClassEntryData(
        classData: fixture.classData,
        level: 1,
        isStartingClass: true,
        classOrder: 0,
      );

      final saved = await endpoints.characterData.saveCharacter(
        ownerSession,
        CharacterData(
          name: 'Ручные владения',
          race: fixture.race,
          background: fixture.background,
          classEntries: [primaryEntry],
          baseAbilityScores: const {
            'strength': 16,
            'dexterity': 14,
            'constitution': 10,
            'intelligence': 10,
            'wisdom': 10,
            'charisma': 10,
          },
          customAbilityBonuses: const {
            'strength': 2,
          },
          manualSkillProficiencies: [
            CharacterSkillProficiencyState(
              skill: Skill.athletics,
              level: CharacterSkillProficiencyLevel.expertise,
            ),
            CharacterSkillProficiencyState(
              skill: Skill.stealth,
              level: CharacterSkillProficiencyLevel.proficient,
            ),
          ],
          manualSavingThrowProficiencies: const [Ability.dexterity],
        ),
      );

      final derived = saved.derived!;
      expect(derived.abilityScores?['strength'], 18);
      expect(derived.abilityModifiers?['strength'], 4);
      expect(derived.skillBonuses?['athletics'], 8);
      expect(derived.skillBonuses?['stealth'], 4);
      expect(derived.skillBonuses?['insight'], 0);
      expect(derived.skillBonuses?['religion'], 0);
      expect(derived.savingThrowBonuses?['strength'], 4);
      expect(derived.savingThrowBonuses?['constitution'], 0);
      expect(derived.savingThrowBonuses?['dexterity'], 4);
      expect(derived.passivePerception, 10);
      expect(derived.savingThrowProficiencies, [Ability.dexterity]);

      final athleticsLevel = derived.skillProficiencyLevels!.singleWhere(
        (state) => state.skill == Skill.athletics,
      );
      final stealthLevel = derived.skillProficiencyLevels!.singleWhere(
        (state) => state.skill == Skill.stealth,
      );
      final insightLevel = derived.skillProficiencyLevels!.singleWhere(
        (state) => state.skill == Skill.insight,
      );
      expect(
        athleticsLevel.level,
        CharacterSkillProficiencyLevel.expertise,
      );
      expect(
        stealthLevel.level,
        CharacterSkillProficiencyLevel.proficient,
      );
      expect(insightLevel.level, CharacterSkillProficiencyLevel.none);
      expect(saved.customAbilityBonuses, {'strength': 2});
      expect(saved.manualSkillProficiencies, hasLength(2));
      expect(saved.manualSavingThrowProficiencies, [Ability.dexterity]);
    });

    _registerCharacterDataCreationScenarios(
      sessionBuilder,
      endpoints,
      authenticatedSession,
    );
    _registerCharacterDataSpellSlotScenarios(
      sessionBuilder,
      endpoints,
      authenticatedSession,
      seedCoreSpellSlotTables,
    );
  });
}
