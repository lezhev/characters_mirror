import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/starting_equipment_selection_support.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_state.g.dart';
part 'background_state.freezed.dart';

@freezed
abstract class BackgroundStateModel with _$BackgroundStateModel {
  const factory BackgroundStateModel({
    @Default([]) List<BackgroundData> allBackgrounds,
    BackgroundData? selectedBackground,
    BackgroundStepView? stepView,
    @Default({}) Map<String, List<ClassChoiceOptionData>> selectedOptions,
    @Default([]) List<CharacterSkillSelectionData> selectedSkillSelections,
    @Default([])
    List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections,
  }) = _BackgroundStateModel;
}

@riverpod
class BackgroundState extends _$BackgroundState {
  @override
  FutureOr<BackgroundStateModel> build() async {
    ref.keepAlive();

    final backgrounds = await ref.watch(backgroundRepositoryProvider).getAll();
    backgrounds.sort((a, b) => a.id!.compareTo(b.id!));

    final baseState = BackgroundStateModel(allBackgrounds: backgrounds);
    final characterCreation = ref.read(characterCreationProvider);
    final backgroundId = characterCreation.character.background?.id;
    if (backgroundId == null) {
      return baseState;
    }

    final selectedBackground = _findBackgroundById(backgrounds, backgroundId);
    if (selectedBackground == null) {
      return baseState;
    }

    return _loadBackgroundSelection(
      current: baseState,
      background: selectedBackground,
      savedChoices:
          characterCreation.character.choices ?? const <CharacterChoiceData>[],
      savedSkillSelections: characterCreation.character.skillSelections ??
          const <CharacterSkillSelectionData>[],
      savedEquipmentSelections:
          characterCreation.character.startingEquipmentSelections ??
              const <CharacterStartingEquipmentSelectionData>[],
    );
  }

  Future<void> selectBackground(BackgroundData newBackground) async {
    final current = state.value;
    if (current == null) return;

    state = await AsyncValue.guard(() async {
      return _loadBackgroundSelection(
        current: current,
        background: newBackground,
      );
    });
  }

