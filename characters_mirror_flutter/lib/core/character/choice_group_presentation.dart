import 'package:characters_mirror_client/characters_mirror_client.dart';

enum ChoicePresentationContext { creation, levelUp }

enum ChoicePresentationMode { inline, picker }

class ChoiceOptionPresentation {
  const ChoiceOptionPresentation(
      {required this.key,
      required this.name,
      this.shortDescription,
      required this.count,
      required this.enabled,
      this.reason});
  final String key;
  final String name;
  final String? shortDescription;
  final int count;
  final bool enabled;
  final String? reason;
  bool get selected => count > 0;
}

class ChoiceGroupPresentation {
  ChoiceGroupPresentation.fromView(ChoiceGroupView view, List<String> selected,
      {ChoicePresentationMode? mode})
      : title = view.group?.name ?? 'Выбор',
        minimum = view.group?.minimumSelectionCount ??
            view.group?.selectionCount ??
            1,
        maximum = view.group?.selectionCount ?? 1,
        allowDuplicates = view.group?.allowDuplicates == true,
        selectedKeys = List.unmodifiable(selected),
        mode = mode ?? choicePresentationMode(view),
        options = List.unmodifiable([
          for (final option in view.options ?? const <ChoiceOptionData>[])
            ChoiceOptionPresentation(
              key: option.optionKey,
              name: option.name ?? option.optionKey,
              shortDescription: option.shortDescription,
              count: selected.where((key) => key == option.optionKey).length,
              enabled: view.optionEligibility
                      ?.where((e) => e.optionKey == option.optionKey)
                      .firstOrNull
                      ?.isEligible !=
                  false,
              reason: choiceDisabledReason(view.optionEligibility
                  ?.where((e) => e.optionKey == option.optionKey)
                  .firstOrNull),
            ),
        ]);
  final String title;
  final int minimum;
  final int maximum;
  final bool allowDuplicates;
  final List<String> selectedKeys;
  final List<ChoiceOptionPresentation> options;
  final ChoicePresentationMode mode;
  bool get required => minimum > 0;
  bool get complete =>
      selectedKeys.length >= minimum && selectedKeys.length <= maximum;

  String prompt(ChoicePresentationContext context) {
    final count = minimum == maximum ? '$maximum' : '$minimum–$maximum';
    if (context == ChoicePresentationContext.creation) {
      return required ? 'Выберите $count' : 'До $maximum';
    }
    return required
        ? 'Обязательно · выбрать $count'
        : 'Необязательно · до $maximum';
  }

  String get selectionSummary {
    if (selectedKeys.isEmpty) return 'Не выбрано';
    if (maximum == 1 && selectedKeys.length == 1) {
      return options
              .where((o) => o.key == selectedKeys.single)
              .firstOrNull
              ?.name ??
          'Выбрано 1';
    }
    return 'Выбрано ${selectedKeys.length} из $maximum';
  }
}

ChoicePresentationMode choicePresentationMode(ChoiceGroupView view) {
  if (view.group?.type == ChoiceType.abilityIncrease) {
    return ChoicePresentationMode.inline;
  }
  final options = view.options ?? const <ChoiceOptionData>[];
  if (view.group?.type == ChoiceType.feat ||
      view.group?.type == ChoiceType.invocation ||
      options.length > 4 ||
      options.any((o) => (o.shortDescription?.length ?? 0) > 160)) {
    return ChoicePresentationMode.picker;
  }
  return ChoicePresentationMode.inline;
}

bool showChoiceGroupTitle(String? featureTitle, String? groupTitle,
    {ChoiceType? type, int linkedGroupCount = 1}) {
  // A single typed catalog decision is already named by its owning feature.
  // Refinement prompts (for example enemy type) and multiple groups keep titles.
  if (linkedGroupCount == 1 &&
      const {
        ChoiceType.fightingStyle,
        ChoiceType.invocation,
        ChoiceType.expertise,
        ChoiceType.abilityIncrease,
        ChoiceType.feat,
      }.contains(type)) {
    return false;
  }
  String normalized(String? text) =>
      (text ?? '').trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  return normalized(groupTitle).isNotEmpty &&
      normalized(groupTitle) != normalized(featureTitle);
}

String? choiceFeatureSourceKey(ChoiceGroupData group) {
  if (group.sourceFeatureId != null) return 'class:${group.sourceFeatureId}';
  if (group.sourceSubclassFeatureId != null) {
    return 'subclass:${group.sourceSubclassFeatureId}';
  }
  return null;
}

String? choiceDisabledReason(ChoiceOptionEligibilityView? eligibility) {
  if (eligibility?.isEligible != false) return null;
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
  return 'Недоступно: ${reasons.isEmpty ? 'требование не выполнено' : reasons}';
}
