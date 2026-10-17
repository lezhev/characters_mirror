part of '../character_data_endpoint.dart';

Future<CharacterData> _stampNewSpellSelectionProvenance(
    Session session, CharacterData character,
    {Transaction? transaction}) async {
  final selections = [...?character.spellSelections];
  if (selections.isEmpty) return character;
  final storedIds = character.id == null
      ? <String>{}
      : (await CharacterSpellSelectionRecord.db.find(session,
              where: (row) => row.characterId.equals(character.id),
              transaction: transaction))
          .map((record) => record.syncId)
          .whereType<String>()
          .toSet();
  var changed = false;
  for (final entry
      in character.classEntries ?? const <CharacterClassEntryData>[]) {
    final classId = entry.classData?.id;
    if (classId == null) continue;
    final step = await ClassDataEndpoint().getStepView(
      session,
      classId,
      selectedLevel: entry.level ?? 1,
      selectedSubclassId: entry.subclass?.id,
    );
    for (var i = 0; i < selections.length; i++) {
      final selection = selections[i];
      final belongs = selection.classEntry?.id != null
          ? selection.classEntry?.id == entry.id
          : (selection.classDataId ?? selection.classEntry?.classData?.id) ==
              classId;
      if (!belongs || storedIds.contains(selection.id)) continue;
      final kind = selection.kind;
      if (kind == null) continue;
      final group = step.spellSelectionGroups
          ?.where((candidate) => candidate.kind == kind)
          .firstOrNull;
      final spellId = selection.spellId ?? selection.spell?.id;
      final spell = group?.options
          ?.where((candidate) => spellId != null
              ? candidate.id == spellId
              : candidate.referenceKey == selection.spellKey)
          .firstOrNull;
      final filter = group?.selectionFilter?.toJson();
      if (spell == null ||
          !spellMatchesSelectionFilter(spell.toJson(), filter,
              kind: kind.name, unrestricted: true)) {
        continue;
      }
      final inferred = spellSelectionProvenance(
        spell.toJson(),
        filter,
        kind: kind.name,
        level: entry.level ?? group?.classLevel ?? 1,
      );
      selections[i] = selection.copyWith(
        selectionFilter: selection.selectionFilter ?? group?.selectionFilter,
        selectionRuleLevel:
            selection.selectionRuleLevel ?? group?.classLevel ?? entry.level,
        selectionUnrestricted: selection.selectionUnrestricted ??
            inferred['selectionUnrestricted'] as bool,
      );
      changed = true;
    }
  }
  return changed ? character.copyWith(spellSelections: selections) : character;
}

Future<void> _validateSpellSelectionFilters(
    Session session, CharacterData character,
    {Transaction? transaction, bool allowSpellReplacements = false}) async {
  final stored = character.id == null
      ? const <String, CharacterSpellSelectionRecord>{}
      : {
          for (final record in await CharacterSpellSelectionRecord.db.find(
              session,
              where: (row) => row.characterId.equals(character.id),
              include: CharacterSpellSelectionRecord.include(
                  classEntry: CharacterClassEntryRecord.include()),
              transaction: transaction))
            if (record.syncId != null) record.syncId!: record,
        };
  for (final selection
      in character.spellSelections ?? const <CharacterSpellSelectionData>[]) {
    _validateStoredSpellSelection(selection, stored[selection.id],
        allowSpellReplacements: allowSpellReplacements);
  }
  for (final entry in character.classEntries ?? <CharacterClassEntryData>[]) {
    final classId = entry.classData?.id;
    if (classId == null) continue;
    final data =
        await ClassData.db.findById(session, classId, transaction: transaction);
    final subclassId = entry.subclass?.id;
    final subclass = subclassId == null
        ? null
        : await SubclassData.db
            .findById(session, subclassId, transaction: transaction);
    if (data == null) continue;
    final effective =
        effectiveSpellcastingClass(data, subclass, entry.level ?? 1);
    final effectiveFilter = effective.spellSelectionFilter?.toJson();
    final sources = await _resolveDerivedSources(
        session, character, character.choices ?? <CharacterChoiceData>[],
        transaction: transaction);
    final step = await ClassDataEndpoint().getStepView(session, classId,
        selectedLevel: entry.level ?? 1,
        selectedSubclassId: subclassId,
        abilityScores: _buildAbilityScores(character, sources.selectedOptions));
    for (final kind in CharacterSpellSelectionKind.values) {
      final selections = (character.spellSelections ??
              <CharacterSpellSelectionData>[])
          .where((s) =>
              s.kind == kind &&
              (s.classEntry?.id != null
                  ? s.classEntry?.id == entry.id
                  : (s.classDataId ?? s.classEntry?.classData?.id) == classId))
          .where((selection) {
        final persisted = stored[selection.id];
        final active = isSpellSelectionActive(selection.toJson(),
            [entry.copyWith(classData: data, subclass: subclass).toJson()]);
        if (!active &&
            (persisted == null ||
                selection.selectionIndex != persisted.selectionIndex)) {
          throw InputValidationException('spellSelections',
              'Inactive spell selections must retain their stored identity.');
        }
        return active;
      }).toList();
      if (selections.isEmpty) continue;
      final group =
          step.spellSelectionGroups?.where((g) => g.kind == kind).firstOrNull;
      if (group == null || selections.length > (group.selectionCount ?? 0)) {
        throw InputValidationException(
            'spellSelections', 'Spell selection exceeds canonical limit.');
      }
      final spells = <Map<String, dynamic>>[];
      for (final selection in selections) {
        final id = selection.spellId ?? selection.spell?.id;
        final spell = group.options
            ?.where((s) =>
                id != null ? s.id == id : s.referenceKey == selection.spellKey)
            .firstOrNull;
        if (spell == null ||
            selection.spellKey != null &&
                selection.spellKey != spell.referenceKey ||
            selection.classEntry?.id != null &&
                selection.classEntry?.id != entry.id ||
            selection.classDataId != null && selection.classDataId != classId) {
          throw InputValidationException('spellSelections',
              'Spell is outside the canonical selection pool.');
        }
        final persisted = stored[selection.id];
        final origin =
            selection.selectionUnrestricted ?? persisted?.selectionUnrestricted;
        if (origin == true &&
            persisted == null &&
            spellMatchesSelectionFilter(spell.toJson(), effectiveFilter,
                kind: kind.name)) {
          throw InputValidationException('spellSelections',
              'A new unrestricted slot must use a spell outside its restricted schools.');
        }
        if (selection.selectionFilter != null &&
            persisted == null &&
            _spellProvenanceJson(selection.selectionFilter!.toJson()) !=
                _spellProvenanceJson(
                    effectiveFilter ?? SpellSelectionFilterData().toJson())) {
          throw InputValidationException(
              'spellSelections', 'Spell selection rule is not canonical.');
        }
        if (selection.selectionRuleLevel != null &&
            persisted == null &&
            selection.selectionRuleLevel != (entry.level ?? 1)) {
          throw InputValidationException(
              'spellSelections', 'Spell selection level is not canonical.');
        }
        spells.add({
          ...spell.toJson(),
          'selectionUnrestricted': ?origin,
        });
      }
      if (!spellSelectionsMatchFilter(spells, effectiveFilter,
          kind: kind.name, level: entry.level ?? 1)) {
        throw InputValidationException('spellSelections',
            'Spell selections exceed the unrestricted quota or filter.');
      }
    }
  }
}

