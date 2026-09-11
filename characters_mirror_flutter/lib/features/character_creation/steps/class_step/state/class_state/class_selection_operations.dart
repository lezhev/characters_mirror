// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../class_state.dart';

extension ClassStateSelectionOperations on ClassState {
  Future<void> selectClass(ClassData newClass) async {
    final current = state.value;
    if (current == null) return;

    state = await AsyncValue.guard(() async {
      return _loadClassSelection(
        current: current,
        classData: newClass,
        selectedLevel: 1,
      );
    });
  }

  Future<void> selectSubclass(SubclassData newSubclass) async {
    final current = state.value;
    final selectedClass = current?.selectedClass;
    if (current == null || selectedClass?.id == null) return;

    state = await AsyncValue.guard(() async {
      final stepView = await ref
          .read(classRepositoryProvider)
          .getStepView(
            selectedClass!.id!,
            selectedLevel: current.selectedLevel,
            isStartingClass: true,
            selectedSubclassId: newSubclass.id,
          )
          .timeout(ClassState._requestTimeout);

      return current.copyWith(
        stepView: stepView,
        selectedSubclass: _findSubclassById(
          stepView.subclassChoice?.subclasses,
          newSubclass.id,
        ),
        selectedOptions: _normalizeSelectedOptions(
            current.selectedOptions, stepView.choiceGroups),
        selectedSkillSelections: _normalizeSkillSelections(
          current.selectedSkillSelections,
          stepView.skillSelectionGroups,
        ),
        selectedSpellSelections: _normalizeSpellSelections(
          current.selectedSpellSelections,
          stepView.spellSelectionGroups,
        ),
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: stepView.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: current.startingEquipmentSelections,
          sourceType: ChoiceSourceType.classData,
          sourceId: selectedClass.id!,
        ),
      );
    });
  }

  Future<void> unselectSubclass() async {
    final current = state.value;
    final selectedClass = current?.selectedClass;
    if (current == null || selectedClass?.id == null) return;

    state = await AsyncValue.guard(() async {
      final stepView = await ref
          .read(classRepositoryProvider)
          .getStepView(
            selectedClass!.id!,
            selectedLevel: current.selectedLevel,
            isStartingClass: true,
          )
          .timeout(ClassState._requestTimeout);

      return current.copyWith(
        stepView: stepView,
        selectedSubclass: null,
        selectedOptions: _normalizeSelectedOptions(
            current.selectedOptions, stepView.choiceGroups),
        selectedSkillSelections: _normalizeSkillSelections(
          current.selectedSkillSelections,
          stepView.skillSelectionGroups,
        ),
        selectedSpellSelections: _normalizeSpellSelections(
          current.selectedSpellSelections,
          stepView.spellSelectionGroups,
        ),
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: stepView.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: current.startingEquipmentSelections,
          sourceType: ChoiceSourceType.classData,
          sourceId: selectedClass.id!,
        ),
      );
    });
  }

  Future<void> refreshSpellSelectionGroupsForAbilityScores(
    Map<String, int> abilityScores,
  ) async {
    final current = state.value;
    final selectedClass = current?.selectedClass;
    if (current == null || selectedClass?.id == null) return;

    state = await AsyncValue.guard(() async {
      final stepView = await ref
          .read(classRepositoryProvider)
          .getStepView(
            selectedClass!.id!,
            selectedLevel: current.selectedLevel,
            isStartingClass: true,
            selectedSubclassId: current.selectedSubclass?.id,
            abilityScores: abilityScores,
          )
          .timeout(ClassState._requestTimeout);

      return current.copyWith(
        stepView: stepView,
        selectedSpellSelections: _normalizeSpellSelections(
          current.selectedSpellSelections,
          stepView.spellSelectionGroups,
        ),
      );
    });
  }

  void syncSpellSelectionsToCreationDraft() {
    final current = state.value;
    if (current == null || current.selectedClass == null) {
      return;
    }

    ref.read(characterCreationProvider.notifier).syncPrimaryClassDraft(
          classData: current.selectedClass,
          subclass: current.selectedSubclass,
          choiceGroups: current.stepView?.choiceGroups ?? const [],
          selectedOptions: current.selectedOptions,
          skillSelections: current.selectedSkillSelections,
          spellSelections: current.selectedSpellSelections,
          startingEquipmentSelections: current.startingEquipmentSelections,
          hasSpellCreationStep: _hasSpellSelectionGroups(
            current.stepView?.spellSelectionGroups,
          ),
          level: current.selectedLevel,
        );
  }
}
