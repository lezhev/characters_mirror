import 'package:flutter/material.dart';

class ActiveConcentrationOverlay extends StatelessWidget {
  const ActiveConcentrationOverlay({
    required this.spellName,
    required this.expanded,
    required this.onToggle,
    required this.onCollapse,
    required this.onCancel,
    super.key,
  });

  final String spellName;
  final bool expanded;
  final VoidCallback onToggle;
  final VoidCallback onCollapse;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    if (!expanded) {
      return Material(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        child: IconButton(
          key: const ValueKey('active-concentration-icon'),
          onPressed: onToggle,
          icon: const Icon(Icons.blur_on),
          color: colorScheme.primary,
          tooltip: 'Концентрация',
        ),
      );
    }

    return Material(
      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.96),
      borderRadius: BorderRadius.circular(8),
      elevation: 4,
      child: InkWell(
        key: const ValueKey('active-concentration-panel'),
        borderRadius: BorderRadius.circular(8),
        onTap: onCollapse,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.blur_on, size: 18, color: colorScheme.primary),
              const SizedBox(width: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: Text(
                  'Концентрация на заклинании $spellName',
                  key: const ValueKey('active-concentration-text'),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              IconButton(
                key: const ValueKey('active-concentration-cancel'),
                onPressed: onCancel,
                icon: const Icon(Icons.remove_circle_outline),
                color: colorScheme.onSurfaceVariant,
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
