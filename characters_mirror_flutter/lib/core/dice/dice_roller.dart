import 'dart:math' as math;

class DiceRollResult {
  const DiceRollResult({
    required this.formula,
    required this.total,
    this.expandedFormula,
  });

  final String formula;
  final String? expandedFormula;
  final int total;

  String get displayText {
    final expanded = expandedFormula;
    if (expanded == null) {
      return '$formula = $total';
    }
    return '$formula = $expanded = $total';
  }
}

class DiceRollException implements Exception {
  const DiceRollException(this.message);

  final String message;

  @override
  String toString() => message;
}

typedef RollDie = int Function(int sides);

const _maxFormulaLength = 256;
const _maxDicePerTerm = 100;
const _maxTotalDice = 500;
const _maxDiceSides = 1000000;
const _maxAbsoluteValue = 1000000000;
const _maxExpandedFormulaLength = 240;

class DiceRoller {
  DiceRoller({
    RollDie? rollDie,
    Map<String, int>? variables,
  })  : _rollDie = rollDie ?? _defaultRollDie,
        _variables = _normalizedVariables(variables ?? const {});

  static final math.Random _random = math.Random();

  final RollDie _rollDie;
  final Map<String, int> _variables;

  DiceRollResult roll(String formula) {
    final trimmed = formula.trim();
    if (trimmed.isEmpty) {
      throw const DiceRollException('Введите формулу броска');
    }
    if (trimmed.length > _maxFormulaLength) {
      throw const DiceRollException('Формула слишком длинная');
    }

    final parser = _DiceParser(trimmed, _rollDie, _variables);
    final total = parser.parse();
    return DiceRollResult(
      formula: trimmed,
      expandedFormula: parser.expandedFormula,
      total: total,
    );
  }

  DiceRollResult rollModifier(String value) {
    final modifier = _parseModifier(value);
    if (modifier < 0) {
      return roll('d20 - ${modifier.abs()}');
    }
    return roll('d20 + $modifier');
  }

  static int _defaultRollDie(int sides) => _random.nextInt(sides) + 1;
}

int _parseModifier(String value) {
  final normalized = value.trim().replaceAll(' ', '');
  if (normalized.isEmpty) {
    throw const DiceRollException('Введите модификатор');
  }

  final modifier = int.tryParse(normalized);
  if (modifier == null) {
    throw const DiceRollException('Модификатор должен быть целым числом');
  }

  return modifier;
}

class _DiceParser {
  _DiceParser(this._source, this._rollDie, this._variables);

  final String _source;
  final RollDie _rollDie;
  final Map<String, int> _variables;
  final List<_DiceReplacement> _replacements = [];
  var _totalDiceCount = 0;
  var _hasDiceRoll = false;
  var _index = 0;

  String? get expandedFormula {
    if (!_hasDiceRoll) {
      return null;
    }

    final buffer = StringBuffer();
    var sourceIndex = 0;
    final sortedReplacements = [..._replacements]
      ..sort((left, right) => left.start.compareTo(right.start));
    for (final replacement in sortedReplacements) {
      buffer
        ..write(_source.substring(sourceIndex, replacement.start))
        ..write(replacement.text);
      sourceIndex = replacement.end;
    }
    buffer.write(_source.substring(sourceIndex));
    final expanded = _normalizeExpandedOperators(buffer.toString());
    if (expanded.length <= _maxExpandedFormulaLength) {
      return expanded;
    }
    return '${expanded.substring(0, _maxExpandedFormulaLength - 3)}...';
  }

  int parse() {
    final result = _parseExpression();
    _skipWhitespace();

    if (!_isAtEnd) {
      if (_current == '/') {
        throw const DiceRollException('Оператор / не поддерживается');
      }
      throw DiceRollException('Неожиданный символ "$_current"');
    }

    return result;
  }

  int _parseExpression() {
    var value = _parseTerm();

    while (true) {
      _skipWhitespace();
      if (_match('+')) {
        value = _checkedValue(value + _parseTerm());
      } else if (_match('-')) {
        value = _checkedValue(value - _parseTerm());
      } else {
        return value;
      }
    }
  }

  int _parseTerm() {
    var value = _parseFactor();

    while (true) {
      _skipWhitespace();
      if (_match('*')) {
        value = _checkedValue(value * _parseFactor());
      } else if (_match('/')) {
        value = _divideFloor(value, _parseFactor());
      } else {
        return value;
      }
    }
  }

  int _parseFactor() {
    _skipWhitespace();

    if (_isAtEnd) {
      throw const DiceRollException('Ожидалось значение');
    }

    if (_match('+')) {
      return _parseFactor();
    }
    if (_match('-')) {
      return _checkedValue(-_parseFactor());
    }
    if (_match('(')) {
      final value = _parseExpression();
      _skipWhitespace();
      if (!_match(')')) {
        throw const DiceRollException('Не закрыта скобка');
      }
      return value;
    }
    if (_isDiceStart(_index)) {
      final start = _index;
      _index++;
      final sides = _parseRequiredNumber('Ожидалось число граней');
      return _rollDice(1, sides, start, _index);
    }
    if (_isDigit(_current)) {
      final start = _index;
      final number = _parseNumber();
      _skipWhitespace();
      if (!_isAtEnd && _isDiceStart(_index)) {
        _index++;
        final sides = _parseRequiredNumber('Ожидалось число граней');
        return _rollDice(
          number,
          sides,
          start,
          _index,
        );
      }
      return number;
    }
    if (_isIdentifierStart(_current)) {
      return _parseVariable();
    }
    throw DiceRollException('Неожиданный символ "$_current"');
  }

