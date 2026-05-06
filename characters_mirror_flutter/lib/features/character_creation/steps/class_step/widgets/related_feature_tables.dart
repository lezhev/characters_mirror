import 'dart:convert';

import 'package:characters_mirror_flutter/core/ui/widgets/smooth_switcher.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

const int relatedFeatureTablePreviewRowCount = 12;

class RelatedFeatureTable {
  const RelatedFeatureTable({
    required this.headers,
    required this.rows,
    this.title,
  });

  final String? title;
  final List<String> headers;
  final List<Map<String, String>> rows;
}

List<RelatedFeatureTable> parseRelatedFeatureTables(String? payload) {
  final text = payload?.trim();
  if (text == null || text.isEmpty) {
    return const <RelatedFeatureTable>[];
  }

  try {
    final decoded = jsonDecode(text);
    if (decoded is! List) {
      return const <RelatedFeatureTable>[];
    }

    return decoded
        .whereType<Map>()
        .map(_parseRelatedFeatureTable)
        .whereType<RelatedFeatureTable>()
        .toList(growable: false);
  } on FormatException {
    return const <RelatedFeatureTable>[];
  } on TypeError {
    return const <RelatedFeatureTable>[];
  }
}

RelatedFeatureTable? _parseRelatedFeatureTable(Map<dynamic, dynamic> source) {
  final headers = (source['headers'] as List?)
      ?.whereType<String>()
      .where((header) => header.trim().isNotEmpty)
      .toList(growable: false);
  final rawRows = source['rows'] as List?;

  if (headers == null || headers.isEmpty || rawRows == null) {
    return null;
  }

  final rows = rawRows.whereType<Map>().map((row) {
    return {
      for (final header in headers)
        header: row[header] == null ? '' : row[header].toString(),
    };
  }).toList(growable: false);

  if (rows.isEmpty) {
    return null;
  }

  final rawTitle = source['title'];
  final title =
      rawTitle is String && rawTitle.trim().isNotEmpty ? rawTitle : null;

  return RelatedFeatureTable(
    title: title,
    headers: headers,
    rows: rows,
  );
}

class RelatedFeatureTables extends StatefulWidget {
  const RelatedFeatureTables({
    required this.tables,
    required this.isExpanded,
    super.key,
    this.expandedTableIndexes = const <int>{},
    this.onToggleRows,
  });

  final List<RelatedFeatureTable> tables;
  final bool isExpanded;
  final Set<int> expandedTableIndexes;
  final ValueChanged<int>? onToggleRows;

  @override
  State<RelatedFeatureTables> createState() => _RelatedFeatureTablesState();
}

class _RelatedFeatureTablesState extends State<RelatedFeatureTables> {
  @override
  Widget build(BuildContext context) {
    final tables = widget.tables;
    if (tables.isEmpty) {
      return const SizedBox.shrink();
    }

    return SmoothSwitcher(
      switchKey: Object.hash(
        widget.isExpanded,
        Object.hashAll(widget.expandedTableIndexes),
      ),
      autoScrollOnTransition: false,
      child: widget.isExpanded
          ? Column(
              key: ValueKey<Object>(
                Object.hash(
                  'expanded',
                  Object.hashAll(widget.expandedTableIndexes),
                ),
              ),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(4),
                for (var index = 0; index < tables.length; index++) ...[
                  if (index > 0) const Gap(12),
                  _RelatedFeatureTableView(
                    table: tables[index],
                    isExpanded: widget.expandedTableIndexes.contains(index),
                    onToggleRows: () => widget.onToggleRows?.call(index),
                  ),
                ],
              ],
            )
          : const SizedBox.shrink(key: ValueKey<String>('collapsed')),
    );
  }
}

class RelatedFeatureTablesToggle extends StatelessWidget {
  const RelatedFeatureTablesToggle({
    required this.isExpanded,
    required this.onPressed,
    super.key,
  });

  final bool isExpanded;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 36, height: 36),
      tooltip: isExpanded ? 'Скрыть таблицы' : 'Показать таблицы',
      onPressed: onPressed,
      icon: AnimatedRotation(
        turns: isExpanded ? 0.5 : 0,
        duration: const Duration(milliseconds: 200),
        child: const Icon(Icons.expand_more),
      ),
    );
  }
}

String displayFeatureText(String value) {
  return value
      .replaceAll(r'\r\n', '\n')
      .replaceAll(r'\n', '\n')
      .replaceAll(r'\r', '\n');
}

class _RelatedFeatureTableView extends StatelessWidget {
  const _RelatedFeatureTableView({
    required this.table,
    required this.isExpanded,
    required this.onToggleRows,
  });

  final RelatedFeatureTable table;
  final bool isExpanded;
  final VoidCallback onToggleRows;

  @override
  Widget build(BuildContext context) {
    final visibleRows = isExpanded
        ? table.rows
        : table.rows.take(relatedFeatureTablePreviewRowCount).toList();
    final hasHiddenRows =
        table.rows.length > relatedFeatureTablePreviewRowCount;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (table.title != null) ...[
          Text(table.title!, style: theme.textTheme.titleSmall),
          const Gap(6),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Table(
            border: TableBorder.all(
              color: theme.colorScheme.outlineVariant,
            ),
            defaultColumnWidth: const FlexColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                children: [
                  for (final header in table.headers)
                    _RelatedFeatureTableCell(
                      text: header,
                      isHeader: true,
                    ),
                ],
              ),
              for (final row in visibleRows)
                TableRow(
                  children: [
                    for (final header in table.headers)
                      _RelatedFeatureTableCell(text: row[header] ?? ''),
                  ],
                ),
            ],
          ),
        ),
        if (hasHiddenRows) ...[
          const Gap(6),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: onToggleRows,
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 20,
              ),
              label: Text(
                isExpanded
                    ? 'Скрыть'
                    : 'Показать ещё ${table.rows.length - visibleRows.length}',
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _RelatedFeatureTableCell extends StatelessWidget {
  const _RelatedFeatureTableCell({
    required this.text,
    this.isHeader = false,
  });

  final String text;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayText = displayFeatureText(text);
    final style = isHeader
        ? theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w700)
        : theme.textTheme.bodySmall;
    final canOpenDetails = !isHeader && text.trim().isNotEmpty;

    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
      child: Text(
        displayText,
        maxLines: isHeader ? 2 : 3,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );

    if (!canOpenDetails) {
      return child;
    }

    return InkWell(
      onTap: () => _showRelatedTableCellDialog(context, displayText),
      child: child,
    );
  }
}

Future<void> _showRelatedTableCellDialog(
  BuildContext context,
  String text,
) {
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Закрыть'),
          ),
        ],
      );
    },
  );
}
