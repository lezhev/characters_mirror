// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'background_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackgroundStateModel {
  List<BackgroundData> get allBackgrounds;
  BackgroundData? get selectedBackground;
  BackgroundStepView? get stepView;
  Map<String, List<ClassChoiceOptionData>> get selectedOptions;
  List<CharacterSkillSelectionData> get selectedSkillSelections;
  List<CharacterStartingEquipmentSelectionData> get startingEquipmentSelections;

  /// Create a copy of BackgroundStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BackgroundStateModelCopyWith<BackgroundStateModel> get copyWith =>
      _$BackgroundStateModelCopyWithImpl<BackgroundStateModel>(
          this as BackgroundStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BackgroundStateModel &&
            const DeepCollectionEquality()
                .equals(other.allBackgrounds, allBackgrounds) &&
            (identical(other.selectedBackground, selectedBackground) ||
                other.selectedBackground == selectedBackground) &&
            (identical(other.stepView, stepView) ||
                other.stepView == stepView) &&
            const DeepCollectionEquality()
                .equals(other.selectedOptions, selectedOptions) &&
            const DeepCollectionEquality().equals(
                other.selectedSkillSelections, selectedSkillSelections) &&
            const DeepCollectionEquality().equals(
                other.startingEquipmentSelections,
                startingEquipmentSelections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(allBackgrounds),
      selectedBackground,
      stepView,
      const DeepCollectionEquality().hash(selectedOptions),
      const DeepCollectionEquality().hash(selectedSkillSelections),
      const DeepCollectionEquality().hash(startingEquipmentSelections));

  @override
  String toString() {
    return 'BackgroundStateModel(allBackgrounds: $allBackgrounds, selectedBackground: $selectedBackground, stepView: $stepView, selectedOptions: $selectedOptions, selectedSkillSelections: $selectedSkillSelections, startingEquipmentSelections: $startingEquipmentSelections)';
  }
}

/// @nodoc
abstract mixin class $BackgroundStateModelCopyWith<$Res> {
  factory $BackgroundStateModelCopyWith(BackgroundStateModel value,
          $Res Function(BackgroundStateModel) _then) =
      _$BackgroundStateModelCopyWithImpl;
  @useResult
  $Res call(
      {List<BackgroundData> allBackgrounds,
      BackgroundData? selectedBackground,
      BackgroundStepView? stepView,
      Map<String, List<ClassChoiceOptionData>> selectedOptions,
      List<CharacterSkillSelectionData> selectedSkillSelections,
      List<CharacterStartingEquipmentSelectionData>
          startingEquipmentSelections});
}

/// @nodoc
class _$BackgroundStateModelCopyWithImpl<$Res>
    implements $BackgroundStateModelCopyWith<$Res> {
  _$BackgroundStateModelCopyWithImpl(this._self, this._then);

  final BackgroundStateModel _self;
  final $Res Function(BackgroundStateModel) _then;

  /// Create a copy of BackgroundStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allBackgrounds = null,
    Object? selectedBackground = freezed,
    Object? stepView = freezed,
    Object? selectedOptions = null,
    Object? selectedSkillSelections = null,
    Object? startingEquipmentSelections = null,
  }) {
    return _then(_self.copyWith(
      allBackgrounds: null == allBackgrounds
          ? _self.allBackgrounds
          : allBackgrounds // ignore: cast_nullable_to_non_nullable
              as List<BackgroundData>,
      selectedBackground: freezed == selectedBackground
          ? _self.selectedBackground
          : selectedBackground // ignore: cast_nullable_to_non_nullable
              as BackgroundData?,
      stepView: freezed == stepView
          ? _self.stepView
          : stepView // ignore: cast_nullable_to_non_nullable
              as BackgroundStepView?,
      selectedOptions: null == selectedOptions
          ? _self.selectedOptions
          : selectedOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<ClassChoiceOptionData>>,
      selectedSkillSelections: null == selectedSkillSelections
          ? _self.selectedSkillSelections
          : selectedSkillSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterSkillSelectionData>,
      startingEquipmentSelections: null == startingEquipmentSelections
          ? _self.startingEquipmentSelections
          : startingEquipmentSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterStartingEquipmentSelectionData>,
    ));
  }
}

