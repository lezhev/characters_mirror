import 'package:characters_mirror_flutter/data/Enums/alignment.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/button.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationNavBar extends ConsumerWidget {
  final String route;
  final VoidCallback onPressedNext;
  const CreationNavBar(
      {super.key, required this.route, required this.onPressedNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final providerStep = ref.watch(
      characterCreationProvider.select((state) => state.step),
    );
    final routeStep = CreationStepX.fromContext(context);
    final currentStep = routeStep ?? providerStep;
    final notifier = ref.read(characterCreationProvider.notifier);

    if (routeStep != null && routeStep != providerStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(characterCreationProvider.notifier).syncStep(routeStep);
      });
    }

    return PageSizeLimiter(
      child: Row(
        children: [
          currentStep == Step.introduction
              ? SizedBox.shrink()
              : Button.outlined(
                  leading: Icon(Icons.arrow_back,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: () => notifier.prevStep(context),
                  title: 'Назад',
                ),
          Spacer(),
          route == 'character'
              ? Button.filled(
                  leading: Icon(Icons.auto_awesome_outlined,
                      color: Theme.of(context).colorScheme.onPrimary),
                  title: 'Завершить',
                  width: 168,
                  onPressed: onPressedNext,
                )
              : Button.filled(
                  onPressed: onPressedNext,
                  title: 'Далее',
                  trailing: Icon(Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
        ],
      ),
    );
  }
}
