import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:flutter/material.dart';

class CharacterFeatureCard extends StatefulWidget {
  const CharacterFeatureCard({
    required this.feature,
    required this.onSave,
    required this.onReset,
    super.key,
  });

  final CharacterFeatureViewData feature;
  final Future<void> Function({
    String? name,
    String? description,
    List<FeatureTag>? tags,
  }) onSave;
  final Future<void> Function() onReset;

  @override
  State<CharacterFeatureCard> createState() => _CharacterFeatureCardState();
}

class _CharacterFeatureCardState extends State<CharacterFeatureCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feature = widget.feature;
    final featureTags = feature.tags ?? feature.defaultTags;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmoothSwitcher.ability(
                        title: feature.name ?? 'Без названия',
                        text: feature.description,
                        tags: featureTags,
                        isCustomized: feature.isCustomized == true,
                        onSave: ({
                          String? title,
                          String? text,
                          List<FeatureTag>? tags,
                        }) {
                          return widget.onSave(
                            name: title,
                            description: text,
                            tags: tags,
                          );
                        },
                        onReset: feature.isCustomized == true
                            ? widget.onReset
                            : null,
                        showTitle: true,
                        showText: false,
                        titleStyle: theme.textTheme.titleMedium,
                        switchKey:
                            '${feature.sourceType.name}:${feature.sourceId}:title',
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _featureSourceLabel(feature),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  icon: AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.expand_more),
                  ),
                ),
              ],
            ),
            if (feature.isCustomized == true)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: widget.onReset,
                  child: const Text('Вернуть всё как было'),
                ),
              ),
            ExpandableSection(
              extraOffset: 64,
              expand: _isExpanded,
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: SmoothSwitcher.ability(
                  title: feature.name,
                  text: feature.description,
                  tags: featureTags,
                  isCustomized: feature.isCustomized == true,
                  onSave: ({
                    String? title,
                    String? text,
                    List<FeatureTag>? tags,
                  }) {
                    return widget.onSave(
                      name: title,
                      description: text,
                      tags: tags,
                    );
                  },
                  onReset: feature.isCustomized == true ? widget.onReset : null,
                  showTitle: false,
                  showText: true,
                  emptyTextPlaceholder: 'Описание не добавлено.',
                  textStyle: theme.textTheme.bodyMedium,
                  switchKey:
                      '${feature.sourceType.name}:${feature.sourceId}:text',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _featureSourceLabel(CharacterFeatureViewData feature) {
  final parts = <String>[
    if (_normalizedText(feature.sourceName) != null) feature.sourceName!.trim(),
    if (feature.level != null) 'Уровень ${feature.level}',
  ];
  return parts.join(' • ');
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}
