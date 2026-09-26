part of '../character_data_endpoint.dart';

Future<CharacterRecord> _upsertCharacterRecord(
  Session session,
  CharacterData character,
  int userId, {
  Transaction? transaction,
  int? exactVersion,
  CharacterRecord? lockedExistingRecord,
  Map<String, int>? syncTargetRevisions,
}) async {
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
        version: exactVersion ?? character.version ?? 1,
        syncTargetRevisions: syncTargetRevisions,
        createdAt: effectiveCreatedAt,
        updatedAt: effectiveUpdatedAt,
      ),
      transaction: transaction,
    );
  }

  final ownedRecord = lockedExistingRecord ??
      await _findOwnedCharacterRecord(
        session,
        character.id!,
        userId,
        transaction: transaction,
      );
  if (ownedRecord != null) {
    final updatedRecord = _toCharacterRecord(
      character,
      id: ownedRecord.id,
      userId: ownedRecord.userId ?? userId,
      version: exactVersion ?? (ownedRecord.version ?? 0) + 1,
      syncTargetRevisions: syncTargetRevisions,
      createdAt: ownedRecord.createdAt?.toUtc() ?? effectiveCreatedAt,
      updatedAt: effectiveUpdatedAt,
    );
    await CharacterRecord.db.updateRow(
      session,
      updatedRecord,
      transaction: transaction,
    );
    return updatedRecord;
  }

  final existingById = await CharacterRecord.db.find(
    session,
    where: (t) => t.id.equals(character.id),
    limit: 1,
    transaction: transaction,
  );
  if (existingById.isNotEmpty) {
    throw Exception('Access denied to character id=${character.id}.');
  }

  return CharacterRecord.db.insertRow(
    session,
    _toCharacterRecord(
      character,
      userId: userId,
      version: exactVersion ?? character.version ?? 1,
      syncTargetRevisions: syncTargetRevisions,
      createdAt: effectiveCreatedAt,
      updatedAt: effectiveUpdatedAt,
    ),
    transaction: transaction,
  );
}

CharacterRecord _toCharacterRecord(
  CharacterData character, {
  int? id,
  required int userId,
  required int version,
  Map<String, int>? syncTargetRevisions,
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
    syncTargetRevisions: syncTargetRevisions ?? character.syncTargetRevisions,
    syncBarrierTokens: character.syncBarrierTokens,
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
    deathSaveSuccesses: _normalizedDeathSaveCount(character.deathSaveSuccesses),
    deathSaveFailures: _normalizedDeathSaveCount(character.deathSaveFailures),
    hpPerLevelBonus: _zeroAsNull(character.hpPerLevelBonus),
    hpFlatBonus: _zeroAsNull(character.hpFlatBonus),
    currentHitDice: _normalizedNonNegativeIntMap(character.currentHitDice),
    hitDiceMaxOverrides:
        _normalizedNonNegativeIntMap(character.hitDiceMaxOverrides),
    currentSpellSlots: character.currentSpellSlots,
    activeConcentrationSpellName: character.activeConcentrationSpellName,
    customInitiativeBonus: _zeroAsNull(character.customInitiativeBonus),
    customArmorClassBonus: _zeroAsNull(character.customArmorClassBonus),
    walkingSpeed: _normalizedSpeed(character.walkingSpeed),
    swimmingSpeed: _normalizedSpeed(character.swimmingSpeed),
    climbingSpeed: _normalizedSpeed(character.climbingSpeed),
    flyingSpeed: _normalizedSpeed(character.flyingSpeed),
    displayedSpeedKind: character.displayedSpeedKind,
    customSpellSaveDcBonus: _zeroAsNull(character.customSpellSaveDcBonus),
    customSpellAttackBonus: _zeroAsNull(character.customSpellAttackBonus),
    preparedSpellKeys:
        _normalizedPreparedSpellKeys(character.preparedSpellKeys),
    activeConditions: _normalizedActiveConditions(character.activeConditions),
    exhaustionLevel: _normalizedExhaustionLevel(character.exhaustionLevel),
    inspiration: character.inspiration,
    equipment: character.equipment,
    manualSkillProficiencies: character.manualSkillProficiencies,
    manualSavingThrowProficiencies: character.manualSavingThrowProficiencies,
    manualSkillProficiencyOverrides: character.manualSkillProficiencyOverrides,
    manualSavingThrowProficiencyOverrides:
        character.manualSavingThrowProficiencyOverrides,
    manualLanguageOverrides: character.manualLanguageOverrides,
    manualToolProficiencyOverrides: character.manualToolProficiencyOverrides,
    manualWeaponProficiencyOverrides:
        character.manualWeaponProficiencyOverrides,
    manualArmorTrainingOverrides: character.manualArmorTrainingOverrides,
    notes: character.notes,
    attacks: character.attacks,
    featureOverrides: _normalizedFeatureOverrides(character.featureOverrides),
    resourceStates: _normalizedResourceStates(character.resourceStates),
  );
}
