import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_display_properties.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/related_feature_tables.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

  Widget buildCard() {
    if (isSubclass) {
      return SubclassFeatureCard(
        feature: subclassFeature!,
        displayProperties:
            view.displayProperties ?? const <FeatureDisplayPropertyView>[],
      );
    }
    return ClassFeatureCard(
      feature: classFeature!,
      displayProperties:
          view.displayProperties ?? const <FeatureDisplayPropertyView>[],
    );
  }
}

class ClassFeatureCard extends StatelessWidget {
  const ClassFeatureCard({
    required this.feature,
    this.displayProperties = const <FeatureDisplayPropertyView>[],
    super.key,
  });

  final ClassFeatureData feature;
  final List<FeatureDisplayPropertyView> displayProperties;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = feature.shortDescription ?? feature.description;

    return AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feature.name ?? 'Без названия',
            style: theme.textTheme.titleMedium,
          ),
          if ((description ?? '').isNotEmpty) ...[
            const Gap(6),
            Text(
              displayFeatureText(description!),
              style: theme.textTheme.bodyMedium,
            ),
          ],
          FeatureDisplayProperties(properties: displayProperties),
        ],
      ),
    );
  }
}

class SubclassFeatureCard extends StatefulWidget {
  const SubclassFeatureCard({
    required this.feature,
    this.displayProperties = const <FeatureDisplayPropertyView>[],
    super.key,
  });

  final SubclassFeatureData feature;
  final List<FeatureDisplayPropertyView> displayProperties;

  @override
  State<SubclassFeatureCard> createState() => _SubclassFeatureCardState();
}

class _SubclassFeatureCardState extends State<SubclassFeatureCard> {
  bool _areRelatedTablesExpanded = false;
  final Set<int> _expandedRelatedTableIndexes = <int>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feature = widget.feature;
    final description = feature.shortDescription ?? feature.description;
    final relatedTables = parseRelatedFeatureTables(feature.relatedTable);

    return AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  feature.name ?? 'Без названия',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              if (relatedTables.isNotEmpty)
                RelatedFeatureTablesToggle(
                  isExpanded: _areRelatedTablesExpanded,
                  onPressed: () {
                    setState(() {
                      _areRelatedTablesExpanded = !_areRelatedTablesExpanded;
                    });
                  },
                ),
            ],
          ),
          if ((description ?? '').isNotEmpty) ...[
            const Gap(6),
            Text(
              displayFeatureText(description!),
              style: theme.textTheme.bodyMedium,
            ),
          ],
          FeatureDisplayProperties(properties: widget.displayProperties),
          RelatedFeatureTables(
            tables: relatedTables,
            isExpanded: _areRelatedTablesExpanded,
            expandedTableIndexes: _expandedRelatedTableIndexes,
            onToggleRows: (index) {
              setState(() {
                if (!_expandedRelatedTableIndexes.add(index)) {
                  _expandedRelatedTableIndexes.remove(index);
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