  int _rollDice(int count, int sides, int start, int end) {
    if (count <= 0) {
      throw const DiceRollException('Количество кубиков должно быть больше 0');
    }
    if (count > _maxDicePerTerm) {
      throw const DiceRollException('Слишком много кубиков в одном броске');
    }
    if (sides <= 0) {
      throw const DiceRollException('Количество граней должно быть больше 0');
    }
    if (sides > _maxDiceSides) {
      throw const DiceRollException('Слишком много граней у кубика');
    }
    if (_totalDiceCount + count > _maxTotalDice) {
      throw const DiceRollException('Слишком много кубиков в формуле');
    }
    _totalDiceCount += count;
    _hasDiceRoll = true;

    var total = 0;
    final rolls = <int>[];
    for (var index = 0; index < count; index++) {
      final roll = _rollDie(sides);
      rolls.add(roll);
      total = _checkedValue(total + roll);
    }
    _replacements.add(
      _DiceReplacement(
        start: start,
        end: end,
        text: rolls.length == 1 ? '${rolls.single}' : '(${rolls.join(' + ')})',
      ),
    );
    return total;
  }

  int _parseRequiredNumber(String message) {
    _skipWhitespace();
    if (_isAtEnd || !_isDigit(_current)) {
      throw DiceRollException(message);
    }
    return _parseNumber();
  }

  int _parseNumber() {
    final start = _index;
    while (!_isAtEnd && _isDigit(_current)) {
      _index++;
    }

    final value = int.tryParse(_source.substring(start, _index));
    if (value == null) {
      throw const DiceRollException('Число слишком большое');
    }
    return _checkedValue(value);
  }

  int _parseVariable() {
    final start = _index;
    while (!_isAtEnd && _isIdentifierPart(_current)) {
      _index++;
    }

    final rawName = _source.substring(start, _index);
    final value = _variables[_normalizeVariableName(rawName)];
    if (value == null) {
      throw DiceRollException('Неизвестная переменная "$rawName"');
    }

    _replacements.add(
      _DiceReplacement(
        start: start,
        end: _index,
        text: '$value',
      ),
    );
    return _checkedValue(value);
  }

  void _skipWhitespace() {
    while (!_isAtEnd && _source[_index].trim().isEmpty) {
      _index++;
    }
  }

  bool _match(String value) {
    if (_isAtEnd || _source[_index] != value) {
      return false;
    }
    _index++;
    return true;
  }

  bool get _isAtEnd => _index >= _source.length;

  String get _current => _source[_index];

  bool _isDiceStart(int index) {
    if (!_isDiceSeparator(_source[index])) {
      return false;
    }

    var nextIndex = index + 1;
    while (nextIndex < _source.length && _source[nextIndex].trim().isEmpty) {
      nextIndex++;
    }
    return nextIndex < _source.length && _isDigit(_source[nextIndex]);
  }
}

int _checkedValue(int value) {
  if (value.abs() > _maxAbsoluteValue) {
    throw const DiceRollException('Результат слишком большой');
  }
  return value;
}

int _divideFloor(int left, int right) {
  if (right == 0) {
    throw const DiceRollException('Деление на 0 невозможно');
  }
  return _checkedValue((left / right).floor());
}

bool _isDigit(String value) {
  final code = value.codeUnitAt(0);
  return code >= 48 && code <= 57;
}

bool _isDiceSeparator(String value) {
  return value == 'd' || value == 'D' || value == 'к' || value == 'К';
}

bool _isIdentifierStart(String value) {
  return _identifierStartPattern.hasMatch(value);
}

bool _isIdentifierPart(String value) {
  return _identifierPartPattern.hasMatch(value);
}

Map<String, int> _normalizedVariables(Map<String, int> variables) {
  return {
    for (final entry in variables.entries)
      _normalizeVariableName(entry.key): _checkedValue(entry.value),
  };
}

String _normalizeVariableName(String value) => value.trim().toLowerCase();

String _normalizeExpandedOperators(String value) {
  return value
      .replaceAll(RegExp(r'\+\s*-'), '- ')
      .replaceAll(RegExp(r'-\s*-'), '+ ');
}

final _identifierStartPattern = RegExp(r'^[A-Za-zА-Яа-яЁё_]$');
final _identifierPartPattern = RegExp(r'^[A-Za-zА-Яа-яЁё_]$');

class _DiceReplacement {
  const _DiceReplacement({
    required this.start,
    required this.end,
    required this.text,
  });

  final int start;
  final int end;
  final String text;
}
