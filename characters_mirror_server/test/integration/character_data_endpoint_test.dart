import 'dart:convert';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
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
          subrace: fixture.subrace,
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
      expect(loaded.equipment, contains('Club x2'));
      expect(loaded.equipment, contains('Dagger x2'));
      expect(loaded.equipment, contains('Leather Armor'));
      expect(loaded.equipment, contains('Holy symbol'));
      expect(loaded.equipment, contains('Crystal Focus'));

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
              sourceType: ChoiceSourceType.race,
              sourceId: fixture.race.id,
              groupKey: fixture.anyBonusGroupKey,
              optionKey: Ability.dexterity.name,
              selectedAbility: Ability.dexterity,
              selectedCount: 1,
            ),
          ],
        ),
      );

      final scores = saved.derived!.abilityScores!;
      expect(scores['charisma'], 12);
      expect(scores['dexterity'], 11);
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
              sourceType: ChoiceSourceType.race,
              sourceId: fixture.race.id,
              groupKey: 'race_bonus_mode',
              selectedText: 'flexiblePlusTwoOne',
            ),
            CharacterChoiceData(
              sourceType: ChoiceSourceType.race,
              sourceId: fixture.race.id,
              groupKey: 'race_flexible_bonus_plus2',
              optionKey: Ability.strength.name,
              selectedAbility: Ability.strength,
              selectedCount: 2,
            ),
            CharacterChoiceData(
              sourceType: ChoiceSourceType.race,
              sourceId: fixture.race.id,
              groupKey: 'race_flexible_bonus_plus1',
              optionKey: Ability.dexterity.name,
              selectedAbility: Ability.dexterity,
              selectedCount: 1,
            ),
            CharacterChoiceData(
              sourceType: ChoiceSourceType.race,
              sourceId: fixture.race.id,
              groupKey: fixture.anyBonusGroupKey,
              optionKey: Ability.wisdom.name,
              selectedAbility: Ability.wisdom,
              selectedCount: 1,
            ),
          ],
        ),
      );

      final scores = saved.derived!.abilityScores!;
      expect(scores['charisma'], 10);
      expect(scores['strength'], 12);
      expect(scores['dexterity'], 11);
      expect(scores['wisdom'], 10);
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

    test(
        'class feature upsert stores nested spell grants by spell reference key',
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

    test('reference import stores class spell grant by spell reference key',
        () async {
      final classData = await endpoints.classData.upsert(
        sessionBuilder,
        ClassData(
          name: 'Grant Import Class',
          hitDieValue: 8,
        ),
      );
      final feature = await endpoints.classFeatureData.upsert(
        sessionBuilder,
        ClassFeatureData(
          parentClassId: classData.id!,
          name: 'Imported Feature Spells',
          level: 1,
        ),
      );
      final spell = await endpoints.spellData.add(
        sessionBuilder,
        SpellData(
          referenceKey: 'grant_import_bless',
          name: 'Grant Import Bless',
          level: 1,
          schoolValue: SpellSchool.enchantment,
        ),
      );

      await endpoints.referenceData.insertJson(
        sessionBuilder,
        'classspellgrant',
        jsonEncode({
          'sourceFeatureId': feature.id,
          'spellReferenceKey': 'grant_import_bless',
          'grantedAtLevel': 1,
          'alwaysPrepared': true,
        }),
      );

      final allGrants = await endpoints.classSpellGrantData.getAll(
        sessionBuilder,
      );
      final storedGrant = allGrants.singleWhere(
        (grant) => grant.sourceFeatureId == feature.id,
      );
      expect(storedGrant.spellId, spell.id);
      expect(storedGrant.spell?.referenceKey, 'grant_import_bless');
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

      final nestedSubclassFeature =
          stepView.currentSubclassFeatures!.singleWhere(
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

      Future<CharacterData> saveAndLoad(
          SubclassData subclass, int level) async {
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

    test('derived pact magic slots stay separate from standard slots',
        () async {
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
          await SpellClassAvailabilityData.db.insertRow(
            session,
            SpellClassAvailabilityData(
              spellId: spell.id!,
              classDataId: classData.id!,
            ),
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
  });
}

class _CreationFixture {
  const _CreationFixture({
    required this.classData,
    required this.classFeature,
    required this.subclass,
    required this.subclassFeature,
    required this.background,
    required this.race,
    required this.raceFeature,
    required this.subrace,
    required this.subraceFeature,
    required this.raceChoiceSet,
    required this.feat,
    required this.lightSpell,
    required this.magicMissileSpell,
    required this.equipment,
  });

  final ClassData classData;
  final ClassFeatureData classFeature;
  final SubclassData subclass;
  final SubclassFeatureData subclassFeature;
  final BackgroundData background;
  final RaceData race;
  final RaceFeatureData raceFeature;
  final SubraceData subrace;
  final RaceFeatureData subraceFeature;
  final RaceChoiceSetData raceChoiceSet;
  final FeatData feat;
  final SpellData lightSpell;
  final SpellData magicMissileSpell;
  final _StartingEquipmentFixture equipment;
}

class _StartingEquipmentFixture {
  const _StartingEquipmentFixture({
    required this.backgroundItemPick,
    required this.backgroundHolySymbolPack,
    required this.classFixedPack,
    required this.classFixedAnySimple,
    required this.classWeaponPick,
    required this.classSimpleWeaponOption,
    required this.classWeaponAnySimple,
    required this.classFocusPick,
    required this.classFocusOption,
    required this.classFocusAnyFocus,
  });

  final StartingEquipmentEntryData backgroundItemPick;
  final StartingEquipmentEntryData backgroundHolySymbolPack;
  final StartingEquipmentEntryData classFixedPack;
  final StartingEquipmentEntryData classFixedAnySimple;
  final StartingEquipmentEntryData classWeaponPick;
  final StartingEquipmentEntryData classSimpleWeaponOption;
  final StartingEquipmentEntryData classWeaponAnySimple;
  final StartingEquipmentEntryData classFocusPick;
  final StartingEquipmentEntryData classFocusOption;
  final StartingEquipmentEntryData classFocusAnyFocus;
}

Future<_StartingEquipmentFixture> _seedStartingEquipmentEntries(
  TestSessionBuilder sessionBuilder, {
  required ClassData classData,
  required BackgroundData background,
}) async {
  final session = sessionBuilder.build();
  try {
    Future<StartingEquipmentEntryData> insert(
      StartingEquipmentEntryData entry,
    ) {
      return StartingEquipmentEntryData.db.insertRow(session, entry);
    }

    final backgroundItemPick = await insert(
      StartingEquipmentEntryData(
        sourceBackgroundId: background.id!,
        kind: StartingEquipmentEntryKind.choiceGroup,
        orderIndex: 0,
        selectionCount: 1,
      ),
    );
    final backgroundHolySymbolPack = await insert(
      StartingEquipmentEntryData(
        sourceBackgroundId: background.id!,
        parentEntryId: backgroundItemPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 0,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceBackgroundId: background.id!,
        parentEntryId: backgroundHolySymbolPack.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.item,
        referenceKey: 'holy_symbol',
        quantity: 1,
      ),
    );

    final classFixedPack = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.fixedLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.armor,
        referenceKey: 'leather_armor',
        quantity: 1,
      ),
    );
    final classFixedAnySimple = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.fixedLine,
        orderIndex: 1,
        lineKind: StartingEquipmentLineKind.weaponCategory,
        quantity: 1,
        allowedWeaponCategories: const [
          WeaponCategory.simpleMelee,
          WeaponCategory.simpleRanged,
        ],
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.fixedLine,
        orderIndex: 2,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.weapon,
        referenceKey: 'dagger',
        quantity: 2,
      ),
    );

    final classWeaponPick = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.choiceGroup,
        orderIndex: 3,
        selectionCount: 1,
      ),
    );
    final crossbowPack = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classWeaponPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 0,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: crossbowPack.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.weapon,
        referenceKey: 'light_crossbow',
        quantity: 1,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: crossbowPack.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 1,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.item,
        referenceKey: 'bolts',
        quantity: 20,
      ),
    );
    final classSimpleWeaponOption = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classWeaponPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 1,
      ),
    );
    final classWeaponAnySimple = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classSimpleWeaponOption.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.weaponCategory,
        quantity: 1,
        allowedWeaponCategories: const [
          WeaponCategory.simpleMelee,
          WeaponCategory.simpleRanged,
        ],
      ),
    );

    final classFocusPick = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.choiceGroup,
        orderIndex: 4,
        selectionCount: 1,
      ),
    );
    final componentPouchOption = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classFocusPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 0,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: componentPouchOption.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.item,
        referenceKey: 'component_pouch',
        quantity: 1,
      ),
    );
    final classFocusOption = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classFocusPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 1,
      ),
    );
    final classFocusAnyFocus = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classFocusOption.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.itemCategory,
        catalogType: EquipmentCatalogType.item,
        quantity: 1,
        allowedItemCategories: const ['Focus'],
      ),
    );

    return _StartingEquipmentFixture(
      backgroundItemPick: backgroundItemPick,
      backgroundHolySymbolPack: backgroundHolySymbolPack,
      classFixedPack: classFixedPack,
      classFixedAnySimple: classFixedAnySimple,
      classWeaponPick: classWeaponPick,
      classSimpleWeaponOption: classSimpleWeaponOption,
      classWeaponAnySimple: classWeaponAnySimple,
      classFocusPick: classFocusPick,
      classFocusOption: classFocusOption,
      classFocusAnyFocus: classFocusAnyFocus,
    );
  } finally {
    await session.close();
  }
}

