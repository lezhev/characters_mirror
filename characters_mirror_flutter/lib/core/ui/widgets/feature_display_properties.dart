import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';

class FeatureDisplayProperties extends StatelessWidget {
  const FeatureDisplayProperties({
    required this.properties,
    super.key,
  });

  final List<FeatureDisplayPropertyView> properties;

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          for (final property in properties)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: '${property.label}: ',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    TextSpan(
                      text: property.value,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
