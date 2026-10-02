import 'package:characters_mirror_flutter/core/ui/input/app_input_formatters.dart';
import 'package:characters_mirror_flutter/core/ui/input/app_input_limits.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('textLengthFormatter', () {
    test('accepts text through the rune limit and truncates a large paste', () {
      final formatter = textLengthFormatter(3);
      expect(_format(formatter, '', 'ab').text, 'ab');
      expect(_format(formatter, '', 'abc').text, 'abc');
      expect(_format(formatter, '', 'abcdef').text, 'abc');
    });

    test('counts Unicode runes and permits deletion at the limit', () {
      final formatter = textLengthFormatter(2);
      expect(_format(formatter, '', '😀😀😀').text, '😀😀');
      expect(_format(formatter, 'abc', 'ab').text, 'ab');
    });
  });

  group('nonNegativeIntFormatter', () {
    final formatter = nonNegativeIntFormatter();
    test('accepts empty, boundaries, and ordinary values', () {
      for (final value in ['', '0', '25', '100000']) {
        expect(_format(formatter, '', value).text, value);
      }
    });

    test('rejects out of range, huge paste, and non-digits', () {
      for (final value in ['100001', '9' * 1000, '12a']) {
        expect(_format(formatter, '25', value).text, '25');
      }
    });
  });

  group('boundedIntFormatter', () {
    final formatter = boundedIntFormatter();
    test('accepts editing states and signed boundaries', () {
      for (final value in ['', '-', '-1', '-100000', '100000']) {
        expect(_format(formatter, '', value).text, value);
      }
    });

    test('rejects out of range, huge paste, and malformed signs', () {
      for (final value in ['-100001', '100001', '9' * 1000, '--1', '1-2']) {
        expect(_format(formatter, '25', value).text, '25');
      }
    });
  });

  test('client limits mirror server validation limits', () {
    expect(AppInputLimits.shortText, 120);
    expect(AppInputLimits.mediumText, 1000);
    expect(AppInputLimits.longText, 20000);
    expect(AppInputLimits.boundedIntMin, -100000);
    expect(AppInputLimits.boundedIntMax, 100000);
    expect(AppInputLimits.nonNegativeIntMax, 100000);
  });
}

TextEditingValue _format(
  TextInputFormatter formatter,
  String oldText,
  String newText,
) {
  return formatter.formatEditUpdate(
    TextEditingValue(
      text: oldText,
      selection: TextSelection.collapsed(offset: oldText.length),
    ),
    TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    ),
  );
}
