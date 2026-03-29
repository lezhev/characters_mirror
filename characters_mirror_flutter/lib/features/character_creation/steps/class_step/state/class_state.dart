import 'dart:async';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/data/reference_repositories.dart';
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
    @Default({}) Map<String, ClassChoiceOptionData> selectedOptions,
    @Default(1) int selectedLevel,
  }) = _ClassStateModel;
}

@riverpod
class ClassState extends _$ClassState {
  static const _requestTimeout = Duration(seconds: 10);

  @override
  FutureOr<ClassStateModel> build() async {
    final classes = await ClassRepository().getAll().timeout(_requestTimeout);
    classes.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    return ClassStateModel(
      allClasses: classes,
      selectedLevel: 1,
    );
  }

  Future<void> selectClass(ClassData newClass) async {
    final current = state.value;
    if (current == null) return;

    state = await AsyncValue.guard(() async {
      final stepView = await ClassRepository()
          .getStepView(
            newClass.id!,
            selectedLevel: 1,
            isStartingClass: true,
          )
          .timeout(_requestTimeout);

      return current.copyWith(
        selectedClass: newClass,
        stepView: stepView,
        selectedSubclass: null,
        selectedOptions: {},
        selectedLevel: 1,
      );
    });
  }

  void selectSubclass(SubclassData newSubclass) {
    state = AsyncValue.data(
      state.value!.copyWith(selectedSubclass: newSubclass),
    );
  }

  void unselectSubclass() {
    state = AsyncValue.data(
      state.value!.copyWith(selectedSubclass: null),
    );
  }

  void selectOption(ClassChoiceGroupData group, ClassChoiceOptionData option) {
    final current = Map<String, ClassChoiceOptionData>.from(
      state.value!.selectedOptions,
    );
    current[_groupKey(group)] = option;

    state = AsyncValue.data(
      state.value!.copyWith(selectedOptions: current),
    );
  }

  void unselectOption(ClassChoiceGroupData group) {
    final current = Map<String, ClassChoiceOptionData>.from(
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
        selectedLevel: 1,
      ),
    );
  }

  String _groupKey(ClassChoiceGroupData group) =>
      group.exclusiveKey?.trim().isNotEmpty == true
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
