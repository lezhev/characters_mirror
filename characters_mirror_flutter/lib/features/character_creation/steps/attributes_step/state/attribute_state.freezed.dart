// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttributeModeDraft {
  Map<Attribute, int> get assignedAttributes;
  List<int?> get remainingValues;
  List<RollBoxState> get boxStates;
  int get purchacePoints;

  /// Create a copy of AttributeModeDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttributeModeDraftCopyWith<AttributeModeDraft> get copyWith =>
      _$AttributeModeDraftCopyWithImpl<AttributeModeDraft>(
          this as AttributeModeDraft, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as AttributeModeDraft;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttributeModeDraft &&
            const DeepCollectionEquality()
                .equals(other.assignedAttributes, _this.assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.remainingValues, _this.remainingValues) &&
            const DeepCollectionEquality()
                .equals(other.boxStates, _this.boxStates) &&
            (identical(other.purchacePoints, _this.purchacePoints) ||
                other.purchacePoints == _this.purchacePoints));
  }

  @override
  int get hashCode {
    final _this = this as AttributeModeDraft;
    return Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_this.assignedAttributes),
        const DeepCollectionEquality().hash(_this.remainingValues),
        const DeepCollectionEquality().hash(_this.boxStates),
        _this.purchacePoints);
  }

  @override
  String toString() {
    final _this = this as AttributeModeDraft;
    return 'AttributeModeDraft(assignedAttributes: ${_this.assignedAttributes}, remainingValues: ${_this.remainingValues}, boxStates: ${_this.boxStates}, purchacePoints: ${_this.purchacePoints})';
  }
}

/// @nodoc
abstract mixin class $AttributeModeDraftCopyWith<$Res> {
  factory $AttributeModeDraftCopyWith(
          AttributeModeDraft value, $Res Function(AttributeModeDraft) _then) =
      _$AttributeModeDraftCopyWithImpl;
  @useResult
  $Res call(
      {Map<Attribute, int> assignedAttributes,
      List<int?> remainingValues,
      List<RollBoxState> boxStates,
      int purchacePoints});
}

/// @nodoc
class _$AttributeModeDraftCopyWithImpl<$Res>
    implements $AttributeModeDraftCopyWith<$Res> {
  _$AttributeModeDraftCopyWithImpl(this._self, this._then);

  final AttributeModeDraft _self;
  final $Res Function(AttributeModeDraft) _then;

  /// Create a copy of AttributeModeDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assignedAttributes = null,
    Object? remainingValues = null,
    Object? boxStates = null,
    Object? purchacePoints = null,
  }) {
    return _then(AttributeModeDraft(
      assignedAttributes: null == assignedAttributes
          ? _self.assignedAttributes
          : assignedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
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
    ));
  }
}

/// Adds pattern-matching-related methods to [AttributeModeDraft].
extension AttributeModeDraftPatterns on AttributeModeDraft {
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
    TResult Function(_AttributeModeDraft value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeModeDraft() when $default != null:
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
    TResult Function(_AttributeModeDraft value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeModeDraft():
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
    TResult? Function(_AttributeModeDraft value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeModeDraft() when $default != null:
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
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttributeModeDraft() when $default != null:
        return $default(_that.assignedAttributes, _that.remainingValues,
            _that.boxStates, _that.purchacePoints);
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
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeModeDraft():
        return $default(_that.assignedAttributes, _that.remainingValues,
            _that.boxStates, _that.purchacePoints);
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
            List<int?> remainingValues,
            List<RollBoxState> boxStates,
            int purchacePoints)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttributeModeDraft() when $default != null:
        return $default(_that.assignedAttributes, _that.remainingValues,
            _that.boxStates, _that.purchacePoints);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AttributeModeDraft implements AttributeModeDraft {
  const _AttributeModeDraft(
      {Map<Attribute, int> assignedAttributes = const {},
      List<int?> remainingValues = const [],
      List<RollBoxState> boxStates = const [],
      this.purchacePoints = 27})
      : _assignedAttributes = assignedAttributes,
        _remainingValues = remainingValues,
        _boxStates = boxStates;

  final Map<Attribute, int> _assignedAttributes;
  @override
  @JsonKey()
  Map<Attribute, int> get assignedAttributes {
    if (_assignedAttributes is EqualUnmodifiableMapView)
      return _assignedAttributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_assignedAttributes);
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

  /// Create a copy of AttributeModeDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttributeModeDraftCopyWith<_AttributeModeDraft> get copyWith =>
      __$AttributeModeDraftCopyWithImpl<_AttributeModeDraft>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttributeModeDraft &&
            const DeepCollectionEquality()
                .equals(other.assignedAttributes, _assignedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.remainingValues, _remainingValues) &&
            const DeepCollectionEquality()
                .equals(other.boxStates, _boxStates) &&
            (identical(other.purchacePoints, purchacePoints) ||
                other.purchacePoints == purchacePoints));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_assignedAttributes),
        const DeepCollectionEquality().hash(_remainingValues),
        const DeepCollectionEquality().hash(_boxStates),
        purchacePoints);
  }

  @override
  String toString() {
    return 'AttributeModeDraft(assignedAttributes: $assignedAttributes, remainingValues: $remainingValues, boxStates: $boxStates, purchacePoints: $purchacePoints)';
  }
}

