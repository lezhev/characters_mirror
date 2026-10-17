import 'package:flutter/material.dart';
import '../../application/statblock/dm_statblock.dart';

class DmStatblockTop extends StatelessWidget {
  const DmStatblockTop({super.key, required this.statblock});
  final DmStatblock statblock;
  @override
  Widget build(BuildContext context) {
    final identity =
        statblock.blocks.firstWhere((b) => b.section == DmSection.identity);
    final combat =
        statblock.blocks.firstWhere((b) => b.section == DmSection.combat).lines;
    final theme = Theme.of(context);
    String value(String label) =>
        combat.where((l) => l.label == label).firstOrNull?.value ?? '—';
    final details = combat.where((l) => !{
          'КД',
          'HP',
          'Инициатива',
          'Бонус мастерства',
          'Скорость'
        }.contains(l.label));
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _Portrait(image: statblock.image),
        const SizedBox(width: 10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SelectableText(statblock.name, style: theme.textTheme.titleLarge),
          if (statblock.identity.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(statblock.identity,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant))
          ],
          const SizedBox(height: 4),
          Wrap(spacing: 10, runSpacing: 2, children: [
            for (final line in identity.lines)
              Text(line.text, style: theme.textTheme.bodySmall)
          ]),
        ])),
      ]),
      const SizedBox(height: 12),
      LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 300 ? 4 : 2;
        final width = (constraints.maxWidth - (columns - 1) * 6) / columns;
        return Wrap(spacing: 6, runSpacing: 6, children: [
          for (final entry in [
            ('ac', 'КД', 'КД'),
            ('hp', 'HP (макс.)', 'HP'),
            ('initiative', 'Инициатива', 'Инициатива'),
            ('proficiency', 'Мастерство', 'Бонус мастерства')
          ])
            SizedBox(
                width: width,
                child: _ValueCell(
                    key: ValueKey('dm-stat-${entry.$1}'),
                    label: entry.$2,
                    value: value(entry.$3))),
        ]);
      }),
      if (details.isNotEmpty) ...[
        const SizedBox(height: 6),
        Wrap(spacing: 12, runSpacing: 2, children: [
          for (final line in details)
            Text(line.text,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant))
        ])
      ],
      const SizedBox(height: 6),
      Text('Скорость: ${value('Скорость')}', style: theme.textTheme.bodyMedium),
      const SizedBox(height: 10),
      LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 480 ? 6 : 3;
        final width = (constraints.maxWidth - (columns - 1) * 6) / columns;
        return Wrap(spacing: 6, runSpacing: 6, children: [
          for (final ability in statblock.abilities)
            SizedBox(
                width: width,
                child: _ValueCell(
                    label: ability.label,
                    value: ability.score,
                    secondary: ability.modifier))
        ]);
      }),
      if (statblock.proficiencySummary.isNotEmpty) ...[
        const SizedBox(height: 8),
        for (final line in statblock.proficiencySummary)
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text(line.text, style: theme.textTheme.bodyMedium))
      ],
    ]);
  }
}

class _ValueCell extends StatelessWidget {
  const _ValueCell(
      {super.key, required this.label, required this.value, this.secondary});
  final String label, value;
  final String? secondary;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
        label: '$label: $value${secondary == null ? '' : ' ($secondary)'}',
        child: DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: theme.colorScheme.outlineVariant),
                borderRadius: BorderRadius.circular(8)),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(label,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme
                                          .colorScheme.onSurfaceVariant)))),
                      const SizedBox(height: 2),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(value, style: theme.textTheme.titleLarge),
                            if (secondary != null) ...[
                              const SizedBox(width: 4),
                              Text('($secondary)',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                      color:
                                          theme.colorScheme.onSurfaceVariant))
                            ],
                          ])),
                    ]))));
  }
}

class _Portrait extends StatelessWidget {
  const _Portrait({required this.image});
  final Uri? image;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget placeholder() => DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(8)),
        child: Icon(Icons.pets_outlined,
            color: theme.colorScheme.onSurfaceVariant, size: 26));
    return SizedBox(
        width: 48,
        height: 48,
        child: image == null
            ? placeholder()
            : ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(image.toString(),
                    fit: BoxFit.contain,
                    errorBuilder: (_, error, stack) => placeholder())));
  }
}
