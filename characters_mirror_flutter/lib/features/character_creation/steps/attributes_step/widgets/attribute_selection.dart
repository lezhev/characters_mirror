import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/attribute_names_column.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/bonus_section.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/drag_box.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/drag_target_column.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/manual_input_column.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/purchace_column.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/widgets/roll_and_drag_box.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/shared/creation_step_swipe_lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class AttributeSelection extends ConsumerWidget {
  const AttributeSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);
    final notifier = ref.read(attributeStateProvider.notifier);
    final character = ref.watch(
      characterCreationProvider.select((value) => value.character),
    );
    final creationNotifier = ref.read(characterCreationProvider.notifier);
    final useFlexibleAbilityBonuses =
        character.useFlexibleAbilityBonuses ?? false;

    return Expanded(
      child: SingleChildScrollView(
        child: PageSizeLimiter(
          child: Column(
            children: [
              const Gap(8),
              PageSizeLimiter(
                maxWidth: 560,
                child: SwitchListTile(
                  value: useFlexibleAbilityBonuses,
                  onChanged: (value) {
                    creationNotifier.setUseFlexibleAbilityBonuses(value);
                  },
                  title:
                      const Text('Опциональные правила выбора характеристик'),
                  subtitle: const Text(
                    'По умолчанию используется правила из книги игрока. Включите это, если хотите использовать опциональные правила.',
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4),
                child: Wrap(
                  spacing: 8,
                  children: [
                    if (notifier.hasRacialBonusMode)
                      ChoiceChip(
                        label: const Text('Раса / подраса'),
                        selected: state.bonusMode == AttributeBonusMode.racial,
                        onSelected: (_) => notifier.setBonusMode(
                          AttributeBonusMode.racial,
                        ),
                      ),
                    if (notifier.hasFlexiblePlusTwoOneMode)
                      ChoiceChip(
                        label: const Text('+2 / +1'),
                        selected: state.bonusMode ==
                            AttributeBonusMode.flexiblePlusTwoOne,
                        onSelected: (_) => notifier.setBonusMode(
                          AttributeBonusMode.flexiblePlusTwoOne,
                        ),
                      ),
                    if (notifier.hasFlexibleThreePlusOneMode)
                      ChoiceChip(
                        label: const Text('3 x +1'),
                        selected: state.bonusMode ==
                            AttributeBonusMode.flexibleThreePlusOne,
                        onSelected: (_) => notifier.setBonusMode(
                          AttributeBonusMode.flexibleThreePlusOne,
                        ),
                      ),
                  ],
                ),
              ),
              const Gap(8),
              _buildRemainingAttributesBlock(
                ref,
                state.selectionType,
                state.remainingValues,
              ),
              if (state.selectionType != SelectType.manual)
                PageSizeLimiter(
                  maxWidth: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (state.selectionType == SelectType.purchace)
                        Text(
                          state.purchacePoints.toString(),
                        ),
                      const Gap(40),
                      const Text('+1'),
                      const Gap(32),
                      const Text('+2'),
                      const Gap(20),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: PageSizeLimiter(
                  maxWidth: 400,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AttributeNamesColumn(),
                      const Spacer(),
                      _buildAssignedAttributesBlock(state.selectionType),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemainingAttributesBlock(
    WidgetRef ref,
    SelectType type,
    List<int?> remainingValues,
  ) {
    switch (type) {
      case SelectType.random:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(6, (i) => RollOrDragBox(index: i)),
          ),
        );
      case SelectType.defaultType:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: remainingValues.map((value) {
              return Draggable<int>(
                data: value!,
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
                  child: DragBox(value, isDragging: true),
                ),
                childWhenDragging: DragBox(value, isDragging: false),
                child: DragBox(value, isDragging: false),
              );
            }).toList(),
          ),
        );
      case SelectType.manual:
        return const SizedBox.shrink();
      case SelectType.purchace:
        return const SizedBox.shrink();
    }
  }

  Widget _buildAssignedAttributesBlock(SelectType type) {
    switch (type) {
      case SelectType.random:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragTargetColumn(),
            const BounsSection.plusOne(),
            const BounsSection.plusTwo(),
          ],
        );
      case SelectType.defaultType:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DragTargetColumn(),
            const BounsSection.plusOne(),
            const BounsSection.plusTwo(),
          ],
        );
      case SelectType.manual:
        return const ManualInputColumn();
      case SelectType.purchace:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PurchaceColumn(),
            const BounsSection.plusOne(),
            const BounsSection.plusTwo(),
          ],
        );
    }
  }
}
