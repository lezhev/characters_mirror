import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

ChoiceEligibilityContext conditionalChoiceContext({
  required CharacterData character,
  required ChoiceGroupData group,
  required Iterable<ChoiceOptionData> options,
  Iterable<ChoiceOptionData> otherOptions = const [],
  Iterable<ClassFeatureData> classFeatures = const [],
  Iterable<SubclassFeatureData> subclassFeatures = const [],
  Iterable<String> otherGrantedCantripKeys = const [],
  Map<String, List<ChoiceOptionData>> selectedOptionsByGroupKey = const {},
}) {
  final facts = collectChoiceSpellFacts([
    for (final s
        in character.spellSelections ?? <CharacterSpellSelectionData>[])
      if (s.spellKey != null && s.kind != null)
        ChoiceSpellSelectionFact(key: s.spellKey!, kind: s.kind!.name),
  ]);
  return ChoiceEligibilityContext(
    totalCharacterLevel: character.classEntries
            ?.fold<int>(0, (sum, e) => sum + (e.level ?? 0)) ??
        1,
    classLevelsByReferenceKey: {
      for (final e in character.classEntries ?? <CharacterClassEntryData>[])
        if (e.classData?.referenceKey != null)
          e.classData!.referenceKey!: e.level ?? 0,
    },
    abilityScores: character.baseAbilityScores ?? {},
    knownSpellKeys: facts.knownSpellKeys,
    knownCantripKeys: knownChoiceCantripKeys(
      character: character.toJson(),
      otherOptions: otherOptions.map((o) => o.toJson()),
      otherFeatures: [
        ...classFeatures
            .where((f) => f.id != group.sourceFeatureId)
            .map((f) => f.toJson()),
        ...subclassFeatures
            .where((f) => f.id != group.sourceSubclassFeatureId)
            .map((f) => f.toJson()),
      ],
      cantripReferenceKeys:
          choiceCantripCandidateKeys(options.map((o) => o.toJson())),
      otherGrantedCantripKeys: otherGrantedCantripKeys,
    ),
    featureKeys: {
      ...classFeatures.map((f) => f.referenceKey).whereType<String>(),
      ...subclassFeatures.map((f) => f.referenceKey).whereType<String>(),
    },
    selectedChoiceOptionKeys: {
      for (final c in character.choices ?? <CharacterChoiceData>[])
        if (c.groupKey != null && c.optionKey != null)
          encodeSelectedChoiceOptionKey(c.groupKey!, c.optionKey!),
      for (final entry in selectedOptionsByGroupKey.entries)
        for (final option in entry.value)
          encodeSelectedChoiceOptionKey(entry.key, option.optionKey),
    },
  );
}

Map<String, List<ChoiceOptionData>> resolveConditionalChoiceSelections({
  required CharacterData character,
  required Iterable<ChoiceGroupView> groups,
  required Map<String, List<ChoiceOptionData>> selections,
  Iterable<ChoiceOptionData> otherOptions = const [],
  Iterable<ClassFeatureData> classFeatures = const [],
  Iterable<SubclassFeatureData> subclassFeatures = const [],
}) {
  final result = Map<String, List<ChoiceOptionData>>.from(selections);
  for (final view in groups) {
    final group = view.group;
    if (group == null) continue;
    final options = view.options ?? <ChoiceOptionData>[];
    final context = conditionalChoiceContext(
      character: character,
      group: group,
      options: options,
      otherOptions: [
        ...otherOptions,
        ...result.entries
            .where((e) => e.key != group.referenceKey)
            .expand((e) => e.value)
      ],
      selectedOptionsByGroupKey: result,
      classFeatures: classFeatures,
      subclassFeatures: subclassFeatures,
    );
    final active = choiceRequirementsEligibilityFromProtocol(
      (group.requirements ?? const <ChoiceRequirementData>[])
          .map((r) => r.toJson()),
      context,
    ).isEligible;
    if (!active) {
      result.remove(group.referenceKey);
      continue;
    }
    if (group.autoSelectSingleEligible != true) continue;
    final selected = (result[group.referenceKey] ?? <ChoiceOptionData>[])
        .where((o) =>
            choiceOptionEligibilityFromProtocol(o.toJson(), context).isEligible)
        .toList();
    final automatic =
        automaticChoiceOptionKey(options.map((o) => o.toJson()), context);
    result[group.referenceKey] = automatic == null
        ? selected
        : [options.firstWhere((o) => o.optionKey == automatic)];
  }
  return result;
}
