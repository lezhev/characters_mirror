import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  test('limited racial cantrip does not pretend its free casts are unlimited',
      () {
    const source = SpellSourceContext(
        sourceKey: 'race:1',
        label: 'Race',
        canUseSlots: false,
        freeCastsFormula: '1',
        freeCastsPerRest: 'longRest');
    final pools = SpellSlotPools.fromCharacter({});
    expect(availableSpellCasts('spell', 0, [source], pools), isEmpty);
  });
  final spell = {
    'referenceKey': 'spell',
    'level': 1,
    'name': 'Spell',
    'concentration': true
  };
  final character = {
    'currentHp': 7,
    'activeConditions': ['poisoned'],
    'derived': {
      'spellSlots': {'1': 2, '3': 1},
      'pactSlots': {'3': 2},
      'resolvedSpells': [
        {
          'spellKey': 'spell',
          'spell': spell,
          'sources': [
            const SpellSourceContext(
                    sourceKey: 'class:1',
                    label: 'Wizard',
                    castingAbility: 'intelligence')
                .toJson()
          ]
        }
      ]
    }
  };
  Map<String, dynamic> action(String pool, int level) => {
        'spellKey': 'spell',
        'spellSourceKey': 'class:1',
        'slotSource': pool,
        'level': level
      };
  test(
      'upcast spends chosen standard slot and preserves pact, HP and conditions',
      () {
    final patch = applySpellCast(character, action('standard', 3));
    expect(patch['currentSpellSlots'], {'3': 0});
    expect(patch['currentPactSlots'], {'3': 2});
    expect(patch['activeConcentrationSpellName'], 'Spell');
    expect(patch.containsKey('currentHp'), false);
    expect(patch.containsKey('activeConditions'), false);
  });
  test('lower spell can use higher pact slot and spends only pact', () {
    final patch = applySpellCast(character, action('pact', 3));
    expect(patch['currentPactSlots'], {'3': 1});
    expect(patch['currentSpellSlots'], isNull);
  });
  test('unavailable slot, source and undercast are rejected', () {
    expect(() => applySpellCast(character, action('standard', 2)),
        throwsA(isA<SpellCastFailure>()));
    expect(() => applySpellCast(character, action('pact', 1)),
        throwsA(isA<SpellCastFailure>()));
    expect(
        () => applySpellCast(
            character, {...action('standard', 1), 'spellSourceKey': 'other'}),
        throwsA(isA<SpellCastFailure>()));
    expect(() => applySpellCast(character, action('none', 0)),
        throwsA(isA<SpellCastFailure>()));
  });
  test('legacy mixed pool splits without restoring spent resources', () {
    final pools = SpellSlotPools.fromCharacter({
      ...character,
      'currentSpellSlots': {'3': 1}
    });
    expect(pools.available(SpellSlotSource.standard, 3), 1);
    expect(pools.available(SpellSlotSource.pact, 3), 0);
  });
  test('cantrip costs no slot and keeps existing concentration', () {
    final c = {
      ...character,
      'activeConcentrationSpellName': 'Existing',
      'derived': {
        'resolvedSpells': [
          {
            'spellKey': 'spell',
            'spell': {...spell, 'level': 0, 'concentration': false},
            'sources': [
              const SpellSourceContext(sourceKey: 'class:1', label: 'Class')
                  .toJson()
            ]
          }
        ]
      }
    };
    final patch = applySpellCast(c, action('none', 0));
    expect(patch['activeConcentrationSpellName'], 'Existing');
    expect(patch['currentSpellSlots'], isNull);
  });
}
