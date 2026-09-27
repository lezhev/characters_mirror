import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/state/attribute_state.dart';
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
    final notifier = ref.read(attributeStateProvider.notifier);
    final hasRules = notifier.hasSelectableBonusRules(bonus);

    return SizedBox(
      width: 50,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: Attribute.values.map((attribute) {
          final isAvailable = notifier.isBonusAvailable(
            attribute: attribute,
            bonusValue: bonus,
          );
          final isEditable = notifier.isBonusEditable(
            attribute: attribute,
            bonusValue: bonus,
          );

          return SizedBox(
            height: 68,
            child: Center(
              child: Checkbox(
                value: bonus == 1
                    ? state.bonusesPlusOne[attribute]
                    : state.bonusesPlusTwo[attribute],
                onChanged: hasRules && isAvailable && isEditable
                    ? (bool? value) {
                        notifier.toggleBonus(
                          attribute: attribute,
                          bonusValue: bonus,
                          value: value,
                        );
                      }
                    : null,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
