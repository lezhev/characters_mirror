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
      selections.removeAt(index);
    } else {
      added[choice.kind] = (added[choice.kind] ?? 0) + 1;
    }
    if (selections.any((s) =>
        s.classEntry?.id == entry.id &&
        s.kind == choice.kind &&
        (s.spellId == spell.id ||
            s.spellKey == spell.referenceKey && spell.referenceKey != null))) {
      throw InputValidationException(
          'spells', 'This spell is already selected.');
    }
    selections.add(CharacterSpellSelectionData(
        id: _generateSyncId(),
        classEntry: entry,
        classDataId: entry.classData!.id,
        spellId: spell.id,
        spellKey: spell.referenceKey,
        kind: choice.kind,
        selectionIndex: selections.length));
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
