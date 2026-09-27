// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_creation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CharacterCreationState {
  CharacterData get character;
  Step get step;
  bool get hasSpellCreationStep;
  int get draftRevision;
  List<ChoiceGroupView> get raceChoiceGroups;
  List<ChoiceGroupView> get classChoiceGroups;
  List<ChoiceGroupView> get backgroundChoiceGroups;
  List<String> get backgroundChoiceGroupKeys;

  /// Create a copy of CharacterCreationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CharacterCreationStateCopyWith<CharacterCreationState> get copyWith =>
      _$CharacterCreationStateCopyWithImpl<CharacterCreationState>(
          this as CharacterCreationState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CharacterCreationState &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.hasSpellCreationStep, hasSpellCreationStep) ||
                other.hasSpellCreationStep == hasSpellCreationStep) &&
            (identical(other.draftRevision, draftRevision) ||
                other.draftRevision == draftRevision) &&
            const DeepCollectionEquality()
                .equals(other.raceChoiceGroups, raceChoiceGroups) &&
            const DeepCollectionEquality()
                .equals(other.classChoiceGroups, classChoiceGroups) &&
            const DeepCollectionEquality()
                .equals(other.backgroundChoiceGroups, backgroundChoiceGroups) &&
            const DeepCollectionEquality().equals(
                other.backgroundChoiceGroupKeys, backgroundChoiceGroupKeys));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      character,
      step,
      hasSpellCreationStep,
      draftRevision,
      const DeepCollectionEquality().hash(raceChoiceGroups),
      const DeepCollectionEquality().hash(classChoiceGroups),
      const DeepCollectionEquality().hash(backgroundChoiceGroups),
      const DeepCollectionEquality().hash(backgroundChoiceGroupKeys));

  @override
  String toString() {
    return 'CharacterCreationState(character: $character, step: $step, hasSpellCreationStep: $hasSpellCreationStep, draftRevision: $draftRevision, raceChoiceGroups: $raceChoiceGroups, classChoiceGroups: $classChoiceGroups, backgroundChoiceGroups: $backgroundChoiceGroups, backgroundChoiceGroupKeys: $backgroundChoiceGroupKeys)';
  }
}

/// @nodoc
abstract mixin class $CharacterCreationStateCopyWith<$Res> {
  factory $CharacterCreationStateCopyWith(CharacterCreationState value,
          $Res Function(CharacterCreationState) _then) =
      _$CharacterCreationStateCopyWithImpl;
  @useResult
  $Res call(
      {CharacterData character,
      Step step,
      bool hasSpellCreationStep,
      int draftRevision,
      List<ChoiceGroupView> raceChoiceGroups,
      List<ChoiceGroupView> classChoiceGroups,
      List<ChoiceGroupView> backgroundChoiceGroups,
      List<String> backgroundChoiceGroupKeys});
}