  void unselectBackground() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedBackground: null,
        stepView: null,
        selectedOptions: const {},
        selectedSkillSelections: const [],
        startingEquipmentSelections: const [],
      ),
    );
  }

  void toggleOption(ClassChoiceGroupData group, ClassChoiceOptionData option) {
    final current = Map<String, List<ClassChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    final groupKey = _groupKey(group);
    final selected = [...?current[groupKey]];
    final optionKey = option.optionKey?.trim();
    if (optionKey == null || optionKey.isEmpty) return;

    if (group.allowDuplicates == true) {
      return;
    }

    final selectionCount = group.selectionCount ?? 1;
    final existingIndex = selected.indexWhere(
      (item) => item.optionKey?.trim() == optionKey,
    );

    if (selectionCount <= 1) {
      if (existingIndex != -1) {
        current.remove(groupKey);
      } else {
        current[groupKey] = [option];
      }
    } else {
      if (existingIndex != -1) {
        selected.removeAt(existingIndex);
      } else if (selected.length < selectionCount) {
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

  void incrementOption(
      ClassChoiceGroupData group, ClassChoiceOptionData option) {
    if (group.allowDuplicates != true) return;

    final current = Map<String, List<ClassChoiceOptionData>>.from(
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

  void decrementOption(
      ClassChoiceGroupData group, ClassChoiceOptionData option) {
    final current = Map<String, List<ClassChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    final groupKey = _groupKey(group);
    final selected = [...?current[groupKey]];
    final optionKey = option.optionKey?.trim();
    if (optionKey == null || optionKey.isEmpty) return;

    final existingIndex = selected.indexWhere(
      (item) => item.optionKey?.trim() == optionKey,
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

  void clearGroup(ClassChoiceGroupData group) {
    final current = Map<String, List<ClassChoiceOptionData>>.from(
      state.value!.selectedOptions,
    );
    current.remove(_groupKey(group));

    state = AsyncValue.data(
      state.value!.copyWith(selectedOptions: current),
    );
  }

  void toggleSkillSelection(
    SkillSelectionGroupView group,
    Skill skill,
  ) {
    final currentState = state.value;
    final backgroundId = currentState?.selectedBackground?.id;
    final kind = group.kind;
    if (currentState == null || backgroundId == null || kind == null) {
      return;
    }

    final selected = [
      for (final selection in currentState.selectedSkillSelections)
        if (selection.backgroundDataId == backgroundId &&
            selection.kind == kind)
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
          backgroundDataId: backgroundId,
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
        if (!(selection.backgroundDataId == backgroundId &&
            selection.kind == kind))
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
    final backgroundId = currentState?.selectedBackground?.id;
    final kind = group.kind;
    if (currentState == null || backgroundId == null || kind == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        selectedSkillSelections: [
          for (final selection in currentState.selectedSkillSelections)
            if (!(selection.backgroundDataId == backgroundId &&
                selection.kind == kind))
              selection,
        ],
      ),
    );
  }

  void selectStartingEquipmentOption(
    StartingEquipmentBlockView blockView,
    StartingEquipmentOptionView optionView,
  ) {
    final currentState = state.value;
    final backgroundId = currentState?.selectedBackground?.id;
    final sourceEntryId = blockView.block?.entryId;
    final optionEntryId = optionView.option?.entryId;
    if (currentState == null ||
        backgroundId == null ||
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
        sourceType: ChoiceSourceType.background,
        sourceId: backgroundId,
        sourceEntryId: sourceEntryId,
      ),
    );
    final isSameOption = existing.choiceOptionEntryId == optionEntryId;

    if (!isSameOption) {
      selections.add(
        CharacterStartingEquipmentSelectionData(
          sourceType: ChoiceSourceType.background,
          sourceId: backgroundId,
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
          sourceType: ChoiceSourceType.background,
          sourceId: backgroundId,
        ),
      ),
    );
  }

  void selectStartingEquipmentFixedBlock(StartingEquipmentBlockView blockView) {
    final currentState = state.value;
    final backgroundId = currentState?.selectedBackground?.id;
    final sourceEntryId = blockView.block?.entryId;
    if (currentState == null || backgroundId == null || sourceEntryId == null) {
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
              sourceType: ChoiceSourceType.background,
              sourceId: backgroundId,
              sourceEntryId: sourceEntryId,
              isSelected: true,
              selectionIndex: 0,
              resolutions: const [],
            ),
          ],
          sourceType: ChoiceSourceType.background,
          sourceId: backgroundId,
        ),
      ),
    );
  }

  void clearStartingEquipmentBlock(StartingEquipmentBlockView blockView) {
    final currentState = state.value;
    final backgroundId = currentState?.selectedBackground?.id;
    final sourceEntryId = blockView.block?.entryId;
    if (currentState == null || backgroundId == null || sourceEntryId == null) {
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
                sourceType: ChoiceSourceType.background,
                sourceId: backgroundId,
                sourceEntryId: sourceEntryId,
                isSelected: false,
                selectionIndex: 0,
                resolutions: const [],
              ),
          ],
          sourceType: ChoiceSourceType.background,
          sourceId: backgroundId,
        ),
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
    final backgroundId = currentState?.selectedBackground?.id;
    final sourceEntryId = blockView.block?.entryId;
    final lineEntryId = line.entryId;
    if (currentState == null ||
        backgroundId == null ||
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
        sourceType: ChoiceSourceType.background,
        sourceId: backgroundId,
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
        sourceType: ChoiceSourceType.background,
        sourceId: backgroundId,
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
          sourceType: ChoiceSourceType.background,
          sourceId: backgroundId,
        ),
      ),
    );
  }

  Future<BackgroundStateModel> _loadBackgroundSelection({
    required BackgroundStateModel current,
    required BackgroundData background,
    List<CharacterChoiceData> savedChoices = const [],
    List<CharacterSkillSelectionData> savedSkillSelections = const [],
    List<CharacterStartingEquipmentSelectionData> savedEquipmentSelections =
        const [],
  }) async {
    final backgroundId = background.id;
    if (backgroundId == null) {
      return current.copyWith(
        selectedBackground: background,
        stepView: null,
        selectedOptions: const {},
        selectedSkillSelections: const [],
        startingEquipmentSelections: const [],
      );
    }

    final stepView =
        await ref.read(backgroundRepositoryProvider).getStepView(backgroundId);
    return current.copyWith(
      selectedBackground: stepView.background ?? background,
      stepView: stepView,
      selectedOptions: _restoreSelectedOptions(
        stepView.choiceGroups,
        savedChoices,
      ),
      selectedSkillSelections: _normalizeSkillSelections(
        savedSkillSelections,
        stepView.skillSelectionGroups,
      ),
      startingEquipmentSelections: normalizeStartingEquipmentSelections(
        blocks: stepView.startingEquipmentBlocks ??
            const <StartingEquipmentBlockView>[],
        selections: savedEquipmentSelections,
        sourceType: ChoiceSourceType.background,
        sourceId: backgroundId,
      ),
    );
  }

  Map<String, List<ClassChoiceOptionData>> _restoreSelectedOptions(
    List<ClassChoiceGroupView>? groups,
    List<CharacterChoiceData> savedChoices,
  ) {
    final optionsByGroupKey = _availableOptionsByGroup(groups);
    final restored = <String, List<ClassChoiceOptionData>>{};
    final sortedChoices = [
      ...savedChoices
    ]..sort((a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));

    for (final choice in sortedChoices) {
      if (choice.sourceType != ChoiceSourceType.background) continue;

      final groupKey = choice.groupKey;
      final optionKey = choice.optionKey?.trim();
      if (groupKey == null || optionKey == null || optionKey.isEmpty) continue;

      final option = optionsByGroupKey[groupKey]?[optionKey];
      if (option == null) continue;

      restored.putIfAbsent(groupKey, () => <ClassChoiceOptionData>[]);
      restored[groupKey]!.add(option);
    }

    return _normalizeSelectedOptions(restored, groups);
  }

  List<CharacterSkillSelectionData> _normalizeSkillSelections(
    List<CharacterSkillSelectionData> selections,
    List<SkillSelectionGroupView>? groups,
  ) {
    final groupMap = {
      for (final group in groups ?? const <SkillSelectionGroupView>[])
        if (group.kind != null && group.backgroundDataId != null)
          '${group.backgroundDataId}:${group.kind!.name}': group,
    };
    final normalized = <CharacterSkillSelectionData>[];

    for (final entry in groupMap.entries) {
      final group = entry.value;
      final available = {
        for (final skill in group.options ?? const <Skill>[]) skill: skill,
      };
      final selected = [
        for (final selection in selections)
          if ('${selection.backgroundDataId}:${selection.kind?.name}' ==
                  entry.key &&
              selection.skill != null &&
              available.containsKey(selection.skill))
            selection,
      ]..sort(
          (left, right) =>
              (left.selectionIndex ?? 0).compareTo(right.selectionIndex ?? 0),
        );

      final limit = group.selectionCount ?? 1;
      final seen = <Skill>{};
      for (final selection in selected) {
        if (seen.length >= limit) break;
        final skill = selection.skill;
        if (skill == null || seen.contains(skill)) continue;
        seen.add(skill);
        normalized.add(
          selection.copyWith(
            backgroundDataId: group.backgroundDataId,
            skill: available[skill],
            kind: group.kind,
            selectionIndex: seen.length - 1,
          ),
        );
      }
    }

    return normalized;
  }

  Map<String, List<ClassChoiceOptionData>> _normalizeSelectedOptions(
    Map<String, List<ClassChoiceOptionData>> selections,
    List<ClassChoiceGroupView>? groups,
  ) {
    final choiceGroups = {
      for (final groupView in groups ?? const <ClassChoiceGroupView>[])
        if (groupView.group != null)
          _groupKey(groupView.group!): groupView.group!,
    };
    final availableOptions = _availableOptionsByGroup(groups);
    final normalized = <String, List<ClassChoiceOptionData>>{};

    for (final entry in selections.entries) {
      final group = choiceGroups[entry.key];
      if (group == null) continue;

      final selectionCount = group.selectionCount ?? 1;
      final allowDuplicates = group.allowDuplicates == true;
      final canonicalOptions = availableOptions[entry.key] ?? const {};
      final selected = <ClassChoiceOptionData>[];
      final seen = <String>{};

      for (final option in entry.value) {
        final optionKey = option.optionKey?.trim();
        if (optionKey == null || optionKey.isEmpty) continue;

        final canonical = canonicalOptions[optionKey];
        if (canonical == null) continue;

        if (!allowDuplicates) {
          if (seen.contains(optionKey)) continue;
          seen.add(optionKey);
        }

        selected.add(canonical);
        if (selected.length >= selectionCount) break;
      }

      if (selected.isNotEmpty) {
        normalized[entry.key] = selected;
      }
    }

    return normalized;
  }

  Map<String, Map<String, ClassChoiceOptionData>> _availableOptionsByGroup(
    List<ClassChoiceGroupView>? groups,
  ) {
    final result = <String, Map<String, ClassChoiceOptionData>>{};

    for (final groupView in groups ?? const <ClassChoiceGroupView>[]) {
      final group = groupView.group;
      if (group == null) continue;

      result[_groupKey(group)] = {
        for (final option
            in groupView.options ?? const <ClassChoiceOptionData>[])
          if (option.optionKey?.trim().isNotEmpty == true)
            option.optionKey!.trim(): option,
      };
    }

    return result;
  }

  StartingEquipmentOptionView? _selectedStartingEquipmentOption({
    required StartingEquipmentBlockView blockView,
    required List<CharacterStartingEquipmentSelectionData> selections,
  }) {
    final sourceEntryId = blockView.block?.entryId;
    if (sourceEntryId == null) {
      return null;
    }
    final selection = selections.firstWhere(
      (item) => item.sourceEntryId == sourceEntryId,
      orElse: () => CharacterStartingEquipmentSelectionData(),
    );
    final optionEntryId = selection.choiceOptionEntryId;
    if (optionEntryId == null) {
      return null;
    }
    for (final optionView
        in blockView.options ?? const <StartingEquipmentOptionView>[]) {
      if (optionView.option?.entryId == optionEntryId) {
        return optionView;
      }
    }
    return null;
  }

  BackgroundData? _findBackgroundById(List<BackgroundData> items, int? id) {
    if (id == null) return null;
    try {
      return items.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  String _groupKey(ClassChoiceGroupData group) =>
      group.exclusiveKey?.trim().isNotEmpty == true
          ? group.exclusiveKey!
          : 'group_${group.id ?? group.name ?? group.type?.name ?? 'unknown'}';
}
