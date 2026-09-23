// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../character_sheet_state.dart';

extension CharacterSheetControllerPersonal on CharacterSheetController {
  Future<void> adjustExperience(int delta) async {
    if (delta == 0) return;
    final current = _requireCharacter();
    final next = (current.experience ?? 0) + delta;
    if (next < 0) return;
    await _saveSemanticAction(
      current.copyWith(experience: next == 0 ? null : next),
      type: CharacterSyncOperationType.adjustExperience,
      action: CharacterSemanticActionData(delta: delta),
    );
  }

  Future<void> setInspiration(bool value) async {
    final current = _requireCharacter();
    await _saveCharacter(current.copyWith(inspiration: value ? true : null));
  }

  Future<void> saveConditions({
    required List<ConditionType> activeConditions,
    int? exhaustionLevel,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        activeConditions: _normalizedActiveConditions(activeConditions),
        exhaustionLevel: _normalizedExhaustionLevel(exhaustionLevel),
      ),
    );
  }

  Future<void> removeCondition(ConditionType condition) async {
    final current = _requireCharacter();
    if (condition == ConditionType.exhaustion) {
      await _saveCharacter(current.copyWith(exhaustionLevel: null));
      return;
    }

    final activeConditions = [
      for (final activeCondition
          in current.activeConditions ?? const <ConditionType>[])
        if (activeCondition != condition) activeCondition,
    ];
    await _saveCharacter(
      current.copyWith(
        activeConditions: activeConditions.isEmpty ? null : activeConditions,
      ),
    );
  }

  Future<void> savePersonalInfo({
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    CharacterAlignment? alignmentValue,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
  }) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        name: _normalizedText(name),
        age: _normalizedText(age),
        height: _normalizedText(height),
        weight: _normalizedText(weight),
        eyes: _normalizedText(eyes),
        skin: _normalizedText(skin),
        hair: _normalizedText(hair),
        alignmentValue: alignmentValue,
        appearance: _normalizedText(appearance),
        backstory: _normalizedText(backstory),
        goals: _normalizedText(goals),
        alliesOrganizations: _normalizedText(alliesOrganizations),
        personalityTraits: _normalizedText(personalityTraits),
        ideals: _normalizedText(ideals),
        bonds: _normalizedText(bonds),
        flaws: _normalizedText(flaws),
      ),
      debounce: false,
    );
  }

  Future<void> addNote() async {}

  Future<void> updateNote(String id, String note) async {
    final current = _requireCharacter();
    logCharacterSyncLifecycle(
      stage: 'ui-edit-accepted',
      characterId: current.id,
      noteId: id,
      noteText: note,
      localVersion: current.version,
      status: 'local-save-pending',
    );
    await _saveCharacter(
      current.copyWith(
        notes: upsertCharacterNote(current.notes, id: id, text: note),
      ),
    );
  }

  Future<void> deleteNote(String id) async {
    final current = _requireCharacter();
    await _saveCharacter(
      current.copyWith(
        notes: removeCharacterNote(current.notes, id),
      ),
    );
  }
}
