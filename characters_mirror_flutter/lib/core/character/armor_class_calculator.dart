import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart' as ac;
import 'armor_class_feature_modifiers.dart';

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

  final abilityModifiers = <Ability, int>{
    for (final ability in Ability.values)
      ability: character.derived?.abilityModifiers?[ability] ??
          _abilityModifier(character.derived?.abilityScores?[ability] ??
              character.baseAbilityScores?[ability.name] ??
              10),
    Ability.dexterity: dexMod,
  };
  final input = armorClassModifierInput(
      character,
      character.derived?.featureModifiers ?? const [],
      abilityModifiers,
      character.derived?.proficiencyBonus ?? 2);
  final result = ac.resolveArmorClass(
      context: input.context,
      modifiers: input.modifiers,
      bodyArmor: armorClassEquipment(bodyArmor),
      shield: armorClassEquipment(shield),
      customBonus: character.customArmorClassBonus ?? 0);
  final derived = character.derived ?? CharacterDerivedData();
  return character.copyWith(
      derived: derived.copyWith(
          armorClass: result.value,
          armorClassSource: result.source,
          armorClassFormula: result.formula));
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
