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
          classEntries: [primaryEntry],
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
              sourceType: ChoiceSourceType.background,
              sourceId: fixture.background.id,
              groupKey: 'background_item_pick',
              optionKey: 'holy_symbol_pack',
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
        'background_item_pick',
      });

      final raceFeatChoice = loaded.choices!.singleWhere(
        (choice) =>
            choice.groupKey == 'race_choice_${fixture.raceChoiceSet.id}',
      );
      expect(raceFeatChoice.selectedFeatId, fixture.feat.id);

      final derived = loaded.derived;
      expect(derived, isNotNull);
      expect(derived!.languages, contains('celestial'));
      expect(derived.toolProficiencies, contains('smith_tools'));
      expect(derived.grantedItemKeys, contains('holy_symbol'));
      expect(derived.grantedSpellKeys, contains('light'));
      expect(derived.featIds, contains(fixture.feat.id));
      expect(
          derived.featureTags,
          containsAll([
            FeatureTag.combat,
            FeatureTag.utility,
          ]));
      expect(derived.abilityScores?['strength'], 10);
      expect(derived.abilityModifiers?['strength'], 0);
      expect(derived.skillBonuses?['acrobatics'], 2);
      expect(derived.skillBonuses?['athletics'], 2);
      expect(derived.skillBonuses?['insight'], 2);
      expect(derived.skillBonuses?['religion'], 2);

      expect(loaded.attacks, hasLength(1));
      final attack = loaded.attacks!.single;
      expect(attack.name, 'Длинный меч');
      expect(attack.leadingAbility, Ability.strength);
      expect(attack.damage, '1d8');
      expect(attack.customAttackBonus, 1);
      expect(attack.damageType, DamageType.slashing);
      expect(attack.tags, containsAll(['versatile', 'martial']));
      expect(attack.description, 'Основная атака оружием.');
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
        containsAll({
          'background_language_pick',
          'background_item_pick',
        }),
      );
    });
  });
}

class _CreationFixture {
  const _CreationFixture({
    required this.classData,
    required this.subclass,
    required this.subclassFeature,
    required this.background,
    required this.race,
    required this.raceChoiceSet,
    required this.feat,
  });

  final ClassData classData;
  final SubclassData subclass;
  final SubclassFeatureData subclassFeature;
  final BackgroundData background;
  final RaceData race;
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

  await endpoints.classFeatureData.upsert(
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

  final backgroundItemGroup = await endpoints.classChoiceGroupData.upsert(
    sessionBuilder,
    ClassChoiceGroupData(
      name: 'Background item',
      sourceBackgroundId: background.id,
      type: ClassChoiceType.equipment,
      selectionCount: 1,
      allowDuplicates: false,
      exclusiveKey: 'background_item_pick',
    ),
  );
  await endpoints.classChoiceOptionData.upsert(
    sessionBuilder,
    ClassChoiceOptionData(
      choiceGroupId: backgroundItemGroup.id!,
      optionKey: 'holy_symbol_pack',
      name: 'Holy symbol',
      grantedItemKeys: const ['holy_symbol'],
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
    subclass: subclass,
    subclassFeature: subclassFeature,
    background: background,
    race: hydratedRace.race!,
    raceChoiceSet: raceChoiceSet,
    feat: feat,
  );
}
