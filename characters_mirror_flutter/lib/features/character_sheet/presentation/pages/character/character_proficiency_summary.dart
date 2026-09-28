import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/character_proficiency_labels.dart';
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

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Владения персонажа',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    if (sections.isEmpty)
                      Text('Пока ничего не добавлено.',
                          style: Theme.of(context).textTheme.bodyMedium)
                    else
                      for (final (label, values) in sections)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text('$label: ${values.join(', ')}'),
                        ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ],
          ),
        ),
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
