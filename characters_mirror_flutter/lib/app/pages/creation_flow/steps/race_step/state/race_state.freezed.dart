// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'race_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RaceStateModel {
  List<RaceData> get allRaces;
  RaceData? get selectedRace;
  List<SubraceData> get subraces;
  SubraceData? get selectedSubrace;

  /// Create a copy of RaceStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RaceStateModelCopyWith<RaceStateModel> get copyWith =>
      _$RaceStateModelCopyWithImpl<RaceStateModel>(
          this as RaceStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RaceStateModel &&
            const DeepCollectionEquality().equals(other.allRaces, allRaces) &&
            (identical(other.selectedRace, selectedRace) ||
                other.selectedRace == selectedRace) &&
            const DeepCollectionEquality().equals(other.subraces, subraces) &&
            (identical(other.selectedSubrace, selectedSubrace) ||
                other.selectedSubrace == selectedSubrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(allRaces),
      selectedRace,
      const DeepCollectionEquality().hash(subraces),
      selectedSubrace);

  @override
  String toString() {
    return 'RaceStateModel(allRaces: $allRaces, selectedRace: $selectedRace, subraces: $subraces, selectedSubrace: $selectedSubrace)';
  }
}

/// @nodoc
abstract mixin class $RaceStateModelCopyWith<$Res> {
  factory $RaceStateModelCopyWith(
          RaceStateModel value, $Res Function(RaceStateModel) _then) =
      _$RaceStateModelCopyWithImpl;
  @useResult
  $Res call(
      {List<RaceData> allRaces,
      RaceData? selectedRace,
      List<SubraceData> subraces,
      SubraceData? selectedSubrace});
}

/// @nodoc
class _$RaceStateModelCopyWithImpl<$Res>
    implements $RaceStateModelCopyWith<$Res> {
  _$RaceStateModelCopyWithImpl(this._self, this._then);

  final RaceStateModel _self;
  final $Res Function(RaceStateModel) _then;

  /// Create a copy of RaceStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allRaces = null,
    Object? selectedRace = freezed,
    Object? subraces = null,
    Object? selectedSubrace = freezed,
  }) {
    return _then(_self.copyWith(
      allRaces: null == allRaces
          ? _self.allRaces
          : allRaces // ignore: cast_nullable_to_non_nullable
              as List<RaceData>,
      selectedRace: freezed == selectedRace
          ? _self.selectedRace
          : selectedRace // ignore: cast_nullable_to_non_nullable
              as RaceData?,
      subraces: null == subraces
          ? _self.subraces
          : subraces // ignore: cast_nullable_to_non_nullable
              as List<SubraceData>,
      selectedSubrace: freezed == selectedSubrace
          ? _self.selectedSubrace
          : selectedSubrace // ignore: cast_nullable_to_non_nullable
              as SubraceData?,
    ));
  }
}

/// Adds pattern-matching-related methods to [RaceStateModel].
extension RaceStateModelPatterns on RaceStateModel {
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
    TResult Function(_RaceStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RaceStateModel() when $default != null:
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
    TResult Function(_RaceStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RaceStateModel():
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
    TResult? Function(_RaceStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RaceStateModel() when $default != null:
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
    TResult Function(List<RaceData> allRaces, RaceData? selectedRace,
            List<SubraceData> subraces, SubraceData? selectedSubrace)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _RaceStateModel() when $default != null:
        return $default(_that.allRaces, _that.selectedRace, _that.subraces,
            _that.selectedSubrace);
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
    TResult Function(List<RaceData> allRaces, RaceData? selectedRace,
            List<SubraceData> subraces, SubraceData? selectedSubrace)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RaceStateModel():
        return $default(_that.allRaces, _that.selectedRace, _that.subraces,
            _that.selectedSubrace);
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
    TResult? Function(List<RaceData> allRaces, RaceData? selectedRace,
            List<SubraceData> subraces, SubraceData? selectedSubrace)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _RaceStateModel() when $default != null:
        return $default(_that.allRaces, _that.selectedRace, _that.subraces,
            _that.selectedSubrace);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _RaceStateModel implements RaceStateModel {
  const _RaceStateModel(
      {final List<RaceData> allRaces = const [],
      this.selectedRace,
      final List<SubraceData> subraces = const [],
      this.selectedSubrace})
      : _allRaces = allRaces,
        _subraces = subraces;

  final List<RaceData> _allRaces;
  @override
  @JsonKey()
  List<RaceData> get allRaces {
    if (_allRaces is EqualUnmodifiableListView) return _allRaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allRaces);
  }

  @override
  final RaceData? selectedRace;
  final List<SubraceData> _subraces;
  @override
  @JsonKey()
  List<SubraceData> get subraces {
    if (_subraces is EqualUnmodifiableListView) return _subraces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subraces);
  }

  @override
  final SubraceData? selectedSubrace;

  /// Create a copy of RaceStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RaceStateModelCopyWith<_RaceStateModel> get copyWith =>
      __$RaceStateModelCopyWithImpl<_RaceStateModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RaceStateModel &&
            const DeepCollectionEquality().equals(other._allRaces, _allRaces) &&
            (identical(other.selectedRace, selectedRace) ||
                other.selectedRace == selectedRace) &&
            const DeepCollectionEquality().equals(other._subraces, _subraces) &&
            (identical(other.selectedSubrace, selectedSubrace) ||
                other.selectedSubrace == selectedSubrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allRaces),
      selectedRace,
      const DeepCollectionEquality().hash(_subraces),
      selectedSubrace);

  @override
  String toString() {
    return 'RaceStateModel(allRaces: $allRaces, selectedRace: $selectedRace, subraces: $subraces, selectedSubrace: $selectedSubrace)';
  }
}

/// @nodoc
abstract mixin class _$RaceStateModelCopyWith<$Res>
    implements $RaceStateModelCopyWith<$Res> {
  factory _$RaceStateModelCopyWith(
          _RaceStateModel value, $Res Function(_RaceStateModel) _then) =
      __$RaceStateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<RaceData> allRaces,
      RaceData? selectedRace,
      List<SubraceData> subraces,
      SubraceData? selectedSubrace});
}

/// @nodoc
class __$RaceStateModelCopyWithImpl<$Res>
    implements _$RaceStateModelCopyWith<$Res> {
  __$RaceStateModelCopyWithImpl(this._self, this._then);

  final _RaceStateModel _self;
  final $Res Function(_RaceStateModel) _then;

  /// Create a copy of RaceStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? allRaces = null,
    Object? selectedRace = freezed,
    Object? subraces = null,
    Object? selectedSubrace = freezed,
  }) {
    return _then(_RaceStateModel(
      allRaces: null == allRaces
          ? _self._allRaces
          : allRaces // ignore: cast_nullable_to_non_nullable
              as List<RaceData>,
      selectedRace: freezed == selectedRace
          ? _self.selectedRace
          : selectedRace // ignore: cast_nullable_to_non_nullable
              as RaceData?,
      subraces: null == subraces
          ? _self._subraces
          : subraces // ignore: cast_nullable_to_non_nullable
              as List<SubraceData>,
      selectedSubrace: freezed == selectedSubrace
          ? _self.selectedSubrace
          : selectedSubrace // ignore: cast_nullable_to_non_nullable
              as SubraceData?,
    ));
  }
}

// dart format on
