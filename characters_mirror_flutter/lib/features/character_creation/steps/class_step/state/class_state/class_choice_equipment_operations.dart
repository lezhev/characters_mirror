// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

part of '../class_state.dart';

extension ClassStateChoiceEquipmentOperations on ClassState {
  void reconcileExpertiseSelections(
    Map<String, Set<String>> eligibleOptionKeysByGroup,
  ) {
    final currentState = state.value;
    if (currentState == null) return;

    final selectedOptions = Map<String, List<ChoiceOptionData>>.from(
      currentState.selectedOptions,
    );
    var changed = false;
    for (final entry in eligibleOptionKeysByGroup.entries) {
      final selected = selectedOptions[entry.key];
      if (selected == null) continue;
      final valid = [
        for (final option in selected)
          if (entry.value.contains(option.optionKey.trim())) option,
      ];
      if (valid.length == selected.length) continue;
      changed = true;
      if (valid.isEmpty) {
        selectedOptions.remove(entry.key);
      } else {
        selectedOptions[entry.key] = valid;
      }
    }
    if (changed) {
      state = AsyncValue.data(currentState.copyWith(
        selectedOptions: selectedOptions,
      ));
    }
  }

  void toggleOption(ChoiceGroupData group, ChoiceOptionData option) {
    final current = Map<String, List<ChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    final groupKey = _groupKey(group);
    final selected = [...?current[groupKey]];
    final optionKey = option.optionKey.trim();
    if (optionKey.isEmpty) return;

    if (group.allowDuplicates == true) {
      return;
    }

    final selectedCount = group.selectionCount ?? 1;
    final existingIndex = selected.indexWhere(
      (item) => item.optionKey.trim() == optionKey,
    );

    if (selectedCount <= 1) {
      if (existingIndex != -1) {
        current.remove(groupKey);
      } else {
        current[groupKey] = [option];
      }
    } else {
      if (existingIndex != -1) {
        selected.removeAt(existingIndex);
      } else if (selected.length < selectedCount) {
        selected.add(option);
      } else {
        return;
      }

      if (selected.isEmpty) {
        current.remove(groupKey);
      } else {
        current[groupKey] = selected;
      }
    }

    state = AsyncValue.data(
      state.value!.copyWith(selectedOptions: current),
    );
  }

  void incrementOption(ChoiceGroupData group, ChoiceOptionData option) {
    if (group.allowDuplicates != true) return;

    final current = Map<String, List<ChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    final groupKey = _groupKey(group);
    final selected = [...?current[groupKey]];
    final selectionCount = group.selectionCount ?? 1;
    if (selected.length >= selectionCount) return;

    selected.add(option);
    current[groupKey] = selected;

    state = AsyncValue.data(
      state.value!.copyWith(selectedOptions: current),
    );
  }

  void decrementOption(ChoiceGroupData group, ChoiceOptionData option) {
    final current = Map<String, List<ChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    final groupKey = _groupKey(group);
    final selected = [...?current[groupKey]];
    final optionKey = option.optionKey.trim();
    if (optionKey.isEmpty) return;

    final existingIndex = selected.indexWhere(
      (item) => item.optionKey.trim() == optionKey,
    );
    if (existingIndex == -1) return;

    selected.removeAt(existingIndex);
    if (selected.isEmpty) {
      current.remove(groupKey);
    } else {
      current[groupKey] = selected;
    }

    state = AsyncValue.data(
      state.value!.copyWith(selectedOptions: current),
    );
  }

  void clearGroup(ChoiceGroupData group) {
    final current = Map<String, List<ChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    current.remove(_groupKey(group));

    state = AsyncValue.data(
      state.value!.copyWith(selectedOptions: current),
    );
  }

  void unselectClass() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedClass: null,
        stepView: null,
        selectedSubclass: null,
        selectedOptions: {},
        selectedSkillSelections: const [],
        selectedSpellSelections: const [],
        startingEquipmentSelections: const [],
        selectedLevel: 1,
      ),
    );
  }

  void selectStartingEquipmentOption(
    StartingEquipmentBlockView blockView,
    StartingEquipmentOptionView optionView,
  ) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final sourceEntryId = blockView.block?.entryId;
    final optionEntryId = optionView.option?.entryId;
    if (currentState == null ||
        classId == null ||
        sourceEntryId == null ||
        optionEntryId == null) {
      return;
    }

    final selections = [
      for (final selection in currentState.startingEquipmentSelections)
        if (selection.sourceEntryId != sourceEntryId) selection,
    ];
    final existing = currentState.startingEquipmentSelections.firstWhere(
      (selection) => selection.sourceEntryId == sourceEntryId,
      orElse: () => CharacterStartingEquipmentSelectionData(
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
        sourceEntryId: sourceEntryId,
      ),
    );
    final isSameOption = existing.choiceOptionEntryId == optionEntryId;

    if (!isSameOption) {
      selections.add(
        CharacterStartingEquipmentSelectionData(
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
          sourceEntryId: sourceEntryId,
          choiceOptionEntryId: optionEntryId,
          isSelected: true,
          selectionIndex: 0,
          resolutions: const [],
        ),
      );
    }

    state = AsyncValue.data(
      currentState.copyWith(
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: currentState.stepView?.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: selections,
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
        ),
      ),
    );
  }

  void selectStartingEquipmentFixedBlock(StartingEquipmentBlockView blockView) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final sourceEntryId = blockView.block?.entryId;
    if (currentState == null || classId == null || sourceEntryId == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: currentState.stepView?.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: [
            for (final selection in currentState.startingEquipmentSelections)
              if (selection.sourceEntryId != sourceEntryId) selection,
            CharacterStartingEquipmentSelectionData(
              sourceType: ChoiceSourceType.classData,
              sourceId: classId,
              sourceEntryId: sourceEntryId,
              isSelected: true,
              selectionIndex: 0,
              resolutions: const [],
            ),
          ],
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
        ),
      ),
    );
  }

  void clearStartingEquipmentBlock(StartingEquipmentBlockView blockView) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final sourceEntryId = blockView.block?.entryId;
    if (currentState == null || classId == null || sourceEntryId == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: currentState.stepView?.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: [
            for (final selection in currentState.startingEquipmentSelections)
              if (selection.sourceEntryId != sourceEntryId) selection,
            if (blockView.block?.kind == StartingEquipmentBlockKind.fixedGrant)
              CharacterStartingEquipmentSelectionData(
                sourceType: ChoiceSourceType.classData,
                sourceId: classId,
                sourceEntryId: sourceEntryId,
                isSelected: false,
                selectionIndex: 0,
                resolutions: const [],
              ),
          ],
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
        ),
      ),
    );
  }
}
