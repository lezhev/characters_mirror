import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/data/repositories/race_repository.dart';

class RaceViewModel extends AutoDisposeNotifier<RaceViewState> {
  late final _repo = ref.read(raceRepositoryProvider);

  @override
  RaceViewState build() => RaceViewState.initial();

  Future<void> loadRaces() async {
    state = state.copyWith(isLoading: true);
    try {
      final races = await _repo.getAll();
      state = state.copyWith(races: races, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void startEditing(RaceData race) {
    state = state.copyWith(editingRace: race);
  }

  void cancelEditing() {
    state = state.copyWith(editingRace: null);
  }

  Future<void> saveRace({
    required String name,
    String? description,
    String? source,
    int? speed,
    String? size,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? languages,
  }) async {
    final race = state.editingRace;
    final data = (race == null)
        ? RaceData(
            name: name,
            description: description,
            source: source,
            speed: speed,
            size: size,
            abilityBonuses: abilityBonuses,
            traits: traits,
            languages: languages,
          )
        : race.copyWith(
            name: name,
            description: description,
            source: source,
            speed: speed,
            size: size,
            abilityBonuses: abilityBonuses,
            traits: traits,
            languages: languages,
          );

    try {
      if (race == null) {
        await _repo.add(data);
      } else {
        await _repo.update(data);
      }
      await loadRaces();
      cancelEditing();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> deleteRace(int id) async {
    try {
      await _repo.delete(id);
      await loadRaces();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

class RaceViewState {
  final List<RaceData> races;
  final RaceData? editingRace;
  final bool isLoading;
  final String? error;

  RaceViewState({
    required this.races,
    this.editingRace,
    required this.isLoading,
    this.error,
  });

  factory RaceViewState.initial() => RaceViewState(races: [], isLoading: false);

  RaceViewState copyWith({
    List<RaceData>? races,
    RaceData? editingRace,
    bool? isLoading,
    String? error,
  }) =>
      RaceViewState(
        races: races ?? this.races,
        editingRace: editingRace,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}

final raceViewModelProvider =
    AutoDisposeNotifierProvider<RaceViewModel, RaceViewState>(
        RaceViewModel.new);
