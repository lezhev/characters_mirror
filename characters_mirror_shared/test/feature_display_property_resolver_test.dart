import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  test('resolves proficiency bonus from total character level', () {
    const definition = FeatureDisplayPropertyDefinition(
      key: 'dc',
      label: 'DC',
      valueKind: FeatureDisplayPropertyValueKind.formula,
      formula: '8 + proficiencyBonus + abilityModifier(wisdom)',
    );
    String resolve(int characterLevel) => resolveFeatureDisplayProperties(
          definitions: const [definition],
          sourceLevel: 3,
          characterLevel: characterLevel,
          proficiencyBonus: 2 + ((characterLevel - 1) ~/ 4),
          abilityModifiers: const {'wisdom': 3},
        ).single.value;

    expect(resolve(3), '13');
    expect(resolve(5), '14');
  });

  test('legacy formula operands keep their existing behavior', () {
    final result = resolveFeatureDisplayProperties(
      definitions: const [
        FeatureDisplayPropertyDefinition(
          key: 'legacy',
          label: 'Legacy',
          valueKind: FeatureDisplayPropertyValueKind.formula,
          formula: 'ceil(classLevel / 2) + max(1, abilityModifier(wisdom))',
        ),
      ],
      sourceLevel: 5,
      characterLevel: 12,
      abilityModifiers: const {'wisdom': 3},
    );

    expect(result.single.value, '6');
  });
}
