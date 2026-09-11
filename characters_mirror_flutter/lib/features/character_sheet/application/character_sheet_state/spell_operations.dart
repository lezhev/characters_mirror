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
    if (key == null || _hasSpellSelection(current, key)) {
      return;
    }

    final selections = [...?current.spellSelections];
    selections.add(
      CharacterSpellSelectionData(
        classDataId: classDataId,
        spell: spell,
        spellId: spell.id,
        spellKey: key,
        kind: (spell.level ?? 0) <= 0
            ? CharacterSpellSelectionKind.knownCantrip
            : CharacterSpellSelectionKind.knownSpell,
        selectionIndex: selections.length,
      ),
    );

    await _saveCharacter(
      current.copyWith(spellSelections: _normalizedSpellSelections(selections)),
    );
  }

  Future<void> forgetSpell(SpellData spell) async {
    final current = _requireCharacter();
    final key = _spellKey(spell);
    if (key == null) {
      return;
    }

    final selections = [
      for (final selection
          in current.spellSelections ?? const <CharacterSpellSelectionData>[])
        if (_spellSelectionKey(selection) != key) selection,
    ];
    final preparedKeys = _effectivePreparedSpellKeys(current)..remove(key);

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

    final defaultKeys = _defaultPreparedSpellKeys(current);
    final preparedKeys = _effectivePreparedSpellKeys(current)..remove(key);
    if (prepared) {
      preparedKeys.add(key);
    }
    final selections = _hasSpellSelection(current, key)
        ? current.spellSelections
        : [
            ...?current.spellSelections,
            CharacterSpellSelectionData(
              classDataId: classDataId,
              spell: spell,
              spellId: spell.id,
              spellKey: key,
              kind: CharacterSpellSelectionKind.knownSpell,
              selectionIndex: current.spellSelections?.length ?? 0,
            ),
          ];

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
    if (level <= 0) {
      return;
    }

    final current = _requireCharacter();
    final maxSlots = _spellSlotCount(current, level);
    final available = _currentSpellSlotCount(current, level);
    if (maxSlots <= 0 || available <= 0) {
      return;
    }

    await setCurrentSpellSlotsForLevel(level, available - 1);
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

    await _saveCharacter(
      current.copyWith(
        currentSpellSlots: currentSpellSlots.isEmpty ? null : currentSpellSlots,
        activeConcentrationSpellName: spell.concentration == true
            ? _spellName(spell)
            : current.activeConcentrationSpellName,
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
