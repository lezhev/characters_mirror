part of '../character_data_endpoint.dart';

Future<void> _deleteStartingEquipmentRecords(
  Session session,
  int characterId, {
  Transaction? transaction,
}) async {
  final selections = await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
  );
  final selectionIds = {
    for (final selection in selections)
      if (selection.id != null) selection.id!,
  };
  if (selectionIds.isNotEmpty) {
    await CharacterStartingEquipmentResolutionRecord.db.deleteWhere(
      session,
      where: (t) => t.selectionId.inSet(selectionIds),
      transaction: transaction,
    );
  }
  await CharacterStartingEquipmentSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
  );
}

Future<void> _upsertStartingEquipmentSelectionRecords(
  Session session,
  CharacterRecord characterRecord,
  List<CharacterStartingEquipmentSelectionData> selections, {
  Transaction? transaction,
}) async {
  final existingSelections =
      await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterRecord.id),
    transaction: transaction,
  );
  final existingSelectionsBySyncId = {
    for (final record in existingSelections)
      if (record.syncId != null) record.syncId!: record,
  };
  final existingSelectionsByLogicalId = {
    for (final record in existingSelections)
      _startingEquipmentSelectionRecordTargetId(record): record,
  };
  final keepSelectionRowIds = <int>{};
  for (final selection in selections) {
    final logicalId = _startingEquipmentSelectionTargetId(selection);
    final existingSelection = existingSelectionsBySyncId[selection.id] ??
        existingSelectionsByLogicalId[logicalId];
    final syncId = existingSelection?.syncId ?? selection.id ?? logicalId;
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
            transaction: transaction,
          )
        : await CharacterStartingEquipmentSelectionRecord.db.updateRow(
            session,
            nextSelection,
            transaction: transaction,
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
        transaction: transaction,
      );
    }
  }
  await _deleteMissingStartingEquipmentSelections(
    session,
    characterRecord.id!,
    keepSelectionRowIds,
    transaction: transaction,
  );
}

Future<void> _upsertStartingEquipmentResolutionRecords(
  Session session,
  CharacterStartingEquipmentSelectionRecord selectionRecord,
  List<CharacterStartingEquipmentResolutionData> resolutions, {
  Transaction? transaction,
}) async {
  final existingResolutions =
      await CharacterStartingEquipmentResolutionRecord.db.find(
    session,
    where: (t) => t.selectionId.equals(selectionRecord.id),
    transaction: transaction,
  );
  final existingBySyncId = {
    for (final record in existingResolutions)
      if (record.syncId != null) record.syncId!: record,
  };
  final existingBySourceLineId = {
    for (final record in existingResolutions)
      if (record.sourceLineEntryId != null) record.sourceLineEntryId!: record,
  };
  final keepRowIds = <int>{};
  for (final resolution in resolutions) {
    final logicalId = resolution.sourceLineEntryId?.toString();
    final existingRecord = existingBySyncId[resolution.id] ??
        existingBySourceLineId[resolution.sourceLineEntryId];
    final syncId = existingRecord?.syncId ??
        resolution.id ??
        logicalId ??
        _generateSyncId();
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
            transaction: transaction,
          )
        : await CharacterStartingEquipmentResolutionRecord.db.updateRow(
            session,
            nextRecord,
            transaction: transaction,
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
      transaction: transaction,
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
  Set<int> keepRowIds, {
  Transaction? transaction,
}) async {
  final existingEntries = await CharacterClassEntryRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
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
    transaction: transaction,
  );
}

Future<void> _deleteMissingChoiceRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds, {
  Transaction? transaction,
}) async {
  final existingChoices = await CharacterChoiceRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
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
    transaction: transaction,
  );
}

Future<void> _deleteMissingSkillSelectionRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds, {
  Transaction? transaction,
}) async {
  final existingSelections = await CharacterSkillSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
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
    transaction: transaction,
  );
}

Future<void> _deleteMissingSpellSelectionRecords(
  Session session,
  int characterId,
  Set<int> keepRowIds, {
  Transaction? transaction,
}) async {
  final existingSelections = await CharacterSpellSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
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
    transaction: transaction,
  );
}

Future<void> _deleteMissingStartingEquipmentSelections(
  Session session,
  int characterId,
  Set<int> keepSelectionRowIds, {
  Transaction? transaction,
}) async {
  final existingSelections =
      await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(characterId),
    transaction: transaction,
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
    transaction: transaction,
  );
  await CharacterStartingEquipmentSelectionRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableSelectionIds.toSet()),
    transaction: transaction,
  );
}

CharacterData _normalizeIncomingCharacter(
  CharacterData character, {
  required DateTime? fallbackUpdatedAt,
}) {
  final updatedAt = character.updatedAt?.toUtc() ?? fallbackUpdatedAt?.toUtc();
  final proficiencyOverrides =
      CharacterProficiencyOverrideValidator.normalize(character);

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
    manualSkillProficiencyOverrides: _normalizedSkillProficiencyOverrides(
      character.manualSkillProficiencyOverrides,
    ),
    manualSavingThrowProficiencyOverrides:
        _normalizedSavingThrowProficiencyOverrides(
      character.manualSavingThrowProficiencyOverrides,
    ),
    manualLanguageOverrides: proficiencyOverrides.manualLanguageOverrides,
    manualToolProficiencyOverrides:
        proficiencyOverrides.manualToolProficiencyOverrides,
    manualWeaponProficiencyOverrides:
        proficiencyOverrides.manualWeaponProficiencyOverrides,
    manualArmorTrainingOverrides:
        proficiencyOverrides.manualArmorTrainingOverrides,
  );
}

String _startingEquipmentSelectionRecordTargetId(
  CharacterStartingEquipmentSelectionRecord record,
) {
  return _encodeCompositeTargetId([
    record.sourceType?.name ?? '',
    record.sourceId?.toString() ?? '',
    record.sourceEntryId?.toString() ?? '',
    record.selectionIndex?.toString() ?? '',
  ]);
}
