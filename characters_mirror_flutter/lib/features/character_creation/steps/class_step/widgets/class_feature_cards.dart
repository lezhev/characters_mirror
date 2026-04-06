import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
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

    return AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Уровень ${feature.level}: ${feature.name ?? 'Без названия'}',
            style: theme.textTheme.titleMedium,
          ),
          const Gap(6),
          if ((feature.description ?? '').isNotEmpty)
            Text(
              feature.description!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
        ],
      ),
    );
  }
}

class SubclassFeatureCard extends StatelessWidget {
  const SubclassFeatureCard({
    required this.feature,
    super.key,
  });

  final SubclassFeatureData feature;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSurfaceCard(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Уровень ${feature.level}: ${feature.name ?? 'Без названия'}',
            style: theme.textTheme.titleMedium,
          ),
          const Gap(6),
          if ((feature.description ?? '').isNotEmpty)
            Text(
              feature.description!,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
        ],
      ),
    );
  }
}
