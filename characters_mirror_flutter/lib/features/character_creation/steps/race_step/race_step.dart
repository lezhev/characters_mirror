import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_tile_view.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_selection_step_scaffold.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_page.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceStep extends HookConsumerWidget {
  const RaceStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsKey = useMemoized(GlobalKey.new);

    return ref.watch(raceStateProvider).when(
      data: (data) {
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
            notifier.syncRaceDraft(
              selectedRace: data.selectedRace,
              selectedSubrace: data.selectedSubrace,
              choiceGroups: data.choiceGroups,
              raceChoices:
                  ref.read(raceStateProvider.notifier).buildRaceChoices(),
            );
            notifier.nextStep(context);
          },
          selection: RaceTileView(),
          details: data.selectedRace == null
              ? null
              : RaceFeatures(
                  selectedRace: data.selectedRace!,
                ),
          detailsKey: detailsKey,
          showJumpButton: data.selectedRace != null,
          scrollHintSelection: data.selectedRace?.id ?? data.selectedRace,
          onJumpToDetails: () => _scrollToDetails(detailsKey),
        );
      },
      error: (e, s) {
        return ErrorPage(
          error: e,
          stackTrace: s,
          onRetry: () => ref.refresh(raceStateProvider),
        );
      },
      loading: () {
        return CreationSelectionStepScaffold.loading(
          route: 'background',
          onBack: () {
            ref.read(characterCreationProvider.notifier).reset();
            context.go('/characters');
          },
        );
      },
    );
  }
}

void _syncAndGo({
  required BuildContext context,
  required WidgetRef ref,
  required RaceStateModel data,
  required Step target,
}) {
  final notifier = ref.read(characterCreationProvider.notifier);
  notifier.syncRaceDraft(
    selectedRace: data.selectedRace,
    selectedSubrace: data.selectedSubrace,
    choiceGroups: data.choiceGroups,
    raceChoices: ref.read(raceStateProvider.notifier).buildRaceChoices(),
  );
  notifier.goToStep(context, target);
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