/// Adds pattern-matching-related methods to [BackgroundStateModel].
extension BackgroundStateModelPatterns on BackgroundStateModel {
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
    TResult Function(_BackgroundStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel() when $default != null:
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
    TResult Function(_BackgroundStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
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
    TResult? Function(_BackgroundStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel() when $default != null:
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
            List<BackgroundData> allBackgrounds,
            BackgroundData? selectedBackground,
            BackgroundStepView? stepView,
            Map<String, List<ClassChoiceOptionData>> selectedOptions,
            List<CharacterSkillSelectionData> selectedSkillSelections,
            List<CharacterStartingEquipmentSelectionData>
                startingEquipmentSelections)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel() when $default != null:
        return $default(
            _that.allBackgrounds,
            _that.selectedBackground,
            _that.stepView,
            _that.selectedOptions,
            _that.selectedSkillSelections,
            _that.startingEquipmentSelections);
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
            List<BackgroundData> allBackgrounds,
            BackgroundData? selectedBackground,
            BackgroundStepView? stepView,
            Map<String, List<ClassChoiceOptionData>> selectedOptions,
            List<CharacterSkillSelectionData> selectedSkillSelections,
            List<CharacterStartingEquipmentSelectionData>
                startingEquipmentSelections)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel():
        return $default(
            _that.allBackgrounds,
            _that.selectedBackground,
            _that.stepView,
            _that.selectedOptions,
            _that.selectedSkillSelections,
            _that.startingEquipmentSelections);
      case _:
        throw StateError('Unexpected subclass');
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
            List<BackgroundData> allBackgrounds,
            BackgroundData? selectedBackground,
            BackgroundStepView? stepView,
            Map<String, List<ClassChoiceOptionData>> selectedOptions,
            List<CharacterSkillSelectionData> selectedSkillSelections,
            List<CharacterStartingEquipmentSelectionData>
                startingEquipmentSelections)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel() when $default != null:
        return $default(
            _that.allBackgrounds,
            _that.selectedBackground,
            _that.stepView,
            _that.selectedOptions,
            _that.selectedSkillSelections,
            _that.startingEquipmentSelections);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BackgroundStateModel implements BackgroundStateModel {
  const _BackgroundStateModel(
      {final List<BackgroundData> allBackgrounds = const [],
      this.selectedBackground,
      this.stepView,
      final Map<String, List<ClassChoiceOptionData>> selectedOptions = const {},
      final List<CharacterSkillSelectionData> selectedSkillSelections =
          const [],
      final List<CharacterStartingEquipmentSelectionData>
          startingEquipmentSelections = const []})
      : _allBackgrounds = allBackgrounds,
        _selectedOptions = selectedOptions,
        _selectedSkillSelections = selectedSkillSelections,
        _startingEquipmentSelections = startingEquipmentSelections;

  final List<BackgroundData> _allBackgrounds;
  @override
  @JsonKey()
  List<BackgroundData> get allBackgrounds {
    if (_allBackgrounds is EqualUnmodifiableListView) return _allBackgrounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allBackgrounds);
  }

