import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/language_labels.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_choice_selector.dart';
import 'package:flutter/material.dart';

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
    final switchKey = group.exclusiveKey ?? group.id ?? groupTitle;

    if (!allowDuplicates) {
      final items = options.map((option) {
        final optionKey = option.optionKey?.trim();
        final isSelected =
            optionKey != null && (selectedCountByOptionKey[optionKey] ?? 0) > 0;
        final title = _choiceOptionTitle(group, option);
        return CreationChoiceSelectorItem(
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
      }).toList();

      if (selectionCount <= 1) {
        return CreationChoiceSelector.single(
          title: groupTitle,
          description: groupDescription,
          switchKey: switchKey,
          onClear:
              selectedOptions.isNotEmpty ? () => onClearGroup(group) : null,
          autoScrollOnExpand: !_shouldDisableChoiceAutoScroll(group.type),
          items: items,
        );
      }

      return CreationChoiceSelector.multi(
        title: groupTitle,
        description: groupDescription,
        switchKey: switchKey,
        selectionLimit: selectionCount,
        onClear: selectedOptions.isNotEmpty ? () => onClearGroup(group) : null,
        autoScrollOnExpand: !_shouldDisableChoiceAutoScroll(group.type),
        items: items,
      );
    }

    return CreationChoiceSelector.counter(
      title: groupTitle,
      description: groupDescription,
      switchKey: switchKey,
      selectionLimit: selectionCount,
      onClear: selectedOptions.isNotEmpty ? () => onClearGroup(group) : null,
      items: options.map((option) {
        final optionKey = option.optionKey?.trim();
        final title = _choiceOptionTitle(group, option);
        final count =
            optionKey == null ? 0 : (selectedCountByOptionKey[optionKey] ?? 0);
        return CreationChoiceSelectorItem(
          id: optionKey ?? title,
          title: title,
          count: count,
          onIncrement: () => onIncrementOption(group, option),
          onDecrement: () => onDecrementOption(group, option),
        );
      }).toList(),
    );
  }
}

String _choiceOptionTitle(
  ClassChoiceGroupData group,
  ClassChoiceOptionData option,
) {
  if (group.type == ClassChoiceType.language) {
    final languages = option.grantedLanguages ?? const <Language>[];
    if (languages.length == 1) {
      return languageLabel(languages.single);
    }
  }
  return option.name ?? option.optionKey ?? 'Опция';
}

bool _shouldDisableChoiceAutoScroll(ClassChoiceType? type) {
  switch (type) {
    case ClassChoiceType.skill:
    case ClassChoiceType.language:
      return true;
    case ClassChoiceType.tool:
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
