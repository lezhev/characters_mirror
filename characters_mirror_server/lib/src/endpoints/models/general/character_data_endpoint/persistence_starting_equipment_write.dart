part of '../character_data_endpoint.dart';

Future<void> _deleteStartingEquipmentRecords(
  Session session,
  int characterId,
) async {
  final selections = await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
  final selectionIds = {
    for (final selection in selections)
      if (selection.id != null) selection.id!,
  };
  if (selectionIds.isNotEmpty) {
    await CharacterStartingEquipmentResolutionRecord.db.deleteWhere(
      session,
      where: (t) => t.selectionId.inSet(selectionIds),
    );
  }
  await CharacterStartingEquipmentSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
}

Future<void> _upsertStartingEquipmentSelectionRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterStartingEquipmentSelectionData> selections,
) async {
  final existingSelections =
      await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterRecord.id),
  );
  final existingSelectionsBySyncId = {
    for (final record in existingSelections)
      if (record.syncId != null) record.syncId!: record,
  };
  final keepSelectionRowIds = <int>{};
  for (final selection in selections) {
    final syncId = selection.id ?? _generateSyncId();
    final existingSelection = existingSelectionsBySyncId[syncId];
    final nextSelection = CharacterStartingEquipmentSelectionRecord(
      id: existingSelection?.id,
      syncId: syncId,
      characterId: characterRecord.id!,
      character: characterRecord,
      sourceType: selection.sourceType,
      sourceId: selection.sourceId,
      sourceEntryId: selection.sourceEntryId,
      choiceOptionEntryId: selection.choiceOptionEntryId,
      isSelected: selection.isSelected,
      selectionIndex: selection.selectionIndex,
      updatedAt: selection.updatedAt?.toUtc() ?? characterRecord.updatedAt,
    );
    final savedSelection = existingSelection == null
        ? await CharacterStartingEquipmentSelectionRecord.db.insertRow(
            session,
            nextSelection,
          )
        : await CharacterStartingEquipmentSelectionRecord.db.updateRow(
            session,
            nextSelection,
          );
    if (savedSelection.id != null) {
      keepSelectionRowIds.add(savedSelection.id!);
      await _upsertStartingEquipmentResolutionRecords(
        session,
        savedSelection,
        _normalizedStartingEquipmentResolutions(
              selection.resolutions,
              selection.updatedAt?.toUtc() ?? characterRecord.updatedAt,
            ) ??
            const <CharacterStartingEquipmentResolutionData>[],
      );
    }
  }
  await _deleteMissingStartingEquipmentSelections(
    session,
    characterRecord.id!,
    keepSelectionRowIds,
  );
}

Future<void> _upsertStartingEquipmentResolutionRecords(
  Session session,
  CharacterStartingEquipmentSelectionRecord selectionRecord,
  List<CharacterStartingEquipmentResolutionData> resolutions,
) async {
  final existingResolutions =
      await CharacterStartingEquipmentResolutionRecord.db.find(
    session,
    where: (t) => t.selectionId.equals(selectionRecord.id),
  );
  final existingBySyncId = {
    for (final record in existingResolutions)
      if (record.syncId != null) record.syncId!: record,
  };
  final keepRowIds = <int>{};
  for (final resolution in resolutions) {
    final syncId = resolution.id ?? _generateSyncId();
    final existingRecord = existingBySyncId[syncId];
    final nextRecord = CharacterStartingEquipmentResolutionRecord(
      id: existingRecord?.id,
      syncId: syncId,
      selectionId: selectionRecord.id!,
      selection: selectionRecord,
      sourceLineEntryId: resolution.sourceLineEntryId,
      catalogType: resolution.catalogType,
      referenceKey: resolution.referenceKey,
      quantity: resolution.quantity,
      updatedAt: resolution.updatedAt?.toUtc() ?? selectionRecord.updatedAt,
    );
    final saved = existingRecord == null
        ? await CharacterStartingEquipmentResolutionRecord.db.insertRow(
            session,
            nextRecord,
          )
        : await CharacterStartingEquipmentResolutionRecord.db.updateRow(
            session,
            nextRecord,
          );
    if (saved.id != null) {
      keepRowIds.add(saved.id!);
    }
  }

  final removableIds = [
    for (final record in existingResolutions)
      if (record.id != null && !keepRowIds.contains(record.id)) record.id!,
  ];
  if (removableIds.isNotEmpty) {
    await CharacterStartingEquipmentResolutionRecord.db.deleteWhere(
      session,
      where: (t) => t.id.inSet(removableIds.toSet()),
    );
  }
}

