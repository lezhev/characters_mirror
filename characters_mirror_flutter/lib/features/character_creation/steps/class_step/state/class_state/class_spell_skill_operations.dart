// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../class_state.dart';

extension ClassStateSpellSkillOperations on ClassState {
  void toggleSpellSelection(
    ClassSpellSelectionGroupView group,
    SpellData spell,
  ) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final kind = group.kind;
    final spellKey = _spellKey(spell);
    if (currentState == null ||
        classId == null ||
        kind == null ||
        spellKey == null) {
      return;
    }

    final selected = [
      for (final selection in currentState.selectedSpellSelections)
        if (selection.classDataId == classId && selection.kind == kind)
          selection,
    ];
    final existingIndex = selected.indexWhere(
      (selection) => _selectionSpellKey(selection) == spellKey,
    );
    if (existingIndex != -1) {
      selected.removeAt(existingIndex);
    } else if (selected.length < (group.selectionCount ?? 1)) {
      selected.add(
        CharacterSpellSelectionData(
          classDataId: classId,
          spell: spell,
          spellId: spell.id,
          spellKey: spellKey,
          kind: kind,
          selectionIndex: selected.length,
        ),
      );
    } else {
      return;
    }

    final nextSelections = [
      for (final selection in currentState.selectedSpellSelections)
        if (!(selection.classDataId == classId && selection.kind == kind))
          selection,
      for (var index = 0; index < selected.length; index++)
        selected[index].copyWith(selectionIndex: index),
    ];

    state = AsyncValue.data(
      currentState.copyWith(
        selectedSpellSelections: _normalizeSpellSelections(
          nextSelections,
          currentState.stepView?.spellSelectionGroups,
        ),
      ),
    );
  }

  void toggleSkillSelection(
    SkillSelectionGroupView group,
    Skill skill,
  ) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final kind = group.kind;
    if (currentState == null || classId == null || kind == null) {
      return;
    }

    final selected = [
      for (final selection in currentState.selectedSkillSelections)
        if (selection.classDataId == classId && selection.kind == kind)
          selection,
    ];
    final existingIndex = selected.indexWhere(
      (selection) => selection.skill == skill,
    );
    if (existingIndex != -1) {
      selected.removeAt(existingIndex);
    } else if (selected.length < (group.selectionCount ?? 1)) {
      selected.add(
        CharacterSkillSelectionData(
          classDataId: classId,
          skill: skill,
          kind: kind,
          selectionIndex: selected.length,
        ),
      );
    } else {
      return;
    }

    final nextSelections = [
      for (final selection in currentState.selectedSkillSelections)
        if (!(selection.classDataId == classId && selection.kind == kind))
          selection,
      for (var index = 0; index < selected.length; index++)
        selected[index].copyWith(selectionIndex: index),
    ];

    state = AsyncValue.data(
      currentState.copyWith(
        selectedSkillSelections: _normalizeSkillSelections(
          nextSelections,
          currentState.stepView?.skillSelectionGroups,
        ),
      ),
    );
  }

  void clearSkillSelectionGroup(SkillSelectionGroupView group) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final kind = group.kind;
    if (currentState == null || classId == null || kind == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        selectedSkillSelections: [
          for (final selection in currentState.selectedSkillSelections)
            if (!(selection.classDataId == classId && selection.kind == kind))
              selection,
        ],
      ),
    );
  }

  void clearSpellSelectionGroup(ClassSpellSelectionGroupView group) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final kind = group.kind;
    if (currentState == null || classId == null || kind == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        selectedSpellSelections: [
          for (final selection in currentState.selectedSpellSelections)
            if (!(selection.classDataId == classId && selection.kind == kind))
              selection,
        ],
      ),
    );
  }

  void setStartingEquipmentResolution({
    required StartingEquipmentBlockView blockView,
    required StartingEquipmentLineData line,
    required EquipmentCatalogType catalogType,
    required String referenceKey,
  }) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final sourceEntryId = blockView.block?.entryId;
    final lineEntryId = line.entryId;
    if (currentState == null ||
        classId == null ||
        sourceEntryId == null ||
        lineEntryId == null ||
        normalizedEquipmentText(referenceKey) == null) {
      return;
    }

    final selectedOption = _selectedStartingEquipmentOption(
      blockView: blockView,
      selections: currentState.startingEquipmentSelections,
    );
    final optionEntryId = selectedOption?.option?.entryId;
    final existingSelection =
        currentState.startingEquipmentSelections.firstWhere(
      (selection) =>
          selection.sourceEntryId == sourceEntryId &&
          selection.choiceOptionEntryId == optionEntryId,
      orElse: () => CharacterStartingEquipmentSelectionData(
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
        sourceEntryId: sourceEntryId,
        choiceOptionEntryId: optionEntryId,
        selectionIndex: 0,
      ),
    );

    final updatedResolutions = [
      for (final resolution in existingSelection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[])
        if (resolution.sourceLineEntryId != lineEntryId) resolution,
      CharacterStartingEquipmentResolutionData(
        sourceLineEntryId: lineEntryId,
        catalogType: catalogType,
        referenceKey: normalizedEquipmentText(referenceKey),
        quantity: line.quantity,
      ),
    ];
    final nextSelections = [
      for (final selection in currentState.startingEquipmentSelections)
        if (!(selection.sourceEntryId == sourceEntryId &&
            selection.choiceOptionEntryId == optionEntryId))
          selection,
      existingSelection.copyWith(
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
        sourceEntryId: sourceEntryId,
        choiceOptionEntryId: optionEntryId,
        isSelected: true,
        resolutions: updatedResolutions,
      ),
    ];

    state = AsyncValue.data(
      currentState.copyWith(
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: currentState.stepView?.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: nextSelections,
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
        ),
      ),
    );
  }
}
