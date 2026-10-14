import '../generated/protocol.dart';
import '../validation/rules.dart';
import '../validation/validation_exception.dart';

typedef FoundryJson = Map<String, Object?>;

/// Reads untrusted Foundry fields without coercing malformed values to zero.
class FoundryJsonReader {
  final List<String> diagnostics = [];

  FoundryJson object(Object? value, String path) {
    if (value == null) return {};
    if (value is Map<String, Object?>) return value;
    diagnostics.add('$path: ожидался объект; поле сохранено в исходном JSON.');
    return {};
  }

  String? text(Object? value, String path, {bool long = false}) {
    if (value == null) return null;
    if (value is! String) {
      diagnostics.add('$path: ожидалась строка; значение неизвестно.');
      return null;
    }
    try {
      if (long) {
        Rules.longText(path, value);
      } else {
        Rules.mediumText(path, value);
      }
    } on InputValidationException {
      throw DmCreatureException(
          code: 'invalid_field',
          message: 'Поле $path превышает допустимую длину.');
    }
    return value;
  }

  num? number(Object? value, String path) {
    if (value == null) return null;
    final parsed = value is num
        ? value
        : value is String
            ? num.tryParse(value)
            : null;
    if (parsed != null && parsed.isFinite) return parsed;
    diagnostics.add('$path: числовое значение неизвестно.');
    return null;
  }

  int? integer(Object? value, String path) {
    final parsed = number(value, path);
    if (parsed == null) return null;
    if (parsed == parsed.roundToDouble()) return parsed.toInt();
    diagnostics.add('$path: ожидалось целое число; значение неизвестно.');
    return null;
  }

  int? nonNegative(Object? value, String path) {
    final parsed = integer(value, path);
    if (parsed == null) return null;
    try {
      Rules.nonNegativeInt(path, parsed);
    } on InputValidationException {
      throw DmCreatureException(
          code: 'invalid_field',
          message: 'Поле $path выходит за допустимые границы.');
    }
    return parsed;
  }
}
