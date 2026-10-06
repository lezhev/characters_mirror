import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/armor_class_calculator.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_fixtures/armor_class_contract.dart';

void main() {
  final classes = <String, ClassData>{};
  final features = <ClassFeatureData>[];
  final modifiers = <FeatureModifierData>[];
  for (final ability in ['constitution', 'wisdom']) {
    final data = ClassData(
        id: ability == 'constitution' ? 201 : 202,
        referenceKey: 'fixture_$ability',
        name: 'Arbitrary $ability source',
        hitDieValue: 8);

    classes[ability] = data;
    final feature = ClassFeatureData(
        id: ability == 'constitution' ? 211 : 212,
        parentClassId: data.id!,
        referenceKey: 'fixture_defense_$ability',
        name: 'Защита без доспехов',
        level: 1);

    features.add(feature);
    final modifier = FeatureModifierData(
        referenceKey: 'fixture_defense_$ability.ac',
        classFeatureId: feature.id!,
        target: FeatureModifierTarget.armorClass,
        operation: FeatureModifierOperation.baseArmorClass,
        value: FeatureModifierValueData(
            kind: FeatureModifierValueKind.staticValue,
            staticValue: 10,
            abilityModifiers: [
              Ability.dexterity,
              Ability.values.byName(ability)
            ]),
        conditions: [
          FeatureModifierConditionData(
              type: FeatureModifierConditionType.unarmored),
          if (ability == 'wisdom')
            FeatureModifierConditionData(
                type: FeatureModifierConditionType.noShield)
        ]);

    modifiers.add(modifier);
  }
  final bonusFeature = ClassFeatureData(
      id: 213,
      parentClassId: classes['constitution']!.id!,
      referenceKey: 'fixture_bonus',
      name: 'Fixture bonus',
      level: 1);

  features.add(bonusFeature);
  final catalog = [
    ArmorData(
        referenceKey: 'leather',
        name: 'Leather',
        categoryValue: ArmorCategory.light,
        baseAC: 11,
        dexBonus: true),
    ArmorData(
        referenceKey: 'plate',
        name: 'Plate',
        categoryValue: ArmorCategory.heavy,
        baseAC: 18,
        dexBonus: false),
    ArmorData(
        referenceKey: 'shield',
        name: 'Shield',
        categoryValue: ArmorCategory.shield,
        bonusAC: 2),
  ];

  late OfflineCacheDatabase cache;
  setUp(() async {
    cache = OfflineCacheDatabase.openInMemory();
    await cache.putReferenceList(
        'armor', offlineAllKey, catalog, (armor) => armor.toJson());
  });
  tearDown(() => cache.close());

  Future<CharacterData> resolve(ArmorClassCase scenario) async {
    for (final ability in scenario.defenses) {
      final data = classes[ability]!;
      await cache.putReference(
          offlineClassStepKind,
          offlineClassStepKey(data.id!, selectedLevel: scenario.level),
          ClassStepView(
              classData: data,
              selectedLevel: scenario.level,
              currentLevelFeatures: features
                  .where((feature) => feature.parentClassId == data.id)
                  .toList(),
              featureModifiers: [
                ...modifiers.where((modifier) =>
                    modifier.classFeatureId ==
                    features
                        .firstWhere(
                            (feature) => feature.parentClassId == data.id)
                        .id),
                if (ability == 'constitution' && scenario.featureBonus != 0)
                  FeatureModifierData(
                      referenceKey: 'fixture_bonus.ac',
                      classFeatureId: bonusFeature.id,
                      target: FeatureModifierTarget.armorClass,
                      operation: FeatureModifierOperation.add,
                      value: FeatureModifierValueData(
                          kind: FeatureModifierValueKind.staticValue,
                          staticValue: scenario.featureBonus)),
              ]),
          (view) => view.toJson());
    }
    return resolveOfflineCharacter(
        cache,
        CharacterData(
          name: scenario.name,
          baseAbilityScores: scenario.scores,
          classEntries: [
            for (final ability in scenario.defenses)
              CharacterClassEntryData(
                  classData: classes[ability],
                  level: scenario.level,
                  isStartingClass: ability == scenario.defenses.first,
                  classOrder: scenario.defenses.indexOf(ability))
          ],
          equippedArmor: scenario.armor == null
              ? null
              : CharacterEquipmentSelectionData(
                  referenceKey: scenario.armor, name: scenario.armor!),
          equippedShield: !scenario.shield
              ? null
              : CharacterEquipmentSelectionData(
                  referenceKey: 'shield', name: 'Shield'),
          customArmorClassBonus:
              scenario.customBonus == 0 ? null : scenario.customBonus,
          equipment: [
            CharacterInventoryItemData(
                name: 'Plate armor in inventory', quantity: 1)
          ],
        ));
  }

  for (final scenario in armorClassCases) {
    test(scenario.name, () async {
      final offline = await resolve(scenario);
      expect(offline.derived?.armorClass, scenario.expected);
      final snapshot = CharacterData.fromJson(offline.toJson());
      final local = recalculateArmorClassFromCatalog(snapshot, catalog);
      expect(local.derived?.armorClass, offline.derived?.armorClass);
      expect(
          local.derived?.armorClassSource, offline.derived?.armorClassSource);
      expect(
          local.derived?.armorClassFormula, offline.derived?.armorClassFormula);
    });
  }

  test('local snapshot reevaluates equipment conditions after removal',
      () async {
    final armored =
        await resolve(const ArmorClassCase('armored', 18, armor: 'plate'));
    expect(
        recalculateArmorClassFromCatalog(
                armored.copyWith(equippedArmor: null), catalog)
            .derived
            ?.armorClass,
        15);
    final shielded = await resolve(const ArmorClassCase('shielded monk', 15,
        dexterity: 16, wisdom: 20, defenses: ['wisdom'], shield: true));
    expect(
        recalculateArmorClassFromCatalog(
                shielded.copyWith(equippedShield: null), catalog)
            .derived
            ?.armorClass,
        18);
  });

  final snapshotsPath = Platform.environment['ARMOR_CLASS_SERVER_SNAPSHOTS'];
  test('actual server snapshots resolve identically offline and without cache',
      () async {
    final lines = await File(snapshotsPath!).readAsLines();
    expect(lines.length, armorClassCases.length);
    for (final line in lines) {
      final row = jsonDecode(line) as Map<String, dynamic>;
      final server = CharacterData.fromJson(row['character']);
      final armor = (row['armor'] as List)
          .map((json) => ArmorData.fromJson(json))
          .toList();
      await cache.putReferenceList(
          'armor', offlineAllKey, armor, (item) => item.toJson());
      for (final json in row['views'] as List) {
        final view = ClassStepView.fromJson(json);
        await cache.putReference(
            offlineClassStepKind,
            offlineClassStepKey(view.classData!.id!,
                selectedLevel: view.selectedLevel!),
            view,
            (item) => item.toJson());
      }
      final offline = await resolveOfflineCharacter(cache, server);
      final local = recalculateArmorClassFromCatalog(server, armor);
      for (final actual in [offline, local]) {
        expect(actual.derived?.armorClass, server.derived?.armorClass,
            reason: server.name);
        expect(
            actual.derived?.armorClassSource, server.derived?.armorClassSource,
            reason: server.name);
        expect(actual.derived?.armorClassFormula,
            server.derived?.armorClassFormula,
            reason: server.name);
      }
    }
  },
      skip: snapshotsPath == null
          ? 'Set ARMOR_CLASS_SERVER_SNAPSHOTS to an integration snapshot export.'
          : false);
}
