import 'spell_source_context.dart';

/// Inputs must be canonical reference rows and currently eligible choices.
/// No persisted selections are synthesized for grants.
List<ResolvedCharacterSpell> resolveCharacterSpellCollection({
  required Map<String, dynamic> character,
  required Iterable<Map<String, dynamic>> spells,
  Iterable<Map<String, dynamic>> classGrants = const [],
  Iterable<Map<String, dynamic>> classFeatures = const [],
  Iterable<Map<String, dynamic>> subclassFeatures = const [],
  Iterable<Map<String, dynamic>> selectedOptions = const [],
  Iterable<Map<String, dynamic>> choiceGroups = const [],
}) {
  final entries = _rows(character['classEntries']);
  final classLevelsTotal =
      entries.fold<int>(0, (sum, e) => sum + (e['level'] as int? ?? 0));
  final totalLevel = classLevelsTotal < 1 ? 1 : classLevelsTotal;
  final options = selectedOptions.toList();
  final selectedIds = options.map((o) => o['id']).whereType<int>().toSet();
  final groups = {for (final g in choiceGroups) g['id']: g};
  final catalog = {
    for (final s in spells)
      if (_key(s['referenceKey']) != null) _key(s['referenceKey'])!: s
  };
  final catalogById = {
    for (final s in catalog.values)
      if (s['id'] != null) s['id']: s
  };
  Map<String, dynamic> referenceSpell(Map<String, dynamic> row) {
    final embedded = _map(row['spell']);
    final id = row['spellId'] ?? embedded['id'];
    final key = _key(row['spellKey']) ??
        _key(row['spellReferenceKey']) ??
        _key(embedded['referenceKey']);
    return catalogById[id] ?? catalog[key] ?? embedded;
  }

  final records = <String, Map<String, SpellSourceContext>>{};
  final always =
      (character['derived'] as Map?)?['alwaysPreparedSpellKeys'] as List? ?? [];
  final selections = _rows(character['spellSelections']);
  final rawPrepared = character['preparedSpellKeys'] as List?;
  final prepared = rawPrepared == null
      ? null
      : <dynamic>{
          ...rawPrepared,
          for (final s in selections)
            if (rawPrepared.contains(s['spellKey']) &&
                _key(referenceSpell(s)['referenceKey']) != null)
              _key(referenceSpell(s)['referenceKey'])!,
        };
  final hasPreparedSelections =
      selections.any((s) => s['kind'] == 'preparedSpell');

  Map<String, dynamic>? entryFor(
      {int? classId, int? subclassId, String? entryId}) {
    return entries
        .where((e) =>
            (entryId != null && e['id'] == entryId) ||
            (classId != null &&
                (_map(e['classData'])['id'] ?? e['classDataId']) == classId) ||
            (subclassId != null &&
                (_map(e['subclass'])['id'] ?? e['subclassId']) == subclassId))
        .firstOrNull;
  }

  SpellSourceContext classSource(Map<String, dynamic>? entry,
      {bool isPrepared = true, bool isAlways = false, bool granted = false}) {
    final data = _castingFields(entry);
    final ability = data['spellcastingAbilityValue'];
    final id = data['id'] as int? ?? entry?['classDataId'] as int?;
    return SpellSourceContext(
        sourceKey: id == null ? 'legacy' : 'class:$id',
        label: _key(data['name']) ?? 'Класс',
        classDataId: id,
        castingAbility: ability as String?,
        prepared: isPrepared || isAlways,
        alwaysPrepared: isAlways,
        granted: granted);
  }

  void add(String? key, SpellSourceContext source,
      [Map<String, dynamic>? spell]) {
    if (key == null) return;
    if (spell != null && !catalog.containsKey(key)) catalog[key] = spell;
    if (spell?['id'] != null)
      catalogById.putIfAbsent(spell!['id'], () => spell);
    if (!catalog.containsKey(key)) return;
    final sources = records.putIfAbsent(key, () => {});
    final old = sources[source.sourceKey];
    sources[source.sourceKey] = old == null
        ? source
        : SpellSourceContext(
            sourceKey: source.sourceKey,
            label: source.label,
            classDataId: source.classDataId,
            castingAbility: source.castingAbility ?? old.castingAbility,
            known: source.known || old.known,
            prepared: source.prepared || old.prepared,
            alwaysPrepared: source.alwaysPrepared || old.alwaysPrepared,
            granted: source.granted || old.granted,
            canUseSlots: source.canUseSlots || old.canUseSlots,
            castAtSpellLevel: source.castAtSpellLevel ?? old.castAtSpellLevel,
            freeCastsFormula: source.freeCastsFormula ?? old.freeCastsFormula,
            freeCastsPerRest: source.freeCastsPerRest ?? old.freeCastsPerRest);
  }

  for (final selection in selections) {
    final spell = referenceSpell(selection);
    final key = _key(spell['referenceKey']) ?? _key(selection['spellKey']);
    final classId = selection['classDataId'] as int? ??
        _map(_map(selection['classEntry'])['classData'])['id'] as int?;
    var entry =
        entryFor(entryId: _map(selection['classEntry'])['id'] as String?) ??
            entryFor(classId: classId);
    if (classId != null && entry == null) continue;
    if (entry == null &&
        entries.isEmpty &&
        _map(selection['classEntry']).isNotEmpty)
      entry = _map(selection['classEntry']);
    // Old records may lack attribution. Only a single caster is unambiguous.
    final casters = entries
        .where((e) => _castingFields(e)['spellcastingAbilityValue'] != null)
        .toList();
    if (entry == null && classId == null && casters.length == 1)
      entry = casters.single;
    final mode = _castingFields(entry)['spellSelectionMode'];
    final kind = selection['kind'];
    final needsPreparation = mode == 'prepared' ||
        mode == 'spellbook' ||
        kind == 'preparedSpell' ||
        kind == 'spellbookSpell' ||
        (mode == null && (prepared != null || hasPreparedSelections));
    final isPrepared = (spell['level'] as int? ?? 0) == 0 ||
        !needsPreparation ||
        (hasPreparedSelections
            ? kind == 'preparedSpell' &&
                (prepared == null || prepared.contains(key))
            : prepared == null
                ? kind == 'preparedSpell'
                : prepared.contains(key));
    add(
        key,
        classSource(entry,
            isPrepared: isPrepared, isAlways: always.contains(key)),
        spell.isEmpty ? null : spell);
  }
  final features = <Map<String, dynamic>>[];
  final featureEntries = <String, Map<String, dynamic>>{};
  for (final f in classFeatures) {
    final entry = entryFor(classId: f['parentClassId'] as int?);
    if (entry != null &&
        (entry['level'] as int? ?? 0) >= (f['level'] as int? ?? 1)) {
      features.add(f);
      featureEntries['feature:${f['id']}'] = entry;
    }
  }
  for (final f in subclassFeatures) {
    final entry = entryFor(subclassId: f['parentSubclassId'] as int?);
    if (entry != null &&
        (entry['level'] as int? ?? 0) >= (f['level'] as int? ?? 1)) {
      features.add(f);
      featureEntries['subclassFeature:${f['id']}'] = entry;
    }
  }
  Map<String, dynamic>? sourceEntry(Map<String, dynamic> row) =>
      entryFor(
          classId: row['sourceClassId'] as int? ??
              _map(row['sourceClass'])['id'] as int?,
          subclassId: row['sourceSubclassId'] as int? ??
              _map(row['sourceSubclass'])['id'] as int?) ??
      featureEntries[
          'feature:${row['sourceFeatureId'] ?? _map(row['sourceFeature'])['id']}'] ??
      featureEntries[
          'subclassFeature:${row['sourceSubclassFeatureId'] ?? _map(row['sourceSubclassFeature'])['id']}'];
  for (final grant in classGrants) {
    final entry = sourceEntry(grant);
    if (entry == null ||
        (entry['level'] as int? ?? 0) <
            (grant['grantedAtLevel'] as int? ?? 1) ||
        (grant['choiceOptionId'] != null &&
            !selectedIds.contains(grant['choiceOptionId']))) continue;
    final spell = referenceSpell(grant);
    add(
        _key(spell['referenceKey']) ?? _key(grant['spellReferenceKey']),
        classSource(entry,
            isAlways: grant['alwaysPrepared'] == true, granted: true),
        spell.isEmpty ? null : spell);
  }
  for (final feature in features) {
    final entry = feature.containsKey('parentClassId')
        ? entryFor(classId: feature['parentClassId'] as int?)
        : entryFor(subclassId: feature['parentSubclassId'] as int?);
    for (final key in feature['grantedSpellKeys'] as List? ?? []) {
      add(_key(key), classSource(entry, granted: true));
    }
  }
  for (final option in options) {
    final group =
        groups[option['choiceGroupId']] ?? _map(option['choiceGroup']);
    final entry = sourceEntry(group);
    for (final key in option['grantedSpellKeys'] as List? ?? []) {
      add(
          _key(key),
          entry != null
              ? classSource(entry, granted: true)
              : SpellSourceContext(
                  sourceKey: 'choice:${option['id']}',
                  label: _key(option['name']) ?? 'Выбор',
                  granted: true,
                  canUseSlots: false));
    }
  }
  for (final race in [_map(character['race']), _map(character['subrace'])]) {
    for (final feature in _rows(race['features'])) {
      if ((feature['level'] as int? ?? 1) > totalLevel) continue;
      for (final grant in _rows(feature['spellGrants'])) {
        if ((grant['grantedAtLevel'] as int? ?? 1) > totalLevel) continue;
        final spell = referenceSpell(grant);
        final key = _key(spell['referenceKey']);
        if (key == null) continue;
        add(
            key,
            SpellSourceContext(
                sourceKey: 'raceFeature:${feature['id']}:$key',
                label: _key(feature['name']) ?? _key(race['name']) ?? 'Раса',
                castingAbility: grant['castingAbility'] as String?,
                granted: true,
                canUseSlots: grant['canAlsoCastWithSpellSlots'] == true,
                castAtSpellLevel: grant['castAtSpellLevel'] as int?,
                freeCastsFormula: grant['freeCastsFormula'] as String?,
                freeCastsPerRest: grant['freeCastsPerRest'] as String?),
            spell);
      }
    }
  }
  int sourceRank(SpellSourceContext source) {
    final entry = entryFor(classId: source.classDataId);
    return entry == null
        ? entries.length + 100
        : entry['classOrder'] as int? ?? entries.indexOf(entry);
  }

  final result = <ResolvedCharacterSpell>[];
  for (final e in records.entries) {
    final sources = e.value.values.toList()
      ..sort((a, b) {
        final order = sourceRank(a).compareTo(sourceRank(b));
        return order != 0 ? order : a.sourceKey.compareTo(b.sourceKey);
      });
    result.add(ResolvedCharacterSpell(
        spellKey: e.key,
        spell: catalog[e.key]!,
        sources: List.unmodifiable(sources)));
  }
  result.sort((a, b) {
    final level = (a.spell['level'] as int? ?? 0)
        .compareTo(b.spell['level'] as int? ?? 0);
    return level != 0
        ? level
        : '${a.spell['name'] ?? a.spellKey}'
            .compareTo('${b.spell['name'] ?? b.spellKey}');
  });
  return result;
}

Map<String, dynamic> _map(dynamic value) =>
    value is Map ? value.cast<String, dynamic>() : {};
List<Map<String, dynamic>> _rows(dynamic value) => value is List
    ? value.whereType<Map>().map((v) => v.cast<String, dynamic>()).toList()
    : [];
String? _key(dynamic value) =>
    value is String && value.trim().isNotEmpty ? value.trim() : null;

Map<String, dynamic> _castingFields(Map<String, dynamic>? entry) {
  final data = _map(entry?['classData']);
  final subclass = _map(entry?['subclass']);
  final level = entry?['level'] as int? ?? 0;
  final active = subclass.isNotEmpty &&
      subclass['parentClassId'] == data['id'] &&
      level >= (subclass['levelRequired'] as int? ?? 1) &&
      level >=
          (subclass['spellcastingStartLevel'] as int? ??
              subclass['levelRequired'] as int? ??
              1);
  return {
    ...data,
    if (active) ...{
      for (final key in ['spellcastingAbilityValue', 'spellSelectionMode'])
        if (subclass[key] != null) key: subclass[key],
    }
  };
}
