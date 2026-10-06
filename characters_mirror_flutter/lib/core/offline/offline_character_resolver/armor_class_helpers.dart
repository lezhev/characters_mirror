part of '../offline_character_resolver.dart';

Future<({int value, String source, String formula})> _calculateArmorClass(
  OfflineCacheDatabase cache,
  CharacterData character,
  Map<Ability, int> abilityModifiers,
  List<FeatureModifierData> armorClassModifiers,
  int proficiencyBonus,
) async {
  final bodyArmorReferenceKey = character.equippedArmor?.referenceKey?.trim();
  final shieldReferenceKey = character.equippedShield?.referenceKey?.trim();
  final armorRows = await cache.getReferenceList(
        'armor',
        offlineAllKey,
        ArmorData.fromJson,
      ) ??
      const <ArmorData>[];
  final bodyArmor = armorRows
      .where((armor) =>
          armor.referenceKey == bodyArmorReferenceKey &&
          (armor.categoryValue == ArmorCategory.light ||
              armor.categoryValue == ArmorCategory.medium ||
              armor.categoryValue == ArmorCategory.heavy))
      .firstOrNull;
  final shield = armorRows
      .where((armor) =>
          armor.referenceKey == shieldReferenceKey &&
          armor.categoryValue == ArmorCategory.shield)
      .firstOrNull;
  final input = armorClassModifierInput(
      character, armorClassModifiers, abilityModifiers, proficiencyBonus);
  return feature_modifiers.resolveArmorClass(
    context: input.context,
    modifiers: input.modifiers,
    bodyArmor: armorClassEquipment(bodyArmor),
    shield: armorClassEquipment(shield),
    customBonus: character.customArmorClassBonus ?? 0,
  );
}
