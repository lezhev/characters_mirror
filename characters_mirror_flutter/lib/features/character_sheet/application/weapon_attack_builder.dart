import 'package:characters_mirror_client/characters_mirror_client.dart';

String? normalizedEquipmentSelectionText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

WeaponData? findWeaponByExactName(
  Iterable<WeaponData>? weapons,
  String? selectedText,
) {
  final normalizedSelection =
      normalizedEquipmentSelectionText(selectedText)?.toLowerCase();
  if (normalizedSelection == null) {
    return null;
  }

  for (final weapon in weapons ?? const <WeaponData>[]) {
    final normalizedName =
        normalizedEquipmentSelectionText(weapon.name)?.toLowerCase();
    if (normalizedName == normalizedSelection) {
      return weapon;
    }
  }
  return null;
}

CharacterAttackData buildAttackDraftFromSelection(String selectedText) {
  return CharacterAttackData(
    name: normalizedEquipmentSelectionText(selectedText),
    leadingAbility: Ability.strength,
    customAttackBonus: 0,
    tags: const [],
  );
}

CharacterAttackData buildAttackFromWeapon({
  required WeaponData weapon,
  required CharacterData character,
}) {
  return CharacterAttackData(
    name: normalizedEquipmentSelectionText(weapon.name) ??
        normalizedEquipmentSelectionText(weapon.referenceKey),
    leadingAbility: weaponAttackAbility(weapon, character),
    damage: normalizedEquipmentSelectionText(weapon.damage),
    customAttackBonus: 0,
    damageType: weapon.damageType,
    tags: normalizedWeaponProperties(weapon.properties),
    description: normalizedEquipmentSelectionText(weapon.description),
  );
}

Ability weaponAttackAbility(WeaponData weapon, CharacterData character) {
  if (hasWeaponProperty(weapon, WeaponProperty.finesse)) {
    final modifiers = character.derived?.abilityModifiers ?? const {};
    final strength = modifiers[Ability.strength.name] ?? 0;
    final dexterity = modifiers[Ability.dexterity.name] ?? 0;
    return dexterity > strength ? Ability.dexterity : Ability.strength;
  }

  switch (weapon.category) {
    case WeaponCategory.simpleRanged:
    case WeaponCategory.martialRanged:
      return Ability.dexterity;
    case WeaponCategory.simpleMelee:
    case WeaponCategory.martialMelee:
    case null:
      return Ability.strength;
  }
}

List<String>? normalizedWeaponProperties(List<WeaponProperty>? properties) {
  final normalized = <String>[
    for (final property in properties ?? const <WeaponProperty>[])
      property.name,
  ];
  return normalized.isEmpty ? null : normalized;
}

bool hasWeaponProperty(WeaponData weapon, WeaponProperty property) {
  return (weapon.properties ?? const <WeaponProperty>[]).contains(property);
}
