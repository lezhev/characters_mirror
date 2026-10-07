import 'dart:math' as math;

enum FeatureDisplayPropertyValueKind { staticValue, progression, formula }

class FeatureDisplayPropertyDefinition {
  const FeatureDisplayPropertyDefinition({
    required this.key,
    required this.label,
    required this.valueKind,
    this.staticValue,
    this.progression,
    this.formula,
    this.sortOrder,
  });

  final String key;
  final String label;
  final FeatureDisplayPropertyValueKind valueKind;
  final String? staticValue;
  final Map<int, String>? progression;
  final String? formula;
  final int? sortOrder;
}

class FeatureDisplayPropertyValue {
  const FeatureDisplayPropertyValue({
    required this.key,
    required this.label,
    required this.value,
    this.sortOrder,
  });

  final String key;
  final String label;
  final String value;
  final int? sortOrder;
}

/// Resolves only display values; formula dice are rendered and never rolled.
List<FeatureDisplayPropertyValue> resolveFeatureDisplayProperties({
  required Iterable<FeatureDisplayPropertyDefinition> definitions,
  required int sourceLevel,
  int? characterLevel,
  int? subclassLevel,
  Map<String, int> abilityModifiers = const {},
}) {
  final resolved = <FeatureDisplayPropertyValue>[];
  for (final definition in definitions) {
    final key = definition.key.trim();
    final label = definition.label.trim();
    if (key.isEmpty || label.isEmpty) continue;

    final value = switch (definition.valueKind) {
      FeatureDisplayPropertyValueKind.staticValue =>
        _nonEmpty(definition.staticValue),
      FeatureDisplayPropertyValueKind.progression =>
        _progressionValue(definition.progression, sourceLevel),
      FeatureDisplayPropertyValueKind.formula => _formulaValue(
          definition.formula,
          sourceLevel: sourceLevel,
          characterLevel: characterLevel,
          subclassLevel: subclassLevel,
          abilityModifiers: abilityModifiers,
        ),
    };
    if (value == null) continue;
    resolved.add(
      FeatureDisplayPropertyValue(
        key: key,
        label: label,
        value: value,
        sortOrder: definition.sortOrder,
      ),
    );
  }
  resolved.sort((left, right) {
    final order = (left.sortOrder ?? 0).compareTo(right.sortOrder ?? 0);
    return order != 0 ? order : left.key.compareTo(right.key);
  });
  return resolved;
}

String? _nonEmpty(String? value) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? null : normalized;
}

String? _progressionValue(Map<int, String>? progression, int sourceLevel) {
  if (progression == null || progression.isEmpty) return null;
  final levels = progression.keys.where((level) => level <= sourceLevel);
  if (levels.isEmpty) return null;
  final selectedLevel = levels.reduce(math.max);
  return _nonEmpty(progression[selectedLevel]);
}

String? _formulaValue(
  String? formula, {
  required int sourceLevel,
  required int? characterLevel,
  required int? subclassLevel,
  required Map<String, int> abilityModifiers,
}) {
  final source = _nonEmpty(formula);
  if (source == null) return null;
  try {
    final parser = _DisplayFormulaParser(
      source,
      sourceLevel: sourceLevel,
      characterLevel: characterLevel,
      subclassLevel: subclassLevel,
      abilityModifiers: abilityModifiers,
    );
    final result = parser.parse();
    return result.number == null
        ? result.display
        : _formatNumber(result.number!);
  } on FormatException {
    return null;
  } on UnsupportedError {
    return null;
  } on RangeError {
    return null;
  }
}

String _formatNumber(num value) {
  if (!value.isFinite) throw const FormatException('Non-finite value.');
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toString();
}

class _FormulaValue {
  const _FormulaValue.number(num value)
      : number = value,
        display = '';
  const _FormulaValue.display(this.display) : number = null;

  final num? number;
  final String display;

  String get expression => number == null ? display : _formatNumber(number!);
}

class _DisplayFormulaParser {
  _DisplayFormulaParser(
    this.source, {
    required this.sourceLevel,
    required this.characterLevel,
    required this.subclassLevel,
    required this.abilityModifiers,
  }) : _tokens = _tokenize(source);

  final String source;
  final int sourceLevel;
  final int? characterLevel;
  final int? subclassLevel;
  final Map<String, int> abilityModifiers;
  final List<String> _tokens;
  int _index = 0;

  _FormulaValue parse() {
    if (_tokens.isEmpty) throw const FormatException('Empty formula.');
    final value = _parseSum();
    if (_index != _tokens.length) {
      throw const FormatException('Unexpected formula token.');
    }
    return value;
  }

