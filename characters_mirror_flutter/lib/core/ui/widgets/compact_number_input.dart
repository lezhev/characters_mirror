import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CompactNumberInput extends StatelessWidget {
  static const double extent = 60;
  const CompactNumberInput(
      {super.key,
      this.fieldKey,
      this.controller,
      this.initialValue,
      this.semanticLabel,
      required this.inputFormatters,
      required this.onChanged});

  final Key? fieldKey;
  final TextEditingController? controller;
  final String? initialValue;
  final String? semanticLabel;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleMedium ?? const TextStyle();
    return Semantics(
        label: semanticLabel,
        child: Align(
          alignment: Alignment.centerLeft,
          widthFactor: 1,
          heightFactor: 1,
          child: SizedBox.square(
            key: fieldKey,
            dimension: extent,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.outlineVariant)),
              child: TextFormField(
                controller: controller,
                initialValue: initialValue,
                expands: true,
                minLines: null,
                maxLines: null,
                textAlign: TextAlign.center,
                // Roboto Mono's visible digit bounds sit below the center of
                // its line box. Center the ink optically, not just the line.
                textAlignVertical: const TextAlignVertical(y: -0.15),
                inputFormatters: inputFormatters,
                keyboardType: TextInputType.number,
                style: textStyle.copyWith(height: 1),
                strutStyle: StrutStyle(
                  fontSize: textStyle.fontSize,
                  height: 1,
                  forceStrutHeight: true,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  filled: false,
                  isCollapsed: true,
                  contentPadding: EdgeInsets.only(left: 2),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        ));
  }
}
