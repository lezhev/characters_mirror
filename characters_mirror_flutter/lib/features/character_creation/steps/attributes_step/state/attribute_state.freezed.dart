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
mixin _$AttributeBonusRule {
  String get groupKey;
  int get choiceSetId;
  ChoiceSourceType get sourceType;
  int get sourceId;
  int get bonusValue;
  int get pickCount;
  bool get mustBeDistinct;
  Set<Attribute> get allowedAttributes;
  Set<Attribute> get defaultAttributes;

  /// Create a copy of AttributeBonusRule
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttributeBonusRuleCopyWith<AttributeBonusRule> get copyWith =>
      _$AttributeBonusRuleCopyWithImpl<AttributeBonusRule>(
          this as AttributeBonusRule, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttributeBonusRule &&
            (identical(other.groupKey, groupKey) ||
                other.groupKey == groupKey) &&
            (identical(other.choiceSetId, choiceSetId) ||
                other.choiceSetId == choiceSetId) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.bonusValue, bonusValue) ||
                other.bonusValue == bonusValue) &&
            (identical(other.pickCount, pickCount) ||
                other.pickCount == pickCount) &&
            (identical(other.mustBeDistinct, mustBeDistinct) ||
                other.mustBeDistinct == mustBeDistinct) &&
            const DeepCollectionEquality()
                .equals(other.allowedAttributes, allowedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.defaultAttributes, defaultAttributes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupKey,
      choiceSetId,
      sourceType,
      sourceId,
      bonusValue,
      pickCount,
      mustBeDistinct,
      const DeepCollectionEquality().hash(allowedAttributes),
      const DeepCollectionEquality().hash(defaultAttributes));

  @override
  String toString() {
    return 'AttributeBonusRule(groupKey: $groupKey, choiceSetId: $choiceSetId, sourceType: $sourceType, sourceId: $sourceId, bonusValue: $bonusValue, pickCount: $pickCount, mustBeDistinct: $mustBeDistinct, allowedAttributes: $allowedAttributes, defaultAttributes: $defaultAttributes)';
  }
}

/// @nodoc
abstract mixin class $AttributeBonusRuleCopyWith<$Res> {
  factory $AttributeBonusRuleCopyWith(
          AttributeBonusRule value, $Res Function(AttributeBonusRule) _then) =
      _$AttributeBonusRuleCopyWithImpl;
  @useResult
  $Res call(
      {String groupKey,
      int choiceSetId,
      ChoiceSourceType sourceType,
      int sourceId,
      int bonusValue,
      int pickCount,
      bool mustBeDistinct,
      Set<Attribute> allowedAttributes,
      Set<Attribute> defaultAttributes});
}

