import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  const resolver = SpellPresentationResolver();
  test('healing scaling and source modifier require explicit data', () {
    final spell = <String, dynamic>{
      'level': 1,
      'isHealing': true,
      'healingDice': '1d8',
      'healingAddsCastingModifier': true,
      'healingScaling': {
        'mode': 'slotLevel',
        'scalingBySlotLevel': {'3': '3d8'},
      },
    };
    final positive = resolver.resolve(spell,
        context:
            const SpellPresentationContext(castLevel: 3, abilityModifier: 4));
    expect(positive.highlights.single.label, 'Лечение');
    expect(positive.highlights.single.value, '3к8 + 4');
    final negative = resolver.resolve(spell,
        context:
            const SpellPresentationContext(castLevel: 3, abilityModifier: -2));
    expect(negative.highlights.single.value, '3к8 - 2');
    final unknown = resolver.resolve(spell,
        context: const SpellPresentationContext(castLevel: 3));
    expect(unknown.highlights.single.value, '3к8 + модификатор');
    final unsupported = resolver.resolve(spell,
        context: const SpellPresentationContext(castLevel: 4));
    expect(unsupported.highlights.single.label, 'Лечение (база)');
    spell.remove('healingAddsCastingModifier');
    expect(
        resolver
            .resolve(spell,
                context: const SpellPresentationContext(
                    castLevel: 3, abilityModifier: 4))
            .highlights
            .single
            .value,
        '3к8');
  });
  test('separate damage triggers are not presented as one sum', () {
    final p = resolver.resolve({
      'damageParts': [
        {'formula': '2d6', 'damageType': 'cold', 'notes': 'Start of turn'},
        {'formula': '2d6', 'damageType': 'acid', 'notes': 'End, failed save'},
      ],
    });
    expect(p.highlights.single.value, contains('; '));
    expect(p.highlights.single.value, isNot(contains(' + ')));
    expect(p.highlights.single.value, contains('Start of turn'));
    expect(p.highlights.single.value, contains('End, failed save'));
  });
  test('area radius length width and height remain distinguishable', () {
    final p = resolver.resolve({
      'areaOfEffectType': 'cylinder',
      'areaOfEffectSizeKind': 'radius',
      'areaOfEffectSize': 20,
      'areaOfEffectHeight': 40,
    });
    expect(p.highlights.single.value, 'Цилиндр · радиус 20 фт., высота 40 фт.');
    final line = resolver.resolve({
      'areaOfEffectType': 'line',
      'areaOfEffectSizeKind': 'length',
      'areaOfEffectSize': 100,
      'areaOfEffectSecondarySize': 5,
    });
    expect(line.highlights.single.value, 'Линия · длина 100 фт., ширина 5 фт.');
  });
  test('legacy dimensions do not invent radius or physical height', () {
    final p = resolver.resolve({
      'areaOfEffectType': 'sphere',
      'areaOfEffectSize': 3,
      'areaOfEffectHeight': 3,
    });
    expect(p.highlights.single.value, 'Сфера · 3 × 3 фт.');
  });
  test('legacy none area and target sentinels do not add highlights', () {
    expect(
        resolver.resolve({
          'areaOfEffectType': 'none',
          'targetType': 'none',
        }).highlights,
        isEmpty);
  });
}
