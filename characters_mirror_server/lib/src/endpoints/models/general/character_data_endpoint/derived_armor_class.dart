part of '../character_data_endpoint.dart';

Future<({int value, String source, String formula})> _calculateArmorClass(
  CharacterData character,
  Map<Ability, int> abilityModifiers,
  Iterable<UnarmoredDefenseRule> unarmoredDefenseRules, {
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
  final dexterityModifier = abilityModifiers[Ability.dexterity] ?? 0;
  final bodyDexterityBonus = baseAC == null
      ? dexterityModifier
      : bodyArmor?.dexBonus == true
          ? _cappedDexterityBonus(dexterityModifier, bodyArmor?.dexBonusMax)
          : 0;
  var automaticArmorClass =
      (baseAC ?? 10) + bodyDexterityBonus + (shield?.bonusAC ?? 0);
  var source = bodyArmor?.name ?? 'Без доспеха';
  var formula = '${baseAC ?? 10} + Ловкость ($bodyDexterityBonus)';
  if (baseAC != null && bodyArmor?.dexBonus != true) {
    formula = '$baseAC';
  }
  if (shield != null) {
    formula += ' + Щит (${shield.bonusAC ?? 0})';
  }
  if (bodyArmor == null) {
    for (final rule in unarmoredDefenseRules) {
      if (rule == UnarmoredDefenseRule.dexterityWisdom && shield != null) {
        continue;
      }
      final secondaryAbility =
          rule == UnarmoredDefenseRule.dexterityConstitution
              ? Ability.constitution
              : Ability.wisdom;
      final formulaAC = 10 +
          dexterityModifier +
          (abilityModifiers[secondaryAbility] ?? 0) +
          (rule == UnarmoredDefenseRule.dexterityConstitution
              ? shield?.bonusAC ?? 0
              : 0);
      if (formulaAC > automaticArmorClass) {
        automaticArmorClass = formulaAC;
        source = 'Защита без доспехов';
        formula = '10 + Ловкость ($dexterityModifier) + '
            '${secondaryAbility == Ability.constitution ? 'Телосложение' : 'Мудрость'} '
            '(${abilityModifiers[secondaryAbility] ?? 0})';
        if (shield != null) {
          formula += ' + Щит (${shield.bonusAC ?? 0})';
        }
      }
    }
  }

  final customBonus = character.customArmorClassBonus ?? 0;
  if (customBonus != 0) formula += ' + Бонус ($customBonus)';
  return (
    value: automaticArmorClass + customBonus,
    source: source,
    formula: formula,
  );
}

int _cappedDexterityBonus(int dexterityModifier, int? maximum) {
  if (maximum == null || dexterityModifier <= maximum) {
    return dexterityModifier;
  }
  return maximum;
}
