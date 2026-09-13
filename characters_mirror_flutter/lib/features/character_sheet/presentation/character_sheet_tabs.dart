import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/fight_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/inventory_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/notes_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CharacterSheetTab {
  const CharacterSheetTab({
    required this.builder,
    required this.destination,
  });

  final Widget Function() builder;
  final NavigationDestination destination;
}

List<CharacterSheetTab> buildCharacterSheetTabs(int characterId) {
  return [
    CharacterSheetTab(
      builder: () => FightPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: _CharacterSheetTabIcon('assets/svg/tab_bar/combat.svg'),
        label: 'Бой',
      ),
    ),
    CharacterSheetTab(
      builder: () => CharacterPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: _CharacterSheetTabIcon('assets/svg/tab_bar/personal.svg'),
        label: 'Персонаж',
      ),
    ),
    CharacterSheetTab(
      builder: () => InventoryPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: _CharacterSheetTabIcon('assets/svg/tab_bar/inventory.svg'),
        label: 'Инвентарь',
      ),
    ),
    CharacterSheetTab(
      builder: () => NotesPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: _CharacterSheetTabIcon('assets/svg/tab_bar/notes.svg'),
        label: 'Заметки',
      ),
    ),
    CharacterSheetTab(
      builder: () => SpellPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: _CharacterSheetTabIcon('assets/svg/tab_bar/spells.svg'),
        label: 'Заклинания',
      ),
    ),
  ];
}

class _CharacterSheetTabIcon extends StatelessWidget {
  const _CharacterSheetTabIcon(this.assetPath);

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    final iconColor = IconTheme.of(context).color;

    return SvgPicture.asset(
      assetPath,
      width: 24,
      height: 24,
      colorFilter: iconColor == null
          ? null
          : ColorFilter.mode(iconColor, BlendMode.srcIn),
    );
  }
}
