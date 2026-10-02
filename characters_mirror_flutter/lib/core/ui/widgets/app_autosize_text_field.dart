import 'package:flutter/material.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_formatters.dart';

class AppAutosizeTextField extends StatelessWidget {
  const AppAutosizeTextField({
    required this.label,
    required this.controller,
    super.key,
    this.focusNode,
    this.minLines = 3,
    this.onChanged,
    this.maxRunes,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int minLines;
  final ValueChanged<String>? onChanged;
  final int? maxRunes;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      minLines: minLines,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      inputFormatters:
          maxRunes == null ? null : [textLengthFormatter(maxRunes!)],
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
