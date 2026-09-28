import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/button.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final hasPreviousStep = notifier.previousVisibleStep(currentStep) != null;

    if (routeStep != null && routeStep != providerStep) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) {
          return;
        }
        if (GoRouter.of(context).state.uri.path != routeStep.routePath) {
          return;
        }
        ref.read(characterCreationProvider.notifier).syncStep(routeStep);
      });
    }

    return Align(
      alignment: Alignment.center,
      heightFactor: 1,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: LayoutBuilder(
          builder: (context, constraints) => route == 'character'
              ? Button.filled(
                  title: 'Создать персонажа',
                  width: constraints.maxWidth,
                  onPressed: onPressedNext,
                )
              : Row(
                  children: [
                    !hasPreviousStep
                        ? SizedBox.shrink()
                        : Button.outlined(
                            leading: Icon(Icons.arrow_back,
                                color: Theme.of(context).colorScheme.primary),
                            onPressed: () => notifier.prevStep(context),
                            title: 'Назад',
                          ),
                    Spacer(),
                    Button.filled(
                      onPressed: onPressedNext,
                      title: 'Далее',
                      trailing: Icon(Icons.arrow_forward,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
