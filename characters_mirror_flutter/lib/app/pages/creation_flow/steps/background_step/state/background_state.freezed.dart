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
                other.selectedBackground == selectedBackground));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(allBackgrounds), selectedBackground);

  @override
  String toString() {
    return 'BackgroundStateModel(allBackgrounds: $allBackgrounds, selectedBackground: $selectedBackground)';
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
      BackgroundData? selectedBackground});
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
    TResult Function(List<BackgroundData> allBackgrounds,
            BackgroundData? selectedBackground)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel() when $default != null:
        return $default(_that.allBackgrounds, _that.selectedBackground);
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
    TResult Function(List<BackgroundData> allBackgrounds,
            BackgroundData? selectedBackground)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel():
        return $default(_that.allBackgrounds, _that.selectedBackground);
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
    TResult? Function(List<BackgroundData> allBackgrounds,
            BackgroundData? selectedBackground)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _BackgroundStateModel() when $default != null:
        return $default(_that.allBackgrounds, _that.selectedBackground);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _BackgroundStateModel implements BackgroundStateModel {
  const _BackgroundStateModel(
      {final List<BackgroundData> allBackgrounds = const [],
      this.selectedBackground})
      : _allBackgrounds = allBackgrounds;

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
                other.selectedBackground == selectedBackground));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_allBackgrounds), selectedBackground);

  @override
  String toString() {
    return 'BackgroundStateModel(allBackgrounds: $allBackgrounds, selectedBackground: $selectedBackground)';
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
      BackgroundData? selectedBackground});
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
    ));
  }
}

// dart format on
