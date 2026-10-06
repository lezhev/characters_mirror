import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_summary.dart';
import 'package:characters_mirror_flutter/core/character/feature_presentation.dart';
import 'package:flutter/material.dart';

class ClassFeatureEntry {
  const ClassFeatureEntry._({
    required this.level,
    required this.isSubclass,
    required this.view,
  });

  final int level;
  final bool isSubclass;
  final ClassStepFeatureView view;
  ClassFeatureData? get classFeature => view.classFeature;
  SubclassFeatureData? get subclassFeature => view.subclassFeature;
  int? get featureId => isSubclass ? subclassFeature?.id : classFeature?.id;

  factory ClassFeatureEntry.classFeature(ClassStepFeatureView view) {
    return ClassFeatureEntry._(
      level: view.classFeature!.level,
      isSubclass: false,
      view: view,
    );
  }

  factory ClassFeatureEntry.subclassFeature(ClassStepFeatureView view) {
    return ClassFeatureEntry._(
      level: view.subclassFeature!.level,
      isSubclass: true,
      view: view,
    );
  }

  Widget buildCard(
      {List<Widget> decisions = const [],
      int sourceLevel = 1,
      Set<int> selectedOptionIds = const {},
      Map<Ability, int> abilityModifiers = const {}}) {
    final definitions = classFeature?.resources ??
        subclassFeature?.resources ??
        const <FeatureResourceDefinitionData>[];
    final resourceSummary = definitions.isEmpty
        ? view.resources ?? const <CharacterResourceViewData>[]
        : referenceResourceSummaries(definitions,
            name: classFeature?.name ?? subclassFeature?.name ?? '',
            sourceLevel: sourceLevel,
            selectedOptionIds: selectedOptionIds,
            abilityModifiers: abilityModifiers);
    if (isSubclass) {
      return SubclassFeatureCard(
        feature: subclassFeature!,
        resources: resourceSummary,
        decisions: decisions,
        displayProperties:
            view.displayProperties ?? const <FeatureDisplayPropertyView>[],
      );
    }
    return ClassFeatureCard(
      feature: classFeature!,
      resources: resourceSummary,
      decisions: decisions,
      displayProperties:
          view.displayProperties ?? const <FeatureDisplayPropertyView>[],
    );
  }
}

class ClassFeatureCard extends StatelessWidget {
  const ClassFeatureCard(
      {required this.feature,
      this.displayProperties = const [],
      this.resources = const [],
      this.decisions = const [],
      super.key});
  final ClassFeatureData feature;
  final List<FeatureDisplayPropertyView> displayProperties;
  final List<CharacterResourceViewData> resources;
  final List<Widget> decisions;
  @override
  Widget build(BuildContext context) => AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: FeatureSummary(
          name: feature.name ?? 'Без названия',
          shortDescription: feature.shortDescription,
          properties: displayProperties,
          resources: resources,
          children: decisions));
}

class SubclassFeatureCard extends StatelessWidget {
  const SubclassFeatureCard(
      {required this.feature,
      this.displayProperties = const [],
      this.resources = const [],
      this.decisions = const [],
      super.key});
  final SubclassFeatureData feature;
  final List<FeatureDisplayPropertyView> displayProperties;
  final List<CharacterResourceViewData> resources;
  final List<Widget> decisions;
  @override
  Widget build(BuildContext context) => AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: FeatureSummary(
          name: feature.name ?? 'Без названия',
          shortDescription: feature.shortDescription,
          properties: displayProperties,
          resources: resources,
          children: decisions));
}
