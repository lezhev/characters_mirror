part of '../character_data_endpoint.dart';

Future<CharacterData> _buildCharacterAggregate(
  Session session,
  CharacterRecord record, {
  Transaction? transaction,
  _CharacterResolveContext? resolveContext,
}) async {
  final context = resolveContext ?? _CharacterResolveContext(session);
  final entryRecords = await CharacterClassEntryRecord.db.find(
    session,
    where: (t) => t.characterId.equals(record.id),
    orderBy: (t) => t.classOrder,
    transaction: transaction,
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
    transaction: transaction,
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
    transaction: transaction,
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
    transaction: transaction,
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
    transaction: transaction,
  );
  final startingEquipmentSelections =
      <CharacterStartingEquipmentSelectionData>[];
  final startingEquipmentSelectionIds = {
    for (final selection in startingEquipmentSelectionRecords)
      if (selection.id != null) selection.id!,
  };
  final startingEquipmentResolutionRecords =
      startingEquipmentSelectionIds.isEmpty
          ? const <CharacterStartingEquipmentResolutionRecord>[]
          : await CharacterStartingEquipmentResolutionRecord.db.find(
              session,
              where: (t) => t.selectionId.inSet(startingEquipmentSelectionIds),
              orderBy: (t) => t.id,
              transaction: transaction,
            );
  final resolutionsBySelectionId =
      <int, List<CharacterStartingEquipmentResolutionRecord>>{};
  for (final resolution in startingEquipmentResolutionRecords) {
    resolutionsBySelectionId
        .putIfAbsent(resolution.selectionId, () => [])
        .add(resolution);
  }
  for (final selection in startingEquipmentSelectionRecords) {
    startingEquipmentSelections.add(
      _toCharacterStartingEquipmentSelectionData(
        selection,
        resolutionsBySelectionId[selection.id] ??
            const <CharacterStartingEquipmentResolutionRecord>[],
      ),
    );
  }
  startingEquipmentSelections.sort(_compareStartingEquipmentSelections);

  final character = _toCharacterData(record).copyWith(
    classEntries: entries,
    choices: choices,
    skillSelections: skillSelections,
    spellSelections: spellSelections,
    startingEquipmentSelections: startingEquipmentSelections,
  );
  final derived = await _buildDerivedData(
    session,
    character,
    transaction: transaction,
    resolveContext: context,
  );
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
    syncTargetRevisions: record.syncTargetRevisions,
    syncBarrierTokens: record.syncBarrierTokens,
    createdAt: record.createdAt,
    updatedAt: record.updatedAt,
    experience: record.experience ?? 0,
    alignmentValue: record.alignmentValue,
    race: record.race,
    subrace: record.subrace,
    background: record.background,
    baseAbilityScores: record.baseAbilityScores,
    customAbilityBonuses: record.customAbilityBonuses,
    useFlexibleAbilityBonuses: record.useFlexibleAbilityBonuses,
    temporaryHp: record.temporaryHp,
    currentHp: record.currentHp,
    deathSaveSuccesses: _normalizedDeathSaveCount(record.deathSaveSuccesses),
    deathSaveFailures: _normalizedDeathSaveCount(record.deathSaveFailures),
    hpPerLevelBonus: _zeroAsNull(record.hpPerLevelBonus),
    hpFlatBonus: _zeroAsNull(record.hpFlatBonus),
    currentHitDice: _normalizedNonNegativeIntMap(record.currentHitDice),
    hitDiceMaxOverrides:
        _normalizedNonNegativeIntMap(record.hitDiceMaxOverrides),
    currentSpellSlots: record.currentSpellSlots,
    activeConcentrationSpellName: record.activeConcentrationSpellName,
    customInitiativeBonus: _zeroAsNull(record.customInitiativeBonus),
    customArmorClassBonus: _zeroAsNull(record.customArmorClassBonus),
    walkingSpeed: _normalizedSpeed(record.walkingSpeed),
    swimmingSpeed: _normalizedSpeed(record.swimmingSpeed),
    climbingSpeed: _normalizedSpeed(record.climbingSpeed),
    flyingSpeed: _normalizedSpeed(record.flyingSpeed),
    displayedSpeedKind: record.displayedSpeedKind,
    customSpellSaveDcBonus: _zeroAsNull(record.customSpellSaveDcBonus),
    customSpellAttackBonus: _zeroAsNull(record.customSpellAttackBonus),
    preparedSpellKeys: _normalizedPreparedSpellKeys(record.preparedSpellKeys),
    activeConditions: _normalizedActiveConditions(record.activeConditions),
    exhaustionLevel: _normalizedExhaustionLevel(record.exhaustionLevel),
    inspiration: record.inspiration,
    equipment: _normalizedInventoryItems(record.equipment, record.updatedAt),
    equippedArmor: record.equippedArmor,
    equippedShield: record.equippedShield,
    manualSkillProficiencies: record.manualSkillProficiencies,
    manualSavingThrowProficiencies: record.manualSavingThrowProficiencies,
    manualSkillProficiencyOverrides: record.manualSkillProficiencyOverrides,
    manualSavingThrowProficiencyOverrides:
        record.manualSavingThrowProficiencyOverrides,
    manualLanguageOverrides: record.manualLanguageOverrides,
    manualToolProficiencyOverrides: record.manualToolProficiencyOverrides,
    manualWeaponProficiencyOverrides: record.manualWeaponProficiencyOverrides,
    manualArmorTrainingOverrides: record.manualArmorTrainingOverrides,
    notes: record.notes,
    attacks: record.attacks,
    featureOverrides: record.featureOverrides,
    resourceStates: _normalizedResourceStates(record.resourceStates),
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
    groupKey: record.groupKey,
    optionKey: record.optionKey,
    selectionIndex: record.selectionIndex,
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
      _toCharacterStartingEquipmentResolutionData(resolution),
  ]..sort(_compareStartingEquipmentResolutions);

  return CharacterStartingEquipmentSelectionData(
    id: record.syncId,
    sourceType: record.sourceType,
    sourceId: record.sourceId,
    sourceEntryId: record.sourceEntryId,
    choiceOptionEntryId: record.choiceOptionEntryId,
    isSelected: record.isSelected,
    selectionIndex: record.selectionIndex,
    resolutions: resolutions,
    updatedAt: record.updatedAt,
  );
}

CharacterStartingEquipmentResolutionData
    _toCharacterStartingEquipmentResolutionData(
  CharacterStartingEquipmentResolutionRecord record,
) {
  return CharacterStartingEquipmentResolutionData(
    id: record.syncId,
    sourceLineEntryId: record.sourceLineEntryId,
    catalogType: record.catalogType,
    referenceKey: record.referenceKey,
    quantity: record.quantity,
    updatedAt: record.updatedAt,
  );
}
