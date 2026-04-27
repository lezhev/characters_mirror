import 'dart:math';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CharacterDataEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<CharacterData>> getAll(Session session) async {
    final userId = await _requireCurrentUserId(session);
    final records = await CharacterRecord.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      include: _characterRecordInclude(),
    );

    return Future.wait(
      records.map((record) => _buildCharacterAggregate(session, record)),
    );
  }

  Future<CharacterData> saveCharacter(
    Session session,
    CharacterData character,
  ) async {
    final userId = await _requireCurrentUserId(session);
    // TODO: Add server-side abuse limits for character count, text lengths,
    // list sizes, and save rate before accepting user-controlled payloads.
    var normalizedCharacter = character.copyWith(
      featureOverrides: await _pruneFeatureOverrides(session, character),
    );
    final existingRecord = character.id == null
        ? null
        : await _findOwnedCharacterRecord(session, character.id!, userId);
    if (_serverSnapshotIsNewer(existingRecord, normalizedCharacter)) {
      return _buildCharacterAggregate(session, existingRecord!);
    }

    normalizedCharacter = _normalizeIncomingCharacter(
      normalizedCharacter,
      fallbackUpdatedAt:
          normalizedCharacter.updatedAt ?? existingRecord?.updatedAt,
    );
    if (character.id == null) {
      normalizedCharacter = await _applyInitialEquipmentSnapshot(
        session,
        normalizedCharacter,
      );
    }
    final savedRecord =
        await _upsertCharacterRecord(session, normalizedCharacter, userId);
    await _upsertCharacterRelations(session, savedRecord, normalizedCharacter);

    final hydratedRecord = await _requireOwnedCharacterRecord(
      session,
      savedRecord.id!,
      userId: userId,
    );
    return _buildCharacterAggregate(session, hydratedRecord);
  }

  Future<CharacterSyncResult> syncSaveCharacter(
    Session session,
    CharacterData character,
    int? expectedVersion,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final characterId = character.id;
    if (characterId != null) {
      final currentRecord = await _findOwnedCharacterRecord(
        session,
        characterId,
        userId,
      );
      if (currentRecord == null) {
        return CharacterSyncResult(
          status: CharacterSyncStatus.notFound,
          message: 'Character was not found for this user.',
        );
      }
      if (currentRecord.version != expectedVersion) {
        return CharacterSyncResult(
          status: CharacterSyncStatus.conflict,
          conflictCharacter:
              await _buildCharacterAggregate(session, currentRecord),
          message: 'Character version conflict.',
        );
      }
    }

    final saved = await saveCharacter(session, character);
    return CharacterSyncResult(
      status: CharacterSyncStatus.saved,
      character: saved,
    );
  }

  Future<CharacterSyncResponse> syncCharacters(
    Session session,
    CharacterSyncRequest request,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final acknowledgedChangeIds = <String>[];
    final rejectedChanges = <CharacterRejectedChangeData>[];
    for (final change in request.changes ?? const <CharacterChangeData>[]) {
      if (change.entityType != CharacterEntityType.character) {
        rejectedChanges.add(
          CharacterRejectedChangeData(
            changeId: change.id,
            reason: 'unsupported_entity',
            message: 'Unsupported entity type ${change.entityType.name}.',
          ),
        );
        continue;
      }

      switch (change.changeType) {
        case CharacterChangeType.upsert:
          final payload = change.payload;
          if (payload == null) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'missing_payload',
                message: 'Upsert change requires payload.',
              ),
            );
            continue;
          }

          final currentRecord = payload.id == null
              ? null
              : await _findOwnedCharacterRecord(session, payload.id!, userId);
          if (_serverSnapshotIsNewer(currentRecord, payload)) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'stale_update',
                message:
                    'Stored character is newer than the incoming snapshot.',
                character: currentRecord == null
                    ? null
                    : await _buildCharacterAggregate(session, currentRecord),
              ),
            );
            continue;
          }

          await saveCharacter(session, payload);
          acknowledgedChangeIds.add(change.id);
          continue;
        case CharacterChangeType.delete:
          final existing = await _findOwnedCharacterRecordByEntityId(
            session,
            userId,
            change.entityId,
          );
          if (existing == null) {
            acknowledgedChangeIds.add(change.id);
            continue;
          }
          if (_serverDeleteShouldWin(existing, change.baseUpdatedAt)) {
            rejectedChanges.add(
              CharacterRejectedChangeData(
                changeId: change.id,
                reason: 'stale_delete',
                message: 'Stored character is newer than the delete base.',
                character: await _buildCharacterAggregate(session, existing),
              ),
            );
            continue;
          }
          await delete(session, existing.id!);
          acknowledgedChangeIds.add(change.id);
          continue;
      }
    }

    final pullCharacters = await _loadCharactersUpdatedAfter(
      session,
      userId: userId,
      updatedAfter: request.pullSince,
    );

    return CharacterSyncResponse(
      acknowledgedChangeIds: acknowledgedChangeIds,
      rejectedChanges: rejectedChanges,
      characters: pullCharacters,
      serverTime: DateTime.now().toUtc(),
    );
  }

  Future<CharacterData> getCharacter(Session session, int id) async {
    final record = await _requireOwnedCharacterRecord(session, id);
    return _buildCharacterAggregate(session, record);
  }

  Future<CharacterSyncResult> syncDeleteCharacter(
    Session session,
    int id,
    int? expectedVersion,
  ) async {
    final userId = await _requireCurrentUserId(session);
    final currentRecord = await _findOwnedCharacterRecord(session, id, userId);
    if (currentRecord == null) {
      return CharacterSyncResult(
        status: CharacterSyncStatus.notFound,
        message: 'Character was not found for this user.',
      );
    }
    if (currentRecord.version != expectedVersion) {
      return CharacterSyncResult(
        status: CharacterSyncStatus.conflict,
        conflictCharacter:
            await _buildCharacterAggregate(session, currentRecord),
        message: 'Character version conflict.',
      );
    }

    await delete(session, id);
    return CharacterSyncResult(status: CharacterSyncStatus.deleted);
  }

  Future<void> delete(Session session, int id) async {
    await _requireOwnedCharacterRecord(session, id);
    await _deleteStartingEquipmentRecords(session, id);
    await CharacterChoiceRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterClassEntryRecord.db.deleteWhere(
      session,
      where: (t) => t.characterId.equals(id),
    );
    await CharacterRecord.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

Future<List<CharacterFeatureOverrideData>> _pruneFeatureOverrides(
  Session session,
  CharacterData character,
) async {
  final normalizedOverrides = _normalizedFeatureOverrides(
    character.featureOverrides,
  );
  if (normalizedOverrides.isEmpty) {
    return const <CharacterFeatureOverrideData>[];
  }

  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final resolvedSources =
      await _resolveDerivedSources(session, character, choices);
  final currentRaceFeatures =
      _currentRaceFeaturesBySource(character, totalLevel);
  final defaultFeatures = _buildActiveFeatures(
    character: character.copyWith(
      featureOverrides: const <CharacterFeatureOverrideData>[],
    ),
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
  );
  final defaultByKey = {
    for (final feature in defaultFeatures)
      _featureOverrideKey(feature.sourceType, feature.sourceId): feature,
  };

  return [
    for (final override in normalizedOverrides)
      if (_isMeaningfulFeatureOverride(
        override,
        defaultByKey[
            _featureOverrideKey(override.sourceType, override.sourceId)],
      ))
        override,
  ];
}

Future<CharacterData> _applyInitialEquipmentSnapshot(
  Session session,
  CharacterData character,
) async {
  final grantedEquipment = await _collectGrantedEquipment(session, character);
  if (grantedEquipment.isEmpty) {
    return character;
  }

  final equipment =
      (character.equipment == null || character.equipment!.isEmpty)
          ? _buildEquipmentSnapshot(
              grantedEquipment,
              fallbackUpdatedAt: character.updatedAt,
            )
          : character.equipment;
  final weaponAttacks = await _buildStartingWeaponAttacks(
    session,
    character,
    grantedEquipment,
  );
  final attacks = [...?character.attacks];
  for (final attack in weaponAttacks) {
    if (!_containsAttackWithName(attacks, attack.name)) {
      attacks.add(attack);
    }
  }

  return character.copyWith(
    equipment: equipment,
    attacks: attacks.isEmpty ? character.attacks : attacks,
  );
}

List<CharacterInventoryItemData> _buildEquipmentSnapshot(
  List<CharacterEquipmentEntryView> grantedEquipment, {
  required DateTime? fallbackUpdatedAt,
}) {
  final items = <CharacterInventoryItemData>[];
  for (final entry in grantedEquipment) {
    final name = _normalizedTextOrNull(entry.displayText) ??
        _normalizedTextOrNull(entry.referenceKey);
    if (name == null) {
      continue;
    }
    items.add(
      CharacterInventoryItemData(
        id: _generateSyncId(),
        name: name,
        quantity: _normalizedPositiveQuantity(entry.quantity),
        type: _inventoryItemTypeForCatalog(entry.catalogType),
        updatedAt: fallbackUpdatedAt,
      ),
    );
  }
  return items;
}

Future<List<CharacterAttackData>> _buildStartingWeaponAttacks(
  Session session,
  CharacterData character,
  List<CharacterEquipmentEntryView> grantedEquipment,
) async {
  final weaponReferenceKeys = <String>[
    for (final entry in grantedEquipment)
      if (entry.catalogType == EquipmentCatalogType.weapon &&
          _normalizedTextOrNull(entry.referenceKey) != null)
        _normalizedTextOrNull(entry.referenceKey)!,
  ];
  if (weaponReferenceKeys.isEmpty) {
    return const <CharacterAttackData>[];
  }

  final uniqueReferenceKeys = <String>{};
  final attacks = <CharacterAttackData>[];
  CharacterDerivedData? derived;

  for (final referenceKey in weaponReferenceKeys) {
    if (!uniqueReferenceKeys.add(referenceKey)) {
      continue;
    }

    final rows = await WeaponData.db.find(
      session,
      where: (t) => t.referenceKey.equals(referenceKey),
      limit: 1,
    );
    if (rows.isEmpty) {
      continue;
    }

    final weapon = rows.first;
    if (_hasWeaponProperty(weapon, WeaponProperty.finesse)) {
      derived ??= await _buildDerivedData(session, character);
    }

    attacks.add(
      CharacterAttackData(
        id: _generateSyncId(),
        name: _normalizedTextOrNull(weapon.name) ?? referenceKey,
        leadingAbility: _startingWeaponAbility(weapon, derived),
        damage: _normalizedTextOrNull(weapon.damage),
        customAttackBonus: 0,
        damageType: weapon.damageType,
        tags: _normalizedAttackTags(weapon.properties),
        description: _normalizedTextOrNull(weapon.description),
        updatedAt: character.updatedAt,
      ),
    );
  }

  return attacks;
}

Ability _startingWeaponAbility(
  WeaponData weapon,
  CharacterDerivedData? derived,
) {
  if (_hasWeaponProperty(weapon, WeaponProperty.finesse)) {
    final modifiers = derived?.abilityModifiers ?? const <String, int>{};
    final strength = modifiers[Ability.strength.name] ?? 0;
    final dexterity = modifiers[Ability.dexterity.name] ?? 0;
    return dexterity > strength ? Ability.dexterity : Ability.strength;
  }

  switch (weapon.category) {
    case WeaponCategory.simpleRanged:
    case WeaponCategory.martialRanged:
      return Ability.dexterity;
    case WeaponCategory.simpleMelee:
    case WeaponCategory.martialMelee:
    case null:
      return Ability.strength;
  }
}

List<String>? _normalizedAttackTags(List<WeaponProperty>? tags) {
  final normalized = [
    for (final tag in tags ?? const <WeaponProperty>[]) tag.name,
  ];
  return normalized.isEmpty ? null : normalized;
}

bool _hasWeaponProperty(WeaponData weapon, WeaponProperty property) {
  return (weapon.properties ?? const <WeaponProperty>[]).contains(property);
}

bool _containsAttackWithName(
  List<CharacterAttackData> attacks,
  String? name,
) {
  final normalizedName = _normalizedTextOrNull(name)?.toLowerCase();
  if (normalizedName == null) {
    return false;
  }

  return attacks.any(
    (attack) =>
        _normalizedTextOrNull(attack.name)?.toLowerCase() == normalizedName,
  );
}

Future<CharacterRecord> _upsertCharacterRecord(
  Session session,
  CharacterData character,
  int userId,
) async {
  final now = DateTime.now().toUtc();
  final effectiveUpdatedAt = character.updatedAt?.toUtc() ?? now;
  final effectiveCreatedAt =
      character.createdAt?.toUtc() ?? character.updatedAt?.toUtc() ?? now;

  if (character.id == null) {
    return CharacterRecord.db.insertRow(
      session,
      _toCharacterRecord(
        character,
        userId: userId,
        version: character.version ?? 1,
        createdAt: effectiveCreatedAt,
        updatedAt: effectiveUpdatedAt,
      ),
    );
  }

  final ownedRecord = await _findOwnedCharacterRecord(
    session,
    character.id!,
    userId,
  );
  if (ownedRecord != null) {
    final updatedRecord = _toCharacterRecord(
      character,
      id: ownedRecord.id,
      userId: ownedRecord.userId ?? userId,
      version: (ownedRecord.version ?? 0) + 1,
      createdAt: ownedRecord.createdAt?.toUtc() ?? effectiveCreatedAt,
      updatedAt: effectiveUpdatedAt,
    );
    await CharacterRecord.db.updateRow(session, updatedRecord);
    return updatedRecord;
  }

  final existingById = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(character.id),
    limit: 1,
  );
  if (existingById.isNotEmpty) {
    throw Exception('Access denied to character id=${character.id}.');
  }

  return CharacterRecord.db.insertRow(
    session,
    _toCharacterRecord(
      character,
      userId: userId,
      version: character.version ?? 1,
      createdAt: effectiveCreatedAt,
      updatedAt: effectiveUpdatedAt,
    ),
  );
}

