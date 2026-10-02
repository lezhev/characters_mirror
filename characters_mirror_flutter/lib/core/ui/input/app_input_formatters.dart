import 'package:flutter/services.dart';

import 'app_input_limits.dart';

TextInputFormatter textLengthFormatter(int maxRunes) =>
    _TextLengthFormatter(maxRunes);

TextInputFormatter nonNegativeIntFormatter(
        {int max = AppInputLimits.nonNegativeIntMax}) =>
    _BoundedIntFormatter(min: 0, max: max, allowNegativeIntermediate: false);

TextInputFormatter boundedIntFormatter({
  int min = AppInputLimits.boundedIntMin,
  int max = AppInputLimits.boundedIntMax,
}) =>
    _BoundedIntFormatter(min: min, max: max, allowNegativeIntermediate: true);

class _TextLengthFormatter extends TextInputFormatter {
  _TextLengthFormatter(this.maxRunes) : assert(maxRunes >= 0);
  final int maxRunes;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final runes = newValue.text.runes;
    if (runes.length <= maxRunes) return newValue;

    final accepted = runes.take(maxRunes).toList(growable: false);
    final text = String.fromCharCodes(accepted);
    final selection = newValue.selection;
    return newValue.copyWith(
      text: text,
      selection: TextSelection(
        baseOffset: _runeSafeOffset(newValue.text, selection.baseOffset, text),
        extentOffset:
            _runeSafeOffset(newValue.text, selection.extentOffset, text),
        affinity: selection.affinity,
        isDirectional: selection.isDirectional,
      ),
      composing: _clampComposing(newValue.composing, text.length),
    );
  }
}

class _BoundedIntFormatter extends TextInputFormatter {
  const _BoundedIntFormatter(
      {required this.min,
      required this.max,
      required this.allowNegativeIntermediate})
      : assert(min <= max);
  final int min;
  final int max;
  final bool allowNegativeIntermediate;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty || (allowNegativeIntermediate && text == '-')) {
      return newValue;
    }

    final negative = text.startsWith('-');
    if (negative && (!allowNegativeIntermediate || min >= 0)) {
      return oldValue;
    }

    final digitStart = negative ? 1 : 0;
    final digitCount = text.length - digitStart;
    if (digitCount == 0 || digitCount > _maxDigits(min, max)) {
      return oldValue;
    }
    for (var index = digitStart; index < text.length; index++) {
      final codeUnit = text.codeUnitAt(index);
      if (codeUnit < 0x30 || codeUnit > 0x39) return oldValue;
    }

    final value = int.tryParse(text);
    if (value == null || value < min || value > max) return oldValue;
    return newValue;
  }
}

int _maxDigits(int min, int max) =>
    (min.abs() > max.abs() ? min.abs() : max.abs()).toString().length;

int _runeSafeOffset(String original, int offset, String truncated) {
  if (offset < 0) return offset;
  final sourceOffset = offset.clamp(0, original.length);
  final acceptedRuneCount = original.substring(0, sourceOffset).runes.length;
  return String.fromCharCodes(truncated.runes.take(acceptedRuneCount)).length;
}

TextRange _clampComposing(TextRange range, int textLength) {
  if (!range.isValid || range.isCollapsed) return TextRange.empty;
  final start = range.start.clamp(0, textLength);
  final end = range.end.clamp(start, textLength);
  return TextRange(start: start, end: end);
}
