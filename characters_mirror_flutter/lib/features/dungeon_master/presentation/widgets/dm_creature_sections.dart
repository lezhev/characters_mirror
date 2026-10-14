import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:flutter/material.dart';
import '../../application/dm_display_fields.dart';

class DmJsonSection extends StatelessWidget {
  const DmJsonSection({super.key, required this.title, required this.fields});
  final String title;
  final CreatureJson fields;
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            DmJsonFields(fields: fields),
          ])));
}

class DmJsonFields extends StatelessWidget {
  const DmJsonFields({super.key, required this.fields});
  final CreatureJson fields;
  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: fields.isEmpty
          ? [const Text('Нет данных')]
          : [
              for (final entry in fields.entries)
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SelectableText(
                      '${dmFieldLabels[entry.key] ?? entry.key}: ${dmValueText(entry.value)}',
                    )),
            ]);
}

class DmItemSection extends StatelessWidget {
  const DmItemSection({super.key, required this.title, required this.items});
  final String title;
  final List<NormalizedCreatureItem> items;
  @override
  Widget build(BuildContext context) => Card(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
            padding: const EdgeInsets.all(16),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
        if (items.isEmpty)
          const Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text('Нет данных')),
        for (final item in items)
          ExpansionTile(
            title: Text(item.name),
            subtitle: Text('${item.itemType} · ${item.activationType ?? '—'}'
                '${item.spellLevel == null ? '' : ' · уровень ${item.spellLevel}'}'),
            expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
            childrenPadding: const EdgeInsets.all(16),
            children: [
              if (item.description.isNotEmpty) ...[
                SelectableText(item.description),
                const SizedBox(height: 16)
              ],
              DmJsonFields(fields: {
                for (final entry in item.fields.entries)
                  if (!{'name', 'description', 'sourceSystem', 'effects'}
                      .contains(entry.key))
                    entry.key: entry.value
              }),
            ],
          ),
      ]));
}
