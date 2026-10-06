import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

FeatureModifierSpec formula(
  String key,
  List<String> abilities, {
  int base = 10,
  Set<FeatureModifierCondition> conditions = const {},
  Set<String> choices = const {},
}) =>
    FeatureModifierSpec(
      referenceKey: key,
      sourceFeatureKey: key,
      sourceClassKey: 'fixture',
      target: FeatureModifierTarget.armorClass,
      operation: FeatureModifierOperation.baseArmorClass,
      valueKind: FeatureModifierValueKind.staticValue,
      staticValue: base,
      abilityModifierKeys: abilities,
      conditions: conditions,
      requiredChoiceOptions: choices,
    );

void main() {
  const context = FeatureModifierContext(
      proficiencyBonus: 2,
      classLevelsByKey: {'fixture': 1},
      activeFeatureKeys: {'con', 'wis', 'natural'},
      abilityModifiers: {'dexterity': 2, 'constitution': 3, 'wisdom': 5});

  test('base candidates compete and are excluded from additive totals', () {
    final modifiers = [
      formula('con', ['dexterity', 'constitution']),
      formula('wis', ['dexterity', 'wisdom'])
    ];
    expect(resolveArmorClass(context: context, modifiers: modifiers).value, 17);
    expect(
        sumFeatureModifierValues(
            evaluateFeatureModifiers(modifiers: modifiers, context: context)),
        isEmpty);
  });

  test('ability term contributes once even with duplicate metadata', () {
    final result = resolveArmorClass(context: context, modifiers: [
      formula('con', ['dexterity', 'dexterity', 'constitution'])
    ]);
    expect(result.value, 15);
    expect(result.formula, '10 + Ловкость (2) + Телосложение (3)');
  });

  test('future natural armor can compete with equipped armor through metadata',
      () {
    const armor = ArmorClassEquipment(name: 'Heavy', baseAC: 18);
    final natural = [
      formula('natural', ['dexterity'], base: 13)
    ];
    const low = FeatureModifierContext(
        proficiencyBonus: 6,
        classLevelsByKey: {},
        activeFeatureKeys: {'natural'},
        isArmored: true,
        abilityModifiers: {'dexterity': 4});
    const high = FeatureModifierContext(
        proficiencyBonus: 6,
        classLevelsByKey: {},
        activeFeatureKeys: {'natural'},
        isArmored: true,
        abilityModifiers: {'dexterity': 6});
    expect(
        resolveArmorClass(context: low, modifiers: natural, bodyArmor: armor)
            .value,
        18);
    expect(
        resolveArmorClass(context: high, modifiers: natural, bodyArmor: armor)
            .value,
        19);
  });

  test('formula conditions and active source remain authoritative', () {
    final modifiers = [
      formula('natural', ['dexterity'],
          base: 20,
          conditions: {
            FeatureModifierCondition.unarmored,
            FeatureModifierCondition.noShield
          },
          choices: {'group::option'})
    ];
    const allowed = FeatureModifierContext(
        proficiencyBonus: 2,
        classLevelsByKey: {},
        activeFeatureKeys: {'natural'},
        selectedChoiceOptionKeys: {'group::option'},
        abilityModifiers: {'dexterity': 2});
    const noChoice = FeatureModifierContext(
        proficiencyBonus: 2,
        classLevelsByKey: {},
        activeFeatureKeys: {'natural'},
        abilityModifiers: {'dexterity': 2});
    const shielded = FeatureModifierContext(
        proficiencyBonus: 2,
        classLevelsByKey: {},
        activeFeatureKeys: {'natural'},
        hasShield: true,
        selectedChoiceOptionKeys: {'group::option'},
        abilityModifiers: {'dexterity': 2});
    const inactive = FeatureModifierContext(
        proficiencyBonus: 2,
        classLevelsByKey: {},
        activeFeatureKeys: {},
        selectedChoiceOptionKeys: {'group::option'},
        abilityModifiers: {'dexterity': 2});
    expect(resolveArmorClass(context: allowed, modifiers: modifiers).value, 22);
    expect(
        resolveArmorClass(context: noChoice, modifiers: modifiers).value, 12);
    expect(
        resolveArmorClass(
                context: shielded,
                modifiers: modifiers,
                shield: const ArmorClassEquipment(bonusAC: 2))
            .value,
        14);
    expect(
        resolveArmorClass(context: inactive, modifiers: modifiers).value, 12);
  });
}
