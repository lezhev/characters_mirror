import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'spellcasting_source.dart';

String? selectionSpellKey(CharacterSpellSelectionData selection) =>
    _text(selection.spellKey) ?? spellReferenceKey(selection.spell);

String? spellReferenceKey(SpellData? spell) =>
    _text(spell?.referenceKey) ?? _text(spell?.name);

String? _text(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

ClassData? spellcastingClassForEntry(CharacterClassEntryData? entry) =>
    entry?.classData == null
        ? null
        : effectiveSpellcastingClass(
            entry!.classData!, entry.subclass, entry.level ?? 0);

ClassSpellSelectionMode spellMode(ClassData? data, [ClassLevelData? row]) =>
    ClassSpellSelectionMode.values.byName(resolveSpellSelectionMode(
        explicitMode: data?.spellSelectionMode?.name,
        legacyFormula: row?.preparedSpellFormula,
        spellcastingAbility: data?.spellcastingAbilityValue?.name,
        hasPreparedRule: row?.preparedSpellRule != null,
        knownSpells: row?.knownSpells,
        knownCantrips: row?.knownCantrips,
        spellbookSpells: row?.spellbookSpells));

int? preparedLimit(ClassLevelData row, Map<String, int> scores) {
  final data = row.preparedSpellRule;
  final rule = data == null
      ? legacyPreparedSpellRule(row.preparedSpellFormula)
      : PreparedSpellRule(
          ability: data.ability.name,
          numerator: data.classLevelNumerator,
          denominator: data.classLevelDenominator,
          rounding: data.rounding.name,
          flatBonus: data.flatBonus,
          minimum: data.minimum);
  return rule?.evaluate(row.level, scores);
}

String selectionIdentity(CharacterSpellSelectionData selection) =>
    spellSelectionIdentity(
        classEntryId: selection.classEntry?.id,
        classDataId:
            selection.classDataId ?? selection.classEntry?.classData?.id,
        kind: selection.kind?.name,
        spellKey: selectionSpellKey(selection) ?? '');

bool selectionBelongsToEntry(
    CharacterSpellSelectionData selection, CharacterClassEntryData entry) {
  if (selection.classEntry?.id != null) {
    return selection.classEntry!.id == entry.id;
  }
  return (selection.classDataId ?? selection.classEntry?.classData?.id) ==
      entry.classData?.id;
}

int nextSpellSelectionIndex(
  Iterable<CharacterSpellSelectionData> selections, {
  required CharacterClassEntryData? classEntry,
  required int? classDataId,
  required CharacterSpellSelectionKind kind,
}) {
  final entryId = classEntry?.id;
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

List<SpellData> draftSpellOptions(ClassSpellSelectionGroupView group,
    List<CharacterSpellSelectionData> selections) {
  final source = group.optionSourceSelectionKind;
  if (source == null) return group.options ?? const [];
  final keys = {
    for (final selection in selections)
      if (selection.kind == source &&
          selection.classDataId == group.classDataId)
        selectionSpellKey(selection),
  };
  return [
    for (final spell in group.options ?? const <SpellData>[])
      if (keys.contains(spellReferenceKey(spell))) spell
  ];
}

/// Normalize independent groups first, then groups whose options depend on them.
List<CharacterSpellSelectionData> normalizeDraftSpells(
    List<CharacterSpellSelectionData> selections,
    List<ClassSpellSelectionGroupView>? groups) {
  final ordered = [...?groups]..sort((a, b) =>
      (a.optionSourceSelectionKind == null ? 0 : 1)
          .compareTo(b.optionSourceSelectionKind == null ? 0 : 1));
  final result = <CharacterSpellSelectionData>[];
  for (final group in ordered) {
    if (group.kind == null || group.classDataId == null) continue;
    final options = {
      for (final spell in draftSpellOptions(group, result))
        if (spellReferenceKey(spell) != null) spellReferenceKey(spell)!: spell
    };
    final selected = selections
        .where((selection) =>
            selection.classDataId == group.classDataId &&
            selection.kind == group.kind)
        .toList()
      ..sort(
          (a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));
    final seen = <String>{};
    for (final selection in selected) {
      if (seen.length >= (group.selectionCount ?? 1)) break;
      final key = selectionSpellKey(selection);
      final spell = options[key];
      if (key == null || spell == null || !seen.add(key)) continue;
      result.add(selection.copyWith(
          spell: spell,
          spellId: spell.id,
          spellKey: key,
          selectionIndex: seen.length - 1));
    }
  }
  return result;
}

List<SpellData> preparationPoolForEntry(
    CharacterData character,
    CharacterClassEntryData entry,
    ClassLevelData? row,
    List<SpellData> allSpells) {
  final mode = spellMode(spellcastingClassForEntry(entry), row);
  if (mode == ClassSpellSelectionMode.spellbook) {
    return [
      for (final selection
          in character.spellSelections ?? const <CharacterSpellSelectionData>[])
        if (selection.kind == CharacterSpellSelectionKind.spellbookSpell &&
            selectionBelongsToEntry(selection, entry) &&
            (selection.spell?.level ?? 0) > 0)
          selection.spell!
    ];
  }
  if (mode != ClassSpellSelectionMode.prepared) return [];
  return allSpells
      .where((spell) =>
          (spell.level ?? 0) > 0 &&
          (spell.availableForClassIds?.contains(entry.classData?.id) == true ||
              spell.availableForSubclassIds?.contains(entry.subclass?.id) ==
                  true))
      .toList();
}

CharacterClassEntryData? spellEntryForClass(
        CharacterData character, int? classId) =>
    character.classEntries
        ?.where((entry) => entry.classData?.id == classId)
        .firstOrNull;

ClassLevelData? spellLevelForEntry(
        CharacterClassEntryData? entry, List<ClassLevelData> levels) =>
    (entry?.classData == null
            ? <ClassLevelData>[]
            : effectiveSpellProgression(
                entry!.classData!, entry.subclass, levels))
        .where((row) =>
            row.classDataId == entry?.classData?.id &&
            row.level == (entry?.level ?? 1))
        .firstOrNull;

CharacterSpellSelectionData learnedSpellSelection(
    CharacterData character, SpellData spell, int? classId,
    {ClassLevelData? classLevel}) {
  final entry = spellEntryForClass(character, classId);
  return CharacterSpellSelectionData(
      classEntry: entry,
      classDataId: classId,
      spell: spell,
      spellId: spell.id,
      spellKey: spellReferenceKey(spell),
      kind: (spell.level ?? 0) <= 0
          ? CharacterSpellSelectionKind.knownCantrip
          : spellMode(spellcastingClassForEntry(entry), classLevel) ==
                  ClassSpellSelectionMode.spellbook
              ? CharacterSpellSelectionKind.spellbookSpell
              : CharacterSpellSelectionKind.knownSpell);
}

List<CharacterSpellSelectionData> prepareSpellSelections(
    CharacterData character, SpellData spell, int? classId, bool prepared,
    {ClassLevelData? classLevel}) {
  final selections = [...?character.spellSelections];
  if (!prepared) return selections;
  final entry = spellEntryForClass(character, classId);
  final key = spellReferenceKey(spell);
  if (spellMode(spellcastingClassForEntry(entry), classLevel) ==
          ClassSpellSelectionMode.spellbook &&
      !selections.any((selection) =>
          selection.kind == CharacterSpellSelectionKind.spellbookSpell &&
          entry != null &&
          selectionBelongsToEntry(selection, entry) &&
          selectionSpellKey(selection) == key)) {
    throw StateError(
        'Spell must be in this class entry spellbook before preparation.');
  }
  final selection = CharacterSpellSelectionData(
      classEntry: entry,
      classDataId: classId,
      spell: spell,
      spellId: spell.id,
      spellKey: key,
      kind: CharacterSpellSelectionKind.preparedSpell);
  if (!selections
      .any((item) => selectionIdentity(item) == selectionIdentity(selection))) {
    selections.add(selection.copyWith(
      selectionIndex: nextSpellSelectionIndex(
        selections,
        classEntry: entry,
        classDataId: classId,
        kind: selection.kind!,
      ),
    ));
  }
  return selections;
}

List<CharacterSpellSelectionData> forgetSpellSelections(
    CharacterData character, SpellData spell, int? classId) {
  final entry = spellEntryForClass(character, classId);
  final key = spellReferenceKey(spell);
  return [
    for (final selection
        in character.spellSelections ?? const <CharacterSpellSelectionData>[])
      if (selectionSpellKey(selection) != key ||
          (entry != null
              ? !selectionBelongsToEntry(selection, entry)
              : selection.classDataId != classId))
        selection
  ];
}
