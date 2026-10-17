import 'package:flutter/material.dart';
import '../../application/statblock/dm_statblock_models.dart';
import 'dm_group_metrics.dart';
import 'dm_rules_disclosure.dart';
import 'dm_statblock_item.dart';

class DmMagicGroup extends StatelessWidget {
  const DmMagicGroup({super.key, required this.magic});
  final DmMagicView magic;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text('Заклинания', style: theme.textTheme.titleMedium),
      if (magic.header.isNotEmpty) ...[
        const SizedBox(height: 8),
        DmGroupMetrics(metrics: magic.header),
      ],
      if (magic.rules.isNotEmpty)
        DmRulesDisclosure(
            id: 'caster-rules',
            title: 'Правила заклинателя',
            items: magic.rules),
      for (final group in magic.spells) ...[
        const Divider(height: 20),
        Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            children: [
              Text(group.title, style: theme.textTheme.titleSmall),
              if (group.usage.isNotEmpty)
                Text(group.usage,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ]),
        for (final item in group.items)
          DmStatblockItem(key: ValueKey(item.id), item: item),
      ]
    ]);
  }
}
