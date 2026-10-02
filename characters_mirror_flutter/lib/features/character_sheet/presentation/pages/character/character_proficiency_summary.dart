import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiency_labels.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';

class CharacterProficiencySummary extends StatelessWidget {
  const CharacterProficiencySummary({
    required this.character,
    required this.toolNames,
    required this.weaponNames,
    required this.onTap,
    super.key,
  });

  final CharacterData character;
  final Map<String, String> toolNames;
  final Map<String, String> weaponNames;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final derived = character.derived;
    final sections = <(String, List<String>)>[
      (
        'Языки',
        _unique([
          ...?derived?.languages?.map(languageProficiencyLabel),
          ...?derived?.customLanguages,
        ]),
      ),
      (
        'Инструменты',
        _unique([
          ...?derived?.toolProficiencyKeys?.map(
            (key) => toolNames[key] ?? 'Неизвестный инструмент',
          ),
          ...?derived?.customToolProficiencies,
        ]),
      ),
      (
        'Оружие',
        _unique([
          ...?derived?.weaponTraining?.map(weaponCategoryProficiencyLabel),
          ...?derived?.weaponProficiencyKeys?.map(
            (key) => weaponNames[key] ?? 'Неизвестное оружие',
          ),
          ...?derived?.customWeaponProficiencies,
        ]),
      ),
      (
        'Доспехи',
        _unique([
          ...?derived?.armorTraining?.map(armorCategoryProficiencyLabel),
          ...?derived?.customArmorTraining,
        ]),
      ),
    ].where((section) => section.$2.isNotEmpty).toList();

    final theme = Theme.of(context);

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
                  'Владения персонажа',
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
          const SizedBox(height: 8),
          if (sections.isEmpty)
            Text('Пока ничего не добавлено.', style: theme.textTheme.bodyMedium)
          else
            for (var index = 0; index < sections.length; index++) ...[
              if (index > 0) const Divider(height: 12),
              _ProficiencyRow(
                label: sections[index].$1,
                value: sections[index].$2.join(', '),
              ),
            ],
        ],
      ),
    );
  }

  static List<String> _unique(Iterable<String> values) {
    final seen = <String>{};
    return [
      for (final value in values)
        if (value.trim().isNotEmpty && seen.add(value.toLowerCase())) value,
    ];
  }
}

class _ProficiencyRow extends StatelessWidget {
  const _ProficiencyRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