CharacterClassEntryRecord? _matchSavedEntryRecord(
  CharacterClassEntryData? draftEntry,
  Map<String, CharacterClassEntryRecord> savedEntriesBySyncId,
  List<CharacterClassEntryRecord> savedEntries,
) {
  if (draftEntry == null) return null;
  final syncId = draftEntry.id;
  if (syncId != null) {
    final matchedBySyncId = savedEntriesBySyncId[syncId];
    if (matchedBySyncId != null) return matchedBySyncId;
  }

  final classDataId = draftEntry.classData?.id;
  if (classDataId == null) return null;
  final subclassId = draftEntry.subclass?.id;
  for (final entry in savedEntries) {
    if (entry.classDataId == classDataId && entry.subclassId == subclassId) {
      return entry;
    }
  }
  return null;
}

Future<void> _deleteMissingClassEntryRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds,
) async {
  final existingEntries = await CharacterClassEntryRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
  final removableIds = [
    for (final entry in existingEntries)
      if (entry.id != null && !keepRowIds.contains(entry.id)) entry.id!,
  ];
  if (removableIds.isEmpty) {
    return;
  }
  await CharacterClassEntryRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableIds.toSet()),
  );
}

Future<void> _deleteMissingChoiceRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds,
) async {
  final existingChoices = await CharacterChoiceRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
  final removableIds = [
    for (final choice in existingChoices)
      if (choice.id != null && !keepRowIds.contains(choice.id)) choice.id!,
  ];
  if (removableIds.isEmpty) {
    return;
  }
  await CharacterChoiceRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableIds.toSet()),
  );
}

Future<void> _deleteMissingSkillSelectionRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds,
) async {
  final existingSelections = await CharacterSkillSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
  final removableIds = [
    for (final selection in existingSelections)
      if (selection.id != null && !keepRowIds.contains(selection.id))
        selection.id!,
  ];
  if (removableIds.isEmpty) {
    return;
  }
  await CharacterSkillSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableIds.toSet()),
  );
}

Future<void> _deleteMissingSpellSelectionRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds,
) async {
  final existingSelections = await CharacterSpellSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
  final removableIds = [
    for (final selection in existingSelections)
      if (selection.id != null && !keepRowIds.contains(selection.id))
        selection.id!,
  ];
  if (removableIds.isEmpty) {
    return;
  }
  await CharacterSpellSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableIds.toSet()),
  );
}

Future<void> _deleteMissingStartingEquipmentSelections(
  Session session,
  int characterId,
  Set<int> keepSelectionRowIds,
) async {
  final existingSelections =
      await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
  );
  final removableSelectionIds = [
    for (final selection in existingSelections)
      if (selection.id != null && !keepSelectionRowIds.contains(selection.id))
        selection.id!,
  ];
  if (removableSelectionIds.isEmpty) {
    return;
  }
  await CharacterStartingEquipmentResolutionRecord.db.deleteWhere(
    session,
    where: (t) => t.selectionId.inSet(removableSelectionIds.toSet()),
  );
  await CharacterStartingEquipmentSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableSelectionIds.toSet()),
  );
}

CharacterData _normalizeIncomingCharacter(
  CharacterData character, {
  required DateTime? fallbackUpdatedAt,
}) {
  final updatedAt = character.updatedAt?.toUtc() ?? fallbackUpdatedAt?.toUtc();

  return character.copyWith(
    updatedAt: updatedAt,
    createdAt: character.createdAt?.toUtc() ?? updatedAt,
    equipment: _normalizedInventoryItems(character.equipment, updatedAt),
    notes: _normalizedNotes(character.notes, updatedAt),
    attacks: _normalizedAttacks(character.attacks, updatedAt),
    featureOverrides: _normalizedFeatureOverridesWithSync(
        character.featureOverrides, updatedAt),
    resourceStates: _normalizedResourceStates(character.resourceStates),
    classEntries: _normalizedClassEntries(character.classEntries, updatedAt),
    choices: _normalizedChoices(character.choices, updatedAt),
    skillSelections: _normalizedSkillSelections(
      character.skillSelections,
      updatedAt,
    ),
    spellSelections: _normalizedSpellSelections(
      character.spellSelections,
      updatedAt,
    ),
    startingEquipmentSelections: _normalizedStartingEquipmentSelections(
      character.startingEquipmentSelections,
      updatedAt,
    ),
  );
}
