// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'default_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DefaultSelectionStateModel {
  Map<Attribute, int> get assignedAttributes;
  Map<Attribute, bool> get bonusesPlusOne;
  Map<Attribute, bool> get bonusesPlusTwo;
  List<int> get attributeValues;
  List<int> get remainingValues;
  List<Attribute> get plusOneOrder;
  List<Attribute> get plusTwoOrder;
  Map<Attribute, int> get raceAttributeBonuses;

  /// Create a copy of DefaultSelectionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DefaultSelectionStateModelCopyWith<DefaultSelectionStateModel>
      get copyWith =>
          _$DefaultSelectionStateModelCopyWithImpl<DefaultSelectionStateModel>(
              this as DefaultSelectionStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DefaultSelectionStateModel &&
            const DeepCollectionEquality()
                .equals(other.assignedAttributes, assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusOne, bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusTwo, bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other.attributeValues, attributeValues) &&
            const DeepCollectionEquality()
                .equals(other.remainingValues, remainingValues) &&
            const DeepCollectionEquality()
                .equals(other.plusOneOrder, plusOneOrder) &&
            const DeepCollectionEquality()
                .equals(other.plusTwoOrder, plusTwoOrder) &&
            const DeepCollectionEquality()
                .equals(other.raceAttributeBonuses, raceAttributeBonuses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(assignedAttributes),
      const DeepCollectionEquality().hash(bonusesPlusOne),
      const DeepCollectionEquality().hash(bonusesPlusTwo),
      const DeepCollectionEquality().hash(attributeValues),
      const DeepCollectionEquality().hash(remainingValues),
      const DeepCollectionEquality().hash(plusOneOrder),
      const DeepCollectionEquality().hash(plusTwoOrder),
      const DeepCollectionEquality().hash(raceAttributeBonuses));

  @override
  String toString() {
    return 'DefaultSelectionStateModel(assignedAttributes: $assignedAttributes, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, attributeValues: $attributeValues, remainingValues: $remainingValues, plusOneOrder: $plusOneOrder, plusTwoOrder: $plusTwoOrder, raceAttributeBonuses: $raceAttributeBonuses)';
  }
}

/// @nodoc
abstract mixin class $DefaultSelectionStateModelCopyWith<$Res> {
  factory $DefaultSelectionStateModelCopyWith(DefaultSelectionStateModel value,
          $Res Function(DefaultSelectionStateModel) _then) =
      _$DefaultSelectionStateModelCopyWithImpl;
  @useResult
  $Res call(
      {Map<Attribute, int> assignedAttributes,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
      List<int> attributeValues,
      List<int> remainingValues,
      List<Attribute> plusOneOrder,
      List<Attribute> plusTwoOrder,
      Map<Attribute, int> raceAttributeBonuses});
}

