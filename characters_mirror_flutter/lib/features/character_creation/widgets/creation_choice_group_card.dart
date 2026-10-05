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

  final ChoiceGroupView groupView;
  final List<ChoiceOptionData> selectedOptions;
  final void Function(ChoiceGroupData group, ChoiceOptionData option)
      onToggleOption;
  final void Function(ChoiceGroupData group, ChoiceOptionData option)
      onIncrementOption;
  final void Function(ChoiceGroupData group, ChoiceOptionData option)
      onDecrementOption;
  final void Function(ChoiceGroupData group) onClearGroup;

  @override
  Widget build(BuildContext context) {
    final group = groupView.group;
    if (group == null) return const SizedBox.shrink();

    final options = [...?groupView.options]
      ..sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
    final eligibilityByOptionKey = {
      for (final eligibility in groupView.optionEligibility ??
          const <ChoiceOptionEligibilityView>[])
        eligibility.optionKey: eligibility,
    };
    final selectionCount = group.selectionCount ?? 1;
    final allowDuplicates = group.allowDuplicates == true;
    final selectedCountByOptionKey = <String, int>{};
    for (final option in selectedOptions) {
      final optionKey = option.optionKey.trim();
      if (optionKey.isEmpty) continue;
      selectedCountByOptionKey[optionKey] =
          (selectedCountByOptionKey[optionKey] ?? 0) + 1;
    }
    final groupTitle = group.name ?? 'Выбор';
    final groupDescription = group.description;
    final switchKey = group.exclusiveKey ?? group.id ?? groupTitle;

    if (!allowDuplicates) {
      final items = options.map((option) {
        final optionKey = option.optionKey.trim();
        final isSelected = optionKey.isNotEmpty &&
            (selectedCountByOptionKey[optionKey] ?? 0) > 0;
        final eligibility = eligibilityByOptionKey[optionKey];
        final title = _choiceOptionTitle(group, option);
        return CreationChoiceSelectorItem(
          id: optionKey.isEmpty ? title : optionKey,
          title: title,
          subtitle: _optionSubtitle(option.description, eligibility),
          isSelected: isSelected,
          isEnabled: eligibility?.isEligible != false || isSelected,
          onTap: eligibility?.isEligible == false && !isSelected
              ? null
              : () => onToggleOption(group, option),
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
        final optionKey = option.optionKey.trim();
        final title = _choiceOptionTitle(group, option);
        final count =
            optionKey.isEmpty ? 0 : (selectedCountByOptionKey[optionKey] ?? 0);
        final eligibility = eligibilityByOptionKey[optionKey];
        return CreationChoiceSelectorItem(
          id: optionKey.isEmpty ? title : optionKey,
          title: title,
          count: count,
          subtitle: _optionSubtitle(option.description, eligibility),
          onIncrement: eligibility?.isEligible == false
              ? null
              : () => onIncrementOption(group, option),
          onDecrement: () => onDecrementOption(group, option),
        );
      }).toList(),
    );
  }
}

String? _optionSubtitle(
  String? description,
  ChoiceOptionEligibilityView? eligibility,
) {
  if (eligibility?.isEligible != false) return description;
  final reasons = eligibility!.failedRequirements
          ?.map((failure) => switch (failure.reason) {
                'minimumClassLevel' =>
                  'Необходимый уровень класса не достигнут',
                'minimumCharacterLevel' =>
                  'Необходимый уровень персонажа не достигнут',
                'abilityScore' => 'Недостаточное значение характеристики',
                'knownSpell' => 'Необходимо знать указанное заклинание',
                'knownCantrip' => 'Необходимо знать указанный заговор',
                'feature' => 'Необходимая особенность отсутствует',
                'selectedChoiceOption' => 'Сначала выберите зависимый вариант',
                'existingSkill' => 'Требуется владение указанным навыком',
                'existingTool' => 'Требуется владение указанным инструментом',
                _ => 'Требование не выполнено',
              })
          .toSet()
          .join('; ') ??
      '';
  final status =
      'Недоступно: ${reasons.isEmpty ? 'требование не выполнено' : reasons}';
  return description == null || description.isEmpty
      ? status
      : '$description\n$status';
}

String _choiceOptionTitle(
  ChoiceGroupData group,
  ChoiceOptionData option,
) {
  if (group.type == ChoiceType.language) {
    final languages = option.grantedLanguages ?? const <Language>[];
    if (languages.length == 1) {
      return languageLabel(languages.single);
    }
  }
  return option.name ?? (option.optionKey.isEmpty ? 'Опция' : option.optionKey);
}

bool _shouldDisableChoiceAutoScroll(ChoiceType? type) {
  switch (type) {
    case ChoiceType.language:
      return true;
    case ChoiceType.tool:
    case ChoiceType.fightingStyle:
    case ChoiceType.expertise:
    case ChoiceType.subclassFeature:
    case ChoiceType.featureOption:
    case ChoiceType.invocation:
    case ChoiceType.abilityIncrease:
    case ChoiceType.feat:
    case ChoiceType.custom:
    case null:
      return false;
  }
}
