import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/dice/dice_roller.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_value_button.dart';
import 'package:flutter/material.dart';

class AttackCard extends StatelessWidget {
  const AttackCard({
    required this.attack,
    required this.attackBonusLabel,
    required this.damageLabel,
    required this.damageRollValue,
    required this.onNamePressed,
    super.key,
    this.diceRoller,
    this.rollVariables = const {},
  });

  final CharacterAttackData attack;
  final String attackBonusLabel;
  final String damageLabel;
  final String damageRollValue;
  final VoidCallback onNamePressed;
  final DiceRoller? diceRoller;
  final Map<String, int> rollVariables;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            RollValueButton(
              label: attackBonusLabel,
              mode: RollValueMode.modifier,
              diceRoller: diceRoller,
              variables: rollVariables,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onNamePressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  child: Text(
                    attack.name ?? 'Название',
                    style: textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Align(
              alignment: Alignment.centerRight,
              child: RollValueButton(
                label: damageLabel,
                value: damageRollValue,
                mode: RollValueMode.formula,
                diceRoller: diceRoller,
                variables: rollVariables,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
