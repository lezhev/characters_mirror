import 'dart:convert';
import 'package:flutter/material.dart';

class DmRawJsonSection extends StatefulWidget {
  const DmRawJsonSection(
      {super.key, required this.rawJson, this.title = 'Исходный JSON'});
  final String rawJson;
  final String title;
  @override
  State<DmRawJsonSection> createState() => _DmRawJsonSectionState();
}

class _DmRawJsonSectionState extends State<DmRawJsonSection> {
  bool _expanded = false;
  String? _formatted;
  @override
  void didUpdateWidget(covariant DmRawJsonSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rawJson != widget.rawJson) _formatted = null;
  }

  @override
  Widget build(BuildContext context) => ExpansionTile(
        key: PageStorageKey(widget.title),
        title: Text(widget.title),
        shape: const Border(),
        collapsedShape: const Border(),
        onExpansionChanged: (expanded) =>
            WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && expanded != _expanded) {
            setState(() => _expanded = expanded);
          }
        }),
        children: _expanded
            ? [
                SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      key: PageStorageKey('${widget.title}:scroll'),
                      padding: const EdgeInsets.all(16),
                      child: SelectableText(
                          key: PageStorageKey('${widget.title}:text'),
                          _formatted ??= const JsonEncoder.withIndent('  ')
                              .convert(jsonDecode(widget.rawJson)),
                          style: const TextStyle(
                              fontFamily: 'monospace', fontSize: 12)),
                    ))
              ]
            : [],
      );
}
