import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_features.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/race_tile_view.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
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

class RaceStep extends HookConsumerWidget {
  const RaceStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsKey = useMemoized(GlobalKey.new);
    final dismissedSelectionKey = useState<String?>(null);

    return ref.watch(raceStateProvider).when(
      data: (data) {
        final selectedRaceKey = data.selectedRace == null
            ? null
            : '${data.selectedRace!.id ?? data.selectedRace!.name}';
        final showJumpButton = selectedRaceKey != null &&
            dismissedSelectionKey.value != selectedRaceKey;

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
                        RaceTileView(),
                        if (data.selectedRace != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 88.0),
                            child: KeyedSubtree(
                              key: detailsKey,
                              child: RaceFeatures(
                                selectedRace: data.selectedRace!,
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
                      dismissedSelectionKey.value = selectedRaceKey;
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
                  final notifier = ref.read(characterCreationProvider.notifier);
                  notifier.syncRaceDraft(
                    selectedRace: data.selectedRace,
                    selectedSubrace: data.selectedSubrace,
                    raceChoices:
                        ref.read(raceStateProvider.notifier).buildRaceChoices(),
                  );
                  notifier.goToStep(context, Step.classStep);
                },
                route: 'class',
              ),
            ),
          ),
        );
      },
      error: (e, s) {
        return errorWidget(
          e: e,
          s: s,
          refresh: () => ref.refresh(raceStateProvider),
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
  required RaceStateModel data,
  required Step target,
}) {
  final notifier = ref.read(characterCreationProvider.notifier);
  notifier.syncRaceDraft(
    selectedRace: data.selectedRace,
    selectedSubrace: data.selectedSubrace,
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
