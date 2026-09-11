part of '../hit_points_calculator_sheet.dart';

class _HitPointTunePanel extends StatelessWidget {
  const _HitPointTunePanel({
    required this.character,
    required this.settings,
    required this.isSaving,
    required this.onHpGainChanged,
    required this.onHpPerLevelBonusChanged,
    required this.onHpFlatBonusChanged,
    required this.onHitDiceCurrentChanged,
    required this.onHitDiceMaxChanged,
  });

  final CharacterData character;
  final HitPointSettingsDraft settings;
  final bool isSaving;
  final void Function(int entryIndex, int levelIndex, int value)
      onHpGainChanged;
  final ValueChanged<int> onHpPerLevelBonusChanged;
  final ValueChanged<int> onHpFlatBonusChanged;
  final void Function(String key, int value) onHitDiceCurrentChanged;
  final void Function(String key, int value) onHitDiceMaxChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final descriptors = hitPointLevelDescriptors(settings.classEntries);
    final baseHitDiceMax = baseHitDiceMaxFromCharacter(character);
    final hitDiceMax = effectiveHitDiceMax(
      baseHitDiceMax,
      settings.hitDiceMaxOverrides,
    );
    final currentHitDice = effectiveCurrentHitDice(
      settings.currentHitDice,
      hitDiceMax,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Настройка максимума', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            if (descriptors.isEmpty)
              Text('Нет уровней класса', style: theme.textTheme.bodyMedium)
            else
              for (final entry in settings.classEntries)
                _ClassHpGainGroup(
                  entry: entry,
                  descriptors: descriptors
                      .where((item) => identical(item.entry, entry))
                      .toList(),
                  isSaving: isSaving,
                  onChanged: onHpGainChanged,
                ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AutosaveNumberField(
                    label: 'Бонус за уровень',
                    value: settings.hpPerLevelBonus,
                    signed: true,
                    enabled: !isSaving,
                    onSave: onHpPerLevelBonusChanged,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _AutosaveNumberField(
                    label: 'Единоразовый бонус',
                    value: settings.hpFlatBonus,
                    signed: true,
                    enabled: !isSaving,
                    onSave: onHpFlatBonusChanged,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Кости хитов', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (hitDiceMax.isEmpty)
              Text('Нет костей хитов', style: theme.textTheme.bodyMedium)
            else
              for (final key in hitDiceMax.keys)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      SizedBox(width: 44, child: Text(key)),
                      Expanded(
                        child: _AutosaveNumberField(
                          label: 'Текущие',
                          value: currentHitDice[key] ?? 0,
                          min: 0,
                          max: hitDiceMax[key],
                          enabled: !isSaving,
                          onSave: (value) =>
                              onHitDiceCurrentChanged(key, value),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _AutosaveNumberField(
                          label: 'Максимум',
                          value: hitDiceMax[key] ?? 0,
                          min: 0,
                          enabled: !isSaving,
                          onSave: (value) => onHitDiceMaxChanged(key, value),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _ClassHpGainGroup extends StatelessWidget {
  const _ClassHpGainGroup({
    required this.entry,
    required this.descriptors,
    required this.isSaving,
    required this.onChanged,
  });

  final CharacterClassEntryData entry;
  final List<HitPointLevelDescriptor> descriptors;
  final bool isSaving;
  final void Function(int entryIndex, int levelIndex, int value) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final className = entry.classData?.name ?? 'Класс';

    if (descriptors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(className, style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final descriptor in descriptors)
                SizedBox(
                  width: 96,
                  child: _AutosaveNumberField(
                    label: 'Ур. ${descriptor.characterLevel}',
                    value: descriptor.value,
                    min: 1,
                    max: descriptor.hitDie,
                    enabled: !isSaving,
                    onSave: (value) => onChanged(
                      descriptor.entryIndex,
                      descriptor.levelIndex,
                      value,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
