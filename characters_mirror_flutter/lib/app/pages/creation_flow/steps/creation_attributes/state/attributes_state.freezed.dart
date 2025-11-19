// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attributes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttributesStateModel {
  SelectType get selectionType;
  Map<Attribute, int> get attributes;

  /// Create a copy of AttributesStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttributesStateModelCopyWith<AttributesStateModel> get copyWith =>
      _$AttributesStateModelCopyWithImpl<AttributesStateModel>(
          this as AttributesStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttributesStateModel &&
            (identical(other.selectionType, selectionType) ||
                other.selectionType == selectionType) &&
            const DeepCollectionEquality()
                .equals(other.attributes, attributes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectionType,
      const DeepCollectionEquality().hash(attributes));

  @override
  String toString() {
    return 'AttributesStateModel(selectionType: $selectionType, attributes: $attributes)';
  }
}

/// @nodoc
abstract mixin class $AttributesStateModelCopyWith<$Res> {
  factory $AttributesStateModelCopyWith(AttributesStateModel value,
          $Res Function(AttributesStateModel) _then) =
      _$AttributesStateModelCopyWithImpl;
  @useResult
  $Res call({SelectType selectionType, Map<Attribute, int> attributes});
}

/// @nodoc
class _$AttributesStateModelCopyWithImpl<$Res>
    implements $AttributesStateModelCopyWith<$Res> {
  _$AttributesStateModelCopyWithImpl(this._self, this._then);

  final AttributesStateModel _self;
  final $Res Function(AttributesStateModel) _then;

  /// Create a copy of AttributesStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectionType = null,
    Object? attributes = null,
  }) {
    return _then(_self.copyWith(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
      attributes: null == attributes
          ? _self.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttributesStateModel].
extension AttributesStateModelPatterns on AttributesStateModel {
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
    TResult Function(_AttributesStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributesStateModel() when $default != null:
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
    TResult Function(_AttributesStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributesStateModel():
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
    TResult? Function(_AttributesStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributesStateModel() when $default != null:
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
    TResult Function(SelectType selectionType, Map<Attribute, int> attributes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributesStateModel() when $default != null:
        return $default(_that.selectionType, _that.attributes);
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
    TResult Function(SelectType selectionType, Map<Attribute, int> attributes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributesStateModel():
        return $default(_that.selectionType, _that.attributes);
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
    TResult? Function(SelectType selectionType, Map<Attribute, int> attributes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributesStateModel() when $default != null:
        return $default(_that.selectionType, _that.attributes);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AttributesStateModel implements AttributesStateModel {
  _AttributesStateModel(
      {this.selectionType = SelectType.defaultType,
      final Map<Attribute, int> attributes = const {}})
      : _attributes = attributes;

  @override
  @JsonKey()
  final SelectType selectionType;
  final Map<Attribute, int> _attributes;
  @override
  @JsonKey()
  Map<Attribute, int> get attributes {
    if (_attributes is EqualUnmodifiableMapView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributes);
  }

  /// Create a copy of AttributesStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttributesStateModelCopyWith<_AttributesStateModel> get copyWith =>
      __$AttributesStateModelCopyWithImpl<_AttributesStateModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttributesStateModel &&
            (identical(other.selectionType, selectionType) ||
                other.selectionType == selectionType) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectionType,
      const DeepCollectionEquality().hash(_attributes));

  @override
  String toString() {
    return 'AttributesStateModel(selectionType: $selectionType, attributes: $attributes)';
  }
}

/// @nodoc
abstract mixin class _$AttributesStateModelCopyWith<$Res>
    implements $AttributesStateModelCopyWith<$Res> {
  factory _$AttributesStateModelCopyWith(_AttributesStateModel value,
          $Res Function(_AttributesStateModel) _then) =
      __$AttributesStateModelCopyWithImpl;
  @override
  @useResult
  $Res call({SelectType selectionType, Map<Attribute, int> attributes});
}

/// @nodoc
class __$AttributesStateModelCopyWithImpl<$Res>
    implements _$AttributesStateModelCopyWith<$Res> {
  __$AttributesStateModelCopyWithImpl(this._self, this._then);

  final _AttributesStateModel _self;
  final $Res Function(_AttributesStateModel) _then;

  /// Create a copy of AttributesStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectionType = null,
    Object? attributes = null,
  }) {
    return _then(_AttributesStateModel(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
      attributes: null == attributes
          ? _self._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
    ));
  }
}

// dart format on