CharacterRecord _toCharacterRecord(
  CharacterData character, {
  int? id,
  required int userId,
  required int version,
  required DateTime createdAt,
  required DateTime updatedAt,
}) {
  return CharacterRecord(
    id: id,
    name: character.name,
    age: character.age,
    height: character.height,
    weight: character.weight,
    eyes: character.eyes,
    skin: character.skin,
    hair: character.hair,
    appearance: character.appearance,
    backstory: character.backstory,
    goals: character.goals,
    alliesOrganizations: character.alliesOrganizations,
    personalityTraits: character.personalityTraits,
    ideals: character.ideals,
    bonds: character.bonds,
    flaws: character.flaws,
    version: version,
    createdAt: createdAt,
    updatedAt: updatedAt,
    userId: userId,
    experience: character.experience,
    alignmentValue: character.alignmentValue,
    raceId: character.race?.id,
    subraceId: character.subrace?.id,
    backgroundId: character.background?.id,
    baseAbilityScores: character.baseAbilityScores,
    customAbilityBonuses: character.customAbilityBonuses,
    useFlexibleAbilityBonuses: character.useFlexibleAbilityBonuses,
    temporaryHp: character.temporaryHp,
    currentHp: character.currentHp,
    inspiration: character.inspiration,
    equipment: character.equipment,
    manualSkillProficiencies: character.manualSkillProficiencies,
    manualSavingThrowProficiencies: character.manualSavingThrowProficiencies,
    notes: character.notes,
    attacks: character.attacks,
    featureOverrides: _normalizedFeatureOverrides(character.featureOverrides),
  );
}

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
      blockKey: selection.blockKey,
      optionKey: selection.optionKey,
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
        selection.resolutions ??
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
      lineKey: resolution.lineKey,
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
  await _deleteMissingStartingEquipmentResolutions(
    session,
    selectionRecord.id!,
    keepRowIds,
  );
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

