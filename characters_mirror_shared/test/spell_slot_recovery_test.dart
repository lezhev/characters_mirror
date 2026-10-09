import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

Map<String, dynamic> fixture(
        {String mode = 'levelBudget',
        String pool = 'spellSlots',
        String trigger = 'shortRest',
        int castLevel = 4,
        bool resource = true}) =>
    {
      'classEntries': [],
      'derived': {
        'spellSlots': {'1': 4, '2': 3, '3': 3, '4': 1, '5': 1, '6': 1},
        'pactSlots': {'3': 2},
        'activeFeatures': [
          {
            'sourceType': 'classFeature',
            'sourceId': 41,
            'sourceClassLevel': 5,
            'resources': resource
                ? [
                    {'key': 'recovery', 'current': 1, 'max': 1}
                  ]
                : [],
            'spellSlotRecoveryEffects': [
              {
                'id': 42,
                'type': 'restore',
                'targetType': pool,
                'activationTrigger': trigger,
                'recoveryPolicy': {
                  'mode': mode,
                  if (resource) 'resourceKey': 'recovery',
                  'levelBudgetBySourceLevel': {
                    '1': 1,
                    '2': 1,
                    '3': 2,
                    '4': 2,
                    '5': 3
                  },
                  if (mode != 'all') 'maximumSlotLevel': 5,
                  if (mode == 'singleLowerLevel') 'minimumCastLevel': 2,
                  if (mode == 'singleLowerLevel') 'spellSchool': 'divination',
                },
              }
            ],
          }
        ],
      },
      'currentSpellSlots': {'1': 2, '2': 1, '3': 1, '4': 0, '5': 0, '6': 0},
      'currentPactSlots': {'3': 0},
      'spellRecoveryTriggers': {
        'classFeature:41:42': {
          'sourceActionId': 'event',
          'trigger': trigger,
          'castLevel': castLevel
        },
      },
    };

Map<String, dynamic> action(Map<int, int> slots,
        {String source = 'standard', bool resource = true}) =>
    {
      'sourceType': 'classFeature',
      'sourceId': 41,
      'recoveryEffectId': 42,
      'slotSource': source,
      'slotsToRestore': {for (final e in slots.entries) '${e.key}': e.value},
      if (resource) 'resourceKey': 'recovery',
      'recoveryTriggerId': 'event',
    };