/// @nodoc
class _$AttributeBonusRuleCopyWithImpl<$Res>
    implements $AttributeBonusRuleCopyWith<$Res> {
  _$AttributeBonusRuleCopyWithImpl(this._self, this._then);

  final AttributeBonusRule _self;
  final $Res Function(AttributeBonusRule) _then;

  /// Create a copy of AttributeBonusRule
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? groupKey = null,
    Object? choiceSetId = null,
    Object? sourceType = null,
    Object? sourceId = null,
    Object? bonusValue = null,
    Object? pickCount = null,
    Object? mustBeDistinct = null,
    Object? allowedAttributes = null,
    Object? defaultAttributes = null,
  }) {
    return _then(_self.copyWith(
      groupKey: null == groupKey
          ? _self.groupKey
          : groupKey // ignore: cast_nullable_to_non_nullable
              as String,
      choiceSetId: null == choiceSetId
          ? _self.choiceSetId
          : choiceSetId // ignore: cast_nullable_to_non_nullable
              as int,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as ChoiceSourceType,
      sourceId: null == sourceId
          ? _self.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as int,
      bonusValue: null == bonusValue
          ? _self.bonusValue
          : bonusValue // ignore: cast_nullable_to_non_nullable
              as int,
      pickCount: null == pickCount
          ? _self.pickCount
          : pickCount // ignore: cast_nullable_to_non_nullable
              as int,
      mustBeDistinct: null == mustBeDistinct
          ? _self.mustBeDistinct
          : mustBeDistinct // ignore: cast_nullable_to_non_nullable
              as bool,
      allowedAttributes: null == allowedAttributes
          ? _self.allowedAttributes
          : allowedAttributes // ignore: cast_nullable_to_non_nullable
              as Set<Attribute>,
      defaultAttributes: null == defaultAttributes
          ? _self.defaultAttributes
          : defaultAttributes // ignore: cast_nullable_to_non_nullable
              as Set<Attribute>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttributeBonusRule].
extension AttributeBonusRulePatterns on AttributeBonusRule {
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
    TResult Function(_AttributeBonusRule value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeBonusRule() when $default != null:
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
    TResult Function(_AttributeBonusRule value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeBonusRule():
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
    TResult? Function(_AttributeBonusRule value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeBonusRule() when $default != null:
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
            String groupKey,
            int choiceSetId,
            ChoiceSourceType sourceType,
            int sourceId,
            int bonusValue,
            int pickCount,
            bool mustBeDistinct,
            Set<Attribute> allowedAttributes,
            Set<Attribute> defaultAttributes)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeBonusRule() when $default != null:
        return $default(
            _that.groupKey,
            _that.choiceSetId,
            _that.sourceType,
            _that.sourceId,
            _that.bonusValue,
            _that.pickCount,
            _that.mustBeDistinct,
            _that.allowedAttributes,
            _that.defaultAttributes);
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
            String groupKey,
            int choiceSetId,
            ChoiceSourceType sourceType,
            int sourceId,
            int bonusValue,
            int pickCount,
            bool mustBeDistinct,
            Set<Attribute> allowedAttributes,
            Set<Attribute> defaultAttributes)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeBonusRule():
        return $default(
            _that.groupKey,
            _that.choiceSetId,
            _that.sourceType,
            _that.sourceId,
            _that.bonusValue,
            _that.pickCount,
            _that.mustBeDistinct,
            _that.allowedAttributes,
            _that.defaultAttributes);
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
            String groupKey,
            int choiceSetId,
            ChoiceSourceType sourceType,
            int sourceId,
            int bonusValue,
            int pickCount,
            bool mustBeDistinct,
            Set<Attribute> allowedAttributes,
            Set<Attribute> defaultAttributes)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeBonusRule() when $default != null:
        return $default(
            _that.groupKey,
            _that.choiceSetId,
            _that.sourceType,
            _that.sourceId,
            _that.bonusValue,
            _that.pickCount,
            _that.mustBeDistinct,
            _that.allowedAttributes,
            _that.defaultAttributes);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AttributeBonusRule implements AttributeBonusRule {
  const _AttributeBonusRule(
      {required this.groupKey,
      required this.choiceSetId,
      required this.sourceType,
      required this.sourceId,
      required this.bonusValue,
      required this.pickCount,
      required this.mustBeDistinct,
      required final Set<Attribute> allowedAttributes,
      final Set<Attribute> defaultAttributes = const {}})
      : _allowedAttributes = allowedAttributes,
        _defaultAttributes = defaultAttributes;

  @override
  final String groupKey;
  @override
  final int choiceSetId;
  @override
  final ChoiceSourceType sourceType;
  @override
  final int sourceId;
  @override
  final int bonusValue;
  @override
  final int pickCount;
  @override
  final bool mustBeDistinct;
  final Set<Attribute> _allowedAttributes;
  @override
  Set<Attribute> get allowedAttributes {
    if (_allowedAttributes is EqualUnmodifiableSetView)
      return _allowedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_allowedAttributes);
  }

  final Set<Attribute> _defaultAttributes;
  @override
  @JsonKey()
  Set<Attribute> get defaultAttributes {
    if (_defaultAttributes is EqualUnmodifiableSetView)
      return _defaultAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_defaultAttributes);
  }

  /// Create a copy of AttributeBonusRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttributeBonusRuleCopyWith<_AttributeBonusRule> get copyWith =>
      __$AttributeBonusRuleCopyWithImpl<_AttributeBonusRule>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttributeBonusRule &&
            (identical(other.groupKey, groupKey) ||
                other.groupKey == groupKey) &&
            (identical(other.choiceSetId, choiceSetId) ||
                other.choiceSetId == choiceSetId) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.sourceId, sourceId) ||
                other.sourceId == sourceId) &&
            (identical(other.bonusValue, bonusValue) ||
                other.bonusValue == bonusValue) &&
            (identical(other.pickCount, pickCount) ||
                other.pickCount == pickCount) &&
            (identical(other.mustBeDistinct, mustBeDistinct) ||
                other.mustBeDistinct == mustBeDistinct) &&
            const DeepCollectionEquality()
                .equals(other._allowedAttributes, _allowedAttributes) &&
            const DeepCollectionEquality()
                .equals(other._defaultAttributes, _defaultAttributes));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      groupKey,
      choiceSetId,
      sourceType,
      sourceId,
      bonusValue,
      pickCount,
      mustBeDistinct,
      const DeepCollectionEquality().hash(_allowedAttributes),
      const DeepCollectionEquality().hash(_defaultAttributes));

  @override
  String toString() {
    return 'AttributeBonusRule(groupKey: $groupKey, choiceSetId: $choiceSetId, sourceType: $sourceType, sourceId: $sourceId, bonusValue: $bonusValue, pickCount: $pickCount, mustBeDistinct: $mustBeDistinct, allowedAttributes: $allowedAttributes, defaultAttributes: $defaultAttributes)';
  }
}

