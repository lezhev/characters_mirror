import 'package:characters_mirror_client/characters_mirror_client.dart';

CharacterData recalculateArmorClassFromCatalog(
    CharacterData character, List<ArmorData> armorCatalog,
    {int? dexterityModifier}) {
  final dexMod = dexterityModifier ??
      character.derived?.abilityModifiers?[Ability.dexterity] ??
      _abilityModifier(
        character.derived?.abilityScores?[Ability.dexterity] ??
            character.baseAbilityScores?['dexterity'] ??
            10,
      );
  final bodyArmor = _resolveArmor(
    armorCatalog,
    character.equippedArmor,
    matchesSlot: (category) =>
        category == ArmorCategory.light ||
        category == ArmorCategory.medium ||
        category == ArmorCategory.heavy,
  );
  final shield = _resolveArmor(
    armorCatalog,
    character.equippedShield,
    matchesSlot: (category) => category == ArmorCategory.shield,
  );

  final baseAC = bodyArmor?.baseAC;
  final bodyDexterityBonus = baseAC == null
      ? dexMod
      : bodyArmor?.dexBonus == true
          ? _cappedDexterityBonus(dexMod, bodyArmor?.dexBonusMax)
          : 0;
  final armorClass =
      (baseAC ?? 10) + bodyDexterityBonus + (shield?.bonusAC ?? 0);
  final derived = character.derived ?? CharacterDerivedData();

  return character.copyWith(
    derived: derived.copyWith(
      armorClass: armorClass + (character.customArmorClassBonus ?? 0),
    ),
  );
}

ArmorData? _resolveArmor(
  List<ArmorData> armorCatalog,
  CharacterEquipmentSelectionData? selection, {
  required bool Function(ArmorCategory?) matchesSlot,
}) {
  final referenceKey = selection?.referenceKey?.trim();
  if (referenceKey == null || referenceKey.isEmpty) return null;
  for (final armor in armorCatalog) {
    if (armor.referenceKey == referenceKey &&
        matchesSlot(armor.categoryValue)) {
      return armor;
    }
  }
  return null;
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

int _cappedDexterityBonus(int dexterityModifier, int? maximum) {
  if (maximum == null || dexterityModifier <= maximum) {
    return dexterityModifier;
  }
  return maximum;
}
