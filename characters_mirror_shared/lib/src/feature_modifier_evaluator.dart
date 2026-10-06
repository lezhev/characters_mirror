enum FeatureModifierTarget {
  speed,
  abilityCheck,
  armorClass,
  attackRoll,
  damageRoll
}

enum FeatureModifierOperation { add, baseArmorClass }

enum FeatureModifierValueKind {
  staticValue,
  classLevelProgression,
  proficiencyBonusFraction,
}

enum FeatureModifierCondition {
  unarmored,
  noShield,
  abilityCheckIsNotProficient,
  armored,
  rangedWeaponAttack,
}

enum FeatureModifierRounding { floor }

class FeatureModifierSpec {
  const FeatureModifierSpec({
    required this.referenceKey,
    required this.sourceFeatureKey,
    required this.sourceClassKey,
    required this.target,
    required this.operation,
    required this.valueKind,
    this.staticValue,
    this.progression = const {},
    this.numerator,
    this.denominator,
    this.rounding,
    this.conditions = const {},
    this.requiredChoiceOptions = const {},
    this.abilityModifierKeys = const [],
    this.sourceName,
  });

  final String referenceKey;
  final String sourceFeatureKey;
  final String sourceClassKey;
  final FeatureModifierTarget target;
  final FeatureModifierOperation operation;
  final FeatureModifierValueKind valueKind;
  final int? staticValue;
  final Map<int, int> progression;
  final int? numerator;
  final int? denominator;
  final FeatureModifierRounding? rounding;
  final Set<FeatureModifierCondition> conditions;
  final Set<String> requiredChoiceOptions;
  final List<String> abilityModifierKeys;
  final String? sourceName;
}

class FeatureModifierContext {
  const FeatureModifierContext({
    required this.proficiencyBonus,
    required this.classLevelsByKey,
    required this.activeFeatureKeys,
    this.isArmored = false,
    this.hasShield = false,
    this.abilityCheckIncludesProficiency = false,
    this.isRangedWeaponAttack = false,
    this.selectedChoiceOptionKeys = const {},
    this.abilityModifiers = const {},
  });

  final int proficiencyBonus;
  final Map<String, int> classLevelsByKey;
  final Set<String> activeFeatureKeys;
  final bool isArmored;
  final bool hasShield;
  final bool abilityCheckIncludesProficiency;
  final bool isRangedWeaponAttack;
  final Set<String> selectedChoiceOptionKeys;
  final Map<String, int> abilityModifiers;
}

class ResolvedFeatureModifier {
  const ResolvedFeatureModifier({
    required this.referenceKey,
    required this.target,
    required this.value,
    this.operation = FeatureModifierOperation.add,
    this.spec,
  });

  final String referenceKey;
  final FeatureModifierTarget target;
  final int value;
  final FeatureModifierOperation operation;
  final FeatureModifierSpec? spec;
}

List<ResolvedFeatureModifier> evaluateFeatureModifiers({
  required Iterable<FeatureModifierSpec> modifiers,
  required FeatureModifierContext context,
}) {
  final byKey = <String, FeatureModifierSpec>{};
  for (final modifier in modifiers) {
    if (modifier.referenceKey.isNotEmpty) {
      byKey.putIfAbsent(modifier.referenceKey, () => modifier);
    }
  }
  final ordered = byKey.values.toList()
    ..sort((a, b) => a.referenceKey.compareTo(b.referenceKey));
  final resolved = <ResolvedFeatureModifier>[];
  for (final modifier in ordered) {
    if (!context.activeFeatureKeys.contains(modifier.sourceFeatureKey))
      continue;
    if (!context.selectedChoiceOptionKeys
        .containsAll(modifier.requiredChoiceOptions)) {
      continue;
    }
    if (!_conditionsPass(modifier.conditions, context)) continue;
    final baseValue = _resolveValue(modifier, context);
    if (baseValue == null) continue;
    if (modifier.operation == FeatureModifierOperation.baseArmorClass &&
        modifier.target != FeatureModifierTarget.armorClass) continue;
    final value = baseValue +
        (modifier.operation == FeatureModifierOperation.baseArmorClass
            ? modifier.abilityModifierKeys.toSet().fold<int>(
                0, (sum, key) => sum + (context.abilityModifiers[key] ?? 0))
            : 0);
    if (value == 0 && modifier.operation == FeatureModifierOperation.add)
      continue;
    resolved.add(ResolvedFeatureModifier(
      referenceKey: modifier.referenceKey,
      target: modifier.target,
      value: value,
      operation: modifier.operation,
      spec: modifier,
    ));
  }
  return resolved;
}

Map<FeatureModifierTarget, int> sumFeatureModifierValues(
  Iterable<ResolvedFeatureModifier> modifiers,
) {
  final result = <FeatureModifierTarget, int>{};
  for (final modifier in modifiers) {
    if (modifier.operation != FeatureModifierOperation.add) continue;
    switch (modifier.target) {
      case FeatureModifierTarget.speed:
      case FeatureModifierTarget.abilityCheck:
      case FeatureModifierTarget.armorClass:
      case FeatureModifierTarget.attackRoll:
      case FeatureModifierTarget.damageRoll:
        result.update(
          modifier.target,
          (value) => value + modifier.value,
          ifAbsent: () => modifier.value,
        );
    }
  }
  return result;
}

bool _conditionsPass(
  Set<FeatureModifierCondition> conditions,
  FeatureModifierContext context,
) {
  for (final condition in conditions) {
    switch (condition) {
      case FeatureModifierCondition.unarmored:
        if (context.isArmored) return false;
      case FeatureModifierCondition.noShield:
        if (context.hasShield) return false;
      case FeatureModifierCondition.abilityCheckIsNotProficient:
        if (context.abilityCheckIncludesProficiency) return false;
      case FeatureModifierCondition.armored:
        if (!context.isArmored) return false;
      case FeatureModifierCondition.rangedWeaponAttack:
        if (!context.isRangedWeaponAttack) return false;
    }
  }
  return true;
}

int? _resolveValue(
  FeatureModifierSpec modifier,
  FeatureModifierContext context,
) {
  switch (modifier.valueKind) {
    case FeatureModifierValueKind.staticValue:
      return modifier.staticValue;
    case FeatureModifierValueKind.classLevelProgression:
      final sourceLevel =
          context.classLevelsByKey[modifier.sourceClassKey] ?? 0;
      int? threshold;
      for (final candidate in modifier.progression.keys) {
        if (candidate <= sourceLevel &&
            (threshold == null || candidate > threshold)) {
          threshold = candidate;
        }
      }
      return threshold == null ? null : modifier.progression[threshold];
    case FeatureModifierValueKind.proficiencyBonusFraction:
      final numerator = modifier.numerator;
      final denominator = modifier.denominator;
      if (numerator == null || denominator == null || denominator <= 0) {
        return null;
      }
      final scaled = context.proficiencyBonus * numerator;
      return switch (modifier.rounding) {
        FeatureModifierRounding.floor => scaled ~/ denominator,
        null => null,
      };
  }
}
