import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'race_state.g.dart';
part 'race_state.freezed.dart';

@freezed
abstract class RaceStateModel with _$RaceStateModel {
  const factory RaceStateModel({
    @Default([]) List<RaceData> allRaces,
    RaceData? selectedRace,
    @Default([]) List<SubraceData> subraces,
    SubraceData? selectedSubrace,
    @Default([]) List<RaceFeatureData> features,
    @Default([]) List<RaceFeatureData> futureFeatures,
    @Default([]) List<ChoiceGroupView> choiceGroups,
    @Default({})
    Map<String, List<ChoiceOptionData>> selectedChoiceOptionsByGroup,
  }) = _RaceStateModel;
}

@riverpod
class RaceState extends _$RaceState {
  static const _requestTimeout = Duration(seconds: 10);

  @override
  FutureOr<RaceStateModel> build() async {
    ref.keepAlive();

    final races = await ref
        .watch(raceRepositoryProvider)
        .getAll()
        .timeout(_requestTimeout);
    races.sort(_compareRaces);

    final baseState = RaceStateModel(allRaces: races);
    final characterCreation = ref.read(characterCreationProvider);
    final draftRaceId = characterCreation.character.race?.id;
    if (draftRaceId == null) return baseState;

    final selectedRace = _findRaceById(races, draftRaceId);
    if (selectedRace == null) return baseState;

    return _loadRaceSelection(
      current: baseState,
      race: selectedRace,
      selectedSubraceId: characterCreation.character.subrace?.id,
      savedChoices:
          characterCreation.character.choices ?? const <CharacterChoiceData>[],
    );
  }

  Future<void> selectRace(RaceData newRace) async {
    final current = state.value;
    if (current == null) return;

    state = await AsyncValue.guard(() async {
      return _loadRaceSelection(
        current: current,
        race: newRace,
      );
    });
  }

  void unselectRace() {
    final current = state.value;
    if (current == null) return;

    state = AsyncValue.data(
      current.copyWith(
        selectedRace: null,
        selectedSubrace: null,
        subraces: const [],
        features: const [],
        futureFeatures: const [],
        choiceGroups: const [],
        selectedChoiceOptionsByGroup: const {},
      ),
    );
  }

  void selectSubrace(SubraceData newSubrace) {
    final current = state.value;
    if (current == null) return;

    final activeFeatures = _activeFeatures(
      current.selectedRace,
      newSubrace,
    );
    final activeGroups = _choiceGroupsForFeatures(
      current.choiceGroups,
      _currentFeatures(activeFeatures),
      race: current.selectedRace,
      subrace: newSubrace,
    );

    state = AsyncValue.data(
      current.copyWith(
        selectedSubrace: newSubrace,
        features: _currentFeatures(activeFeatures),
        futureFeatures: _futureFeatures(activeFeatures),
        choiceGroups: activeGroups,
        selectedChoiceOptionsByGroup: _normalizeSelectedChoiceOptions(
          current.selectedChoiceOptionsByGroup,
          activeGroups,
        ),
      ),
    );
  }

  void unselectSubrace() {
    final current = state.value;
    if (current == null) return;

    final activeFeatures = _activeFeatures(current.selectedRace, null);
    final activeGroups = _choiceGroupsForFeatures(
      current.choiceGroups,
      _currentFeatures(activeFeatures),
      race: current.selectedRace,
    );

    state = AsyncValue.data(
      current.copyWith(
        selectedSubrace: null,
        features: _currentFeatures(activeFeatures),
        futureFeatures: _futureFeatures(activeFeatures),
        choiceGroups: activeGroups,
        selectedChoiceOptionsByGroup: _normalizeSelectedChoiceOptions(
          current.selectedChoiceOptionsByGroup,
          activeGroups,
        ),
      ),
    );
  }

