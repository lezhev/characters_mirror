part of '../character_data_endpoint.dart';

Future<({int value, String source, String formula})> _calculateArmorClass(
  CharacterData character,
  Map<Ability, int> abilityModifiers,
  List<FeatureModifierData> armorClassModifiers,
  int proficiencyBonus, {
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
