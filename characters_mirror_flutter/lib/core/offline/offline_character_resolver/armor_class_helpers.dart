part of '../offline_character_resolver.dart';

Future<({int value, String source, String formula})> _calculateArmorClass(
  OfflineCacheDatabase cache,
  CharacterData character,
  Map<Ability, int> abilityModifiers,
  Iterable<UnarmoredDefenseRule> unarmoredDefenseRules,
) async {
  final bodyArmorReferenceKey = character.equippedArmor?.referenceKey?.trim();
  final shieldReferenceKey = character.equippedShield?.referenceKey?.trim();
  final customBonus = character.customArmorClassBonus ?? 0;
  final rules = unarmoredDefenseRules.toSet();
  if ((bodyArmorReferenceKey == null || bodyArmorReferenceKey.isEmpty) &&
      (shieldReferenceKey == null || shieldReferenceKey.isEmpty) &&
      rules.isEmpty) {
    final dexterityModifier = abilityModifiers[Ability.dexterity] ?? 0;
    return (
      value: 10 + dexterityModifier + customBonus,
      source: 'Без доспеха',
      formula: '10 + Ловкость ($dexterityModifier)'
          '${customBonus == 0 ? '' : ' + Бонус ($customBonus)'}',
    );
  }

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
  if (baseAC != null && bodyArmor?.dexBonus != true) formula = '$baseAC';
  if (shield != null) formula += ' + Щит (${shield.bonusAC ?? 0})';
  if (bodyArmor == null) {
    for (final rule in rules) {
      if (rule == UnarmoredDefenseRule.dexterityWisdom && shield != null) {
        continue;
      }
      final secondaryAbility =
          rule == UnarmoredDefenseRule.dexterityConstitution
              ? Ability.constitution
              : Ability.wisdom;
      final formulaAC = 10 +
          (abilityModifiers[Ability.dexterity] ?? 0) +
          (abilityModifiers[secondaryAbility] ?? 0) +
          (rule == UnarmoredDefenseRule.dexterityConstitution && shield != null
              ? shield.bonusAC ?? 0
              : 0);
      if (formulaAC > automaticArmorClass) {
        automaticArmorClass = formulaAC;
        source = 'Защита без доспехов';
        formula = '10 + Ловкость ($dexterityModifier) + '
            '${secondaryAbility == Ability.constitution ? 'Телосложение' : 'Мудрость'} '
            '(${abilityModifiers[secondaryAbility] ?? 0})';
        if (shield != null) formula += ' + Щит (${shield.bonusAC ?? 0})';
      }
    }
  }
  if (customBonus != 0) formula += ' + Бонус ($customBonus)';
  return (
    value: automaticArmorClass + customBonus,
    source: source,
    formula: formula,
  );
}

int _cappedDexterityBonus(int dexterityModifier, int? maximum) {
  if (maximum == null || dexterityModifier <= maximum) return dexterityModifier;
  return maximum;
}
