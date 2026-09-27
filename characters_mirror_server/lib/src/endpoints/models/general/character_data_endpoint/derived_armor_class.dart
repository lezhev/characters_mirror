part of '../character_data_endpoint.dart';

Future<int> _calculateArmorClass(
  CharacterData character,
  int dexterityModifier, {
  required _CharacterResolveContext resolveContext,
  Transaction? transaction,
}) async {
  Future<ArmorData?> resolve(
    CharacterEquipmentSelectionData? selection, {
    required bool Function(ArmorCategory?) matchesSlot,
  }) async {
    final referenceKey = selection?.referenceKey?.trim();
    if (referenceKey == null || referenceKey.isEmpty) return null;
    final armor = await resolveContext.armor(
      referenceKey,
      transaction: transaction,
    );
    if (!matchesSlot(armor?.categoryValue)) return null;
    return armor;
  }

  final bodyArmor = await resolve(
    character.equippedArmor,
    matchesSlot: (category) =>
        category == ArmorCategory.light ||
        category == ArmorCategory.medium ||
        category == ArmorCategory.heavy,
  );
  final shield = await resolve(
    character.equippedShield,
    matchesSlot: (category) => category == ArmorCategory.shield,
  );

  final baseAC = bodyArmor?.baseAC;
  final bodyDexterityBonus = baseAC == null
      ? dexterityModifier
      : bodyArmor?.dexBonus == true
          ? _cappedDexterityBonus(dexterityModifier, bodyArmor?.dexBonusMax)
          : 0;
  final automaticArmorClass =
      (baseAC ?? 10) + bodyDexterityBonus + (shield?.bonusAC ?? 0);

  return automaticArmorClass + (character.customArmorClassBonus ?? 0);
}

int _cappedDexterityBonus(int dexterityModifier, int? maximum) {
  if (maximum == null || dexterityModifier <= maximum) {
    return dexterityModifier;
  }
  return maximum;
}
