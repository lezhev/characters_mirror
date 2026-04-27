import 'dart:collection';

import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_value_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RollValueButton', () {
    testWidgets('rolls modifier values as d20 plus bonus', (tester) async {
      await _pumpRollButton(
        tester,
        RollValueButton(
          label: '+4',
          mode: RollValueMode.modifier,
          diceRoller: _rollerWithValues([15]),
        ),
      );

      await tester.tap(find.text('+4'));
      await tester.pump();

      expect(find.text('d20 + 4 = 15 + 4 = 19'), findsOneWidget);
    });

    testWidgets('rolls formula values without adding d20', (tester) async {
      await _pumpRollButton(
        tester,
        RollValueButton(
          label: '2d6 + 1',
          mode: RollValueMode.formula,
          diceRoller: _rollerWithValues([2, 3]),
        ),
      );

      await tester.tap(find.text('2d6 + 1'));
      await tester.pump();

      expect(find.text('2d6 + 1 = (2 + 3) + 1 = 6'), findsOneWidget);
    });

    testWidgets('closes roll result messages', (tester) async {
      await _pumpRollButton(
        tester,
        RollValueButton(
          label: '+0',
          mode: RollValueMode.modifier,
          diceRoller: _rollerWithValues([10]),
        ),
      );

      await tester.tap(find.text('+0'));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('roll-result-close')));
      await tester.pump();

      expect(find.text('d20 + 0 = 10 + 0 = 10'), findsNothing);
    });

    testWidgets('close button works when overlay wraps MaterialApp child',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) {
            return RollResultsOverlay(
              child: child ?? const SizedBox.shrink(),
            );
          },
          home: Scaffold(
            body: Center(
              child: RollValueButton(
                label: '+0',
                mode: RollValueMode.modifier,
                diceRoller: _rollerWithValues([10]),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('+0'));
      await tester.pump();
      await tester.tap(find.byKey(const ValueKey('roll-result-close')));
      await tester.pump();

      expect(find.text('d20 + 0 = 10 + 0 = 10'), findsNothing);
    });

    testWidgets('keeps only the latest visible messages', (tester) async {
      await _pumpRollButton(
        tester,
        RollValueButton(
          label: '+0',
          mode: RollValueMode.modifier,
          diceRoller: _rollerWithValues([1, 2, 3, 4]),
        ),
        maxVisibleMessages: 3,
      );

      for (var index = 0; index < 4; index++) {
        await tester.tap(find.text('+0'));
        await tester.pump();
      }

      expect(find.text('d20 + 0 = 1 + 0 = 1'), findsNothing);
      expect(find.text('d20 + 0 = 2 + 0 = 2'), findsOneWidget);
      expect(find.text('d20 + 0 = 3 + 0 = 3'), findsOneWidget);
      expect(find.text('d20 + 0 = 4 + 0 = 4'), findsOneWidget);
    });

    testWidgets('shows close button only on latest message and clears all',
        (tester) async {
      await _pumpRollButton(
        tester,
        RollValueButton(
          label: '+0',
          mode: RollValueMode.modifier,
          diceRoller: _rollerWithValues([1, 2, 3]),
        ),
      );

      for (var index = 0; index < 3; index++) {
        await tester.tap(find.text('+0'));
        await tester.pump();
      }

      expect(find.byKey(const ValueKey('roll-result-close')), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('roll-result-close')));
      await tester.pump();

      expect(find.text('d20 + 0 = 1 + 0 = 1'), findsNothing);
      expect(find.text('d20 + 0 = 2 + 0 = 2'), findsNothing);
      expect(find.text('d20 + 0 = 3 + 0 = 3'), findsNothing);
    });
  });
}

Future<void> _pumpRollButton(
  WidgetTester tester,
  Widget button, {
  int maxVisibleMessages = 8,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: RollResultsOverlay(
        maxVisibleMessages: maxVisibleMessages,
        child: Scaffold(
          body: Center(child: button),
        ),
      ),
    ),
  );
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
