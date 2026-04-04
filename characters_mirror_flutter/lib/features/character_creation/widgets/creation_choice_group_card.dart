import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreationChoiceGroupCard extends StatelessWidget {
  const CreationChoiceGroupCard({
    required this.groupView,
    required this.selectedOptions,
    required this.onToggleOption,
    required this.onIncrementOption,
    required this.onDecrementOption,
    required this.onClearGroup,
    super.key,
  });

  final ClassChoiceGroupView groupView;
  final List<ClassChoiceOptionData> selectedOptions;
  final void Function(ClassChoiceGroupData group, ClassChoiceOptionData option)
      onToggleOption;
  final void Function(ClassChoiceGroupData group, ClassChoiceOptionData option)
      onIncrementOption;
  final void Function(ClassChoiceGroupData group, ClassChoiceOptionData option)
      onDecrementOption;
  final void Function(ClassChoiceGroupData group) onClearGroup;

  @override
  Widget build(BuildContext context) {
    final group = groupView.group;
    if (group == null) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final options = [...?groupView.options]
      ..sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    final selectionCount = group.selectionCount ?? 1;
    final allowDuplicates = group.allowDuplicates == true;
    final selectedCountByOptionKey = <String, int>{};
    for (final option in selectedOptions) {
      final optionKey = option.optionKey?.trim();
      if (optionKey == null || optionKey.isEmpty) continue;
      selectedCountByOptionKey[optionKey] =
          (selectedCountByOptionKey[optionKey] ?? 0) + 1;
    }
    final isSingleChoice = selectionCount <= 1 && !allowDuplicates;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: colorScheme.surfaceDim,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(group.name ?? 'Выбор', style: textTheme.titleMedium),
                    if ((group.description ?? '').trim().isNotEmpty) ...[
                      const Gap(6),
                      Text(group.description!, style: textTheme.bodyMedium),
                    ],
                  ],
                ),
              ),
              if (selectedOptions.isNotEmpty)
                TextButton(
                  onPressed: () => onClearGroup(group),
                  child: const Text('Сбросить'),
                ),
            ],
          ),
          const Gap(10),
          Text(
            _selectionHint(
              selectionCount: selectionCount,
              allowDuplicates: allowDuplicates,
            ),
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(10),
          if (allowDuplicates)
            Column(
              children: options.map((option) {
                final optionKey = option.optionKey?.trim();
                final count = optionKey == null
                    ? 0
                    : (selectedCountByOptionKey[optionKey] ?? 0);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          option.name ?? option.optionKey ?? 'Опция',
                          style: textTheme.bodyMedium,
                        ),
                      ),
                      IconButton(
                        onPressed: count > 0
                            ? () => onDecrementOption(group, option)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text('$count', style: textTheme.titleSmall),
                      IconButton(
                        onPressed: selectedOptions.length < selectionCount
                            ? () => onIncrementOption(group, option)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                );
              }).toList(),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final optionKey = option.optionKey?.trim();
                final isSelected = optionKey != null &&
                    (selectedCountByOptionKey[optionKey] ?? 0) > 0;

                final chip = isSingleChoice
                    ? ChoiceChip(
                        label: Text(option.name ?? option.optionKey ?? 'Опция'),
                        selected: isSelected,
                        onSelected: (_) => onToggleOption(group, option),
                      )
                    : FilterChip(
                        label: Text(option.name ?? option.optionKey ?? 'Опция'),
                        selected: isSelected,
                        onSelected: (_) => onToggleOption(group, option),
                      );
                return chip;
              }).toList(),
            ),
          if (selectedOptions.any(
            (option) => (option.description ?? '').trim().isNotEmpty,
          )) ...[
            const Gap(10),
            ...selectedOptions
                .where((option) => (option.description ?? '').trim().isNotEmpty)
                .map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Text(
                      option.description!,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

String _selectionHint({
  required int selectionCount,
  required bool allowDuplicates,
}) {
  if (allowDuplicates) {
    return 'Выберите до $selectionCount. Одинаковые опции можно брать несколько раз.';
  }
  if (selectionCount <= 1) {
    return 'Выберите 1.';
  }
  return 'Выберите до $selectionCount.';
}
