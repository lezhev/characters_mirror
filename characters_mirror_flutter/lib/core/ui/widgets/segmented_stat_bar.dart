import 'package:flutter/material.dart';

class SegmentedStatBar extends StatelessWidget {
  const SegmentedStatBar({
    required this.segments,
    super.key,
  });

  final List<SegmentedStatBarItem> segments;

  static const double _compactBreakpointPerSegment = 132;
  static const double _compactGap = 12;
  static const double _compactMinCardWidth = 92;

  @override
  Widget build(BuildContext context) {
    if (segments.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final compactThreshold = segments.length * _compactBreakpointPerSegment;
        if (constraints.maxWidth < compactThreshold) {
          return _CompactStatCards(
            segments: segments,
            maxWidth: constraints.maxWidth,
            gap: _compactGap,
            minCardWidth: _compactMinCardWidth,
          );
        }

        return _SegmentedStatRow(segments: segments);
      },
    );
  }
}

class _SegmentedStatRow extends StatelessWidget {
  const _SegmentedStatRow({
    required this.segments,
  });

  final List<SegmentedStatBarItem> segments;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = colorScheme.primary;
    const borderRadius = BorderRadius.all(Radius.circular(8));

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Row(
          children: [
            for (var index = 0; index < segments.length; index++) ...[
              Expanded(
                child: _SegmentedStatButton(item: segments[index]),
              ),
              if (index < segments.length - 1)
                SizedBox(
                  width: 1,
                  height: 62,
                  child: ColoredBox(color: borderColor.withValues(alpha: 0.55)),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

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

    return Wrap(
      spacing: gap,
      runSpacing: gap,
      children: [
        for (final segment in segments)
          SizedBox(
            width: cardWidth,
            child: _CompactStatCard(item: segment),
          ),
      ],
    );
  }

  int _columnCount() {
    final fitCount = ((maxWidth + gap) / (minCardWidth + gap)).floor();
    return fitCount.clamp(1, segments.length);
  }
}

class SegmentedStatBarItem {
  const SegmentedStatBarItem({
    required this.value,
    this.label,
    this.icon,
    this.onPressed,
  });

  final String value;
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
}

class _SegmentedStatButton extends StatelessWidget {
  const _SegmentedStatButton({
    required this.item,
  });

  final SegmentedStatBarItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: item.onPressed ?? () {},
        overlayColor: WidgetStatePropertyAll(
          colorScheme.primary.withValues(alpha: 0.08),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 62),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Center(
              child: item.icon == null
                  ? _TextOnlySegment(item: item)
                  : _IconSegment(item: item),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompactStatCard extends StatelessWidget {
  const _CompactStatCard({
    required this.item,
  });

  final SegmentedStatBarItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const borderRadius = BorderRadius.all(Radius.circular(8));

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.primary.withValues(alpha: 0.7)),
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: item.onPressed ?? () {},
            overlayColor: WidgetStatePropertyAll(
              colorScheme.primary.withValues(alpha: 0.08),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 88),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: item.icon == null
                    ? Center(child: _TextOnlySegment(item: item))
                    : _IconCardSegment(item: item),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconSegment extends StatelessWidget {
  const _IconSegment({
    required this.item,
  });

  final SegmentedStatBarItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          item.icon,
          color: colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            item.value,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}

class _TextOnlySegment extends StatelessWidget {
  const _TextOnlySegment({
    required this.item,
  });

  final SegmentedStatBarItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          item.value,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall,
        ),
        if (item.label != null) ...[
          const SizedBox(height: 2),
          Text(
            item.label!,
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
  });

  final SegmentedStatBarItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          color: colorScheme.primary,
          size: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            height: 1,
            thickness: 1,
            color: colorScheme.outline,
          ),
        ),
        Text(
          item.value,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
