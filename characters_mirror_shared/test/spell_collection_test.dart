import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  const spell = {'referenceKey': 'spell', 'name': 'Spell', 'level': 1};
  const entries = [
    {
      'level': 3,
      'classData': {
        'id': 1,
        'name': 'Wizard',
        'spellcastingAbilityValue': 'intelligence',
        'spellSelectionMode': 'known'
      }
    },
    {
      'level': 3,
      'classData': {
        'id': 2,
        'name': 'Cleric',
        'spellcastingAbilityValue': 'wisdom',
        'spellSelectionMode': 'known'
      }
    },
  ];
  List<ResolvedCharacterSpell> resolve(Map<String, dynamic> character,
          {List<Map<String, dynamic>> grants = const [],
          List<Map<String, dynamic>> options = const [],
          List<Map<String, dynamic>> groups = const []}) =>
      resolveCharacterSpellCollection(
          character: character,
          spells: [spell],
          classGrants: grants,
          selectedOptions: options,
          choiceGroups: groups);
  test('one visual entry preserves wizard and cleric sources', () {
    final result = resolve({
      'classEntries': entries,
      'spellSelections': [
        {'spell': spell, 'classDataId': 1},
        {'spell': spell, 'classDataId': 2},
      ]
    });
    expect(result, hasLength(1));
    expect(result.single.sources.map((s) => s.castingAbility),
        ['intelligence', 'wisdom']);
  });
  test(
      'ID-only writes and legacy selection names resolve to canonical identity',
      () {
    final result = resolveCharacterSpellCollection(character: {
      'classEntries': entries,
      'spellSelections': [
        {'spellId': 7, 'classDataId': 1},
        {'spellId': 7, 'spellKey': 'Legacy display name', 'classDataId': 2},
      ],
    }, spells: [
      {...spell, 'id': 7}
    ]);
    expect(result, hasLength(1));
    expect(result.single.spellKey, 'spell');
    expect(result.single.sources, hasLength(2));
  });
  test('selection entry identity wins over inconsistent class ID', () {
    final result = resolve({
      'classEntries': [
        {...entries[1], 'id': 'cleric'},
        {...entries[0], 'id': 'wizard'},
      ],
      'spellSelections': [
        {
          'spell': spell,
          'classDataId': 2,
          'classEntry': {'id': 'wizard'}
        },
      ]
    });
    expect(result.single.sources.single.castingAbility, 'intelligence');
  });
  test('grant only and always prepared resolve without persisted selections',
      () {
    final result = resolve({
      'classEntries': entries
    }, grants: [
      {
        'spell': spell,
        'sourceClassId': 2,
        'grantedAtLevel': 3,
        'alwaysPrepared': true
      },
    ]);
    expect(result.single.sources.single.alwaysPrepared, true);
    expect(result.single.sources.single.castingAbility, 'wisdom');
    expect(
        resolve({
          'classEntries': [
            {'level': 2, 'classData': entries[1]['classData']}
          ]
        }, grants: [
          {'spell': spell, 'sourceClassId': 2, 'grantedAtLevel': 3}
        ]),
        isEmpty);
  });
  test('preparing cleric source does not prepare wizard spellbook source', () {
    final result = resolve({
      'classEntries': [
        {
          ...entries[0],
          'classData': {
            ...entries[0]['classData'] as Map,
            'spellSelectionMode': 'spellbook'
          }
        },
        {
          ...entries[1],
          'classData': {
            ...entries[1]['classData'] as Map,
            'spellSelectionMode': 'prepared'
          }
        },
      ],
      'preparedSpellKeys': ['spell'],
      'spellSelections': [
        {'spell': spell, 'classDataId': 1, 'kind': 'spellbookSpell'},
        {'spell': spell, 'classDataId': 2, 'kind': 'preparedSpell'},
      ]
    });
    expect(result.single.sources.first.prepared, false);
    expect(result.single.sources.last.prepared, true);
  });
  test('conditional choice and grant disappear with selection replacement', () {
    const grant = {'spell': spell, 'sourceClassId': 1, 'choiceOptionId': 10};
    expect(resolve({'classEntries': entries}, grants: [grant]), isEmpty);
    expect(
        resolve({
          'classEntries': entries
        }, grants: [
          grant
        ], options: [
          {'id': 10}
        ]),
        hasLength(1));
  });
  test('choice-option class spell grant keeps its casting source and policy',
      () {
    final result = resolve(
      {'classEntries': entries},
      grants: [
        {
          'id': 27,
          'spell': spell,
          'sourceClassId': 2,
          'grantedAtLevel': 1,
          'choiceOptionId': 10,
          'castingAbility': 'wisdom',
          'alwaysPrepared': true,
          'activation': {
            'canUseStandardSlots': false,
            'canUsePactSlots': false,
            'slotless': true,
            'atWill': false,
            'freeCasts': 1,
            'resetOn': 'longRest',
          },
        },
      ],
      options: [
        {'id': 10}
      ],
    );
    final source = result.single.sources.single;
    expect(source.sourceKey, 'classGrant:27');
    expect(source.castingAbility, 'wisdom');
    expect(source.canUseSlots, isFalse);
    expect(source.alwaysPrepared, isTrue);
    expect(source.activation?['canUseStandardSlots'], isFalse);
    expect(source.activation?['canUsePactSlots'], isFalse);
  });
  test(
      'a selection attributed to a removed class cannot become an anonymous source',
      () {
    final result = resolve({
      'classEntries': [entries[1]],
      'spellSelections': [
        {'spell': spell, 'classDataId': 1, 'classEntry': entries[0]},
      ]
    });
    expect(result, isEmpty);
  });
  test('race level, ability, fixed level and free-cast gap are preserved', () {
    Map<String, dynamic> character(int level) => {
          'classEntries': [
            {'level': level, 'classData': entries[0]['classData']}
          ],
          'race': {
            'features': [
              {
                'id': 7,
                'level': 1,
                'name': 'Race',
                'spellGrants': [
                  {
                    'spell': spell,
                    'grantedAtLevel': 3,
                    'castingAbility': 'charisma',
                    'castAtSpellLevel': 2,
                    'canAlsoCastWithSpellSlots': false,
                    'freeCastsFormula': '1',
                    'freeCastsPerRest': 'longRest'
                  }
                ]
              }
            ]
          }
        };
    expect(resolve(character(2)), isEmpty);
    final source = resolve(character(3)).single.sources.single;
    expect(source.castingAbility, 'charisma');
    expect(source.canUseSlots, false);
    expect(source.castAtSpellLevel, 2);
    expect(source.freeCastsFormula, '1');
  });
}
