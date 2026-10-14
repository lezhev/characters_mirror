import 'dart:convert';
import 'package:flutter/material.dart';

class DmRawJsonSection extends StatefulWidget {
  const DmRawJsonSection({super.key, required this.rawJson});
  final String rawJson;
  @override
  State<DmRawJsonSection> createState() => _DmRawJsonSectionState();
}

class _DmRawJsonSectionState extends State<DmRawJsonSection> {
  bool _expanded = false;
  String? _formatted;
  @override
  Widget build(BuildContext context) => Card(
          child: ExpansionTile(
        title: const Text('Исходный JSON'),
        onExpansionChanged: (expanded) => setState(() => _expanded = expanded),
        children: _expanded
            ? [
                SizedBox(
                    height: 400,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: SelectableText(
                          _formatted ??= const JsonEncoder.withIndent('  ')
                              .convert(jsonDecode(widget.rawJson)),
                          style: const TextStyle(
                              fontFamily: 'monospace', fontSize: 12)),
                    ))
              ]
            : [],
      ));
}