void _validateStoredSpellSelection(CharacterSpellSelectionData selection,
    CharacterSpellSelectionRecord? persisted,
    {required bool allowSpellReplacements}) {
  if (persisted == null) return;
  final changedSpell =
      (selection.spellId ?? selection.spell?.id) != persisted.spellId ||
          selection.spellKey != persisted.spellKey;
  if (changedSpell && !allowSpellReplacements) {
    throw InputValidationException('spellSelections',
        'Known spells can only be changed by a level-up replacement.');
  }
  if (persisted.selectionRuleLevel != null) {
    if (selection.selectionRuleLevel != null &&
        selection.selectionRuleLevel != persisted.selectionRuleLevel) {
      throw InputValidationException(
          'spellSelections', 'Spell selection level cannot change.');
    }
  } else if (selection.selectionRuleLevel != null && !allowSpellReplacements) {
    throw InputValidationException(
        'spellSelections', 'Spell selection level cannot change.');
  }
  if (persisted.classDataId != null || persisted.classEntryId != null) {
    final entryId = selection.classEntry?.id;
    final classId = selection.classDataId ??
        selection.classEntry?.classData?.id ??
        (entryId == persisted.classEntry?.syncId
            ? persisted.classDataId
            : null);
    if (selection.kind != persisted.kind ||
        classId !=
            (persisted.classDataId ?? persisted.classEntry?.classDataId) ||
        (entryId != null && entryId != persisted.classEntry?.syncId)) {
      throw InputValidationException(
          'spellSelections', 'Spell selection attribution cannot change.');
    }
  }
  if (persisted.selectionUnrestricted != null &&
      selection.selectionUnrestricted != null &&
      persisted.selectionUnrestricted != selection.selectionUnrestricted) {
    throw InputValidationException(
        'spellSelections', 'Spell selection origin cannot change.');
  }
  if (!allowSpellReplacements &&
      selection.selectionFilter != null &&
      _spellProvenanceJson(selection.selectionFilter?.toJson()) !=
          _spellProvenanceJson(persisted.selectionFilter?.toJson())) {
    throw InputValidationException(
        'spellSelections', 'Spell selection rule cannot change.');
  }
  if (!allowSpellReplacements &&
      selection.spellReplacementHistory != null &&
      _spellProvenanceJson(selection.spellReplacementHistory
              ?.map((h) => h.toJson())
              .toList()) !=
          _spellProvenanceJson(persisted.spellReplacementHistory
              ?.map((h) => h.toJson())
              .toList())) {
    throw InputValidationException(
        'spellSelections', 'Spell replacement history cannot change.');
  }
}

String? _spellProvenanceJson(dynamic value) =>
    value == null ? null : jsonEncode(value);
