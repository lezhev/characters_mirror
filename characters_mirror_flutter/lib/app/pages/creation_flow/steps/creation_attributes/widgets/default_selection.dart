import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/creation_attributes/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/creation_attributes/widgets/default_selection_state/default_selection_state.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class DefaultSelection extends ConsumerWidget {
  const DefaultSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(defaultSelectionStateProvider);
    return Expanded(
      child: SingleChildScrollView(
        child: PageSizeLimiter(
          child: Column(
            children: [
              const Text(
                'Выберите характеристики перетаскиванием',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const Gap(16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.remainingValues.map((value) {
                  return Draggable<int>(
                    data: value,
                    feedback: Material(
                      color: Colors.transparent,
                      child: DraggableBox(value, isDragging: true),
                    ),
                    childWhenDragging: DraggableBox(value, isDragging: false),
                    child: DraggableBox(value, isDragging: false),
                  );
                }).toList(),
              ),
              if (state.remainingValues.isNotEmpty) const Gap(16),
              PageSizeLimiter(
                maxWidth: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: StatNamesColumn(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: DragTargetColumn(),
                        ),
                        BounsSection.plusOne(),
                        BounsSection.plusTwo(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatNamesColumn extends StatelessWidget {
  const StatNamesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 150),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: Attribute.values.map((attribute) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Text(
                attribute.getTitle(),
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class DragTargetColumn extends ConsumerWidget {
  const DragTargetColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(defaultSelectionStateProvider);
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
                    ref
                        .read(defaultSelectionStateProvider.notifier)
                        .unselectAttribute(attribute);
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
                        (ref
                                .read(defaultSelectionStateProvider.notifier)
                                .mergeStatsAndBonuses()[attribute])
                            .toString(),
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
                ref
                    .read(defaultSelectionStateProvider.notifier)
                    .onAcceptWithDetailes(details, attribute);
              },
              onWillAcceptWithDetails: (details) => true,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BounsSection extends ConsumerWidget {
  final int bonus;

  const BounsSection(this.bonus, {super.key});
  const BounsSection.plusOne({super.key, this.bonus = 1});
  const BounsSection.plusTwo({super.key, this.bonus = 2});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(defaultSelectionStateProvider);
    return Column(
      children: [
        Text('+$bonus'),
        Gap(10),
        Container(
          height: 500,
          width: 50,
          color: Colors.transparent,
          child: ListView(
            children: Attribute.values.map((attribute) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Checkbox(
                  value: bonus == 1
                      ? state.bonusesPlusOne[attribute]
                      : state.bonusesPlusTwo[attribute],
                  onChanged: (bool? value) {
                    ref
                        .read(defaultSelectionStateProvider.notifier)
                        .toggleBonus(
                            attribute: attribute,
                            bonusValue: bonus,
                            value: value);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DraggableBox extends StatelessWidget {
  final int value;

  final bool isDragging;

  const DraggableBox(this.value, {super.key, required this.isDragging});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: isDragging
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.8)
            : Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 1,
        ),
      ),
      child: Center(
        child: Text(
          value.toString(),
          style: TextStyle(
              fontSize: 18, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
