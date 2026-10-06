// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../character_sheet_state.dart';

extension CharacterSheetControllerSpells on CharacterSheetController {
  Future<void> setCurrentSpellSlotsForLevel(int level, int available) async {
    final current = _requireCharacter();
    final maxSlots = _spellSlotCount(current, level);
    final normalizedAvailable = available.clamp(0, maxSlots).toInt();
    final currentSpellSlots = <int, int>{...?current.currentSpellSlots};
    if (maxSlots <= 0 || normalizedAvailable == maxSlots) {
      currentSpellSlots.remove(level);
    } else {
      currentSpellSlots[level] = normalizedAvailable;
    }

    await _saveCharacter(
      current.copyWith(
        currentSpellSlots: currentSpellSlots.isEmpty ? null : currentSpellSlots,
      ),
    );
  }

  Future<void> saveSpellcastingBonuses({
    required int saveDcBonus,
    required int attackBonus,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        customSpellSaveDcBonus: saveDcBonus == 0 ? null : saveDcBonus,
        customSpellAttackBonus: attackBonus == 0 ? null : attackBonus,
      ),
    );
  }

  Future<void> learnSpell(SpellData spell, {int? classDataId}) async {
    final current = _requireCharacter();
    final key = _spellKey(spell);
    if (key == null) return;
    final entry = spellEntryForClass(current, classDataId);
    final row = entry != null && entry.classData?.spellSelectionMode == null
        ? spellLevelForEntry(entry, await ClassLevelRepository().getAll())
        : null;
    final selection =
        learnedSpellSelection(current, spell, classDataId, classLevel: row);
    final selections = [...?current.spellSelections];
    if (selections.any(
        (item) => selectionIdentity(item) == selectionIdentity(selection))) {
      return;
    }
    selections.add(selection.copyWith(
      selectionIndex: nextSpellSelectionIndex(
        selections,
        classEntry: selection.classEntry,
        classDataId: selection.classDataId,
        kind: selection.kind!,
      ),
    ));

    await _saveCharacter(
      current.copyWith(spellSelections: _normalizedSpellSelections(selections)),
    );
  }

  Future<void> forgetSpell(SpellData spell, {int? classDataId}) async {
    final current = _requireCharacter();
    final key = _spellKey(spell);
    if (key == null) {
      return;
    }

    final sourceId =
        classDataId ?? current.classEntries?.firstOrNull?.classData?.id;
    final selections = forgetSpellSelections(current, spell, sourceId);
    final preparedKeys = _effectivePreparedSpellKeys(current);
    if (!selections.any((selection) => _spellSelectionKey(selection) == key)) {
      preparedKeys.remove(key);
    }

    await _saveCharacter(
      current.copyWith(
        spellSelections: _normalizedSpellSelections(selections),
        preparedSpellKeys: _normalizedPreparedKeys(
          current,
          preparedKeys,
        ),
      ),
    );
  }

  Future<void> setSpellPrepared(
    SpellData spell,
    bool prepared, {
    int? classDataId,
  }) async {
    final current = _requireCharacter();
    final key = _spellKey(spell);
    if (key == null) {
      return;
    }

    final entry = spellEntryForClass(current, classDataId);
    final row = entry != null && entry.classData?.spellSelectionMode == null
        ? spellLevelForEntry(entry, await ClassLevelRepository().getAll())
        : null;
    final selections = prepareSpellSelections(
        current, spell, classDataId, prepared,
        classLevel: row);
    final defaultKeys = _defaultPreparedSpellKeys(current);
    final preparedKeys = _effectivePreparedSpellKeys(current)..remove(key);
    if (prepared) {
      preparedKeys.add(key);
    }
    await _saveCharacter(
      current.copyWith(
        spellSelections: _normalizedSpellSelections(selections),
        preparedSpellKeys: _normalizedPreparedKeys(
          current,
          preparedKeys,
          defaultKeys: defaultKeys,
        ),
      ),
    );
  }

  Future<void> spendSpellSlot(int level) async {
    await adjustSpellSlots(level, -1);
  }

  Future<void> adjustSpellSlots(int level, int delta) async {
    if (level <= 0) {
      return;
    }

    final current = _requireCharacter();
    final maxSlots = _spellSlotCount(current, level);
    final available = _currentSpellSlotCount(current, level);
    final nextAvailable = available + delta;
    if (delta == 0 ||
        maxSlots <= 0 ||
        nextAvailable < 0 ||
        nextAvailable > maxSlots) {
      return;
    }
    final slots = <int, int>{...?current.currentSpellSlots};
    if (nextAvailable == maxSlots) {
      slots.remove(level);
    } else {
      slots[level] = nextAvailable;
    }
    await _saveSemanticAction(
      current.copyWith(currentSpellSlots: slots.isEmpty ? null : slots),
      type: CharacterSyncOperationType.adjustSpellSlots,
      action: CharacterSemanticActionData(level: level, delta: delta),
    );
  }

  Future<void> castSpell(SpellData spell) async {
    final current = _requireCharacter();
    final level = spell.level ?? 0;
    final currentSpellSlots = <int, int>{...?current.currentSpellSlots};

    if (level > 0) {
      final maxSlots = _spellSlotCount(current, level);
      final available = _currentSpellSlotCount(current, level);
      if (maxSlots <= 0 || available <= 0) {
        return;
      }

      final nextAvailable = available - 1;
      if (nextAvailable == maxSlots) {
        currentSpellSlots.remove(level);
      } else {
        currentSpellSlots[level] = nextAvailable;
      }
    }

    await _saveSemanticAction(
      current.copyWith(
        currentSpellSlots: currentSpellSlots.isEmpty ? null : currentSpellSlots,
        activeConcentrationSpellName: spell.concentration == true
            ? _spellName(spell)
            : current.activeConcentrationSpellName,
      ),
      type: CharacterSyncOperationType.castSpell,
      action: CharacterSemanticActionData(
        level: level,
        spellName: spell.concentration == true ? _spellName(spell) : null,
        startsConcentration: spell.concentration == true,
      ),
    );
  }

  Future<void> cancelConcentration() async {
    final current = _requireCharacter();
    if (_normalizedText(current.activeConcentrationSpellName) == null) {
      return;
    }

    await _saveCharacter(current.copyWith(activeConcentrationSpellName: null));
  }
}
