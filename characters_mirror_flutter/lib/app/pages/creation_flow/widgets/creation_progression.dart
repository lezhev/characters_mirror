import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationProgression extends StatelessWidget {
  const CreationProgression({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        StepIndicator(step: Step.introduction),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.race),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.classStep),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.background),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.attributes),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.personal),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.summary),
      ],
    );
  }
}

class StepIndicator extends ConsumerWidget {
  final Step step;

  const StepIndicator({super.key, required this.step});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.read(characterCreationProvider);
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width > 500 ? 24 : 16,
      backgroundColor: step == state.step
          ? colorScheme.primary
          : colorScheme.surfaceContainerLowest,
    );
    //  return Container(
    //   width: diameter,
    //   height: diameter,
    //   decoration: BoxDecoration(
    //     color: step == state.step
    //         ? colorScheme.primary
    //         : colorScheme.surfaceContainerLowest,
    //     border: Border.all(
    //       color: step == state.step
    //           ? colorScheme.primary
    //           : colorScheme.surfaceContainerLowest,
    //       width: 1,
    //     ),
    //     borderRadius: BorderRadius.circular(24),
    //   ),
    // );
    //}
  }
}

class StepLine extends ConsumerWidget {
  const StepLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 40,
      height: 4,
      color: colorScheme.outline,
    );
  }
}
