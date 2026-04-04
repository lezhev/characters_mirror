import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
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
  }) = _BackgroundStateModel;
}

@riverpod
class BackgroundState extends _$BackgroundState {
  @override
  FutureOr<BackgroundStateModel> build() async {
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

  void incrementOption(ClassChoiceGroupData group, ClassChoiceOptionData option) {
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

  void decrementOption(ClassChoiceGroupData group, ClassChoiceOptionData option) {
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

  Future<BackgroundStateModel> _loadBackgroundSelection({
    required BackgroundStateModel current,
    required BackgroundData background,
    List<CharacterChoiceData> savedChoices = const [],
  }) async {
    final backgroundId = background.id;
    if (backgroundId == null) {
      return current.copyWith(
        selectedBackground: background,
        stepView: null,
        selectedOptions: const {},
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
    );
  }

  Map<String, List<ClassChoiceOptionData>> _restoreSelectedOptions(
    List<ClassChoiceGroupView>? groups,
    List<CharacterChoiceData> savedChoices,
  ) {
    final optionsByGroupKey = _availableOptionsByGroup(groups);
    final restored = <String, List<ClassChoiceOptionData>>{};
    final sortedChoices = [...savedChoices]
      ..sort((a, b) => (a.selectionIndex ?? 0).compareTo(b.selectionIndex ?? 0));

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

  Map<String, List<ClassChoiceOptionData>> _normalizeSelectedOptions(
    Map<String, List<ClassChoiceOptionData>> selections,
    List<ClassChoiceGroupView>? groups,
  ) {
    final choiceGroups = {
      for (final groupView in groups ?? const <ClassChoiceGroupView>[])
        if (groupView.group != null) _groupKey(groupView.group!): groupView.group!,
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
        for (final option in groupView.options ?? const <ClassChoiceOptionData>[])
          if (option.optionKey?.trim().isNotEmpty == true)
            option.optionKey!.trim(): option,
      };
    }

    return result;
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
