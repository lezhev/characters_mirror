import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  const context = FeatureModifierContext(
    proficiencyBonus: 2,
    classLevelsByKey: {'source': 3, 'other': 2},
    activeFeatureKeys: {'feature'},
    abilityModifiers: {'dexterity': 1},
  );
  const armor = FeatureModifierSpec(
    referenceKey: 'arbitrary.ac',
    sourceFeatureKey: 'feature',
    sourceClassKey: 'source',
    target: FeatureModifierTarget.armorClass,
    operation: FeatureModifierOperation.baseArmorClass,
    valueKind: FeatureModifierValueKind.staticValue,
    staticValue: 13,
    abilityModifierKeys: ['dexterity'],
    conditions: {FeatureModifierCondition.unarmored},
  );
  const hp = FeatureModifierSpec(
    referenceKey: 'arbitrary.hp',
    sourceFeatureKey: 'feature',
    sourceClassKey: 'source',
    target: FeatureModifierTarget.hitPointMaximum,
    operation: FeatureModifierOperation.add,
    valueKind: FeatureModifierValueKind.classLevelProgression,
    progression: {1: 1, 2: 2, 3: 3, 4: 4, 5: 5},
  );
  test('generic properties show existing AC formula and source-class HP', () {
    final properties = resolveFeatureModifierDisplayProperties(
        modifiers: [armor, hp], context: context);
    expect(
        properties.map((p) => p.label), ['КД без доспехов', 'Максимум хитов']);
    expect(properties.map((p) => p.value), ['13 + Ловкость (1) = 14', '+3']);
    expect(resolveArmorClass(context: context, modifiers: [armor]).value, 14);
  });
  test('spell healing property shows symbolic cast-level bonus', () {
    final properties = resolveFeatureModifierDisplayProperties(modifiers: [
      const FeatureModifierSpec(
        referenceKey: 'arbitrary.healing',
        sourceFeatureKey: 'feature',
        sourceClassKey: 'source',
        target: FeatureModifierTarget.spellHealing,
        operation: FeatureModifierOperation.add,
        valueKind: FeatureModifierValueKind.castLevel,
        staticValue: 2,
        minimumCastLevel: 1,
      ),
    ], context: context);
    expect(properties.single.label, 'Дополнительное лечение');
    expect(properties.single.value, 'Уровень ячейки + 2 (от 1-го уровня)');
  });
  test('inactive sources do not acquire display properties', () {
    expect(
        resolveFeatureModifierDisplayProperties(
            modifiers: [armor, hp],
            context: const FeatureModifierContext(
              proficiencyBonus: 2,
              classLevelsByKey: {'source': 3},
              activeFeatureKeys: {},
            )),
        isEmpty);
  });
}
