import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/data/repositories/referense_tables_repositories.dart';
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
    @Default({}) Map<int, List<RaceFeatureData>> subclassFeatures,
  }) = _RaceStateModel;
}

@riverpod
class RaceState extends _$RaceState {
  @override
  FutureOr<RaceStateModel> build() async {
    final races = await RaceRepository().getAll();
    races.sort((a, b) => a.id!.compareTo(b.id!));

    return RaceStateModel(allRaces: races);
  }

  Future<void> selectRace(RaceData newRace) async {
    final subraces = await SubraceRepository().getAllByRaceId(newRace.id!);
    final subraceIds = subraces
        .map((subrace) => subrace.id)
        .whereType<int>()
        .toList();
    final allFeatures = await RaceFeatureRepository().getAllByRaceContext(
      newRace.id!,
      subraceIds: subraceIds,
    );
    final baseFeatures = allFeatures
        .where((feature) => feature.raceId == newRace.id)
        .toList()
      ..sort(_compareFeatures);
    final subraceFeatures = <int, List<RaceFeatureData>>{};

    for (final subrace in subraces) {
      if (subrace.id == null) continue;
      subraceFeatures[subrace.id!] = allFeatures
          .where((feature) => feature.subraceId == subrace.id)
          .toList()
        ..sort(_compareFeatures);
    }

    state = AsyncValue.data(
      state.value!.copyWith(
        selectedRace: newRace,
        selectedSubrace: null,
        subraces: subraces,
        features: _currentFeatures(baseFeatures),
        futureFeatures: _futureFeatures(baseFeatures),
        subclassFeatures: subraceFeatures,
      ),
    );
  }

  void unselectRace() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedRace: null,
        selectedSubrace: null,
        subraces: [],
        features: [],
        futureFeatures: [],
        subclassFeatures: {},
      ),
    );
  }

  void selectSubrace(SubraceData newSubrace) {
    final current = state.value!;
    final selectedFeatures = current.subclassFeatures[newSubrace.id] ?? const [];
    final baseFeatures = _baseRaceFeatures(current);

    state = AsyncValue.data(
      current.copyWith(
        selectedSubrace: newSubrace,
        features: _currentFeatures([...baseFeatures, ...selectedFeatures]),
        futureFeatures: _futureFeatures([...baseFeatures, ...selectedFeatures]),
      ),
    );
  }

  void unselectSubrace() {
    final current = state.value!;
    final baseFeatures = _baseRaceFeatures(current);

    state = AsyncValue.data(
      current.copyWith(
        selectedSubrace: null,
        features: _currentFeatures(baseFeatures),
        futureFeatures: _futureFeatures(baseFeatures),
      ),
    );
  }

  List<RaceFeatureData> _baseRaceFeatures(RaceStateModel current) {
    final selectedRaceId = current.selectedRace?.id;
    if (selectedRaceId == null) return const [];

    final loaded = [
      ...current.features,
      ...current.futureFeatures,
      ...current.subclassFeatures.values.expand((items) => items),
    ];

    final baseFeatures = loaded
        .where((feature) => feature.raceId == selectedRaceId)
        .toList()
      ..sort(_compareFeatures);

    return baseFeatures;
  }

  List<RaceFeatureData> _currentFeatures(List<RaceFeatureData> features) {
    return features.where((feature) => (feature.level ?? 1) <= 1).toList()
      ..sort(_compareFeatures);
  }

  List<RaceFeatureData> _futureFeatures(List<RaceFeatureData> features) {
    return features.where((feature) => (feature.level ?? 1) > 1).toList()
      ..sort(_compareFeatures);
  }

  int _compareFeatures(RaceFeatureData a, RaceFeatureData b) {
    final levelCompare = (a.level ?? 1).compareTo(b.level ?? 1);
    if (levelCompare != 0) return levelCompare;
    return (a.name ?? '').compareTo(b.name ?? '');
  }
}
