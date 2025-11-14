import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/data/repositories/referense_tables_repositories.dart';
import 'package:characters_mirror_flutter/utils/get_level_by_xp.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'class_state.g.dart';
part 'class_state.freezed.dart';

@freezed
sealed class ClassStateModel with _$ClassStateModel {
  const factory ClassStateModel({
    @Default([]) List<ClassData> allClasses,
    ClassData? selectedClass,
    @Default([]) List<SubclassData> subclasses,
    SubclassData? selectedSubclass,
    @Default([]) List<ClassFeatureData> features,
    @Default([]) List<ClassFeatureData> futureFeatures,
    @Default([]) List<ClassOptionData> classOptions,
    Map<int, ClassOptionData>? selectedOption,
  }) = _ClassStateModel;
}

@riverpod
class ClassState extends _$ClassState {
  @override
  FutureOr<ClassStateModel> build() async {
    final classes = await ClassRepository().getAll();
    classes.sort((a, b) => a.id!.compareTo(b.id!));

    return ClassStateModel(allClasses: classes);
  }

  Future<void> selectClass(ClassData newClass) async {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedClass: newClass,
      ),
    );

    final xp = ref
        .watch(characterCreationProvider.select((c) => c.character.experience));
    final level = getLevelByXp(xp ?? 0);

    final subclasses =
        (await SubclassRepository().getAllByClassId(newClass.id!));

    final features =
        (await ClassFeatureRepository().getAllByClassId(newClass.id!))
            .where((f) => f.level <= level)
            .toList();
    features.sort((a, b) => a.id!.compareTo(b.id!));

    final futureFeatures =
        (await ClassFeatureRepository().getAllByClassId(newClass.id!))
            .where((f) => f.level > level)
            .toList();
    futureFeatures.sort((a, b) => a.id!.compareTo(b.id!));

    final options =
        (await ClassOptionRepository().getAllByClassId(newClass.id!));

    state = AsyncValue.data(
      state.value!.copyWith(
        subclasses: subclasses,
        features: features,
        futureFeatures: futureFeatures,
        classOptions: options,
      ),
    );
  }

  void selectSubclass(SubclassData newSubclass) {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedSubclass: newSubclass,
      ),
    );
  }

  void selectOption(ClassOptionData option, int featureLevel) {
    final current = state.value!.selectedOption ?? {};

    final updated = Map<int, ClassOptionData>.from(current);

    updated[featureLevel] = option;

    state = AsyncValue.data(
      state.value!.copyWith(
        selectedOption: updated,
      ),
    );
  }

  void unselectClassOption(int level) {
    final current = state.value!.selectedOption ?? {};

    final updated = Map<int, ClassOptionData>.from(current);

    updated.remove(level);

    state = AsyncValue.data(
      state.value!.copyWith(
        selectedOption: updated,
      ),
    );
  }

  void unselectSubclass() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedSubclass: null,
      ),
    );
  }

  void unselectClass() {
    state = AsyncValue.data(
      state.value!.copyWith(
        selectedClass: null,
        subclasses: [],
        features: [],
        futureFeatures: [],
        classOptions: [],
      ),
    );
    unselectSubclass();
  }
}
