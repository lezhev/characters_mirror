import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/expandable_section.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_display_properties.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/feature_tag_widgets.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
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
    final resources = feature.resources ?? const <CharacterResourceViewData>[];
    final sourceLabel = _featureSourceLabel(feature);

    return SheetOutlineCard(
      padding: EdgeInsets.zero,
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SmoothSwitcher.ability(
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
                              isEditable: !_isExpanded,
                              titleStyle: theme.textTheme.titleMedium,
                              transitionAlignment: Alignment.topLeft,
                              switchKey:
                                  '${feature.sourceType.name}:${feature.sourceId}:title',
                            ),
                          ),
                        ),
                        if (!_isExpanded && resources.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: _CollapsedResourceSummary(
                                resources: resources,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
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
                              text: feature.shortDescription,
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
                              transitionAlignment: Alignment.topLeft,
                              switchKey:
                                  '${feature.sourceType.name}:${feature.sourceId}:text',
                            ),
                            FeatureDisplayProperties(
                              properties: feature.displayProperties ??
                                  const <FeatureDisplayPropertyView>[],
                            ),
                            if (feature.selectedChoiceDetails
                                case final choices?
                                when choices.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              for (final choice in choices)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(choice.name,
                                            style: theme.textTheme.bodyMedium),
                                        if (choice
                                                .shortDescription?.isNotEmpty ==
                                            true)
                                          Text(choice.shortDescription!,
                                              style: theme.textTheme.bodySmall),
                                      ]),
                                ),
                            ],
                            if (_isExpanded && resources.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              for (var index = 0;
                                  index < resources.length;
                                  index++) ...[
                                _FeatureResourceSection(
                                  resource: resources[index],
                                  onChanged: (current) => widget.onSetResource(
                                    resources[index].key,
                                    current,
                                  ),
                                ),
                                if (index != resources.length - 1)
                                  const SizedBox(height: 10),
                              ],
                              const SizedBox(height: 12),
                            ],
                            if (featureTags != null &&
                                featureTags.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              FeatureTagIconWrap(
                                tags: featureTags,
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

class _CollapsedResourceSummary extends StatelessWidget {
  const _CollapsedResourceSummary({
    required this.resources,
  });

  final List<CharacterResourceViewData> resources;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final resource in resources)
          _ResourceSummaryBadge(resource: resource),
      ],
    );
  }
}

class _ResourceSummaryBadge extends StatelessWidget {
  const _ResourceSummaryBadge({
    required this.resource,
  });

  final CharacterResourceViewData resource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Text(
          _resourceAmountLabel(resource),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _FeatureResourceSection extends StatelessWidget {
  const _FeatureResourceSection({
    required this.resource,
    required this.onChanged,
  });

  final CharacterResourceViewData resource;
  final Future<void> Function(int current) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.32),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.44),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _resourceTitle(resource),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelLarge?.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _resourceResetLabel(resource),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            _FeatureResourceControl(
              resource: resource,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureResourceControl extends StatelessWidget {
  const _FeatureResourceControl({
    required this.resource,
    required this.onChanged,
  });

  final CharacterResourceViewData resource;
  final Future<void> Function(int current) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnlimited = resource.isUnlimited == true;
    final canDecrease = resource.current > 0;
    final canIncrease = resource.current < resource.max;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Row(
          children: [
            _ResourceRoundButton(
              tooltip: 'Потратить ресурс',
              icon: Icons.remove_rounded,
              onPressed: !isUnlimited && canDecrease
                  ? () => onChanged(resource.current - 1)
                  : null,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ResourceChargeDots(resource: resource),
                    const SizedBox(height: 4),
                    Text(
                      _resourceExpandedAmountLabel(resource),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _ResourceRoundButton(
              tooltip: 'Восстановить ресурс',
              icon: Icons.add_rounded,
              onPressed: !isUnlimited && canIncrease
                  ? () => onChanged(resource.current + 1)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceRoundButton extends StatelessWidget {
  const _ResourceRoundButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      constraints: const BoxConstraints.tightFor(width: 44, height: 44),
      padding: EdgeInsets.zero,
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: 22),
    );
  }
}

class _ResourceChargeDots extends StatelessWidget {
  const _ResourceChargeDots({
    required this.resource,
  });

  final CharacterResourceViewData resource;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (resource.isUnlimited == true || resource.max > 8) {
      return const SizedBox.shrink();
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        for (var index = 0; index < resource.max; index++)
          Icon(
            index < resource.current ? Icons.circle : Icons.circle_outlined,
            size: 9,
            color: index < resource.current
                ? colorScheme.primary
                : colorScheme.outlineVariant,
          ),
      ],
    );
  }
}

String _resourceTitle(CharacterResourceViewData resource) {
  switch (resource.kind) {
    case FeatureResourceKind.uses:
      return 'Использования';
    case FeatureResourceKind.points:
      return 'Очки';
    case FeatureResourceKind.dice:
      return 'Кости';
    case FeatureResourceKind.slots:
      return 'Ячейки';
    case FeatureResourceKind.special:
      return 'Ресурс';
  }
}

String _resourceResetLabel(CharacterResourceViewData resource) {
  final resetOn = resource.resetOn;
  if (resetOn == null) {
    return 'Без автоматического восстановления';
  }
  switch (resetOn) {
    case RestType.shortRest:
      return 'Короткий отдых';
    case RestType.longRest:
      return 'Длинный отдых';
    case RestType.dawn:
      return 'На рассвете';
    case RestType.special:
      return 'Особое восстановление';
  }
}

String _resourceAmountLabel(CharacterResourceViewData resource) {
  if (resource.isUnlimited == true) {
    return '∞';
  }
  return '${resource.current}/${resource.max}';
}

String _resourceExpandedAmountLabel(CharacterResourceViewData resource) {
  if (resource.isUnlimited == true) {
    return 'Без ограничений';
  }
  return '${resource.current} из ${resource.max}';
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
