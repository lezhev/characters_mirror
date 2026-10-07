import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  final classFeature = {
    'id': 7,
    'referenceKey': 'class_feature',
    'parentClassId': 1,
    'level': 1
  };
  final subfeature = {
    'id': 7,
    'referenceKey': 'sub_feature',
    'parentSubclassId': 3,
    'level': 1
  };
  Map<String, dynamic> character({int level = 3, bool subclass = true}) => {
        'classEntries': [
          {
            'classData': {'id': 1, 'referenceKey': 'fighter'},
            'level': 2
          },
          {
            'classData': {'id': 2, 'referenceKey': 'sorcerer'},
            'level': level,
            if (subclass)
              'subclass': {'id': 3, 'parentClassId': 2, 'levelRequired': 1}
          },
        ],
      };
  final row = <String, dynamic>{
    'referenceKey': 'fixture.hp',
    'subclassFeatureId': 7,
    'target': 5,
    'operation': 0,
    'value': {
      'kind': 1,
      'progression': [
        for (var level = 1; level <= 20; level++) {'k': level, 'v': level}
      ]
    }
  };
  int bonus(Map<String, dynamic> data) {
    final input = characterFeatureModifierInput(data,
        modifiers: [row],
        classFeatures: [classFeature],
        subclassFeatures: [subfeature]);
    return sumFeatureModifierValues(evaluateFeatureModifiers(
            modifiers: input.modifiers,
            context: input.context))[FeatureModifierTarget.hitPointMaximum] ??
        0;
  }

  test('source ID spaces and source class level remain independent', () {
    expect(bonus(character(level: 1)), 1);
    expect(bonus(character()), 3);
    expect(bonus(character(level: 2)), 2);
    expect(bonus(character(subclass: false)), 0);
    expect(bonus(character(level: 0)), 0);
  });
  test('hydrated snapshot can recalculate and discards inactive sources', () {
    final rows = activeFeatureModifierRows(character(), [row],
        subclassFeatures: [subfeature]);
    final snapshot = character()..['derived'] = {'featureModifiers': rows};
    final input = characterFeatureModifierInput(snapshot);
    expect(
        evaluateFeatureModifiers(
                modifiers: input.modifiers, context: input.context)
            .single
            .value,
        3);
    expect(activeFeatureModifierRows(character(), rows, subclassFeatures: []),
        isEmpty);
    expect(
        activeFeatureModifierRows(character(subclass: false), rows), isEmpty);
    final aboveLevel = {...subfeature, 'level': 4};
    expect(
        activeFeatureModifierRows(character(), [row],
            subclassFeatures: [aboveLevel]),
        isEmpty);
  });
  test('protocol adapter supports future generic spell data without a new type',
      () {
    final input = characterFeatureModifierInput(character(), subclassFeatures: [
      subfeature
    ], modifiers: [
      {
        ...row,
        'target': 7,
        'spellKey': 'eldritch_blast',
        'value': {
          'kind': 3,
          'abilityModifiers': ['charisma']
        }
      },
      {
        ...row,
        'referenceKey': 'fixture.range',
        'target': 8,
        'operation': 2,
        'spellKey': 'eldritch_blast',
        'value': {'kind': 0, 'staticValue': 300}
      },
    ], abilityModifiers: {
      'charisma': 4
    });
    final resolved = evaluateFeatureModifiers(
        modifiers: input.modifiers,
        context: input.context,
        spellContext: const FeatureModifierSpellContext(
            spellKey: 'eldritch_blast', castLevel: 0));
    expect(
        sumFeatureModifierValues(resolved)[FeatureModifierTarget.spellDamage],
        4);
    expect(
        applyFeatureModifierValues(
            120, resolved, FeatureModifierTarget.spellRange),
        300);
  });
  test('enum-key protocol maps preserve presentation abilities and modifiers',
      () {
    final data = character()
      ..['derived'] = {
        'abilityModifiers': [
          {'k': 'wisdom', 'v': 4},
          {'k': 'charisma', 'v': 3}
        ],
        'abilityScores': [
          {'k': 'wisdom', 'v': 18}
        ],
      };
    expect(spellPresentationContextForCharacter(data, 'wisdom').abilityModifier,
        4);
    expect(
        characterFeatureModifierInput(data)
            .context
            .abilityModifiers['charisma'],
        3);
    expect(spellPresentationContextForCharacter({}, null).casterLevel, 1);
  });
}
