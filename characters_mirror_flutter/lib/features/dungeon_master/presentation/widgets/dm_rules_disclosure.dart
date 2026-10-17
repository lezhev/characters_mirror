import 'package:flutter/material.dart';
import '../../application/statblock/dm_statblock_models.dart';
import 'dm_statblock_item.dart';

/// Uses the same disclosure and animation as actions, with named source texts
/// inside a single body instead of nested per-feature toggles.
class DmRulesDisclosure extends StatelessWidget {
  const DmRulesDisclosure(
      {super.key, required this.id, required this.title, required this.items});
  final String id, title;
  final List<DmItemView> items;
  @override
  Widget build(BuildContext context) => DmStatblockItem(
      key: ValueKey(id),
      item: DmItemView(
          id: id,
          name: title,
          section: DmSection.other,
          summary: '',
          description: items
              .map((i) =>
                  '${i.name}\n${i.description.isNotEmpty ? i.description : i.summary}')
              .join('\n\n'),
          lines: const []),
      descriptionBuilder: (context) =>
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            for (var index = 0; index < items.length; index++) ...[
              if (index > 0) const SizedBox(height: 12),
              Column(
                  key: ValueKey(items[index].id),
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(items[index].name,
                        style: Theme.of(context).textTheme.titleSmall),
                    if (items[index].description.isNotEmpty)
                      SelectableText(items[index].description)
                    else if (items[index].summary.isNotEmpty)
                      Text(items[index].summary),
                  ]),
            ]
          ]));
}
