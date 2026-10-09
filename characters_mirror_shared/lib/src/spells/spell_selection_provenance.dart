import 'spell_selection_filter.dart';

Map<String, dynamic> spellSelectionProvenance(
  Map<String, dynamic> spell,
  Map<String, dynamic>? filter, {
  required String kind,
  required int level,
}) {
  if (!spellMatchesSelectionFilter(spell, filter,
      kind: kind, unrestricted: true)) {
    throw ArgumentError('Spell is outside the canonical selection filter.');
  }
  final unrestricted =
      !spellMatchesSelectionFilter(spell, filter, kind: kind);
  return {
    'selectionFilter': filter ?? <String, dynamic>{},
    'selectionRuleLevel': level,
    'selectionUnrestricted': unrestricted,
  };
}

/// Replaces a spell in its original slot, retaining that slot's filter and
/// recording enough state for a level-down to restore the prior selection.
Map<String, dynamic>? replaceSpellSelection({
  required Map<String, dynamic> selection,
  required Map<String, dynamic> replacementSpell,
  required Map<String, dynamic>? currentFilter,
  required String kind,
  required int currentLevel,
}) {
  if (!spellMatchesSelectionFilter(replacementSpell, currentFilter,
      kind: kind, unrestricted: true)) return null;

  final priorSpell = _map(selection['spell']);
  final storedFilter = _map(selection['selectionFilter']);
  final priorFilter = storedFilter.isEmpty ? currentFilter : storedFilter;
  var unrestricted = selection['selectionUnrestricted'] as bool?;
  if (unrestricted == null) {
    // Legacy selections outside the restricted school set are unambiguously
    // unrestricted. In-school legacy selections remain unknown and receive
    // the safe restricted replacement rule without acquiring new provenance.
    unrestricted = !spellMatchesSelectionFilter(priorSpell, priorFilter,
        kind: kind);
  }
  if (!unrestricted &&
      !_matchesSelectionSchools(replacementSpell, priorFilter, kind)) {
    return null;
  }

  final priorOrigin = selection['selectionUnrestricted'] as bool?;
  final history = [
    ..._rows(selection['spellReplacementHistory']),
    {
      'spellId': selection['spellId'] ?? priorSpell['id'],
      'spellKey': selection['spellKey'] ?? priorSpell['referenceKey'],
      'selectionFilter': selection['selectionFilter'],
      'selectionRuleLevel': selection['selectionRuleLevel'],
      'selectionUnrestricted': priorOrigin,
      'replacedAtClassLevel': currentLevel,
    }
  ];
  return {
    ...selection,
    'spell': replacementSpell,
    'spellId': replacementSpell['id'],
    'spellKey': replacementSpell['referenceKey'],
    // Preserve ambiguous legacy origin; every subsequent replacement remains
    // restricted until the character's actual origin can be established.
    'selectionUnrestricted': priorOrigin ??
        (spellMatchesSelectionFilter(priorSpell, priorFilter, kind: kind)
            ? null
            : true),
    'selectionFilter':
        selection['selectionFilter'] ?? (unrestricted ? currentFilter : null),
    'selectionRuleLevel': selection['selectionRuleLevel'],
    'spellReplacementHistory': history,
  };
}

List<Map<String, dynamic>> rollbackSpellSelectionReplacements(
  Iterable<Map<String, dynamic>> selections, {
  required String classEntryId,
  required int targetLevel,
}) => [
      for (final selection in selections)
        _rollbackSpellSelection(selection, classEntryId, targetLevel),
    ];

Map<String, dynamic> _rollbackSpellSelection(
    Map<String, dynamic> selection, String classEntryId, int targetLevel) {
  if (_map(selection['classEntry'])['id'] != classEntryId) return selection;
  final history = _rows(selection['spellReplacementHistory']);
  if (history.isEmpty) return selection;
  var next = Map<String, dynamic>.from(selection);
  final remaining = [...history];
  while (remaining.isNotEmpty &&
      (remaining.last['replacedAtClassLevel'] as int) > targetLevel) {
    final previous = remaining.removeLast();
    next = {
      ...next,
      'spell': null,
      'spellId': previous['spellId'],
      'spellKey': previous['spellKey'],
      'selectionFilter': previous['selectionFilter'],
      'selectionRuleLevel': previous['selectionRuleLevel'],
      'selectionUnrestricted': previous['selectionUnrestricted'],
      'spellReplacementHistory': remaining.isEmpty ? null : remaining,
    };
  }
  return next;
}

bool _matchesSelectionSchools(
    Map<String, dynamic> spell, Map<String, dynamic>? filter, String kind) {
  if (filter == null) return true;
  final kinds = filter['kinds'] as List?;
  if (kinds != null && !kinds.contains(kind)) return true;
  final schools = filter['schools'] as List?;
  return schools == null ||
      schools.isEmpty ||
      schools.contains(spell['schoolValue']);
}

Map<String, dynamic> _map(dynamic value) => value is Map
    ? value.map((key, item) => MapEntry('$key', item))
    : <String, dynamic>{};

List<Map<String, dynamic>> _rows(dynamic value) => value is List
    ? value.whereType<Map>().map(_map).toList()
    : <Map<String, dynamic>>[];
