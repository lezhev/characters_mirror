import 'package:characters_mirror_flutter/core/ui/pointer_swipe_policy.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/character_sheet_tabs.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/attributes_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/character_sheet_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
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
    final pageController = usePageController();
    final edgeSwipeStart = useState<Offset?>(null);
    final edgeSwipeStartPage = useState<int?>(null);
    final isAttributesOpen = useState(false);
    final returnPageIndex = useState(0);
    final characterName = ref
        .watch(characterSheetControllerProvider(characterId))
        .valueOrNull
        ?.name
        ?.trim();
    final tabs = buildCharacterSheetTabs(characterId);

    void closeAttributes() {
      final targetPage = returnPageIndex.value;
      pageIndex.value = targetPage;
      isAttributesOpen.value = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(targetPage);
        }
      });
    }

    void selectPage(int index) {
      pageIndex.value = index;
      if (!pageController.hasClients) {
        return;
      }
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
      );
    }

    void handleEdgePointerUp(PointerUpEvent event) {
      final start = edgeSwipeStart.value;
      final startPage = edgeSwipeStartPage.value;
      edgeSwipeStart.value = null;
      edgeSwipeStartPage.value = null;
      if (start == null || startPage == null) {
        return;
      }

      final delta = event.position - start;
      if (delta.dx.abs() < 80 || delta.dx.abs() < delta.dy.abs() * 1.4) {
        return;
      }

      final isFirstPage = startPage == 0;
      final isLastPage = startPage == tabs.length - 1;
      if (delta.dx > 0 && isFirstPage) {
        selectPage(tabs.length - 1);
      } else if (delta.dx < 0 && isLastPage) {
        selectPage(0);
      }
    }

    return Scaffold(
      appBar: isAttributesOpen.value
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CharacterSheetAppBar(
                characterName: (characterName == null || characterName.isEmpty)
                    ? 'Персонаж'
                    : characterName,
                onSettingsPressed: () {
                  context.go('/characters/sheet/$characterId/settings');
                },
                onMenuPressed: () {
                  returnPageIndex.value = pageIndex.value;
                  isAttributesOpen.value = true;
                },
              ),
            ),
      body: Column(
        children: [
          Expanded(
            child: isAttributesOpen.value
                ? KeyedSubtree(
                    key: const ValueKey('attributes'),
                    child: AttributesPage(
                      characterId: characterId,
                      onClose: closeAttributes,
                    ),
                  )
                : Listener(
                    behavior: HitTestBehavior.translucent,
                    onPointerDown: (event) {
                      if (!allowsSwipeNavigationForPointer(event.kind)) {
                        edgeSwipeStart.value = null;
                        edgeSwipeStartPage.value = null;
                        return;
                      }
                      edgeSwipeStart.value = event.position;
                      edgeSwipeStartPage.value = pageIndex.value;
                    },
                    onPointerUp: handleEdgePointerUp,
                    onPointerCancel: (_) {
                      edgeSwipeStart.value = null;
                      edgeSwipeStartPage.value = null;
                    },
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (index) => pageIndex.value = index,
                      children: [
                        for (final tab in tabs) tab.builder(),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: isAttributesOpen.value
          ? null
          : NavigationBar(
              selectedIndex: pageIndex.value,
              onDestinationSelected: selectPage,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: [
                for (final tab in tabs) tab.destination,
              ],
            ),
    );
  }
}
