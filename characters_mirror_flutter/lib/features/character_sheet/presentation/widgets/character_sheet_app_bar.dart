import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CharacterSheetAppBar extends StatelessWidget {
  const CharacterSheetAppBar({
    required this.characterName,
    required this.onRestSelected,
    required this.onSettingsPressed,
    required this.onMenuPressed,
    super.key,
  });

  final String characterName;
  final ValueChanged<RestType> onRestSelected;
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
                RestActionButton(
                  iconPath: 'assets/svg/rest/longRest.svg',
                  tooltip: 'Долгий отдых',
                  onPressed: () => onRestSelected(RestType.longRest),
                ),
                RestActionButton(
                  iconPath: 'assets/svg/rest/shortRest.svg',
                  tooltip: 'Короткий отдых',
                  onPressed: () => onRestSelected(RestType.shortRest),
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

class RestActionButton extends StatelessWidget {
  const RestActionButton({
    required this.iconPath,
    required this.onPressed,
    this.tooltip,
    super.key,
  });

  final String iconPath;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      tooltip: tooltip,
      onPressed: onPressed,
      icon: _RestIcon(iconPath),
    );
  }
}

class _RestIcon extends StatelessWidget {
  const _RestIcon(this.assetPath);

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final iconColor = IconTheme.of(context).color;

    return SvgPicture.asset(
      assetPath,
      width: 28,
      height: 28,
      colorFilter: iconColor == null
          ? null
          : ColorFilter.mode(iconColor, BlendMode.srcIn),
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