Future<void> _deleteMissingStartingEquipmentResolutions(
  Session session,
  int selectionId,
  Set<int> keepRowIds,
) async {
  final existingResolutions =
      await CharacterStartingEquipmentResolutionRecord.db.find(
    session,
    where: (t) => t.selectionId.equals(selectionId),
  );
  final removableIds = [
    for (final resolution in existingResolutions)
      if (resolution.id != null && !keepRowIds.contains(resolution.id))
        resolution.id!,
  ];
  if (removableIds.isEmpty) {
    return;
  }
  await CharacterStartingEquipmentResolutionRecord.db.deleteWhere(
    session,
    where: (t) => t.id.inSet(removableIds.toSet()),
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

List<CharacterInventoryItemData>? _normalizedInventoryItems(
  List<CharacterInventoryItemData>? items,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final item in items ?? const <CharacterInventoryItemData>[])
      if (_normalizedTextOrNull(item.name) != null)
        CharacterInventoryItemData(
          id: item.id ?? _generateSyncId(),
          name: _normalizedTextOrNull(item.name),
          quantity: _normalizedPositiveQuantity(item.quantity),
          type: item.type ?? CharacterInventoryItemType.custom,
          updatedAt: item.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterNoteData>? _normalizedNotes(
  List<CharacterNoteData>? notes,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final note in notes ?? const <CharacterNoteData>[])
      if (_normalizedTextOrNull(note.text) != null)
        CharacterNoteData(
          id: note.id ?? _generateSyncId(),
          text: _normalizedTextOrNull(note.text),
          updatedAt: note.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterAttackData>? _normalizedAttacks(
  List<CharacterAttackData>? attacks,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final attack in attacks ?? const <CharacterAttackData>[])
      CharacterAttackData(
        id: attack.id ?? _generateSyncId(),
        name: _normalizedTextOrNull(attack.name),
        leadingAbility: attack.leadingAbility,
        damage: _normalizedTextOrNull(attack.damage),
        customAttackBonus: attack.customAttackBonus ?? 0,
        damageType: attack.damageType,
        tags: _normalizedAttackTagsFromStrings(attack.tags),
        description: _normalizedTextOrNull(attack.description),
        updatedAt: attack.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterFeatureOverrideData> _normalizedFeatureOverridesWithSync(
  List<CharacterFeatureOverrideData>? overrides,
  DateTime? updatedAt,
) {
  return [
    for (final override in _normalizedFeatureOverrides(overrides))
      override.copyWith(
        id: override.id ?? _generateSyncId(),
        updatedAt: override.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
}

List<CharacterClassEntryData>? _normalizedClassEntries(
  List<CharacterClassEntryData>? entries,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final entry in entries ?? const <CharacterClassEntryData>[])
      if (entry.classData?.id != null)
        entry.copyWith(
          id: entry.id ?? _generateSyncId(),
          notes: _normalizedTextOrNull(entry.notes),
          updatedAt: entry.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterChoiceData>? _normalizedChoices(
  List<CharacterChoiceData>? choices,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final choice in choices ?? const <CharacterChoiceData>[])
      choice.copyWith(
        id: choice.id ?? _generateSyncId(),
        selectedToolKey: _normalizedTextOrNull(choice.selectedToolKey),
        selectedText: _normalizedTextOrNull(choice.selectedText),
        updatedAt: choice.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterSpellSelectionData>? _normalizedSpellSelections(
  List<CharacterSpellSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection in selections ?? const <CharacterSpellSelectionData>[])
      if (selection.spellId != null ||
          selection.spell?.id != null ||
          _normalizedTextOrNull(selection.spellKey) != null ||
          _normalizedTextOrNull(selection.spell?.referenceKey) != null ||
          _normalizedTextOrNull(selection.spell?.name) != null)
        selection.copyWith(
          id: selection.id ?? _generateSyncId(),
          classDataId:
              selection.classDataId ?? selection.classEntry?.classData?.id,
          spellId: selection.spellId ?? selection.spell?.id,
          spellKey: _normalizedTextOrNull(selection.spellKey) ??
              _normalizedTextOrNull(selection.spell?.referenceKey) ??
              _normalizedTextOrNull(selection.spell?.name),
          updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterSkillSelectionData>? _normalizedSkillSelections(
  List<CharacterSkillSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection in selections ?? const <CharacterSkillSelectionData>[])
      if (selection.skill != null)
        selection.copyWith(
          id: selection.id ?? _generateSyncId(),
          classDataId:
              selection.classDataId ?? selection.classEntry?.classData?.id,
          updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
        ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterStartingEquipmentSelectionData>?
    _normalizedStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData>? selections,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final selection
        in selections ?? const <CharacterStartingEquipmentSelectionData>[])
      selection.copyWith(
        id: selection.id ?? _generateSyncId(),
        optionKey: _normalizedTextOrNull(selection.optionKey),
        resolutions: _normalizedStartingEquipmentResolutions(
          selection.resolutions,
          updatedAt,
        ),
        updatedAt: selection.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<CharacterStartingEquipmentResolutionData>?
    _normalizedStartingEquipmentResolutions(
  List<CharacterStartingEquipmentResolutionData>? resolutions,
  DateTime? updatedAt,
) {
  final normalized = [
    for (final resolution
        in resolutions ?? const <CharacterStartingEquipmentResolutionData>[])
      CharacterStartingEquipmentResolutionData(
        id: resolution.id ?? _generateSyncId(),
        lineKey: _normalizedTextOrNull(resolution.lineKey),
        catalogType: resolution.catalogType,
        referenceKey: _normalizedTextOrNull(resolution.referenceKey),
        quantity: _normalizedPositiveQuantity(resolution.quantity),
        updatedAt: resolution.updatedAt?.toUtc() ?? updatedAt,
      ),
  ];
  return normalized.isEmpty ? null : normalized;
}

List<String>? _normalizedAttackTagsFromStrings(List<String>? tags) {
  final normalized = [
    for (final tag in tags ?? const <String>[])
      if (_normalizedTextOrNull(tag) != null) _normalizedTextOrNull(tag)!,
  ];
  return normalized.isEmpty ? null : normalized;
}

bool _serverSnapshotIsNewer(
  CharacterRecord? currentRecord,
  CharacterData incoming,
) {
  final storedUpdatedAt = currentRecord?.updatedAt?.toUtc();
  final incomingUpdatedAt = incoming.updatedAt?.toUtc();
  if (storedUpdatedAt == null || incomingUpdatedAt == null) {
    return false;
  }
  return storedUpdatedAt.isAfter(incomingUpdatedAt);
}

bool _serverDeleteShouldWin(
    CharacterRecord currentRecord, DateTime? baseUpdatedAt) {
  final storedUpdatedAt = currentRecord.updatedAt?.toUtc();
  final base = baseUpdatedAt?.toUtc();
  if (storedUpdatedAt == null || base == null) {
    return false;
  }
  return storedUpdatedAt.isAfter(base);
}

Future<CharacterRecord?> _findOwnedCharacterRecordByEntityId(
  Session session,
  int userId,
  String entityId,
) async {
  final numericId = int.tryParse(entityId);
  if (numericId != null) {
    return _findOwnedCharacterRecord(session, numericId, userId);
  }
  return null;
}

Future<List<CharacterData>> _loadCharactersUpdatedAfter(
  Session session, {
  required int userId,
  required DateTime? updatedAfter,
}) async {
  final records = await CharacterRecord.db.find(
    session,
    where: (t) {
      var expression = t.userId.equals(userId);
      if (updatedAfter != null) {
        expression &= t.updatedAt > updatedAfter.toUtc();
      }
      return expression;
    },
    orderBy: (t) => t.updatedAt,
    orderDescending: false,
    include: _characterRecordInclude(),
  );

  return Future.wait(
    records.map((record) => _buildCharacterAggregate(session, record)),
  );
}

CharacterInventoryItemType _inventoryItemTypeForCatalog(
  EquipmentCatalogType? catalogType,
) {
  switch (catalogType) {
    case EquipmentCatalogType.weapon:
      return CharacterInventoryItemType.weapon;
    case EquipmentCatalogType.armor:
      return CharacterInventoryItemType.armor;
    case EquipmentCatalogType.magicItem:
      return CharacterInventoryItemType.magicItem;
    case EquipmentCatalogType.item:
    case null:
      return CharacterInventoryItemType.item;
  }
}

String _generateSyncId() {
  final random = Random.secure();
  final chunks = [
    for (final length in const [8, 4, 4, 4, 12]) _randomHex(random, length),
  ];
  return chunks.join('-');
}

String _randomHex(Random random, int length) {
  final buffer = StringBuffer();
  for (var index = 0; index < length; index++) {
    buffer.write(random.nextInt(16).toRadixString(16));
  }
  return buffer.toString();
}

Future<int> _requireCurrentUserId(Session session) async {
  final userId = (await session.authenticated)?.userId;
  if (userId == null) {
    throw Exception('Authentication required.');
  }
  return userId;
}

Future<CharacterRecord?> _findOwnedCharacterRecord(
  Session session,
  int characterId,
  int userId,
) async {
  final rows = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(characterId) & t.userId.equals(userId),
    limit: 1,
    include: _characterRecordInclude(),
  );
  if (rows.isEmpty) {
    return null;
  }
  return rows.first;
}

Future<CharacterRecord> _requireOwnedCharacterRecord(
  Session session,
  int characterId, {
  int? userId,
}) async {
  final resolvedUserId = userId ?? await _requireCurrentUserId(session);
  final record = await _findOwnedCharacterRecord(
    session,
    characterId,
    resolvedUserId,
  );
  if (record != null) {
    return record;
  }

  final existing = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(characterId),
    limit: 1,
  );
  if (existing.isNotEmpty) {
    throw Exception('Access denied to character id=$characterId.');
  }

  throw Exception('CharacterData with id=$characterId was not found.');
}

Future<CharacterData> _buildCharacterAggregate(
  Session session,
  CharacterRecord record,
) async {
  final entryRecords = await CharacterClassEntryRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    orderBy: (t) => t.classOrder,
    include: CharacterClassEntryRecord.include(
      classData: ClassData.include(),
      subclass: SubclassData.include(),
    ),
  );
  final entries = entryRecords.map(_toCharacterClassEntryData).toList();
  final entriesById = {
    for (final entry in entries)
      if (entry.id != null) entry.id!: entry,
  };
  final choiceRecords = await CharacterChoiceRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    include: CharacterChoiceRecord.include(
      classEntry: CharacterClassEntryRecord.include(
        classData: ClassData.include(),
        subclass: SubclassData.include(),
      ),
    ),
  );
  final choices = choiceRecords
      .map((record) => _toCharacterChoiceData(record, entriesById))
      .toList()
    ..sort(_compareCharacterChoices);
  final skillSelectionRecords = await CharacterSkillSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    orderBy: (t) => t.selectionIndex,
    include: CharacterSkillSelectionRecord.include(
      classEntry: CharacterClassEntryRecord.include(
        classData: ClassData.include(),
        subclass: SubclassData.include(),
      ),
      classData: ClassData.include(),
      backgroundData: BackgroundData.include(),
    ),
  );
  final skillSelections = skillSelectionRecords
      .map((record) => _toCharacterSkillSelectionData(record, entriesById))
      .toList()
    ..sort(_compareSkillSelections);
  final spellSelectionRecords = await CharacterSpellSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    orderBy: (t) => t.selectionIndex,
    include: CharacterSpellSelectionRecord.include(
      classEntry: CharacterClassEntryRecord.include(
        classData: ClassData.include(),
        subclass: SubclassData.include(),
      ),
      classData: ClassData.include(),
      spell: SpellData.include(),
    ),
  );
  final spellSelections = spellSelectionRecords
      .map((record) => _toCharacterSpellSelectionData(record, entriesById))
      .toList()
    ..sort(_compareSpellSelections);
  final startingEquipmentSelectionRecords =
      await CharacterStartingEquipmentSelectionRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    orderBy: (t) => t.selectionIndex,
  );
  final selectionIds = {
    for (final selection in startingEquipmentSelectionRecords)
      if (selection.id != null) selection.id!,
  };
  final resolutionRecords = selectionIds.isEmpty
      ? const <CharacterStartingEquipmentResolutionRecord>[]
      : await CharacterStartingEquipmentResolutionRecord.db.find(
          session,
          where: (t) => t.selectionId.inSet(selectionIds),
          orderBy: (t) => t.id,
        );
  final resolutionsBySelectionId =
      <int, List<CharacterStartingEquipmentResolutionRecord>>{};
  for (final resolution in resolutionRecords) {
    final selectionId = resolution.selectionId;
    resolutionsBySelectionId.putIfAbsent(
      selectionId,
      () => <CharacterStartingEquipmentResolutionRecord>[],
    );
    resolutionsBySelectionId[selectionId]!.add(resolution);
  }
  final startingEquipmentSelections = [
    for (final selection in startingEquipmentSelectionRecords)
      _toCharacterStartingEquipmentSelectionData(
        selection,
        resolutionsBySelectionId[selection.id] ??
            const <CharacterStartingEquipmentResolutionRecord>[],
      ),
  ]..sort(_compareStartingEquipmentSelections);

  final character = _toCharacterData(record).copyWith(
    classEntries: entries,
    choices: choices,
    skillSelections: skillSelections,
    spellSelections: spellSelections,
    startingEquipmentSelections: startingEquipmentSelections,
  );
  final derived = await _buildDerivedData(session, character);
  return character.copyWith(derived: derived);
}

CharacterData _toCharacterData(CharacterRecord record) {
  return CharacterData(
    id: record.id,
    name: record.name,
    age: record.age,
    height: record.height,
    weight: record.weight,
    eyes: record.eyes,
    skin: record.skin,
    hair: record.hair,
    appearance: record.appearance,
    backstory: record.backstory,
    goals: record.goals,
    alliesOrganizations: record.alliesOrganizations,
    personalityTraits: record.personalityTraits,
    ideals: record.ideals,
    bonds: record.bonds,
    flaws: record.flaws,
    version: record.version,
    createdAt: record.createdAt,
    updatedAt: record.updatedAt,
    experience: record.experience,
    alignmentValue: record.alignmentValue,
    race: record.race,
    subrace: record.subrace,
    background: record.background,
    baseAbilityScores: record.baseAbilityScores,
    customAbilityBonuses: record.customAbilityBonuses,
    useFlexibleAbilityBonuses: record.useFlexibleAbilityBonuses,
    temporaryHp: record.temporaryHp,
    currentHp: record.currentHp,
    inspiration: record.inspiration,
    equipment: record.equipment,
    manualSkillProficiencies: record.manualSkillProficiencies,
    manualSavingThrowProficiencies: record.manualSavingThrowProficiencies,
    notes: record.notes,
    attacks: record.attacks,
    featureOverrides: record.featureOverrides,
  );
}

CharacterClassEntryData _toCharacterClassEntryData(
  CharacterClassEntryRecord record,
) {
  return CharacterClassEntryData(
    id: record.syncId,
    classData: record.classData,
    subclass: record.subclass,
    level: record.level,
    isStartingClass: record.isStartingClass,
    classOrder: record.classOrder,
    hpMode: record.hpMode,
    hpRolledValues: record.hpRolledValues,
    notes: record.notes,
    updatedAt: record.updatedAt,
  );
}

CharacterChoiceData _toCharacterChoiceData(
  CharacterChoiceRecord record,
  Map<String, CharacterClassEntryData> entriesById,
) {
  return CharacterChoiceData(
    id: record.syncId,
    classEntry: record.classEntry?.syncId == null
        ? null
        : entriesById[record.classEntry!.syncId!],
    sourceType: record.sourceType,
    sourceId: record.sourceId,
    groupKey: record.groupKey,
    optionKey: record.optionKey,
    selectionIndex: record.selectionIndex,
    selectedAbility: record.selectedAbility,
    selectedLanguage: record.selectedLanguage,
    selectedToolKey: record.selectedToolKey,
    selectedFeatId: record.selectedFeatId,
    selectedText: record.selectedText,
    selectedCount: record.selectedCount,
    updatedAt: record.updatedAt,
  );
}

CharacterSkillSelectionData _toCharacterSkillSelectionData(
  CharacterSkillSelectionRecord record,
  Map<String, CharacterClassEntryData> entriesById,
) {
  return CharacterSkillSelectionData(
    id: record.syncId,
    classEntry: record.classEntry?.syncId == null
        ? null
        : entriesById[record.classEntry!.syncId!],
    classDataId: record.classDataId,
    backgroundDataId: record.backgroundDataId,
    skill: record.skill,
    kind: record.kind,
    selectionIndex: record.selectionIndex,
    updatedAt: record.updatedAt,
  );
}

CharacterSpellSelectionData _toCharacterSpellSelectionData(
  CharacterSpellSelectionRecord record,
  Map<String, CharacterClassEntryData> entriesById,
) {
  return CharacterSpellSelectionData(
    id: record.syncId,
    classEntry: record.classEntry?.syncId == null
        ? null
        : entriesById[record.classEntry!.syncId!],
    classDataId: record.classDataId,
    spell: record.spell,
    spellId: record.spellId,
    spellKey: record.spellKey,
    kind: record.kind,
    selectionIndex: record.selectionIndex,
    updatedAt: record.updatedAt,
  );
}

CharacterStartingEquipmentSelectionData
    _toCharacterStartingEquipmentSelectionData(
  CharacterStartingEquipmentSelectionRecord record,
  List<CharacterStartingEquipmentResolutionRecord> resolutionRecords,
) {
  final resolutions = [
    for (final resolution in resolutionRecords)
      CharacterStartingEquipmentResolutionData(
        id: resolution.syncId,
        lineKey: resolution.lineKey,
        catalogType: resolution.catalogType,
        referenceKey: resolution.referenceKey,
        quantity: resolution.quantity,
        updatedAt: resolution.updatedAt,
      ),
  ]..sort(_compareStartingEquipmentResolutions);

  return CharacterStartingEquipmentSelectionData(
    id: record.syncId,
    sourceType: record.sourceType,
    sourceId: record.sourceId,
    blockKey: record.blockKey,
    optionKey: record.optionKey,
    selectionIndex: record.selectionIndex,
    resolutions: resolutions,
    updatedAt: record.updatedAt,
  );
}

Future<CharacterDerivedData> _buildDerivedData(
  Session session,
  CharacterData character,
) async {
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final choices = character.choices ?? const <CharacterChoiceData>[];
  final totalLevel =
      entries.fold<int>(0, (sum, entry) => sum + (entry.level ?? 0));
  final proficiencyBonus = totalLevel <= 0 ? 2 : 2 + ((totalLevel - 1) ~/ 4);
  final resolvedSources =
      await _resolveDerivedSources(session, character, choices);
  final currentRaceFeatures =
      _currentRaceFeaturesBySource(character, totalLevel);
  final scores = _buildAbilityScores(character, choices);
  final abilityModifiers = {
    for (final ability in Ability.values)
      ability.name: _abilityModifier(scores[ability.name] ?? 10),
  };
  final dexMod = _abilityModifier(scores['dexterity'] ?? 10);
  final conMod = _abilityModifier(scores['constitution'] ?? 10);

  final startingEntry = _resolveStartingEntry(entries);
  final defaultSavingThrowAbilities = {
    for (final ability in startingEntry?.classData?.savingThrowProficiencies ??
        const <Ability>[])
      ability.name,
  };
  final savingThrowAbilities = character.manualSavingThrowProficiencies == null
      ? defaultSavingThrowAbilities
      : {
          for (final ability
              in character.manualSavingThrowProficiencies ?? const <Ability>[])
            ability.name,
        };
  final savingThrowProficiencies = [
    for (final ability in Ability.values)
      if (savingThrowAbilities.contains(ability.name)) ability,
  ];

  final skillProficiencies = _collectSkillProficiencies(
    character,
    character.skillSelections ?? const <CharacterSkillSelectionData>[],
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final skillProficiencyLevels = character.manualSkillProficiencies == null
      ? _defaultSkillProficiencyLevels(skillProficiencies)
      : _normalizedSkillProficiencyLevels(character.manualSkillProficiencies);
  final skillBonuses = <String, int>{};
  for (final skill in Skill.values) {
    final base = _abilityModifier(scores[_abilityForSkill(skill).name] ?? 10);
    final multiplier =
        _skillProficiencyMultiplier(skillProficiencyLevels[skill]);
    skillBonuses[skill.name] = base + (proficiencyBonus * multiplier);
  }

  final savingThrowBonuses = <String, int>{};
  for (final ability in Ability.values) {
    final base = _abilityModifier(scores[ability.name] ?? 10);
    final proficient = savingThrowAbilities.contains(ability.name);
    savingThrowBonuses[ability.name] =
        base + (proficient ? proficiencyBonus : 0);
  }

  final maxHp = _calculateMaxHp(entries, conMod);
  final passivePerception = 10 + (skillBonuses[Skill.perception.name] ?? 0);
  final passiveInvestigation =
      10 + (skillBonuses[Skill.investigation.name] ?? 0);
  final passiveInsight = 10 + (skillBonuses[Skill.insight.name] ?? 0);
  final spellData = await _resolveSpellSlots(session, entries);
  final languages = _collectLanguages(
    character,
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final toolProficiencies = _collectToolProficiencies(
    character,
    entries,
    choices,
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
  );
  final armorTraining = _collectArmorTraining(
    character,
    entries,
    resolvedSources.classBackgroundOptions,
  );
  final weaponTraining = _collectWeaponTraining(
    character,
    entries,
    resolvedSources.classBackgroundOptions,
  );
  final featIds = _collectFeatIds(choices, resolvedSources.raceOptions);
  final featTags = await _loadFeatTags(session, featIds);
  final featureTags = _collectFeatureTags(
    character: character,
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
    featTags: featTags,
  );
  final activeFeatures = _buildActiveFeatures(
    character: character,
    resolvedSources: resolvedSources,
    currentRaceFeatures: currentRaceFeatures,
  );
  final grantedSpellKeys = _collectGrantedSpellKeys(
    character.spellSelections ?? const <CharacterSpellSelectionData>[],
    resolvedSources.classBackgroundOptions,
    resolvedSources.raceOptions,
    currentRaceFeatures,
  );
  final grantedEquipment = await _collectGrantedEquipment(session, character);
  final hitDiceSummary = <String, int>{};
  for (final entry in entries) {
    final hitDie = _resolveHitDie(entry.classData);
    final level = entry.level ?? 0;
    if (hitDie != null && level > 0) {
      final key = 'd$hitDie';
      hitDiceSummary[key] = (hitDiceSummary[key] ?? 0) + level;
    }
  }

  final senses = <String>[
    if (character.race?.visionType != null) character.race!.visionType!.name,
  ];
  final resistances = _collectDamageTypes(character, choices);

  return CharacterDerivedData(
    totalLevel: totalLevel,
    proficiencyBonus: proficiencyBonus,
    abilityScores: scores,
    abilityModifiers: abilityModifiers,
    activeFeatures: activeFeatures,
    armorClass: 10 + dexMod,
    initiative: dexMod,
    speed: character.race?.speed ?? 30,
    maxHp: maxHp,
    passivePerception: passivePerception,
    passiveInvestigation: passiveInvestigation,
    passiveInsight: passiveInsight,
    savingThrowBonuses: savingThrowBonuses,
    skillBonuses: skillBonuses,
    skillProficiencyLevels: _skillProficiencyStateList(skillProficiencyLevels),
    savingThrowProficiencies: savingThrowProficiencies,
    spellSlots: spellData.spellSlots,
    pactSlots: spellData.pactSlots,
    hitDiceSummary: hitDiceSummary,
    languages: languages,
    toolProficiencies: toolProficiencies,
    armorTraining: armorTraining,
    weaponTraining: weaponTraining,
    featureTags: featureTags,
    featIds: featIds,
    grantedSpellKeys: grantedSpellKeys,
    grantedEquipment: grantedEquipment,
    senses: senses,
    resistances: resistances,
    rebuiltAt: DateTime.now(),
  );
}

Map<String, int> _buildAbilityScores(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final scores = <String, int>{
    for (final ability in Ability.values) ability.name: 10,
    ...?character.baseAbilityScores,
  };

  final raceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.race,
    character.race?.id,
  );
  final subraceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.subrace,
    character.subrace?.id,
  );
  final activeBonusMode = _resolveActiveBonusMode(raceChoices);
  final activeRaceChoices = _filterChoicesForActiveBonusMode(
    raceChoices,
    activeBonusMode,
  );
  final activeSubraceChoices = _filterChoicesForActiveBonusMode(
    subraceChoices,
    activeBonusMode,
  );
  final usesFlexibleBonuses =
      activeBonusMode == _BonusMode.flexiblePlusTwoOne ||
          activeBonusMode == _BonusMode.flexibleThreePlusOne;

  if (!usesFlexibleBonuses) {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromRace(character.race),
    );
  }
  _applyRacialChoiceBonuses(scores, activeRaceChoices);

  if (usesFlexibleBonuses) {
    // Flexible +2/+1 replaces both the race and subrace default bonuses.
  } else {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromSubrace(character.subrace),
    );
  }
  _applyRacialChoiceBonuses(scores, activeSubraceChoices);

  _applyCustomAbilityBonuses(scores, character.customAbilityBonuses);

  return scores;
}

void _applyCustomAbilityBonuses(
  Map<String, int> scores,
  Map<String, int>? bonuses,
) {
  if (bonuses == null) {
    return;
  }

  for (final entry in bonuses.entries) {
    final abilityKey = _normalizeAbilityKey(entry.key);
    if (abilityKey == null || entry.value == 0) {
      continue;
    }
    scores[abilityKey] = (scores[abilityKey] ?? 10) + entry.value;
  }
}

enum _BonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

_BonusMode _resolveActiveBonusMode(List<CharacterChoiceData> raceChoices) {
  for (final choice in raceChoices) {
    if (choice.groupKey != 'race_bonus_mode') continue;

    switch (choice.selectedText) {
      case 'flexiblePlusTwoOne':
        return _BonusMode.flexiblePlusTwoOne;
      case 'flexibleThreePlusOne':
        return _BonusMode.flexibleThreePlusOne;
      case 'racial':
      default:
        return _BonusMode.racial;
    }
  }

  return _BonusMode.racial;
}

List<CharacterChoiceData> _filterChoicesForActiveBonusMode(
  List<CharacterChoiceData> choices,
  _BonusMode activeMode,
) {
  return choices.where((choice) {
    final groupKey = choice.groupKey;
    if (groupKey == null || groupKey == 'race_bonus_mode') {
      return false;
    }

    final isFlexible = groupKey.startsWith('race_flexible_bonus');
    switch (activeMode) {
      case _BonusMode.racial:
        return !isFlexible;
      case _BonusMode.flexiblePlusTwoOne:
        return groupKey == 'race_flexible_bonus_plus2' ||
            groupKey == 'race_flexible_bonus_plus1';
      case _BonusMode.flexibleThreePlusOne:
        return groupKey == 'race_flexible_bonus_three_plus1';
    }
  }).toList();
}

List<CharacterChoiceData> _racialChoicesForSource(
  List<CharacterChoiceData> choices,
  ChoiceSourceType sourceType,
  int? sourceId,
) {
  if (sourceId == null) {
    return const [];
  }

  return choices.where((choice) {
    return choice.sourceType == sourceType && choice.sourceId == sourceId;
  }).toList();
}

void _applyRacialChoiceBonuses(
  Map<String, int> scores,
  List<CharacterChoiceData> choices,
) {
  for (final choice in choices) {
    final bonus = choice.selectedCount ?? 0;
    final key = choice.selectedAbility?.name ?? choice.optionKey?.trim();
    if (key == null || key.isEmpty || bonus == 0) {
      continue;
    }

    final abilityKey = _normalizeAbilityKey(key);
    if (abilityKey == null) continue;

    scores[abilityKey] = (scores[abilityKey] ?? 10) + bonus;
  }
}

String? _normalizeAbilityKey(String raw) {
  for (final ability in Ability.values) {
    if (ability.name == raw) {
      return ability.name;
    }
  }
  return null;
}

Set<Skill> _collectSkillProficiencies(
  CharacterData character,
  List<CharacterSkillSelectionData> skillSelections,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final skills = <Skill>{};
  _addSkillNames(skills, character.race?.skillProficiencies);
  _addSkillNames(skills, character.subrace?.skillProficiencies);
  _addSkillNames(skills, character.background?.skillProficiencies);

  for (final selection in skillSelections) {
    final skill = selection.skill;
    if (skill != null) {
      skills.add(skill);
    }
  }

  for (final option in classBackgroundOptions) {
    skills.addAll(option.grantedSkills ?? const <Skill>[]);
  }

  for (final option in raceOptions) {
    if (option.skill != null) {
      skills.add(option.skill!);
    }
  }

  return skills;
}

Map<Skill, CharacterSkillProficiencyLevel> _defaultSkillProficiencyLevels(
  Set<Skill> skillProficiencies,
) {
  return {
    for (final skill in Skill.values)
      skill: skillProficiencies.contains(skill)
          ? CharacterSkillProficiencyLevel.proficient
          : CharacterSkillProficiencyLevel.none,
  };
}

Map<Skill, CharacterSkillProficiencyLevel> _normalizedSkillProficiencyLevels(
  List<CharacterSkillProficiencyState>? states,
) {
  final levels = {
    for (final skill in Skill.values)
      skill: CharacterSkillProficiencyLevel.none,
  };
  for (final state in states ?? const <CharacterSkillProficiencyState>[]) {
    levels[state.skill] = state.level;
  }
  return levels;
}

List<CharacterSkillProficiencyState> _skillProficiencyStateList(
  Map<Skill, CharacterSkillProficiencyLevel> levels,
) {
  return [
    for (final skill in Skill.values)
      CharacterSkillProficiencyState(
        skill: skill,
        level: levels[skill] ?? CharacterSkillProficiencyLevel.none,
      ),
  ];
}

int _skillProficiencyMultiplier(CharacterSkillProficiencyLevel? level) {
  switch (level) {
    case CharacterSkillProficiencyLevel.proficient:
      return 1;
    case CharacterSkillProficiencyLevel.expertise:
      return 2;
    case CharacterSkillProficiencyLevel.none:
    case null:
      return 0;
  }
}

CharacterClassEntryData? _resolveStartingEntry(
  List<CharacterClassEntryData> entries,
) {
  for (final entry in entries) {
    if (entry.isStartingClass == true) {
      return entry;
    }
  }
  if (entries.isEmpty) return null;
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  return sortedEntries.first;
}

int _calculateMaxHp(List<CharacterClassEntryData> entries, int conModifier) {
  final sortedEntries = [...entries]
    ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
  var total = 0;
  var consumedFirstCharacterLevel = false;

  for (final entry in sortedEntries) {
    final hitDie = _resolveHitDie(entry.classData) ?? 0;
    final fixedGain = max(1, (hitDie ~/ 2) + 1);
    final rolledValues = entry.hpRolledValues ?? const <int>[];
    final level = entry.level ?? 0;

    for (var levelIndex = 0; levelIndex < level; levelIndex++) {
      final isFirstCharacterLevel = !consumedFirstCharacterLevel;
      final rollValue = levelIndex < rolledValues.length
          ? rolledValues[levelIndex]
          : fixedGain;

      total += (isFirstCharacterLevel ? hitDie : rollValue) + conModifier;
      consumedFirstCharacterLevel = true;
    }
  }

  return max(total, 1);
}

Future<_SpellSlotData> _resolveSpellSlots(
  Session session,
  List<CharacterClassEntryData> entries,
) async {
  Map<int, int>? spellSlots;
  Map<int, int>? pactSlots;

  for (final entry in entries) {
    final classData = entry.classData;
    final level = entry.level;
    if (classData == null ||
        classData.spellcastingProgression == null ||
        classData.id == null ||
        level == null) {
      continue;
    }

    final rows = await ClassLevelData.db.find(
      session,
      where: (t) => t.classDataId.equals(classData.id),
    );
    ClassLevelData? match;
    for (final row in rows) {
      if (row.level == level) {
        match = row;
        break;
      }
    }
    if (match == null) continue;

    if (classData.spellcastingProgression ==
        SpellcastingProgression.pactMagic) {
      pactSlots = match.spellSlots;
    } else {
      spellSlots ??= match.spellSlots;
    }
  }

  return _SpellSlotData(
    spellSlots: spellSlots,
    pactSlots: pactSlots,
  );
}

class _SpellSlotData {
  final Map<int, int>? spellSlots;
  final Map<int, int>? pactSlots;

  const _SpellSlotData({
    required this.spellSlots,
    required this.pactSlots,
  });
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

class _ResolvedDerivedSources {
  final List<ClassChoiceOptionData> classBackgroundOptions;
  final List<RaceChoiceOptionData> raceOptions;
  final List<ClassFeatureData> currentClassFeatures;
  final List<SubclassFeatureData> currentSubclassFeatures;

  const _ResolvedDerivedSources({
    required this.classBackgroundOptions,
    required this.raceOptions,
    required this.currentClassFeatures,
    required this.currentSubclassFeatures,
  });
}

class _CurrentRaceFeatures {
  final List<RaceFeatureData> raceFeatures;
  final List<RaceFeatureData> subraceFeatures;

  const _CurrentRaceFeatures({
    required this.raceFeatures,
    required this.subraceFeatures,
  });
}

class _ResolvedStartingEquipmentSources {
  final Map<String, StartingEquipmentBlockData> blocksBySourceKey;
  final Map<String, StartingEquipmentOptionData> optionsBySourceKey;
  final Map<int, List<StartingEquipmentLineData>> fixedLinesByBlockId;
  final Map<int, List<StartingEquipmentLineData>> linesByOptionId;

  const _ResolvedStartingEquipmentSources({
    required this.blocksBySourceKey,
    required this.optionsBySourceKey,
    required this.fixedLinesByBlockId,
    required this.linesByOptionId,
  });
}

class _GrantedEquipmentAccumulator {
  _GrantedEquipmentAccumulator({
    required this.catalogType,
    required this.referenceKey,
    required this.displayText,
    required this.quantity,
  });

  final EquipmentCatalogType catalogType;
  final String referenceKey;
  String displayText;
  int quantity;
}

Future<_ResolvedDerivedSources> _resolveDerivedSources(
  Session session,
  CharacterData character,
  List<CharacterChoiceData> choices,
) async {
  final entries = character.classEntries ?? const <CharacterClassEntryData>[];
  final currentClassFeatures = <ClassFeatureData>[];
  final currentSubclassFeatures = <SubclassFeatureData>[];
  final classLevels = <int, int>{};
  final subclassLevels = <int, int>{};

  for (final entry in entries) {
    final level = entry.level ?? 0;
    final classId = entry.classData?.id;
    if (classId != null) {
      classLevels[classId] = max(classLevels[classId] ?? 0, level);
      currentClassFeatures.addAll(
        await ClassFeatureData.db.find(
          session,
          where: (t) => t.parentClassId.equals(classId) & (t.level <= level),
          orderBy: (t) => t.level,
        ),
      );
    }

    final subclassId = entry.subclass?.id;
    if (subclassId != null) {
      subclassLevels[subclassId] = max(subclassLevels[subclassId] ?? 0, level);
      currentSubclassFeatures.addAll(
        await SubclassFeatureData.db.find(
          session,
          where: (t) =>
              t.parentSubclassId.equals(subclassId) & (t.level <= level),
          orderBy: (t) => t.level,
        ),
      );
    }
  }

  final currentClassFeatureIds = {
    for (final feature in currentClassFeatures)
      if (feature.id != null) feature.id!,
  };
  final currentSubclassFeatureIds = {
    for (final feature in currentSubclassFeatures)
      if (feature.id != null) feature.id!,
  };

  final allGroups = await ClassChoiceGroupData.db.find(
    session,
    orderBy: (t) => t.id,
  );
  final relevantGroups = allGroups.where((group) {
    final groupLevel = group.level ?? 1;
    final byClass = group.sourceClassId != null &&
        (classLevels[group.sourceClassId!] ?? 0) >= groupLevel;
    final bySubclass = group.sourceSubclassId != null &&
        (subclassLevels[group.sourceSubclassId!] ?? 0) >= groupLevel;
    final byFeature = group.sourceFeatureId != null &&
        currentClassFeatureIds.contains(group.sourceFeatureId);
    final bySubclassFeature = group.sourceSubclassFeatureId != null &&
        currentSubclassFeatureIds.contains(group.sourceSubclassFeatureId);
    final byBackground = group.sourceBackgroundId != null &&
        group.sourceBackgroundId == character.background?.id;

    return byClass ||
        bySubclass ||
        byFeature ||
        bySubclassFeature ||
        byBackground;
  }).toList();

  final optionsByGroupKey = <String, Map<String, ClassChoiceOptionData>>{};
  for (final group in relevantGroups) {
    final groupId = group.id;
    if (groupId == null) continue;

    final options = await ClassChoiceOptionData.db.find(
      session,
      where: (t) => t.choiceGroupId.equals(groupId),
    );
    optionsByGroupKey[_classChoiceGroupKey(group)] = {
      for (final option in options)
        if (_normalizedTextOrNull(option.optionKey) != null)
          option.optionKey!.trim(): option,
    };
  }

  final classBackgroundOptions = <ClassChoiceOptionData>[];
  for (final choice in choices.where(_isClassOrBackgroundChoice)) {
    final groupKey = choice.groupKey;
    final optionKey = _normalizedTextOrNull(choice.optionKey);
    if (groupKey == null || optionKey == null) continue;

    final option = optionsByGroupKey[groupKey]?[optionKey];
    if (option != null) {
      classBackgroundOptions.add(option);
    }
  }

  return _ResolvedDerivedSources(
    classBackgroundOptions: classBackgroundOptions,
    raceOptions: _selectedRaceChoiceOptions(character, choices),
    currentClassFeatures: currentClassFeatures,
    currentSubclassFeatures: currentSubclassFeatures,
  );
}

void _addSkillNames(Set<Skill> target, List<String>? names) {
  for (final name in names ?? const <String>[]) {
    final skill = _skillFromName(name);
    if (skill != null) {
      target.add(skill);
    }
  }
}

Skill? _skillFromName(String raw) {
  final normalized = raw.trim();
  for (final value in Skill.values) {
    if (value.name == normalized) {
      return value;
    }
  }
  return null;
}

List<String> _collectLanguages(
  CharacterData character,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.languages));

  for (final option in classBackgroundOptions) {
    values.addAll([
      for (final language in option.grantedLanguages ?? const <Language>[])
        language.name,
    ]);
  }
  for (final option in raceOptions) {
    if (option.language != null) {
      values.add(option.language!.name);
    }
  }
  for (final choice in choices) {
    if (choice.selectedLanguage != null) {
      values.add(choice.selectedLanguage!.name);
      continue;
    }

    final legacyLanguage = _languageFromName(choice.selectedText ?? '');
    if (legacyLanguage != null) {
      values.add(legacyLanguage.name);
    }
  }

  return values.toList()..sort();
}

List<String> _collectToolProficiencies(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<CharacterChoiceData> choices,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.toolProficiencies));
  values.addAll(_normalizedTexts(character.subrace?.toolProficiencies));
  values.addAll(_normalizedTexts(character.background?.toolProficiencies));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final isStarting = entry.isStartingClass ?? false;
    values.addAll(_normalizedTexts(
      isStarting ? classData.toolTraining : classData.multiclassToolTraining,
    ));
  }
  for (final option in classBackgroundOptions) {
    values.addAll(_normalizedTexts(option.grantedToolKeys));
  }
  for (final option in raceOptions) {
    final toolKey = _normalizedTextOrNull(option.toolKey);
    if (toolKey != null) {
      values.add(toolKey);
    }
  }
  for (final choice in choices) {
    final toolKey = _normalizedTextOrNull(choice.selectedToolKey);
    if (toolKey != null) {
      values.add(toolKey);
    }
  }

  return values.toList()..sort();
}

