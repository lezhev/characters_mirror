import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

Map<String, dynamic> character(Map<String, dynamic> activation) => {
      'derived': {
        'spellSlots': {'1': 2},
        'pactSlots': {'1': 1},
        'activeFeatures': [
          {
            'sourceType': 'classFeature',
            'sourceId': 12,
            'sourceClassLevel': 5,
            'resources': [
              {'key': 'ki', 'max': 3}
            ]
          }
        ],
        'resolvedSpells': [
          {
            'spellKey': 'burning_hands',
            'spell': {'level': 1},
            'sources': [
              {
                'sourceKey': 'grant:1',
                'label': 'grant',
                'activation': activation,
                'resourceSourceType': 'classFeature',
                'resourceSourceId': 12,
              }
            ]
          }
        ]
      }
    };
Map<String, dynamic> action(String payment, {String pool = 'none'}) => {
      'spellKey': 'burning_hands',
      'spellSourceKey': 'grant:1',
      'level': 1,
      'slotSource': pool,
      'spellPayment': payment
    };

void main() {
  test('resource-only grants spend ki atomically, never slots', () {
    final c = character({
      'canUseStandardSlots': false,
      'canUsePactSlots': false,
      'slotless': true,
      'atWill': false,
      'resourceKey': 'ki',
      'resourceCost': 2
    });
    final patch = applySpellCast(c, action('resource'));
    expect((patch['resourceStates'] as List).single['current'], 1);
    expect(patch.containsKey('currentSpellSlots'), false);
    expect(() => applySpellCast({...c, ...patch}, action('resource')),
        throwsA(isA<SpellCastFailure>()));
    expect(() => applySpellCast(c, action('slot', pool: 'standard')),
        throwsA(isA<SpellCastFailure>()));
  });
  test('arcanum free cast expires and only long rest resets it', () {
    final c = character({
      'canUseStandardSlots': false,
      'canUsePactSlots': false,
      'slotless': true,
      'atWill': false,
      'freeCasts': 1,
      'resetOn': 'longRest'
    });
    final spent = {...c, ...applySpellCast(c, action('free'))};
    expect(() => applySpellCast(spent, action('free')),
        throwsA(isA<SpellCastFailure>()));
    expect(spellActivationRestPatch(spent, 'shortRest'), isEmpty);
    final rested = {...spent, ...spellActivationRestPatch(spent, 'longRest')};
    expect(() => applySpellCast(rested, action('free')), returnsNormally);
  });
  test('source cast limits count slot casts and reset only on configured rest',
      () {
    final base = character({
      'canUseStandardSlots': false,
      'canUsePactSlots': true,
      'slotless': false,
      'atWill': false,
      'maxCasts': 1,
      'castsResetOn': 'longRest',
    });
    final c = {
      ...base,
      'derived': {
        ...base['derived'] as Map,
        'pactSlots': {'1': 2},
      },
    };
    final spent = {...c, ...applySpellCast(c, action('slot', pool: 'pact'))};
    expect(spent['spellActivationUses'], {'castLimit:grant:1': 1});
    expect(() => applySpellCast(spent, action('slot', pool: 'pact')),
        throwsA(isA<SpellCastFailure>()));
    expect(spellActivationRestPatch(spent, 'shortRest'), isEmpty);
    final rested = {...spent, ...spellActivationRestPatch(spent, 'longRest')};
    expect(rested['spellActivationUses'], isNull);
    expect(
        () => applySpellCast({
              ...rested,
              'currentPactSlots': {'1': 1}
            }, action('slot', pool: 'pact')),
        returnsNormally);
  });
  test('cast limits belong to one spell source and reject invalid policies',
      () {
    final policy = {
      'canUseStandardSlots': false,
      'canUsePactSlots': true,
      'slotless': false,
      'atWill': false,
      'maxCasts': 1,
      'castsResetOn': 'longRest',
    };
    final base = character(policy);
    final c = {
      ...base,
      'derived': {
        ...base['derived'] as Map,
        'pactSlots': {'1': 2},
      },
    };
    final otherSource = SpellSourceContext(
      sourceKey: 'grant:other',
      label: 'Other grant',
      activation: policy,
    );
    final spent = {...c, ...applySpellCast(c, action('slot', pool: 'pact'))};
    expect(
        availableSpellCasts('burning_hands', 1, [otherSource],
                SpellSlotPools.fromCharacter(spent),
                character: spent)
            .single
            .source
            .sourceKey,
        'grant:other');
    expect(
        () => validateSpellActivation({
              ...policy,
              'maxCasts': 0,
            }),
        throwsA(isA<SpellCastFailure>()));
  });
  test('standard and pact permissions are independent', () {
    final c = character({
      'canUseStandardSlots': true,
      'canUsePactSlots': false,
      'slotless': false,
      'atWill': false
    });
    expect(
        applySpellCast(
            c, action('slot', pool: 'standard'))['currentSpellSlots'],
        {'1': 1});
    expect(() => applySpellCast(c, action('slot', pool: 'pact')),
        throwsA(isA<SpellCastFailure>()));
  });
  test('fixed cast level and at-will grants do not materialize counters', () {
    final c = character({
      'canUseStandardSlots': false,
      'canUsePactSlots': false,
      'slotless': true,
      'atWill': true,
      'castAtSpellLevel': 3
    });
    final patch = applySpellCast(c, {...action('atWill'), 'level': 3});
    expect(patch.keys, ['activeConcentrationSpellName']);
    expect(() => applySpellCast(c, action('atWill')),
        throwsA(isA<SpellCastFailure>()));
    expect(
        () =>
            applySpellCast({...c, ...patch}, {...action('atWill'), 'level': 3}),
        returnsNormally);
  });

  test('resource-funded upcast derives cast level and payment from policy', () {
    final activation = {
      'canUseStandardSlots': false,
      'canUsePactSlots': false,
      'slotless': true,
      'atWill': false,
      'resourceKey': 'ki',
      'resourceCost': 2,
      'resourceUpcastPolicy': {
        'resourcePerAdditionalSpellLevel': 1,
        'maxResourceCostBySourceLevel': {'1': 2, '5': 3},
      },
    };
    final c = character(activation);
    final pools = SpellSlotPools.fromCharacter(c);
    final source = SpellSourceContext(
        sourceKey: 'grant:1',
        label: 'grant',
        activation: activation,
        resourceSourceType: 'classFeature',
        resourceSourceId: 12);
    final choices =
        availableSpellCasts('burning_hands', 1, [source], pools, character: c);

    expect(choices.map((choice) => (choice.castLevel, choice.resourceCost)),
        [(1, 2), (2, 3)]);
    final moreResource = {
      ...c,
      'derived': {
        ...c['derived'] as Map,
        'activeFeatures': [
          {
            'sourceType': 'classFeature',
            'sourceId': 12,
            'sourceClassLevel': 5,
            'resources': [
              {'key': 'ki', 'max': 5}
            ],
          }
        ],
      },
    };
    final baseCast = applySpellCast(moreResource, action('resource'));
    expect((baseCast['resourceStates'] as List).single['current'], 3);
    final cast = applySpellCast(c, {...action('resource'), 'level': 2});
    expect((cast['resourceStates'] as List).single['current'], 0);
    expect(cast.containsKey('currentSpellSlots'), false);
    expect(
        () => applySpellCast(moreResource, {...action('resource'), 'level': 3}),
        throwsA(isA<SpellCastFailure>()));
    expect(() => applySpellCast(c, action('slot', pool: 'standard')),
        throwsA(isA<SpellCastFailure>()));
    expect(() => applySpellCast(c, action('slot', pool: 'pact')),
        throwsA(isA<SpellCastFailure>()));

    final short = {
      ...c,
      'resourceStates': [
        {
          'sourceType': 'classFeature',
          'sourceId': 12,
          'resourceKey': 'ki',
          'current': 1,
        }
      ],
    };
    expect(() => applySpellCast(short, action('resource')),
        throwsA(isA<SpellCastFailure>()));
  });
}
