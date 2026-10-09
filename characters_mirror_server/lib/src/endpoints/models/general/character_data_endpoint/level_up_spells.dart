part of '../character_data_endpoint.dart';

List<(CharacterSpellSelectionKind, int)> _levelUpSpellCounts(
        ClassSpellDeltaView delta) =>
    [
      (CharacterSpellSelectionKind.knownCantrip, delta.cantripsToAdd),
      (CharacterSpellSelectionKind.knownSpell, delta.knownSpellsToAdd),
      (CharacterSpellSelectionKind.spellbookSpell, delta.spellbookSpellsToAdd),
    ];

Future<CharacterData> _addLevelUpSpells(
    Session session,
    CharacterData draft,
    CharacterClassEntryData entry,
    ClassStepView step,
    ClassSpellDeltaView delta,
    LevelUpRequest request,
    {Transaction? transaction}) async {
  final selections = [...?draft.spellSelections];
  final added = <CharacterSpellSelectionKind, int>{};
  final replaced = <String>{};
  final selectedIds = <int>{};
  var replacementCount = 0;
  for (final choice in request.spells ?? const <LevelUpSpellChoice>[]) {
    final group = step.spellSelectionGroups
        ?.where((g) => g.kind == choice.kind)
        .firstOrNull;
    final spell =
        group?.options?.where((s) => s.id == choice.spellId).firstOrNull;
    if (spell == null || !selectedIds.add(choice.spellId)) {
      throw InputValidationException(
          'spells', 'Spell is unavailable or selected twice.');
    }
    int? selectionIndex;
    CharacterSpellSelectionData? replacedSelection;
    if (choice.replacesSelectionId != null) {
      final index = selections.indexWhere((s) =>
          s.id == choice.replacesSelectionId &&
          s.classEntry?.id == entry.id &&
          s.kind == CharacterSpellSelectionKind.knownSpell);
      if (choice.kind != CharacterSpellSelectionKind.knownSpell ||
          index < 0 ||
          !replaced.add(choice.replacesSelectionId!) ||
          ++replacementCount > delta.knownSpellReplacements) {
        throw InputValidationException('spells', 'Invalid spell replacement.');
      }
      selectionIndex = selections[index].selectionIndex;
      replacedSelection = selections[index];
      selections.removeAt(index);
    } else {
      added[choice.kind] = (added[choice.kind] ?? 0) + 1;
      selectionIndex = _nextLevelUpSpellSelectionIndex(
        selections,
        entry: entry,
        kind: choice.kind,
      );
    }
    if (selections.any((s) =>
        s.classEntry?.id == entry.id &&
        s.kind == choice.kind &&
        (s.spellId == spell.id ||
            s.spellKey == spell.referenceKey && spell.referenceKey.isNotEmpty))) {
      throw InputValidationException(
          'spells', 'This spell is already selected.');
    }
    if (replacedSelection != null) {
      final replaced = replaceSpellSelection(
        selection: replacedSelection.toJson(),
        replacementSpell: spell.toJson(),
        currentFilter: group?.selectionFilter?.toJson(),
        kind: choice.kind.name,
        currentLevel: step.selectedLevel ?? (entry.level ?? 0) + 1,
      );
      if (replaced == null) {
        throw InputValidationException(
            'spells', 'Replacement violates its original selection rule.');
      }
      selections.add(CharacterSpellSelectionData.fromJson(replaced));
    } else {
      final provenance = spellSelectionProvenance(
        spell.toJson(),
        group?.selectionFilter?.toJson(),
        kind: choice.kind.name,
        level: step.selectedLevel ?? (entry.level ?? 1) + 1,
      );
      selections.add(CharacterSpellSelectionData(
          id: _generateSyncId(),
          classEntry: entry,
          classDataId: entry.classData!.id,
          spellId: spell.id,
          spellKey: spell.referenceKey,
          kind: choice.kind,
          selectionIndex: selectionIndex,
          selectionFilter: SpellSelectionFilterData.fromJson(
              Map<String, dynamic>.from(provenance['selectionFilter'] as Map)),
          selectionRuleLevel: provenance['selectionRuleLevel'] as int,
          selectionUnrestricted:
              provenance['selectionUnrestricted'] as bool));
    }
  }
  final counts = {
    for (final (kind, count) in _levelUpSpellCounts(delta)) kind: count
  };
  for (final e in added.entries) {
    if (e.value > (counts[e.key] ?? 0)) {
      throw InputValidationException('spells', 'Too many new spells.');
    }
  }
  return draft.copyWith(spellSelections: selections);
}

int _nextLevelUpSpellSelectionIndex(
  List<CharacterSpellSelectionData> selections, {
  required CharacterClassEntryData entry,
  required CharacterSpellSelectionKind kind,
}) {
  final entryId = entry.id;
  final classDataId = entry.classData?.id;
  var maxIndex = -1;
  for (final selection in selections) {
    if (selection.kind != kind) continue;
    final selectionEntryId = selection.classEntry?.id;
    final sameSource = entryId != null
        ? selectionEntryId == entryId
        : selectionEntryId == null &&
            (selection.classDataId ?? selection.classEntry?.classData?.id) ==
                classDataId;
    final index = selection.selectionIndex;
    if (sameSource && index != null && index > maxIndex) maxIndex = index;
  }
  return maxIndex + 1;
}