void main() {
  test('source-level budget restores and spends a use in one patch', () {
    final character = fixture();
    final patch = applySpellSlotRecovery(character, action({1: 1, 2: 1}));
    final pools = SpellSlotPools.fromCharacter({...character, ...patch});
    expect(pools.standardCurrent[1], 3);
    expect(pools.standardCurrent[2], 2);
    expect((patch['resourceStates'] as List).single['current'], 0);
    expect(spellSlotRecoveryTriggers({...character, ...patch}), isEmpty);
  });
  test('rejects overspending budget, high levels and unspent slots', () {
    for (final slots in [
      {2: 2},
      {6: 1},
      {1: 3},
      {2: -1},
      <int, int>{}
    ]) {
      expect(() => applySpellSlotRecovery(fixture(), action(slots)),
          throwsA(isA<SpellCastFailure>()));
    }
    expect(
        () => applySpellSlotRecovery(
            {...fixture(), 'currentSpellSlots': null}, action({1: 1})),
        throwsA(isA<SpellCastFailure>()));
  });
  test('expert divination restores exactly one lower slot, at most fifth', () {
    final character = fixture(
        mode: 'singleLowerLevel', trigger: 'spellCast', resource: false);
    final patch =
        applySpellSlotRecovery(character, action({3: 1}, resource: false));
    expect(
        SpellSlotPools.fromCharacter({...character, ...patch})
            .standardCurrent[3],
        2);
    for (final slots in [
      {4: 1},
      {1: 2},
      {1: 1, 2: 1},
      {6: 1}
    ]) {
      expect(
          () =>
              applySpellSlotRecovery(character, action(slots, resource: false)),
          throwsA(isA<SpellCastFailure>()));
    }
  });
  test('eldritch master restores only pact slots', () {
    final character =
        fixture(mode: 'all', pool: 'pactSlots', trigger: 'manual');
    final patch = applySpellSlotRecovery(character, action({}, source: 'pact'));
    final pools = SpellSlotPools.fromCharacter({...character, ...patch});
    expect(pools.pactCurrent[3], 2);
    expect(pools.standardCurrent[3], 1);
  });
  test('missing and forged triggers or resource identities fail closed', () {
    for (final data in [
      {
        ...action({1: 1}),
        'recoveryTriggerId': 'fake'
      },
      {
        ...action({1: 1}),
        'resourceKey': 'other'
      },
      {
        ...action({1: 1}),
        'slotSource': 'pact'
      },
    ]) {
      expect(() => applySpellSlotRecovery(fixture(), data),
          throwsA(isA<SpellCastFailure>()));
    }
    expect(
        () => applySpellSlotRecovery(
            {...fixture(), 'spellRecoveryTriggers': null}, action({1: 1})),
        throwsA(isA<SpellCastFailure>()));
  });

  test('canonical maximum and resource exhaustion cannot be bypassed', () {
    final character = {
      ...fixture(),
      'currentSpellSlots': {'1': 4},
      'resourceStates': [
        {
          'sourceType': 'classFeature',
          'sourceId': 41,
          'resourceKey': 'recovery',
          'current': 0
        }
      ]
    };
    expect(
        spellSlotRecoveryOptions(
            character, characterSpellSlotRecoverySources(character).single),
        isEmpty);
    expect(() => applySpellSlotRecovery(character, action({1: 1})),
        throwsA(isA<SpellCastFailure>()));
    final full = {
      ...fixture(),
      'currentSpellSlots': {'1': 4}
    };
    expect(() => applySpellSlotRecovery(full, action({1: 1})),
        throwsA(isA<SpellCastFailure>()));
  });

  test('legacy combined counters materialize both pools without mixing', () {
    final character = {
      ...fixture(mode: 'all', pool: 'pactSlots', trigger: 'manual'),
      'currentPactSlots': null,
      'currentSpellSlots': {'3': 1}
    };
    final before = SpellSlotPools.fromCharacter(character);
    final patch = applySpellSlotRecovery(character, action({}, source: 'pact'));
    final after = SpellSlotPools.fromCharacter({...character, ...patch});
    expect(after.standardCurrent, before.standardCurrent);
    expect(after.pactCurrent[3], 2);
    expect(patch['currentPactSlots'], isNotNull);
    expect(
        spellSlotRecoveryActionTargetKeys(
            character, action({}, source: 'pact')),
        containsAll(['map:currentPactSlots:3', 'map:currentSpellSlots:3']));
  });

  test(
      'only actual qualifying cast events mint an opportunity; later casts invalidate it',
      () {
    final character = {
      ...fixture(
          mode: 'singleLowerLevel', trigger: 'spellCast', resource: false)
    };
    (character['derived'] as Map)['resolvedSpells'] = [
      {
        'spellKey': 'divination',
        'spell': {'level': 2, 'schoolValue': 'divination'}
      },
      {
        'spellKey': 'other',
        'spell': {'level': 2, 'schoolValue': 'evocation'}
      },
    ];
    Map<String, dynamic> event(String key, int level, String pool) =>
        spellSlotRecoveryEventPatch(character,
            event: 'spellCast',
            sourceActionId: 'new-cast',
            castAction: {'spellKey': key, 'level': level, 'slotSource': pool});
    for (final args in [
      ('other', 3, 'standard'),
      ('divination', 1, 'standard'),
      ('divination', 3, 'none')
    ]) {
      expect(
          spellSlotRecoveryTriggers(
              {...character, ...event(args.$1, args.$2, args.$3)}),
          isEmpty);
    }
    final triggered = {...character, ...event('divination', 7, 'pact')};
    expect(
        spellSlotRecoveryOptions(
                triggered, characterSpellSlotRecoverySources(triggered).single)
            .keys,
        [1, 2, 3, 4, 5]);
    expect(spellSlotRecoveryTriggers(triggered).values.single['sourceActionId'],
        'new-cast');
  });
  test('casting or a new day closes a previous short-rest recovery window', () {
    for (final event in ['spellCast', 'dawn']) {
      final character = fixture();
      final patch = spellSlotRecoveryEventPatch(character,
          event: event, sourceActionId: 'later');
      expect(spellSlotRecoveryTriggers({...character, ...patch}), isEmpty);
    }
  });
}
