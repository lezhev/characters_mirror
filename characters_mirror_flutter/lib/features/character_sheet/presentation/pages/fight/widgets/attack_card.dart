import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';

class AttackCard extends StatelessWidget {
  const AttackCard({
    required this.attack,
    required this.attackBonusLabel,
    required this.damageLabel,
    required this.onNamePressed,
    super.key,
  });

  final CharacterAttackData attack;
  final String attackBonusLabel;
  final String damageLabel;
  final VoidCallback onNamePressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            _AttackValueButton(
              label: attackBonusLabel,
              onPressed: () {},
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
              child: _AttackValueButton(
                label: damageLabel,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttackValueButton extends StatelessWidget {
  const _AttackValueButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}