  void toggleChoiceOption(ChoiceGroupData group, ChoiceOptionData option) {
    final current = state.value;
    final groupKey = group.referenceKey;
    if (current == null || groupKey.isEmpty) return;

    final selectedByGroup = Map<String, List<ChoiceOptionData>>.from(
        current.selectedChoiceOptionsByGroup);
    final selected = [...?selectedByGroup[groupKey]];
    final optionKey = option.optionKey.trim();
    if (optionKey.isEmpty) return;

    final existingIndex = selected.indexWhere(
      (item) => item.optionKey == optionKey,
    );

    if (existingIndex != -1) {
      selected.removeAt(existingIndex);
    } else {
      final pickCount = group.selectionCount ?? 1;
      if (pickCount <= 1) {
        selected
          ..clear()
          ..add(option);
      } else if (selected.length < pickCount) {
        selected.add(option);
      } else {
        return;
      }
    }

    if (selected.isEmpty) {
      selectedByGroup.remove(groupKey);
    } else {
      selectedByGroup[groupKey] = selected;
    }

    state = AsyncValue.data(
      current.copyWith(
        selectedChoiceOptionsByGroup: _normalizeSelectedChoiceOptions(
          selectedByGroup,
          current.choiceGroups,
        ),
      ),
    );
  }

  List<CharacterChoiceData> buildRaceChoices() {
    final current = state.value;
    if (current == null) return const [];

    final result = <CharacterChoiceData>[];

    for (final groupView in current.choiceGroups) {
      final group = groupView.group;
      if (group == null) continue;
      final selectedOptions = current.selectedChoiceOptionsByGroup[group.referenceKey] ??
          const <ChoiceOptionData>[];
      for (var index = 0; index < selectedOptions.length; index++) {
        result.add(CharacterChoiceData(
          groupKey: group.referenceKey,
          optionKey: selectedOptions[index].optionKey,
          selectionIndex: index,
        ));
      }
    }

    return result;
  }

  Future<RaceStateModel> _loadRaceSelection({
    required RaceStateModel current,
    required RaceData race,
    int? selectedSubraceId,
    List<CharacterChoiceData> savedChoices = const [],
  }) async {
    final raceId = race.id;
    if (raceId == null) {
      return current.copyWith(
        selectedRace: race,
        selectedSubrace: null,
        subraces: const [],
        features: _currentFeatures(_activeFeatures(race, null)),
        futureFeatures: _futureFeatures(_activeFeatures(race, null)),
        choiceGroups: const <ChoiceGroupView>[],
        selectedChoiceOptionsByGroup: const {},
      );
    }

    final stepView = await ref
        .read(raceRepositoryProvider)
        .getStepView(raceId)
        .timeout(_requestTimeout);
    final resolvedRace = _normalizedRace(stepView.race ?? race);
    final resolvedSubraces = [...?stepView.subraces]
        .map(_normalizedSubrace)
        .toList()
      ..sort(_compareSubraces);
    final selectedSubrace =
        _findSubraceById(resolvedSubraces, selectedSubraceId);
    final activeFeatures = _activeFeatures(resolvedRace, selectedSubrace);
    final activeGroups = _choiceGroupsForFeatures(
      stepView.choiceGroups ?? const <ChoiceGroupView>[],
      _currentFeatures(activeFeatures),
      race: resolvedRace,
      subrace: selectedSubrace,
    );

    return current.copyWith(
      selectedRace: resolvedRace,
      selectedSubrace: selectedSubrace,
      subraces: resolvedSubraces,
      features: _currentFeatures(activeFeatures),
      futureFeatures: _futureFeatures(activeFeatures),
      choiceGroups: activeGroups,
      selectedChoiceOptionsByGroup: _restoreSelectedChoiceOptions(
        activeGroups,
        savedChoices,
      ),
    );
  }

  Map<String, List<ChoiceOptionData>> _restoreSelectedChoiceOptions(
    List<ChoiceGroupView> groups,
    List<CharacterChoiceData> savedChoices,
  ) {
    final optionsByGroupKey = _availableOptionsByGroup(groups);
    final restored = <String, List<ChoiceOptionData>>{};

    for (final choice in savedChoices) {
      final groupKey = choice.groupKey;
      final optionKey = choice.optionKey?.trim();
      if (groupKey == null || optionKey == null || optionKey.isEmpty) continue;

      final option = optionsByGroupKey[groupKey]?[optionKey];
      if (option == null) continue;

      restored.putIfAbsent(groupKey, () => <ChoiceOptionData>[]);
      final alreadySelected = restored[groupKey]!.any(
        (item) => item.optionKey == optionKey,
      );
      if (!alreadySelected) {
        restored[groupKey]!.add(option);
      }
    }

    return _normalizeSelectedChoiceOptions(restored, groups);
  }

