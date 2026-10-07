import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  final resolver = SpellPresentationResolver();
  test('full text and escaped paragraphs are retained without curated summary',
      () {
    final description = '${'Длинное описание. ' * 90}\\n\\nПоследний абзац.';
    final p = resolver.resolve({'name': 'Utility', 'description': description});
    expect(p.description, description.replaceAll(r'\n', '\n'));
    expect(p.displayDescription(compact: true), p.description);
    expect(p.highlights, isEmpty);
  });
  test('parts override legacy damage and scale only from structured maps', () {
    final p = resolver.resolve({
      'level': 3,
      'damageDice': '99d6',
      'damageType': 'cold',
      'damageParts': [
        {
          'formula': '8d6',
          'damageType': 'fire',
          'scaling': {
            'mode': 'slotLevel',
            'scalingBySlotLevel': {'5': '10d6'}
          }
        },
        {'formula': '1d4', 'damageType': 'force'}
      ],
      'requiresSavingThrow': true,
      'savingThrowAbility': 'dexterity',
      'areaOfEffectType': 'sphere',
      'areaOfEffectSize': 20,
    }, context: const SpellPresentationContext(castLevel: 5, saveDc: 16));
    expect(p.highlights.first.value, contains('10к6'));
    expect(p.highlights.first.value, contains('1к4'));
    expect(p.highlights.first.value, isNot(contains('99')));
    expect(p.highlights.first.damageParts.map((part) => part.formula),
        ['10к6', '1к4']);
    expect(p.highlights.first.damageParts.map((part) => part.damageType),
        ['fire', 'force']);
    expect(p.collapsedHighlights.map((h) => h.kind), [
      SpellHighlightKind.damage,
      SpellHighlightKind.save,
      SpellHighlightKind.area
    ]);
  });
  test('cantrip uses caster threshold and material prose retains newlines', () {
    final p = resolver.resolve({
      'damageDice': '1d10',
      'damageScaling': {
        'mode': 'casterLevel',
        'scalingByCasterLevel': {'5': '2d10', '11': '3d10'}
      },
      'materialDescription': r'Камень\nи нить',
      'materialCost': 10000,
      'materialConsumed': true,
      'requiresAttackRoll': true,
    }, context: const SpellPresentationContext(casterLevel: 7, attackBonus: 5));
    expect(p.highlights.first.value, contains('2к10'));
    expect(p.materialDescription, 'Камень\nи нить');
    expect(p.materialCost, 10000);
    expect(p.materialConsumed, true);
    expect(p.highlights[1].value, contains('+5'));
  });
  test('healing is a formula without invented modifier or inferred upcast', () {
    final p = resolver.resolve({
      'level': 1,
      'isHealing': true,
      'healingDice': '1d8',
      'higherLevel': r'Дополнительное лечение.\nЗа каждый уровень.'
    },
        context:
            const SpellPresentationContext(castLevel: 3, abilityModifier: 4));
    expect(p.highlights.first.kind, SpellHighlightKind.healing);
    expect(p.highlights.first.value, '1к8');
    expect(p.highlights.first.label, 'Лечение (база)');
    expect(p.higherLevel, 'Дополнительное лечение.\nЗа каждый уровень.');
  });
  test('curated summary is opt-in and never displaces full description', () {
    final p = resolver.resolve({
      'description': 'Правила.\n\nДалее.',
      'shortDescription': r'Кратко.\nИ ещё.'
    });
    expect(p.displayDescription(), 'Правила.\n\nДалее.');
    expect(p.displayDescription(compact: true), 'Кратко.\nИ ещё.');
  });
  test(
      'real line breaks and punctuation are preserved, other escapes stay literal',
      () {
    const source = 'Русский — текст.\r\n\r\nАбзац.\\t';
    expect(spellDescriptionText(source), source);
    expect(spellDescriptionText(r'Абзац.\r\n\r\nДалее.'), 'Абзац.\n\nДалее.');
  });
  test(
      'canonical no attack overrides old flag while save ability supplies typed highlight',
      () {
    final p = resolver.resolve({
      'attackType': 'none',
      'requiresAttackRoll': true,
      'savingThrowAbility': 'WIS',
      'requiresSavingThrow': false
    });
    expect(p.highlights.map((h) => h.kind), [SpellHighlightKind.save]);
    expect(p.highlights.single.value, 'WIS');
  });
  test(
      'special scaling retains notes and uncomputed upcast is labelled as base',
      () {
    final p = resolver.resolve({
      'level': 1,
      'damageDice': '1d6',
      'damageScaling': {
        'mode': 'special',
        'notes': r'Особое правило.\nСм. описание.'
      }
    }, context: const SpellPresentationContext(castLevel: 4));
    expect(p.highlights.first.label, 'Урон (база)');
    expect(p.highlights.last.value, 'Особое правило.\nСм. описание.');
  });
}
