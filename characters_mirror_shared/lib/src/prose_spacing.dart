bool hasInvalidEscapedProseNewline(String value) {
  var searchFrom = 0;
  while (true) {
    final index = value.indexOf(r'\n', searchFrom);
    if (index < 0) return false;
    if (index == 0 || value.codeUnitAt(index - 1) != 0x2e) {
      return true;
    }
    searchFrom = index + 2;
  }
}

String normalizeProseSpacing(String value) {
  if (value.isEmpty || !value.contains('.')) return value;

  final protected = <String>[];
  var working = value;

  for (final pattern in _protectedProsePatterns) {
    working = working.replaceAllMapped(pattern, (match) {
      final index = protected.length;
      protected.add(match.group(0)!);
      return '\u0001PROTECTED_$index\u0002';
    });
  }

  final buffer = StringBuffer();
  var index = 0;
  while (index < working.length) {
    final char = working[index];
    if (char != '.') {
      buffer.write(char);
      index += 1;
      continue;
    }

    final current = buffer.toString();
    final trimmed = current.replaceFirst(RegExp(r'[ \t\r\n]+$'), '');
    if (trimmed.length != current.length) {
      buffer
        ..clear()
        ..write(trimmed);
    }

    buffer.write('.');
    index += 1;
    if (index >= working.length) continue;

    var cursor = index;
    var sawLineBreak = false;
    final lineBreaks = StringBuffer();
    while (cursor < working.length) {
      final code = working.codeUnitAt(cursor);
      if (code == 0x20 || code == 0x09) {
        cursor += 1;
        continue;
      }
      if (code == 0x0d) {
        sawLineBreak = true;
        if (cursor + 1 < working.length &&
            working.codeUnitAt(cursor + 1) == 0x0a) {
          lineBreaks.write('\r\n');
          cursor += 2;
        } else {
          lineBreaks.write('\r');
          cursor += 1;
        }
        continue;
      }
      if (code == 0x0a) {
        sawLineBreak = true;
        lineBreaks.write('\n');
        cursor += 1;
        continue;
      }
      break;
    }

    if (sawLineBreak) {
      buffer.write(lineBreaks);
      index = cursor;
      continue;
    }

    if (_startsEscapedLineBreak(working, cursor)) {
      index = cursor;
      continue;
    }

    final hadHorizontalSpace = cursor > index;
    if (cursor >= working.length) {
      index = cursor;
      continue;
    }
    if (_startsProseWord(working, cursor)) {
      buffer.write(' ');
      index = cursor;
      continue;
    }

    if (hadHorizontalSpace) {
      buffer.write(' ');
      index = cursor;
    }
  }

  var result = buffer.toString();
  for (var i = protected.length - 1; i >= 0; i--) {
    result = result.replaceAll('\u0001PROTECTED_$i\u0002', protected[i]);
  }
  return result;
}

bool _startsEscapedLineBreak(String value, int index) {
  if (index + 1 < value.length &&
      value.codeUnitAt(index) == 0x5c &&
      value.codeUnitAt(index + 1) == 0x6e) {
    return true;
  }
  return index + 3 < value.length &&
      value.codeUnitAt(index) == 0x5c &&
      value.codeUnitAt(index + 1) == 0x72 &&
      value.codeUnitAt(index + 2) == 0x5c &&
      value.codeUnitAt(index + 3) == 0x6e;
}

bool _startsProseWord(String value, int index) {
  if (index >= value.length) return false;
  final code = value.codeUnitAt(index);
  if ((code >= 0x30 && code <= 0x39) ||
      (code >= 0x41 && code <= 0x5a) ||
      (code >= 0x61 && code <= 0x7a) ||
      (code >= 0x0400 && code <= 0x052f)) {
    return true;
  }
  return code == 0x22 ||
      code == 0x27 ||
      code == 0x28 ||
      code == 0x5b ||
      code == 0x7b ||
      code == 0x00ab ||
      code == 0x201c;
}

final _protectedProsePatterns = <RegExp>[
  RegExp(r'(?:https?://|www\.)[^\s]+', caseSensitive: false),
  RegExp(r'[^\s@]+@[^\s@]+\.[^\s@]+', caseSensitive: false),
  RegExp(r'\d+\.\d+'),
  RegExp(r'\.{2,}'),
  RegExp(r'[\u0430-\u044f\u0451]\.[ \t]*[\u0430-\u044f\u0451]\.'),
  RegExp(
    r'(?:[A-Z]\.[ \t]*){2,}|'
    r'(?:[\u0410-\u042F\u0401]\.[ \t]*){2,}',
  ),
];
