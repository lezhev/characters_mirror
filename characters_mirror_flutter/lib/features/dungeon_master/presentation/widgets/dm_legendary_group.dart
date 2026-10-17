import 'package:flutter/material.dart';
import '../../application/statblock/dm_statblock_models.dart';
import 'dm_group_metrics.dart';
import 'dm_rules_disclosure.dart';
import 'dm_statblock_item.dart';

class DmLegendaryGroup extends StatelessWidget {
  const DmLegendaryGroup({super.key, required this.group});
  final DmVisualGroup group;
  @override
  Widget build(BuildContext context) {
    final view = group.legendary!;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(group.title, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      if (view.metrics.isNotEmpty)
        DmGroupMetrics(metrics: view.metrics, periods: view.periods),
      if (view.rules.isNotEmpty)
        DmRulesDisclosure(
            id: 'legendary-rules',
            title: 'Правила использования',
            items: view.rules),
      if (view.actions.isNotEmpty &&
          (view.rules.isNotEmpty || view.metrics.isNotEmpty))
        const Divider(height: 20),
      for (final item in view.actions)
        DmStatblockItem(key: ValueKey(item.id), item: item),
    ]);
  }
}
