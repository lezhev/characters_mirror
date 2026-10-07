// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../character_sheet_state.dart';

extension CharacterSheetControllerSpells on CharacterSheetController {
  Future<void> setCurrentSpellSlotsForLevel(int level, int available,
      {SpellSlotSource slotSource = SpellSlotSource.standard}) async {
    final current = _requireCharacter();
    final pools = SpellSlotPools.fromCharacter(current.toJson());
    final maximum = pools.maximum(slotSource, level);
    final delta =
        available.clamp(0, maximum) - pools.available(slotSource, level);
    if (delta == 0 || maximum <= 0) return;
    await adjustSpellSlots(level, delta, slotSource: slotSource);
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
    if (!selections.any((selection) =>
        _spellSelectionKey(selection) == key &&
        selection.kind == CharacterSpellSelectionKind.preparedSpell)) {
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
    if (prepared ||
        selections.any((selection) =>
            _spellSelectionKey(selection) == key &&
            selection.kind == CharacterSpellSelectionKind.preparedSpell)) {
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

  Future<void> adjustSpellSlots(int level, int delta,
      {SpellSlotSource slotSource = SpellSlotSource.standard}) async {
    if (level <= 0 || delta == 0) return;
    final current = _requireCharacter();
    final action = CharacterSemanticActionData(
        level: level, delta: delta, slotSource: slotSource.name);
    await _saveSemanticAction(adjustCharacterSpellSlots(current, action),
        type: CharacterSyncOperationType.adjustSpellSlots, action: action);
  }

  Future<void> castSpell(SpellData spell,
      {SpellCastContext? castContext}) async {
    final current = _requireCharacter();
    final resolved = characterResolvedSpells(current);
    final entry =
        resolved.where((s) => s.spellKey == spell.referenceKey).firstOrNull;
    if (entry == null) throw StateError('Заклинание недоступно персонажу.');
    final choices = availableSpellCasts(
        entry.spellKey,
        entry.spell.level ?? 0,
        entry.sources
            .map((s) => SpellSourceContext.fromJson(s.toJson()))
            .toList(),
        SpellSlotPools.fromCharacter(current.toJson()));
    final cast = castContext ?? choices.firstOrNull;
    if (cast == null) throw StateError('Нет доступной ячейки заклинания.');
    final action = CharacterSemanticActionData.fromJson(cast.toActionJson())
        .copyWith(
            startsConcentration: entry.spell.concentration == true,
            spellName:
                entry.spell.concentration == true ? entry.spell.name : null);
    final canonical = current.copyWith(
        derived: current.derived?.copyWith(resolvedSpells: resolved));
    await _saveSemanticAction(applyCharacterSpellCast(canonical, action),
        type: CharacterSyncOperationType.castSpell, action: action);
  }

  Future<void> cancelConcentration() async {
    final current = _requireCharacter();
    if (_normalizedText(current.activeConcentrationSpellName) == null) {
      return;
    }

    await _saveCharacter(current.copyWith(activeConcentrationSpellName: null));
  }
}