List<String> _collectArmorTraining(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassChoiceOptionData> classBackgroundOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.armorProficiencies));
  values.addAll(_normalizedTexts(character.subrace?.armorProficiencies));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.armorTraining
        : classData.multiclassArmorTraining;
    values.addAll([
      for (final training in source ?? const <ArmorCategory>[]) training.name,
    ]);
  }
  for (final option in classBackgroundOptions) {
    values.addAll([
      for (final training
          in option.grantedArmorTraining ?? const <ArmorCategory>[])
        training.name,
    ]);
  }

  return values.toList()..sort();
}

List<String> _collectWeaponTraining(
  CharacterData character,
  List<CharacterClassEntryData> entries,
  List<ClassChoiceOptionData> classBackgroundOptions,
) {
  final values = <String>{};
  values.addAll(_normalizedTexts(character.race?.weaponProficiencies));
  values.addAll(_normalizedTexts(character.subrace?.weaponProficiencies));

  for (final entry in entries) {
    final classData = entry.classData;
    if (classData == null) continue;
    final source = (entry.isStartingClass ?? false)
        ? classData.weaponTraining
        : classData.multiclassWeaponTraining;
    values.addAll([
      for (final training in source ?? const <WeaponCategory>[]) training.name,
    ]);
  }
  for (final option in classBackgroundOptions) {
    values.addAll([
      for (final training
          in option.grantedWeaponTraining ?? const <WeaponCategory>[])
        training.name,
    ]);
  }

  return values.toList()..sort();
}

