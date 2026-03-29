import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_tile_view.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/jump_to_details_button.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_shimmer.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClassStep extends HookConsumerWidget {
  const ClassStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsKey = useMemoized(GlobalKey.new);
    final dismissedSelectionKey = useState<String?>(null);

    return ref.watch(classStateProvider).when(
      data: (data) {
        final selectedClassKey =
            data.selectedClass == null
                ? null
                : '${data.selectedClass!.id ?? data.selectedClass!.name}';
        final showJumpButton =
            selectedClassKey != null &&
            dismissedSelectionKey.value != selectedClassKey;

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(CreationAppBar.height),
            child: CreationAppBar(
              title: "Создание персонажа",
              onBack: () {
                ref.read(characterCreationProvider.notifier).reset();
                context.go('/characters');
              },
              onStepTap: (target) => _syncAndGo(
                context: context,
                ref: ref,
                data: data,
                target: target,
              ),
            ),
          ),
          body: PageSizeLimiter(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const ClassTileView(),
                        if (data.selectedClass != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 88.0),
                            child: KeyedSubtree(
                              key: detailsKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 12),
                                  ClassFeatures(
                                    stepView: data.stepView,
                                    selectedLevel: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (showJumpButton)
                  JumpToDetailsButton(
                    onPressed: () {
                      dismissedSelectionKey.value = selectedClassKey;
                      _scrollToDetails(detailsKey);
                    },
                  ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: CreationNavBar(
                onPressedNext: () {
                  final notifier =
                      ref.read(characterCreationProvider.notifier);
                  notifier.syncPrimaryClassDraft(
                    classData: data.selectedClass,
                    subclass: data.selectedSubclass,
                    choiceGroups: data.stepView?.choiceGroups ?? const [],
                    selectedOptions: data.selectedOptions,
                    level: data.selectedLevel,
                  );
                  notifier.nextStep(context);
                },
                route: 'background',
              ),
            ),
          ),
        );
      },
      error: (e, s) {
        return errorWidget(
          e: e,
          s: s,
          refresh: () => ref.refresh(classStateProvider),
          context: context,
        );
      },
      loading: () {
        return CreationShimmer();
      },
    );
  }
}

void _syncAndGo({
  required BuildContext context,
  required WidgetRef ref,
  required ClassStateModel data,
  required Step target,
}) {
  ref.read(characterCreationProvider.notifier).syncPrimaryClassDraft(
        classData: data.selectedClass,
        subclass: data.selectedSubclass,
        choiceGroups: data.stepView?.choiceGroups ?? const [],
        selectedOptions: data.selectedOptions,
        level: data.selectedLevel,
      );
  ref.read(characterCreationProvider.notifier).goToStep(context, target);
}

Future<void> _scrollToDetails(GlobalKey key) async {
  final context = key.currentContext;
  if (context == null) return;

  await Scrollable.ensureVisible(
    context,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOutCubic,
    alignment: 0.0,
  );
}
