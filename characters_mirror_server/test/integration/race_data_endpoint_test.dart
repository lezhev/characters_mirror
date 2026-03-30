import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('RaceData endpoint', (sessionBuilder, endpoints) {
    test(
        'getStepView returns nested race, subrace, spell grant, and choice option data',
        () async {
      final race = await endpoints.raceData.upsert(
        sessionBuilder,
        RaceData(
          name: 'Test Dragonborn',
          size: CreatureSize.medium,
          visionType: SenseType.darkvision,
          visionRange: 60,
        ),
      );
      final subrace = await endpoints.subraceData.upsert(
        sessionBuilder,
        SubraceData(
          name: 'Test Lineage',
          parentRaceId: race.id!,
          charismaBonus: 1,
        ),
      );
      final spell = await endpoints.spellData.upsert(
        sessionBuilder,
        SpellData(
          name: 'Test Thaumaturgy',
          level: 0,
        ),
      );

      final raceFeature = await endpoints.raceFeature.upsert(
        sessionBuilder,
        RaceFeatureData(
          raceId: race.id,
          name: 'Breath Weapon',
          level: 1,
          description: 'Test breath weapon.',
        ),
      );
      await endpoints.raceFeature.upsert(
        sessionBuilder,
        RaceFeatureData(
          subraceId: subrace.id,
          name: 'Chromatic Legacy',
          level: 1,
          description: 'Test subrace feature.',
        ),
      );

      final choiceSet = await endpoints.raceChoiceSetData.upsert(
        sessionBuilder,
        RaceChoiceSetData(
          featureId: raceFeature.id!,
          kind: RaceChoiceKind.dragonbornAncestryChoice,
          pickCount: 1,
          mustBeDistinct: true,
          description: 'Choose a legacy.',
        ),
      );
      await endpoints.raceChoiceOptionData.upsert(
        sessionBuilder,
        RaceChoiceOptionData(
          choiceSetId: choiceSet.id!,
          optionKey: 'red_dragon',
          name: 'Red Dragon',
          damageType: DamageType.fire,
          areaOfEffectType: AreaOfEffectType.cone,
          areaText: '15 ft.',
          saveAbility: Ability.dexterity,
          damageByLevel: const {'1': '2d6', '5': '3d6'},
        ),
      );
      await endpoints.raceFeatureSpellGrantData.upsert(
        sessionBuilder,
        RaceFeatureSpellGrantData(
          featureId: raceFeature.id!,
          spellId: spell.id!,
          grantedAtLevel: 1,
          castingAbility: Ability.charisma,
          freeCastsPerRest: RestType.longRest,
          castAtSpellLevel: 1,
          canAlsoCastWithSpellSlots: false,
        ),
      );

      final stepView = await endpoints.raceData.getStepView(
        sessionBuilder,
        race.id!,
      );

      expect(stepView.race?.id, race.id);
      expect(stepView.subraces, hasLength(1));
      expect(stepView.features, hasLength(2));

      final nestedRaceFeature = stepView.race?.features?.single;
      expect(nestedRaceFeature?.name, 'Breath Weapon');
      expect(nestedRaceFeature?.spellGrants, hasLength(1));
      expect(nestedRaceFeature?.spellGrants?.single.spell?.name,
          'Test Thaumaturgy');
      expect(nestedRaceFeature?.choiceSets, hasLength(1));
      expect(
        nestedRaceFeature?.choiceSets?.single.choiceOptions?.single.damageType,
        DamageType.fire,
      );

      final nestedSubrace = stepView.subraces!.single;
      expect(nestedSubrace.id, subrace.id);
      expect(nestedSubrace.features, hasLength(1));
      expect(nestedSubrace.features?.single.name, 'Chromatic Legacy');

      final aggregatedNames =
          stepView.features?.map((feature) => feature.name).toSet();
      expect(
        aggregatedNames,
        containsAll(<String?>['Breath Weapon', 'Chromatic Legacy']),
      );
    });

    test('rejects invalid race feature ownership', () async {
      final race = await endpoints.raceData.upsert(
        sessionBuilder,
        RaceData(name: 'Ownership Race'),
      );
      final subrace = await endpoints.subraceData.upsert(
        sessionBuilder,
        SubraceData(
          name: 'Ownership Subrace',
          parentRaceId: race.id!,
        ),
      );

      await expectLater(
        endpoints.raceFeature.upsert(
          sessionBuilder,
          RaceFeatureData(
            raceId: race.id,
            subraceId: subrace.id,
            name: 'Invalid Feature',
            level: 1,
          ),
        ),
        throwsA(
          predicate(
            (error) => error.toString().contains('exactly one owner'),
          ),
        ),
      );
    });

    test('rejects race choice sets without a feature owner', () async {
      await expectLater(
        endpoints.raceChoiceSetData.upsert(
          sessionBuilder,
          RaceChoiceSetData(
            featureId: 0,
            kind: RaceChoiceKind.languageChoice,
            pickCount: 1,
            mustBeDistinct: true,
          ),
        ),
        throwsA(
          predicate((error) => error.toString().contains('featureId')),
        ),
      );
    });

    test(
        'rejects race choice options whose payload does not match the choice kind',
        () async {
      final race = await endpoints.raceData.upsert(
        sessionBuilder,
        RaceData(name: 'Choice Race'),
      );
      final feature = await endpoints.raceFeature.upsert(
        sessionBuilder,
        RaceFeatureData(
          raceId: race.id,
          name: 'Choice Feature',
          level: 1,
        ),
      );
      final choiceSet = await endpoints.raceChoiceSetData.upsert(
        sessionBuilder,
        RaceChoiceSetData(
          featureId: feature.id!,
          kind: RaceChoiceKind.languageChoice,
          pickCount: 1,
          mustBeDistinct: true,
        ),
      );

      await expectLater(
        endpoints.raceChoiceOptionData.upsert(
          sessionBuilder,
          RaceChoiceOptionData(
            choiceSetId: choiceSet.id!,
            optionKey: 'bad_option',
            name: 'Bad Option',
            skill: Skill.arcana,
          ),
        ),
        throwsA(
          predicate((error) => error.toString().contains('require language')),
        ),
      );
    });

    test('rejects race feature spell grants without required references',
        () async {
      await expectLater(
        endpoints.raceFeatureSpellGrantData.upsert(
          sessionBuilder,
          RaceFeatureSpellGrantData(
            featureId: 0,
            spellId: 0,
          ),
        ),
        throwsA(
          predicate((error) => error.toString().contains('featureId')),
        ),
      );
    });
  });
}
