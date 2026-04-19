import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character/class_race_formatters.dart';
import 'package:flutter/material.dart';

class ClassRaceDetailsPage extends StatelessWidget {
  const ClassRaceDetailsPage({
    required this.character,
    super.key,
  });

  final CharacterData character;

  @override
  Widget build(BuildContext context) {
    final classEntries = sortedClassEntries(character.classEntries);
    final subclassEntries = [
      for (final entry in classEntries)
        if (normalizedText(entry.subclass?.name) != null) entry,
    ];
    final subrace = character.subrace;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Класс и раса'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: PageSizeLimiter(
            child: ListView(
              children: [
                _DetailsSection(
                  title: 'Класс',
                  children: classEntries.isEmpty
                      ? [
                          const Text('Класс не выбран.'),
                        ]
                      : [
                          for (var index = 0;
                              index < classEntries.length;
                              index++) ...[
                            _ClassEntryDetails(entry: classEntries[index]),
                            if (index < classEntries.length - 1)
                              const Divider(height: 24),
                          ],
                        ],
                ),
                const SizedBox(height: 12),
                if (subclassEntries.isNotEmpty) ...[
                  _DetailsSection(
                    title: 'Подкласс',
                    children: [
                      for (var index = 0;
                          index < subclassEntries.length;
                          index++) ...[
                        _SubclassDetails(entry: subclassEntries[index]),
                        if (index < subclassEntries.length - 1)
                          const Divider(height: 24),
                      ],
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                _DetailsSection(
                  title: 'Раса',
                  children: [
                    _DetailRow(
                      label: 'Раса',
                      value:
                          displayName(character.race?.name, 'Раса не выбрана'),
                    ),
                    if (normalizedText(subrace?.name) != null)
                      _DetailRow(
                        label: 'Подраса',
                        value: subrace!.name!.trim(),
                      ),
                  ],
                ),
                if (normalizedText(subrace?.description) != null) ...[
                  const SizedBox(height: 12),
                  _DetailsSection(
                    title: 'Подраса',
                    children: [
                      Text(
                        subrace!.name?.trim() ?? 'Подраса',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subrace.description!.trim(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ClassEntryDetails extends StatelessWidget {
  const _ClassEntryDetails({
    required this.entry,
  });

  final CharacterClassEntryData entry;

  @override
  Widget build(BuildContext context) {
    final classData = entry.classData;
    final rows = <_DetailRow>[
      _DetailRow(
        label: 'Класс',
        value: displayName(classData?.name, 'Класс не выбран'),
      ),
      if (entry.level != null)
        _DetailRow(label: 'Уровень', value: '${entry.level}'),
      if (normalizedText(entry.subclass?.name) != null)
        _DetailRow(label: 'Подкласс', value: entry.subclass!.name!.trim()),
      if (classData?.hitDieValue != null)
        _DetailRow(label: 'Кость хитов', value: 'd${classData!.hitDieValue}'),
      if (classData?.primaryAbilities?.isNotEmpty ?? false)
        _DetailRow(
          label: 'Ключевые характеристики',
          value: joinAbilities(classData!.primaryAbilities!),
        ),
      if (classData?.savingThrowProficiencies?.isNotEmpty ?? false)
        _DetailRow(
          label: 'Спасброски',
          value: joinAbilities(classData!.savingThrowProficiencies!),
        ),
      if (classData?.armorTraining?.isNotEmpty ?? false)
        _DetailRow(
          label: 'Броня',
          value: joinArmorCategories(classData!.armorTraining!),
        ),
      if (classData?.weaponTraining?.isNotEmpty ?? false)
        _DetailRow(
          label: 'Оружие',
          value: joinWeaponCategories(classData!.weaponTraining!),
        ),
      if (classData?.toolTraining?.isNotEmpty ?? false)
        _DetailRow(
          label: 'Инструменты',
          value: classData!.toolTraining!.join(', '),
        ),
      if (classData?.spellcastingAbilityValue != null)
        _DetailRow(
          label: 'Базовая характеристика заклинаний',
          value: abilityLabel(classData!.spellcastingAbilityValue!),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }
}

class _SubclassDetails extends StatelessWidget {
  const _SubclassDetails({
    required this.entry,
  });

  final CharacterClassEntryData entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subclass = entry.subclass;
    final className = normalizedText(entry.classData?.name);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayName(subclass?.name, 'Подкласс'),
          style: theme.textTheme.titleSmall,
        ),
        if (className != null) ...[
          const SizedBox(height: 4),
          Text(
            className,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
        if (normalizedText(subclass?.description) != null) ...[
          const SizedBox(height: 8),
          Text(
            subclass!.description!.trim(),
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ],
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 144,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
