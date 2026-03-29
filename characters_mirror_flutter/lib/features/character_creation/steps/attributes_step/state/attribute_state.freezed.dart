// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttributeStateModel {
  SelectType get selectionType;
  Map<Attribute, int> get assignedAttributes;
  Map<Attribute, bool> get bonusesPlusOne;
  Map<Attribute, bool> get bonusesPlusTwo;
  List<Attribute> get plusOneOrder;
  List<Attribute> get plusTwoOrder;
  List<int?> get remainingValues;
  List<RollBoxState> get boxStates;
  int get purchacePoints;
  Map<Attribute, int> get raceAttributeBonuses;

  /// Create a copy of AttributeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttributeStateModelCopyWith<AttributeStateModel> get copyWith =>
      _$AttributeStateModelCopyWithImpl<AttributeStateModel>(
          this as AttributeStateModel, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttributeStateModel &&
            (identical(other.selectionType, selectionType) ||
                other.selectionType == selectionType) &&
            const DeepCollectionEquality()
                .equals(other.assignedAttributes, assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusOne, bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusTwo, bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other.plusOneOrder, plusOneOrder) &&
            const DeepCollectionEquality()
                .equals(other.plusTwoOrder, plusTwoOrder) &&
            const DeepCollectionEquality()
                .equals(other.remainingValues, remainingValues) &&
            const DeepCollectionEquality().equals(other.boxStates, boxStates) &&
            (identical(other.purchacePoints, purchacePoints) ||
                other.purchacePoints == purchacePoints) &&
            const DeepCollectionEquality()
                .equals(other.raceAttributeBonuses, raceAttributeBonuses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectionType,
      const DeepCollectionEquality().hash(assignedAttributes),
      const DeepCollectionEquality().hash(bonusesPlusOne),
      const DeepCollectionEquality().hash(bonusesPlusTwo),
      const DeepCollectionEquality().hash(plusOneOrder),
      const DeepCollectionEquality().hash(plusTwoOrder),
      const DeepCollectionEquality().hash(remainingValues),
      const DeepCollectionEquality().hash(boxStates),
      purchacePoints,
      const DeepCollectionEquality().hash(raceAttributeBonuses));

  @override
  String toString() {
    return 'AttributeStateModel(selectionType: $selectionType, assignedAttributes: $assignedAttributes, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, plusOneOrder: $plusOneOrder, plusTwoOrder: $plusTwoOrder, remainingValues: $remainingValues, boxStates: $boxStates, purchacePoints: $purchacePoints, raceAttributeBonuses: $raceAttributeBonuses)';
  }
}

/// @nodoc
abstract mixin class $AttributeStateModelCopyWith<$Res> {
  factory $AttributeStateModelCopyWith(
          AttributeStateModel value, $Res Function(AttributeStateModel) _then) =
      _$AttributeStateModelCopyWithImpl;
  @useResult
  $Res call(
      {SelectType selectionType,
      Map<Attribute, int> assignedAttributes,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
      List<Attribute> plusOneOrder,
      List<Attribute> plusTwoOrder,
      List<int?> remainingValues,
      List<RollBoxState> boxStates,
      int purchacePoints,
      Map<Attribute, int> raceAttributeBonuses});
}

