part of '../character_sheet_state.dart';

String? _normalizedText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }
  return trimmed;
}

List<ConditionType>? _normalizedActiveConditions(
  List<ConditionType>? conditions,
) {
  final normalized = <ConditionType>[];
  for (final condition in conditions ?? const <ConditionType>[]) {
    if (condition == ConditionType.exhaustion ||
        normalized.contains(condition)) {
      continue;
    }
    normalized.add(condition);
  }
  return normalized.isEmpty ? null : normalized;
}

int? _normalizedExhaustionLevel(int? value) {
  if (value == null || value <= 0) {
    return null;
  }
  return value.clamp(1, 6).toInt();
}

int _normalizedMovementSpeed(int value) {
  return value < 0 ? 0 : value;
}

String? _spellKey(SpellData spell) {
  return _normalizedText(spell.referenceKey);
}

List<CharacterSpellSelectionData>? _normalizedSpellSelections(
  List<CharacterSpellSelectionData>? selections,
) {
  final normalized = [...?selections];
  return normalized.isEmpty ? null : normalized;
}

List<String> _defaultPreparedSpellKeys(CharacterData character) {
  final keys = {
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (selection.kind == CharacterSpellSelectionKind.preparedSpell &&
          _spellSelectionKey(selection) != null)
        _spellSelectionKey(selection)!,
  }.toList()
    ..sort();
  return keys;
}

Set<String> _effectivePreparedSpellKeys(CharacterData character) {
  final explicit = character.preparedSpellKeys;
  if (explicit != null) {
    final aliases = {
      for (final s
          in character.spellSelections ?? <CharacterSpellSelectionData>[])
        if (_normalizedText(s.spellKey) != null &&
            _normalizedText(s.spell?.referenceKey) != null)
          _normalizedText(s.spellKey)!: _normalizedText(s.spell?.referenceKey)!,
    };
    return {
      for (final key in explicit)
        if (_normalizedText(key) != null)
          aliases[_normalizedText(key)!] ?? _normalizedText(key)!,
    };
  }
  return _defaultPreparedSpellKeys(character).toSet();
}

List<String>? _normalizedPreparedKeys(
  CharacterData character,
  Set<String> preparedKeys, {
  List<String>? defaultKeys,
}) {
  final sortedKeys = preparedKeys.toList()..sort();
  final defaults = defaultKeys ?? _defaultPreparedSpellKeys(character);
  final matchesDefault = sortedKeys.length == defaults.length &&
      sortedKeys.every(defaults.contains);
  return matchesDefault ? null : sortedKeys;
}

String? _spellSelectionKey(CharacterSpellSelectionData selection) {
  return _normalizedText(selection.spell?.referenceKey) ??
      _normalizedText(selection.spellKey);
}
