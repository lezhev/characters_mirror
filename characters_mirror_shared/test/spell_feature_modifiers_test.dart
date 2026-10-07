import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

const life = FeatureModifierSpec(
  referenceKey: 'fixture.life.healing',
  sourceFeatureKey: 'life',
  sourceClassKey: 'cleric',
  target: FeatureModifierTarget.spellHealing,
  operation: FeatureModifierOperation.add,
  valueKind: FeatureModifierValueKind.castLevel,
  staticValue: 2,
  minimumCastLevel: 1,
);
const context = FeatureModifierContext(
    proficiencyBonus: 2,
    classLevelsByKey: {'cleric': 3},
    activeFeatureKeys: {'life'},
    abilityModifiers: {'charisma': 4});

void main() {
  Map<String, dynamic> spell(
          {String key = 'cure_wounds', int level = 1, bool healing = true}) =>
      {
        'referenceKey': key,
        'level': level,
        'isHealing': healing,
        'healingDice': key == 'healing_word' ? '1d4' : '1d8',
        'healingAddsCastingModifier': true,
        'healingScaling': {
          'mode': 'slotLevel',
          'scalingBySlotLevel': {'3': '3d8'}
        },
      };
  String? healing(Map<String, dynamic> data,
          {int? castLevel, bool active = true, int? ability}) =>
      const SpellPresentationResolver()
          .resolve(data,
              context: SpellPresentationContext(
                castLevel: castLevel,
                abilityModifier: ability,
                featureModifiers: active ? [life] : [],
                modifierContext: context,
              ))
          .highlights
          .where((h) => h.kind == SpellHighlightKind.healing)
          .firstOrNull
          ?.value;

  test('Life uses base presentation level and effective upcast level', () {
    expect(healing(spell()), '1к8 + 3 + модификатор');
    expect(healing(spell(), castLevel: 3), '3к8 + 5 + модификатор');
    expect(healing(spell(), castLevel: 3, ability: 4), '3к8 + 5 + 4');
    expect(healing(spell(key: 'healing_word')), '1к4 + 3 + модификатор');
  });
  test('cantrip, non-healing and missing feature do not gain Life bonus', () {
    expect(healing(spell(level: 0)), '1к8 + модификатор');
    expect(healing(spell(healing: false)), isNull);
    expect(healing(spell(), active: false), '1к8 + модификатор');
    expect(
        evaluateFeatureModifiers(
            modifiers: [life],
            context: const FeatureModifierContext(
                proficiencyBonus: 2,
                classLevelsByKey: {},
                activeFeatureKeys: {}),
            spellContext: const FeatureModifierSpellContext(
                spellKey: 'cure_wounds', castLevel: 3)),
        isEmpty);
  });
  test('future damage ability term and range set are fixture-only data', () {
    const damage = FeatureModifierSpec(
        referenceKey: 'fixture.agonizing',
        sourceFeatureKey: 'life',
        sourceClassKey: 'cleric',
        spellKey: 'eldritch_blast',
        target: FeatureModifierTarget.spellDamage,
        operation: FeatureModifierOperation.add,
        valueKind: FeatureModifierValueKind.abilityModifier,
        abilityModifierKeys: ['charisma']);
    const range = FeatureModifierSpec(
        referenceKey: 'fixture.spear',
        sourceFeatureKey: 'life',
        sourceClassKey: 'cleric',
        spellKey: 'eldritch_blast',
        target: FeatureModifierTarget.spellRange,
        operation: FeatureModifierOperation.setValue,
        valueKind: FeatureModifierValueKind.staticValue,
        staticValue: 300);
    final evaluated = evaluateFeatureModifiers(
        modifiers: [damage, range],
        context: context,
        spellContext: const FeatureModifierSpellContext(
            spellKey: 'eldritch_blast', castLevel: 0));
    expect(
        sumFeatureModifierValues(evaluated)[FeatureModifierTarget.spellDamage],
        4);
    expect(
        applyFeatureModifierValues(
            120, evaluated, FeatureModifierTarget.spellRange),
        300);
    expect(
        evaluateFeatureModifiers(
            modifiers: [damage, range],
            context: context,
            spellContext: const FeatureModifierSpellContext(
                spellKey: 'other', castLevel: 0)),
        isEmpty);
    expect(
        evaluateFeatureModifiers(modifiers: [damage, range], context: context),
        isEmpty);
  });
  test('spell restrictions and context do not affect character targets', () {
    const hp = FeatureModifierSpec(
        referenceKey: 'fixture.hp',
        sourceFeatureKey: 'life',
        sourceClassKey: 'cleric',
        target: FeatureModifierTarget.hitPointMaximum,
        operation: FeatureModifierOperation.add,
        valueKind: FeatureModifierValueKind.classLevelProgression,
        progression: {1: 1, 2: 2, 3: 3},
        spellKey: 'other',
        minimumCastLevel: 9);
    expect(
        evaluateFeatureModifiers(modifiers: [hp], context: context)
            .single
            .value,
        3);
  });
  test('Wrath formula uses the existing formatter', () {
    final result = resolveFeatureDisplayProperties(definitions: const [
      FeatureDisplayPropertyDefinition(
          key: 'damage',
          label: 'Урон',
          valueKind: FeatureDisplayPropertyValueKind.formula,
          formula: '2d8',
          sortOrder: 0),
    ], sourceLevel: 1);
    expect(result.single.value, '2к8');
  });
}
