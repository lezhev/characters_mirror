// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../character_sheet_state.dart';

extension CharacterSheetControllerCombat on CharacterSheetController {
  Future<void> applyHitPointAction({
    required HitPointAction action,
    required int amount,
  }) async {
    if (amount <= 0) return;
    final current = _requireCharacter();
    final totals = applyHitPointChange(
      totals: hitPointTotalsFromCharacter(current),
      value: amount,
      action: action,
    );
    final hitPoints = normalizeHitPointsForSave(
      currentHp: totals.currentHp,
      maxHp: totals.maxHp,
      temporaryHp: totals.temporaryHp,
    );
    final type = switch (action) {
      HitPointAction.damage => CharacterSyncOperationType.applyDamage,
      HitPointAction.heal => CharacterSyncOperationType.heal,
      HitPointAction.temporary => CharacterSyncOperationType.grantTemporaryHp,
    };
    await _saveSemanticAction(
      current.copyWith(
        currentHp: hitPoints.currentHp,
        temporaryHp: hitPoints.temporaryHp,
        deathSaveSuccesses:
            totals.currentHp > 0 ? null : current.deathSaveSuccesses,
        deathSaveFailures:
            totals.currentHp > 0 ? null : current.deathSaveFailures,
      ),
      type: type,
      action: CharacterSemanticActionData(amount: amount),
    );
  }

  Future<void> addAttack(CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks, attack];
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> updateAttack(int index, CharacterAttackData attack) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    final previousAttack = attacks[index];
    attacks[index] = attack.copyWith(
      id: attack.id ?? previousAttack.id,
      updatedAt: attack.updatedAt ?? previousAttack.updatedAt,
    );
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> deleteAttack(int index) async {
    final current = _requireCharacter();
    final attacks = [...?current.attacks];
    if (index < 0 || index >= attacks.length) {
      throw RangeError.index(index, attacks, 'index');
    }

    attacks.removeAt(index);
    await _saveCharacter(current.copyWith(attacks: attacks));
  }

  Future<void> saveEquipmentText(String? text) async {
    final current = _requireCharacter();
    final parsed = inventoryItemsFromText(
      text,
      previous: current.equipment,
    );
    final equipment = parsed == null
        ? null
        : [
            parsed.single.copyWith(
              id: parsed.single.id ?? createCharacterSyncItemId(),
            ),
          ];
    await _saveCharacter(
      current.copyWith(equipment: equipment),
    );
  }

  Future<void> saveHitPoints({
    required int currentHp,
    required int temporaryHp,
  }) async {
    final current = _requireCharacter();
    final hitPoints = normalizeHitPointsForSave(
      currentHp: currentHp,
      maxHp: current.derived?.maxHp ?? 0,
      temporaryHp: temporaryHp,
    );

    await _saveCharacter(
      current.copyWith(
        currentHp: hitPoints.currentHp,
        temporaryHp: hitPoints.temporaryHp,
        deathSaveSuccesses: hitPoints.currentHp == null || currentHp > 0
            ? null
            : current.deathSaveSuccesses,
        deathSaveFailures: hitPoints.currentHp == null || currentHp > 0
            ? null
            : current.deathSaveFailures,
      ),
      debounce: false,
    );
  }

