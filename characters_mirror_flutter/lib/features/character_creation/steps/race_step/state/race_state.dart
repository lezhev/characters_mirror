import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/data/reference_repositories.dart';
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
    @Default({})
    Map<String, List<RaceChoiceOptionData>> selectedChoiceOptionsByGroup,
  }) = _RaceStateModel;
}

@riverpod
class RaceState extends _$RaceState {
  static const _requestTimeout = Duration(seconds: 10);

  @override
  FutureOr<RaceStateModel> build() async {
    final races = await RaceRepository().getAll().timeout(_requestTimeout);
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

    state = AsyncValue.data(
      current.copyWith(
        selectedSubrace: newSubrace,
        features: _currentFeatures(activeFeatures),
        futureFeatures: _futureFeatures(activeFeatures),
        selectedChoiceOptionsByGroup: _normalizeSelectedChoiceOptions(
          current.selectedChoiceOptionsByGroup,
          activeFeatures,
        ),
      ),
    );
  }

  void unselectSubrace() {
    final current = state.value;
    if (current == null) return;

    final activeFeatures = _activeFeatures(current.selectedRace, null);

    state = AsyncValue.data(
      current.copyWith(
        selectedSubrace: null,
        features: _currentFeatures(activeFeatures),
        futureFeatures: _futureFeatures(activeFeatures),
        selectedChoiceOptionsByGroup: _normalizeSelectedChoiceOptions(
          current.selectedChoiceOptionsByGroup,
          activeFeatures,
        ),
      ),
    );
  }

