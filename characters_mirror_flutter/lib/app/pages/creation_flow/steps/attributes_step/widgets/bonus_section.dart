import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/steps/attributes_step/state/attribute_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BounsSection extends ConsumerWidget {
  final int bonus;

  const BounsSection(this.bonus, {super.key});
  const BounsSection.plusOne({super.key, this.bonus = 1});
  const BounsSection.plusTwo({super.key, this.bonus = 2});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attributeStateProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Container(
        height: 416,
        width: 50,
        color: Colors.transparent,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: Attribute.values.map((attribute) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 28.0),
              child: Checkbox(
                value: bonus == 1
                    ? state.bonusesPlusOne[attribute]
                    : state.bonusesPlusTwo[attribute],
                onChanged: (bool? value) {
                  ref.read(attributeStateProvider.notifier).toggleBonus(
                      attribute: attribute, bonusValue: bonus, value: value);
                },
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
