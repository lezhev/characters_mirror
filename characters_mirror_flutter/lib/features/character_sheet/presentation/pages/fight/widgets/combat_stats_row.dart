import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/segmented_stat_bar.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter/material.dart';

class CombatStatsRow extends StatelessWidget {
  const CombatStatsRow({
    required this.character,
    required this.onHpPressed,
    super.key,
  });

  final CharacterData character;
  final VoidCallback onHpPressed;

  @override
  Widget build(BuildContext context) {
    return SegmentedStatBar(
      segments: [
        SegmentedStatBarItem(
          icon: Icons.favorite,
          value: formatHpLabel(character),
          onPressed: onHpPressed,
        ),
        SegmentedStatBarItem(
          icon: Icons.bolt,
          value: formatInitiativeLabel(character),
        ),
        SegmentedStatBarItem(
          icon: Icons.shield_outlined,
          value: formatArmorClassLabel(character),
        ),
        SegmentedStatBarItem(
          icon: Icons.directions_run,
          value: formatSpeedLabel(character),
        ),
      ],
    );
  }
}
