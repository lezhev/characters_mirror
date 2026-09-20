// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../character_sheet_state.dart';

extension CharacterSheetControllerAbilities on CharacterSheetController {
  Future<void> saveBaseAbilityScore(Ability ability, int? score) async {
    final current = _requireCharacter();
    final scores = <String, int>{...?current.baseAbilityScores};
    if (score == null) {
      scores.remove(ability.name);
    } else {
      scores[ability.name] = score;
    }

    await _saveCharacter(
      current.copyWith(
        baseAbilityScores: scores.isEmpty ? null : scores,
      ),
    );
  }

  Future<void> saveCustomAbilityBonus(Ability ability, int? bonus) async {
    final current = _requireCharacter();
    final bonuses = <String, int>{...?current.customAbilityBonuses};
    if (bonus == null || bonus == 0) {
      bonuses.remove(ability.name);
    } else {
      bonuses[ability.name] = bonus;
    }

    await _saveCharacter(
      current.copyWith(
        customAbilityBonuses: bonuses.isEmpty ? null : bonuses,
      ),
    );
  }

  Future<void> saveAbilityDetails({
    required Ability ability,
    required int? score,
    required int? customBonus,
    required bool savingThrowProficient,
  }) async {
    final current = _requireCharacter();
    final scores = <String, int>{...?current.baseAbilityScores};
    if (score == null) {
      scores.remove(ability.name);
    } else {
      scores[ability.name] = score;
    }

    final bonuses = <String, int>{...?current.customAbilityBonuses};
    if (customBonus == null || customBonus == 0) {
      bonuses.remove(ability.name);
    } else {
      bonuses[ability.name] = customBonus;
    }

    final overrides = buildManualSavingThrowProficiencies(
      character: current,
      ability: ability,
      proficient: savingThrowProficient,
    );
    final updated = withOptimisticSavingThrowProficiency(
      character: current,
      manualSavingThrowProficiencies: overrides,
    );
    await _saveCharacter(
      updated.copyWith(
        baseAbilityScores: scores.isEmpty ? null : scores,
        customAbilityBonuses: bonuses.isEmpty ? null : bonuses,
      ),
    );
  }

  Future<void> saveSkillProficiency(
    Skill skill,
    CharacterSkillProficiencyLevel level,
  ) async {
    final current = _requireCharacter();
    final manualSkillProficiencies = buildManualSkillProficiencies(
      character: current,
      skill: skill,
      level: level,
    );
    await _saveCharacter(
      withOptimisticSkillProficiency(
        character: current,
        manualSkillProficiencies: manualSkillProficiencies,
      ),
    );
  }

  Future<void> saveSavingThrowProficiency(
    Ability ability,
    bool proficient,
  ) async {
    final current = _requireCharacter();
    final manualSavingThrowProficiencies = buildManualSavingThrowProficiencies(
      character: current,
      ability: ability,
      proficient: proficient,
    );
    await _saveCharacter(
      withOptimisticSavingThrowProficiency(
        character: current,
        manualSavingThrowProficiencies: manualSavingThrowProficiencies,
      ),
    );
  }
}
