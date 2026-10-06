import 'dart:io';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Level 1-3 reference backfill', (sessions, _) {
    test('backfills grants, preserves descriptions, and is repeatable',
        () async {
      final session = sessions.build();
      try {
        final data = await ClassData.db.insertRow(
            session, ClassData(referenceKey: 'backfill_fixture_class'));
        final subclass = await SubclassData.db.insertRow(
            session,
            SubclassData(
                parentClassId: data.id!,
                referenceKey: 'backfill_fixture_subclass'));
        const armor = {
          'bard_valor_bonus_proficiencies': [
            ArmorCategory.medium,
            ArmorCategory.shield
          ],
          'cleric_life_bonus_proficiency': [ArmorCategory.heavy],
          'cleric_nature_bonus_proficiency': [ArmorCategory.heavy],
          'cleric_tempest_bonus_proficiencies': [ArmorCategory.heavy],
          'cleric_war_bonus_proficiency': [ArmorCategory.heavy],
        };
        const martial = {
          'bard_valor_bonus_proficiencies',
          'cleric_tempest_bonus_proficiencies',
          'cleric_war_bonus_proficiency',
        };
        const grants = <(String, String, int)>[
          ('cleric_knowledge_domain_spells', 'command', 1),
          ('cleric_knowledge_domain_spells', 'identify', 1),
          ('cleric_life_domain_spells', 'bless', 1),
          ('cleric_life_domain_spells', 'cure_wounds', 1),
          ('cleric_light_domain_spells', 'burning_hands', 1),
          ('cleric_light_domain_spells', 'faerie_fire', 1),
          ('cleric_nature_domain_spells', 'animal_friendship', 1),
          ('cleric_nature_domain_spells', 'speak_with_animals', 1),
          ('cleric_tempest_domain_spells', 'fog_cloud', 1),
          ('cleric_tempest_domain_spells', 'thunderwave', 1),
          ('cleric_trickery_domain_spells', 'charm_person', 1),
          ('cleric_trickery_domain_spells', 'disguise_self', 1),
          ('cleric_war_domain_spells', 'divine_favor', 1),
          ('cleric_war_domain_spells', 'shield_of_faith', 1),
          ('paladin_devotion_oath_spells', 'protection_from_evil_and_good', 3),
          ('paladin_devotion_oath_spells', 'sanctuary', 3),
          ('paladin_ancients_oath_spells', 'ensnaring_strike', 3),
          ('paladin_ancients_oath_spells', 'speak_with_animals', 3),
          ('paladin_vengeance_oath_spells', 'bane', 3),
          ('paladin_vengeance_oath_spells', 'hunters_mark', 3),
        ];
        final featureKeys = {
          ...armor.keys,
          'rogue_assassin_bonus_proficiencies',
          'cleric_light_bonus_cantrip',
          for (final grant in grants) grant.$1,
        };
        final features = <String, SubclassFeatureData>{};
        for (final key in featureKeys) {
          features[key] = await SubclassFeatureData.db.insertRow(
              session,
              SubclassFeatureData(
                  parentSubclassId: subclass.id!,
                  referenceKey: key,
                  name: key == 'paladin_devotion_oath_spells'
                      ? 'Заклинания клятвы предонности'
                      : 'Fixture $key',
                  description: 'Fixture description',
                  level: key.startsWith('paladin') ? 3 : 1));
        }
        final spells = <String, SpellData>{};
        for (final key in {for (final grant in grants) grant.$2, 'light'}) {
          spells[key] = await SpellData.db.insertRow(
              session, SpellData(referenceKey: key, name: 'Fixture $key'));
        }
        final sql = (await File(
                    'migrations/20261006201000000-level3-technical-backfill-1/migration.sql')
                .readAsString())
            .split('-- MIGRATION VERSION')[0]
            .replaceFirst('BEGIN;', '')
            .replaceAll(RegExp(r'^--.*$', multiLine: true), '');
        final firstVersions = <String, int?>{};
        for (var run = 0; run < 2; run++) {
          // The fixture updates stay inside the test's rollback transaction.
          for (final statement in sql.split(';')) {
            if (statement.trim().isNotEmpty) {
              await session.db.unsafeQuery(statement);
            }
          }
          for (final original in features.entries) {
            final feature = (await SubclassFeatureData.db
                .findById(session, original.value.id!))!;
            expect(feature.description, original.value.description);
            expect(feature.level, original.value.level);
            expect(
                feature.name,
                original.key == 'paladin_devotion_oath_spells'
                    ? 'Заклинания клятвы преданности'
                    : original.value.name);
            if (armor.containsKey(original.key)) {
              expect(feature.grantedArmorTraining, armor[original.key]);
            }
            if (martial.contains(original.key)) {
              expect(feature.grantedWeaponTraining,
                  [WeaponCategory.martialMelee, WeaponCategory.martialRanged]);
            }
            if (original.key == 'rogue_assassin_bonus_proficiencies') {
              expect(feature.grantedToolKeys, ['disguise_kit', 'poisoner_kit']);
            }
            if (original.key == 'cleric_light_bonus_cantrip') {
              expect(feature.grantedSpellKeys, ['light']);
            }
            if (run == 0) {
              firstVersions[original.key] = feature.version;
            } else {
              expect(feature.version, firstVersions[original.key]);
            }
          }
          final rows = await ClassSpellGrantData.db.find(session,
              where: (t) => t.sourceSubclassFeatureId.inSet(
                  features.values.map((feature) => feature.id!).toSet()));
          expect(rows, hasLength(20));
          for (final grant in grants) {
            final row = rows.singleWhere((row) =>
                row.sourceSubclassFeatureId == features[grant.$1]!.id &&
                row.spellId == spells[grant.$2]!.id);
            expect(row.grantedAtLevel, grant.$3);
            expect(row.alwaysPrepared, true);
          }
        }
      } finally {
        await session.close();
      }
    });
  });
}
