import 'spell_source_context.dart';
import 'spell_protocol_values.dart';

enum SpellSlotSource { none, standard, pact }

class SpellCastContext {
  const SpellCastContext(
      {required this.spellKey,
      required this.source,
      required this.baseSpellLevel,
      required this.castLevel,
      required this.slotSource});
  final String spellKey;
  final SpellSourceContext source;
  final int baseSpellLevel;
  final int castLevel;
  final SpellSlotSource slotSource;
  String? get castingAbility => source.castingAbility;
  Map<String, dynamic> toActionJson() => {
        'spellKey': spellKey,
        'spellSourceKey': source.sourceKey,
        'level': castLevel,
        'slotSource': slotSource.name
      };
}

class SpellCastFailure implements Exception {
  const SpellCastFailure(this.code, this.message);
  final String code;
  final String message;
  @override
  String toString() => message;
}

class SpellSlotPools {
  const SpellSlotPools(
      {required this.standardMax,
      required this.pactMax,
      required this.standardCurrent,
      required this.pactCurrent});
  final Map<int, int> standardMax;
  final Map<int, int> pactMax;
  final Map<int, int> standardCurrent;
  final Map<int, int> pactCurrent;

  factory SpellSlotPools.fromCharacter(Map<String, dynamic> character) {
    final derived = character['derived'] as Map? ?? {};
    final standard = _intMap(derived['spellSlots']);
    final pact = _intMap(derived['pactSlots']);
    final stored = _intMap(character['currentSpellSlots']);
    final pactStored = _intMap(character['currentPactSlots']);
    final currentStandard = <int, int>{};
    final currentPact = <int, int>{};
    for (final level in {...standard.keys, ...pact.keys}) {
      final s = standard[level] ?? 0;
      final p = pact[level] ?? 0;
      if (character['currentPactSlots'] == null && p > 0) {
        // Legacy counters were a combined pool. Its spending origin is lost.
        // Split deterministically, preserving the total remaining count.
        final combined = (stored[level] ?? s + p).clamp(0, s + p);
        currentStandard[level] = combined.clamp(0, s);
        currentPact[level] = (combined - currentStandard[level]!).clamp(0, p);
      } else {
        currentStandard[level] = (stored[level] ?? s).clamp(0, s);
        currentPact[level] = (pactStored[level] ?? p).clamp(0, p);
      }
    }
    return SpellSlotPools(
        standardMax: standard,
        pactMax: pact,
        standardCurrent: currentStandard,
        pactCurrent: currentPact);
  }

  int maximum(SpellSlotSource source, int level) => switch (source) {
        SpellSlotSource.standard => standardMax[level] ?? 0,
        SpellSlotSource.pact => pactMax[level] ?? 0,
        SpellSlotSource.none => 0,
      };
  int available(SpellSlotSource source, int level) => switch (source) {
        SpellSlotSource.standard => standardCurrent[level] ?? 0,
        SpellSlotSource.pact => pactCurrent[level] ?? 0,
        SpellSlotSource.none => 0,
      };

  Map<String, dynamic> adjusted(SpellSlotSource source, int level, int delta) {
    final max = maximum(source, level);
    final next = available(source, level) + delta;
    if (level < 1 || level > 9 || source == SpellSlotSource.none || max <= 0) {
      throw const SpellCastFailure(
          'target_not_found', 'The requested spell slot does not exist.');
    }
    if (next < 0)
      throw const SpellCastFailure(
          'insufficient_resource', 'Not enough spell slots are available.');
    if (next > max)
      throw const SpellCastFailure('resource_bounds',
          'Spell slot adjustment exceeds the canonical maximum.');
    final standard = {...standardCurrent};
    final pact = {...pactCurrent};
    (source == SpellSlotSource.pact ? pact : standard)[level] = next;
    return _patch(standard, pact);
  }

  Map<String, dynamic> get materialized => _patch(standardCurrent, pactCurrent);
  Map<String, dynamic> _patch(Map<int, int> standard, Map<int, int> pact) {
    final sparse = {
      for (final e in standardMax.entries)
        if ((standard[e.key] ?? e.value) != e.value) '${e.key}': standard[e.key]
    };
    // A non-null pact map marks counters as separated, even after a rest.
    return {
      'currentSpellSlots': sparse.isEmpty ? null : sparse,
      'currentPactSlots': pactMax.isEmpty
          ? null
          : {
              for (final e in pactMax.entries)
                '${e.key}': pact[e.key] ?? e.value
            }
    };
  }
}