  _FormulaValue _parseSum() {
    var value = _parseProduct();
    while (_peek('+') || _peek('-')) {
      final operator = _take();
      value = _combine(value, _parseProduct(), operator);
    }
    return value;
  }

  _FormulaValue _parseProduct() {
    var value = _parseUnary();
    while (_peek('*') || _peek('/')) {
      final operator = _take();
      value = _combine(value, _parseUnary(), operator);
    }
    return value;
  }

  _FormulaValue _parseUnary() {
    if (_peek('+')) {
      _take();
      return _parseUnary();
    }
    if (_peek('-')) {
      _take();
      final value = _parseUnary();
      if (value.number != null) return _FormulaValue.number(-value.number!);
      return _FormulaValue.display('-${value.display}');
    }
    return _parsePrimary();
  }

  _FormulaValue _parsePrimary() {
    if (_peek('(')) {
      _take();
      final value = _parseSum();
      _expect(')');
      return value;
    }
    final token = _take();
    final number = num.tryParse(token);
    if (number != null) return _FormulaValue.number(number);
    if (RegExp(r'^\d+d\d+$', caseSensitive: false).hasMatch(token)) {
      return _FormulaValue.display(
        token.replaceFirst(RegExp('d', caseSensitive: false), 'к'),
      );
    }
    if (_peek('(')) return _parseFunction(token);
    final operand = switch (token) {
      'classLevel' => _FormulaValue.number(sourceLevel),
      'subclassLevel' => _FormulaValue.number(
          subclassLevel ?? sourceLevel,
        ),
      'characterLevel' when characterLevel != null =>
        _FormulaValue.number(characterLevel!),
      _ => null,
    };
    if (operand == null) throw FormatException('Unsupported operand: $token');
    return operand;
  }

  _FormulaValue _parseFunction(String name) {
    _expect('(');
    if (name == 'abilityModifier') {
      final ability = _take();
      _expect(')');
      final value = abilityModifiers[ability];
      if (value == null) throw const FormatException('Unknown ability.');
      return _FormulaValue.number(value);
    }
    if (name == 'max' || name == 'min') {
      final left = _parseSum();
      _expect(',');
      final right = _parseSum();
      _expect(')');
      if (left.number == null || right.number == null) {
        throw const FormatException('Min/max requires numeric values.');
      }
      return _FormulaValue.number(
        name == 'max'
            ? math.max(left.number!, right.number!)
            : math.min(left.number!, right.number!),
      );
    }
    if (name != 'ceil' && name != 'floor') {
      throw const FormatException('Unsupported function.');
    }
    final value = _parseSum();
    _expect(')');
    if (value.number == null) {
      throw const FormatException('Rounding requires a numeric value.');
    }
    return _FormulaValue.number(
      name == 'ceil' ? value.number!.ceil() : value.number!.floor(),
    );
  }

  _FormulaValue _combine(
    _FormulaValue left,
    _FormulaValue right,
    String operator,
  ) {
    if (left.number != null && right.number != null) {
      final a = left.number!;
      final b = right.number!;
      return _FormulaValue.number(switch (operator) {
        '+' => a + b,
        '-' => a - b,
        '*' => a * b,
        '/' when b != 0 => a / b,
        '/' => throw const FormatException('Division by zero.'),
        _ => throw const FormatException('Unsupported operator.'),
      });
    }
    return _FormulaValue.display(
        '${left.expression} $operator ${right.expression}');
  }

  bool _peek(String value) =>
      _index < _tokens.length && _tokens[_index] == value;

  String _take() {
    if (_index >= _tokens.length)
      throw const FormatException('Unexpected end.');
    return _tokens[_index++];
  }

  void _expect(String value) {
    if (!_peek(value)) throw FormatException('Expected $value.');
    _index++;
  }

  static List<String> _tokenize(String formula) {
    final tokens = <String>[];
    final matcher = RegExp(
      r'\s*(\d+d\d+|\d+(?:\.\d+)?|[A-Za-z][A-Za-z0-9]*|[()+\-*/,])',
      caseSensitive: false,
    ).allMatches(formula);
    var consumed = 0;
    for (final match in matcher) {
      if (formula.substring(consumed, match.start).trim().isNotEmpty) {
        throw const FormatException('Invalid formula token.');
      }
      tokens.add(match.group(1)!);
      consumed = match.end;
    }
    if (formula.substring(consumed).trim().isNotEmpty) {
      throw const FormatException('Invalid formula suffix.');
    }
    return tokens;
  }
}
