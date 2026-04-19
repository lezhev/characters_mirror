import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/character_sheet_tabs.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/mechanics/mechanics_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_sheet_app_bar.dart';
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
    final isMechanicsOpen = useState(false);
    final returnPageIndex = useState(0);
    final characterName = ref
        .watch(characterSheetControllerProvider(characterId))
        .valueOrNull
        ?.name
        ?.trim();
    final tabs = buildCharacterSheetTabs(characterId);

    void closeMechanics() {
      pageIndex.value = returnPageIndex.value;
      isMechanicsOpen.value = false;
    }

    return Scaffold(
      appBar: isMechanicsOpen.value
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CharacterSheetAppBar(
                characterName: (characterName == null || characterName.isEmpty)
                    ? 'Персонаж'
                    : characterName,
                onMenuPressed: () {
                  returnPageIndex.value = pageIndex.value;
                  isMechanicsOpen.value = true;
                },
              ),
            ),
      body: KeyedSubtree(
        key: ValueKey(
          isMechanicsOpen.value ? 'mechanics' : 'tab-${pageIndex.value}',
        ),
        child: isMechanicsOpen.value
            ? MechanicsPage(
                characterId: characterId,
                onClose: closeMechanics,
              )
            : tabs[pageIndex.value].builder(),
      ),
      bottomNavigationBar: isMechanicsOpen.value
          ? null
          : NavigationBar(
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
