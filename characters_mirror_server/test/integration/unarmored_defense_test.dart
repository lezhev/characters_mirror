import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import '../../../test_fixtures/armor_class_contract.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Data-driven armor class', (sessions, endpoints) {
    final owner = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(978, <Scope>{}));
    final admin = sessions.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(979, {Scope('admin')}));

    test(
        'reference import retains ability terms and validates formula metadata',
        () async {
      final session = admin.build();
      try {
        final data = await ClassData.db.insertRow(session,
            ClassData(referenceKey: 'formula_import_class', name: 'Fixture'));
        final feature = await ClassFeatureData.db.insertRow(
            session,
            ClassFeatureData(
                parentClassId: data.id!,
                referenceKey: 'formula_import_feature',
                level: 1));
        Map<String, dynamic> modifier(
                {Object abilities = const ['dexterity', 'constitution'],
                String target = 'armorClass'}) =>
            {
              'referenceKey': 'formula_import.ac',
              'sourceFeatureKey': feature.referenceKey,
              'target': target,
              'operation': 'baseArmorClass',
              'value': {
                'kind': 'staticValue',
                'staticValue': 10,
                'abilityModifiers': abilities
              },
              'conditions': [
                {'type': 'unarmored'}
              ],
            };
        expect(
            await endpoints.admin.importFeatureModifiers(
                admin,
                jsonEncode({
                  'modifiers': [modifier()]
                })),
            1);
        final rows = await FeatureModifierData.db
            .find(session, where: (t) => t.classFeatureId.equals(feature.id));
        expect(rows.single.value.abilityModifiers,
            [Ability.dexterity, Ability.constitution]);
        for (final invalid in [
          modifier(abilities: ['unknown']),
          modifier(abilities: 'dexterity'),
          modifier(target: 'speed')
        ]) {
          await expectLater(
              endpoints.admin.importFeatureModifiers(
                  admin,
                  jsonEncode({
                    'modifiers': [invalid]
                  })),
              throwsArgumentError);
        }
      } finally {
        await session.close();
      }
    });
    test('PHB cases and exportable server/offline snapshots', () async {
      final session = owner.build();
      try {
        final classes = <String, ClassData>{};
        final features = <ClassFeatureData>[];
        final modifiers = <FeatureModifierData>[];
        for (final ability in ['constitution', 'wisdom']) {
          var data = ClassData(
              referenceKey: 'fixture_$ability',
              name: 'Arbitrary $ability source',
              hitDieValue: 8);
          data = await ClassData.db.insertRow(session, data);
          classes[ability] = data;
          var feature = ClassFeatureData(
              parentClassId: data.id!,
              referenceKey: 'fixture_defense_$ability',
              name: 'Защита без доспехов',
              level: 1);
          feature = await ClassFeatureData.db.insertRow(session, feature);
          features.add(feature);
          var modifier = FeatureModifierData(
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
          modifier = await FeatureModifierData.db.insertRow(session, modifier);
          modifiers.add(modifier);
        }
        var bonusFeature = ClassFeatureData(
            parentClassId: classes['constitution']!.id!,
            referenceKey: 'fixture_bonus',
            name: 'Fixture bonus',
            level: 1);
        bonusFeature =
            await ClassFeatureData.db.insertRow(session, bonusFeature);
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
        await ArmorData.db.insert(session, catalog);

        for (final scenario in armorClassCases) {
          CharacterSaveRateLimiter.resetForTests();
          final existingBonus = await FeatureModifierData.db.find(session,
              where: (t) => t.referenceKey.equals('fixture_bonus.ac'));
          if (existingBonus.isNotEmpty) {
            await FeatureModifierData.db
                .deleteRow(session, existingBonus.single);
          }
          if (scenario.featureBonus != 0) {
            await FeatureModifierData.db.insertRow(
                session,
                FeatureModifierData(
                    referenceKey: 'fixture_bonus.ac',
                    classFeatureId: bonusFeature.id,
                    target: FeatureModifierTarget.armorClass,
                    operation: FeatureModifierOperation.add,
                    value: FeatureModifierValueData(
                        kind: FeatureModifierValueKind.staticValue,
                        staticValue: scenario.featureBonus)));
          }
          final saved = await endpoints.characterData.saveCharacter(
              owner,
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
          final reloaded =
              await endpoints.characterData.getCharacter(owner, saved.id!);
          expect(reloaded.derived?.armorClass, scenario.expected,
              reason: scenario.name);
          final snapshotPath =
              Platform.environment['ARMOR_CLASS_SERVER_SNAPSHOTS'];
          if (snapshotPath != null) {
            final views = [
              for (final ability in scenario.defenses)
                await endpoints.classData.getStepView(
                    owner, classes[ability]!.id!,
                    isStartingClass: ability == scenario.defenses.first,
                    selectedLevel: scenario.level)
            ];
            await File(snapshotPath).writeAsString(
                '${jsonEncode({
                      'character': reloaded.toJson(),
                      'armor': catalog.map((armor) => armor.toJson()).toList(),
                      'views': views.map((view) => view.toJson()).toList()
                    })}\n',
                mode: FileMode.append);
          }
        }
      } finally {
        await session.close();
      }
    });

    test(
        'reference migration uses stable keys, preserves copy and is repeatable',
        () async {
      final session = owner.build();
      try {
        final originals = <ClassFeatureData>[];
        for (final pair in [
          ('barbarian', 'constitution'),
          ('monk', 'wisdom')
        ]) {
          final data = await ClassData.db.insertRow(session,
              ClassData(referenceKey: pair.$1, name: 'Arbitrary name'));
          originals.add(await ClassFeatureData.db.insertRow(
              session,
              ClassFeatureData(
                  parentClassId: data.id!,
                  referenceKey: '${pair.$1}_unarmored_defense',
                  name: 'Защита без доспехов',
                  description: 'Сохранить описание без изменений.',
                  level: 2)));
        }
        final sql = (await File(
                    'migrations/20261006200000000-unarmored-defense-formulas/migration.sql')
                .readAsString())
            .split('-- MIGRATION VERSION')[0]
            .replaceFirst('BEGIN;', '');
        for (var run = 0; run < 2; run++) {
          // Execute data statements inside the test's rollback transaction.
          for (final statement in sql.split(';')) {
            if (statement.trim().isNotEmpty) {
              await session.db.unsafeQuery(statement);
            }
          }
        }
        for (final original in originals) {
          final feature =
              (await ClassFeatureData.db.findById(session, original.id!))!;
          expect(feature.level, 1);
          expect(feature.name, original.name);
          expect(feature.description, original.description);
          final rows = await FeatureModifierData.db
              .find(session, where: (t) => t.classFeatureId.equals(feature.id));
          expect(rows, hasLength(1));
          expect(
              rows.single.operation, FeatureModifierOperation.baseArmorClass);
          expect(rows.single.value.staticValue, 10);
          expect(rows.single.value.abilityModifiers, [
            Ability.dexterity,
            feature.referenceKey!.startsWith('barbarian')
                ? Ability.constitution
                : Ability.wisdom
          ]);
          expect(
              rows.single.conditions!
                  .map((condition) => condition.type)
                  .toList(),
              [
                FeatureModifierConditionType.unarmored,
                if (feature.referenceKey!.startsWith('monk'))
                  FeatureModifierConditionType.noShield
              ]);
        }
      } finally {
        await session.close();
      }
    });
  });
}
