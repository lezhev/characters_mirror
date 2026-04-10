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
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              groupKey: 'class_skill_pick',
              optionKey: 'acrobatics_pick',
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              classEntry: primaryEntry,
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              groupKey: 'class_skill_pick',
              optionKey: 'athletics_pick',
              selectionIndex: 1,
            ),
            CharacterChoiceData(
              classEntry: primaryEntry,
              sourceType: ChoiceSourceType.subclassFeature,
              sourceId: fixture.subclassFeature.id,
              groupKey: 'subclass_tool_pick',
              optionKey: 'smith_tools',
              selectionIndex: 0,
            ),
            CharacterChoiceData(
              classEntry: primaryEntry,
              sourceType: ChoiceSourceType.subclassFeature,
              sourceId: fixture.subclassFeature.id,
              groupKey: 'subclass_spell_pick',
              optionKey: 'light_cantrip',
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
          startingEquipmentSelections: [
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.background,
              sourceId: fixture.background.id,
              blockKey: 'background_item_pick',
              optionKey: 'holy_symbol_pack',
              selectionIndex: 0,
            ),
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              blockKey: 'class_weapon_pick',
              optionKey: 'simple_weapon_option',
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  lineKey: 'class_weapon_any_simple',
                  catalogType: EquipmentCatalogType.weapon,
                  referenceKey: 'club',
                  quantity: 1,
                ),
              ],
            ),
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              blockKey: 'class_focus_pick',
              optionKey: 'focus_option',
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  lineKey: 'class_focus_any_focus',
                  catalogType: EquipmentCatalogType.item,
                  referenceKey: 'crystal_focus',
                  quantity: 1,
                ),
              ],
            ),
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: fixture.classData.id,
              blockKey: 'class_fixed_pack',
              selectionIndex: 0,
              resolutions: [
                CharacterStartingEquipmentResolutionData(
                  lineKey: 'class_fixed_any_simple',
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

      final classChoices = loaded.choices!
          .where((choice) => choice.groupKey == 'class_skill_pick')
          .toList()
        ..sort(
            (a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));
      expect(classChoices, hasLength(2));
      expect(classChoices.map((choice) => choice.optionKey), [
        'acrobatics_pick',
        'athletics_pick',
      ]);
      expect(
        classChoices.every((choice) => choice.classEntry?.id == loadedEntry.id),
        isTrue,
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
        (selection) => selection.blockKey == 'class_weapon_pick',
      );
      expect(loadedWeaponSelection.optionKey, 'simple_weapon_option');
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
            FeatureTag.utility,
          ]));
      expect(derived.abilityScores?['strength'], 10);
      expect(derived.abilityModifiers?['strength'], 0);
      expect(derived.skillBonuses?['acrobatics'], 5);
      expect(derived.skillBonuses?['athletics'], 2);
      expect(derived.skillBonuses?['insight'], 2);
      expect(derived.skillBonuses?['religion'], 2);
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
        loaded.copyWith(equipment: 'Manual equipment text'),
      );
      expect(resaved.equipment, 'Manual equipment text');
      expect(resaved.attacks, hasLength(3));
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
          'class_skill_pick',
          'subclass_tool_pick',
          'subclass_spell_pick',
        }),
      );
      expect(
        stepView.startingEquipmentBlocks
            ?.map((blockView) => blockView.block?.blockKey)
            .whereType<String>()
            .toSet(),
        containsAll({
          'class_fixed_pack',
          'class_weapon_pick',
          'class_focus_pick',
        }),
      );
      final classWeaponBlock = stepView.startingEquipmentBlocks!.singleWhere(
        (blockView) => blockView.block?.blockKey == 'class_weapon_pick',
      );
      final simpleWeaponOption = classWeaponBlock.options!.singleWhere(
        (optionView) => optionView.option?.optionKey == 'simple_weapon_option',
      );
      expect(
        simpleWeaponOption.lines?.single.kind,
        StartingEquipmentLineKind.weaponCategory,
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
      expect(
        stepView.startingEquipmentBlocks
            ?.map((blockView) => blockView.block?.blockKey)
            .whereType<String>()
            .toSet(),
        contains('background_item_pick'),
      );
    });

    test('warlock step view bootstraps canonical starting equipment', () async {
      final warlock = await endpoints.classData.upsert(
        sessionBuilder,
        ClassData(
          name: 'Warlock',
          hitDieValue: 8,
          primaryAbilities: const [Ability.charisma],
          savingThrowProficiencies: const [Ability.wisdom, Ability.charisma],
          armorTraining: const [ArmorCategory.light],
          weaponTraining: const [
            WeaponCategory.simpleMelee,
            WeaponCategory.simpleRanged,
          ],
          availableSkills: const [Skill.arcana, Skill.deception],
          skillCount: 2,
          subclassChoiceLevel: 1,
          imageURL: 'warlock',
        ),
      );

      final stepView = await endpoints.classData.getStepView(
        sessionBuilder,
        warlock.id!,
        selectedLevel: 1,
        isStartingClass: true,
      );

      final blockKeys = stepView.startingEquipmentBlocks
              ?.map((blockView) => blockView.block?.blockKey)
              .whereType<String>()
              .toList() ??
          const <String>[];
      expect(
        blockKeys,
        orderedEquals([
          'warlock_weapon_choice',
          'warlock_focus_choice',
          'warlock_pack_choice',
          'warlock_fixed_equipment',
        ]),
      );

      final weaponBlock = stepView.startingEquipmentBlocks!.firstWhere(
        (blockView) => blockView.block?.blockKey == 'warlock_weapon_choice',
      );
      expect(
        weaponBlock.options
            ?.map((optionView) => optionView.option?.optionKey)
            .whereType<String>(),
        containsAll(
            ['warlock_crossbow_option', 'warlock_simple_weapon_option']),
      );

      final packBlock = stepView.startingEquipmentBlocks!.firstWhere(
        (blockView) => blockView.block?.blockKey == 'warlock_pack_choice',
      );
      expect(
        packBlock.options
            ?.map((optionView) => optionView.option?.optionKey)
            .whereType<String>(),
        containsAll([
          'warlock_scholar_pack_option',
          'warlock_dungeoneer_pack_option',
        ]),
      );

      final fixedBlock = stepView.startingEquipmentBlocks!.firstWhere(
        (blockView) => blockView.block?.blockKey == 'warlock_fixed_equipment',
      );
      expect(
        fixedBlock.fixedLines
            ?.map((line) => line.lineKey)
            .whereType<String>()
            .toList(),
        orderedEquals([
          'warlock_fixed_leather_armor',
          'warlock_fixed_simple_weapon',
          'warlock_fixed_daggers',
        ]),
      );

      final items = await endpoints.itemData.getAll(sessionBuilder);
      final itemKeys =
          items.map((item) => item.referenceKey).whereType<String>().toSet();
      expect(
        itemKeys,
        containsAll([
          'component_pouch',
          'scholar_pack',
          'dungeoneer_pack',
          'bolts',
          'crystal_focus',
        ]),
      );

      final weapons = await endpoints.weaponData.getAll(sessionBuilder);
      final weaponKeys = weapons
          .map((weapon) => weapon.referenceKey)
          .whereType<String>()
          .toSet();
      expect(
        weaponKeys,
        containsAll([
          'club',
          'dagger',
          'greatclub',
          'handaxe',
          'javelin',
          'light_hammer',
          'mace',
          'quarterstaff',
          'sickle',
          'spear',
          'light_crossbow',
          'dart',
          'shortbow',
          'sling',
        ]),
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
      imageURL: 'fighter',
    ),
  );

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

  final classSkillGroup = await endpoints.classChoiceGroupData.upsert(
    sessionBuilder,
    ClassChoiceGroupData(
      name: 'Class skills',
      sourceClassId: classData.id,
      type: ClassChoiceType.skill,
      selectionCount: 2,
      allowDuplicates: false,
      exclusiveKey: 'class_skill_pick',
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: classSkillGroup.id!,
      optionKey: 'acrobatics_pick',
      name: 'Acrobatics',
      grantedSkills: const [Skill.acrobatics],
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: classSkillGroup.id!,
      optionKey: 'athletics_pick',
      name: 'Athletics',
      grantedSkills: const [Skill.athletics],
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: classSkillGroup.id!,
      optionKey: 'perception_pick',
      name: 'Perception',
      grantedSkills: const [Skill.perception],
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

  final subclassSpellGroup = await endpoints.classChoiceGroupData.upsert(
    sessionBuilder,
    ClassChoiceGroupData(
      name: 'Subclass spell',
      sourceSubclassFeatureId: subclassFeature.id,
      type: ClassChoiceType.spell,
      selectionCount: 1,
      allowDuplicates: false,
      exclusiveKey: 'subclass_spell_pick',
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: subclassSpellGroup.id!,
      optionKey: 'light_cantrip',
      name: 'Light',
      grantedSpellKeys: const ['light'],
    ),
  );

  final background = await endpoints.backgroundData.upsert(
    sessionBuilder,
    BackgroundData(
      name: 'Fixture Acolyte',
      skillProficiencies: const ['insight', 'religion'],
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
      damageTypeValue: DamageType.bludgeoning,
      properties: const ['light'],
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'dagger',
      name: 'Dagger',
      category: WeaponCategory.simpleMelee,
      damage: '1d4',
      damageTypeValue: DamageType.piercing,
      properties: const ['finesse', 'light', 'thrown'],
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'light_crossbow',
      name: 'Light Crossbow',
      category: WeaponCategory.simpleRanged,
      damage: '1d8',
      damageTypeValue: DamageType.piercing,
      properties: const ['ammunition', 'loading', 'two-handed'],
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

  final backgroundItemBlock = await endpoints.startingEquipmentBlockData.upsert(
    sessionBuilder,
    StartingEquipmentBlockData(
      sourceBackgroundId: background.id,
      blockKey: 'background_item_pick',
      orderIndex: 0,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      name: 'Background item',
    ),
  );
  final holySymbolOption = await endpoints.startingEquipmentOptionData.upsert(
    sessionBuilder,
    StartingEquipmentOptionData(
      blockId: backgroundItemBlock.id!,
      optionKey: 'holy_symbol_pack',
      orderIndex: 0,
      name: 'Holy symbol',
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      optionId: holySymbolOption.id!,
      lineKey: 'background_holy_symbol',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'holy_symbol',
      displayText: 'Holy symbol',
      quantity: 1,
    ),
  );

  final classFixedBlock = await endpoints.startingEquipmentBlockData.upsert(
    sessionBuilder,
    StartingEquipmentBlockData(
      sourceClassId: classData.id,
      blockKey: 'class_fixed_pack',
      orderIndex: 0,
      kind: StartingEquipmentBlockKind.fixedGrant,
      selectionCount: 1,
      name: 'Warlock fixed equipment',
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      blockId: classFixedBlock.id!,
      lineKey: 'class_fixed_leather',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.armor,
      referenceKey: 'leather_armor',
      displayText: 'Leather Armor',
      quantity: 1,
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      blockId: classFixedBlock.id!,
      lineKey: 'class_fixed_any_simple',
      orderIndex: 1,
      kind: StartingEquipmentLineKind.weaponCategory,
      displayText: 'Any simple weapon',
      quantity: 1,
      allowedWeaponCategories: const [
        WeaponCategory.simpleMelee,
        WeaponCategory.simpleRanged,
      ],
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      blockId: classFixedBlock.id!,
      lineKey: 'class_fixed_daggers',
      orderIndex: 2,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.weapon,
      referenceKey: 'dagger',
      displayText: 'Dagger',
      quantity: 2,
    ),
  );

  final classWeaponBlock = await endpoints.startingEquipmentBlockData.upsert(
    sessionBuilder,
    StartingEquipmentBlockData(
      sourceClassId: classData.id,
      blockKey: 'class_weapon_pick',
      orderIndex: 1,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      name: 'Weapon choice',
    ),
  );
  final crossbowOption = await endpoints.startingEquipmentOptionData.upsert(
    sessionBuilder,
    StartingEquipmentOptionData(
      blockId: classWeaponBlock.id!,
      optionKey: 'crossbow_pack',
      orderIndex: 0,
      name: 'Light crossbow and 20 bolts',
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      optionId: crossbowOption.id!,
      lineKey: 'class_weapon_crossbow',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.weapon,
      referenceKey: 'light_crossbow',
      displayText: 'Light Crossbow',
      quantity: 1,
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      optionId: crossbowOption.id!,
      lineKey: 'class_weapon_bolts',
      orderIndex: 1,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'bolts',
      displayText: 'Crossbow Bolts',
      quantity: 20,
    ),
  );
  final simpleWeaponOption = await endpoints.startingEquipmentOptionData.upsert(
    sessionBuilder,
    StartingEquipmentOptionData(
      blockId: classWeaponBlock.id!,
      optionKey: 'simple_weapon_option',
      orderIndex: 1,
      name: 'Any simple weapon',
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      optionId: simpleWeaponOption.id!,
      lineKey: 'class_weapon_any_simple',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.weaponCategory,
      displayText: 'Any simple weapon',
      quantity: 1,
      allowedWeaponCategories: const [
        WeaponCategory.simpleMelee,
        WeaponCategory.simpleRanged,
      ],
    ),
  );

  final classFocusBlock = await endpoints.startingEquipmentBlockData.upsert(
    sessionBuilder,
    StartingEquipmentBlockData(
      sourceClassId: classData.id,
      blockKey: 'class_focus_pick',
      orderIndex: 2,
      kind: StartingEquipmentBlockKind.choice,
      selectionCount: 1,
      name: 'Focus choice',
    ),
  );
  final componentPouchOption =
      await endpoints.startingEquipmentOptionData.upsert(
    sessionBuilder,
    StartingEquipmentOptionData(
      blockId: classFocusBlock.id!,
      optionKey: 'component_pouch_option',
      orderIndex: 0,
      name: 'Component pouch',
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      optionId: componentPouchOption.id!,
      lineKey: 'class_focus_component_pouch',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'component_pouch',
      displayText: 'Component Pouch',
      quantity: 1,
    ),
  );
  final focusOption = await endpoints.startingEquipmentOptionData.upsert(
    sessionBuilder,
    StartingEquipmentOptionData(
      blockId: classFocusBlock.id!,
      optionKey: 'focus_option',
      orderIndex: 1,
      name: 'Arcane focus',
    ),
  );
  await endpoints.startingEquipmentLineData.upsert(
    sessionBuilder,
    StartingEquipmentLineData(
      optionId: focusOption.id!,
      lineKey: 'class_focus_any_focus',
      orderIndex: 0,
      kind: StartingEquipmentLineKind.itemCategory,
      displayText: 'Arcane focus',
      quantity: 1,
      allowedItemCategories: const ['Focus'],
    ),
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
  );
}
