import 'package:flutter/material.dart';

class SegmentedStatBar extends StatelessWidget {
  const SegmentedStatBar({
    required this.segments,
    super.key,
  });

  final List<SegmentedStatBarItem> segments;

  static const double _compactBreakpointPerSegment = 132;
  static const double _mediumBreakpointPerSegment = 108;
  static const double _compactGap = 12;
  static const double _compactMinCardWidth = 92;

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return _CompactStatCards(
          segments: segments,
          maxWidth: constraints.maxWidth,
          gap: _compactGap,
          minCardWidth: _compactMinCardWidth,
        );
      },
    );
  }
}

enum _StatValueDensity { full, medium, short }

class _CompactStatCards extends StatelessWidget {
  const _CompactStatCards({
    required this.segments,
    required this.maxWidth,
    required this.gap,
    required this.minCardWidth,
  });

  final List<SegmentedStatBarItem> segments;
  final double maxWidth;
  final double gap;
  final double minCardWidth;

  @override
  Widget build(BuildContext context) {
    final columns = _columnCount();
    final cardWidth = (maxWidth - gap * (columns - 1)) / columns;
    final valueDensity = _valueDensityFor(cardWidth);

    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: [
        for (final segment in segments)
          SizedBox(
            width: cardWidth,
            child: _CompactStatCard(
              item: segment,
              valueDensity: valueDensity,
            ),
          ),
      ],
    );
  }

  _StatValueDensity _valueDensityFor(double cardWidth) {
    if (cardWidth < SegmentedStatBar._mediumBreakpointPerSegment) {
      return _StatValueDensity.short;
    }
    if (cardWidth < SegmentedStatBar._compactBreakpointPerSegment) {
      return _StatValueDensity.medium;
    }
    return _StatValueDensity.full;
  }

  int _columnCount() {
    final fitCount = ((maxWidth + gap) / (minCardWidth + gap)).floor();
    return fitCount.clamp(1, segments.length);
  }
}

class SegmentedStatBarItem {
  const SegmentedStatBarItem({
    required this.value,
    this.mediumValue,
    this.shortValue,
    this.label,
    this.icon,
    this.onPressed,
    this.onLongPress,
  });

  final String value;
  final String? mediumValue;
  final String? shortValue;
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  String _valueFor(_StatValueDensity density) {
    switch (density) {
      case _StatValueDensity.full:
        return value;
      case _StatValueDensity.medium:
        return mediumValue ?? value;
      case _StatValueDensity.short:
        return shortValue ?? mediumValue ?? value;
    }
  }
}

class _CompactStatCard extends StatelessWidget {
  const _CompactStatCard({
    required this.item,
    required this.valueDensity,
  });

  final SegmentedStatBarItem item;
  final _StatValueDensity valueDensity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const borderRadius = BorderRadius.all(Radius.circular(8));

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: item.onPressed ?? () {},
            onLongPress: item.onLongPress,
            overlayColor: WidgetStatePropertyAll(
              colorScheme.surfaceContainerHigh.withValues(alpha: 0.36),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 88),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: item.icon == null
                    ? Center(
                        child: _TextOnlySegment(
                          item: item,
                          value: item._valueFor(valueDensity),
                        ),
                      )
                    : _IconCardSegment(
                        item: item,
                        value: item._valueFor(valueDensity),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextOnlySegment extends StatelessWidget {
  const _TextOnlySegment({
    required this.item,
    required this.value,
  });

  final SegmentedStatBarItem item;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall,
        ),
        if (item.label != null) ...[
          const SizedBox(height: 2),
          Text(
            item.label!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

class _IconCardSegment extends StatelessWidget {
  const _IconCardSegment({
    required this.item,
    required this.value,
  });

  final SegmentedStatBarItem item;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          color: colorScheme.onSurfaceVariant,
          size: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.outlineVariant,
          ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
