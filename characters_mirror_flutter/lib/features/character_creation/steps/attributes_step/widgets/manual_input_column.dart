import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_formatters.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/compact_number_input.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManualInputColumn extends ConsumerWidget {
  const ManualInputColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);

    return SizedBox(
      width: 80,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: Attribute.values.map((attribute) {
          final value = state.assignedAttributes[attribute] ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SizedBox(
              height: 60,
              child: CompactNumberInput(
                fieldKey: ValueKey('manual-input-${attribute.name}'),
                initialValue: value == 0 ? '' : value.toString(),
                inputFormatters: [nonNegativeIntFormatter()],
                onChanged: (text) {
                  final intValue = int.tryParse(text) ?? 0;
                  ref
                      .read(attributeStateProvider.notifier)
                      .updateManualAttribute(attribute, intValue);
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
