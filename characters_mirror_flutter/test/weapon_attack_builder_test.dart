import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/weapon_attack_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('weapon attack builder', () {
    test('finds weapon by exact name ignoring case and outer spaces', () {
      final weapons = [
        WeaponData(referenceKey: 'dagger', name: 'Dagger'),
      ];

      expect(findWeaponByExactName(weapons, ' dagger '), same(weapons.single));
      expect(findWeaponByExactName(weapons, 'Dag'), isNull);
    });

    test('uses dexterity for ranged weapons', () {
      final attack = buildAttackFromWeapon(
        weapon: WeaponData(
          name: 'Light Crossbow',
          category: WeaponCategory.simpleRanged,
        ),
        character: CharacterData(),
      );

      expect(attack.leadingAbility, Ability.dexterity);
    });

    test('uses strength for melee weapons', () {
      final attack = buildAttackFromWeapon(
        weapon: WeaponData(
          name: 'Club',
          category: WeaponCategory.simpleMelee,
        ),
        character: CharacterData(),
      );

      expect(attack.leadingAbility, Ability.strength);
    });

    test('uses higher strength or dexterity modifier for finesse weapons', () {
      final weapon = WeaponData(
        name: 'Dagger',
        category: WeaponCategory.simpleMelee,
        properties: const [WeaponProperty.finesse],
      );

      final attack = buildAttackFromWeapon(
        weapon: weapon,
        character: CharacterData(
          derived: CharacterDerivedData(
            abilityModifiers: const {
              'strength': 1,
              'dexterity': 3,
            },
          ),
        ),
      );

      expect(attack.leadingAbility, Ability.dexterity);
    });

    test('builds manual draft from unknown selected text', () {
      final attack = buildAttackDraftFromSelection(' Unknown blade ');

      expect(attack.name, 'Unknown blade');
      expect(attack.leadingAbility, Ability.strength);
      expect(attack.customAttackBonus, 0);
      expect(attack.tags, isEmpty);
    });

    test('copies weapon combat fields into an attack', () {
      final attack = buildAttackFromWeapon(
        weapon: WeaponData(
          referenceKey: 'dagger',
          name: 'Dagger',
          category: WeaponCategory.simpleMelee,
          damage: '1d4',
          damageType: DamageType.piercing,
          properties: const [WeaponProperty.finesse, WeaponProperty.light],
          description: 'Small blade.',
        ),
        character: CharacterData(),
      );

      expect(attack.name, 'Dagger');
      expect(attack.damage, '1d4');
      expect(attack.damageType, DamageType.piercing);
      expect(attack.tags, ['finesse', 'light']);
      expect(attack.description, 'Small blade.');
    });
  });
}
