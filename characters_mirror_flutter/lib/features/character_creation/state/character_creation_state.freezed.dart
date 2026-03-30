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
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, character, step);

  @override
  String toString() {
    return 'CharacterCreationState(character: $character, step: $step)';
  }
}

/// @nodoc
abstract mixin class $CharacterCreationStateCopyWith<$Res> {
  factory $CharacterCreationStateCopyWith(CharacterCreationState value,
          $Res Function(CharacterCreationState) _then) =
      _$CharacterCreationStateCopyWithImpl;
  @useResult
  $Res call({CharacterData character, Step step});
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
    TResult Function(CharacterData character, Step step)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState() when $default != null:
        return $default(_that.character, _that.step);
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
    TResult Function(CharacterData character, Step step) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState():
        return $default(_that.character, _that.step);
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
    TResult? Function(CharacterData character, Step step)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _CharacterCreationState() when $default != null:
        return $default(_that.character, _that.step);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _CharacterCreationState implements CharacterCreationState {
  const _CharacterCreationState({required this.character, required this.step});

  @override
  final CharacterData character;
  @override
  final Step step;

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
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, character, step);

  @override
  String toString() {
    return 'CharacterCreationState(character: $character, step: $step)';
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
  $Res call({CharacterData character, Step step});
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
    ));
  }
}

// dart format on
