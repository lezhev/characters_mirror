import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class IntroductionStep extends ConsumerWidget {
  const IntroductionStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CreationAppBar(
        title: "Создание персонажа",
        onBack: () => context.go('/characters'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: PageSizeLimiter(child: Center(child: Text('Introduction'))),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CreationNavBar(
            onPressedNext: () {
              ref.read(characterCreationProvider.notifier).nextStep(context);
            },
            route: 'race',
          ),
        ),
      ),
    );
  }
}