/// @nodoc
class _$DefaultSelectionStateModelCopyWithImpl<$Res>
    implements $DefaultSelectionStateModelCopyWith<$Res> {
  _$DefaultSelectionStateModelCopyWithImpl(this._self, this._then);

  final DefaultSelectionStateModel _self;
  final $Res Function(DefaultSelectionStateModel) _then;

  /// Create a copy of DefaultSelectionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignedAttributes = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? attributeValues = null,
    Object? remainingValues = null,
    Object? plusOneOrder = null,
    Object? plusTwoOrder = null,
    Object? raceAttributeBonuses = null,
  }) {
    return _then(_self.copyWith(
      assignedAttributes: null == assignedAttributes
          ? _self.assignedAttributes
          : assignedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
      bonusesPlusOne: null == bonusesPlusOne
          ? _self.bonusesPlusOne
          : bonusesPlusOne // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
      bonusesPlusTwo: null == bonusesPlusTwo
          ? _self.bonusesPlusTwo
          : bonusesPlusTwo // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
      attributeValues: null == attributeValues
          ? _self.attributeValues
          : attributeValues // ignore: cast_nullable_to_non_nullable
              as List<int>,
      remainingValues: null == remainingValues
          ? _self.remainingValues
          : remainingValues // ignore: cast_nullable_to_non_nullable
              as List<int>,
      plusOneOrder: null == plusOneOrder
          ? _self.plusOneOrder
          : plusOneOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      plusTwoOrder: null == plusTwoOrder
          ? _self.plusTwoOrder
          : plusTwoOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      raceAttributeBonuses: null == raceAttributeBonuses
          ? _self.raceAttributeBonuses
          : raceAttributeBonuses // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [DefaultSelectionStateModel].
extension DefaultSelectionStateModelPatterns on DefaultSelectionStateModel {
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
    TResult Function(_DefaultSelectionStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultSelectionStateModel() when $default != null:
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
    TResult Function(_DefaultSelectionStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultSelectionStateModel():
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
    TResult? Function(_DefaultSelectionStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultSelectionStateModel() when $default != null:
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
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<int> attributeValues,
            List<int> remainingValues,
            List<Attribute> plusOneOrder,
            List<Attribute> plusTwoOrder,
            Map<Attribute, int> raceAttributeBonuses)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DefaultSelectionStateModel() when $default != null:
        return $default(
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.attributeValues,
            _that.remainingValues,
            _that.plusOneOrder,
            _that.plusTwoOrder,
            _that.raceAttributeBonuses);
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
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<int> attributeValues,
            List<int> remainingValues,
            List<Attribute> plusOneOrder,
            List<Attribute> plusTwoOrder,
            Map<Attribute, int> raceAttributeBonuses)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultSelectionStateModel():
        return $default(
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.attributeValues,
            _that.remainingValues,
            _that.plusOneOrder,
            _that.plusTwoOrder,
            _that.raceAttributeBonuses);
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
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<int> attributeValues,
            List<int> remainingValues,
            List<Attribute> plusOneOrder,
            List<Attribute> plusTwoOrder,
            Map<Attribute, int> raceAttributeBonuses)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DefaultSelectionStateModel() when $default != null:
        return $default(
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.attributeValues,
            _that.remainingValues,
            _that.plusOneOrder,
            _that.plusTwoOrder,
            _that.raceAttributeBonuses);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DefaultSelectionStateModel implements DefaultSelectionStateModel {
  _DefaultSelectionStateModel(
      {final Map<Attribute, int> assignedAttributes = const {},
      final Map<Attribute, bool> bonusesPlusOne = const {},
      final Map<Attribute, bool> bonusesPlusTwo = const {},
      final List<int> attributeValues = const [],
      final List<int> remainingValues = const [],
      final List<Attribute> plusOneOrder = const [],
      final List<Attribute> plusTwoOrder = const [],
      required final Map<Attribute, int> raceAttributeBonuses})
      : _assignedAttributes = assignedAttributes,
        _bonusesPlusOne = bonusesPlusOne,
        _bonusesPlusTwo = bonusesPlusTwo,
        _attributeValues = attributeValues,
        _remainingValues = remainingValues,
        _plusOneOrder = plusOneOrder,
        _plusTwoOrder = plusTwoOrder,
        _raceAttributeBonuses = raceAttributeBonuses;

  final Map<Attribute, int> _assignedAttributes;
  @override
  @JsonKey()
  Map<Attribute, int> get assignedAttributes {
    if (_assignedAttributes is EqualUnmodifiableMapView)
      return _assignedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_assignedAttributes);
  }

  final Map<Attribute, bool> _bonusesPlusOne;
  @override
  @JsonKey()
  Map<Attribute, bool> get bonusesPlusOne {
    if (_bonusesPlusOne is EqualUnmodifiableMapView) return _bonusesPlusOne;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bonusesPlusOne);
  }

  final Map<Attribute, bool> _bonusesPlusTwo;
  @override
  @JsonKey()
  Map<Attribute, bool> get bonusesPlusTwo {
    if (_bonusesPlusTwo is EqualUnmodifiableMapView) return _bonusesPlusTwo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bonusesPlusTwo);
  }

  final List<int> _attributeValues;
  @override
  @JsonKey()
  List<int> get attributeValues {
    if (_attributeValues is EqualUnmodifiableListView) return _attributeValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attributeValues);
  }

  final List<int> _remainingValues;
  @override
  @JsonKey()
  List<int> get remainingValues {
    if (_remainingValues is EqualUnmodifiableListView) return _remainingValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remainingValues);
  }

  final List<Attribute> _plusOneOrder;
  @override
  @JsonKey()
  List<Attribute> get plusOneOrder {
    if (_plusOneOrder is EqualUnmodifiableListView) return _plusOneOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plusOneOrder);
  }

  final List<Attribute> _plusTwoOrder;
  @override
  @JsonKey()
  List<Attribute> get plusTwoOrder {
    if (_plusTwoOrder is EqualUnmodifiableListView) return _plusTwoOrder;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plusTwoOrder);
  }

  final Map<Attribute, int> _raceAttributeBonuses;
  @override
  Map<Attribute, int> get raceAttributeBonuses {
    if (_raceAttributeBonuses is EqualUnmodifiableMapView)
      return _raceAttributeBonuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_raceAttributeBonuses);
  }

  /// Create a copy of DefaultSelectionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DefaultSelectionStateModelCopyWith<_DefaultSelectionStateModel>
      get copyWith => __$DefaultSelectionStateModelCopyWithImpl<
          _DefaultSelectionStateModel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DefaultSelectionStateModel &&
            const DeepCollectionEquality()
                .equals(other._assignedAttributes, _assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other._bonusesPlusOne, _bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other._bonusesPlusTwo, _bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other._attributeValues, _attributeValues) &&
            const DeepCollectionEquality()
                .equals(other._remainingValues, _remainingValues) &&
            const DeepCollectionEquality()
                .equals(other._plusOneOrder, _plusOneOrder) &&
            const DeepCollectionEquality()
                .equals(other._plusTwoOrder, _plusTwoOrder) &&
            const DeepCollectionEquality()
                .equals(other._raceAttributeBonuses, _raceAttributeBonuses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_assignedAttributes),
      const DeepCollectionEquality().hash(_bonusesPlusOne),
      const DeepCollectionEquality().hash(_bonusesPlusTwo),
      const DeepCollectionEquality().hash(_attributeValues),
      const DeepCollectionEquality().hash(_remainingValues),
      const DeepCollectionEquality().hash(_plusOneOrder),
      const DeepCollectionEquality().hash(_plusTwoOrder),
      const DeepCollectionEquality().hash(_raceAttributeBonuses));

  @override
  String toString() {
    return 'DefaultSelectionStateModel(assignedAttributes: $assignedAttributes, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, attributeValues: $attributeValues, remainingValues: $remainingValues, plusOneOrder: $plusOneOrder, plusTwoOrder: $plusTwoOrder, raceAttributeBonuses: $raceAttributeBonuses)';
  }
}

