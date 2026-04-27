import 'dart:collection';

import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiceRoller', () {
    test('rolls common dice formulas', () {
      final roller = _rollerWithValues([12, 7, 3, 4, 2, 5, 4]);

      expect(roller.roll('d20').total, 12);
      expect(roller.roll('к115').total, 7);
      expect(roller.roll('2d6 + 3').total, 10);
      expect(roller.roll('2к6 + (1к4 * 2)').total, 15);
    });

    test('expands dice before evaluating math operations', () {
      final roller = _rollerWithValues([2, 3, 4]);

      expect(
        roller.roll('2d6 + (1к4 * 2)'),
        _hasRoll('2d6 + (1к4 * 2)', 13, '(2 + 3) + (4 * 2)'),
      );
    });

    test('does not add an expanded formula when no dice are present', () {
      final result = DiceRoller(rollDie: (_) => 1).roll('5 + 2');

      expect(result.expandedFormula, isNull);
      expect(result.displayText, '5 + 2 = 7');
    });

    test('supports integer division rounded down', () {
      final roller = _rollerWithValues([3]);

      expect(roller.roll('1 / 2').total, 0);
      expect(roller.roll('-1 / 2').total, -1);
      expect(roller.roll('5 / 2 * 3').total, 6);
      expect(roller.roll('d6 / 2'), _hasRoll('d6 / 2', 1, '3 / 2'));
    });

    test('truncates long expanded formulas for display', () {
      final result = DiceRoller(rollDie: (_) => 1).roll('100d6');

      expect(result.total, 100);
      expect(result.expandedFormula, isNotNull);
      expect(result.expandedFormula!.length, lessThanOrEqualTo(240));
      expect(result.expandedFormula, endsWith('...'));
    });

    test('supports integers, unary minus, spaces, and separator case', () {
      final roller = _rollerWithValues([5, 6]);

      expect(roller.roll('5').total, 5);
      expect(roller.roll('-1').total, -1);
      expect(roller.roll(' D20 + -2 ').total, 3);
      expect(roller.roll(' 1 К 6 + 1 ').total, 7);
    });

    test('rolls modifiers as d20 plus displayed bonus', () {
      final roller = _rollerWithValues([14, 8]);

      expect(roller.rollModifier('+3'), _hasRoll('d20 + 3', 17, '14 + 3'));
      expect(roller.rollModifier('-2'), _hasRoll('d20 - 2', 6, '8 - 2'));
    });

    test('rejects invalid formulas', () {
      final roller = DiceRoller(rollDie: (_) => 1);

      expect(() => roller.roll(''), throwsA(isA<DiceRollException>()));
      expect(() => roller.roll('d'), throwsA(isA<DiceRollException>()));
      expect(() => roller.roll('0d6'), throwsA(isA<DiceRollException>()));
      expect(() => roller.roll('2d0'), throwsA(isA<DiceRollException>()));
      expect(() => roller.roll('1 / 0'), throwsA(isA<DiceRollException>()));
      expect(() => roller.roll('(1d4'), throwsA(isA<DiceRollException>()));
    });

    test('rejects expensive formulas before rolling dice', () {
      var rollCount = 0;
      final roller = DiceRoller(
        rollDie: (_) {
          rollCount++;
          return 1;
        },
      );

      expect(
        () => roller.roll('10000000*1000000d100000 *1999999999'),
        throwsA(isA<DiceRollException>()),
      );
      expect(rollCount, 0);
      expect(() => roller.roll('101d6'), throwsA(isA<DiceRollException>()));
      expect(
        () => roller.roll('100d6 + 100d6 + 100d6 + 100d6 + 100d6 + 1d6'),
        throwsA(isA<DiceRollException>()),
      );
      expect(
        () => roller.roll('1000000 * 1000000'),
        throwsA(isA<DiceRollException>()),
      );
      expect(
        () => roller.roll('d1000001'),
        throwsA(isA<DiceRollException>()),
      );
      expect(
        () => roller.roll(List.filled(257, '1').join('+')),
        throwsA(isA<DiceRollException>()),
      );
    });
  });
}

Matcher _hasRoll(String formula, int total, [String? expandedFormula]) {
  return isA<DiceRollResult>()
      .having((result) => result.formula, 'formula', formula)
      .having(
        (result) => result.expandedFormula,
        'expandedFormula',
        expandedFormula,
      )
      .having((result) => result.total, 'total', total);
}

DiceRoller _rollerWithValues(List<int> values) {
  final queue = Queue<int>.from(values);
  return DiceRoller(
    rollDie: (sides) {
      final value = queue.removeFirst();
      expect(value, inInclusiveRange(1, sides));
      return value;
    },
  );
}
