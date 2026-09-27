part of '../offline_character_resolver.dart';

Future<int> _calculateArmorClass(
  OfflineCacheDatabase cache,
  CharacterData character,
  int dexterityModifier,
) async {
  final bodyArmorReferenceKey = character.equippedArmor?.referenceKey?.trim();
  final shieldReferenceKey = character.equippedShield?.referenceKey?.trim();
  final customBonus = character.customArmorClassBonus ?? 0;
  if ((bodyArmorReferenceKey == null || bodyArmorReferenceKey.isEmpty) &&
      (shieldReferenceKey == null || shieldReferenceKey.isEmpty)) {
    return 10 + dexterityModifier + customBonus;
  }

  final armorRows = await cache.getReferenceList(
        'armor',
        offlineAllKey,
        ArmorData.fromJson,
      ) ??
      const <ArmorData>[];

  return recalculateArmorClassFromCatalog(
        character,
        armorRows,
        dexterityModifier: dexterityModifier,
      ).derived?.armorClass ??
      10 + dexterityModifier + customBonus;
}
