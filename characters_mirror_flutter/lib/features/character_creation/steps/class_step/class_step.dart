import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/class_tile_view.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_selection_step_scaffold.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_shimmer.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
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
        final selectedClassKey = data.selectedClass == null
            ? null
            : '${data.selectedClass!.id ?? data.selectedClass!.name}';
        final showJumpButton = selectedClassKey != null &&
            dismissedSelectionKey.value != selectedClassKey;

        return CreationSelectionStepScaffold(
          route: 'background',
          onBack: () {
            ref.read(characterCreationProvider.notifier).reset();
            context.go('/characters');
          },
          onStepTap: (target) async => _syncAndGo(
            context: context,
            ref: ref,
            data: data,
            target: target,
          ),
          onPressedNext: () {
            final notifier = ref.read(characterCreationProvider.notifier);
            notifier.syncPrimaryClassDraft(
              classData: data.selectedClass,
              subclass: data.selectedSubclass,
              choiceGroups: data.stepView?.choiceGroups ?? const [],
              selectedOptions: data.selectedOptions,
              spellSelections: data.selectedSpellSelections,
              startingEquipmentSelections: data.startingEquipmentSelections,
              level: data.selectedLevel,
            );
            notifier.nextStep(context);
          },
          selection: const ClassTileView(),
          details: data.selectedClass == null
              ? null
              : Column(
                  children: [
                    const SizedBox(height: 12),
                    ClassFeatures(
                      stepView: data.stepView,
                      selectedLevel: 1,
                    ),
                  ],
                ),
          detailsKey: detailsKey,
          showJumpButton: showJumpButton,
          onJumpToDetails: () {
            dismissedSelectionKey.value = selectedClassKey;
            _scrollToDetails(detailsKey);
          },
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
        return const DelayedCreationShimmer();
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
        spellSelections: data.selectedSpellSelections,
        startingEquipmentSelections: data.startingEquipmentSelections,
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
