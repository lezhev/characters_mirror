import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  Positioned(
                    left: 9,
                    bottom: 8,
                    child: SizedBox(
                      width: 44,
                      height: 36,
                      child: TextFormField(
                        initialValue: value == 0 ? '' : value.toString(),
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (text) {
                          final intValue = int.tryParse(text) ?? 0;
                          final newValue = intValue.clamp(1, 20);
                          ref
                              .read(attributeStateProvider.notifier)
                              .updateManualAttribute(attribute, newValue);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