/// @nodoc
abstract mixin class _$AttributeBonusRuleCopyWith<$Res>
    implements $AttributeBonusRuleCopyWith<$Res> {
  factory _$AttributeBonusRuleCopyWith(
          _AttributeBonusRule value, $Res Function(_AttributeBonusRule) _then) =
      __$AttributeBonusRuleCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String groupKey,
      int choiceSetId,
      ChoiceSourceType sourceType,
      int sourceId,
      int bonusValue,
      int pickCount,
      bool mustBeDistinct,
      Set<Attribute> allowedAttributes,
      Set<Attribute> defaultAttributes});
}

/// @nodoc
class __$AttributeBonusRuleCopyWithImpl<$Res>
    implements _$AttributeBonusRuleCopyWith<$Res> {
  __$AttributeBonusRuleCopyWithImpl(this._self, this._then);

  final _AttributeBonusRule _self;
  final $Res Function(_AttributeBonusRule) _then;

  /// Create a copy of AttributeBonusRule
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? groupKey = null,
    Object? choiceSetId = null,
    Object? sourceType = null,
    Object? sourceId = null,
    Object? bonusValue = null,
    Object? pickCount = null,
    Object? mustBeDistinct = null,
    Object? allowedAttributes = null,
    Object? defaultAttributes = null,
  }) {
    return _then(_AttributeBonusRule(
      groupKey: null == groupKey
          ? _self.groupKey
          : groupKey // ignore: cast_nullable_to_non_nullable
              as String,
      choiceSetId: null == choiceSetId
          ? _self.choiceSetId
          : choiceSetId // ignore: cast_nullable_to_non_nullable
              as int,
      sourceType: null == sourceType
          ? _self.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as ChoiceSourceType,
      sourceId: null == sourceId
          ? _self.sourceId
          : sourceId // ignore: cast_nullable_to_non_nullable
              as int,
      bonusValue: null == bonusValue
          ? _self.bonusValue
          : bonusValue // ignore: cast_nullable_to_non_nullable
              as int,
      pickCount: null == pickCount
          ? _self.pickCount
          : pickCount // ignore: cast_nullable_to_non_nullable
              as int,
      mustBeDistinct: null == mustBeDistinct
          ? _self.mustBeDistinct
          : mustBeDistinct // ignore: cast_nullable_to_non_nullable
              as bool,
      allowedAttributes: null == allowedAttributes
          ? _self._allowedAttributes
          : allowedAttributes // ignore: cast_nullable_to_non_nullable
              as Set<Attribute>,
      defaultAttributes: null == defaultAttributes
          ? _self._defaultAttributes
          : defaultAttributes // ignore: cast_nullable_to_non_nullable
              as Set<Attribute>,
    ));
  }
}

