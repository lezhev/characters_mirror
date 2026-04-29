import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/attack_card.dart';
import 'package:flutter/material.dart';

class AttackListSection extends StatelessWidget {
  const AttackListSection({
    required this.attacks,
    required this.onAddAttack,
    required this.attackBonusLabelBuilder,
    required this.damageLabelBuilder,
    required this.onAttackPressed,
    super.key,
    this.rollVariables = const {},
  });

  final List<CharacterAttackData> attacks;
  final VoidCallback onAddAttack;
  final String Function(CharacterAttackData attack) attackBonusLabelBuilder;
  final String Function(CharacterAttackData attack) damageLabelBuilder;
  final void Function(int index, CharacterAttackData attack) onAttackPressed;
  final Map<String, int> rollVariables;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(
          title: 'Атаки',
          showDivider: false,
          trailing: TextButton(
            onPressed: onAddAttack,
            child: const Icon(Icons.add),
          ),
        ),
        const SizedBox(height: 16),
        for (var index = 0; index < attacks.length; index++) ...[
          AttackCard(
            attack: attacks[index],
            attackBonusLabel: attackBonusLabelBuilder(attacks[index]),
            damageLabel: damageLabelBuilder(attacks[index]),
            onNamePressed: () => onAttackPressed(index, attacks[index]),
            rollVariables: rollVariables,
          ),
          if (index < attacks.length - 1) const SizedBox(height: 4),
        ],
      ],
    );
  }
}
