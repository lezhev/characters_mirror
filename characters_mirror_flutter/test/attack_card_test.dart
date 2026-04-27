import 'dart:collection';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/attack_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AttackCard', () {
    testWidgets('rolls attack bonus and damage buttons', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RollResultsOverlay(
            child: Scaffold(
              body: Center(
                child: AttackCard(
                  attack: CharacterAttackData(
                    name: 'Меч',
                    damage: '2d6 + 1',
                  ),
                  attackBonusLabel: '+5',
                  damageLabel: '2d6 + 1',
                  onNamePressed: () {},
                  diceRoller: _rollerWithValues([10, 2, 3]),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('+5'));
      await tester.pump();

      expect(find.text('d20 + 5 = 10 + 5 = 15'), findsOneWidget);

      await tester.tap(find.text('2d6 + 1'));
      await tester.pump();

      expect(find.text('2d6 + 1 = (2 + 3) + 1 = 6'), findsOneWidget);
    });
  });
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