List<int> _collectFeatIds(
  List<CharacterChoiceData> choices,
  List<RaceChoiceOptionData> raceOptions,
) {
  final values = <int>{
    for (final choice in choices)
      if (choice.selectedFeatId != null) choice.selectedFeatId!,
    for (final option in raceOptions)
      if (option.featId != null) option.featId!,
  };
  return values.toList()..sort();
}

Future<Set<FeatureTag>> _loadFeatTags(
  Session session,
  List<int> featIds,
) async {
  if (featIds.isEmpty) {
    return const <FeatureTag>{};
  }

  final feats = await FeatData.db.find(
    session,
    where: (t) => t.id.inSet(featIds.toSet()),
  );
  return {
    for (final feat in feats) ...?feat.tags,
  };
}

List<FeatureTag> _collectFeatureTags({
  required CharacterData character,
  required _ResolvedDerivedSources resolvedSources,
  required _CurrentRaceFeatures currentRaceFeatures,
  required Set<FeatureTag> featTags,
}) {
  final values = <FeatureTag>{
    ...featTags,
    for (final feature in resolvedSources.currentClassFeatures)
      ...?feature.tags,
    for (final feature in resolvedSources.currentSubclassFeatures)
      ...?feature.tags,
    for (final feature in currentRaceFeatures.raceFeatures) ...?feature.tags,
    for (final feature in currentRaceFeatures.subraceFeatures) ...?feature.tags,
    for (final option in resolvedSources.classBackgroundOptions)
      ...?option.grantedFeatureTags,
    for (final option in resolvedSources.raceOptions)
      ...?option.grantedFeatureTags,
  };

  final list = values.toList()..sort((a, b) => a.name.compareTo(b.name));
  return list;
}

