part of '../character_data_endpoint.dart';

({List<CharacterChoiceData> choices, List<String> missingGroups})
    _resolveAutomaticChoices(
  CharacterData character,
  List<ChoiceGroupData> groups,
  Map<String, Map<String, ChoiceOptionData>> options,
  Map<String, List<_SelectedGenericChoice>> selections,
  List<ClassFeatureData> classFeatures,
  List<SubclassFeatureData> subclassFeatures,
  Set<String> cantripKeys,
  Map<String, Set<String>> grantedCantrips,
) {
  final automatic = <CharacterChoiceData>[];
  final missing = <String>[];
  for (final group in groups) {
    if (group.autoSelectSingleEligible != true ||
        (selections[group.referenceKey]?.isNotEmpty ?? false)) {
      continue;
    }
    final selectedOptions = {
      for (final entry in selections.entries)
        entry.key: entry.value.map((choice) => choice.option).toList()
    };
    final context = buildChoiceEligibilityContext(
      character: character,
      evaluatingGroupKey: group.referenceKey,
      selectedOptionsByGroupKey: selectedOptions,
      groups: groups,
      abilityScores: _buildAbilityScores(character,
          selectedOptions.values.expand((options) => options).toList()),
      currentClassFeatures: classFeatures,
      currentSubclassFeatures: subclassFeatures,
      cantripReferenceKeys: cantripKeys,
      grantedCantripKeys: grantedCantrips[group.referenceKey] ?? {},
    );
    final optionKey = automaticChoiceOptionKey(
        (options[group.referenceKey]?.values ?? <ChoiceOptionData>[])
            .map((option) => option.toJson()),
        context);
    if (optionKey == null) {
      missing.add(group.referenceKey);
      continue;
    }
    final parentClassId = classFeatures
        .where((feature) => feature.id == group.sourceFeatureId)
        .firstOrNull
        ?.parentClassId;
    final parentSubclassId = subclassFeatures
        .where((feature) => feature.id == group.sourceSubclassFeatureId)
        .firstOrNull
        ?.parentSubclassId;
    final entry = character.classEntries
        ?.where((entry) =>
            (group.sourceClassId != null &&
                entry.classData?.id == group.sourceClassId) ||
            (group.sourceSubclassId != null &&
                entry.subclass?.id == group.sourceSubclassId) ||
            (parentClassId != null && entry.classData?.id == parentClassId) ||
            (parentSubclassId != null &&
                entry.subclass?.id == parentSubclassId))
        .firstOrNull;
    final choice = CharacterChoiceData(
      id: _generateSyncId(),
      groupKey: group.referenceKey,
      optionKey: optionKey,
      selectionIndex: 0,
      classEntry: entry,
    );
    final option = options[group.referenceKey]![optionKey]!;
    selections[group.referenceKey] = [_SelectedGenericChoice(choice, option)];
    automatic.add(choice);
  }
  return (choices: automatic, missingGroups: missing);
}