/// @nodoc
abstract mixin class _$DefaultSelectionStateModelCopyWith<$Res>
    implements $DefaultSelectionStateModelCopyWith<$Res> {
  factory _$DefaultSelectionStateModelCopyWith(
          _DefaultSelectionStateModel value,
          $Res Function(_DefaultSelectionStateModel) _then) =
      __$DefaultSelectionStateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Map<Attribute, int> assignedAttributes,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
      List<int> attributeValues,
      List<int> remainingValues,
      List<Attribute> plusOneOrder,
      List<Attribute> plusTwoOrder,
      Map<Attribute, int> raceAttributeBonuses});
}

/// @nodoc
class __$DefaultSelectionStateModelCopyWithImpl<$Res>
    implements _$DefaultSelectionStateModelCopyWith<$Res> {
  __$DefaultSelectionStateModelCopyWithImpl(this._self, this._then);

  final _DefaultSelectionStateModel _self;
  final $Res Function(_DefaultSelectionStateModel) _then;

  /// Create a copy of DefaultSelectionStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assignedAttributes = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? attributeValues = null,
    Object? remainingValues = null,
    Object? plusOneOrder = null,
    Object? plusTwoOrder = null,
    Object? raceAttributeBonuses = null,
  }) {
    return _then(_DefaultSelectionStateModel(
      assignedAttributes: null == assignedAttributes
          ? _self._assignedAttributes
          : assignedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
      bonusesPlusOne: null == bonusesPlusOne
          ? _self._bonusesPlusOne
          : bonusesPlusOne // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
      bonusesPlusTwo: null == bonusesPlusTwo
          ? _self._bonusesPlusTwo
          : bonusesPlusTwo // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
      attributeValues: null == attributeValues
          ? _self._attributeValues
          : attributeValues // ignore: cast_nullable_to_non_nullable
              as List<int>,
      remainingValues: null == remainingValues
          ? _self._remainingValues
          : remainingValues // ignore: cast_nullable_to_non_nullable
              as List<int>,
      plusOneOrder: null == plusOneOrder
          ? _self._plusOneOrder
          : plusOneOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      plusTwoOrder: null == plusTwoOrder
          ? _self._plusTwoOrder
          : plusTwoOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      raceAttributeBonuses: null == raceAttributeBonuses
          ? _self._raceAttributeBonuses
          : raceAttributeBonuses // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
    ));
  }
}

// dart format on