/// @nodoc
mixin _$AttributeStateModel {
  SelectType get selectionType;
  AttributeBonusMode get bonusMode;
  Map<Attribute, int> get assignedAttributes;
  Map<Attribute, bool> get bonusesPlusOne;
  Map<Attribute, bool> get bonusesPlusTwo;
  List<int?> get remainingValues;
  List<RollBoxState> get boxStates;
  int get purchacePoints;
  Map<Attribute, int> get fixedRaceBonuses;
  List<AttributeBonusRule> get resolvedBonusRules;
  Map<String, Set<Attribute>> get selectedBonusAttributesByRule;

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
            (identical(other.bonusMode, bonusMode) ||
                other.bonusMode == bonusMode) &&
            const DeepCollectionEquality()
                .equals(other.assignedAttributes, assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusOne, bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusTwo, bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other.remainingValues, remainingValues) &&
            const DeepCollectionEquality().equals(other.boxStates, boxStates) &&
            (identical(other.purchacePoints, purchacePoints) ||
                other.purchacePoints == purchacePoints) &&
            const DeepCollectionEquality()
                .equals(other.fixedRaceBonuses, fixedRaceBonuses) &&
            const DeepCollectionEquality()
                .equals(other.resolvedBonusRules, resolvedBonusRules) &&
            const DeepCollectionEquality().equals(
                other.selectedBonusAttributesByRule,
                selectedBonusAttributesByRule));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectionType,
      bonusMode,
      const DeepCollectionEquality().hash(assignedAttributes),
      const DeepCollectionEquality().hash(bonusesPlusOne),
      const DeepCollectionEquality().hash(bonusesPlusTwo),
      const DeepCollectionEquality().hash(remainingValues),
      const DeepCollectionEquality().hash(boxStates),
      purchacePoints,
      const DeepCollectionEquality().hash(fixedRaceBonuses),
      const DeepCollectionEquality().hash(resolvedBonusRules),
      const DeepCollectionEquality().hash(selectedBonusAttributesByRule));

  @override
  String toString() {
    return 'AttributeStateModel(selectionType: $selectionType, bonusMode: $bonusMode, assignedAttributes: $assignedAttributes, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, remainingValues: $remainingValues, boxStates: $boxStates, purchacePoints: $purchacePoints, fixedRaceBonuses: $fixedRaceBonuses, resolvedBonusRules: $resolvedBonusRules, selectedBonusAttributesByRule: $selectedBonusAttributesByRule)';
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
      AttributeBonusMode bonusMode,
      Map<Attribute, int> assignedAttributes,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
      List<int?> remainingValues,
      List<RollBoxState> boxStates,
      int purchacePoints,
      Map<Attribute, int> fixedRaceBonuses,
      List<AttributeBonusRule> resolvedBonusRules,
      Map<String, Set<Attribute>> selectedBonusAttributesByRule});
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
    Object? bonusMode = null,
    Object? assignedAttributes = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? remainingValues = null,
    Object? boxStates = null,
    Object? purchacePoints = null,
    Object? fixedRaceBonuses = null,
    Object? resolvedBonusRules = null,
    Object? selectedBonusAttributesByRule = null,
  }) {
    return _then(_self.copyWith(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
      bonusMode: null == bonusMode
          ? _self.bonusMode
          : bonusMode // ignore: cast_nullable_to_non_nullable
              as AttributeBonusMode,
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
      fixedRaceBonuses: null == fixedRaceBonuses
          ? _self.fixedRaceBonuses
          : fixedRaceBonuses // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
      resolvedBonusRules: null == resolvedBonusRules
          ? _self.resolvedBonusRules
          : resolvedBonusRules // ignore: cast_nullable_to_non_nullable
              as List<AttributeBonusRule>,
      selectedBonusAttributesByRule: null == selectedBonusAttributesByRule
          ? _self.selectedBonusAttributesByRule
          : selectedBonusAttributesByRule // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<Attribute>>,
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
            AttributeBonusMode bonusMode,
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints,
            Map<Attribute, int> fixedRaceBonuses,
            List<AttributeBonusRule> resolvedBonusRules,
            Map<String, Set<Attribute>> selectedBonusAttributesByRule)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel() when $default != null:
        return $default(
            _that.selectionType,
            _that.bonusMode,
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.remainingValues,
            _that.boxStates,
            _that.purchacePoints,
            _that.fixedRaceBonuses,
            _that.resolvedBonusRules,
            _that.selectedBonusAttributesByRule);
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
            AttributeBonusMode bonusMode,
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints,
            Map<Attribute, int> fixedRaceBonuses,
            List<AttributeBonusRule> resolvedBonusRules,
            Map<String, Set<Attribute>> selectedBonusAttributesByRule)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel():
        return $default(
            _that.selectionType,
            _that.bonusMode,
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.remainingValues,
            _that.boxStates,
            _that.purchacePoints,
            _that.fixedRaceBonuses,
            _that.resolvedBonusRules,
            _that.selectedBonusAttributesByRule);
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
            AttributeBonusMode bonusMode,
            Map<Attribute, int> assignedAttributes,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints,
            Map<Attribute, int> fixedRaceBonuses,
            List<AttributeBonusRule> resolvedBonusRules,
            Map<String, Set<Attribute>> selectedBonusAttributesByRule)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeStateModel() when $default != null:
        return $default(
            _that.selectionType,
            _that.bonusMode,
            _that.assignedAttributes,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
            _that.remainingValues,
            _that.boxStates,
            _that.purchacePoints,
            _that.fixedRaceBonuses,
            _that.resolvedBonusRules,
            _that.selectedBonusAttributesByRule);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AttributeStateModel implements AttributeStateModel {
  _AttributeStateModel(
      {this.selectionType = SelectType.defaultType,
      this.bonusMode = AttributeBonusMode.racial,
      final Map<Attribute, int> assignedAttributes = const {},
      final Map<Attribute, bool> bonusesPlusOne = const {},
      final Map<Attribute, bool> bonusesPlusTwo = const {},
      final List<int?> remainingValues = const [],
      final List<RollBoxState> boxStates = const [],
      this.purchacePoints = 27,
      final Map<Attribute, int> fixedRaceBonuses = const {},
      final List<AttributeBonusRule> resolvedBonusRules = const [],
      final Map<String, Set<Attribute>> selectedBonusAttributesByRule =
          const {}})
      : _assignedAttributes = assignedAttributes,
        _bonusesPlusOne = bonusesPlusOne,
        _bonusesPlusTwo = bonusesPlusTwo,
        _remainingValues = remainingValues,
        _boxStates = boxStates,
        _fixedRaceBonuses = fixedRaceBonuses,
        _resolvedBonusRules = resolvedBonusRules,
        _selectedBonusAttributesByRule = selectedBonusAttributesByRule;

  @override
  @JsonKey()
  final SelectType selectionType;
  @override
  @JsonKey()
  final AttributeBonusMode bonusMode;
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
  final Map<Attribute, int> _fixedRaceBonuses;
  @override
  @JsonKey()
  Map<Attribute, int> get fixedRaceBonuses {
    if (_fixedRaceBonuses is EqualUnmodifiableMapView) return _fixedRaceBonuses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fixedRaceBonuses);
  }

  final List<AttributeBonusRule> _resolvedBonusRules;
  @override
  @JsonKey()
  List<AttributeBonusRule> get resolvedBonusRules {
    if (_resolvedBonusRules is EqualUnmodifiableListView)
      return _resolvedBonusRules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resolvedBonusRules);
  }

  final Map<String, Set<Attribute>> _selectedBonusAttributesByRule;
  @override
  @JsonKey()
  Map<String, Set<Attribute>> get selectedBonusAttributesByRule {
    if (_selectedBonusAttributesByRule is EqualUnmodifiableMapView)
      return _selectedBonusAttributesByRule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedBonusAttributesByRule);
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
            (identical(other.bonusMode, bonusMode) ||
                other.bonusMode == bonusMode) &&
            const DeepCollectionEquality()
                .equals(other._assignedAttributes, _assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other._bonusesPlusOne, _bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other._bonusesPlusTwo, _bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other._remainingValues, _remainingValues) &&
            const DeepCollectionEquality()
                .equals(other._boxStates, _boxStates) &&
            (identical(other.purchacePoints, purchacePoints) ||
                other.purchacePoints == purchacePoints) &&
            const DeepCollectionEquality()
                .equals(other._fixedRaceBonuses, _fixedRaceBonuses) &&
            const DeepCollectionEquality()
                .equals(other._resolvedBonusRules, _resolvedBonusRules) &&
            const DeepCollectionEquality().equals(
                other._selectedBonusAttributesByRule,
                _selectedBonusAttributesByRule));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectionType,
      bonusMode,
      const DeepCollectionEquality().hash(_assignedAttributes),
      const DeepCollectionEquality().hash(_bonusesPlusOne),
      const DeepCollectionEquality().hash(_bonusesPlusTwo),
      const DeepCollectionEquality().hash(_remainingValues),
      const DeepCollectionEquality().hash(_boxStates),
      purchacePoints,
      const DeepCollectionEquality().hash(_fixedRaceBonuses),
      const DeepCollectionEquality().hash(_resolvedBonusRules),
      const DeepCollectionEquality().hash(_selectedBonusAttributesByRule));

  @override
  String toString() {
    return 'AttributeStateModel(selectionType: $selectionType, bonusMode: $bonusMode, assignedAttributes: $assignedAttributes, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, remainingValues: $remainingValues, boxStates: $boxStates, purchacePoints: $purchacePoints, fixedRaceBonuses: $fixedRaceBonuses, resolvedBonusRules: $resolvedBonusRules, selectedBonusAttributesByRule: $selectedBonusAttributesByRule)';
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
      AttributeBonusMode bonusMode,
      Map<Attribute, int> assignedAttributes,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
      List<int?> remainingValues,
      List<RollBoxState> boxStates,
      int purchacePoints,
      Map<Attribute, int> fixedRaceBonuses,
      List<AttributeBonusRule> resolvedBonusRules,
      Map<String, Set<Attribute>> selectedBonusAttributesByRule});
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
    Object? bonusMode = null,
    Object? assignedAttributes = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? remainingValues = null,
    Object? boxStates = null,
    Object? purchacePoints = null,
    Object? fixedRaceBonuses = null,
    Object? resolvedBonusRules = null,
    Object? selectedBonusAttributesByRule = null,
  }) {
    return _then(_AttributeStateModel(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
      bonusMode: null == bonusMode
          ? _self.bonusMode
          : bonusMode // ignore: cast_nullable_to_non_nullable
              as AttributeBonusMode,
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
      fixedRaceBonuses: null == fixedRaceBonuses
          ? _self._fixedRaceBonuses
          : fixedRaceBonuses // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
      resolvedBonusRules: null == resolvedBonusRules
          ? _self._resolvedBonusRules
          : resolvedBonusRules // ignore: cast_nullable_to_non_nullable
              as List<AttributeBonusRule>,
      selectedBonusAttributesByRule: null == selectedBonusAttributesByRule
          ? _self._selectedBonusAttributesByRule
          : selectedBonusAttributesByRule // ignore: cast_nullable_to_non_nullable
              as Map<String, Set<Attribute>>,
    ));
  }
}

// dart format on
