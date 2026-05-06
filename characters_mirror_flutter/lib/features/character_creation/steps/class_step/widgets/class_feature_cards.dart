import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/class_step/widgets/related_feature_tables.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ClassFeatureEntry {
  const ClassFeatureEntry._({
    required this.level,
    required this.isSubclass,
    this.classFeature,
    this.subclassFeature,
  });

  final int level;
  final bool isSubclass;
  final ClassFeatureData? classFeature;
  final SubclassFeatureData? subclassFeature;

  factory ClassFeatureEntry.classFeature(ClassFeatureData feature) {
    return ClassFeatureEntry._(
      level: feature.level,
      isSubclass: false,
      classFeature: feature,
    );
  }

  factory ClassFeatureEntry.subclassFeature(SubclassFeatureData feature) {
    return ClassFeatureEntry._(
      level: feature.level,
      isSubclass: true,
      subclassFeature: feature,
    );
  }

  Widget buildCard() {
    if (isSubclass) {
      return SubclassFeatureCard(feature: subclassFeature!);
    }
    return ClassFeatureCard(feature: classFeature!);
  }
}

class ClassFeatureCard extends StatelessWidget {
  const ClassFeatureCard({
    required this.feature,
    super.key,
  });

  final ClassFeatureData feature;

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
              textAlign: TextAlign.justify,
            ),
          ],
        ],
      ),
    );
  }
}

class SubclassFeatureCard extends StatefulWidget {
  const SubclassFeatureCard({
    required this.feature,
    super.key,
  });

  final SubclassFeatureData feature;

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
              textAlign: TextAlign.justify,
            ),
          ],
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
