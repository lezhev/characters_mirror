import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/fight_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/inventory_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/notes_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:flutter/material.dart';

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
        icon: Icon(Icons.sports_martial_arts),
        label: 'Бой',
      ),
    ),
    CharacterSheetTab(
      builder: () => CharacterPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: Icon(Icons.person),
        label: 'Персонаж',
      ),
    ),
    CharacterSheetTab(
      builder: () => InventoryPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: Icon(Icons.inventory),
        label: 'Инвентарь',
      ),
    ),
    CharacterSheetTab(
      builder: () => NotesPage(characterId: characterId),
      destination: const NavigationDestination(
        icon: Icon(Icons.note),
        label: 'Заметки',
      ),
    ),
    const CharacterSheetTab(
      builder: _buildSpellPage,
      destination: NavigationDestination(
        icon: Icon(Icons.auto_fix_high),
        label: 'Заклинания',
      ),
    ),
  ];
}

Widget _buildSpellPage() => const SpellPage();