/// @nodoc
class _$CharacterCreationStateCopyWithImpl<$Res>
    implements $CharacterCreationStateCopyWith<$Res> {
  _$CharacterCreationStateCopyWithImpl(this._self, this._then);

  final CharacterCreationState _self;
  final $Res Function(CharacterCreationState) _then;

  /// Create a copy of CharacterCreationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? character = null,
    Object? step = null,
    Object? hasSpellCreationStep = null,
    Object? draftRevision = null,
    Object? raceChoiceGroups = null,
    Object? classChoiceGroups = null,
    Object? backgroundChoiceGroups = null,
    Object? backgroundChoiceGroupKeys = null,
  }) {
    return _then(_self.copyWith(
      character: null == character
          ? _self.character
          : character // ignore: cast_nullable_to_non_nullable
              as CharacterData,
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as Step,
      hasSpellCreationStep: null == hasSpellCreationStep
          ? _self.hasSpellCreationStep
          : hasSpellCreationStep // ignore: cast_nullable_to_non_nullable
              as bool,
      draftRevision: null == draftRevision
          ? _self.draftRevision
          : draftRevision // ignore: cast_nullable_to_non_nullable
              as int,
      raceChoiceGroups: null == raceChoiceGroups
          ? _self.raceChoiceGroups
          : raceChoiceGroups // ignore: cast_nullable_to_non_nullable
              as List<ChoiceGroupView>,
      classChoiceGroups: null == classChoiceGroups
          ? _self.classChoiceGroups
          : classChoiceGroups // ignore: cast_nullable_to_non_nullable
              as List<ChoiceGroupView>,
      backgroundChoiceGroups: null == backgroundChoiceGroups
          ? _self.backgroundChoiceGroups
          : backgroundChoiceGroups // ignore: cast_nullable_to_non_nullable
              as List<ChoiceGroupView>,
      backgroundChoiceGroupKeys: null == backgroundChoiceGroupKeys
          ? _self.backgroundChoiceGroupKeys
          : backgroundChoiceGroupKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// Adds pattern-matching-related methods to [CharacterCreationState].
extension CharacterCreationStatePatterns on CharacterCreationState {
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
    TResult Function(_CharacterCreationState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState() when $default != null:
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
    TResult Function(_CharacterCreationState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState():
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
    TResult? Function(_CharacterCreationState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState() when $default != null:
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
            CharacterData character,
            Step step,
            bool hasSpellCreationStep,
            int draftRevision,
            List<ChoiceGroupView> raceChoiceGroups,
            List<ChoiceGroupView> classChoiceGroups,
            List<ChoiceGroupView> backgroundChoiceGroups,
            List<String> backgroundChoiceGroupKeys)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState() when $default != null:
        return $default(
            _that.character,
            _that.step,
            _that.hasSpellCreationStep,
            _that.draftRevision,
            _that.raceChoiceGroups,
            _that.classChoiceGroups,
            _that.backgroundChoiceGroups,
            _that.backgroundChoiceGroupKeys);
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
            CharacterData character,
            Step step,
            bool hasSpellCreationStep,
            int draftRevision,
            List<ChoiceGroupView> raceChoiceGroups,
            List<ChoiceGroupView> classChoiceGroups,
            List<ChoiceGroupView> backgroundChoiceGroups,
            List<String> backgroundChoiceGroupKeys)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState():
        return $default(
            _that.character,
            _that.step,
            _that.hasSpellCreationStep,
            _that.draftRevision,
            _that.raceChoiceGroups,
            _that.classChoiceGroups,
            _that.backgroundChoiceGroups,
            _that.backgroundChoiceGroupKeys);
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
            CharacterData character,
            Step step,
            bool hasSpellCreationStep,
            int draftRevision,
            List<ChoiceGroupView> raceChoiceGroups,
            List<ChoiceGroupView> classChoiceGroups,
            List<ChoiceGroupView> backgroundChoiceGroups,
            List<String> backgroundChoiceGroupKeys)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState() when $default != null:
        return $default(
            _that.character,
            _that.step,
            _that.hasSpellCreationStep,
            _that.draftRevision,
            _that.raceChoiceGroups,
            _that.classChoiceGroups,
            _that.backgroundChoiceGroups,
            _that.backgroundChoiceGroupKeys);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CharacterCreationState implements CharacterCreationState {
  const _CharacterCreationState(
      {required this.character,
      required this.step,
      this.hasSpellCreationStep = false,
      this.draftRevision = 0,
      final List<ChoiceGroupView> raceChoiceGroups = const [],
      final List<ChoiceGroupView> classChoiceGroups = const [],
      final List<ChoiceGroupView> backgroundChoiceGroups = const [],
      final List<String> backgroundChoiceGroupKeys = const []})
      : _raceChoiceGroups = raceChoiceGroups,
        _classChoiceGroups = classChoiceGroups,
        _backgroundChoiceGroups = backgroundChoiceGroups,
        _backgroundChoiceGroupKeys = backgroundChoiceGroupKeys;

  @override
  final CharacterData character;
  @override
  final Step step;
  @override
  @JsonKey()
  final bool hasSpellCreationStep;
  @override
  @JsonKey()
  final int draftRevision;
  final List<ChoiceGroupView> _raceChoiceGroups;
  @override
  @JsonKey()
  List<ChoiceGroupView> get raceChoiceGroups {
    if (_raceChoiceGroups is EqualUnmodifiableListView)
      return _raceChoiceGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_raceChoiceGroups);
  }

  final List<ChoiceGroupView> _classChoiceGroups;
  @override
  @JsonKey()
  List<ChoiceGroupView> get classChoiceGroups {
    if (_classChoiceGroups is EqualUnmodifiableListView)
      return _classChoiceGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_classChoiceGroups);
  }

  final List<ChoiceGroupView> _backgroundChoiceGroups;
  @override
  @JsonKey()
  List<ChoiceGroupView> get backgroundChoiceGroups {
    if (_backgroundChoiceGroups is EqualUnmodifiableListView)
      return _backgroundChoiceGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backgroundChoiceGroups);
  }

  final List<String> _backgroundChoiceGroupKeys;
  @override
  @JsonKey()
  List<String> get backgroundChoiceGroupKeys {
    if (_backgroundChoiceGroupKeys is EqualUnmodifiableListView)
      return _backgroundChoiceGroupKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_backgroundChoiceGroupKeys);
  }

  /// Create a copy of CharacterCreationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CharacterCreationStateCopyWith<_CharacterCreationState> get copyWith =>
      __$CharacterCreationStateCopyWithImpl<_CharacterCreationState>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CharacterCreationState &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.step, step) || other.step == step) &&
            (identical(other.hasSpellCreationStep, hasSpellCreationStep) ||
                other.hasSpellCreationStep == hasSpellCreationStep) &&
            (identical(other.draftRevision, draftRevision) ||
                other.draftRevision == draftRevision) &&
            const DeepCollectionEquality()
                .equals(other._raceChoiceGroups, _raceChoiceGroups) &&
            const DeepCollectionEquality()
                .equals(other._classChoiceGroups, _classChoiceGroups) &&
            const DeepCollectionEquality().equals(
                other._backgroundChoiceGroups, _backgroundChoiceGroups) &&
            const DeepCollectionEquality().equals(
                other._backgroundChoiceGroupKeys, _backgroundChoiceGroupKeys));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      character,
      step,
      hasSpellCreationStep,
      draftRevision,
      const DeepCollectionEquality().hash(_raceChoiceGroups),
      const DeepCollectionEquality().hash(_classChoiceGroups),
      const DeepCollectionEquality().hash(_backgroundChoiceGroups),
      const DeepCollectionEquality().hash(_backgroundChoiceGroupKeys));

  @override
  String toString() {
    return 'CharacterCreationState(character: $character, step: $step, hasSpellCreationStep: $hasSpellCreationStep, draftRevision: $draftRevision, raceChoiceGroups: $raceChoiceGroups, classChoiceGroups: $classChoiceGroups, backgroundChoiceGroups: $backgroundChoiceGroups, backgroundChoiceGroupKeys: $backgroundChoiceGroupKeys)';
  }
}

