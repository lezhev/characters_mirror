import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/common/selection_type.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/attribute_names_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/bonus_section.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/drag_box.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/drag_target_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/manual_input_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/purchace_column.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/widgets/roll_and_drag_box.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
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
    return Expanded(
      child: SingleChildScrollView(
        child: PageSizeLimiter(
          child: Column(
            children: [
              Gap(8),
              _buildRemainingAttributesBlock(
                  state.selectionType, state.remainingValues),
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
                      Gap(40),
                      Text('+1'),
                      Gap(32),
                      Text('+2'),
                      Gap(20),
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
                      AttributeNamesColumn(),
                      Spacer(),
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
      SelectType type, List<int?> remainingValues) {
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
        return SizedBox.shrink();
      case SelectType.purchace:
        return SizedBox.shrink();
    }
  }

  Widget _buildAssignedAttributesBlock(SelectType type) {
    switch (type) {
      case SelectType.random:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DragTargetColumn(),
            BounsSection.plusOne(),
            BounsSection.plusTwo(),
          ],
        );
      case SelectType.defaultType:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DragTargetColumn(),
            BounsSection.plusOne(),
            BounsSection.plusTwo(),
          ],
        );
      case SelectType.manual:
        return ManualInputColumn();
      case SelectType.purchace:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PurchaceColumn(),
            BounsSection.plusOne(),
            BounsSection.plusTwo(),
          ],
        );
    }
  }
}
