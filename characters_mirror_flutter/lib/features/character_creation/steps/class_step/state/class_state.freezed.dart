// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'class_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ClassStateModel {
  List<ClassData> get allClasses;
  ClassData? get selectedClass;
  ClassStepView? get stepView;
  SubclassData? get selectedSubclass;
  Map<String, List<ClassChoiceOptionData>> get selectedOptions;
  List<CharacterSpellSelectionData> get selectedSpellSelections;
  List<CharacterStartingEquipmentSelectionData> get startingEquipmentSelections;
  int get selectedLevel;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClassStateModelCopyWith<ClassStateModel> get copyWith =>
      _$ClassStateModelCopyWithImpl<ClassStateModel>(
          this as ClassStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClassStateModel &&
            const DeepCollectionEquality()
                .equals(other.allClasses, allClasses) &&
            (identical(other.selectedClass, selectedClass) ||
                other.selectedClass == selectedClass) &&
            (identical(other.stepView, stepView) ||
                other.stepView == stepView) &&
            (identical(other.selectedSubclass, selectedSubclass) ||
                other.selectedSubclass == selectedSubclass) &&
            const DeepCollectionEquality()
                .equals(other.selectedOptions, selectedOptions) &&
            const DeepCollectionEquality().equals(
                other.selectedSpellSelections, selectedSpellSelections) &&
            const DeepCollectionEquality().equals(
                other.startingEquipmentSelections,
                startingEquipmentSelections) &&
            (identical(other.selectedLevel, selectedLevel) ||
                other.selectedLevel == selectedLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(allClasses),
      selectedClass,
      stepView,
      selectedSubclass,
      const DeepCollectionEquality().hash(selectedOptions),
      const DeepCollectionEquality().hash(selectedSpellSelections),
      const DeepCollectionEquality().hash(startingEquipmentSelections),
      selectedLevel);

  @override
  String toString() {
    return 'ClassStateModel(allClasses: $allClasses, selectedClass: $selectedClass, stepView: $stepView, selectedSubclass: $selectedSubclass, selectedOptions: $selectedOptions, selectedSpellSelections: $selectedSpellSelections, startingEquipmentSelections: $startingEquipmentSelections, selectedLevel: $selectedLevel)';
  }
}

/// @nodoc
abstract mixin class $ClassStateModelCopyWith<$Res> {
  factory $ClassStateModelCopyWith(
          ClassStateModel value, $Res Function(ClassStateModel) _then) =
      _$ClassStateModelCopyWithImpl;
  @useResult
  $Res call(
      {List<ClassData> allClasses,
      ClassData? selectedClass,
      ClassStepView? stepView,
      SubclassData? selectedSubclass,
      Map<String, List<ClassChoiceOptionData>> selectedOptions,
      List<CharacterSpellSelectionData> selectedSpellSelections,
      List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections,
      int selectedLevel});
}

