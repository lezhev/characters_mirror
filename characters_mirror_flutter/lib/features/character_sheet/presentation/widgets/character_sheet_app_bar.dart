import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';

class CharacterSheetAppBar extends StatelessWidget {
  const CharacterSheetAppBar({
    required this.characterName,
    required this.hasActiveStatus,
    required this.onBackPressed,
    required this.onQuickActionsPressed,
    required this.onSettingsPressed,
    required this.onMenuPressed,
    super.key,
  });

  final String characterName;
  final bool hasActiveStatus;
  final VoidCallback onBackPressed;
  final VoidCallback onQuickActionsPressed;
  final VoidCallback onSettingsPressed;
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: theme.appBarTheme.backgroundColor ?? colorScheme.surface,
      elevation: theme.appBarTheme.elevation ?? 0,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: PageSizeLimiter(
            child: Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  onPressed: onBackPressed,
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    characterName,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  key: const ValueKey('quick-actions-button'),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  tooltip: 'Быстрые действия',
                  onPressed: onQuickActionsPressed,
                  color: hasActiveStatus
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                  icon: const Icon(Icons.bolt_outlined),
                ),
                SheetAppBarAction(
                  icon: Icons.settings,
                  tooltip: 'Настройки персонажа',
                  onPressed: onSettingsPressed,
                ),
                SheetAppBarAction(
                  icon: Icons.menu,
                  tooltip: 'Характеристики',
                  onPressed: onMenuPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SheetAppBarAction extends StatelessWidget {
  const SheetAppBarAction({
    required this.icon,
    this.onPressed,
    this.tooltip,
    super.key,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onPressed: onPressed ?? () {},
      tooltip: tooltip,
      icon: Icon(icon),
    );
  }
}