List<String> _collectGrantedSpellKeys(
  List<CharacterSpellSelectionData> spellSelections,
  List<ClassChoiceOptionData> classBackgroundOptions,
  List<RaceChoiceOptionData> raceOptions,
  _CurrentRaceFeatures currentRaceFeatures,
) {
  final values = <String>{};
  for (final selection in spellSelections) {
    final spellKey = _normalizedTextOrNull(selection.spellKey) ??
        _normalizedTextOrNull(selection.spell?.referenceKey) ??
        _normalizedTextOrNull(selection.spell?.name);
    if (spellKey != null) {
      values.add(spellKey);
    }
  }
  for (final option in classBackgroundOptions) {
    values.addAll(_normalizedTexts(option.grantedSpellKeys));
  }
  for (final option in raceOptions) {
    final spellName = _normalizedTextOrNull(option.spell?.name);
    if (spellName != null) {
      values.add(spellName);
    }
  }
  for (final feature in [
    ...currentRaceFeatures.raceFeatures,
    ...currentRaceFeatures.subraceFeatures,
  ]) {
    for (final grant
        in feature.spellGrants ?? const <RaceFeatureSpellGrantData>[]) {
      final spellName = _normalizedTextOrNull(grant.spell?.name);
      if (spellName != null) {
        values.add(spellName);
      }
    }
  }
  return values.toList()..sort();
}

Future<List<CharacterEquipmentEntryView>> _collectGrantedEquipment(
  Session session,
  CharacterData character,
) async {
  final resolvedSources =
      await _resolveStartingEquipmentSources(session, character);
  if (resolvedSources.blocksBySourceKey.isEmpty) {
    return const <CharacterEquipmentEntryView>[];
  }

  final selections = character.startingEquipmentSelections ??
      const <CharacterStartingEquipmentSelectionData>[];
  final accumulated = <String, _GrantedEquipmentAccumulator>{};

  for (final entry in resolvedSources.blocksBySourceKey.entries) {
    final block = entry.value;
    final sourceSelections =
        _matchingStartingEquipmentSelections(selections, block);
    final blockLines = block.id == null
        ? const <StartingEquipmentLineData>[]
        : resolvedSources.fixedLinesByBlockId[block.id!] ??
            const <StartingEquipmentLineData>[];

    if (block.kind == StartingEquipmentBlockKind.choice) {
      await _applyStartingEquipmentLines(
        session,
        blockLines,
        _collectBlockLevelResolutions(sourceSelections),
        accumulated,
      );

      for (final selection in sourceSelections) {
        final optionKey = _normalizedTextOrNull(selection.optionKey);
        if (optionKey == null) {
          continue;
        }

        final option = resolvedSources
            .optionsBySourceKey[_startingEquipmentOptionSourceKey(
          selection.sourceType,
          selection.sourceId,
          selection.blockKey,
          optionKey,
        )];
        if (option?.id == null) {
          continue;
        }

        await _applyStartingEquipmentLines(
          session,
          resolvedSources.linesByOptionId[option!.id!] ??
              const <StartingEquipmentLineData>[],
          selection.resolutions ??
              const <CharacterStartingEquipmentResolutionData>[],
          accumulated,
        );
      }
      continue;
    }

    await _applyStartingEquipmentLines(
      session,
      blockLines,
      _collectBlockLevelResolutions(sourceSelections),
      accumulated,
    );
  }

  final result = [
    for (final item in accumulated.values)
      CharacterEquipmentEntryView(
        catalogType: item.catalogType,
        referenceKey: item.referenceKey,
        displayText: item.displayText,
        quantity: item.quantity,
      ),
  ]..sort(
      (a, b) {
        final textCompare =
            (a.displayText ?? '').compareTo(b.displayText ?? '');
        if (textCompare != 0) {
          return textCompare;
        }
        final typeCompare =
            (a.catalogType?.name ?? '').compareTo(b.catalogType?.name ?? '');
        if (typeCompare != 0) {
          return typeCompare;
        }
        return (a.referenceKey ?? '').compareTo(b.referenceKey ?? '');
      },
    );
  return result;
}

Future<_ResolvedStartingEquipmentSources> _resolveStartingEquipmentSources(
  Session session,
  CharacterData character,
) async {
  final startingClassId = _resolveStartingEntry(
          character.classEntries ?? const <CharacterClassEntryData>[])
      ?.classData
      ?.id;
  final backgroundId = character.background?.id;
  if (startingClassId == null && backgroundId == null) {
    return const _ResolvedStartingEquipmentSources(
      blocksBySourceKey: <String, StartingEquipmentBlockData>{},
      optionsBySourceKey: <String, StartingEquipmentOptionData>{},
      fixedLinesByBlockId: <int, List<StartingEquipmentLineData>>{},
      linesByOptionId: <int, List<StartingEquipmentLineData>>{},
    );
  }

  final blocks = await _loadRelevantStartingEquipmentBlocks(
    session,
    sourceClassId: startingClassId,
    sourceBackgroundId: backgroundId,
  );
  if (blocks.isEmpty) {
    return const _ResolvedStartingEquipmentSources(
      blocksBySourceKey: <String, StartingEquipmentBlockData>{},
      optionsBySourceKey: <String, StartingEquipmentOptionData>{},
      fixedLinesByBlockId: <int, List<StartingEquipmentLineData>>{},
      linesByOptionId: <int, List<StartingEquipmentLineData>>{},
    );
  }

  final blockIds = {
    for (final block in blocks)
      if (block.id != null) block.id!,
  };
  final options = blockIds.isEmpty
      ? const <StartingEquipmentOptionData>[]
      : await StartingEquipmentOptionData.db.find(
          session,
          where: (t) => t.blockId.inSet(blockIds),
          orderBy: (t) => t.orderIndex,
        );
  final optionIds = {
    for (final option in options)
      if (option.id != null) option.id!,
  };
  final lines = (blockIds.isEmpty && optionIds.isEmpty)
      ? const <StartingEquipmentLineData>[]
      : await StartingEquipmentLineData.db.find(
          session,
          where: (t) => t.blockId.inSet(blockIds) | t.optionId.inSet(optionIds),
          orderBy: (t) => t.orderIndex,
        );

  final blockById = {
    for (final block in blocks)
      if (block.id != null) block.id!: block,
  };
  final blocksBySourceKey = <String, StartingEquipmentBlockData>{};
  for (final block in blocks) {
    final blockKey = _normalizedTextOrNull(block.blockKey);
    final sourceType = _startingEquipmentSourceTypeForBlock(block);
    final sourceId = _startingEquipmentSourceIdForBlock(block);
    if (blockKey == null || sourceType == null || sourceId == null) {
      continue;
    }
    blocksBySourceKey[
            _startingEquipmentBlockSourceKey(sourceType, sourceId, blockKey)] =
        block;
  }

  final optionsBySourceKey = <String, StartingEquipmentOptionData>{};
  for (final option in options) {
    final optionKey = _normalizedTextOrNull(option.optionKey);
    final block = blockById[option.blockId];
    final blockKey = _normalizedTextOrNull(block?.blockKey);
    final sourceType =
        block == null ? null : _startingEquipmentSourceTypeForBlock(block);
    final sourceId =
        block == null ? null : _startingEquipmentSourceIdForBlock(block);
    if (optionKey == null ||
        blockKey == null ||
        sourceType == null ||
        sourceId == null) {
      continue;
    }
    optionsBySourceKey[_startingEquipmentOptionSourceKey(
      sourceType,
      sourceId,
      blockKey,
      optionKey,
    )] = option;
  }

  final fixedLinesByBlockId = <int, List<StartingEquipmentLineData>>{};
  final linesByOptionId = <int, List<StartingEquipmentLineData>>{};
  for (final line in lines) {
    final blockId = line.blockId;
    if (blockId != null) {
      fixedLinesByBlockId.putIfAbsent(
        blockId,
        () => <StartingEquipmentLineData>[],
      );
      fixedLinesByBlockId[blockId]!.add(line);
    }
    final optionId = line.optionId;
    if (optionId != null) {
      linesByOptionId.putIfAbsent(
        optionId,
        () => <StartingEquipmentLineData>[],
      );
      linesByOptionId[optionId]!.add(line);
    }
  }

  return _ResolvedStartingEquipmentSources(
    blocksBySourceKey: blocksBySourceKey,
    optionsBySourceKey: optionsBySourceKey,
    fixedLinesByBlockId: fixedLinesByBlockId,
    linesByOptionId: linesByOptionId,
  );
}

Future<List<StartingEquipmentBlockData>> _loadRelevantStartingEquipmentBlocks(
  Session session, {
  int? sourceClassId,
  int? sourceBackgroundId,
}) async {
  if (sourceClassId != null && sourceBackgroundId != null) {
    return StartingEquipmentBlockData.db.find(
      session,
      where: (t) =>
          t.sourceClassId.equals(sourceClassId) |
          t.sourceBackgroundId.equals(sourceBackgroundId),
      orderBy: (t) => t.orderIndex,
    );
  }
  if (sourceClassId != null) {
    return StartingEquipmentBlockData.db.find(
      session,
      where: (t) => t.sourceClassId.equals(sourceClassId),
      orderBy: (t) => t.orderIndex,
    );
  }
  if (sourceBackgroundId != null) {
    return StartingEquipmentBlockData.db.find(
      session,
      where: (t) => t.sourceBackgroundId.equals(sourceBackgroundId),
      orderBy: (t) => t.orderIndex,
    );
  }
  return const <StartingEquipmentBlockData>[];
}

List<CharacterStartingEquipmentSelectionData>
    _matchingStartingEquipmentSelections(
  List<CharacterStartingEquipmentSelectionData> selections,
  StartingEquipmentBlockData block,
) {
  final blockKey = _normalizedTextOrNull(block.blockKey);
  final sourceType = _startingEquipmentSourceTypeForBlock(block);
  final sourceId = _startingEquipmentSourceIdForBlock(block);
  if (blockKey == null || sourceType == null || sourceId == null) {
    return const <CharacterStartingEquipmentSelectionData>[];
  }

  return [
    for (final selection in selections)
      if (selection.sourceType == sourceType &&
          selection.sourceId == sourceId &&
          _normalizedTextOrNull(selection.blockKey) == blockKey)
        selection,
  ]..sort(_compareStartingEquipmentSelections);
}

List<CharacterStartingEquipmentResolutionData> _collectBlockLevelResolutions(
  List<CharacterStartingEquipmentSelectionData> selections,
) {
  final resolutions = <CharacterStartingEquipmentResolutionData>[];
  for (final selection in selections) {
    if (_normalizedTextOrNull(selection.optionKey) != null) {
      continue;
    }
    resolutions.addAll(
      selection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[],
    );
  }
  resolutions.sort(_compareStartingEquipmentResolutions);
  return resolutions;
}

Future<void> _applyStartingEquipmentLines(
  Session session,
  List<StartingEquipmentLineData> lines,
  List<CharacterStartingEquipmentResolutionData> resolutions,
  Map<String, _GrantedEquipmentAccumulator> accumulated,
) async {
  final resolutionsByLineKey =
      <String, CharacterStartingEquipmentResolutionData>{};
  for (final resolution in resolutions) {
    final lineKey = _normalizedTextOrNull(resolution.lineKey);
    if (lineKey == null) {
      continue;
    }
    resolutionsByLineKey[lineKey] = resolution;
  }

  for (final line in lines) {
    switch (line.kind) {
      case StartingEquipmentLineKind.catalogRef:
        final catalogType = line.catalogType;
        final referenceKey = _normalizedTextOrNull(line.referenceKey);
        if (catalogType == null || referenceKey == null) {
          continue;
        }
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: catalogType,
          referenceKey: referenceKey,
          displayText: _normalizedTextOrNull(line.displayText) ?? referenceKey,
          quantity: _normalizedPositiveQuantity(line.quantity),
        );
        break;
      case StartingEquipmentLineKind.weaponCategory:
        final lineKey = _normalizedTextOrNull(line.lineKey);
        if (lineKey == null) {
          continue;
        }
        final resolution = resolutionsByLineKey[lineKey];
        if (resolution == null) {
          continue;
        }
        final resolved = await _resolveWeaponCategorySelection(
          session,
          line,
          resolution,
        );
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: resolved.catalogType,
          referenceKey: resolved.referenceKey,
          displayText: resolved.displayText,
          quantity: resolved.quantity,
        );
        break;
      case StartingEquipmentLineKind.itemCategory:
        final lineKey = _normalizedTextOrNull(line.lineKey);
        if (lineKey == null) {
          continue;
        }
        final resolution = resolutionsByLineKey[lineKey];
        if (resolution == null) {
          continue;
        }
        final resolved = await _resolveItemCategorySelection(
          session,
          line,
          resolution,
        );
        _accumulateGrantedEquipment(
          accumulated,
          catalogType: resolved.catalogType,
          referenceKey: resolved.referenceKey,
          displayText: resolved.displayText,
          quantity: resolved.quantity,
        );
        break;
      case null:
        continue;
    }
  }
}

