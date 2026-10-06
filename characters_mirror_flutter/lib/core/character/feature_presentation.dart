import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'choice_group_presentation.dart';

/// Reference feature content shared by creation and level-up projections.
/// Sheet uses CharacterFeatureViewData for overrides and live resource state.
class FeaturePresentation {
  const FeaturePresentation(
      {required this.sourceKey,
      required this.name,
      required this.level,
      this.shortDescription,
      this.displayProperties = const [],
      this.choices = const [],
      this.resources = const []});
  final String? sourceKey;
  final String name;
  final int level;
  final String? shortDescription;
  final List<FeatureDisplayPropertyView> displayProperties;
  final List<ChoiceGroupView> choices;
  final List<CharacterResourceViewData> resources;

  factory FeaturePresentation.fromStep(
    ClassStepFeatureView view, {
    Iterable<ChoiceGroupView> groups = const [],
    int sourceLevel = 1,
    Map<Ability, int> abilityModifiers = const {},
  }) {
    final c = view.classFeature;
    final s = view.subclassFeature;
    final key = c?.id != null
        ? 'class:${c!.id}'
        : s?.id != null
            ? 'subclass:${s!.id}'
            : null;
    final name = c?.name ?? s?.name ?? 'Без названия';
    return FeaturePresentation(
        sourceKey: key,
        name: name,
        level: c?.level ?? s?.level ?? 1,
        shortDescription: c?.shortDescription ?? s?.shortDescription,
        displayProperties: view.displayProperties ?? const [],
        choices: [
          for (final g in groups)
            if (g.group != null &&
                key != null &&
                choiceFeatureSourceKey(g.group!) == key)
              g
        ]..sort((a, b) =>
            (a.group?.sortOrder ?? 0).compareTo(b.group?.sortOrder ?? 0)),
        resources: view.resources ??
            referenceResourceSummaries(c?.resources ?? s?.resources ?? [],
                name: name,
                sourceLevel: sourceLevel,
                abilityModifiers: abilityModifiers));
  }

  FeaturePresentation withResources(List<CharacterResourceViewData> values,
          {List<FeatureDisplayPropertyView>? properties}) =>
      FeaturePresentation(
          sourceKey: sourceKey,
          name: name,
          level: level,
          shortDescription: shortDescription,
          displayProperties: properties ?? displayProperties,
          choices: choices,
          resources: values);
}

List<ClassStepFeatureView> stepFeatureViews(
        List<ClassFeatureData>? classes,
        List<SubclassFeatureData>? subclasses,
        List<ClassStepFeatureView>? classViews,
        List<ClassStepFeatureView>? subclassViews) =>
    [
      ..._mergeViews(classes ?? [], classViews ?? []),
      ..._mergeSubclassViews(subclasses ?? [], subclassViews ?? []),
    ];

List<ClassStepFeatureView> _mergeViews(
        List<ClassFeatureData> features, List<ClassStepFeatureView> views) =>
    features.isEmpty
        ? views
        : [
            for (final f in features)
              views
                      .where((v) => f.id != null && v.classFeature?.id == f.id)
                      .firstOrNull ??
                  ClassStepFeatureView(classFeature: f)
          ];
List<ClassStepFeatureView> _mergeSubclassViews(
        List<SubclassFeatureData> features, List<ClassStepFeatureView> views) =>
    features.isEmpty
        ? views
        : [
            for (final f in features)
              views
                      .where(
                          (v) => f.id != null && v.subclassFeature?.id == f.id)
                      .firstOrNull ??
                  ClassStepFeatureView(subclassFeature: f)
          ];

List<CharacterResourceViewData> referenceResourceSummaries(
    Iterable<FeatureResourceDefinitionData> definitions,
    {required String name,
    required int sourceLevel,
    Map<Ability, int> abilityModifiers = const {},
    Set<int> selectedOptionIds = const {}}) {
  final result = <CharacterResourceViewData>[];
  for (final d in definitions) {
    if (d.choiceOptionId != null &&
        !selectedOptionIds.contains(d.choiceOptionId)) {
      continue;
    }
    final unlimited = d.becomesUnlimitedAtLevel != null &&
        sourceLevel >= d.becomesUnlimitedAtLevel!;
    final maximum = featureResourceSummaryMaximum(
        rule: d.maxRule.name,
        value: d.maxValue,
        abilityModifier: abilityModifiers[d.maxAbility] ?? 0,
        sourceLevel: sourceLevel,
        characterLevel: sourceLevel,
        proficiencyBonus: 2 + ((sourceLevel - 1) ~/ 4),
        progression: [
          for (final row in d.progressionValues ??
              const <FeatureResourceProgressionValueData>[])
            (level: row.level, value: row.value)
        ]);
    if (maximum == null || (!unlimited && maximum <= 0)) continue;
    result.add(CharacterResourceViewData(
        key: d.key,
        name: d.name ?? name,
        kind: d.kind,
        current: unlimited ? 0 : maximum,
        max: unlimited ? 0 : maximum,
        isUnlimited: unlimited ? true : null,
        resetOn: d.resetOn,
        usageResetOn: d.usageResetOn,
        activationTrigger: d.activationTrigger));
  }
  return result..sort((a, b) => a.key.compareTo(b.key));
}