/// @nodoc
class _$AttributeStateModelCopyWithImpl<$Res>
    implements $AttributeStateModelCopyWith<$Res> {
  _$AttributeStateModelCopyWithImpl(this._self, this._then);

  final AttributeStateModel _self;
  final $Res Function(AttributeStateModel) _then;

  /// Create a copy of AttributeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectionType = null,
    Object? assignedAttributes = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? plusOneOrder = null,
    Object? plusTwoOrder = null,
    Object? remainingValues = null,
    Object? boxStates = null,
    Object? purchacePoints = null,
    Object? raceAttributeBonuses = null,
  }) {
    return _then(_self.copyWith(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
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
      plusOneOrder: null == plusOneOrder
          ? _self.plusOneOrder
          : plusOneOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      plusTwoOrder: null == plusTwoOrder
          ? _self.plusTwoOrder
          : plusTwoOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      remainingValues: null == remainingValues
          ? _self.remainingValues
          : remainingValues // ignore: cast_nullable_to_non_nullable
              as List<int?>,
      boxStates: null == boxStates
          ? _self.boxStates
          : boxStates // ignore: cast_nullable_to_non_nullable
              as List<RollBoxState>,
      purchacePoints: null == purchacePoints
          ? _self.purchacePoints
          : purchacePoints // ignore: cast_nullable_to_non_nullable
              as int,
      raceAttributeBonuses: null == raceAttributeBonuses
          ? _self.raceAttributeBonuses
          : raceAttributeBonuses // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttributeStateModel].
extension AttributeStateModelPatterns on AttributeStateModel {
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
    TResult Function(_AttributeStateModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel() when $default != null:
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
    TResult Function(_AttributeStateModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel():
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
    TResult? Function(_AttributeStateModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel() when $default != null:
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
            SelectType selectionType,
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<Attribute> plusOneOrder,
            List<Attribute> plusTwoOrder,
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints,
            Map<Attribute, int> raceAttributeBonuses)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel() when $default != null:
        return $default(
            _that.selectionType,
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.plusOneOrder,
            _that.plusTwoOrder,
            _that.remainingValues,
            _that.boxStates,
            _that.purchacePoints,
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
            SelectType selectionType,
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<Attribute> plusOneOrder,
            List<Attribute> plusTwoOrder,
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints,
            Map<Attribute, int> raceAttributeBonuses)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel():
        return $default(
            _that.selectionType,
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.plusOneOrder,
            _that.plusTwoOrder,
            _that.remainingValues,
            _that.boxStates,
            _that.purchacePoints,
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
            SelectType selectionType,
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<Attribute> plusOneOrder,
            List<Attribute> plusTwoOrder,
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints,
            Map<Attribute, int> raceAttributeBonuses)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel() when $default != null:
        return $default(
            _that.selectionType,
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.plusOneOrder,
            _that.plusTwoOrder,
            _that.remainingValues,
            _that.boxStates,
            _that.purchacePoints,
            _that.raceAttributeBonuses);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AttributeStateModel implements AttributeStateModel {
  _AttributeStateModel(
      {this.selectionType = SelectType.defaultType,
      final Map<Attribute, int> assignedAttributes = const {},
      final Map<Attribute, bool> bonusesPlusOne = const {},
      final Map<Attribute, bool> bonusesPlusTwo = const {},
      final List<Attribute> plusOneOrder = const [],
      final List<Attribute> plusTwoOrder = const [],
      final List<int?> remainingValues = const [],
      final List<RollBoxState> boxStates = const [],
      this.purchacePoints = 27,
      required final Map<Attribute, int> raceAttributeBonuses})
      : _assignedAttributes = assignedAttributes,
        _bonusesPlusOne = bonusesPlusOne,
        _bonusesPlusTwo = bonusesPlusTwo,
        _plusOneOrder = plusOneOrder,
        _plusTwoOrder = plusTwoOrder,
        _remainingValues = remainingValues,
        _boxStates = boxStates,
        _raceAttributeBonuses = raceAttributeBonuses;

  @override
  @JsonKey()
  final SelectType selectionType;
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

  final List<int?> _remainingValues;
  @override
  @JsonKey()
  List<int?> get remainingValues {
    if (_remainingValues is EqualUnmodifiableListView) return _remainingValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_remainingValues);
  }

  final List<RollBoxState> _boxStates;
  @override
  @JsonKey()
  List<RollBoxState> get boxStates {
    if (_boxStates is EqualUnmodifiableListView) return _boxStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_boxStates);
  }

  @override
  @JsonKey()
  final int purchacePoints;
  final Map<Attribute, int> _raceAttributeBonuses;
  @override
  Map<Attribute, int> get raceAttributeBonuses {
    if (_raceAttributeBonuses is EqualUnmodifiableMapView)
      return _raceAttributeBonuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_raceAttributeBonuses);
  }

  /// Create a copy of AttributeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttributeStateModelCopyWith<_AttributeStateModel> get copyWith =>
      __$AttributeStateModelCopyWithImpl<_AttributeStateModel>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttributeStateModel &&
            (identical(other.selectionType, selectionType) ||
                other.selectionType == selectionType) &&
            const DeepCollectionEquality()
                .equals(other._assignedAttributes, _assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other._bonusesPlusOne, _bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other._bonusesPlusTwo, _bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other._plusOneOrder, _plusOneOrder) &&
            const DeepCollectionEquality()
                .equals(other._plusTwoOrder, _plusTwoOrder) &&
            const DeepCollectionEquality()
                .equals(other._remainingValues, _remainingValues) &&
            const DeepCollectionEquality()
                .equals(other._boxStates, _boxStates) &&
            (identical(other.purchacePoints, purchacePoints) ||
                other.purchacePoints == purchacePoints) &&
            const DeepCollectionEquality()
                .equals(other._raceAttributeBonuses, _raceAttributeBonuses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectionType,
      const DeepCollectionEquality().hash(_assignedAttributes),
      const DeepCollectionEquality().hash(_bonusesPlusOne),
      const DeepCollectionEquality().hash(_bonusesPlusTwo),
      const DeepCollectionEquality().hash(_plusOneOrder),
      const DeepCollectionEquality().hash(_plusTwoOrder),
      const DeepCollectionEquality().hash(_remainingValues),
      const DeepCollectionEquality().hash(_boxStates),
      purchacePoints,
      const DeepCollectionEquality().hash(_raceAttributeBonuses));

  @override
  String toString() {
    return 'AttributeStateModel(selectionType: $selectionType, assignedAttributes: $assignedAttributes, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, plusOneOrder: $plusOneOrder, plusTwoOrder: $plusTwoOrder, remainingValues: $remainingValues, boxStates: $boxStates, purchacePoints: $purchacePoints, raceAttributeBonuses: $raceAttributeBonuses)';
  }
}

/// @nodoc
abstract mixin class _$AttributeStateModelCopyWith<$Res>
    implements $AttributeStateModelCopyWith<$Res> {
  factory _$AttributeStateModelCopyWith(_AttributeStateModel value,
          $Res Function(_AttributeStateModel) _then) =
      __$AttributeStateModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {SelectType selectionType,
      Map<Attribute, int> assignedAttributes,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
      List<Attribute> plusOneOrder,
      List<Attribute> plusTwoOrder,
      List<int?> remainingValues,
      List<RollBoxState> boxStates,
      int purchacePoints,
      Map<Attribute, int> raceAttributeBonuses});
}

/// @nodoc
class __$AttributeStateModelCopyWithImpl<$Res>
    implements _$AttributeStateModelCopyWith<$Res> {
  __$AttributeStateModelCopyWithImpl(this._self, this._then);

  final _AttributeStateModel _self;
  final $Res Function(_AttributeStateModel) _then;

  /// Create a copy of AttributeStateModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? selectionType = null,
    Object? assignedAttributes = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? plusOneOrder = null,
    Object? plusTwoOrder = null,
    Object? remainingValues = null,
    Object? boxStates = null,
    Object? purchacePoints = null,
    Object? raceAttributeBonuses = null,
  }) {
    return _then(_AttributeStateModel(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
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
      plusOneOrder: null == plusOneOrder
          ? _self._plusOneOrder
          : plusOneOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      plusTwoOrder: null == plusTwoOrder
          ? _self._plusTwoOrder
          : plusTwoOrder // ignore: cast_nullable_to_non_nullable
              as List<Attribute>,
      remainingValues: null == remainingValues
          ? _self._remainingValues
          : remainingValues // ignore: cast_nullable_to_non_nullable
              as List<int?>,
      boxStates: null == boxStates
          ? _self._boxStates
          : boxStates // ignore: cast_nullable_to_non_nullable
              as List<RollBoxState>,
      purchacePoints: null == purchacePoints
          ? _self.purchacePoints
          : purchacePoints // ignore: cast_nullable_to_non_nullable
              as int,
      raceAttributeBonuses: null == raceAttributeBonuses
          ? _self._raceAttributeBonuses
          : raceAttributeBonuses // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
    ));
  }
}

// dart format on
