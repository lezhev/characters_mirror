import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/character/armor_class_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recalculates equipped chain mail AC without an offline cache', () {
    final character = CharacterData(
      baseAbilityScores: {'dexterity': 18},
      equippedArmor: CharacterEquipmentSelectionData(
        referenceKey: 'chain_mail',
        name: 'Кольчуга',
      ),
      derived: CharacterDerivedData(
        abilityModifiers: {Ability.dexterity: 4},
        armorClass: 14,
      ),
    );
    final armorCatalog = [
      ArmorData(
        referenceKey: 'chain_mail',
        name: 'Кольчуга',
        categoryValue: ArmorCategory.heavy,
        baseAC: 16,
        dexBonus: false,
      ),
    ];

    final resolved = recalculateArmorClassFromCatalog(
      character,
      armorCatalog,
    );

    expect(resolved.derived?.armorClass, 16);
    expect(resolved.equippedArmor?.referenceKey, 'chain_mail');
    expect(resolved.derived?.abilityModifiers?[Ability.dexterity], 4);
  });

  test('recalculates unarmored AC after removing catalog armor', () {
    final character = CharacterData(
      baseAbilityScores: {'dexterity': 18},
      equippedArmor: CharacterEquipmentSelectionData(
        referenceKey: 'chain_mail',
        name: 'Кольчуга',
      ),
      derived: CharacterDerivedData(
        abilityModifiers: {Ability.dexterity: 4},
        armorClass: 16,
      ),
    ).copyWith(equippedArmor: null);

    final resolved = recalculateArmorClassFromCatalog(character, const []);

    expect(resolved.derived?.armorClass, 14);
  });
}