class _MixedAbilityBonusRaceFixture {
  const _MixedAbilityBonusRaceFixture({
    required this.race,
    required this.anyBonusChoiceSet,
  });

  final RaceData race;
  final RaceChoiceSetData anyBonusChoiceSet;

  String get anyBonusGroupKey => 'race_choice_${anyBonusChoiceSet.id}_bonus_1';
}

Future<_MixedAbilityBonusRaceFixture> _seedMixedAbilityBonusRace(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
) async {
  final race = await endpoints.raceData.upsert(
    sessionBuilder,
    RaceData(
      name: 'Fixture Charisma Plus Any Race',
      charismaBonus: 2,
    ),
  );
  final feature = await endpoints.raceFeature.upsert(
    sessionBuilder,
    RaceFeatureData(
      raceId: race.id,
      name: 'Flexible Aptitude',
      level: 1,
    ),
  );
  final choiceSet = await endpoints.raceChoiceSetData.upsert(
    sessionBuilder,
    RaceChoiceSetData(
      featureId: feature.id!,
      kind: RaceChoiceKind.abilityBonusChoice,
      pickCount: 1,
      mustBeDistinct: true,
      description: 'Choose one ability score to increase by 1.',
    ),
  );

  for (final ability in Ability.values) {
    await endpoints.raceChoiceOptionData.upsert(
      sessionBuilder,
      RaceChoiceOptionData(
        choiceSetId: choiceSet.id!,
        optionKey: ability.name,
        name: ability.name,
        ability: ability,
        bonusValue: 1,
      ),
    );
  }

  final hydratedRace = await endpoints.raceData.getStepView(
    sessionBuilder,
    race.id!,
  );

  return _MixedAbilityBonusRaceFixture(
    race: hydratedRace.race!,
    anyBonusChoiceSet: choiceSet,
  );
}

