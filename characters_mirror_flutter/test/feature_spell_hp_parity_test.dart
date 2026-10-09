import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character_spells/character_spell_projection.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/utils/calculate_max_hp_for_character.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as shared;
import 'package:flutter_test/flutter_test.dart';
import '../../test_fixtures/spell_feature_contract.dart';

void main() {
  late OfflineCacheDatabase cache;
  setUp(() => cache = OfflineCacheDatabase.openInMemory());
  tearDown(() => cache.close());

  Future<void> cacheView(ClassStepView view, {int? subclassId}) =>
      cache.putReference(
          offlineClassStepKind,
          offlineClassStepKey(view.classData!.id!,
              selectedLevel: view.selectedLevel!,
              selectedSubclassId: subclassId),
          view,
          (v) => v.toJson());

  final sorcerer =
      ClassData(id: 8401, referenceKey: 'hp_fixture_sorcerer', hitDieValue: 6);
  final fighter =
      ClassData(id: 8402, referenceKey: 'hp_fixture_fighter', hitDieValue: 10);
  final sub =
      SubclassData(id: 8403, parentClassId: sorcerer.id!, levelRequired: 1);
  final feature = SubclassFeatureData(
      id: 8404,
      parentSubclassId: sub.id!,
      level: 1,
      referenceKey: 'hp_fixture_draconic');
  final modifiers = [
    FeatureModifierData(
        referenceKey: 'hp_fixture.maximum',
        subclassFeatureId: feature.id,
        target: FeatureModifierTarget.hitPointMaximum,
        operation: FeatureModifierOperation.add,
        value: FeatureModifierValueData(
            kind: FeatureModifierValueKind.classLevelProgression,
            progression: {
              for (var level = 1; level <= 20; level++) level: level
            })),
    FeatureModifierData(
        referenceKey: 'hp_fixture.ac',
        subclassFeatureId: feature.id,
        target: FeatureModifierTarget.armorClass,
        operation: FeatureModifierOperation.baseArmorClass,
        value: FeatureModifierValueData(
            kind: FeatureModifierValueKind.staticValue,
            staticValue: 13,
            abilityModifiers: [Ability.dexterity]),
        conditions: [
          FeatureModifierConditionData(
              type: FeatureModifierConditionType.unarmored)
        ]),
  ];

  test(
      'offline source HP, level-down clamp, manual bonuses and sheet recalculation',
      () async {
    for (final level in [1, 2, 3]) {
      await cacheView(
          ClassStepView(
              classData: sorcerer,
              selectedLevel: level,
              currentSubclassFeatures: [feature],
              featureModifiers: modifiers),
          subclassId: sub.id);
      await cacheView(ClassStepView(classData: sorcerer, selectedLevel: level));
    }
    await cacheView(ClassStepView(classData: fighter, selectedLevel: 2));
    CharacterData character(int level,
            {bool multiclass = false, bool active = true, int? currentHp}) =>
        CharacterData(
            baseAbilityScores: {'constitution': 8, 'dexterity': 14},
            currentHp: currentHp,
            classEntries: [
              CharacterClassEntryData(
                  id: 'entry',
                  classData: sorcerer,
                  subclass: active ? sub : null,
                  level: level,
                  isStartingClass: true,
                  hpRolledValues: [6, 4, 1].take(level).toList()),
              if (multiclass)
                CharacterClassEntryData(
                    id: 'other',
                    classData: fighter,
                    level: 2,
                    classOrder: 1,
                    isStartingClass: false,
                    hpRolledValues: [4, 4])
            ]);
    expect(
        (await resolveOfflineCharacter(cache, character(1))).derived!.maxHp, 6);
    final before = await resolveOfflineCharacter(
        cache, character(3, multiclass: true, currentHp: 17));
    final after = await resolveOfflineCharacter(
        cache, character(2, multiclass: true, currentHp: 17));
    expect(before.derived!.maxHp, 17);
    expect(after.derived!.maxHp, 16);
    expect(after.currentHp, 16);
    expect(
        (await resolveOfflineCharacter(
                cache, character(2, multiclass: true, currentHp: 3)))
            .currentHp,
        3);
    expect(after.derived!.armorClass, 15);
    final properties = after.derived!.activeFeatures!.single.displayProperties!;
    expect(
        properties.singleWhere((p) => p.label == 'Максимум хитов').value, '+2');
    expect(properties.singleWhere((p) => p.label == 'КД без доспехов').value,
        '13 + Ловкость (2) = 15');
    expect(calculateMaxHpForCharacter(before), 17);
    expect(calculateMaxHpForCharacter(after), 16);
    expect(calculateMaxHpForCharacter(before, classEntries: after.classEntries),
        16);
    final manual = await resolveOfflineCharacter(
        cache, before.copyWith(hpFlatBonus: 7, hpPerLevelBonus: 2));
    expect(manual.derived!.maxHp, 17 + 7 + 5 * 2);
    expect(calculateMaxHpForCharacter(manual), manual.derived!.maxHp);
    expect(manual.hpFlatBonus, 7);
    expect(manual.hpPerLevelBonus, 2);
    final manualDown = await resolveOfflineCharacter(
        cache, manual.copyWith(classEntries: after.classEntries));
    expect(manualDown.derived!.maxHp, 16 + 7 + 4 * 2);
    expect(manualDown.hpFlatBonus, 7);
    expect(manualDown.hpPerLevelBonus, 2);
    expect(calculateMaxHpForCharacter(manualDown), manualDown.derived!.maxHp);
    final capped = await resolveOfflineCharacter(
        cache, before.copyWith(hpFlatBonus: -100));
    expect(capped.derived!.maxHp, 4);
    expect(calculateMaxHpForCharacter(capped), 4);
    expect(
        (await resolveOfflineCharacter(
                cache, character(3, multiclass: true, active: false)))
            .derived!
            .maxHp,
        14);
  });

  test(
      'offline Life data flows to the ordinary card and upcast contexts without HP mutation',
      () async {
    final cleric = ClassData(
        id: 8501, referenceKey: 'life_fixture_cleric', hitDieValue: 8);
    final lifeSub =
        SubclassData(id: 8502, parentClassId: cleric.id!, levelRequired: 1);
    final lifeFeature = SubclassFeatureData(
        id: 8503,
        parentSubclassId: lifeSub.id!,
        referenceKey: 'life_fixture',
        level: 1);
    await cacheView(
        ClassStepView(
            classData: cleric,
            selectedLevel: 3,
            currentSubclassFeatures: [
              lifeFeature
            ],
            featureModifiers: [
              FeatureModifierData(
                  referenceKey: 'life_fixture.healing',
                  subclassFeatureId: lifeFeature.id,
                  target: FeatureModifierTarget.spellHealing,
                  operation: FeatureModifierOperation.add,
                  minimumCastLevel: 1,
                  value: FeatureModifierValueData(
                      kind: FeatureModifierValueKind.castLevel,
                      staticValue: 2)),
            ]),
        subclassId: lifeSub.id);
    await cacheView(ClassStepView(classData: cleric, selectedLevel: 3));
    final character = await resolveOfflineCharacter(
        cache,
        CharacterData(currentHp: 2, baseAbilityScores: {
          'wisdom': 18
        }, classEntries: [
          CharacterClassEntryData(
              classData: cleric,
              subclass: lifeSub,
              level: 3,
              isStartingClass: true)
        ]));
    expect(spellFeatureContractValues(character.toJson()),
        lifeSpellFeatureExpected);
    final source = shared.SpellSourceContext(
        sourceKey: 'class:${cleric.id}',
        label: 'Fixture',
        castingAbility: 'wisdom');
    final context =
        characterSpellPresentationContext(character, source, castLevel: 3);
    final p = const shared.SpellPresentationResolver().resolve({
      'referenceKey': 'cure_wounds',
      'level': 1,
      'isHealing': true,
      'healingDice': '1d8',
      'healingAddsCastingModifier': true,
      'healingScaling': {
        'mode': 'slotLevel',
        'scalingBySlotLevel': {'3': '3d8'}
      },
    }, context: context);
    expect(p.highlights.single.value, '3к8 + 5 + 4');
    expect(character.currentHp, 2);
    final noLife = await resolveOfflineCharacter(
        cache,
        character.copyWith(classEntries: [
          character.classEntries!.single.copyWith(subclass: null)
        ]));
    expect(spellFeatureContractValues(noLife.toJson())['cure_wounds:1'],
        '1к8 + 4');
  });

  final serverSnapshots =
      Platform.environment['FEATURE_MODIFIER_SERVER_SNAPSHOTS'];
  if (serverSnapshots != null) {
    test(
        'real server snapshots match offline HP, AC, spells and feature presentation',
        () async {
      final rows = await File(serverSnapshots).readAsLines();
      expect(rows, isNotEmpty);
      for (final line in rows.where((line) => line.isNotEmpty)) {
        final snapshot = jsonDecode(line) as Map<String, dynamic>;
        final server = CharacterData.fromJson(snapshot['character']);
        for (final row in snapshot['views']) {
          final view = ClassStepView.fromJson(row);
          final entry = server.classEntries!
              .firstWhere((e) => e.classData!.id == view.classData!.id);
          await cacheView(view, subclassId: entry.subclass?.id);
        }
        final offline = await resolveOfflineCharacter(
            cache, server.copyWith(derived: null));
        expect(offline.derived!.maxHp, server.derived!.maxHp,
            reason: snapshot['label']);
        expect(calculateMaxHpForCharacter(offline), server.derived!.maxHp,
            reason: snapshot['label']);
        expect(offline.derived!.armorClass, server.derived!.armorClass,
            reason: snapshot['label']);
        expect(offline.currentHp, server.currentHp ?? server.derived!.maxHp,
            reason: snapshot['label']);
        expect(spellFeatureContractValues(offline.toJson()),
            snapshot['spellValues'],
            reason: snapshot['label']);
        for (final feature
            in server.derived!.activeFeatures ?? <CharacterFeatureViewData>[]) {
          final local = offline.derived!.activeFeatures!.firstWhere((f) =>
              f.sourceType == feature.sourceType &&
              f.sourceId == feature.sourceId);
          expect(local.displayProperties?.map((p) => p.toJson()).toList(),
              feature.displayProperties?.map((p) => p.toJson()).toList(),
              reason: snapshot['label']);
          expect(local.resources?.map((r) => r.toJson()).toList(),
              feature.resources?.map((r) => r.toJson()).toList(),
              reason: snapshot['label']);
        }
      }
    });
  }
}
