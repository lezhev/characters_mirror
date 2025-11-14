import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/class_features.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/class_tile_view.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/class_step/state/class_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
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
                route: 'background',
              ),
            ),
          ),
        );
      },
      error: (e, s) {
        //TODO
        return Text('data');
      },
      loading: () {
        return CircularProgressIndicator();
      },
    );
  }
}
