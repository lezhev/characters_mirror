import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/inventory_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/notes_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/spell_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CharacterSheet extends HookConsumerWidget {
  const CharacterSheet({
    required this.characterId,
    super.key,
  });

  final int characterId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = useState(0);
    final tabs = [
      _CharacterSheetTab(
        page: FightPage(characterId: characterId),
        destination: const NavigationDestination(
          icon: Icon(Icons.sports_martial_arts),
          label: 'Бой',
        ),
      ),
      const _CharacterSheetTab(
        page: CharacterPage(),
        destination: NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Персонаж',
        ),
      ),
      const _CharacterSheetTab(
        page: InventoryPage(),
        destination: NavigationDestination(
          icon: Icon(Icons.inventory),
          label: 'Инвентарь',
        ),
      ),
      const _CharacterSheetTab(
        page: NotesPage(),
        destination: NavigationDestination(
          icon: Icon(Icons.note),
          label: 'Заметки',
        ),
      ),
      const _CharacterSheetTab(
        page: SpellPage(),
        destination: NavigationDestination(
          icon: Icon(Icons.auto_fix_high),
          label: 'Заклинания',
        ),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: pageIndex.value,
        children: [for (final tab in tabs) tab.page],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex.value,
        onDestinationSelected: (index) => pageIndex.value = index,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          for (final tab in tabs) tab.destination,
        ],
      ),
    );
  }
}

class _CharacterSheetTab {
  const _CharacterSheetTab({
    required this.page,
    required this.destination,
  });

  final Widget page;
  final NavigationDestination destination;
}
