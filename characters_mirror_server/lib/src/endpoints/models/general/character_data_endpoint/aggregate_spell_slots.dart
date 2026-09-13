part of '../character_data_endpoint.dart';

Future<_SpellSlotData> _resolveSpellSlots(
  Session session,
  List<CharacterClassEntryData> entries, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  var standardCasterLevel = 0;
  var highestPactLevel = 0;
  final standardEntries = [
    for (final entry in entries)
      if (_isStandardCasterProgression(
          entry.classData?.spellcastingProgression))
        entry,
  ];
  final useSingleClassRounding = standardEntries.length == 1;

  for (final entry in entries) {
    final classData = entry.classData;
    final level = entry.level ?? 0;
    final progression = classData?.spellcastingProgression;
    if (progression == null || level <= 0) {
      continue;
    }

    switch (progression) {
      case SpellcastingProgression.full:
        standardCasterLevel += level;
        break;
      case SpellcastingProgression.half:
        standardCasterLevel +=
            useSingleClassRounding ? ((level + 1) ~/ 2) : (level ~/ 2);
        break;
      case SpellcastingProgression.third:
        standardCasterLevel +=
            useSingleClassRounding ? ((level + 2) ~/ 3) : (level ~/ 3);
        break;
      case SpellcastingProgression.pactMagic:
        highestPactLevel = max(highestPactLevel, level);
        break;
      case SpellcastingProgression.none:
        break;
    }
  }

  final spellSlots = await _spellSlotsForProgressionLevel(
    session,
    _standardSpellSlotTableKey,
    min(20, standardCasterLevel),
    transaction: transaction,
    resolveContext: context,
  );
  final pactSlots = await _spellSlotsForProgressionLevel(
    session,
    _pactMagicSpellSlotTableKey,
    min(20, highestPactLevel),
    transaction: transaction,
    resolveContext: context,
  );

  return _SpellSlotData(
    spellSlots: spellSlots,
    pactSlots: pactSlots,
  );
}

bool _isStandardCasterProgression(SpellcastingProgression? progression) {
  return progression == SpellcastingProgression.full ||
      progression == SpellcastingProgression.half ||
      progression == SpellcastingProgression.third;
}

Future<Map<int, int>?> _spellSlotsForProgressionLevel(
  Session session,
  String tableKey,
  int level, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  if (level <= 0) {
    return null;
  }
  final row = await (resolveContext ?? _CharacterResolveContext(session))
      .spellSlotProgression(
    tableKey,
    level,
    transaction: transaction,
  );
  if (row == null) {
    return null;
  }
  return _nonZeroSpellSlots(row.spellSlots);
}

Map<int, int>? _nonZeroSpellSlots(Map<int, int>? slots) {
  final result = <int, int>{};
  for (final entry in slots?.entries ?? const Iterable.empty()) {
    if (entry.key > 0 && entry.value > 0) {
      result[entry.key] = entry.value;
    }
  }
  return result.isEmpty ? null : result;
}

class _SpellSlotData {
  final Map<int, int>? spellSlots;
  final Map<int, int>? pactSlots;

  const _SpellSlotData({
    required this.spellSlots,
    required this.pactSlots,
  });
}
