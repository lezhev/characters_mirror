part of '../character_data_endpoint.dart';

Future<void> _upsertCharacterRelations(
  Session session,
  CharacterRecord characterRecord,
  CharacterData character,
) async {
  final entryResult = await _upsertClassEntryRecords(
    session,
    characterRecord,
    character.classEntries ?? const <CharacterClassEntryData>[],
  );
  await _upsertChoiceRecords(
    session,
    characterRecord,
    entryResult.savedEntries,
    character.choices ?? const <CharacterChoiceData>[],
  );
  await _upsertSkillSelectionRecords(
    session,
    characterRecord,
    entryResult.savedEntries,
    character.skillSelections ?? const <CharacterSkillSelectionData>[],
  );
  await _upsertSpellSelectionRecords(
    session,
    characterRecord,
    entryResult.savedEntries,
    character.spellSelections ?? const <CharacterSpellSelectionData>[],
  );
  await _deleteMissingClassEntryRecords(
    session,
    characterRecord.id!,
    entryResult.keepRowIds,
  );
  await _upsertStartingEquipmentSelectionRecords(
    session,
    characterRecord,
    character.startingEquipmentSelections ??
        const <CharacterStartingEquipmentSelectionData>[],
  );
}

class _UpsertClassEntryResult {
  const _UpsertClassEntryResult({
    required this.savedEntries,
    required this.keepRowIds,
  });

  final List<CharacterClassEntryRecord> savedEntries;
  final Set<int> keepRowIds;
}

Future<_UpsertClassEntryResult> _upsertClassEntryRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterClassEntryData> entries,
) async {
  final existingEntries = await CharacterClassEntryRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterRecord.id),
  );
  final existingBySyncId = {
    for (final record in existingEntries)
      if (record.syncId != null) record.syncId!: record,
  };

  final savedEntries = <CharacterClassEntryRecord>[];
  final keepRowIds = <int>{};
  for (final entry in entries) {
    final classDataId = entry.classData?.id;
    if (classDataId == null) {
      throw Exception('Character class entry requires classData.id.');
    }

    final syncId = entry.id ?? _generateSyncId();
    final existingRecord = existingBySyncId[syncId];
    final nextRecord = CharacterClassEntryRecord(
      id: existingRecord?.id,
      syncId: syncId,
      characterId: characterRecord.id!,
      character: characterRecord,
      classDataId: classDataId,
      subclassId: entry.subclass?.id,
      level: entry.level ?? 1,
      isStartingClass: entry.isStartingClass,
      classOrder: entry.classOrder,
      hpMode: entry.hpMode,
      hpRolledValues: entry.hpRolledValues,
      notes: entry.notes,
      updatedAt: entry.updatedAt?.toUtc() ?? characterRecord.updatedAt,
    );
    final saved = existingRecord == null
        ? await CharacterClassEntryRecord.db.insertRow(session, nextRecord)
        : await CharacterClassEntryRecord.db.updateRow(session, nextRecord);
    if (saved.id != null) {
      keepRowIds.add(saved.id!);
    }
    savedEntries.add(saved);
  }

  return _UpsertClassEntryResult(
    savedEntries: savedEntries,
    keepRowIds: keepRowIds,
  );
}

Future<void> _upsertChoiceRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterClassEntryRecord> savedEntries,
  List<CharacterChoiceData> choices,
) async {
  final existingChoices = await CharacterChoiceRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterRecord.id),
  );
  final existingBySyncId = {
    for (final record in existingChoices)
      if (record.syncId != null) record.syncId!: record,
  };
  final savedEntriesBySyncId = {
    for (final entry in savedEntries)
      if (entry.syncId != null) entry.syncId!: entry,
  };

  final keepRowIds = <int>{};
  for (final choice in choices) {
    final syncId = choice.id ?? _generateSyncId();
    final existingRecord = existingBySyncId[syncId];
    final matchedEntry = _matchSavedEntryRecord(
      choice.classEntry,
      savedEntriesBySyncId,
      savedEntries,
    );
    final nextRecord = CharacterChoiceRecord(
      id: existingRecord?.id,
      syncId: syncId,
      characterId: characterRecord.id!,
      character: characterRecord,
      classEntryId: matchedEntry?.id,
      classEntry: matchedEntry,
      sourceType: choice.sourceType,
      sourceId: choice.sourceId,
      groupKey: choice.groupKey,
      optionKey: choice.optionKey,
      selectionIndex: choice.selectionIndex,
      selectedAbility: choice.selectedAbility,
      selectedLanguage: choice.selectedLanguage,
      selectedToolKey: choice.selectedToolKey,
      selectedFeatId: choice.selectedFeatId,
      selectedText: choice.selectedText,
      selectedCount: choice.selectedCount,
      updatedAt: choice.updatedAt?.toUtc() ?? characterRecord.updatedAt,
    );
    final saved = existingRecord == null
        ? await CharacterChoiceRecord.db.insertRow(session, nextRecord)
        : await CharacterChoiceRecord.db.updateRow(session, nextRecord);
    if (saved.id != null) {
      keepRowIds.add(saved.id!);
    }
  }

  await _deleteMissingChoiceRecords(session, characterRecord.id!, keepRowIds);
}