Future<_CreationFixture> _seedCreationFixture(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
) async {
  final classData = await endpoints.classData.upsert(
    sessionBuilder,
    ClassData(
      name: 'Fixture Fighter',
      hitDieValue: 10,
      primaryAbilities: const [Ability.strength],
      savingThrowProficiencies: const [
        Ability.strength,
        Ability.constitution,
      ],
      armorTraining: const [
        ArmorCategory.light,
        ArmorCategory.medium,
        ArmorCategory.shield,
      ],
      weaponTraining: const [
        WeaponCategory.simpleMelee,
        WeaponCategory.martialMelee,
      ],
      availableSkills: const [
        Skill.acrobatics,
        Skill.athletics,
        Skill.perception,
      ],
      skillCount: 2,
      subclassChoiceLevel: 1,
      spellcastingProgression: SpellcastingProgression.full,
      imageURL: 'fighter',
    ),
  );
  await endpoints.classLevelData.upsert(
    sessionBuilder,
    ClassLevelData(
      classDataId: classData.id!,
      level: 1,
      knownCantrips: 1,
      knownSpells: 1,
    ),
  );
  await endpoints.spellSlotProgressionData.upsert(
    sessionBuilder,
    SpellSlotProgressionData(
      tableKey: 'standard',
      level: 1,
      spellSlots: const {1: 2},
    ),
  );
  final lightSpell = await endpoints.spellData.add(
    sessionBuilder,
    SpellData(
      referenceKey: 'light',
      name: 'Light',
      level: 0,
      schoolValue: SpellSchool.evocation,
    ),
  );
  final magicMissileSpell = await endpoints.spellData.add(
    sessionBuilder,
    SpellData(
      referenceKey: 'magic_missile',
      name: 'Magic Missile',
      level: 1,
      schoolValue: SpellSchool.evocation,
    ),
  );
  await endpoints.spellData.add(
    sessionBuilder,
    SpellData(
      referenceKey: 'shield',
      name: 'Shield',
      level: 1,
      schoolValue: SpellSchool.abjuration,
    ),
  );
  final session = sessionBuilder.build();
  try {
    await SpellClassAvailabilityData.db.insertRow(
      session,
      SpellClassAvailabilityData(
        spellId: lightSpell.id!,
        classDataId: classData.id!,
      ),
    );
    await SpellClassAvailabilityData.db.insertRow(
      session,
      SpellClassAvailabilityData(
        spellId: magicMissileSpell.id!,
        classDataId: classData.id!,
      ),
    );
  } finally {
    await session.close();
  }

  final classFeature = await endpoints.classFeatureData.upsert(
    sessionBuilder,
    ClassFeatureData(
      parentClassId: classData.id!,
      name: 'Fighting Style',
      level: 1,
      tags: const [FeatureTag.combat],
    ),
  );

  final subclass = await endpoints.subclassData.upsert(
    sessionBuilder,
    SubclassData(
      parentClassId: classData.id!,
      name: 'Fixture Champion',
      levelRequired: 1,
      description: 'Subclass used in integration tests.',
    ),
  );

  final subclassFeature = await endpoints.subclassFeatureData.upsert(
    sessionBuilder,
    SubclassFeatureData(
      parentSubclassId: subclass.id!,
      name: 'Fixture Specialty',
      level: 1,
      tags: const [FeatureTag.utility],
    ),
  );

  final subclassToolGroup = await endpoints.classChoiceGroupData.upsert(
    sessionBuilder,
    ClassChoiceGroupData(
      name: 'Subclass tools',
      sourceSubclassFeatureId: subclassFeature.id,
      type: ClassChoiceType.tool,
      selectionCount: 1,
      allowDuplicates: false,
      exclusiveKey: 'subclass_tool_pick',
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: subclassToolGroup.id!,
      optionKey: 'smith_tools',
      name: 'Smith tools',
      grantedToolKeys: const ['smith_tools'],
    ),
  );

  final background = await endpoints.backgroundData.upsert(
    sessionBuilder,
    BackgroundData(
      name: 'Fixture Acolyte',
      skillProficiencies: const ['insight', 'religion'],
      availableSkills: const [Skill.survival, Skill.history],
      skillCount: 1,
      feature: 'Shelter of the Faithful',
    ),
  );

  final backgroundLanguageGroup = await endpoints.classChoiceGroupData.upsert(
    sessionBuilder,
    ClassChoiceGroupData(
      name: 'Background language',
      sourceBackgroundId: background.id,
      type: ClassChoiceType.language,
      selectionCount: 1,
      allowDuplicates: false,
      exclusiveKey: 'background_language_pick',
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: backgroundLanguageGroup.id!,
      optionKey: 'celestial_language',
      name: 'Celestial',
      grantedLanguages: const [Language.celestial],
    ),
  );

  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'holy_symbol',
      name: 'Holy Symbol',
      category: 'Gear',
    ),
  );
  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'crystal_focus',
      name: 'Crystal Focus',
      category: 'Focus',
    ),
  );
  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'component_pouch',
      name: 'Component Pouch',
      category: 'Gear',
    ),
  );
  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'bolts',
      name: 'Crossbow Bolts',
      category: 'Ammunition',
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'club',
      name: 'Club',
      category: WeaponCategory.simpleMelee,
      damage: '1d4',
      damageType: DamageType.bludgeoning,
      properties: const [WeaponProperty.light],
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'dagger',
      name: 'Dagger',
      category: WeaponCategory.simpleMelee,
      damage: '1d4',
      damageType: DamageType.piercing,
      properties: const [
        WeaponProperty.finesse,
        WeaponProperty.light,
        WeaponProperty.thrown,
      ],
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'light_crossbow',
      name: 'Light Crossbow',
      category: WeaponCategory.simpleRanged,
      damage: '1d8',
      damageType: DamageType.piercing,
      properties: const [
        WeaponProperty.ammunition,
        WeaponProperty.loading,
        WeaponProperty.twoHanded,
      ],
    ),
  );
  await endpoints.armorData.upsert(
    sessionBuilder,
    ArmorData(
      referenceKey: 'leather_armor',
      name: 'Leather Armor',
      categoryValue: ArmorCategory.light,
    ),
  );

  final equipment = await _seedStartingEquipmentEntries(
    sessionBuilder,
    classData: classData,
    background: background,
  );

  final feat = await endpoints.featData.upsert(
    sessionBuilder,
    FeatData(
      name: 'Skilled',
      tags: const [FeatureTag.utility],
    ),
  );

  final race = await endpoints.raceData.upsert(
    sessionBuilder,
    RaceData(
      name: 'Fixture Variant Human',
      size: CreatureSize.medium,
      speed: 30,
      languages: const ['common'],
      visionType: SenseType.darkvision,
      skillProficiencies: const [],
      armorProficiencies: const [],
      weaponProficiencies: const [],
      toolProficiencies: const [],
    ),
  );

  final raceFeature = await endpoints.raceFeature.upsert(
    sessionBuilder,
    RaceFeatureData(
      raceId: race.id,
      name: 'Variant Human Bonus Feat',
      level: 1,
    ),
  );

  final subrace = await endpoints.subraceData.upsert(
    sessionBuilder,
    SubraceData(
      parentRaceId: race.id!,
      name: 'Fixture Nightfolk',
      description: 'Subrace used in integration tests.',
    ),
  );

  final subraceFeature = await endpoints.raceFeature.upsert(
    sessionBuilder,
    RaceFeatureData(
      subraceId: subrace.id,
      name: 'Shadow Sight',
      description: 'See through darkness more clearly.',
      level: 1,
      tags: const [FeatureTag.utility],
    ),
  );

  final raceChoiceSet = await endpoints.raceChoiceSetData.upsert(
    sessionBuilder,
    RaceChoiceSetData(
      featureId: raceFeature.id!,
      kind: RaceChoiceKind.featChoice,
      pickCount: 1,
      mustBeDistinct: true,
      description: 'Choose one feat.',
    ),
  );

  await endpoints.raceChoiceOptionData.upsert(
    sessionBuilder,
    RaceChoiceOptionData(
      choiceSetId: raceChoiceSet.id!,
      optionKey: 'skilled_feat',
      name: 'Skilled',
      featId: feat.id!,
      grantedFeatureTags: const [FeatureTag.exploration],
    ),
  );

  final hydratedRace = await endpoints.raceData.getStepView(
    sessionBuilder,
    race.id!,
  );

  return _CreationFixture(
    classData: classData,
    classFeature: classFeature,
    subclass: subclass,
    subclassFeature: subclassFeature,
    background: background,
    race: hydratedRace.race!,
    raceFeature: raceFeature,
    subrace: subrace,
    subraceFeature: subraceFeature,
    raceChoiceSet: raceChoiceSet,
    feat: feat,
    lightSpell: lightSpell,
    magicMissileSpell: magicMissileSpell,
    equipment: equipment,
  );
}
