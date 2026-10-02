import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_formatters.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';

class CharacterClassRaceSummary extends StatelessWidget {
  const CharacterClassRaceSummary({
    required this.character,
    required this.onTap,
    super.key,
  });

  final CharacterData character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SheetOutlineCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Класс и раса',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 24,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            classSummary(character.classEntries),
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            raceSummary(character.race, character.subrace),
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
