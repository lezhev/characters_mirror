import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/feature_tag_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeatureTagSelectionGrid extends StatelessWidget {
  const FeatureTagSelectionGrid({
    required this.tags,
    required this.selectedTags,
    required this.onChanged,
    super.key,
    this.minTileWidth = 104,
    this.tileHeight = 96,
    this.spacing = 8,
    this.iconSize = 30,
  });

  final List<FeatureTag> tags;
  final Set<FeatureTag> selectedTags;
  final ValueChanged<Set<FeatureTag>> onChanged;
  final double minTileWidth;
  final double tileHeight;
  final double spacing;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : minTileWidth * 3 + spacing * 2;
        final columns = featureTagGridColumnCount(
          width: availableWidth,
          minTileWidth: minTileWidth,
          spacing: spacing,
        );
        final tileWidth = (availableWidth - spacing * (columns - 1)) / columns;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: columns,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: tileWidth / tileHeight,
          children: [
            for (final tag in tags)
              FeatureTagSelectionTile(
                key: ValueKey('feature-tag-tile-${tag.name}'),
                tag: tag,
                selected: selectedTags.contains(tag),
                iconSize: iconSize,
                onTap: () => _toggleTag(tag),
              ),
          ],
        );
      },
    );
  }

  void _toggleTag(FeatureTag tag) {
    final next = <FeatureTag>{...selectedTags};
    if (!next.add(tag)) {
      next.remove(tag);
    }
    onChanged(next);
  }
}

int featureTagGridColumnCount({
  required double width,
  double minTileWidth = 104,
  double spacing = 8,
}) {
  if (!width.isFinite || width <= 0) {
    return 1;
  }

  return math.max(
    1,
    ((width + spacing) / (minTileWidth + spacing)).floor(),
  );
}

class FeatureTagSelectionTile extends StatelessWidget {
  const FeatureTagSelectionTile({
    required this.tag,
    required this.selected,
    required this.onTap,
    super.key,
    this.iconSize = 30,
  });

  final FeatureTag tag;
  final bool selected;
  final VoidCallback onTap;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final label = featureTagRuLabel(tag);
    final foreground =
        selected ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: selected
                  ? colorScheme.primary.withValues(alpha: 0.14)
                  : colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.34,
                    ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.outlineVariant.withValues(alpha: 0.48),
                width: selected ? 1.5 : 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeatureTagIcon(
                  tag: tag,
                  size: iconSize,
                  color: foreground,
                  showTooltip: false,
                ),
                const SizedBox(height: 8),
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color:
                        selected ? colorScheme.primary : colorScheme.onSurface,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureTagIconWrap extends StatelessWidget {
  const FeatureTagIconWrap({
    required this.tags,
    super.key,
    this.size = 22,
    this.spacing = 8,
    this.runSpacing = 8,
    this.color,
  });

  final List<FeatureTag> tags;
  final double size;
  final double spacing;
  final double runSpacing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: [
        for (final tag in tags)
          FeatureTagIcon(
            key: ValueKey('feature-tag-icon-${tag.name}'),
            tag: tag,
            size: size,
            color: color,
          ),
      ],
    );
  }
}

class FeatureTagIcon extends StatelessWidget {
  const FeatureTagIcon({
    required this.tag,
    super.key,
    this.size = 22,
    this.color,
    this.showTooltip = true,
  });

  final FeatureTag tag;
  final double size;
  final Color? color;
  final bool showTooltip;

  @override
  Widget build(BuildContext context) {
    final label = featureTagRuLabel(tag);
    final icon = Semantics(
      label: label,
      image: true,
      child: SvgPicture.asset(
        featureTagAssetPath(tag),
        width: size,
        height: size,
        excludeFromSemantics: true,
        colorFilter: ColorFilter.mode(
          color ?? Theme.of(context).colorScheme.onSurfaceVariant,
          BlendMode.srcIn,
        ),
      ),
    );

    if (!showTooltip) {
      return icon;
    }

    return Tooltip(
      message: label,
      child: icon,
    );
  }
}