Future<void> _upsertSkillSelectionRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterClassEntryRecord> savedEntries,
  List<CharacterSkillSelectionData> selections,
) async {
  final existingSelections = await CharacterSkillSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterRecord.id),
  );
  final existingBySyncId = {
    for (final record in existingSelections)
      if (record.syncId != null) record.syncId!: record,
  };
  final savedEntriesBySyncId = {
    for (final entry in savedEntries)
      if (entry.syncId != null) entry.syncId!: entry,
  };

  final keepRowIds = <int>{};
  for (final selection in selections) {
    final skill = selection.skill;
    if (skill == null) {
      continue;
    }

    final syncId = selection.id ?? _generateSyncId();
    final existingRecord = existingBySyncId[syncId];
    final matchedEntry = _matchSavedEntryRecord(
      selection.classEntry,
      savedEntriesBySyncId,
      savedEntries,
    );
    final nextRecord = CharacterSkillSelectionRecord(
      id: existingRecord?.id,
      syncId: syncId,
      characterId: characterRecord.id!,
      character: characterRecord,
      classEntryId: matchedEntry?.id,
      classEntry: matchedEntry,
      classDataId: selection.classDataId ?? matchedEntry?.classDataId,
      backgroundDataId: selection.backgroundDataId,
      skill: skill,
      kind: selection.kind,
      selectionIndex: selection.selectionIndex,
      updatedAt: selection.updatedAt?.toUtc() ?? characterRecord.updatedAt,
    );
    final saved = existingRecord == null
        ? await CharacterSkillSelectionRecord.db.insertRow(session, nextRecord)
        : await CharacterSkillSelectionRecord.db.updateRow(session, nextRecord);
    if (saved.id != null) {
      keepRowIds.add(saved.id!);
    }
  }

  await _deleteMissingSkillSelectionRecords(
    session,
    characterRecord.id!,
    keepRowIds,
  );
}

Future<void> _upsertSpellSelectionRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterClassEntryRecord> savedEntries,
  List<CharacterSpellSelectionData> selections,
) async {
  final existingSelections = await CharacterSpellSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterRecord.id),
  );
  final existingBySyncId = {
    for (final record in existingSelections)
      if (record.syncId != null) record.syncId!: record,
  };
  final savedEntriesBySyncId = {
    for (final entry in savedEntries)
      if (entry.syncId != null) entry.syncId!: entry,
  };

  final keepRowIds = <int>{};
  for (final selection in selections) {
    final syncId = selection.id ?? _generateSyncId();
    final existingRecord = existingBySyncId[syncId];
    final matchedEntry = _matchSavedEntryRecord(
      selection.classEntry,
      savedEntriesBySyncId,
      savedEntries,
    );
    final spellId = selection.spellId ?? selection.spell?.id;
    final spellKey = _normalizedTextOrNull(selection.spellKey) ??
        _normalizedTextOrNull(selection.spell?.referenceKey) ??
        _normalizedTextOrNull(selection.spell?.name);
    if (spellId == null && spellKey == null) {
      continue;
    }

    final nextRecord = CharacterSpellSelectionRecord(
      id: existingRecord?.id,
      syncId: syncId,
      characterId: characterRecord.id!,
      character: characterRecord,
      classEntryId: matchedEntry?.id,
      classEntry: matchedEntry,
      classDataId: selection.classDataId ?? matchedEntry?.classDataId,
      spellId: spellId,
      spell: selection.spell,
      spellKey: spellKey,
      kind: selection.kind,
      selectionIndex: selection.selectionIndex,
      updatedAt: selection.updatedAt?.toUtc() ?? characterRecord.updatedAt,
    );
    final saved = existingRecord == null
        ? await CharacterSpellSelectionRecord.db.insertRow(session, nextRecord)
        : await CharacterSpellSelectionRecord.db.updateRow(session, nextRecord);
    if (saved.id != null) {
      keepRowIds.add(saved.id!);
    }
  }

  await _deleteMissingSpellSelectionRecords(
    session,
    characterRecord.id!,
    keepRowIds,
  );
}
