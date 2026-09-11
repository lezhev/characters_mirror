part of '../import_spell_csv.dart';

List<List<String>> _parseCsv(String input) {
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var inQuotes = false;

  void endField() {
    row.add(field.toString());
    field.clear();
  }

  void endRow() {
    endField();
    rows.add(row);
    row = <String>[];
  }

  for (var i = 0; i < input.length; i++) {
    final ch = input[i];
    if (ch == '"') {
      if (inQuotes && i + 1 < input.length && input[i + 1] == '"') {
        field.write('"');
        i++;
      } else {
        inQuotes = !inQuotes;
      }
      continue;
    }

    if (ch == ',' && !inQuotes) {
      endField();
      continue;
    }

    if ((ch == '\n' || ch == '\r') && !inQuotes) {
      if (ch == '\r' && i + 1 < input.length && input[i + 1] == '\n') {
        i++;
      }
      endRow();
      continue;
    }

    field.write(ch);
  }

  if (inQuotes) {
    throw const FormatException('CSV ended inside a quoted field.');
  }
  if (field.isNotEmpty || row.isNotEmpty) {
    endRow();
  }
  return rows;
}

String _requiredText(String value, int rowIndex, String column) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    throw FormatException(
        'CSV row ${rowIndex + 1} has empty required $column.');
  }
  return normalized;
}

int _requiredInt(String value, int rowIndex, String column) {
  final parsed = _nullableInt(value);
  if (parsed == null) {
    throw FormatException(
        'CSV row ${rowIndex + 1} has empty required $column.');
  }
  return parsed;
}

String? _nullableText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty || trimmed.toLowerCase() == 'null') {
    return null;
  }
  return trimmed;
}

int? _nullableInt(String? value) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    return null;
  }
  return int.parse(normalized);
}

int? _nullableMaterialCost(String? value) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    return null;
  }
  final digits = normalized.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) {
    return null;
  }
  return int.parse(digits);
}

bool? _nullableBool(String? value) {
  final normalized = _nullableText(value)?.toLowerCase();
  if (normalized == null) {
    return null;
  }
  if (normalized == 'true') {
    return true;
  }
  if (normalized == 'false') {
    return false;
  }
  throw FormatException('Expected boolean, got "$value".');
}

List<int> _dbIntList(Object? value) {
  if (value == null) {
    return const [];
  }

  final Object? decoded = value is String ? jsonDecode(value) : value;
  if (decoded is! List) {
    return const [];
  }

  final result = <int>[];
  for (final item in decoded) {
    if (item is int) {
      result.add(item);
    } else if (item is num) {
      result.add(item.toInt());
    } else if (item is String) {
      final parsed = int.tryParse(item);
      if (parsed != null) {
        result.add(parsed);
      }
    }
  }
  return result..sort();
}

bool _sameIntList(List<int> first, List<int> second) {
  if (first.length != second.length) {
    return false;
  }
  final sortedFirst = [...first]..sort();
  final sortedSecond = [...second]..sort();
  for (var i = 0; i < sortedFirst.length; i++) {
    if (sortedFirst[i] != sortedSecond[i]) {
      return false;
    }
  }
  return true;
}

List<String> _splitList(String? value) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    return const [];
  }
  final listText = normalized.replaceAll(r'\r', ',').replaceAll(r'\n', ',');
  final result = <String>[];
  final seen = <String>{};
  for (final part in listText.split(RegExp(r'[,\r\n]+'))) {
    final trimmed = part.trim().replaceAll('"', '');
    final key = _normalize(trimmed);
    if (_ignoredTokens.contains(key) || !seen.add(key)) {
      continue;
    }
    result.add(trimmed);
  }
  return result;
}

List<String> _duplicates(Iterable<String> values) {
  final seen = <String>{};
  final duplicates = <String>{};
  for (final value in values) {
    if (!seen.add(value)) {
      duplicates.add(value);
    }
  }
  return duplicates.toList()..sort();
}

String _normalize(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll('ё', 'е')
      .replaceAll(RegExp(r'\s+'), ' ');
}

String _quoteList(Iterable<String> values, {int max = 20}) {
  final list = values.toList()..sort();
  if (list.isEmpty) {
    return '-';
  }
  final visible = list.take(max).join(', ');
  final hidden = list.length - max;
  return hidden > 0 ? '$visible, ... (+$hidden)' : visible;
}