void _accumulateGrantedEquipment(
  Map<String, _GrantedEquipmentAccumulator> accumulated, {
  required EquipmentCatalogType catalogType,
  required String referenceKey,
  required String displayText,
  required int quantity,
}) {
  final key = '${catalogType.name}:$referenceKey';
  final existing = accumulated[key];
  if (existing == null) {
    accumulated[key] = _GrantedEquipmentAccumulator(
      catalogType: catalogType,
      referenceKey: referenceKey,
      displayText: displayText,
      quantity: quantity,
    );
    return;
  }

  existing.quantity += quantity;
  if (existing.displayText.trim().isEmpty) {
    existing.displayText = displayText;
  }
}

Future<_GrantedEquipmentAccumulator> _resolveWeaponCategorySelection(
  Session session,
  StartingEquipmentLineData line,
  CharacterStartingEquipmentResolutionData resolution,
) async {
  if (resolution.catalogType != EquipmentCatalogType.weapon) {
    throw Exception(
      'Starting equipment line "${line.lineKey}" requires a weapon resolution.',
    );
  }

  final referenceKey = _normalizedTextOrNull(resolution.referenceKey);
  if (referenceKey == null) {
    throw Exception(
      'Starting equipment line "${line.lineKey}" requires weapon referenceKey.',
    );
  }

  final rows = await WeaponData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (rows.isEmpty) {
    throw Exception(
      'Weapon referenceKey="$referenceKey" was not found for starting equipment.',
    );
  }

  final weapon = rows.first;
  final allowed = line.allowedWeaponCategories ?? const <WeaponCategory>[];
  if (allowed.isNotEmpty && !allowed.contains(weapon.category)) {
    throw Exception(
      'Weapon "$referenceKey" is not allowed for starting equipment line "${line.lineKey}".',
    );
  }

  return _GrantedEquipmentAccumulator(
    catalogType: EquipmentCatalogType.weapon,
    referenceKey: referenceKey,
    displayText: _normalizedTextOrNull(weapon.name) ?? referenceKey,
    quantity: _normalizedPositiveQuantity(resolution.quantity,
        fallback: line.quantity),
  );
}

Future<_GrantedEquipmentAccumulator> _resolveItemCategorySelection(
  Session session,
  StartingEquipmentLineData line,
  CharacterStartingEquipmentResolutionData resolution,
) async {
  if (resolution.catalogType != EquipmentCatalogType.item) {
    throw Exception(
      'Starting equipment line "${line.lineKey}" requires an item resolution.',
    );
  }

  final referenceKey = _normalizedTextOrNull(resolution.referenceKey);
  if (referenceKey == null) {
    throw Exception(
      'Starting equipment line "${line.lineKey}" requires item referenceKey.',
    );
  }

  final rows = await ItemData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (rows.isEmpty) {
    throw Exception(
      'Item referenceKey="$referenceKey" was not found for starting equipment.',
    );
  }

  final item = rows.first;
  final itemCategory = _normalizedTextOrNull(item.category);
  final allowedCategories = {
    for (final category in line.allowedItemCategories ?? const <String>[])
      if (_normalizedTextOrNull(category) != null)
        _normalizedTextOrNull(category)!,
  };
  if (allowedCategories.isNotEmpty &&
      (itemCategory == null || !allowedCategories.contains(itemCategory))) {
    throw Exception(
      'Item "$referenceKey" is not allowed for starting equipment line "${line.lineKey}".',
    );
  }

  return _GrantedEquipmentAccumulator(
    catalogType: EquipmentCatalogType.item,
    referenceKey: referenceKey,
    displayText: _normalizedTextOrNull(item.name) ?? referenceKey,
    quantity: _normalizedPositiveQuantity(resolution.quantity,
        fallback: line.quantity),
  );
}

List<DamageType> _collectDamageTypes(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final values = <DamageType>{};
  values.addAll([
    ...?character.race?.resistances,
    ...?character.subrace?.resistances,
  ]);
  for (final option in _selectedRaceChoiceOptions(character, choices)) {
    if (option.damageType != null) {
      values.add(option.damageType!);
    }
  }
  return values.toList()..sort((a, b) => a.name.compareTo(b.name));
}

bool _isClassOrBackgroundChoice(CharacterChoiceData choice) {
  switch (choice.sourceType) {
    case ChoiceSourceType.background:
    case ChoiceSourceType.classData:
    case ChoiceSourceType.subclass:
    case ChoiceSourceType.classFeature:
    case ChoiceSourceType.subclassFeature:
      return true;
    case ChoiceSourceType.race:
    case ChoiceSourceType.subrace:
    case null:
      return false;
  }
}

ChoiceSourceType? _startingEquipmentSourceTypeForBlock(
  StartingEquipmentBlockData block,
) {
  if (block.sourceClassId != null) {
    return ChoiceSourceType.classData;
  }
  if (block.sourceBackgroundId != null) {
    return ChoiceSourceType.background;
  }
  return null;
}

int? _startingEquipmentSourceIdForBlock(StartingEquipmentBlockData block) {
  return block.sourceClassId ?? block.sourceBackgroundId;
}

String _startingEquipmentBlockSourceKey(
  ChoiceSourceType sourceType,
  int sourceId,
  String blockKey,
) {
  return '${sourceType.name}:$sourceId:$blockKey';
}

String _startingEquipmentOptionSourceKey(
  ChoiceSourceType? sourceType,
  int? sourceId,
  String? blockKey,
  String optionKey,
) {
  return '${sourceType?.name ?? 'unknown'}:${sourceId ?? 0}:${blockKey ?? 'unknown'}:$optionKey';
}

int _normalizedPositiveQuantity(
  int? value, {
  int? fallback,
}) {
  final candidate = value ?? fallback ?? 1;
  return candidate > 0 ? candidate : 1;
}

String _classChoiceGroupKey(ClassChoiceGroupData group) {
  final explicitKey = _normalizedTextOrNull(group.exclusiveKey);
  if (explicitKey != null) {
    return explicitKey;
  }
  return 'group_${group.id ?? group.name ?? _safeEnumToken(group.type) ?? 'unknown'}';
}

String? _normalizedTextOrNull(String? value) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? null : trimmed;
}

Iterable<String> _normalizedTexts(Iterable<String>? values) sync* {
  for (final value in values ?? const <String>[]) {
    final normalized = _normalizedTextOrNull(value);
    if (normalized != null) {
      yield normalized;
    }
  }
}

Language? _languageFromName(String raw) {
  final normalized = raw.trim();
  for (final value in Language.values) {
    if (value.name == normalized) {
      return value;
    }
  }
  return null;
}

_CurrentRaceFeatures _currentRaceFeaturesBySource(
  CharacterData character,
  int totalLevel,
) {
  final characterLevel = max(totalLevel, 1);

  List<RaceFeatureData> filterCurrent(List<RaceFeatureData>? features) {
    return [
      for (final feature in features ?? const <RaceFeatureData>[])
        if ((feature.level ?? 1) <= characterLevel) feature,
    ];
  }

  return _CurrentRaceFeatures(
    raceFeatures: filterCurrent(character.race?.features),
    subraceFeatures: filterCurrent(character.subrace?.features),
  );
}

List<CharacterFeatureViewData> _buildActiveFeatures({
  required CharacterData character,
  required _ResolvedDerivedSources resolvedSources,
  required _CurrentRaceFeatures currentRaceFeatures,
}) {
  final normalizedOverrides = _normalizedFeatureOverrides(
    character.featureOverrides,
  );
  final overridesByKey = {
    for (final override in normalizedOverrides)
      _featureOverrideKey(override.sourceType, override.sourceId): override,
  };
  final activeFeatures = <CharacterFeatureViewData>[];

  void addFeature({
    required CharacterFeatureSourceType sourceType,
    required int? sourceId,
    required String? sourceName,
    required int? level,
    required String? defaultName,
    required String? defaultDescription,
    required List<FeatureTag>? defaultTags,
  }) {
    if (sourceId == null) {
      return;
    }

    final override = overridesByKey[_featureOverrideKey(sourceType, sourceId)];
    final resolvedName = override?.name ?? defaultName;
    final resolvedDescription = override?.description ?? defaultDescription;
    final normalizedDefaultTags = _normalizedFeatureTags(
      defaultTags,
      preserveEmpty: false,
    );
    final resolvedTags = override?.tags != null
        ? _normalizedFeatureTags(override!.tags, preserveEmpty: true)
        : normalizedDefaultTags;
    final isCustomized = override != null &&
        (_normalizedTextOrNull(resolvedName) !=
                _normalizedTextOrNull(defaultName) ||
            _normalizedTextOrNull(resolvedDescription) !=
                _normalizedTextOrNull(defaultDescription) ||
            !_featureTagsEqual(
              resolvedTags,
              normalizedDefaultTags,
              preserveEmpty: false,
            ));

    activeFeatures.add(
      CharacterFeatureViewData(
        sourceType: sourceType,
        sourceId: sourceId,
        sourceName: sourceName,
        level: level,
        defaultName: defaultName,
        defaultDescription: defaultDescription,
        defaultTags: normalizedDefaultTags,
        name: resolvedName,
        description: resolvedDescription,
        tags: resolvedTags,
        isCustomized: isCustomized,
      ),
    );
  }

  for (final feature in resolvedSources.currentClassFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.classFeature,
      sourceId: feature.id,
      sourceName: character.classEntries
          ?.firstWhere(
            (entry) => entry.classData?.id == feature.parentClassId,
            orElse: CharacterClassEntryData.new,
          )
          .classData
          ?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }
  for (final feature in resolvedSources.currentSubclassFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subclassFeature,
      sourceId: feature.id,
      sourceName: character.classEntries
          ?.firstWhere(
            (entry) => entry.subclass?.id == feature.parentSubclassId,
            orElse: CharacterClassEntryData.new,
          )
          .subclass
          ?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }
  for (final feature in currentRaceFeatures.raceFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.raceFeature,
      sourceId: feature.id,
      sourceName: character.race?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }
  for (final feature in currentRaceFeatures.subraceFeatures) {
    addFeature(
      sourceType: CharacterFeatureSourceType.subraceFeature,
      sourceId: feature.id,
      sourceName: character.subrace?.name,
      level: feature.level,
      defaultName: feature.name,
      defaultDescription: feature.description,
      defaultTags: feature.tags,
    );
  }

  activeFeatures.sort(_compareActiveFeatures);
  return activeFeatures;
}

List<CharacterFeatureOverrideData> _normalizedFeatureOverrides(
  List<CharacterFeatureOverrideData>? overrides,
) {
  final normalized = <CharacterFeatureOverrideData>[];

  for (final override in overrides ?? const <CharacterFeatureOverrideData>[]) {
    final name = _normalizedTextOrNull(override.name);
    final description = _normalizedTextOrNull(override.description);
    final tags = _normalizedFeatureTags(override.tags, preserveEmpty: true);
    if (name == null && description == null && tags == null) {
      continue;
    }

    final candidate = CharacterFeatureOverrideData(
      sourceType: override.sourceType,
      sourceId: override.sourceId,
      name: name,
      description: description,
      tags: tags,
    );

    final existingIndex = normalized.indexWhere(
      (item) =>
          item.sourceType == candidate.sourceType &&
          item.sourceId == candidate.sourceId,
    );
    if (existingIndex >= 0) {
      normalized[existingIndex] = candidate;
    } else {
      normalized.add(candidate);
    }
  }

  normalized.sort((a, b) {
    final sourceCompare = _featureSourceOrder(a.sourceType)
        .compareTo(_featureSourceOrder(b.sourceType));
    if (sourceCompare != 0) {
      return sourceCompare;
    }
    return a.sourceId.compareTo(b.sourceId);
  });
  return normalized;
}

