part of '../character_data_endpoint.dart';

CharacterData _addLevelUpChoices(
    CharacterData draft,
    CharacterClassEntryData entry,
    List<ChoiceGroupView> groups,
    LevelUpRequest request) {
  final available = {for (final view in groups) view.group!.referenceKey: view};
  final choices = [...?draft.choices];
  for (final selection
      in request.choices?.entries ?? const <MapEntry<String, List<String>>>[]) {
    final view = available[selection.key];
    if (view == null) {
      throw InputValidationException(
          'choices', 'Choice is not unlocked by this level-up.');
    }
    for (var i = 0; i < selection.value.length; i++) {
      choices.add(CharacterChoiceData(
          id: _generateSyncId(),
          classEntry: entry,
          groupKey: selection.key,
          optionKey: selection.value[i],
          selectionIndex: i));
    }
  }
  return draft.copyWith(choices: choices);
}

List<String> _missingLevelUpChoices(
    List<ChoiceGroupView> groups, LevelUpRequest request) {
  final missing = <String>[];
  final selectedExclusive = {
    for (final g in groups)
      if ((request.choices?[g.group!.referenceKey]?.isNotEmpty ?? false) &&
          g.group!.exclusiveKey != null)
        g.group!.exclusiveKey!
  };
  final reportedExclusive = <String>{};
  for (final view in groups) {
    final group = view.group!;
    final exclusive = group.exclusiveKey;
    final selected = request.choices?[group.referenceKey] ?? const <String>[];
    if (exclusive != null &&
        selectedExclusive.contains(exclusive) &&
        selected.isEmpty) {
      continue;
    }
    if (exclusive != null &&
        selected.isEmpty &&
        !reportedExclusive.add(exclusive)) {
      continue;
    }
    final minimum = group.minimumSelectionCount ?? group.selectionCount ?? 1;
    if (minimum == 0) continue;
    if (group.type == ChoiceType.abilityIncrease) {
      final points = selected.fold<int>(
          0,
          (sum, key) =>
              sum +
              (view.options
                      ?.where((o) => o.optionKey == key)
                      .firstOrNull
                      ?.grantedAbilityBonuses
                      ?.values
                      .fold<int>(0, (a, b) => a + b) ??
                  0));
      if (points != 2) {
        missing.add('Распределите 2 очка характеристик или выберите черту');
      }
    } else if (selected.length < minimum) {
      missing.add('Завершите выбор: ${group.name ?? group.referenceKey}');
    }
  }
  return missing;
}

void _validateLevelUpAsi(CharacterData before, CharacterDerivedData after,
    List<ChoiceGroupView> groups, LevelUpRequest request) {
  for (final view
      in groups.where((g) => g.group!.type == ChoiceType.abilityIncrease)) {
    final keys = request.choices?[view.group!.referenceKey] ?? const <String>[];
    final bonuses = <String, int>{};
    for (final key in keys) {
      final option = view.options?.where((o) => o.optionKey == key).firstOrNull;
      for (final e in option?.grantedAbilityBonuses?.entries ??
          const <MapEntry<String, int>>[]) {
        if (e.value < 0 || e.value > 2) {
          throw InputValidationException('choices', 'Invalid ASI option.');
        }
        bonuses[e.key] = (bonuses[e.key] ?? 0) + e.value;
      }
    }
    if (bonuses.values.fold<int>(0, (a, b) => a + b) > 2) {
      throw InputValidationException('choices', 'ASI exceeds two points.');
    }
    for (final e in bonuses.entries) {
      final ability = Ability.values.where((a) => a.name == e.key).firstOrNull;
      if (ability == null ||
          e.value > 2 ||
          (after.abilityScores?[ability] ?? 10) > 20) {
        throw InputValidationException(
            'choices', 'ASI cannot raise an ability above 20.');
      }
    }
  }
}
