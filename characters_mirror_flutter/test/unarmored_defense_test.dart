import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/armor_class_calculator.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stat_settings_sheet.dart';
import 'package:flutter/material.dart';
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

  for (final ability in ['constitution', 'wisdom']) {
    testWidgets('missing class step retains $ability defense and AC details',
        (tester) async {
      final snapshot = await resolve(ArmorClassCase('snapshot', 15,
          defenses: [ability], constitution: 16, wisdom: 16));
      final emptyCache = OfflineCacheDatabase.openInMemory();
      addTearDown(emptyCache.close);
      final offline = await resolveOfflineCharacter(emptyCache, snapshot);
      expect(offline.derived?.armorClass, snapshot.derived?.armorClass);
      expect(offline.derived?.armorClassFormula,
          snapshot.derived?.armorClassFormula);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TextButton(
            onPressed: () => showArmorClassSettingsSheet(
              context: tester.element(find.byType(TextButton)),
              character: offline,
              onSave: (_) async {},
            ),
            child: const Text('AC'),
          ),
        ),
      ));
      await tester.tap(find.text('AC'));
      await tester.pumpAndSettle();
      expect(find.text('Итоговая КД: 15'), findsOneWidget);
      expect(find.text('Источник: Защита без доспехов'), findsOneWidget);
      expect(find.text('Расчёт: ${snapshot.derived?.armorClassFormula}'),
          findsOneWidget);
    });
  }

  test('missing class step reevaluates snapshot conditions and ability scores',
      () async {
    final snapshot = await resolve(
        const ArmorClassCase('snapshot', 15, defenses: ['wisdom'], wisdom: 16));
    final emptyCache = OfflineCacheDatabase.openInMemory();
    addTearDown(emptyCache.close);
    await emptyCache.putReferenceList(
        'armor', offlineAllKey, catalog, (armor) => armor.toJson());
    final changed = snapshot.copyWith(
      baseAbilityScores: {'dexterity': 18, 'wisdom': 20},
      classEntries: [snapshot.classEntries!.single.copyWith(level: 2)],
      customArmorClassBonus: 1,
    );
    final offline = await resolveOfflineCharacter(emptyCache, changed);
    expect(offline.derived?.armorClass, 20);
    expect(offline.derived?.armorClassFormula,
        '10 + Ловкость (4) + Мудрость (5) + Бонус (1)');
    final shielded = await resolveOfflineCharacter(
        emptyCache,
        changed.copyWith(
            equippedShield: CharacterEquipmentSelectionData(
                referenceKey: 'shield', name: 'Shield')));
    expect(shielded.derived?.armorClass, 17);
    final armored = await resolveOfflineCharacter(
        emptyCache,
        changed.copyWith(
            equippedArmor: CharacterEquipmentSelectionData(
                referenceKey: 'plate', name: 'Plate')));
    expect(armored.derived?.armorClass, 19);
    final removedClass = await resolveOfflineCharacter(
        emptyCache, changed.copyWith(classEntries: []));
    expect(removedClass.derived?.armorClass, 15);
  });

  test('cached current class step supersedes snapshot formula modifiers',
      () async {
    final snapshot = await resolve(const ArmorClassCase('snapshot', 15));
    final data = classes['constitution']!;
    await cache.putReference(
        offlineClassStepKind,
        offlineClassStepKey(data.id!),
        ClassStepView(
            classData: data,
            selectedLevel: 1,
            currentLevelFeatures: [],
            featureModifiers: []),
        (view) => view.toJson());
    final offline = await resolveOfflineCharacter(cache, snapshot);
    expect(offline.derived?.armorClass, 12);
    expect(offline.derived?.featureModifiers, isEmpty);
  });

  test('older cached step without modifier metadata retains snapshot formula',
      () async {
    final snapshot = await resolve(const ArmorClassCase('snapshot', 15));
    await cache.putReference(
        offlineClassStepKind,
        offlineClassStepKey(classes['constitution']!.id!),
        ClassStepView(currentLevelFeatures: [features.first]),
        (view) => view.toJson());
    final offline = await resolveOfflineCharacter(cache, snapshot);
    expect(offline.derived?.armorClass, 15);
    expect(offline.derived?.armorClassFormula,
        snapshot.derived?.armorClassFormula);
  });

  test('snapshot subclass formula requires its subclass and feature level',
      () async {
    final data = classes['constitution']!;
    final subclass =
        SubclassData(id: 301, parentClassId: data.id!, levelRequired: 2);
    final feature = SubclassFeatureData(
        id: 302,
        parentSubclassId: subclass.id!,
        level: 3,
        name: 'Fixture defense');
    final character = CharacterData(
      baseAbilityScores: {'dexterity': 14, 'wisdom': 16},
      classEntries: [
        CharacterClassEntryData(classData: data, subclass: subclass, level: 3)
      ],
      derived: CharacterDerivedData(featureModifiers: [
        FeatureModifierData(
          referenceKey: 'subclass.ac',
          subclassFeatureId: feature.id,
          subclassFeature: feature,
          target: FeatureModifierTarget.armorClass,
          operation: FeatureModifierOperation.baseArmorClass,
          value: FeatureModifierValueData(
              kind: FeatureModifierValueKind.staticValue,
              staticValue: 10,
              abilityModifiers: [Ability.dexterity, Ability.wisdom]),
        )
      ]),
    );
    expect(
        (await resolveOfflineCharacter(cache, character)).derived?.armorClass,
        15);
    for (final entry in [
      character.classEntries!.single.copyWith(level: 2),
      character.classEntries!.single.copyWith(subclass: null),
      character.classEntries!.single
          .copyWith(subclass: subclass.copyWith(id: 303)),
    ]) {
      expect(
          (await resolveOfflineCharacter(
                  cache, character.copyWith(classEntries: [entry])))
              .derived
              ?.armorClass,
          12);
    }
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