  Map<String, List<ChoiceOptionData>> _normalizeSelectedChoiceOptions(
    Map<String, List<ChoiceOptionData>> selections,
    List<ChoiceGroupView> groups,
  ) {
    final availableOptions = _availableOptionsByGroup(groups);
    final choiceGroups = {
      for (final view in groups)
        if (view.group != null) view.group!.referenceKey: view.group!,
    };
    final normalized = <String, List<ChoiceOptionData>>{};

    for (final entry in selections.entries) {
      final group = choiceGroups[entry.key];
      if (group == null) continue;

      final pickCount = group.selectionCount ?? 1;
      final canonicalOptions = availableOptions[entry.key] ?? const {};
      final selected = <ChoiceOptionData>[];

      for (final option in entry.value) {
        final optionKey = option.optionKey.trim();
        if (optionKey.isEmpty) continue;

        final canonical = canonicalOptions[optionKey];
        if (canonical == null) continue;

        if (group.allowDuplicates != true &&
            selected.any((item) => item.optionKey == optionKey)) {
          continue;
        }

        selected.add(canonical);
        if (selected.length >= pickCount) break;
      }

      if (selected.isNotEmpty) {
        normalized[entry.key] = selected;
      }
    }

    return normalized;
  }

  Map<String, Map<String, ChoiceOptionData>> _availableOptionsByGroup(
    List<ChoiceGroupView> groups,
  ) {
    final result = <String, Map<String, ChoiceOptionData>>{};

    for (final groupView in groups) {
      final key = groupView.group?.referenceKey;
      if (key == null || key.isEmpty) continue;
      result[key] = {
        for (final option in groupView.options ?? const <ChoiceOptionData>[])
          option.optionKey: option,
      };
    }

    return result;
  }

  List<ChoiceGroupView> _choiceGroupsForFeatures(
    List<ChoiceGroupView> groups,
    List<RaceFeatureData> features,
    {RaceData? race, SubraceData? subrace}
  ) {
    final featureIds = {
      for (final feature in features)
        if (feature.id != null) feature.id!,
    };
    return [
      for (final group in groups)
        if (group.group?.sourceRaceId == race?.id ||
            group.group?.sourceSubraceId == subrace?.id ||
            (group.group?.sourceRaceFeatureId != null &&
                featureIds.contains(group.group!.sourceRaceFeatureId)))
          group,
    ];
  }

  List<RaceFeatureData> _activeFeatures(RaceData? race, SubraceData? subrace) {
    final result = <RaceFeatureData>[
      ...?race?.features,
      ...?subrace?.features,
    ];
    result.sort(_compareFeatures);
    return result;
  }

  List<RaceFeatureData> _currentFeatures(List<RaceFeatureData> features) {
    return features.where((feature) => (feature.level ?? 1) <= 1).toList()
      ..sort(_compareFeatures);
  }

  List<RaceFeatureData> _futureFeatures(List<RaceFeatureData> features) {
    return features.where((feature) => (feature.level ?? 1) > 1).toList()
      ..sort(_compareFeatures);
  }

  RaceData? _findRaceById(List<RaceData> races, int? id) {
    if (id == null) return null;
    try {
      return races.firstWhere((race) => race.id == id);
    } catch (_) {
      return null;
    }
  }

  SubraceData? _findSubraceById(List<SubraceData> subraces, int? id) {
    if (id == null) return null;
    try {
      return subraces.firstWhere((subrace) => subrace.id == id);
    } catch (_) {
      return null;
    }
  }

  RaceData _normalizedRace(RaceData race) {
    final features = [...?race.features]..sort(_compareFeatures);
    return race.copyWith(features: features);
  }

  SubraceData _normalizedSubrace(SubraceData subrace) {
    final features = [...?subrace.features]..sort(_compareFeatures);
    return subrace.copyWith(features: features);
  }

  int _compareRaces(RaceData a, RaceData b) =>
      (a.name ?? '').compareTo(b.name ?? '');

  int _compareSubraces(SubraceData a, SubraceData b) =>
      (a.name ?? '').compareTo(b.name ?? '');

  int _compareFeatures(RaceFeatureData a, RaceFeatureData b) {
    final levelCompare = (a.level ?? 1).compareTo(b.level ?? 1);
    if (levelCompare != 0) return levelCompare;
    return (a.name ?? '').compareTo(b.name ?? '');
  }

}
