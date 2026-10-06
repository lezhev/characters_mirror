import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:characters_mirror_flutter/core/character/feature_text.dart';
import 'feature_display_properties.dart';

/// Reference content only. Decisions and interactive resources are projected by
/// their context-specific composition roots.
class FeatureSummary extends StatelessWidget {
  const FeatureSummary(
      {super.key,
      required this.name,
      this.shortDescription,
      this.properties = const [],
      this.resources = const [],
      this.children = const []});
  final String name;
  final String? shortDescription;
  final List<FeatureDisplayPropertyView> properties;
  final List<CharacterResourceViewData> resources;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(name, style: Theme.of(context).textTheme.titleMedium),
        if (shortDescription?.isNotEmpty == true) ...[
          const SizedBox(height: 6),
          Text(displayFeatureText(shortDescription!),
              style: Theme.of(context).textTheme.bodyMedium),
        ],
        FeatureDisplayProperties(properties: properties),
        for (final r in resources) ...[
          const SizedBox(height: 8),
          Text('${r.name ?? name}: ${r.isUnlimited == true ? '∞' : r.max}',
              style: Theme.of(context).textTheme.bodyMedium),
          if (r.resetOn != null)
            Text(
                'Восстановление: ${switch (r.resetOn!) {
                  RestType.shortRest => 'короткий отдых',
                  RestType.longRest => 'длинный отдых',
                  RestType.dawn => 'на рассвете',
                  RestType.special => 'особое',
                }}',
                style: Theme.of(context).textTheme.bodySmall),
        ],
        ...children,
      ]);
}
