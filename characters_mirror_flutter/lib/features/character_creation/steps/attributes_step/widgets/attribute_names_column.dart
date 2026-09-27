import 'package:characters_mirror_flutter/features/character_creation/steps/attributes_step/common/attribute_enum.dart';
import 'package:flutter/material.dart';

class AttributeNamesColumn extends StatelessWidget {
  const AttributeNamesColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: Attribute.values.map((attribute) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            key: ValueKey('attribute-name-${attribute.name}'),
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Text(
              attribute.getTitle(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
