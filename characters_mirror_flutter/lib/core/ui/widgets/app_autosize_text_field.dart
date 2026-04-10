import 'package:flutter/material.dart';

class AppAutosizeTextField extends StatelessWidget {
  const AppAutosizeTextField({
    required this.label,
    required this.controller,
    super.key,
    this.focusNode,
    this.minLines = 3,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int minLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      minLines: minLines,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