/// @nodoc
class _$ClassStateModelCopyWithImpl<$Res>
    implements $ClassStateModelCopyWith<$Res> {
  _$ClassStateModelCopyWithImpl(this._self, this._then);

  final ClassStateModel _self;
  final $Res Function(ClassStateModel) _then;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allClasses = null,
    Object? selectedClass = freezed,
    Object? stepView = freezed,
    Object? selectedSubclass = freezed,
    Object? selectedOptions = null,
    Object? selectedSpellSelections = null,
    Object? startingEquipmentSelections = null,
    Object? selectedLevel = null,
  }) {
    return _then(_self.copyWith(
      allClasses: null == allClasses
          ? _self.allClasses
          : allClasses // ignore: cast_nullable_to_non_nullable
              as List<ClassData>,
      selectedClass: freezed == selectedClass
          ? _self.selectedClass
          : selectedClass // ignore: cast_nullable_to_non_nullable
              as ClassData?,
      stepView: freezed == stepView
          ? _self.stepView
          : stepView // ignore: cast_nullable_to_non_nullable
              as ClassStepView?,
      selectedSubclass: freezed == selectedSubclass
          ? _self.selectedSubclass
          : selectedSubclass // ignore: cast_nullable_to_non_nullable
              as SubclassData?,
      selectedOptions: null == selectedOptions
          ? _self.selectedOptions
          : selectedOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<ClassChoiceOptionData>>,
      selectedSpellSelections: null == selectedSpellSelections
          ? _self.selectedSpellSelections
          : selectedSpellSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterSpellSelectionData>,
      startingEquipmentSelections: null == startingEquipmentSelections
          ? _self.startingEquipmentSelections
          : startingEquipmentSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterStartingEquipmentSelectionData>,
      selectedLevel: null == selectedLevel
          ? _self.selectedLevel
          : selectedLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [ClassStateModel].
extension ClassStateModelPatterns on ClassStateModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ClassStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ClassStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ClassStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<ClassData> allClasses,
            ClassData? selectedClass,
            ClassStepView? stepView,
            SubclassData? selectedSubclass,
            Map<String, List<ClassChoiceOptionData>> selectedOptions,
            List<CharacterSpellSelectionData> selectedSpellSelections,
            List<CharacterStartingEquipmentSelectionData>
                startingEquipmentSelections,
            int selectedLevel)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(
            _that.allClasses,
            _that.selectedClass,
            _that.stepView,
            _that.selectedSubclass,
            _that.selectedOptions,
            _that.selectedSpellSelections,
            _that.startingEquipmentSelections,
            _that.selectedLevel);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<ClassData> allClasses,
            ClassData? selectedClass,
            ClassStepView? stepView,
            SubclassData? selectedSubclass,
            Map<String, List<ClassChoiceOptionData>> selectedOptions,
            List<CharacterSpellSelectionData> selectedSpellSelections,
            List<CharacterStartingEquipmentSelectionData>
                startingEquipmentSelections,
            int selectedLevel)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel():
        return $default(
            _that.allClasses,
            _that.selectedClass,
            _that.stepView,
            _that.selectedSubclass,
            _that.selectedOptions,
            _that.selectedSpellSelections,
            _that.startingEquipmentSelections,
            _that.selectedLevel);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<ClassData> allClasses,
            ClassData? selectedClass,
            ClassStepView? stepView,
            SubclassData? selectedSubclass,
            Map<String, List<ClassChoiceOptionData>> selectedOptions,
            List<CharacterSpellSelectionData> selectedSpellSelections,
            List<CharacterStartingEquipmentSelectionData>
                startingEquipmentSelections,
            int selectedLevel)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ClassStateModel() when $default != null:
        return $default(
            _that.allClasses,
            _that.selectedClass,
            _that.stepView,
            _that.selectedSubclass,
            _that.selectedOptions,
            _that.selectedSpellSelections,
            _that.startingEquipmentSelections,
            _that.selectedLevel);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _ClassStateModel implements ClassStateModel {
  const _ClassStateModel(
      {final List<ClassData> allClasses = const [],
      this.selectedClass,
      this.stepView,
      this.selectedSubclass,
      final Map<String, List<ClassChoiceOptionData>> selectedOptions = const {},
      final List<CharacterSpellSelectionData> selectedSpellSelections =
          const [],
      final List<CharacterStartingEquipmentSelectionData>
          startingEquipmentSelections = const [],
      this.selectedLevel = 1})
      : _allClasses = allClasses,
        _selectedOptions = selectedOptions,
        _selectedSpellSelections = selectedSpellSelections,
        _startingEquipmentSelections = startingEquipmentSelections;

  final List<ClassData> _allClasses;
  @override
  @JsonKey()
  List<ClassData> get allClasses {
    if (_allClasses is EqualUnmodifiableListView) return _allClasses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allClasses);
  }

  @override
  final ClassData? selectedClass;
  @override
  final ClassStepView? stepView;
  @override
  final SubclassData? selectedSubclass;
  final Map<String, List<ClassChoiceOptionData>> _selectedOptions;
  @override
  @JsonKey()
  Map<String, List<ClassChoiceOptionData>> get selectedOptions {
    if (_selectedOptions is EqualUnmodifiableMapView) return _selectedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedOptions);
  }

  final List<CharacterSpellSelectionData> _selectedSpellSelections;
  @override
  @JsonKey()
  List<CharacterSpellSelectionData> get selectedSpellSelections {
    if (_selectedSpellSelections is EqualUnmodifiableListView)
      return _selectedSpellSelections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSpellSelections);
  }

  final List<CharacterStartingEquipmentSelectionData>
      _startingEquipmentSelections;
  @override
  @JsonKey()
  List<CharacterStartingEquipmentSelectionData>
      get startingEquipmentSelections {
    if (_startingEquipmentSelections is EqualUnmodifiableListView)
      return _startingEquipmentSelections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_startingEquipmentSelections);
  }

  @override
  @JsonKey()
  final int selectedLevel;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClassStateModelCopyWith<_ClassStateModel> get copyWith =>
      __$ClassStateModelCopyWithImpl<_ClassStateModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClassStateModel &&
            const DeepCollectionEquality()
                .equals(other._allClasses, _allClasses) &&
            (identical(other.selectedClass, selectedClass) ||
                other.selectedClass == selectedClass) &&
            (identical(other.stepView, stepView) ||
                other.stepView == stepView) &&
            (identical(other.selectedSubclass, selectedSubclass) ||
                other.selectedSubclass == selectedSubclass) &&
            const DeepCollectionEquality()
                .equals(other._selectedOptions, _selectedOptions) &&
            const DeepCollectionEquality().equals(
                other._selectedSpellSelections, _selectedSpellSelections) &&
            const DeepCollectionEquality().equals(
                other._startingEquipmentSelections,
                _startingEquipmentSelections) &&
            (identical(other.selectedLevel, selectedLevel) ||
                other.selectedLevel == selectedLevel));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allClasses),
      selectedClass,
      stepView,
      selectedSubclass,
      const DeepCollectionEquality().hash(_selectedOptions),
      const DeepCollectionEquality().hash(_selectedSpellSelections),
      const DeepCollectionEquality().hash(_startingEquipmentSelections),
      selectedLevel);

  @override
  String toString() {
    return 'ClassStateModel(allClasses: $allClasses, selectedClass: $selectedClass, stepView: $stepView, selectedSubclass: $selectedSubclass, selectedOptions: $selectedOptions, selectedSpellSelections: $selectedSpellSelections, startingEquipmentSelections: $startingEquipmentSelections, selectedLevel: $selectedLevel)';
  }
}

