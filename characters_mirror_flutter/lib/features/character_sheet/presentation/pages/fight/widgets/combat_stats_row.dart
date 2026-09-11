import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/segmented_stat_bar.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:flutter/material.dart';

class CombatStatsRow extends StatelessWidget {
  const CombatStatsRow({
    required this.character,
    required this.onHpPressed,
    required this.onInitiativePressed,
    required this.onInitiativeLongPressed,
    required this.onArmorClassPressed,
    required this.onSpeedPressed,
    super.key,
  });

  final CharacterData character;
  final VoidCallback onHpPressed;
  final VoidCallback onInitiativePressed;
  final VoidCallback onInitiativeLongPressed;
  final VoidCallback onArmorClassPressed;
  final VoidCallback onSpeedPressed;

  @override
  Widget build(BuildContext context) {
    return SegmentedStatBar(
      segments: [
        SegmentedStatBarItem(
          icon: Icons.favorite,
          value: formatHpLabel(character),
          mediumValue: formatHpLabel(
            character,
            density: HpLabelDensity.withoutTemporary,
          ),
          shortValue: formatHpLabel(
            character,
            density: HpLabelDensity.currentOnly,
          ),
          onPressed: onHpPressed,
        ),
        SegmentedStatBarItem(
          icon: Icons.bolt,
          value: formatInitiativeLabel(character),
          onPressed: onInitiativePressed,
          onLongPress: onInitiativeLongPressed,
        ),
        SegmentedStatBarItem(
          icon: Icons.shield_outlined,
          value: formatArmorClassLabel(character),
          onPressed: onArmorClassPressed,
        ),
        SegmentedStatBarItem(
          icon: Icons.directions_run,
          value: formatSpeedLabel(character),
          onPressed: onSpeedPressed,
        ),
      ],
    );
  }
}
