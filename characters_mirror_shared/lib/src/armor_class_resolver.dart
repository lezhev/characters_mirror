import 'feature_modifier_evaluator.dart';

class ArmorClassEquipment {
  const ArmorClassEquipment({
    this.name,
    this.baseAC,
    this.dexBonus = false,
    this.dexBonusMax,
    this.bonusAC = 0,
  });

  final String? name;
  final int? baseAC;
  final bool dexBonus;
  final int? dexBonusMax;
  final int bonusAC;
}

({int value, String source, String formula}) resolveArmorClass({
  required FeatureModifierContext context,
  Iterable<FeatureModifierSpec> modifiers = const [],
  ArmorClassEquipment? bodyArmor,
  ArmorClassEquipment? shield,
  int customBonus = 0,
}) {
  final dexterity = context.abilityModifiers['dexterity'] ?? 0;
  final base = bodyArmor?.baseAC;
  final maximum = bodyArmor?.dexBonusMax;
  final dexBonus = base == null
      ? dexterity
      : bodyArmor?.dexBonus != true
          ? 0
          : maximum != null && dexterity > maximum
              ? maximum
              : dexterity;
  var value = (base ?? 10) + dexBonus;
  var source = bodyArmor?.name ?? 'Без доспеха';
  var formula = base != null && bodyArmor?.dexBonus != true
      ? '$base'
      : '${base ?? 10} + Ловкость ($dexBonus)';
  final evaluated =
      evaluateFeatureModifiers(modifiers: modifiers, context: context);
  for (final modifier in evaluated) {
    if (modifier.target != FeatureModifierTarget.armorClass ||
        modifier.operation != FeatureModifierOperation.baseArmorClass ||
        modifier.value <= value) continue;
    value = modifier.value;
    final spec = modifier.spec!;
    source = spec.sourceName ?? 'Защита без доспехов';
    // Ability terms are included once in each base candidate, never added to armor.
    final abilityTerms = spec.abilityModifierKeys.toSet();
    final constant = value -
        abilityTerms.fold<int>(
            0, (sum, key) => sum + (context.abilityModifiers[key] ?? 0));
    formula = '$constant';
    for (final key in abilityTerms) {
      formula +=
          ' + ${_abilityLabel(key)} (${context.abilityModifiers[key] ?? 0})';
    }
  }
  if (shield != null) {
    value += shield.bonusAC;
    formula += ' + Щит (${shield.bonusAC})';
  }
  value += customBonus;
  if (customBonus != 0) formula += ' + Бонус ($customBonus)';
  final effects =
      sumFeatureModifierValues(evaluated)[FeatureModifierTarget.armorClass] ??
          0;
  value += effects;
  if (effects != 0) formula += ' + Эффекты ($effects)';
  return (value: value, source: source, formula: formula);
}

String _abilityLabel(String key) => switch (key) {
      'strength' => 'Сила',
      'dexterity' => 'Ловкость',
      'constitution' => 'Телосложение',
      'intelligence' => 'Интеллект',
      'wisdom' => 'Мудрость',
      'charisma' => 'Харизма',
      _ => key,
    };
