import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/compact_value_button.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:flutter/material.dart';

enum RollValueMode {
  modifier,
  formula,
}

class RollValueButton extends StatelessWidget {
  const RollValueButton({
    required this.label,
    required this.mode,
    super.key,
    this.value,
    this.width,
    this.diceRoller,
    this.variables = const {},
  });

  final String label;
  final String? value;
  final RollValueMode mode;
  final double? width;
  final DiceRoller? diceRoller;
  final Map<String, int> variables;

  @override
  Widget build(BuildContext context) {
    final rollValue = value ?? label;

    return CompactValueButton(
      label: label,
      width: width,
      onPressed: rollValue.trim().isEmpty
          ? null
          : () {
              final roller = diceRoller ?? DiceRoller(variables: variables);
              try {
                final result = switch (mode) {
                  RollValueMode.modifier => roller.rollModifier(rollValue),
                  RollValueMode.formula => roller.roll(rollValue),
                };
                RollResultsOverlay.show(
                  context,
                  result.displayText,
                );
              } on DiceRollException catch (error) {
                RollResultsOverlay.show(context, error.message);
              }
            },
    );
  }
}
