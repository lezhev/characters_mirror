import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

const slotPolicy = {
  'canUseStandardSlots': true,
  'canUsePactSlots': false,
  'slotless': false,
  'atWill': false,
};
const freePolicy = {
  'canUseStandardSlots': false,
  'canUsePactSlots': false,
  'slotless': true,
  'atWill': false,
  'freeCasts': 1,
  'resetOn': 'longRest',
};

SpellSourceContext source(Map<String, dynamic> policy) =>
    SpellSourceContext(sourceKey: 'grant', label: 'Grant', activation: policy);

void main() {
  final invalid = <String, Map<String, dynamic>>{
    'no payment method': {...slotPolicy, 'canUseStandardSlots': false},
    'slotless without payment': {...slotPolicy, 'slotless': true},
    'at-will with resource': {
      ...freePolicy,
      'freeCasts': null,
      'resetOn': null,
      'atWill': true,
      'resourceKey': 'ki',
      'resourceCost': 2,
    },
    'at-will with free counter': {...freePolicy, 'atWill': true},
    'at-will without slotless': {...slotPolicy, 'atWill': true},
    'resource without slotless': {
      ...slotPolicy,
      'resourceKey': 'ki',
      'resourceCost': 2,
    },
    'free counter without slotless': {...freePolicy, 'slotless': false},
    'resource missing cost': {...freePolicy, 'resourceKey': 'ki'},
    'cost missing resource': {...freePolicy, 'resourceCost': 2},
    'empty resource key': {
      ...freePolicy,
      'resourceKey': ' ',
      'resourceCost': 2
    },
    'zero resource cost': {
      ...freePolicy,
      'resourceKey': 'ki',
      'resourceCost': 0
    },
    'negative resource cost': {
      ...freePolicy,
      'resourceKey': 'ki',
      'resourceCost': -1
    },
    'fractional resource cost': {
      ...freePolicy,
      'resourceKey': 'ki',
      'resourceCost': 1.5
    },
    'zero free casts': {...freePolicy, 'freeCasts': 0},
    'negative free casts': {...freePolicy, 'freeCasts': -1},
    'free casts missing reset': {...freePolicy, 'resetOn': null},
    'reset without free casts': {...slotPolicy, 'resetOn': 'longRest'},
    'unknown reset': {...freePolicy, 'resetOn': 'weekly'},
    'negative cast level': {...slotPolicy, 'castAtSpellLevel': -1},
    'cast level above nine': {...slotPolicy, 'castAtSpellLevel': 10},
    'missing permission': {...slotPolicy, 'canUsePactSlots': null},
    'non-boolean permission': {...slotPolicy, 'slotless': 'true'},
    'upcast without a resource payment': {
      ...freePolicy,
      'resourceUpcastPolicy': {
        'resourcePerAdditionalSpellLevel': 1,
        'maxResourceCostBySourceLevel': {1: 3},
      }
    },
    'upcast with a zero step': {
      ...freePolicy,
      'resourceKey': 'ki',
      'resourceCost': 2,
      'resourceUpcastPolicy': {
        'resourcePerAdditionalSpellLevel': 0,
        'maxResourceCostBySourceLevel': {1: 3},
      }
    },
    'upcast limit below base cost': {
      ...freePolicy,
      'resourceKey': 'ki',
      'resourceCost': 2,
      'resourceUpcastPolicy': {
        'resourcePerAdditionalSpellLevel': 1,
        'maxResourceCostBySourceLevel': {1: 1, 5: 3},
      }
    },
    'decreasing upcast limit': {
      ...freePolicy,
      'resourceKey': 'ki',
      'resourceCost': 2,
      'resourceUpcastPolicy': {
        'resourcePerAdditionalSpellLevel': 1,
        'maxResourceCostBySourceLevel': {1: 4, 5: 3},
      }
    },
    'upcast with slot permissions': {
      ...freePolicy,
      'canUseStandardSlots': true,
      'resourceKey': 'ki',
      'resourceCost': 2,
      'resourceUpcastPolicy': {
        'resourcePerAdditionalSpellLevel': 1,
        'maxResourceCostBySourceLevel': {1: 2, 5: 3},
      }
    },
  };
  for (final entry in invalid.entries) {
    test('rejects ${entry.key} before offering casts', () {
      final s = source(entry.value);
      final failure = throwsA(isA<SpellCastFailure>()
          .having((e) => e.code, 'code', 'invalid_activation'));
      expect(() => spellActivationPolicy(s), failure);
      expect(
          () => availableSpellCasts(
              'spell',
              1,
              [s],
              SpellSlotPools.fromCharacter({
                'derived': {
                  'spellSlots': {'1': 2}
                }
              })),
          failure);
    });
  }

  test('finite payments and slot pools may be alternative methods', () {
    final policy = {
      ...freePolicy,
      'canUseStandardSlots': true,
      'canUsePactSlots': true,
      'resourceKey': 'ki',
      'resourceCost': 2,
    };
    expect(spellActivationPolicy(source(policy)), policy);
  });

  Map<String, dynamic> raceCharacter(Map<String, dynamic>? activation) => {
        'race': {
          'features': [
            {
              'id': 4,
              'spellGrants': [
                {
                  'spellId': 5,
                  'activation': activation,
                  'canAlsoCastWithSpellSlots': true,
                  'freeCastsFormula': '9',
                  'freeCastsPerRest': 'shortRest',
                  'castAtSpellLevel': 4,
                }
              ]
            }
          ]
        },
        'derived': {
          'spellSlots': {'1': 2},
          'pactSlots': {'1': 1}
        },
      };
  const spell = {'id': 5, 'referenceKey': 'spell', 'level': 1};

  test('race activation wholly overrides conflicting legacy fields', () {
    final c = raceCharacter(freePolicy);
    final resolved =
        resolveCharacterSpellCollection(character: c, spells: [spell]).single;
    final s = resolved.sources.single;
    final casts = availableSpellCasts(
        'spell', 1, [s], SpellSlotPools.fromCharacter(c),
        character: c);
    expect(casts.map((c) => (c.payment, c.castLevel)), [('free', 1)]);
    expect(s.canUseSlots, false);
    expect(s.freeCastsFormula, isNull);
    expect(s.freeCastsPerRest, isNull);
    expect(s.castAtSpellLevel, isNull);
    final spent = {
      ...c,
      'spellActivationUses': {s.sourceKey: 1},
      'derived': {
        ...c['derived'] as Map,
        'resolvedSpells': [resolved.toJson()]
      }
    };
    expect(spellActivationRestPatch(spent, 'shortRest'), isEmpty);
    expect(spellActivationRestPatch(spent, 'longRest')['spellActivationUses'],
        isNull);
    expect(
        availableSpellCasts(
            'spell', 1, [s], SpellSlotPools.fromCharacter(spent),
            character: spent),
        isEmpty);
  });

  test('legacy race fields are used only without activation', () {
    final c = raceCharacter(null);
    final s = resolveCharacterSpellCollection(character: c, spells: [spell])
        .single
        .sources
        .single;
    final casts = availableSpellCasts(
        'spell', 1, [s], SpellSlotPools.fromCharacter(c),
        character: c);
    expect(casts.map((c) => (c.payment, c.castLevel, c.slotSource)), [
      ('free', 4, SpellSlotSource.none),
      (null, 1, SpellSlotSource.standard),
      (null, 1, SpellSlotSource.pact),
    ]);
  });

  test('explicit slot permission does not inherit legacy free casts or level',
      () {
    final c = raceCharacter(slotPolicy);
    final s = resolveCharacterSpellCollection(character: c, spells: [spell])
        .single
        .sources
        .single;
    final casts = availableSpellCasts(
        'spell', 1, [s], SpellSlotPools.fromCharacter(c),
        character: c);
    expect(casts.map((c) => (c.payment, c.castLevel, c.slotSource)), [
      ('slot', 1, SpellSlotSource.standard),
    ]);
  });

  test('active class grant policies are validated during collection', () {
    expect(
        () => resolveCharacterSpellCollection(character: {
              'classEntries': [
                {
                  'classData': {'id': 1},
                  'level': 1
                }
              ]
            }, spells: [
              spell
            ], classGrants: [
              {
                'id': 2,
                'sourceClassId': 1,
                'spellId': 5,
                'activation': {...slotPolicy, 'canUseStandardSlots': false},
              }
            ]),
        throwsA(isA<SpellCastFailure>()));
  });

  test('explicit invalid race policy cannot fall back to legacy permissions',
      () {
    expect(
        () => resolveCharacterSpellCollection(
            character:
                raceCharacter({...slotPolicy, 'canUseStandardSlots': false}),
            spells: [spell]),
        throwsA(isA<SpellCastFailure>()));
  });
}
