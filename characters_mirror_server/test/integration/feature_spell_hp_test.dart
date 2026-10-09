import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import '../../../test_fixtures/spell_feature_contract.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Spell and HP feature modifiers', (sessions, endpoints) {
    final owner = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(986, <Scope>{}));
    setUp(CharacterSaveRateLimiter.resetForTests);

    Future<(ClassData, SubclassData, SubclassFeatureData)> source(
        String key) async {
      final session = owner.build();
      try {
        final features = await SubclassFeatureData.db
            .find(session, where: (t) => t.referenceKey.equals(key));
        expect(features, hasLength(1));
        final sub = (await SubclassData.db
            .findById(session, features.single.parentSubclassId))!;
        final data = (await ClassData.db.findById(session, sub.parentClassId))!;
        return (data, sub, features.single);
      } finally {
        await session.close();
      }
    }

    Future<void> export(CharacterData character, String label) async {
      final path = Platform.environment['FEATURE_MODIFIER_SERVER_SNAPSHOTS'];
      if (path == null) return;
      final views = <ClassStepView>[];
      for (final entry in character.classEntries!) {
        views.add(await endpoints.classData.getStepView(
            owner, entry.classData!.id!,
            selectedLevel: entry.level!,
            selectedSubclassId: entry.subclass?.id,
            isStartingClass: entry.isStartingClass == true));
      }
      await File(path).writeAsString(
          '${jsonEncode({
                'label': label,
                'character': character.toJson(),
                'views': views.map((v) => v.toJson()).toList(),
                'spellValues': spellFeatureContractValues(character.toJson()),
              })}\n',
          mode: FileMode.append);
    }

    test(
        'Life reference data drives base/upcast presentation without HP mutation',
        () async {
      final (data, sub, feature) = await source('cleric_life_disciple_of_life');
      final character = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(
            name: 'Life fixture',
            currentHp: 2,
            baseAbilityScores: {'wisdom': 18},
            classEntries: [
              CharacterClassEntryData(
                  id: 'entry',
                  classData: data,
                  subclass: sub,
                  level: 3,
                  isStartingClass: true)
            ],
          ));
      final modifiers = character.derived!.featureModifiers!
          .where((m) => m.subclassFeatureId == feature.id)
          .toList();
      final healing = modifiers.single;
      expect(healing.target, FeatureModifierTarget.spellHealing);
      expect(healing.value.kind, FeatureModifierValueKind.castLevel);
      expect(healing.value.staticValue, 2);
      expect(healing.spellKey, isNull);
      expect(healing.minimumCastLevel, 1);
      final active = character.derived!.activeFeatures!.firstWhere((f) =>
          f.sourceType == CharacterFeatureSourceType.subclassFeature &&
          f.sourceId == feature.id);
      expect(active.displayProperties!.single.label, 'Дополнительное лечение');
      expect(active.displayProperties!.single.value,
          'Уровень ячейки + 2 (от 1-го уровня)');
      expect(active.shortDescription, isNot(contains('2 +')));
      expect(spellFeatureContractValues(character.toJson()),
          lifeSpellFeatureExpected);
      expect(character.currentHp, 2);
      expect(
          (await endpoints.characterData.getCharacter(owner, character.id!))
              .currentHp,
          2);
      await export(character, 'Life');

      CharacterSaveRateLimiter.resetForTests();
      final ordinary = await endpoints.characterData.saveCharacter(
          owner,
          character.copyWith(id: null, classEntries: [
            character.classEntries!.single.copyWith(subclass: null)
          ]));
      final values = spellFeatureContractValues(ordinary.toJson());
      expect(values['cure_wounds:1'], '1к8 + 4');
      expect(values['cure_wounds:3'], '3к8 + 4');
      await export(ordinary, 'No Life');
    });

    test(
        'Draconic uses source levels, preserves manual HP and AC, and clamps level-down',
        () async {
      final (data, sub, feature) =
          await source('sorcerer_draconic_bloodline_draconic_resilience');
      final session = owner.build();
      late ClassData fighter;
      try {
        fighter = await ClassData.db.insertRow(
            session,
            ClassData(
                referenceKey: 'hp_context_other_fixture',
                name: 'Other class',
                hitDieValue: 10));
      } finally {
        await session.close();
      }

      for (final level in [1, 3]) {
        CharacterSaveRateLimiter.resetForTests();
        final character = await endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
              name: 'Draconic fixture',
              baseAbilityScores: {'constitution': 8, 'dexterity': 14},
              classEntries: [
                CharacterClassEntryData(
                    id: 'entry',
                    classData: data,
                    subclass: sub,
                    level: level,
                    isStartingClass: true,
                    hpRolledValues: [6, 4, 1].take(level).toList())
              ],
            ));
        expect(character.derived!.maxHp, level == 1 ? 6 : 11);
        expect(character.derived!.armorClass, 15);
        final properties = character.derived!.activeFeatures!
            .firstWhere((f) =>
                f.sourceType == CharacterFeatureSourceType.subclassFeature &&
                f.sourceId == feature.id)
            .displayProperties!;
        expect(properties.singleWhere((p) => p.label == 'Максимум хитов').value,
            '+$level');
        expect(
            properties.singleWhere((p) => p.label == 'КД без доспехов').value,
            '13 + Ловкость (2) = 15');
        await export(character, 'Draconic $level');
      }
      for (final lowHp in [false, true]) {
        CharacterSaveRateLimiter.resetForTests();
        final before = await endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
              name: 'Draconic multiclass',
              currentHp: lowHp ? 3 : 17,
              baseAbilityScores: {'constitution': 8, 'dexterity': 14},
              classEntries: [
                CharacterClassEntryData(
                    id: 'entry',
                    classData: data,
                    subclass: sub,
                    level: 3,
                    classOrder: 0,
                    isStartingClass: true,
                    hpRolledValues: [6, 4, 1]),
                CharacterClassEntryData(
                    id: 'other',
                    classData: fighter,
                    level: 2,
                    classOrder: 1,
                    isStartingClass: false,
                    hpRolledValues: [4, 4]),
              ],
            ));
        expect(before.derived!.maxHp, 17);
        final request = LevelDownRequest(
            characterId: before.id!,
            classEntryId: 'entry',
            expectedVersion: before.version!);
        final preview =
            await endpoints.characterData.previewLevelDown(owner, request);
        expect(preview.newMaxHp,
            16); // Normal third-level HP is zero; only the modifier decreases.
        expect(preview.character.currentHp, lowHp ? 3 : 16);
        final after =
            await endpoints.characterData.applyLevelDown(owner, request);
        expect(after.derived!.maxHp, 16);
        expect(after.currentHp, lowHp ? 3 : 16);
        expect(after.derived!.armorClass, 15);
        await export(before, 'Multiclass before $lowHp');
        await export(after, 'Multiclass after $lowHp');

        CharacterSaveRateLimiter.resetForTests();
        final manual = await endpoints.characterData.saveCharacter(
            owner, after.copyWith(hpFlatBonus: 7, hpPerLevelBonus: 2));
        expect(manual.derived!.maxHp, 16 + 7 + 4 * 2);
        expect(manual.hpFlatBonus, 7);
        expect(manual.hpPerLevelBonus, 2);
        await export(manual, 'Manual HP $lowHp');
        final manualDown = await endpoints.characterData.applyLevelDown(
            owner,
            LevelDownRequest(
                characterId: manual.id!,
                classEntryId: 'entry',
                expectedVersion: manual.version!));
        expect(manualDown.derived!.maxHp, 25);
        expect(manualDown.hpFlatBonus, 7);
        expect(manualDown.hpPerLevelBonus, 2);
        expect(manualDown.currentHp, lowHp ? 3 : 16);
        await export(manualDown, 'Manual HP level-down $lowHp');
        CharacterSaveRateLimiter.resetForTests();
        final noFeature = await endpoints.characterData.saveCharacter(
            owner,
            manualDown.copyWith(classEntries: [
              for (final entry in manualDown.classEntries!)
                entry.id == 'entry' ? entry.copyWith(subclass: null) : entry
            ]));
        expect(noFeature.derived!.maxHp, manualDown.derived!.maxHp! - 1);
        await export(noFeature, 'Removed source $lowHp');
      }
    });

    test(
        'Wrath reference display formula is canonical and resource semantics remain intact',
        () async {
      final (data, sub, feature) =
          await source('cleric_tempest_wrath_of_the_storm');
      final session = owner.build();
      try {
        final properties = await FeatureDisplayPropertyData.db.find(session,
            where: (t) => t.sourceSubclassFeatureId.equals(feature.id));
        expect(properties.single.key, 'damage');
        expect(properties.single.label, 'Урон');
        expect(properties.single.valueKind,
            FeatureDisplayPropertyValueKind.formula);
        expect(properties.single.formula, '2d8');
        expect(feature.shortDescription, isNot(contains('2к8')));
        final resources = await FeatureResourceDefinitionData.db.find(session,
            where: (t) => t.subclassFeatureId.equals(feature.id));
        expect(resources.single.key, 'wrathOfTheStorm');
        expect(resources.single.maxRule,
            FeatureResourceMaxRule.abilityModifierMinOne);
        expect(resources.single.resetOn, RestType.longRest);
      } finally {
        await session.close();
      }
      final character = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(name: 'Wrath fixture', baseAbilityScores: {
            'wisdom': 18
          }, classEntries: [
            CharacterClassEntryData(
                id: 'entry',
                classData: data,
                subclass: sub,
                level: 1,
                isStartingClass: true),
          ]));
      final active = character.derived!.activeFeatures!.firstWhere((f) =>
          f.sourceType == CharacterFeatureSourceType.subclassFeature &&
          f.sourceId == feature.id);
      expect(active.displayProperties!.single.value, '2к8');
      expect(active.resources!.single.max, 4);
      await export(character, 'Wrath');
    });
  });
}
