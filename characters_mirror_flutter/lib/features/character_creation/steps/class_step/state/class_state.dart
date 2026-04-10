import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/starting_equipment_selection_support.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'class_state.g.dart';
part 'class_state.freezed.dart';

@freezed
sealed class ClassStateModel with _$ClassStateModel {
  const factory ClassStateModel({
    @Default([]) List<ClassData> allClasses,
    ClassData? selectedClass,
    ClassStepView? stepView,
    SubclassData? selectedSubclass,
    @Default({}) Map<String, List<ClassChoiceOptionData>> selectedOptions,
    @Default([])
    List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections,
    @Default(1) int selectedLevel,
  }) = _ClassStateModel;
}

@riverpod
class ClassState extends _$ClassState {
  static const _requestTimeout = Duration(seconds: 10);

  @override
  FutureOr<ClassStateModel> build() async {
    ref.keepAlive();

    final repository = ref.watch(classRepositoryProvider);
    final classes = await repository.getAll().timeout(_requestTimeout);
    classes.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    final baseState = ClassStateModel(
      allClasses: classes,
      selectedLevel: 1,
    );

    final characterCreation = ref.read(characterCreationProvider);
    final entry = _resolvePrimaryEntry(
      characterCreation.character.classEntries ??
          const <CharacterClassEntryData>[],
    );
    final selectedClassId = entry?.classData?.id;
    if (selectedClassId == null) {
      return baseState;
    }

    final selectedClass = _findClassById(classes, selectedClassId);
    if (selectedClass == null) {
      return baseState;
    }

    return _loadClassSelection(
      current: baseState,
      classData: selectedClass,
      selectedSubclassId: entry?.subclass?.id,
      selectedLevel: entry?.level ?? 1,
      savedChoices:
          characterCreation.character.choices ?? const <CharacterChoiceData>[],
      savedEquipmentSelections:
          characterCreation.character.startingEquipmentSelections ??
              const <CharacterStartingEquipmentSelectionData>[],
    );
  }

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
          .timeout(_requestTimeout);

