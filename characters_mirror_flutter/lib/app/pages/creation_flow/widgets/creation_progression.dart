import 'dart:async';

import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationProgression extends StatelessWidget {
  final FutureOr<void> Function(Step target)? onStepTap;

  const CreationProgression({super.key, this.onStepTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StepIndicator(step: Step.introduction, onTap: onStepTap),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.race, onTap: onStepTap),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.classStep, onTap: onStepTap),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.background, onTap: onStepTap),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.attributes, onTap: onStepTap),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.personal, onTap: onStepTap),
        Expanded(child: StepLine()),
        StepIndicator(step: Step.summary, onTap: onStepTap),
      ],
    );
  }
}

class StepIndicator extends ConsumerWidget {
  final Step step;
  final FutureOr<void> Function(Step target)? onTap;

  const StepIndicator({super.key, required this.step, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final state = ref.watch(characterCreationProvider);
    return InkResponse(
      onTap: onTap == null ? null : () => onTap!(step),
      radius: MediaQuery.of(context).size.width > 500 ? 28 : 20,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width > 500 ? 24 : 16,
        backgroundColor: step == state.step
            ? colorScheme.primary
            : colorScheme.surfaceContainerLowest,
      ),
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
