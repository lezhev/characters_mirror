import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';

class CharacterPersonalSummary extends StatelessWidget {
  const CharacterPersonalSummary({
    required this.character,
    required this.onTap,
    super.key,
  });

  final CharacterData character;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fields = <(String, String?)>[
      ('Возраст', character.age),
      ('Рост', character.height),
      ('Вес', character.weight),
      ('Глаза', character.eyes),
      ('Кожа', character.skin),
      ('Волосы', character.hair),
    ];

    return SheetOutlineCard(
      onTap: onTap,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Описание персонажа',
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
          const SizedBox(height: 10),
          Text('Основные характеристики', style: theme.textTheme.bodySmall),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 420 ? 3 : 2;
              final gap = 8.0;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final (label, value) in fields)
                    SizedBox(
                      width: width,
                      child: _PersonalSummaryCell(
                        label: label,
                        value: value,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PersonalSummaryCell extends StatelessWidget {
  const _PersonalSummaryCell({required this.label, required this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final displayValue = value?.trim();

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              displayValue == null || displayValue.isEmpty ? '—' : displayValue,
              style: theme.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
