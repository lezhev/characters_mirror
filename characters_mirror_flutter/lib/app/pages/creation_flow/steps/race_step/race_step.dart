import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/race_features.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/race_tile_view.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/race_step/state/race_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_shimmer.dart';
import 'package:characters_mirror_flutter/app/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RaceStep extends ConsumerWidget {
  const RaceStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(raceStateProvider).when(
      data: (data) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120),
            child: CreationAppBar(
              title: "Создание персонажа",
              onBack: () => context.go('/characters'),
            ),
          ),
          body: PageSizeLimiter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                children: [
                  RaceTileView(),
                  if (data.selectedRace != null)
                    RaceFeatures(selectedRace: data.selectedRace!),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: CreationNavBar(
                onPressedNext: () {
                  ref
                      .read(characterCreationProvider.notifier)
                      .nextStep(context);
                  ref
                      .read(characterCreationProvider.notifier)
                      .setRace(data.selectedRace!);
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