/// @nodoc
abstract mixin class _$ClassStateModelCopyWith<$Res>
    implements $ClassStateModelCopyWith<$Res> {
  factory _$ClassStateModelCopyWith(
          _ClassStateModel value, $Res Function(_ClassStateModel) _then) =
      __$ClassStateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<ClassData> allClasses,
      ClassData? selectedClass,
      ClassStepView? stepView,
      SubclassData? selectedSubclass,
      Map<String, List<ClassChoiceOptionData>> selectedOptions,
      List<CharacterSpellSelectionData> selectedSpellSelections,
      List<CharacterStartingEquipmentSelectionData> startingEquipmentSelections,
      int selectedLevel});
}

/// @nodoc
class __$ClassStateModelCopyWithImpl<$Res>
    implements _$ClassStateModelCopyWith<$Res> {
  __$ClassStateModelCopyWithImpl(this._self, this._then);

  final _ClassStateModel _self;
  final $Res Function(_ClassStateModel) _then;

  /// Create a copy of ClassStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allClasses = null,
    Object? selectedClass = freezed,
    Object? stepView = freezed,
    Object? selectedSubclass = freezed,
    Object? selectedOptions = null,
    Object? selectedSpellSelections = null,
    Object? startingEquipmentSelections = null,
    Object? selectedLevel = null,
  }) {
    return _then(_ClassStateModel(
      allClasses: null == allClasses
          ? _self._allClasses
          : allClasses // ignore: cast_nullable_to_non_nullable
              as List<ClassData>,
      selectedClass: freezed == selectedClass
          ? _self.selectedClass
          : selectedClass // ignore: cast_nullable_to_non_nullable
              as ClassData?,
      stepView: freezed == stepView
          ? _self.stepView
          : stepView // ignore: cast_nullable_to_non_nullable
              as ClassStepView?,
      selectedSubclass: freezed == selectedSubclass
          ? _self.selectedSubclass
          : selectedSubclass // ignore: cast_nullable_to_non_nullable
              as SubclassData?,
      selectedOptions: null == selectedOptions
          ? _self._selectedOptions
          : selectedOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<ClassChoiceOptionData>>,
      selectedSpellSelections: null == selectedSpellSelections
          ? _self._selectedSpellSelections
          : selectedSpellSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterSpellSelectionData>,
      startingEquipmentSelections: null == startingEquipmentSelections
          ? _self._startingEquipmentSelections
          : startingEquipmentSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterStartingEquipmentSelectionData>,
      selectedLevel: null == selectedLevel
          ? _self.selectedLevel
          : selectedLevel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
