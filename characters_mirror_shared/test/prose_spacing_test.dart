import 'package:test/test.dart';

import 'package:characters_mirror_shared/characters_mirror_shared.dart';

void main() {
  group('normalizeProseSpacing', () {
    test('removes whitespace before a period', () {
      expect(normalizeProseSpacing('word .'), 'word.');
      expect(normalizeProseSpacing('word \n.'), 'word.');
    });

    test('adds one space before the next word on the same line', () {
      expect(normalizeProseSpacing('word.Next'), 'word. Next');
      expect(normalizeProseSpacing('word.   Next'), 'word. Next');
      expect(
        normalizeProseSpacing(
          '\u0421\u043b\u043e\u0432\u043e.'
          '\u0421\u043b\u0435\u0434\u0443\u044e\u0449\u0435\u0435',
        ),
        '\u0421\u043b\u043e\u0432\u043e. '
        '\u0421\u043b\u0435\u0434\u0443\u044e\u0449\u0435\u0435',
      );
    });

    test('preserves line breaks after a period and removes padding', () {
      expect(normalizeProseSpacing('word. \n  Next'), 'word.\nNext');
      expect(normalizeProseSpacing('word. \n \n Next'), 'word.\n\nNext');
      expect(normalizeProseSpacing(r'word.\nNext'), r'word.\nNext');
      expect(normalizeProseSpacing(r'word.  \nNext'), r'word.\nNext');
    });

    test('keeps protected punctuation constructs intact', () {
      expect(normalizeProseSpacing('1.5 ... 2.0'), '1.5 ... 2.0');
      expect(
        normalizeProseSpacing('https://example.com/a.b'),
        'https://example.com/a.b',
      );
      expect(
        normalizeProseSpacing('mail@example.com'),
        'mail@example.com',
      );
    });

    test('keeps common Russian abbreviations intact', () {
      expect(
        normalizeProseSpacing('\u0442.\u0434.'),
        '\u0442.\u0434.',
      );
      expect(
        normalizeProseSpacing('\u0442. \u0434.'),
        '\u0442. \u0434.',
      );
      expect(
        normalizeProseSpacing('\u0442.\u043f.'),
        '\u0442.\u043f.',
      );
      expect(
        normalizeProseSpacing('\u0442. \u043f.'),
        '\u0442. \u043f.',
      );
      expect(
        normalizeProseSpacing('\u0442.\u0447.'),
        '\u0442.\u0447.',
      );
      expect(
        normalizeProseSpacing('\u0442.\u0435.'),
        '\u0442.\u0435.',
      );
    });

    test('keeps initials intact', () {
      expect(normalizeProseSpacing('A.B.'), 'A.B.');
      expect(
        normalizeProseSpacing('\u0410.\u0411.'),
        '\u0410.\u0411.',
      );
    });

    test('does not append whitespace at end of text', () {
      expect(normalizeProseSpacing('word.'), 'word.');
      expect(normalizeProseSpacing('word.  '), 'word.');
    });
  });

  group('hasInvalidEscapedProseNewline', () {
    test('allows escaped newline only immediately after a period', () {
      expect(hasInvalidEscapedProseNewline(r'First.\nSecond'), isFalse);
      expect(hasInvalidEscapedProseNewline(r'First. Second'), isFalse);
      expect(hasInvalidEscapedProseNewline(r'First\nSecond'), isTrue);
      expect(hasInvalidEscapedProseNewline(r'First,\nSecond'), isTrue);
      expect(hasInvalidEscapedProseNewline(r'First.\n\nSecond'), isTrue);
      expect(hasInvalidEscapedProseNewline(r'\nFirst'), isTrue);
    });

    test('flags escaped newline inside a word', () {
      expect(
        hasInvalidEscapedProseNewline(
          r'\u043e\u0441\u0432\u0435\u0449\u0435\n\u043d',
        ),
        isTrue,
      );
    });
  });
}