  @override
  final BackgroundData? selectedBackground;
  @override
  final BackgroundStepView? stepView;
  final Map<String, List<ClassChoiceOptionData>> _selectedOptions;
  @override
  @JsonKey()
  Map<String, List<ClassChoiceOptionData>> get selectedOptions {
    if (_selectedOptions is EqualUnmodifiableMapView) return _selectedOptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedOptions);
  }

  final List<CharacterSkillSelectionData> _selectedSkillSelections;
  @override
  @JsonKey()
  List<CharacterSkillSelectionData> get selectedSkillSelections {
    if (_selectedSkillSelections is EqualUnmodifiableListView)
      return _selectedSkillSelections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedSkillSelections);
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

  /// Create a copy of BackgroundStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BackgroundStateModelCopyWith<_BackgroundStateModel> get copyWith =>
      __$BackgroundStateModelCopyWithImpl<_BackgroundStateModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _BackgroundStateModel &&
            const DeepCollectionEquality()
                .equals(other._allBackgrounds, _allBackgrounds) &&
            (identical(other.selectedBackground, selectedBackground) ||
                other.selectedBackground == selectedBackground) &&
            (identical(other.stepView, stepView) ||
                other.stepView == stepView) &&
            const DeepCollectionEquality()
                .equals(other._selectedOptions, _selectedOptions) &&
            const DeepCollectionEquality().equals(
                other._selectedSkillSelections, _selectedSkillSelections) &&
            const DeepCollectionEquality().equals(
                other._startingEquipmentSelections,
                _startingEquipmentSelections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allBackgrounds),
      selectedBackground,
      stepView,
      const DeepCollectionEquality().hash(_selectedOptions),
      const DeepCollectionEquality().hash(_selectedSkillSelections),
      const DeepCollectionEquality().hash(_startingEquipmentSelections));

  @override
  String toString() {
    return 'BackgroundStateModel(allBackgrounds: $allBackgrounds, selectedBackground: $selectedBackground, stepView: $stepView, selectedOptions: $selectedOptions, selectedSkillSelections: $selectedSkillSelections, startingEquipmentSelections: $startingEquipmentSelections)';
  }
}

/// @nodoc
abstract mixin class _$BackgroundStateModelCopyWith<$Res>
    implements $BackgroundStateModelCopyWith<$Res> {
  factory _$BackgroundStateModelCopyWith(_BackgroundStateModel value,
          $Res Function(_BackgroundStateModel) _then) =
      __$BackgroundStateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<BackgroundData> allBackgrounds,
      BackgroundData? selectedBackground,
      BackgroundStepView? stepView,
      Map<String, List<ClassChoiceOptionData>> selectedOptions,
      List<CharacterSkillSelectionData> selectedSkillSelections,
      List<CharacterStartingEquipmentSelectionData>
          startingEquipmentSelections});
}

/// @nodoc
class __$BackgroundStateModelCopyWithImpl<$Res>
    implements _$BackgroundStateModelCopyWith<$Res> {
  __$BackgroundStateModelCopyWithImpl(this._self, this._then);

  final _BackgroundStateModel _self;
  final $Res Function(_BackgroundStateModel) _then;

  /// Create a copy of BackgroundStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allBackgrounds = null,
    Object? selectedBackground = freezed,
    Object? stepView = freezed,
    Object? selectedOptions = null,
    Object? selectedSkillSelections = null,
    Object? startingEquipmentSelections = null,
  }) {
    return _then(_BackgroundStateModel(
      allBackgrounds: null == allBackgrounds
          ? _self._allBackgrounds
          : allBackgrounds // ignore: cast_nullable_to_non_nullable
              as List<BackgroundData>,
      selectedBackground: freezed == selectedBackground
          ? _self.selectedBackground
          : selectedBackground // ignore: cast_nullable_to_non_nullable
              as BackgroundData?,
      stepView: freezed == stepView
          ? _self.stepView
          : stepView // ignore: cast_nullable_to_non_nullable
              as BackgroundStepView?,
      selectedOptions: null == selectedOptions
          ? _self._selectedOptions
          : selectedOptions // ignore: cast_nullable_to_non_nullable
              as Map<String, List<ClassChoiceOptionData>>,
      selectedSkillSelections: null == selectedSkillSelections
          ? _self._selectedSkillSelections
          : selectedSkillSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterSkillSelectionData>,
      startingEquipmentSelections: null == startingEquipmentSelections
          ? _self._startingEquipmentSelections
          : startingEquipmentSelections // ignore: cast_nullable_to_non_nullable
              as List<CharacterStartingEquipmentSelectionData>,
    ));
  }
}

// dart format on
