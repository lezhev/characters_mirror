import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter/material.dart';

class CombatStatsRow extends StatelessWidget {
  const CombatStatsRow({
    required this.character,
    required this.onHpPressed,
    super.key,
  });

  final CharacterData character;
  final VoidCallback onHpPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CombatStatButton(
            icon: Icons.favorite,
            value: formatHpLabel(character),
            onPressed: onHpPressed,
          ),
        ),
        Expanded(
          child: CombatStatButton(
            icon: Icons.bolt,
            value: formatInitiativeLabel(character),
          ),
        ),
        Expanded(
          child: CombatStatButton(
            icon: Icons.shield_outlined,
            value: formatArmorClassLabel(character),
          ),
        ),
      ],
    );
  }
}

class CombatStatButton extends StatelessWidget {
  const CombatStatButton({
    required this.icon,
    required this.value,
    this.onPressed,
    super.key,
  });

  final IconData icon;
  final String value;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed ?? () {},
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.transparent,
          overlayColor:
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          iconSize: 22,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
        ),
        label: Text(
          value,
          overflow: TextOverflow.ellipsis,
          style: textTheme.titleMedium,
        ),
      ),
    );
  }
}