  Future<void> saveDeathSavingThrows({
    required int successes,
    required int failures,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        deathSaveSuccesses: normalizeDeathSaveCountForSave(successes),
        deathSaveFailures: normalizeDeathSaveCountForSave(failures),
      ),
    );
  }

  Future<void> saveHitPointSettings({
    required List<CharacterClassEntryData> classEntries,
    required int hpPerLevelBonus,
    required int hpFlatBonus,
    required Map<String, int> currentHitDice,
    required Map<String, int> hitDiceMaxOverrides,
  }) async {
    final current = _requireCharacter();
    final normalizedEntries = normalizeHitPointClassEntries(classEntries);
    final baseHitDiceMax = baseHitDiceMaxFromCharacter(
      current.copyWith(classEntries: normalizedEntries),
    );
    final normalizedMaxOverrides = normalizeHitDiceMaxOverridesForSave(
      baseHitDiceMax,
      hitDiceMaxOverrides,
    );
    final effectiveMaxHitDice = effectiveHitDiceMax(
      baseHitDiceMax,
      normalizedMaxOverrides,
    );
    final normalizedCurrentHitDice = normalizeCurrentHitDiceForSave(
      currentHitDice,
      effectiveMaxHitDice,
    );

    final settingsCharacter = current.copyWith(
      classEntries: normalizedEntries,
      hpPerLevelBonus: hpPerLevelBonus == 0 ? null : hpPerLevelBonus,
      hpFlatBonus: hpFlatBonus == 0 ? null : hpFlatBonus,
      currentHitDice: normalizedCurrentHitDice,
      hitDiceMaxOverrides: normalizedMaxOverrides,
    );
    final nextMaxHp = calculateMaxHpForCharacter(settingsCharacter);
    final currentHp = current.currentHp ?? nextMaxHp;
    final hitPoints = normalizeHitPointsForSave(
      currentHp: currentHp,
      maxHp: nextMaxHp,
      temporaryHp: current.temporaryHp ?? 0,
    );

    await _saveCharacter(
      settingsCharacter.copyWith(
        currentHp: hitPoints.currentHp,
        temporaryHp: hitPoints.temporaryHp,
      ),
    );
  }

  Future<void> adjustHitDice(String dieKind, int delta) async {
    if (delta == 0) return;
    final current = _requireCharacter();
    final maximum = effectiveHitDiceMaxFromCharacter(current)[dieKind];
    if (maximum == null || maximum <= 0) return;
    final available = effectiveCurrentHitDice(
      current.currentHitDice,
      effectiveHitDiceMaxFromCharacter(current),
    )[dieKind]!;
    final next = available + delta;
    if (next < 0 || next > maximum) return;
    final values = <String, int>{...?current.currentHitDice};
    if (next == maximum) {
      values.remove(dieKind);
    } else {
      values[dieKind] = next;
    }
    await _saveSemanticAction(
      current.copyWith(currentHitDice: values.isEmpty ? null : values),
      type: CharacterSyncOperationType.adjustHitDice,
      action: CharacterSemanticActionData(dieKind: dieKind, delta: delta),
    );
  }

  Future<void> saveInitiativeBonus(int bonus) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(customInitiativeBonus: bonus == 0 ? null : bonus),
      debounce: false,
    );
  }

  Future<void> saveArmorClassBonus(int bonus) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(customArmorClassBonus: bonus == 0 ? null : bonus),
      debounce: false,
    );
  }

  Future<void> saveEquippedArmor(
    CharacterEquipmentSelectionData? selection,
  ) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(equippedArmor: selection),
      debounce: false,
    );
  }

  Future<void> saveEquippedShield(
    CharacterEquipmentSelectionData? selection,
  ) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(equippedShield: selection),
      debounce: false,
    );
  }

  Future<CharacterData> ensureMovementSpeedsInitialized() async {
    final current = _requireCharacter();
    if (current.walkingSpeed != null &&
        current.swimmingSpeed != null &&
        current.climbingSpeed != null &&
        current.flyingSpeed != null &&
        current.displayedSpeedKind != null) {
      return current;
    }

    final speeds = effectiveMovementSpeeds(current);
    await _saveCharacter(
      current.copyWith(
        walkingSpeed:
            current.walkingSpeed ?? speeds[CharacterSpeedKind.walking],
        swimmingSpeed:
            current.swimmingSpeed ?? speeds[CharacterSpeedKind.swimming],
        climbingSpeed:
            current.climbingSpeed ?? speeds[CharacterSpeedKind.climbing],
        flyingSpeed: current.flyingSpeed ?? speeds[CharacterSpeedKind.flying],
        displayedSpeedKind:
            current.displayedSpeedKind ?? CharacterSpeedKind.walking,
      ),
    );
    return _requireCharacter();
  }

  Future<void> saveMovementSpeeds({
    required int walkingSpeed,
    required int swimmingSpeed,
    required int climbingSpeed,
    required int flyingSpeed,
    required CharacterSpeedKind displayedSpeedKind,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        walkingSpeed: _normalizedMovementSpeed(walkingSpeed),
        swimmingSpeed: _normalizedMovementSpeed(swimmingSpeed),
        climbingSpeed: _normalizedMovementSpeed(climbingSpeed),
        flyingSpeed: _normalizedMovementSpeed(flyingSpeed),
        displayedSpeedKind: displayedSpeedKind,
      ),
      debounce: false,
    );
  }
}