List<SpellCastContext> availableSpellCasts(String spellKey, int baseLevel,
    List<SpellSourceContext> sources, SpellSlotPools pools) {
  final result = <SpellCastContext>[];
  for (final source in sources) {
    if (!source.prepared && !source.alwaysPrepared) continue;
    if (baseLevel == 0) {
      if (source.freeCastsFormula != null || source.freeCastsPerRest != null)
        continue;
      result.add(SpellCastContext(
          spellKey: spellKey,
          source: source,
          baseSpellLevel: 0,
          castLevel: 0,
          slotSource: SpellSlotSource.none));
    } else if (source.canUseSlots) {
      for (final pool in [SpellSlotSource.standard, SpellSlotSource.pact]) {
        for (var level = baseLevel; level <= 9; level++) {
          if (pools.available(pool, level) > 0)
            result.add(SpellCastContext(
                spellKey: spellKey,
                source: source,
                baseSpellLevel: baseLevel,
                castLevel: level,
                slotSource: pool));
        }
      }
    }
  }
  return result;
}

/// Returns only resource/concentration changes, never effects on HP or targets.
Map<String, dynamic> applySpellCast(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  final key = action['spellKey'];
  final sourceKey = action['spellSourceKey'];
  final level = action['level'] as int?;
  final source = SpellSlotSource.values
      .where((s) => s.name == action['slotSource'])
      .firstOrNull;
  if (key is! String ||
      key.isEmpty ||
      sourceKey is! String ||
      sourceKey.isEmpty ||
      level == null ||
      level < 0 ||
      level > 9 ||
      source == null) {
    throw const SpellCastFailure('invalid_action',
        'Cast action requires spell, source, level and slot source.');
  }
  final rows = (character['derived'] as Map?)?['resolvedSpells'] as List? ?? [];
  final entry =
      rows.whereType<Map>().where((e) => e['spellKey'] == key).firstOrNull;
  if (entry == null)
    throw const SpellCastFailure(
        'target_not_found', 'The spell is not available to this character.');
  final spell = entry['spell'] as Map;
  final sources = (entry['sources'] as List)
      .cast<Map>()
      .map((s) => SpellSourceContext.fromJson(s.cast<String, dynamic>()))
      .toList();
  final baseLevel = spell['level'] as int? ?? 0;
  final pools = SpellSlotPools.fromCharacter(character);
  final choices = availableSpellCasts(key, baseLevel, sources, pools);
  if (!choices.any((c) =>
      c.source.sourceKey == sourceKey &&
      c.castLevel == level &&
      c.slotSource == source)) {
    throw const SpellCastFailure(
        'invalid_cast', 'The selected source or spell slot is not available.');
  }
  final patch = source == SpellSlotSource.none
      ? <String, dynamic>{}
      : pools.adjusted(source, level, -1);
  patch['activeConcentrationSpellName'] = spell['concentration'] == true
      ? spell['name'] ?? key
      : character['activeConcentrationSpellName'];
  return patch;
}

Map<int, int> _intMap(dynamic value) => spellProtocolIntMap<int>(value);

SpellSlotSource spellActionSlotSource(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  if (action['slotSource'] != null) {
    final source = SpellSlotSource.values
        .where((s) => s.name == action['slotSource'])
        .firstOrNull;
    if (source == null)
      throw const SpellCastFailure('invalid_action', 'Unknown slot source.');
    return source;
  }
  final pools = SpellSlotPools.fromCharacter(character);
  final level = action['level'] as int? ?? 0;
  return pools.maximum(SpellSlotSource.standard, level) == 0 &&
          pools.maximum(SpellSlotSource.pact, level) > 0
      ? SpellSlotSource.pact
      : SpellSlotSource.standard;
}

bool spellCastStartsConcentration(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  if (action['spellKey'] == null) return action['startsConcentration'] == true;
  final rows = (character['derived'] as Map?)?['resolvedSpells'] as List? ?? [];
  final spell = rows
      .whereType<Map>()
      .where((r) => r['spellKey'] == action['spellKey'])
      .firstOrNull?['spell'] as Map?;
  return spell?['concentration'] == true;
}

List<String> spellSlotActionTargetKeys(
    Map<String, dynamic> character, Map<String, dynamic> action) {
  final pools = SpellSlotPools.fromCharacter(character);
  final source = spellActionSlotSource(character, action);
  if ((action['level'] as int? ?? 0) <= 0 || source == SpellSlotSource.none)
    return [];
  if (character['currentPactSlots'] == null && pools.pactMax.isNotEmpty) {
    return [
      for (final level in {
        ...pools.standardMax.keys,
        ..._intMap(character['currentSpellSlots']).keys
      })
        'map:currentSpellSlots:$level',
      for (final level in pools.pactMax.keys) 'map:currentPactSlots:$level'
    ];
  }
  return [
    'map:${source == SpellSlotSource.pact ? 'currentPactSlots' : 'currentSpellSlots'}:${action['level']}'
  ];
}