/// @nodoc
abstract mixin class _$CharacterCreationStateCopyWith<$Res>
    implements $CharacterCreationStateCopyWith<$Res> {
  factory _$CharacterCreationStateCopyWith(_CharacterCreationState value,
          $Res Function(_CharacterCreationState) _then) =
      __$CharacterCreationStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {CharacterData character,
      Step step,
      bool hasSpellCreationStep,
      int draftRevision,
      List<ChoiceGroupView> raceChoiceGroups,
      List<ChoiceGroupView> classChoiceGroups,
      List<ChoiceGroupView> backgroundChoiceGroups,
      List<String> backgroundChoiceGroupKeys});
}

/// @nodoc
class __$CharacterCreationStateCopyWithImpl<$Res>
    implements _$CharacterCreationStateCopyWith<$Res> {
  __$CharacterCreationStateCopyWithImpl(this._self, this._then);

  final _CharacterCreationState _self;
  final $Res Function(_CharacterCreationState) _then;

  /// Create a copy of CharacterCreationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? character = null,
    Object? step = null,
    Object? hasSpellCreationStep = null,
    Object? draftRevision = null,
    Object? raceChoiceGroups = null,
    Object? classChoiceGroups = null,
    Object? backgroundChoiceGroups = null,
    Object? backgroundChoiceGroupKeys = null,
  }) {
    return _then(_CharacterCreationState(
      character: null == character
          ? _self.character
          : character // ignore: cast_nullable_to_non_nullable
              as CharacterData,
      step: null == step
          ? _self.step
          : step // ignore: cast_nullable_to_non_nullable
              as Step,
      hasSpellCreationStep: null == hasSpellCreationStep
          ? _self.hasSpellCreationStep
          : hasSpellCreationStep // ignore: cast_nullable_to_non_nullable
              as bool,
      draftRevision: null == draftRevision
          ? _self.draftRevision
          : draftRevision // ignore: cast_nullable_to_non_nullable
              as int,
      raceChoiceGroups: null == raceChoiceGroups
          ? _self._raceChoiceGroups
          : raceChoiceGroups // ignore: cast_nullable_to_non_nullable
              as List<ChoiceGroupView>,
      classChoiceGroups: null == classChoiceGroups
          ? _self._classChoiceGroups
          : classChoiceGroups // ignore: cast_nullable_to_non_nullable
              as List<ChoiceGroupView>,
      backgroundChoiceGroups: null == backgroundChoiceGroups
          ? _self._backgroundChoiceGroups
          : backgroundChoiceGroups // ignore: cast_nullable_to_non_nullable
              as List<ChoiceGroupView>,
      backgroundChoiceGroupKeys: null == backgroundChoiceGroupKeys
          ? _self._backgroundChoiceGroupKeys
          : backgroundChoiceGroupKeys // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

// dart format on
