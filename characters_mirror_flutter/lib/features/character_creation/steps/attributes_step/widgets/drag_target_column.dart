import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DragTargetColumn extends ConsumerWidget {
  const DragTargetColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);
    final notifier = ref.read(attributeStateProvider.notifier);
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 68),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: Attribute.values.map((attribute) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: DragTarget<int>(
              builder: (context, candidateData, rejectedData) {
                return GestureDetector(
                  onTap: () {
                    notifier.unselectAttribute(attribute);
                  },
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: state.assignedAttributes[attribute] != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        notifier.mergeStatsAndBonuses()[attribute].toString(),
                        style: TextStyle(
                          fontSize: 18,
                          color: state.assignedAttributes[attribute] != 0
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
              onAcceptWithDetails: (details) {
                notifier.onAcceptWithDetailes(details, attribute);
              },
              onWillAcceptWithDetails: (details) => true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
