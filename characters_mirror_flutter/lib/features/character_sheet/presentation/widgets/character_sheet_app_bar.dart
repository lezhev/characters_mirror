import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CharacterSheetAppBar extends StatelessWidget {
  const CharacterSheetAppBar({
    required this.characterName,
    required this.onSettingsPressed,
    required this.onMenuPressed,
    super.key,
  });

  final String characterName;
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
                  onPressed: () => context.go('/characters'),
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
