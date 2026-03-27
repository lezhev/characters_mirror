import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/class_features.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/class_tile_view.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_shimmer.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClassStep extends ConsumerWidget {
  const ClassStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(classStateProvider).when(
      data: (data) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: CreationAppBar(
              title: "Создание персонажа",
              onBack: () => context.go('/characters'),
            ),
          ),
          body: PageSizeLimiter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClassTileView(),
                    if (data.selectedClass != null)
                      ClassFeatures(selectedClass: data.selectedClass!)
                  ],
                ),
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
                      .addClass(data.selectedClass!);
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
            context: context);
      },
      loading: () {
        return CreationShimmer();
      },
    );
  }
}