bool _isMeaningfulFeatureOverride(
  CharacterFeatureOverrideData override,
  CharacterFeatureViewData? defaultFeature,
) {
  if (defaultFeature == null) {
    return false;
  }

  return _normalizedTextOrNull(override.name) !=
          _normalizedTextOrNull(defaultFeature.defaultName) ||
      _normalizedTextOrNull(override.description) !=
          _normalizedTextOrNull(defaultFeature.defaultDescription) ||
      !_featureTagsEqual(
        override.tags,
        defaultFeature.defaultTags,
        preserveEmpty: false,
      );
}

List<FeatureTag>? _normalizedFeatureTags(
  List<FeatureTag>? tags, {
  required bool preserveEmpty,
}) {
  if (tags == null) {
    return null;
  }

  final normalized = {...tags}.toList()
    ..sort((a, b) => a.name.compareTo(b.name));
  if (normalized.isEmpty && !preserveEmpty) {
    return null;
  }
  return normalized;
}

bool _featureTagsEqual(
  List<FeatureTag>? left,
  List<FeatureTag>? right, {
  required bool preserveEmpty,
}) {
  final normalizedLeft = _normalizedFeatureTags(
    left,
    preserveEmpty: preserveEmpty,
  );
  final normalizedRight = _normalizedFeatureTags(
    right,
    preserveEmpty: preserveEmpty,
  );
  if (normalizedLeft == null || normalizedRight == null) {
    return normalizedLeft == normalizedRight;
  }
  if (normalizedLeft.length != normalizedRight.length) {
    return false;
  }
  for (var index = 0; index < normalizedLeft.length; index++) {
    if (normalizedLeft[index] != normalizedRight[index]) {
      return false;
    }
  }
  return true;
}

String _featureOverrideKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
) {
  return '${sourceType.name}:$sourceId';
}

int _compareActiveFeatures(
  CharacterFeatureViewData a,
  CharacterFeatureViewData b,
) {
  final sourceCompare = _featureSourceOrder(a.sourceType)
      .compareTo(_featureSourceOrder(b.sourceType));
  if (sourceCompare != 0) {
    return sourceCompare;
  }

  final levelCompare = (a.level ?? 0).compareTo(b.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }

  final nameCompare =
      (a.name ?? a.defaultName ?? '').compareTo(b.name ?? b.defaultName ?? '');
  if (nameCompare != 0) {
    return nameCompare;
  }

  return a.sourceId.compareTo(b.sourceId);
}

int _featureSourceOrder(CharacterFeatureSourceType sourceType) {
  switch (sourceType) {
    case CharacterFeatureSourceType.classFeature:
      return 0;
    case CharacterFeatureSourceType.subclassFeature:
      return 1;
    case CharacterFeatureSourceType.raceFeature:
      return 2;
    case CharacterFeatureSourceType.subraceFeature:
      return 3;
  }
}

String? _safeEnumToken(Object? value) {
  if (value == null) return null;
  final raw = value.toString();
  if (raw.trim().isEmpty) return null;
  final parts = raw.split('.');
  return parts.isEmpty ? raw : parts.last;
}

int? _resolveHitDie(ClassData? classData) {
  if (classData == null) return null;
  return classData.hitDieValue;
}

Ability _abilityForSkill(Skill skill) {
  switch (skill) {
    case Skill.acrobatics:
    case Skill.sleightOfHand:
    case Skill.stealth:
      return Ability.dexterity;
    case Skill.animalHandling:
    case Skill.insight:
    case Skill.medicine:
    case Skill.perception:
    case Skill.survival:
      return Ability.wisdom;
    case Skill.arcana:
    case Skill.history:
    case Skill.investigation:
    case Skill.nature:
    case Skill.religion:
      return Ability.intelligence;
    case Skill.athletics:
      return Ability.strength;
    case Skill.deception:
    case Skill.intimidation:
    case Skill.performance:
    case Skill.persuasion:
      return Ability.charisma;
  }
}

void _applyFixedRaceBonuses(
  Map<String, int> scores,
  Map<String, int> bonuses,
) {
  bonuses.forEach((key, value) {
    scores[key] = (scores[key] ?? 10) + value;
  });
}

Map<String, int> _abilityBonusesFromRace(RaceData? race) {
  return {
    if (race?.strengthBonus != null)
      Ability.strength.name: race!.strengthBonus!,
    if (race?.dexterityBonus != null)
      Ability.dexterity.name: race!.dexterityBonus!,
    if (race?.constitutionBonus != null)
      Ability.constitution.name: race!.constitutionBonus!,
    if (race?.intelligenceBonus != null)
      Ability.intelligence.name: race!.intelligenceBonus!,
    if (race?.wisdomBonus != null) Ability.wisdom.name: race!.wisdomBonus!,
    if (race?.charismaBonus != null)
      Ability.charisma.name: race!.charismaBonus!,
  };
}

Map<String, int> _abilityBonusesFromSubrace(SubraceData? subrace) {
  return {
    if (subrace?.strengthBonus != null)
      Ability.strength.name: subrace!.strengthBonus!,
    if (subrace?.dexterityBonus != null)
      Ability.dexterity.name: subrace!.dexterityBonus!,
    if (subrace?.constitutionBonus != null)
      Ability.constitution.name: subrace!.constitutionBonus!,
    if (subrace?.intelligenceBonus != null)
      Ability.intelligence.name: subrace!.intelligenceBonus!,
    if (subrace?.wisdomBonus != null)
      Ability.wisdom.name: subrace!.wisdomBonus!,
    if (subrace?.charismaBonus != null)
      Ability.charisma.name: subrace!.charismaBonus!,
  };
}

List<RaceChoiceOptionData> _selectedRaceChoiceOptions(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final optionsByGroupKey = <String, Map<String, RaceChoiceOptionData>>{};

  void registerFeatures(List<RaceFeatureData>? features) {
    for (final feature in features ?? const <RaceFeatureData>[]) {
      for (final choiceSet
          in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        final groupKey = _choiceSetGroupKey(choiceSet.id);
        if (groupKey == null) continue;

        optionsByGroupKey[groupKey] = {
          for (final option
              in choiceSet.choiceOptions ?? const <RaceChoiceOptionData>[])
            if (option.optionKey?.trim().isNotEmpty == true)
              option.optionKey!.trim(): option,
        };
      }
    }
  }

  registerFeatures(character.race?.features);
  registerFeatures(character.subrace?.features);

  final selected = <RaceChoiceOptionData>[];
  for (final choice in choices) {
    final groupKey = choice.groupKey;
    final optionKey = choice.optionKey?.trim();
    if (groupKey == null || optionKey == null || optionKey.isEmpty) {
      continue;
    }

    final option = optionsByGroupKey[groupKey]?[optionKey];
    if (option != null) {
      selected.add(option);
    }
  }

  return selected;
}

int _compareCharacterChoices(CharacterChoiceData a, CharacterChoiceData b) {
  final groupCompare = (a.groupKey ?? '').compareTo(b.groupKey ?? '');
  if (groupCompare != 0) return groupCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareSkillSelections(
  CharacterSkillSelectionData a,
  CharacterSkillSelectionData b,
) {
  final kindCompare = (a.kind?.name ?? '').compareTo(b.kind?.name ?? '');
  if (kindCompare != 0) return kindCompare;

  final classCompare = (a.classDataId ?? 0).compareTo(b.classDataId ?? 0);
  if (classCompare != 0) return classCompare;

  final backgroundCompare =
      (a.backgroundDataId ?? 0).compareTo(b.backgroundDataId ?? 0);
  if (backgroundCompare != 0) return backgroundCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  final skillCompare = (a.skill?.name ?? '').compareTo(b.skill?.name ?? '');
  if (skillCompare != 0) return skillCompare;

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareSpellSelections(
  CharacterSpellSelectionData a,
  CharacterSpellSelectionData b,
) {
  final classCompare = (a.classDataId ?? 0).compareTo(b.classDataId ?? 0);
  if (classCompare != 0) return classCompare;

  final kindCompare = (a.kind?.name ?? '').compareTo(b.kind?.name ?? '');
  if (kindCompare != 0) return kindCompare;

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) return selectionCompare;

  final spellCompare = (a.spellKey ??
          a.spell?.referenceKey ??
          a.spell?.name ??
          '')
      .compareTo(b.spellKey ?? b.spell?.referenceKey ?? b.spell?.name ?? '');
  if (spellCompare != 0) return spellCompare;

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareStartingEquipmentSelections(
  CharacterStartingEquipmentSelectionData a,
  CharacterStartingEquipmentSelectionData b,
) {
  final sourceCompare =
      (a.sourceType?.name ?? '').compareTo(b.sourceType?.name ?? '');
  if (sourceCompare != 0) {
    return sourceCompare;
  }

  final sourceIdCompare = (a.sourceId ?? 0).compareTo(b.sourceId ?? 0);
  if (sourceIdCompare != 0) {
    return sourceIdCompare;
  }

  final blockCompare = (a.blockKey ?? '').compareTo(b.blockKey ?? '');
  if (blockCompare != 0) {
    return blockCompare;
  }

  final selectionCompare =
      (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0);
  if (selectionCompare != 0) {
    return selectionCompare;
  }

  final optionCompare = (a.optionKey ?? '').compareTo(b.optionKey ?? '');
  if (optionCompare != 0) {
    return optionCompare;
  }

  return (a.id ?? '').compareTo(b.id ?? '');
}

int _compareStartingEquipmentResolutions(
  CharacterStartingEquipmentResolutionData a,
  CharacterStartingEquipmentResolutionData b,
) {
  final lineCompare = (a.lineKey ?? '').compareTo(b.lineKey ?? '');
  if (lineCompare != 0) {
    return lineCompare;
  }

  final typeCompare =
      (a.catalogType?.name ?? '').compareTo(b.catalogType?.name ?? '');
  if (typeCompare != 0) {
    return typeCompare;
  }

  final referenceCompare =
      (a.referenceKey ?? '').compareTo(b.referenceKey ?? '');
  if (referenceCompare != 0) {
    return referenceCompare;
  }

  return (a.id ?? '').compareTo(b.id ?? '');
}

String? _choiceSetGroupKey(int? choiceSetId) {
  if (choiceSetId == null) return null;
  return 'race_choice_$choiceSetId';
}

CharacterRecordInclude _characterRecordInclude() {
  return CharacterRecord.include(
    race: _raceDataInclude(),
    subrace: _subraceDataInclude(),
    background: BackgroundData.include(),
  );
}

RaceDataInclude _raceDataInclude() {
  return RaceData.include(
    features: RaceFeatureData.includeList(
      include: _raceFeatureInclude(),
    ),
  );
}

SubraceDataInclude _subraceDataInclude() {
  return SubraceData.include(
    features: RaceFeatureData.includeList(
      include: _raceFeatureInclude(),
    ),
  );
}

RaceFeatureDataInclude _raceFeatureInclude() {
  return RaceFeatureData.include(
    spellGrants: RaceFeatureSpellGrantData.includeList(
      include: RaceFeatureSpellGrantData.include(
        spell: SpellData.include(),
      ),
    ),
    choiceSets: RaceChoiceSetData.includeList(
      include: RaceChoiceSetData.include(
        choiceOptions: RaceChoiceOptionData.includeList(
          include: RaceChoiceOptionData.include(
            spell: SpellData.include(),
            feat: FeatData.include(),
          ),
        ),
      ),
    ),
  );
}