  void toggleChoiceOption(
      RaceChoiceSetData choiceSet, RaceChoiceOptionData option) {
    if (choiceSet.kind == RaceChoiceKind.abilityBonusChoice) return;

    final current = state.value;
    final groupKey = _choiceSetGroupKey(choiceSet.id);
    if (current == null || groupKey == null) return;

    final selectedByGroup = Map<String, List<RaceChoiceOptionData>>.from(
        current.selectedChoiceOptionsByGroup);
    final selected = [...?selectedByGroup[groupKey]];
    final optionKey = option.optionKey?.trim();
    if (optionKey == null || optionKey.isEmpty) return;

    final existingIndex = selected.indexWhere(
      (item) => item.optionKey?.trim() == optionKey,
    );

    if (existingIndex != -1) {
      selected.removeAt(existingIndex);
    } else {
      final pickCount = choiceSet.pickCount ?? 1;
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
          _activeFeatures(current.selectedRace, current.selectedSubrace),
        ),
      ),
    );
  }

  List<CharacterChoiceData> buildRaceChoices() {
    final current = state.value;
    if (current == null) return const [];

    final result = <CharacterChoiceData>[];

    for (final feature
        in _activeFeatures(current.selectedRace, current.selectedSubrace)) {
      final sourceType = feature.subraceId != null
          ? ChoiceSourceType.subrace
          : ChoiceSourceType.race;
      final sourceId = feature.subraceId ?? feature.raceId;
      if (sourceId == null) continue;

      for (final choiceSet
          in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        if (choiceSet.kind == RaceChoiceKind.abilityBonusChoice) continue;
        final groupKey = _choiceSetGroupKey(choiceSet.id);
        if (groupKey == null) continue;

        final selectedOptions =
            current.selectedChoiceOptionsByGroup[groupKey] ??
                const <RaceChoiceOptionData>[];
        for (final option in selectedOptions) {
          result.add(
            CharacterChoiceData(
              sourceType: sourceType,
              sourceId: sourceId,
              groupKey: groupKey,
              optionKey: option.optionKey,
              selectedText: _choiceOptionLabel(option),
              selectedSpellKey: option.spell?.name,
            ),
          );
        }
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
        selectedChoiceOptionsByGroup: const {},
      );
    }

    final stepView =
        await RaceRepository().getStepView(raceId).timeout(_requestTimeout);
    final resolvedRace = _normalizedRace(stepView.race ?? race);
    final resolvedSubraces = [...?stepView.subraces]
        .map(_normalizedSubrace)
        .toList()
      ..sort(_compareSubraces);
    final selectedSubrace =
        _findSubraceById(resolvedSubraces, selectedSubraceId);
    final activeFeatures = _activeFeatures(resolvedRace, selectedSubrace);

    return current.copyWith(
      selectedRace: resolvedRace,
      selectedSubrace: selectedSubrace,
      subraces: resolvedSubraces,
      features: _currentFeatures(activeFeatures),
      futureFeatures: _futureFeatures(activeFeatures),
      selectedChoiceOptionsByGroup: _restoreSelectedChoiceOptions(
        activeFeatures,
        savedChoices,
      ),
    );
  }

  Map<String, List<RaceChoiceOptionData>> _restoreSelectedChoiceOptions(
    List<RaceFeatureData> features,
    List<CharacterChoiceData> savedChoices,
  ) {
    final optionsByGroupKey = _availableOptionsByGroup(features);
    final restored = <String, List<RaceChoiceOptionData>>{};

    for (final choice in savedChoices) {
      if (choice.sourceType != ChoiceSourceType.race &&
          choice.sourceType != ChoiceSourceType.subrace) {
        continue;
      }

      final groupKey = choice.groupKey;
      final optionKey = choice.optionKey?.trim();
      if (groupKey == null || optionKey == null || optionKey.isEmpty) continue;

      final option = optionsByGroupKey[groupKey]?[optionKey];
      if (option == null) continue;

      restored.putIfAbsent(groupKey, () => <RaceChoiceOptionData>[]);
      final alreadySelected = restored[groupKey]!.any(
        (item) => item.optionKey?.trim() == optionKey,
      );
      if (!alreadySelected) {
        restored[groupKey]!.add(option);
      }
    }

    return _normalizeSelectedChoiceOptions(restored, features);
  }

  Map<String, List<RaceChoiceOptionData>> _normalizeSelectedChoiceOptions(
    Map<String, List<RaceChoiceOptionData>> selections,
    List<RaceFeatureData> features,
  ) {
    final availableOptions = _availableOptionsByGroup(features);
    final choiceSetsByGroup = _choiceSetsByGroup(features);
    final normalized = <String, List<RaceChoiceOptionData>>{};

    for (final entry in selections.entries) {
      final choiceSet = choiceSetsByGroup[entry.key];
      if (choiceSet == null) continue;

      final pickCount = choiceSet.pickCount ?? 1;
      final canonicalOptions = availableOptions[entry.key] ?? const {};
      final selected = <RaceChoiceOptionData>[];

      for (final option in entry.value) {
        final optionKey = option.optionKey?.trim();
        if (optionKey == null || optionKey.isEmpty) continue;

        final canonical = canonicalOptions[optionKey];
        if (canonical == null) continue;

        final alreadySelected = selected.any(
          (item) => item.optionKey?.trim() == optionKey,
        );
        if (alreadySelected) continue;

        selected.add(canonical);
        if (selected.length >= pickCount) break;
      }

      if (selected.isNotEmpty) {
        normalized[entry.key] = selected;
      }
    }

    return normalized;
  }

  Map<String, Map<String, RaceChoiceOptionData>> _availableOptionsByGroup(
    List<RaceFeatureData> features,
  ) {
    final result = <String, Map<String, RaceChoiceOptionData>>{};

    for (final feature in features) {
      for (final choiceSet
          in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        if (choiceSet.kind == RaceChoiceKind.abilityBonusChoice) continue;
        final groupKey = _choiceSetGroupKey(choiceSet.id);
        if (groupKey == null) continue;

        result[groupKey] = {
          for (final option
              in choiceSet.choiceOptions ?? const <RaceChoiceOptionData>[])
            if (option.optionKey?.trim().isNotEmpty == true)
              option.optionKey!.trim(): option,
        };
      }
    }

    return result;
  }

  Map<String, RaceChoiceSetData> _choiceSetsByGroup(
      List<RaceFeatureData> features) {
    final result = <String, RaceChoiceSetData>{};

    for (final feature in features) {
      for (final choiceSet
          in feature.choiceSets ?? const <RaceChoiceSetData>[]) {
        if (choiceSet.kind == RaceChoiceKind.abilityBonusChoice) continue;
        final groupKey = _choiceSetGroupKey(choiceSet.id);
        if (groupKey != null) {
          result[groupKey] = choiceSet;
        }
      }
    }

    return result;
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

  String? _choiceSetGroupKey(int? choiceSetId) {
    if (choiceSetId == null) return null;
    return 'race_choice_$choiceSetId';
  }

  String _choiceOptionLabel(RaceChoiceOptionData option) {
    return option.name ??
        option.spell?.name ??
        option.optionKey ??
        option.toolKey ??
        'Выбор';
  }
}
