import 'dart:async';

import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationProgression extends StatelessWidget {
  final Step currentStep;
  final FutureOr<void> Function(Step target)? onStepTap;

  const CreationProgression({
    super.key,
    required this.currentStep,
    this.onStepTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StepIndicator(
          step: Step.introduction,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
        Expanded(child: StepLine()),
        StepIndicator(
          step: Step.race,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
        Expanded(child: StepLine()),
        StepIndicator(
          step: Step.classStep,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
        Expanded(child: StepLine()),
        StepIndicator(
          step: Step.background,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
        Expanded(child: StepLine()),
        StepIndicator(
          step: Step.attributes,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
        Expanded(child: StepLine()),
        StepIndicator(
          step: Step.personal,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
        Expanded(child: StepLine()),
        StepIndicator(
          step: Step.summary,
          currentStep: currentStep,
          onTap: onStepTap,
        ),
      ],
    );
  }
}

class StepIndicator extends StatelessWidget {
  final Step step;
  final Step currentStep;
  final FutureOr<void> Function(Step target)? onTap;

  const StepIndicator({
    super.key,
    required this.step,
    required this.currentStep,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isCurrent = step == currentStep;
    final isWide = MediaQuery.of(context).size.width > 500;
    final radius = isCurrent
        ? (isWide ? 28.0 : 20.0)
        : (isWide ? 24.0 : 16.0);

    return InkResponse(
      onTap: onTap == null ? null : () => onTap!(step),
      radius: radius + 4,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: isCurrent
            ? colorScheme.primary
            : colorScheme.surfaceContainerLowest,
        child: isCurrent
            ? Text(
                '${step.number}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              )
            : null,
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