/// @nodoc
abstract mixin class _$AttributeModeDraftCopyWith<$Res>
    implements $AttributeModeDraftCopyWith<$Res> {
  factory _$AttributeModeDraftCopyWith(
          _AttributeModeDraft value, $Res Function(_AttributeModeDraft) _then) =
      __$AttributeModeDraftCopyWithImpl;
  @override
  @useResult
  $Res call(
      {Map<Attribute, int> assignedAttributes,
      List<int?> remainingValues,
      List<RollBoxState> boxStates,
      int purchacePoints});
}

/// @nodoc
class __$AttributeModeDraftCopyWithImpl<$Res>
    implements _$AttributeModeDraftCopyWith<$Res> {
  __$AttributeModeDraftCopyWithImpl(this._self, this._then);

  final _AttributeModeDraft _self;
  final $Res Function(_AttributeModeDraft) _then;

  /// Create a copy of AttributeModeDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? assignedAttributes = null,
    Object? remainingValues = null,
    Object? boxStates = null,
    Object? purchacePoints = null,
  }) {
    return _then(_AttributeModeDraft(
      assignedAttributes: null == assignedAttributes
          ? _self._assignedAttributes
          : assignedAttributes // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, int>,
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
    ));
  }
}

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
  Map<String, String> get optionKeyByAttribute;
  Map<String, String> get attributeKeyByOption;
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
    final _this = this as AttributeBonusRule;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttributeBonusRule &&
            (identical(other.groupKey, _this.groupKey) ||
                other.groupKey == _this.groupKey) &&
            (identical(other.choiceSetId, _this.choiceSetId) ||
                other.choiceSetId == _this.choiceSetId) &&
            (identical(other.sourceType, _this.sourceType) ||
                other.sourceType == _this.sourceType) &&
            (identical(other.sourceId, _this.sourceId) ||
                other.sourceId == _this.sourceId) &&
            (identical(other.bonusValue, _this.bonusValue) ||
                other.bonusValue == _this.bonusValue) &&
            (identical(other.pickCount, _this.pickCount) ||
                other.pickCount == _this.pickCount) &&
            (identical(other.mustBeDistinct, _this.mustBeDistinct) ||
                other.mustBeDistinct == _this.mustBeDistinct) &&
            const DeepCollectionEquality()
                .equals(other.allowedAttributes, _this.allowedAttributes) &&
            const DeepCollectionEquality().equals(
                other.optionKeyByAttribute, _this.optionKeyByAttribute) &&
            const DeepCollectionEquality().equals(
                other.attributeKeyByOption, _this.attributeKeyByOption) &&
            const DeepCollectionEquality()
                .equals(other.defaultAttributes, _this.defaultAttributes));
  }

  @override
  int get hashCode {
    final _this = this as AttributeBonusRule;
    return Object.hash(
        runtimeType,
        _this.groupKey,
        _this.choiceSetId,
        _this.sourceType,
        _this.sourceId,
        _this.bonusValue,
        _this.pickCount,
        _this.mustBeDistinct,
        const DeepCollectionEquality().hash(_this.allowedAttributes),
        const DeepCollectionEquality().hash(_this.optionKeyByAttribute),
        const DeepCollectionEquality().hash(_this.attributeKeyByOption),
        const DeepCollectionEquality().hash(_this.defaultAttributes));
  }

  @override
  String toString() {
    final _this = this as AttributeBonusRule;
    return 'AttributeBonusRule(groupKey: ${_this.groupKey}, choiceSetId: ${_this.choiceSetId}, sourceType: ${_this.sourceType}, sourceId: ${_this.sourceId}, bonusValue: ${_this.bonusValue}, pickCount: ${_this.pickCount}, mustBeDistinct: ${_this.mustBeDistinct}, allowedAttributes: ${_this.allowedAttributes}, optionKeyByAttribute: ${_this.optionKeyByAttribute}, attributeKeyByOption: ${_this.attributeKeyByOption}, defaultAttributes: ${_this.defaultAttributes})';
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
      Map<String, String> optionKeyByAttribute,
      Map<String, String> attributeKeyByOption,
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
    Object? optionKeyByAttribute = null,
    Object? attributeKeyByOption = null,
    Object? defaultAttributes = null,
  }) {
    return _then(AttributeBonusRule(
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
      optionKeyByAttribute: null == optionKeyByAttribute
          ? _self.optionKeyByAttribute
          : optionKeyByAttribute // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      attributeKeyByOption: null == attributeKeyByOption
          ? _self.attributeKeyByOption
          : attributeKeyByOption // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
            Map<String, String> optionKeyByAttribute,
            Map<String, String> attributeKeyByOption,
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
            _that.optionKeyByAttribute,
            _that.attributeKeyByOption,
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
            Map<String, String> optionKeyByAttribute,
            Map<String, String> attributeKeyByOption,
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
            _that.optionKeyByAttribute,
            _that.attributeKeyByOption,
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
            Map<String, String> optionKeyByAttribute,
            Map<String, String> attributeKeyByOption,
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
            _that.optionKeyByAttribute,
            _that.attributeKeyByOption,
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
      required Set<Attribute> allowedAttributes,
      Map<String, String> optionKeyByAttribute = const {},
      Map<String, String> attributeKeyByOption = const {},
      Set<Attribute> defaultAttributes = const {}})
      : _allowedAttributes = allowedAttributes,
        _optionKeyByAttribute = optionKeyByAttribute,
        _attributeKeyByOption = attributeKeyByOption,
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

  final Map<String, String> _optionKeyByAttribute;
  @override
  @JsonKey()
  Map<String, String> get optionKeyByAttribute {
    if (_optionKeyByAttribute is EqualUnmodifiableMapView)
      return _optionKeyByAttribute;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_optionKeyByAttribute);
  }

  final Map<String, String> _attributeKeyByOption;
  @override
  @JsonKey()
  Map<String, String> get attributeKeyByOption {
    if (_attributeKeyByOption is EqualUnmodifiableMapView)
      return _attributeKeyByOption;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_attributeKeyByOption);
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
                .equals(other.allowedAttributes, _allowedAttributes) &&
            const DeepCollectionEquality()
                .equals(other.optionKeyByAttribute, _optionKeyByAttribute) &&
            const DeepCollectionEquality()
                .equals(other.attributeKeyByOption, _attributeKeyByOption) &&
            const DeepCollectionEquality()
                .equals(other.defaultAttributes, _defaultAttributes));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        groupKey,
        choiceSetId,
        sourceType,
        sourceId,
        bonusValue,
        pickCount,
        mustBeDistinct,
        const DeepCollectionEquality().hash(_allowedAttributes),
        const DeepCollectionEquality().hash(_optionKeyByAttribute),
        const DeepCollectionEquality().hash(_attributeKeyByOption),
        const DeepCollectionEquality().hash(_defaultAttributes));
  }

  @override
  String toString() {
    return 'AttributeBonusRule(groupKey: $groupKey, choiceSetId: $choiceSetId, sourceType: $sourceType, sourceId: $sourceId, bonusValue: $bonusValue, pickCount: $pickCount, mustBeDistinct: $mustBeDistinct, allowedAttributes: $allowedAttributes, optionKeyByAttribute: $optionKeyByAttribute, attributeKeyByOption: $attributeKeyByOption, defaultAttributes: $defaultAttributes)';
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
      Map<String, String> optionKeyByAttribute,
      Map<String, String> attributeKeyByOption,
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
    Object? optionKeyByAttribute = null,
    Object? attributeKeyByOption = null,
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
      optionKeyByAttribute: null == optionKeyByAttribute
          ? _self._optionKeyByAttribute
          : optionKeyByAttribute // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      attributeKeyByOption: null == attributeKeyByOption
          ? _self._attributeKeyByOption
          : attributeKeyByOption // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
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
  Map<SelectType, AttributeModeDraft> get drafts;
  AttributeBonusMode get bonusMode;
  Map<Attribute, bool> get bonusesPlusOne;
  Map<Attribute, bool> get bonusesPlusTwo;
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
    final _this = this as AttributeStateModel;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttributeStateModel &&
            (identical(other.selectionType, _this.selectionType) ||
                other.selectionType == _this.selectionType) &&
            const DeepCollectionEquality().equals(other.drafts, _this.drafts) &&
            (identical(other.bonusMode, _this.bonusMode) ||
                other.bonusMode == _this.bonusMode) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusOne, _this.bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusTwo, _this.bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other.fixedRaceBonuses, _this.fixedRaceBonuses) &&
            const DeepCollectionEquality()
                .equals(other.resolvedBonusRules, _this.resolvedBonusRules) &&
            const DeepCollectionEquality().equals(
                other.selectedBonusAttributesByRule,
                _this.selectedBonusAttributesByRule));
  }

  @override
  int get hashCode {
    final _this = this as AttributeStateModel;
    return Object.hash(
        runtimeType,
        _this.selectionType,
        const DeepCollectionEquality().hash(_this.drafts),
        _this.bonusMode,
        const DeepCollectionEquality().hash(_this.bonusesPlusOne),
        const DeepCollectionEquality().hash(_this.bonusesPlusTwo),
        const DeepCollectionEquality().hash(_this.fixedRaceBonuses),
        const DeepCollectionEquality().hash(_this.resolvedBonusRules),
        const DeepCollectionEquality()
            .hash(_this.selectedBonusAttributesByRule));
  }

  @override
  String toString() {
    final _this = this as AttributeStateModel;
    return 'AttributeStateModel(selectionType: ${_this.selectionType}, drafts: ${_this.drafts}, bonusMode: ${_this.bonusMode}, bonusesPlusOne: ${_this.bonusesPlusOne}, bonusesPlusTwo: ${_this.bonusesPlusTwo}, fixedRaceBonuses: ${_this.fixedRaceBonuses}, resolvedBonusRules: ${_this.resolvedBonusRules}, selectedBonusAttributesByRule: ${_this.selectedBonusAttributesByRule})';
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
      Map<SelectType, AttributeModeDraft> drafts,
      AttributeBonusMode bonusMode,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
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
    Object? drafts = null,
    Object? bonusMode = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? fixedRaceBonuses = null,
    Object? resolvedBonusRules = null,
    Object? selectedBonusAttributesByRule = null,
  }) {
    return _then(AttributeStateModel(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
      drafts: null == drafts
          ? _self.drafts
          : drafts // ignore: cast_nullable_to_non_nullable
              as Map<SelectType, AttributeModeDraft>,
      bonusMode: null == bonusMode
          ? _self.bonusMode
          : bonusMode // ignore: cast_nullable_to_non_nullable
              as AttributeBonusMode,
      bonusesPlusOne: null == bonusesPlusOne
          ? _self.bonusesPlusOne
          : bonusesPlusOne // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
      bonusesPlusTwo: null == bonusesPlusTwo
          ? _self.bonusesPlusTwo
          : bonusesPlusTwo // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
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
            Map<SelectType, AttributeModeDraft> drafts,
            AttributeBonusMode bonusMode,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
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
            _that.drafts,
            _that.bonusMode,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
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
            Map<SelectType, AttributeModeDraft> drafts,
            AttributeBonusMode bonusMode,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
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
            _that.drafts,
            _that.bonusMode,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
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
            Map<SelectType, AttributeModeDraft> drafts,
            AttributeBonusMode bonusMode,
            Map<Attribute, bool> bonusesPlusOne,
            Map<Attribute, bool> bonusesPlusTwo,
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
            _that.drafts,
            _that.bonusMode,
            _that.bonusesPlusOne,
            _that.bonusesPlusTwo,
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
  const _AttributeStateModel(
      {this.selectionType = SelectType.defaultType,
      Map<SelectType, AttributeModeDraft> drafts = const {},
      this.bonusMode = AttributeBonusMode.racial,
      Map<Attribute, bool> bonusesPlusOne = const {},
      Map<Attribute, bool> bonusesPlusTwo = const {},
      Map<Attribute, int> fixedRaceBonuses = const {},
      List<AttributeBonusRule> resolvedBonusRules = const [],
      Map<String, Set<Attribute>> selectedBonusAttributesByRule = const {}})
      : _drafts = drafts,
        _bonusesPlusOne = bonusesPlusOne,
        _bonusesPlusTwo = bonusesPlusTwo,
        _fixedRaceBonuses = fixedRaceBonuses,
        _resolvedBonusRules = resolvedBonusRules,
        _selectedBonusAttributesByRule = selectedBonusAttributesByRule;

  @override
  @JsonKey()
  final SelectType selectionType;
  final Map<SelectType, AttributeModeDraft> _drafts;
  @override
  @JsonKey()
  Map<SelectType, AttributeModeDraft> get drafts {
    if (_drafts is EqualUnmodifiableMapView) return _drafts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_drafts);
  }

  @override
  @JsonKey()
  final AttributeBonusMode bonusMode;
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
            const DeepCollectionEquality().equals(other.drafts, _drafts) &&
            (identical(other.bonusMode, bonusMode) ||
                other.bonusMode == bonusMode) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusOne, _bonusesPlusOne) &&
            const DeepCollectionEquality()
                .equals(other.bonusesPlusTwo, _bonusesPlusTwo) &&
            const DeepCollectionEquality()
                .equals(other.fixedRaceBonuses, _fixedRaceBonuses) &&
            const DeepCollectionEquality()
                .equals(other.resolvedBonusRules, _resolvedBonusRules) &&
            const DeepCollectionEquality().equals(
                other.selectedBonusAttributesByRule,
                _selectedBonusAttributesByRule));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        selectionType,
        const DeepCollectionEquality().hash(_drafts),
        bonusMode,
        const DeepCollectionEquality().hash(_bonusesPlusOne),
        const DeepCollectionEquality().hash(_bonusesPlusTwo),
        const DeepCollectionEquality().hash(_fixedRaceBonuses),
        const DeepCollectionEquality().hash(_resolvedBonusRules),
        const DeepCollectionEquality().hash(_selectedBonusAttributesByRule));
  }

  @override
  String toString() {
    return 'AttributeStateModel(selectionType: $selectionType, drafts: $drafts, bonusMode: $bonusMode, bonusesPlusOne: $bonusesPlusOne, bonusesPlusTwo: $bonusesPlusTwo, fixedRaceBonuses: $fixedRaceBonuses, resolvedBonusRules: $resolvedBonusRules, selectedBonusAttributesByRule: $selectedBonusAttributesByRule)';
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
      Map<SelectType, AttributeModeDraft> drafts,
      AttributeBonusMode bonusMode,
      Map<Attribute, bool> bonusesPlusOne,
      Map<Attribute, bool> bonusesPlusTwo,
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
    Object? drafts = null,
    Object? bonusMode = null,
    Object? bonusesPlusOne = null,
    Object? bonusesPlusTwo = null,
    Object? fixedRaceBonuses = null,
    Object? resolvedBonusRules = null,
    Object? selectedBonusAttributesByRule = null,
  }) {
    return _then(_AttributeStateModel(
      selectionType: null == selectionType
          ? _self.selectionType
          : selectionType // ignore: cast_nullable_to_non_nullable
              as SelectType,
      drafts: null == drafts
          ? _self._drafts
          : drafts // ignore: cast_nullable_to_non_nullable
              as Map<SelectType, AttributeModeDraft>,
      bonusMode: null == bonusMode
          ? _self.bonusMode
          : bonusMode // ignore: cast_nullable_to_non_nullable
              as AttributeBonusMode,
      bonusesPlusOne: null == bonusesPlusOne
          ? _self._bonusesPlusOne
          : bonusesPlusOne // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
      bonusesPlusTwo: null == bonusesPlusTwo
          ? _self._bonusesPlusTwo
          : bonusesPlusTwo // ignore: cast_nullable_to_non_nullable
              as Map<Attribute, bool>,
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
