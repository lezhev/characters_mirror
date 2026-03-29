import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/data/reference_repositories.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'background_state.g.dart';
part 'background_state.freezed.dart';

@freezed
abstract class BackgroundStateModel with _$BackgroundStateModel {
  const factory BackgroundStateModel({
    @Default([]) List<BackgroundData> allBackgrounds,
    BackgroundData? selectedBackground,
  }) = _BackgroundStateModel;
}

@riverpod
class BackgroundState extends _$BackgroundState {
  @override
  FutureOr<BackgroundStateModel> build() async {
    //await Future.delayed(Duration(milliseconds: 100));
    final backgrounds = await BackgroundRepository().getAll();
    backgrounds.sort((a, b) => a.id!.compareTo(b.id!));

    return BackgroundStateModel(allBackgrounds: backgrounds);
  }

  Future<void> selectBackground(BackgroundData newBackground) async {
    state = AsyncValue.data(
      state.value!.copyWith(selectedBackground: newBackground),
    );
  }

  void unselectBackground() {
    state = AsyncValue.data(
      state.value!.copyWith(selectedBackground: null),
    );
  }
}
