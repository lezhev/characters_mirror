import 'package:flutter/material.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import '../../application/statblock/dm_statblock.dart';
import 'dm_statblock_item.dart';
import 'dm_statblock_top.dart';
import 'dm_legendary_group.dart';
import 'dm_magic_group.dart';

class DmStatblockView extends StatelessWidget {
  const DmStatblockView({super.key, required this.statblock});
  final DmStatblock statblock;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SheetOutlineCard(
            key: const ValueKey('dm-statblock-top'),
            child: DmStatblockTop(statblock: statblock)),
        if (statblock.groups.length > 1) ...[
          const SizedBox(height: 10),
          SheetOutlineCard(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                for (var index = 1;
                    index < statblock.groups.length;
                    index++) ...[
                  if (index > 1)
                    Divider(key: ValueKey('group-divider-$index'), height: 20),
                  _Group(
                      key: ValueKey(statblock.groups[index].id),
                      group: statblock.groups[index]),
                ],
              ])),
        ],
      ]);
}

class _Group extends StatelessWidget {
  const _Group({super.key, required this.group});
  final DmVisualGroup group;
  @override
  Widget build(BuildContext context) {
    if (group.id == 'legendary') return DmLegendaryGroup(group: group);
    if (group.magic != null) return DmMagicGroup(magic: group.magic!);
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(group.title, style: theme.textTheme.titleMedium),
      const SizedBox(height: 6),
      for (final block in group.blocks) ...[
        for (final line in block.lines)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(line.text)),
        for (final item in block.items)
          DmStatblockItem(key: ValueKey(item.id), item: item),
      ],
    ]);
  }
}
