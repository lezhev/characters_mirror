import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/feature_tag_localization.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:flutter/material.dart';

class CharacterFeatureCard extends StatefulWidget {
  const CharacterFeatureCard({
    required this.feature,
    required this.onSave,
    required this.onReset,
    required this.onSetResource,
    super.key,
  });

  final CharacterFeatureViewData feature;
  final Future<void> Function({
    String? name,
    String? description,
    List<FeatureTag>? tags,
  }) onSave;
  final Future<void> Function() onReset;
  final Future<void> Function(String resourceKey, int current) onSetResource;

  @override
  State<CharacterFeatureCard> createState() => _CharacterFeatureCardState();
}

class _CharacterFeatureCardState extends State<CharacterFeatureCard> {
  bool _isExpanded = false;

  Future<void> _openEditDialog() {
    final feature = widget.feature;
    return showSmoothSwitcherAbilityDialog(
      context: context,
      title: feature.name,
      text: feature.description,
      tags: feature.tags ?? feature.defaultTags,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final feature = widget.feature;
    final featureTags = feature.tags ?? feature.defaultTags;
    final sourceLabel = _featureSourceLabel(feature);

    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _isExpanded ? _openEditDialog : null,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
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
                      onReset:
                          feature.isCustomized == true ? widget.onReset : null,
                      showTitle: true,
                      showText: false,
                      isEditable: !_isExpanded,
                      titleStyle: theme.textTheme.titleMedium,
                      switchKey:
                          '${feature.sourceType.name}:${feature.sourceId}:title',
                    ),
                    if (feature.isCustomized == true)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: widget.onReset,
                          child: const Text('Вернуть всё как было'),
                        ),
                      ),
                    if (feature.resources != null &&
                        feature.resources!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      for (final resource in feature.resources!)
                        _FeatureResourceCounter(
                          resource: resource,
                          onChanged: (current) =>
                              widget.onSetResource(resource.key, current),
                        ),
                    ],
                    ExpandableSection(
                      extraOffset: 64,
                      expand: _isExpanded,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (sourceLabel != null)
                              Text(
                                sourceLabel,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            if (sourceLabel != null) const SizedBox(height: 8),
                            SmoothSwitcher.ability(
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
                              onReset: feature.isCustomized == true
                                  ? widget.onReset
                                  : null,
                              showTitle: false,
                              showText: true,
                              isEditable: false,
                              emptyTextPlaceholder: 'Описание не добавлено.',
                              textStyle: theme.textTheme.bodyMedium,
                              switchKey:
                                  '${feature.sourceType.name}:${feature.sourceId}:text',
                            ),
                            if (featureTags != null &&
                                featureTags.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final tag in featureTags)
                                    Chip(
                                      label: Text(featureTagRuLabel(tag)),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, right: 4),
            child: IconButton(
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
          ),
        ],
      ),
    );
  }
}

class _FeatureResourceCounter extends StatelessWidget {
  const _FeatureResourceCounter({
    required this.resource,
    required this.onChanged,
  });

  final CharacterResourceViewData resource;
  final Future<void> Function(int current) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnlimited = resource.isUnlimited == true;
    final canDecrease = resource.current > 0;
    final canIncrease = resource.current < resource.max;

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 6,
      children: [
        IconButton.filledTonal(
          visualDensity: VisualDensity.compact,
          tooltip: 'Потратить ресурс',
          onPressed: !isUnlimited && canDecrease
              ? () => onChanged(resource.current - 1)
              : null,
          icon: const Icon(Icons.remove, size: 18),
        ),
        if (!isUnlimited && resource.max <= 6)
          Wrap(
            spacing: 3,
            children: [
              for (var index = 0; index < resource.max; index++)
                Icon(
                  index < resource.current
                      ? Icons.circle
                      : Icons.radio_button_unchecked,
                  size: 10,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
        Text(
          isUnlimited ? '∞' : '${resource.current}/${resource.max}',
          style: theme.textTheme.labelLarge,
        ),
        IconButton.filledTonal(
          visualDensity: VisualDensity.compact,
          tooltip: 'Восстановить ресурс',
          onPressed: !isUnlimited && canIncrease
              ? () => onChanged(resource.current + 1)
              : null,
          icon: const Icon(Icons.add, size: 18),
        ),
      ],
    );
  }
}

String? _featureSourceLabel(CharacterFeatureViewData feature) {
  final parts = <String>[
    if (_normalizedText(feature.sourceName) != null) feature.sourceName!.trim(),
    if (feature.level != null) 'Уровень ${feature.level}',
  ];
  if (parts.isEmpty) {
    return null;
  }
  return parts.join(' • ');
}

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}
