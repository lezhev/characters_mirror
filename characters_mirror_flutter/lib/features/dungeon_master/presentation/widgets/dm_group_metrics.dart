import 'package:flutter/material.dart';
import '../../application/statblock/dm_statblock_models.dart';

/// Quiet, wrapping metrics shared by the two special statblock groups.
class DmGroupMetrics extends StatelessWidget {
  const DmGroupMetrics(
      {super.key, required this.metrics, this.periods = const []});
  final List<DmStatLine> metrics;
  final List<String> periods;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth < 260 ? 1 : metrics.length;
      return Wrap(spacing: 12, runSpacing: 8, children: [
        for (var index = 0; index < metrics.length; index++)
          SizedBox(
              width: (constraints.maxWidth - (columns - 1) * 12) / columns,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(metrics[index].label,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant)),
                    const SizedBox(height: 2),
                    Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Text(metrics[index].value,
                              style: theme.textTheme.titleLarge),
                          if (index < periods.length &&
                              periods[index].isNotEmpty)
                            Text(periods[index],
                                style: theme.textTheme.bodySmall),
                        ]),
                  ])),
      ]);
    });
  }
}
