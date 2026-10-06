import 'dart:math';

/// Resolves a reference resource for presentation using the same max rules as
/// character resources. Special resources have no numeric summary.
int? featureResourceSummaryMaximum({
  required String rule,
  int? value,
  int abilityModifier = 0,
  required int sourceLevel,
  required int characterLevel,
  required int proficiencyBonus,
  Iterable<({int level, int value})> progression = const [],
}) {
  final multiplier = max(value ?? 1, 1);
  return switch (rule) {
    'fixed' => multiplier,
    'proficiencyBonus' => proficiencyBonus,
    'abilityModifier' => abilityModifier + (value ?? 0),
    'abilityModifierMinOne' => max(1, abilityModifier + (value ?? 0)),
    'sourceClassLevel' => max(sourceLevel, 0),
    'sourceClassLevelTimesValue' => max(sourceLevel, 0) * multiplier,
    'totalLevel' => max(characterLevel, 0),
    'totalLevelTimesValue' => max(characterLevel, 0) * multiplier,
    'sourceClassLevelTable' => _tableMaximum(progression, sourceLevel),
    _ => null,
  };
}

int _tableMaximum(Iterable<({int level, int value})> rows, int level) {
  final available = rows.where((row) => row.level <= level).toList()
    ..sort((a, b) => a.level.compareTo(b.level));
  return max(0, available.lastOrNull?.value ?? 0);
}
