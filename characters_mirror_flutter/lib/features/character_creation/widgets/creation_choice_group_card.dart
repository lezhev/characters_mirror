import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_cards_switcher.dart';
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
    final groupTitle = group.name ?? 'Выбор';
    final groupDescription = group.description;

    if (!allowDuplicates) {
      return CreationChoiceCardsSwitcher(
        title: groupTitle,
        description: groupDescription,
        switchKey: group.exclusiveKey ?? group.id ?? groupTitle,
        onClear: selectedOptions.isNotEmpty ? () => onClearGroup(group) : null,
        autoScrollOnExpand: !_shouldDisableChoiceAutoScroll(group.type),
        items: options.map((option) {
          final optionKey = option.optionKey?.trim();
          final isSelected = optionKey != null &&
              (selectedCountByOptionKey[optionKey] ?? 0) > 0;
          final title = option.name ?? option.optionKey ?? 'Опция';
          return CreationChoiceCardItem(
            id: optionKey ?? title,
            title: title,
            subtitle: option.description,
            isSelected: isSelected,
            onTap: () => onToggleOption(group, option),
            onInfoTap: () => showChoiceOptionPlaceholderDialog(
              context: context,
              title: title,
              description: option.description,
            ),
          );
        }).toList(),
      );
    }

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
                    Text(groupTitle, style: textTheme.titleMedium),
                    if ((groupDescription ?? '').trim().isNotEmpty) ...[
                      const Gap(6),
                      Text(groupDescription!, style: textTheme.bodyMedium),
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
          ),
        ],
      ),
    );
  }
}

bool _shouldDisableChoiceAutoScroll(ClassChoiceType? type) {
  switch (type) {
    case ClassChoiceType.skill:
    case ClassChoiceType.spell:
    case ClassChoiceType.cantrip:
      return true;
    case ClassChoiceType.tool:
    case ClassChoiceType.language:
    case ClassChoiceType.fightingStyle:
    case ClassChoiceType.expertise:
    case ClassChoiceType.subclassFeature:
    case ClassChoiceType.featureOption:
    case ClassChoiceType.invocation:
    case ClassChoiceType.abilityIncrease:
    case ClassChoiceType.feat:
    case ClassChoiceType.custom:
    case null:
      return false;
  }
}
