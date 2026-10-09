import 'spell_protocol_values.dart';

bool spellMatchesSelectionFilter(
    Map<String, dynamic> spell, Map<String, dynamic>? filter,
    {required String kind, bool unrestricted = false}) {
  if (filter == null) return true;
  final kinds = filter['kinds'] as List?;
  if (kinds != null && !kinds.contains(kind)) return true;
  final level = spell['level'] as int? ?? 0;
  if (level < (filter['minimumSpellLevel'] as int? ?? 0) ||
      level > (filter['maximumSpellLevel'] as int? ?? 9)) return false;
  final schools = filter['schools'] as List?;
  return unrestricted ||
      schools == null ||
      schools.isEmpty ||
      schools.contains(spell['schoolValue']);
}

int spellSelectionUnrestrictedCount(Map<String, dynamic>? filter, int level) {
  final progression =
      spellProtocolIntMap<int>(filter?['unrestrictedChoicesByLevel']);
  final rows = [
    for (final e in progression.entries)
      if ((int.tryParse('${e.key}') ?? 21) <= level) e
  ]..sort((a, b) => int.parse('${a.key}').compareTo(int.parse('${b.key}')));
  return (rows.lastOrNull?.value ?? 0).clamp(0, 100);
}

bool spellSelectionsMatchFilter(
    Iterable<Map<String, dynamic>> spells, Map<String, dynamic>? filter,
    {required String kind, required int level}) {
  var unrestricted = 0;
  final seen = <dynamic>{};
  for (final spell in spells) {
    if (!seen.add(spell['id'] ?? spell['referenceKey'])) return false;
    final origin = spell['selectionUnrestricted'];
    if (origin == true) {
      if (!spellMatchesSelectionFilter(spell, filter,
          kind: kind, unrestricted: true)) return false;
      unrestricted++;
    } else if (origin == false) {
      if (!spellMatchesSelectionFilter(spell, filter, kind: kind)) return false;
    } else {
      if (spellMatchesSelectionFilter(spell, filter, kind: kind)) continue;
      if (!spellMatchesSelectionFilter(spell, filter,
              kind: kind, unrestricted: true) ||
          ++unrestricted > spellSelectionUnrestrictedCount(filter, level)) {
        return false;
      }
    }
    if (unrestricted > spellSelectionUnrestrictedCount(filter, level)) {
      return false;
    }
  }
  return true;
}
