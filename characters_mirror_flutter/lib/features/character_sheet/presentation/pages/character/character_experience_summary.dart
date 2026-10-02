import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';

class CharacterExperienceSummary extends StatelessWidget {
  const CharacterExperienceSummary({
    required this.character,
    this.onTap,
    this.currentLevelStartExperience,
    this.nextLevelExperience,
    super.key,
  });

  final CharacterData character;
  final VoidCallback? onTap;
  final int? currentLevelStartExperience;
  final int? nextLevelExperience;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final experience = character.experience;
    final totalLevel = character.derived?.totalLevel;
    final hasProgressTarget = experience != null &&
        currentLevelStartExperience != null &&
        nextLevelExperience != null &&
        nextLevelExperience! > currentLevelStartExperience!;
    final progress = hasProgressTarget
        ? ((experience - currentLevelStartExperience!) /
                (nextLevelExperience! - currentLevelStartExperience!))
            .clamp(0.0, 1.0)
        : null;

    return SheetOutlineCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child:
                    Text('Уровень и опыт', style: theme.textTheme.titleMedium),
              ),
              Icon(
                Icons.chevron_right,
                size: 24,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  totalLevel == null
                      ? 'Уровень не указан'
                      : '$totalLevel уровень',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: Text(
                  experience == null
                      ? 'Опыт не указан'
                      : hasProgressTarget
                          ? '$experience / $nextLevelExperience опыта'
                          : '$experience опыта · порог не указан',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress ?? 0),
        ],
      ),
    );
  }
}
