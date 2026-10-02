import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_swipe_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DragTargetColumn extends ConsumerWidget {
  const DragTargetColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);
    final notifier = ref.read(attributeStateProvider.notifier);
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 68,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: Attribute.values.map((attribute) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: DragTarget<AttributeDragData>(
              builder: (context, candidateData, rejectedData) {
                final assignedValue = state.assignedAttributes[attribute] ?? 0;
                final card = GestureDetector(
                  onTap: () => notifier.unselectAttribute(attribute),
                  child: Container(
                    key: ValueKey('attribute-value-${attribute.name}'),
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: assignedValue != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        notifier.mergeStatsAndBonuses()[attribute].toString(),
                        style: textTheme.titleMedium?.copyWith(
                          color: assignedValue != 0
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
                if (assignedValue == 0) return card;
                return Draggable<AttributeDragData>(
                  data: AttributeDragData(
                    value: assignedValue,
                    sourceAttribute: attribute,
                  ),
                  onDragStarted: () {
                    ref.read(creationStepSwipeLockedProvider.notifier).state =
                        true;
                  },
                  onDragEnd: (_) {
                    ref.read(creationStepSwipeLockedProvider.notifier).state =
                        false;
                  },
                  feedback: Material(
                    color: Colors.transparent,
                    child: card,
                  ),
                  childWhenDragging: card,
                  child: card,
                );
              },
              onAcceptWithDetails: (details) {
                notifier.onAcceptAttributeDrag(details, attribute);
              },
              onWillAcceptWithDetails: (details) => true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