      return current.copyWith(
        stepView: stepView,
        selectedSubclass: _findSubclassById(
          stepView.subclassChoice?.subclasses,
          newSubclass.id,
        ),
        selectedOptions: _normalizeSelectedOptions(
            current.selectedOptions, stepView.choiceGroups),
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
          .timeout(_requestTimeout);

      return current.copyWith(
        stepView: stepView,
        selectedSubclass: null,
        selectedOptions: _normalizeSelectedOptions(
            current.selectedOptions, stepView.choiceGroups),
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

    final selectedCount = group.selectionCount ?? 1;
    final existingIndex = selected.indexWhere(
      (item) => item.optionKey?.trim() == optionKey,
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

  void unselectClass() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedClass: null,
        stepView: null,
        selectedSubclass: null,
        selectedOptions: {},
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
    final blockKey = normalizedEquipmentKey(blockView.block?.blockKey);
    final optionKey = normalizedEquipmentKey(optionView.option?.optionKey);
    if (currentState == null ||
        classId == null ||
        blockKey == null ||
        optionKey == null) {
      return;
    }

    final selections = [
      for (final selection in currentState.startingEquipmentSelections)
        if (normalizedEquipmentKey(selection.blockKey) != blockKey) selection,
    ];
    final existing = currentState.startingEquipmentSelections.firstWhere(
      (selection) => normalizedEquipmentKey(selection.blockKey) == blockKey,
      orElse: () => CharacterStartingEquipmentSelectionData(
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
        blockKey: blockKey,
      ),
    );
    final isSameOption =
        normalizedEquipmentKey(existing.optionKey) == optionKey;

    if (!isSameOption) {
      selections.add(
        CharacterStartingEquipmentSelectionData(
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
          blockKey: blockKey,
          optionKey: optionView.option?.optionKey,
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

  void clearStartingEquipmentBlock(StartingEquipmentBlockView blockView) {
    final currentState = state.value;
    final classId = currentState?.selectedClass?.id;
    final blockKey = normalizedEquipmentKey(blockView.block?.blockKey);
    if (currentState == null || classId == null || blockKey == null) {
      return;
    }

    state = AsyncValue.data(
      currentState.copyWith(
        startingEquipmentSelections: normalizeStartingEquipmentSelections(
          blocks: currentState.stepView?.startingEquipmentBlocks ??
              const <StartingEquipmentBlockView>[],
          selections: [
            for (final selection in currentState.startingEquipmentSelections)
              if (normalizedEquipmentKey(selection.blockKey) != blockKey)
                selection,
          ],
          sourceType: ChoiceSourceType.classData,
          sourceId: classId,
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
    final classId = currentState?.selectedClass?.id;
    final blockKey = normalizedEquipmentKey(blockView.block?.blockKey);
    final lineKey = normalizedEquipmentKey(line.lineKey);
    if (currentState == null ||
        classId == null ||
        blockKey == null ||
        lineKey == null ||
        normalizedEquipmentKey(referenceKey) == null) {
      return;
    }

    final selectedOption = _selectedStartingEquipmentOption(
      blockView: blockView,
      selections: currentState.startingEquipmentSelections,
    );
    final optionKey = normalizedEquipmentKey(selectedOption?.option?.optionKey);
    final existingSelection =
        currentState.startingEquipmentSelections.firstWhere(
      (selection) =>
          normalizedEquipmentKey(selection.blockKey) == blockKey &&
          normalizedEquipmentKey(selection.optionKey) == optionKey,
      orElse: () => CharacterStartingEquipmentSelectionData(
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
        blockKey: blockKey,
        optionKey: selectedOption?.option?.optionKey,
        selectionIndex: 0,
      ),
    );

    final updatedResolutions = [
      for (final resolution in existingSelection.resolutions ??
          const <CharacterStartingEquipmentResolutionData>[])
        if (normalizedEquipmentKey(resolution.lineKey) != lineKey) resolution,
      CharacterStartingEquipmentResolutionData(
        lineKey: line.lineKey,
        catalogType: catalogType,
        referenceKey: normalizedEquipmentKey(referenceKey),
        quantity: line.quantity,
      ),
    ];
    final nextSelections = [
      for (final selection in currentState.startingEquipmentSelections)
        if (!(normalizedEquipmentKey(selection.blockKey) == blockKey &&
            normalizedEquipmentKey(selection.optionKey) == optionKey))
          selection,
      existingSelection.copyWith(
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
        blockKey: blockView.block?.blockKey,
        optionKey: selectedOption?.option?.optionKey,
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

  Future<ClassStateModel> _loadClassSelection({
    required ClassStateModel current,
    required ClassData classData,
    int? selectedSubclassId,
    int selectedLevel = 1,
    List<CharacterChoiceData> savedChoices = const [],
    List<CharacterStartingEquipmentSelectionData> savedEquipmentSelections =
        const [],
  }) async {
    final classId = classData.id;
    if (classId == null) {
      return current.copyWith(
        selectedClass: classData,
        stepView: null,
        selectedSubclass: null,
        selectedOptions: const {},
        startingEquipmentSelections: const [],
        selectedLevel: selectedLevel,
      );
    }

    final stepView = await ref
        .read(classRepositoryProvider)
        .getStepView(
          classId,
          selectedLevel: selectedLevel,
          isStartingClass: true,
          selectedSubclassId: selectedSubclassId,
        )
        .timeout(_requestTimeout);

    return current.copyWith(
      selectedClass: classData,
      stepView: stepView,
      selectedSubclass: _findSubclassById(
        stepView.subclassChoice?.subclasses,
        selectedSubclassId,
      ),
      selectedOptions: _restoreSelectedOptions(
        stepView.choiceGroups,
        savedChoices,
      ),
      startingEquipmentSelections: normalizeStartingEquipmentSelections(
        blocks: stepView.startingEquipmentBlocks ??
            const <StartingEquipmentBlockView>[],
        selections: savedEquipmentSelections,
        sourceType: ChoiceSourceType.classData,
        sourceId: classId,
      ),
      selectedLevel: selectedLevel,
    );
  }

  StartingEquipmentOptionView? _selectedStartingEquipmentOption({
    required StartingEquipmentBlockView blockView,
    required List<CharacterStartingEquipmentSelectionData> selections,
  }) {
    final blockKey = normalizedEquipmentKey(blockView.block?.blockKey);
    if (blockKey == null) {
      return null;
    }
    final selection = selections.firstWhere(
      (item) => normalizedEquipmentKey(item.blockKey) == blockKey,
      orElse: () => CharacterStartingEquipmentSelectionData(),
    );
    final optionKey = normalizedEquipmentKey(selection.optionKey);
    if (optionKey == null) {
      return null;
    }
    for (final optionView
        in blockView.options ?? const <StartingEquipmentOptionView>[]) {
      if (normalizedEquipmentKey(optionView.option?.optionKey) == optionKey) {
        return optionView;
      }
    }
    return null;
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
      if (!_isClassChoiceSource(choice.sourceType)) continue;

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

  bool _isClassChoiceSource(ChoiceSourceType? sourceType) {
    switch (sourceType) {
      case ChoiceSourceType.classData:
      case ChoiceSourceType.subclass:
      case ChoiceSourceType.classFeature:
      case ChoiceSourceType.subclassFeature:
        return true;
      case ChoiceSourceType.race:
      case ChoiceSourceType.subrace:
      case ChoiceSourceType.background:
      case null:
        return false;
    }
  }

  CharacterClassEntryData? _resolvePrimaryEntry(
    List<CharacterClassEntryData> entries,
  ) {
    for (final entry in entries) {
      if (entry.isStartingClass == true) {
        return entry;
      }
    }
    if (entries.isEmpty) return null;
    final sorted = [...entries]
      ..sort((a, b) => (a.classOrder ?? 0).compareTo(b.classOrder ?? 0));
    return sorted.first;
  }

  ClassData? _findClassById(List<ClassData> classes, int? id) {
    if (id == null) return null;
    try {
      return classes.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  SubclassData? _findSubclassById(List<SubclassData>? subclasses, int? id) {
    if (id == null) return null;
    try {
      return (subclasses ?? const <SubclassData>[])
          .firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  String _groupKey(ClassChoiceGroupData group) => group.exclusiveKey
              ?.trim()
              .isNotEmpty ==
          true
      ? group.exclusiveKey!
      : 'group_${group.id ?? group.name ?? _safeEnumToken(group.type) ?? 'unknown'}';

  String? _safeEnumToken(Object? value) {
    if (value == null) return null;
    final raw = value.toString();
    if (raw.trim().isEmpty) return null;
    final parts = raw.split('.');
    return parts.isEmpty ? raw : parts.last;
  }
}
