import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:flutter/material.dart';

class ClassProfileCard extends StatelessWidget {
  const ClassProfileCard({
    required this.classData,
    super.key,
  });

  final ClassData classData;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final description = classData.description;
    final details = <(String, String)>[
      if (classData.hitDieValue case final hitDie?) ('Кость хитов', 'd$hitDie'),
      if (classData.primaryAbilities?.isNotEmpty ?? false)
        (
          'Ключевые характеристики',
          classData.primaryAbilities!.map(attributesAbilityLabel).join(', '),
        ),
      if (classData.savingThrowProficiencies?.isNotEmpty ?? false)
        (
          'Спасброски',
          classData.savingThrowProficiencies!
              .map(attributesAbilityLabel)
              .join(', '),
        ),
      if (classData.spellcastingAbilityValue case final ability?)
        ('Магия', attributesAbilityLabel(ability)),
    ];

    return AppSurfaceCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (description != null && description.trim().isNotEmpty) ...[
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
              textAlign: TextAlign.start,
            ),
            if (details.isNotEmpty) const SizedBox(height: 12),
          ],
          for (var index = 0; index < details.length; index++) ...[
            _ClassProfileDetail(
              label: details[index].$1,
              value: details[index].$2,
            ),
            if (index < details.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _ClassProfileDetail extends StatelessWidget {
  const _ClassProfileDetail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width:
                constraints.maxWidth < 460 ? constraints.maxWidth * 0.46 : 200,
            child: Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
