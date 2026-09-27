import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  final catalog = <ArmorData>[
    ArmorData(
      referenceKey: 'leather_armor',
      name: 'Leather Armor',
      categoryValue: ArmorCategory.light,
      baseAC: 11,
      dexBonus: true,
    ),
    ArmorData(
      referenceKey: 'scale_mail',
      name: 'Scale Mail',
      categoryValue: ArmorCategory.medium,
      baseAC: 14,
      dexBonus: true,
      dexBonusMax: 2,
    ),
    ArmorData(
      referenceKey: 'chain_mail',
      name: 'Chain Mail',
      categoryValue: ArmorCategory.heavy,
      baseAC: 16,
      dexBonus: false,
    ),
    ArmorData(
      referenceKey: 'shield',
      name: 'Shield',
      categoryValue: ArmorCategory.shield,
      bonusAC: 3,
    ),
  ];

  Future<int?> resolveAc({
    int dexterity = 16,
    String? armorKey,
    String armorName = 'Custom armor',
    String? shieldKey,
    String shieldName = 'Custom shield',
    int? customBonus,
  }) async {
    await cache.putReferenceList(
      'armor',
      offlineAllKey,
      catalog,
      (value) => value.toJson(),
    );
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        baseAbilityScores: {'dexterity': dexterity},
        equippedArmor: armorKey == null && armorName == 'Custom armor'
            ? null
            : CharacterEquipmentSelectionData(
                referenceKey: armorKey,
                name: armorName,
              ),
        equippedShield: shieldKey == null && shieldName == 'Custom shield'
            ? null
            : CharacterEquipmentSelectionData(
                referenceKey: shieldKey,
                name: shieldName,
              ),
        customArmorClassBonus: customBonus,
      ),
    );
    return derived.armorClass;
  }

  test('unarmored AC applies positive and negative Dexterity modifiers',
      () async {
    expect(await resolveAc(dexterity: 16), 13);
    expect(await resolveAc(dexterity: 8), 9);
  });

  test('light armor adds the full Dexterity modifier', () async {
    expect(await resolveAc(dexterity: 18, armorKey: 'leather_armor'), 15);
  });

  test('medium armor caps only positive Dexterity contribution', () async {
    expect(await resolveAc(dexterity: 18, armorKey: 'scale_mail'), 16);
    expect(await resolveAc(dexterity: 8, armorKey: 'scale_mail'), 13);
  });

  test('heavy armor ignores Dexterity', () async {
    expect(await resolveAc(dexterity: 18, armorKey: 'chain_mail'), 16);
  });

  test('shield uses its catalog AC bonus with body armor and custom bonus',
      () async {
    expect(await resolveAc(dexterity: 14, shieldKey: 'shield'), 15);
    expect(
      await resolveAc(
        dexterity: 18,
        armorKey: 'leather_armor',
        shieldKey: 'shield',
      ),
      18,
    );
    expect(
      await resolveAc(
        dexterity: 18,
        armorKey: 'scale_mail',
        shieldKey: 'shield',
        customBonus: 2,
      ),
      21,
    );
  });

  test('custom or unresolved armor does not infer catalog stats by name',
      () async {
    expect(
      await resolveAc(dexterity: 16, armorName: 'Chain Mail'),
      13,
    );
    expect(
      await resolveAc(
        dexterity: 16,
        armorKey: 'unknown_chain_mail',
        armorName: 'Chain Mail',
      ),
      13,
    );
  });
}
