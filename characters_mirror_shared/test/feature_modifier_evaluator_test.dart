import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  const movement = FeatureModifierSpec(
    referenceKey: 'monk.unarmored_movement',
    sourceFeatureKey: 'unarmored_movement',
    sourceClassKey: 'monk',
    target: FeatureModifierTarget.speed,
    operation: FeatureModifierOperation.add,
    valueKind: FeatureModifierValueKind.classLevelProgression,
    progression: {2: 10, 6: 15, 10: 20, 14: 25, 18: 30},
    conditions: {
      FeatureModifierCondition.unarmored,
      FeatureModifierCondition.noShield,
    },
  );

  FeatureModifierContext context({
    int monkLevel = 2,
    int fighterLevel = 0,
    bool armored = false,
    bool shield = false,
    int proficiencyBonus = 2,
    bool proficient = false,
  }) =>
      FeatureModifierContext(
        proficiencyBonus: proficiencyBonus,
        classLevelsByKey: {'monk': monkLevel, 'fighter': fighterLevel},
        activeFeatureKeys: {'unarmored_movement', 'jack_of_all_trades'},
        isArmored: armored,
        hasShield: shield,
        abilityCheckIncludesProficiency: proficient,
      );

  test('progression uses greatest threshold for source class level', () {
    for (final entry in <int, int>{2: 10, 5: 10, 6: 15, 18: 30}.entries) {
      final result = evaluateFeatureModifiers(
        modifiers: [movement],
        context: context(monkLevel: entry.key),
      );
      expect(sumFeatureModifierValues(result)[FeatureModifierTarget.speed],
          entry.value);
    }
    expect(
      evaluateFeatureModifiers(
          modifiers: [movement], context: context(monkLevel: 1)),
      isEmpty,
    );
  });

  test('multiclass level does not replace source class level', () {
    final result = evaluateFeatureModifiers(
      modifiers: [movement],
      context: context(monkLevel: 2, fighterLevel: 8),
    );
    expect(sumFeatureModifierValues(result)[FeatureModifierTarget.speed], 10);
  });

  test('armor and shield conditions block movement bonus', () {
    expect(
      evaluateFeatureModifiers(
        modifiers: [movement],
        context: context(armored: true),
      ),
      isEmpty,
    );
    expect(
      evaluateFeatureModifiers(
        modifiers: [movement],
        context: context(shield: true),
      ),
      isEmpty,
    );
  });

  test('proficiency fraction rounds down and requires missing proficiency', () {
    const jack = FeatureModifierSpec(
      referenceKey: 'bard.jack_of_all_trades',
      sourceFeatureKey: 'jack_of_all_trades',
      sourceClassKey: 'bard',
      target: FeatureModifierTarget.abilityCheck,
      operation: FeatureModifierOperation.add,
      valueKind: FeatureModifierValueKind.proficiencyBonusFraction,
      numerator: 1,
      denominator: 2,
      rounding: FeatureModifierRounding.floor,
      conditions: {FeatureModifierCondition.abilityCheckIsNotProficient},
    );
    for (final entry in <int, int>{2: 1, 3: 1, 4: 2, 5: 2, 6: 3}.entries) {
      final result = evaluateFeatureModifiers(
        modifiers: [jack],
        context: context(proficiencyBonus: entry.key),
      );
      expect(
          sumFeatureModifierValues(result)[FeatureModifierTarget.abilityCheck],
          entry.value);
    }
    expect(
      evaluateFeatureModifiers(
        modifiers: [jack],
        context: context(proficient: true),
      ),
      isEmpty,
    );
  });

  test('requires active source feature and deduplicates by stable identity',
      () {
    final inactive = context()..activeFeatureKeys.clear();
    expect(evaluateFeatureModifiers(modifiers: [movement], context: inactive),
        isEmpty);
    final result = evaluateFeatureModifiers(
      modifiers: [movement, movement],
      context: context(),
    );
    expect(result, hasLength(1));
  });

  test('static add modifiers stack in stable identity order', () {
    const first = FeatureModifierSpec(
      referenceKey: 'feature.speed.first',
      sourceFeatureKey: 'unarmored_movement',
      sourceClassKey: 'monk',
      target: FeatureModifierTarget.speed,
      operation: FeatureModifierOperation.add,
      valueKind: FeatureModifierValueKind.staticValue,
      staticValue: 5,
    );
    const second = FeatureModifierSpec(
      referenceKey: 'feature.speed.second',
      sourceFeatureKey: 'unarmored_movement',
      sourceClassKey: 'monk',
      target: FeatureModifierTarget.speed,
      operation: FeatureModifierOperation.add,
      valueKind: FeatureModifierValueKind.staticValue,
      staticValue: 10,
    );
    final result = evaluateFeatureModifiers(
      modifiers: [second, first],
      context: context(),
    );
    expect(result.map((modifier) => modifier.referenceKey), [
      'feature.speed.first',
      'feature.speed.second',
    ]);
    expect(sumFeatureModifierValues(result)[FeatureModifierTarget.speed], 15);
  });
}
