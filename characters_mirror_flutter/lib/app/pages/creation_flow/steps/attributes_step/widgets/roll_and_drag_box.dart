import 'dart:math';

import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/drag_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RollOrDragBox extends HookConsumerWidget {
  final int index;

  const RollOrDragBox({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);
    final rollValue = state.remainingValues[index];
    final boxState = state.boxStates[index];
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    useEffect(() {
      if (boxState == RollBoxState.rolling) {
        controller.forward(from: 0);
      }
      return null;
    }, [boxState]);

    switch (boxState) {
      case RollBoxState.initial:
        return Material(
          child: InkWell(
            onTap: () {
              ref.read(attributeStateProvider.notifier).rollValueAt(index);
            },
            child: _diceContainer(context),
          ),
        );

      case RollBoxState.rolling:
        return _diceContainer(context, rotationController: controller);

      case RollBoxState.filled:
        return Draggable<int>(
          data: rollValue!,
          feedback: Material(
            color: Colors.transparent,
            child: DragBox(rollValue, isDragging: true),
          ),
          childWhenDragging: DragBox(rollValue, isDragging: false),
          child: DragBox(rollValue, isDragging: false),
        );
      case RollBoxState.empty:
        return SizedBox.shrink();
    }
  }

  Widget _diceContainer(BuildContext context,
      {AnimationController? rotationController}) {
    Widget diceIcon = SvgPicture.asset(
      'svg/dice.svg',
      width: 28,
      height: 28,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.primary,
        BlendMode.srcIn,
      ),
    );

    if (rotationController != null) {
      diceIcon = AnimatedBuilder(
        animation: rotationController,
        builder: (context, child) {
          final angle = rotationController.value * 2 * pi;
          return Transform.rotate(angle: angle, child: child);
        },
        child: diceIcon,
      );
    }

    return Ink(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: Center(child: diceIcon),
    );
  }
}
