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
    //await Future.delayed(Duration(milliseconds: 100));
    final races = await RaceRepository().getAll();
    races.sort((a, b) => a.id!.compareTo(b.id!));

    return RaceStateModel(allRaces: races);
  }

  Future<void> selectRace(RaceData newRace) async {
    final subrases = (await SubraceRepository().getAllByRaceId(newRace.id!));

    state = AsyncValue.data(
      state.value!.copyWith(selectedRace: newRace, subraces: subrases),
    );
  }

  void unselectRace() {
    state = AsyncValue.data(
      state.value!.copyWith(selectedRace: null, subraces: []),
    );
  }

  void selectSubrace(SubraceData newSubrace) {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedSubrace: newSubrace,
      ),
    );
  }

  void unselectSubrace() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedSubrace: null,
      ),
    );
  }
}
