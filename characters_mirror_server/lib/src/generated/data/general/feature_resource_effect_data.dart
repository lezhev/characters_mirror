/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../data/general/class/class_feature_data.dart' as _i2;
import '../../data/general/class/subclass_feature_data.dart' as _i3;
import '../../data/general/race/race_feature_data.dart' as _i4;
import '../../enums/feature_resource_effect_type.dart' as _i5;
import '../../enums/feature_resource_target_type.dart' as _i6;
import '../../enums/character_feature_source_type.dart' as _i7;
import '../../enums/feature_resource_max_rule.dart' as _i8;
import '../../enums/ability.dart' as _i9;
import '../../enums/feature_resource_trigger.dart' as _i10;
import '../../enums/rest_type.dart' as _i11;

abstract class FeatureResourceEffectData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  FeatureResourceEffectData._({
    this.id,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    this.raceFeatureId,
    this.raceFeature,
    required this.type,
    this.targetType,
    this.targetResourceKey,
    this.targetSourceType,
    this.targetSourceId,
    this.amountRule,
    this.amountValue,
    this.amountAbility,
    this.activationTrigger,
    this.usageResetOn,
    this.setResetOn,
    this.setMaxRule,
    this.setMaxValue,
    this.setMaxAbility,
    this.addMaxValue,
    this.setUnlimited,
    this.becomesUnlimitedAtLevel,
  });

  factory FeatureResourceEffectData({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    required _i5.FeatureResourceEffectType type,
    _i6.FeatureResourceTargetType? targetType,
    String? targetResourceKey,
    _i7.CharacterFeatureSourceType? targetSourceType,
    int? targetSourceId,
    _i8.FeatureResourceMaxRule? amountRule,
    int? amountValue,
    _i9.Ability? amountAbility,
    _i10.FeatureResourceTrigger? activationTrigger,
    _i11.RestType? usageResetOn,
    _i11.RestType? setResetOn,
    _i8.FeatureResourceMaxRule? setMaxRule,
    int? setMaxValue,
    _i9.Ability? setMaxAbility,
    int? addMaxValue,
    bool? setUnlimited,
    int? becomesUnlimitedAtLevel,
  }) = _FeatureResourceEffectDataImpl;

  factory FeatureResourceEffectData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureResourceEffectData(
      id: jsonSerialization['id'] as int?,
      classFeatureId: jsonSerialization['classFeatureId'] as int?,
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _i2.ClassFeatureData.fromJson(
              (jsonSerialization['classFeature'] as Map<String, dynamic>)),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['subclassFeature'] as Map<String, dynamic>)),
      raceFeatureId: jsonSerialization['raceFeatureId'] as int?,
      raceFeature: jsonSerialization['raceFeature'] == null
          ? null
          : _i4.RaceFeatureData.fromJson(
              (jsonSerialization['raceFeature'] as Map<String, dynamic>)),
      type: _i5.FeatureResourceEffectType.fromJson(
          (jsonSerialization['type'] as String)),
      targetType: jsonSerialization['targetType'] == null
          ? null
          : _i6.FeatureResourceTargetType.fromJson(
              (jsonSerialization['targetType'] as String)),
      targetResourceKey: jsonSerialization['targetResourceKey'] as String?,
      targetSourceType: jsonSerialization['targetSourceType'] == null
          ? null
          : _i7.CharacterFeatureSourceType.fromJson(
              (jsonSerialization['targetSourceType'] as String)),
      targetSourceId: jsonSerialization['targetSourceId'] as int?,
      amountRule: jsonSerialization['amountRule'] == null
          ? null
          : _i8.FeatureResourceMaxRule.fromJson(
              (jsonSerialization['amountRule'] as String)),
      amountValue: jsonSerialization['amountValue'] as int?,
      amountAbility: jsonSerialization['amountAbility'] == null
          ? null
          : _i9.Ability.fromJson(
              (jsonSerialization['amountAbility'] as String)),
      activationTrigger: jsonSerialization['activationTrigger'] == null
          ? null
          : _i10.FeatureResourceTrigger.fromJson(
              (jsonSerialization['activationTrigger'] as String)),
      usageResetOn: jsonSerialization['usageResetOn'] == null
          ? null
          : _i11.RestType.fromJson(
              (jsonSerialization['usageResetOn'] as String)),
      setResetOn: jsonSerialization['setResetOn'] == null
          ? null
          : _i11.RestType.fromJson((jsonSerialization['setResetOn'] as String)),
      setMaxRule: jsonSerialization['setMaxRule'] == null
          ? null
          : _i8.FeatureResourceMaxRule.fromJson(
              (jsonSerialization['setMaxRule'] as String)),
      setMaxValue: jsonSerialization['setMaxValue'] as int?,
      setMaxAbility: jsonSerialization['setMaxAbility'] == null
          ? null
          : _i9.Ability.fromJson(
              (jsonSerialization['setMaxAbility'] as String)),
      addMaxValue: jsonSerialization['addMaxValue'] as int?,
      setUnlimited: jsonSerialization['setUnlimited'] as bool?,
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
    );
  }

  static final t = FeatureResourceEffectDataTable();

  static const db = FeatureResourceEffectDataRepository._();

  @override
  int? id;

  int? classFeatureId;

  _i2.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i3.SubclassFeatureData? subclassFeature;

  int? raceFeatureId;

  _i4.RaceFeatureData? raceFeature;

  _i5.FeatureResourceEffectType type;

  _i6.FeatureResourceTargetType? targetType;

  String? targetResourceKey;

  _i7.CharacterFeatureSourceType? targetSourceType;

  int? targetSourceId;

  _i8.FeatureResourceMaxRule? amountRule;

  int? amountValue;

  _i9.Ability? amountAbility;

  _i10.FeatureResourceTrigger? activationTrigger;

  _i11.RestType? usageResetOn;

  _i11.RestType? setResetOn;

  _i8.FeatureResourceMaxRule? setMaxRule;

  int? setMaxValue;

  _i9.Ability? setMaxAbility;

  int? addMaxValue;

  bool? setUnlimited;

  int? becomesUnlimitedAtLevel;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureResourceEffectData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureResourceEffectData copyWith({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    _i5.FeatureResourceEffectType? type,
    _i6.FeatureResourceTargetType? targetType,
    String? targetResourceKey,
    _i7.CharacterFeatureSourceType? targetSourceType,
    int? targetSourceId,
    _i8.FeatureResourceMaxRule? amountRule,
    int? amountValue,
    _i9.Ability? amountAbility,
    _i10.FeatureResourceTrigger? activationTrigger,
    _i11.RestType? usageResetOn,
    _i11.RestType? setResetOn,
    _i8.FeatureResourceMaxRule? setMaxRule,
    int? setMaxValue,
    _i9.Ability? setMaxAbility,
    int? addMaxValue,
    bool? setUnlimited,
    int? becomesUnlimitedAtLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJson(),
      'type': type.toJson(),
      if (targetType != null) 'targetType': targetType?.toJson(),
      if (targetResourceKey != null) 'targetResourceKey': targetResourceKey,
      if (targetSourceType != null)
        'targetSourceType': targetSourceType?.toJson(),
      if (targetSourceId != null) 'targetSourceId': targetSourceId,
      if (amountRule != null) 'amountRule': amountRule?.toJson(),
      if (amountValue != null) 'amountValue': amountValue,
      if (amountAbility != null) 'amountAbility': amountAbility?.toJson(),
      if (activationTrigger != null)
        'activationTrigger': activationTrigger?.toJson(),
      if (usageResetOn != null) 'usageResetOn': usageResetOn?.toJson(),
      if (setResetOn != null) 'setResetOn': setResetOn?.toJson(),
      if (setMaxRule != null) 'setMaxRule': setMaxRule?.toJson(),
      if (setMaxValue != null) 'setMaxValue': setMaxValue,
      if (setMaxAbility != null) 'setMaxAbility': setMaxAbility?.toJson(),
      if (addMaxValue != null) 'addMaxValue': addMaxValue,
      if (setUnlimited != null) 'setUnlimited': setUnlimited,
      if (becomesUnlimitedAtLevel != null)
        'becomesUnlimitedAtLevel': becomesUnlimitedAtLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJsonForProtocol(),
      'type': type.toJson(),
      if (targetType != null) 'targetType': targetType?.toJson(),
      if (targetResourceKey != null) 'targetResourceKey': targetResourceKey,
      if (targetSourceType != null)
        'targetSourceType': targetSourceType?.toJson(),
      if (targetSourceId != null) 'targetSourceId': targetSourceId,
      if (amountRule != null) 'amountRule': amountRule?.toJson(),
      if (amountValue != null) 'amountValue': amountValue,
      if (amountAbility != null) 'amountAbility': amountAbility?.toJson(),
      if (activationTrigger != null)
        'activationTrigger': activationTrigger?.toJson(),
      if (usageResetOn != null) 'usageResetOn': usageResetOn?.toJson(),
      if (setResetOn != null) 'setResetOn': setResetOn?.toJson(),
      if (setMaxRule != null) 'setMaxRule': setMaxRule?.toJson(),
      if (setMaxValue != null) 'setMaxValue': setMaxValue,
      if (setMaxAbility != null) 'setMaxAbility': setMaxAbility?.toJson(),
      if (addMaxValue != null) 'addMaxValue': addMaxValue,
      if (setUnlimited != null) 'setUnlimited': setUnlimited,
      if (becomesUnlimitedAtLevel != null)
        'becomesUnlimitedAtLevel': becomesUnlimitedAtLevel,
    };
  }

  static FeatureResourceEffectDataInclude include({
    _i2.ClassFeatureDataInclude? classFeature,
    _i3.SubclassFeatureDataInclude? subclassFeature,
    _i4.RaceFeatureDataInclude? raceFeature,
  }) {
    return FeatureResourceEffectDataInclude._(
      classFeature: classFeature,
      subclassFeature: subclassFeature,
      raceFeature: raceFeature,
    );
  }

  static FeatureResourceEffectDataIncludeList includeList({
    _i1.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    FeatureResourceEffectDataInclude? include,
  }) {
    return FeatureResourceEffectDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceEffectDataImpl extends FeatureResourceEffectData {
  _FeatureResourceEffectDataImpl({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    required _i5.FeatureResourceEffectType type,
    _i6.FeatureResourceTargetType? targetType,
    String? targetResourceKey,
    _i7.CharacterFeatureSourceType? targetSourceType,
    int? targetSourceId,
    _i8.FeatureResourceMaxRule? amountRule,
    int? amountValue,
    _i9.Ability? amountAbility,
    _i10.FeatureResourceTrigger? activationTrigger,
    _i11.RestType? usageResetOn,
    _i11.RestType? setResetOn,
    _i8.FeatureResourceMaxRule? setMaxRule,
    int? setMaxValue,
    _i9.Ability? setMaxAbility,
    int? addMaxValue,
    bool? setUnlimited,
    int? becomesUnlimitedAtLevel,
  }) : super._(
          id: id,
          classFeatureId: classFeatureId,
          classFeature: classFeature,
          subclassFeatureId: subclassFeatureId,
          subclassFeature: subclassFeature,
          raceFeatureId: raceFeatureId,
          raceFeature: raceFeature,
          type: type,
          targetType: targetType,
          targetResourceKey: targetResourceKey,
          targetSourceType: targetSourceType,
          targetSourceId: targetSourceId,
          amountRule: amountRule,
          amountValue: amountValue,
          amountAbility: amountAbility,
          activationTrigger: activationTrigger,
          usageResetOn: usageResetOn,
          setResetOn: setResetOn,
          setMaxRule: setMaxRule,
          setMaxValue: setMaxValue,
          setMaxAbility: setMaxAbility,
          addMaxValue: addMaxValue,
          setUnlimited: setUnlimited,
          becomesUnlimitedAtLevel: becomesUnlimitedAtLevel,
        );

  /// Returns a shallow copy of this [FeatureResourceEffectData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureResourceEffectData copyWith({
    Object? id = _Undefined,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    Object? raceFeatureId = _Undefined,
    Object? raceFeature = _Undefined,
    _i5.FeatureResourceEffectType? type,
    Object? targetType = _Undefined,
    Object? targetResourceKey = _Undefined,
    Object? targetSourceType = _Undefined,
    Object? targetSourceId = _Undefined,
    Object? amountRule = _Undefined,
    Object? amountValue = _Undefined,
    Object? amountAbility = _Undefined,
    Object? activationTrigger = _Undefined,
    Object? usageResetOn = _Undefined,
    Object? setResetOn = _Undefined,
    Object? setMaxRule = _Undefined,
    Object? setMaxValue = _Undefined,
    Object? setMaxAbility = _Undefined,
    Object? addMaxValue = _Undefined,
    Object? setUnlimited = _Undefined,
    Object? becomesUnlimitedAtLevel = _Undefined,
  }) {
    return FeatureResourceEffectData(
      id: id is int? ? id : this.id,
      classFeatureId:
          classFeatureId is int? ? classFeatureId : this.classFeatureId,
      classFeature: classFeature is _i2.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i3.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      raceFeatureId: raceFeatureId is int? ? raceFeatureId : this.raceFeatureId,
      raceFeature: raceFeature is _i4.RaceFeatureData?
          ? raceFeature
          : this.raceFeature?.copyWith(),
      type: type ?? this.type,
      targetType: targetType is _i6.FeatureResourceTargetType?
          ? targetType
          : this.targetType,
      targetResourceKey: targetResourceKey is String?
          ? targetResourceKey
          : this.targetResourceKey,
      targetSourceType: targetSourceType is _i7.CharacterFeatureSourceType?
          ? targetSourceType
          : this.targetSourceType,
      targetSourceId:
          targetSourceId is int? ? targetSourceId : this.targetSourceId,
      amountRule: amountRule is _i8.FeatureResourceMaxRule?
          ? amountRule
          : this.amountRule,
      amountValue: amountValue is int? ? amountValue : this.amountValue,
      amountAbility:
          amountAbility is _i9.Ability? ? amountAbility : this.amountAbility,
      activationTrigger: activationTrigger is _i10.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
      usageResetOn:
          usageResetOn is _i11.RestType? ? usageResetOn : this.usageResetOn,
      setResetOn: setResetOn is _i11.RestType? ? setResetOn : this.setResetOn,
      setMaxRule: setMaxRule is _i8.FeatureResourceMaxRule?
          ? setMaxRule
          : this.setMaxRule,
      setMaxValue: setMaxValue is int? ? setMaxValue : this.setMaxValue,
      setMaxAbility:
          setMaxAbility is _i9.Ability? ? setMaxAbility : this.setMaxAbility,
      addMaxValue: addMaxValue is int? ? addMaxValue : this.addMaxValue,
      setUnlimited: setUnlimited is bool? ? setUnlimited : this.setUnlimited,
      becomesUnlimitedAtLevel: becomesUnlimitedAtLevel is int?
          ? becomesUnlimitedAtLevel
          : this.becomesUnlimitedAtLevel,
    );
  }
}

class FeatureResourceEffectDataTable extends _i1.Table<int?> {
  FeatureResourceEffectDataTable({super.tableRelation})
      : super(tableName: 'feature_resource_effect_data') {
    classFeatureId = _i1.ColumnInt(
      'classFeatureId',
      this,
    );
    subclassFeatureId = _i1.ColumnInt(
      'subclassFeatureId',
      this,
    );
    raceFeatureId = _i1.ColumnInt(
      'raceFeatureId',
      this,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    targetType = _i1.ColumnEnum(
      'targetType',
      this,
      _i1.EnumSerialization.byName,
    );
    targetResourceKey = _i1.ColumnString(
      'targetResourceKey',
      this,
    );
    targetSourceType = _i1.ColumnEnum(
      'targetSourceType',
      this,
      _i1.EnumSerialization.byName,
    );
    targetSourceId = _i1.ColumnInt(
      'targetSourceId',
      this,
    );
    amountRule = _i1.ColumnEnum(
      'amountRule',
      this,
      _i1.EnumSerialization.byName,
    );
    amountValue = _i1.ColumnInt(
      'amountValue',
      this,
    );
    amountAbility = _i1.ColumnEnum(
      'amountAbility',
      this,
      _i1.EnumSerialization.byName,
    );
    activationTrigger = _i1.ColumnEnum(
      'activationTrigger',
      this,
      _i1.EnumSerialization.byName,
    );
    usageResetOn = _i1.ColumnEnum(
      'usageResetOn',
      this,
      _i1.EnumSerialization.byName,
    );
    setResetOn = _i1.ColumnEnum(
      'setResetOn',
      this,
      _i1.EnumSerialization.byName,
    );
    setMaxRule = _i1.ColumnEnum(
      'setMaxRule',
      this,
      _i1.EnumSerialization.byName,
    );
    setMaxValue = _i1.ColumnInt(
      'setMaxValue',
      this,
    );
    setMaxAbility = _i1.ColumnEnum(
      'setMaxAbility',
      this,
      _i1.EnumSerialization.byName,
    );
    addMaxValue = _i1.ColumnInt(
      'addMaxValue',
      this,
    );
    setUnlimited = _i1.ColumnBool(
      'setUnlimited',
      this,
    );
    becomesUnlimitedAtLevel = _i1.ColumnInt(
      'becomesUnlimitedAtLevel',
      this,
    );
  }

  late final _i1.ColumnInt classFeatureId;

  _i2.ClassFeatureDataTable? _classFeature;

  late final _i1.ColumnInt subclassFeatureId;

  _i3.SubclassFeatureDataTable? _subclassFeature;

  late final _i1.ColumnInt raceFeatureId;

  _i4.RaceFeatureDataTable? _raceFeature;

  late final _i1.ColumnEnum<_i5.FeatureResourceEffectType> type;

  late final _i1.ColumnEnum<_i6.FeatureResourceTargetType> targetType;

  late final _i1.ColumnString targetResourceKey;

  late final _i1.ColumnEnum<_i7.CharacterFeatureSourceType> targetSourceType;

  late final _i1.ColumnInt targetSourceId;

  late final _i1.ColumnEnum<_i8.FeatureResourceMaxRule> amountRule;

  late final _i1.ColumnInt amountValue;

  late final _i1.ColumnEnum<_i9.Ability> amountAbility;

  late final _i1.ColumnEnum<_i10.FeatureResourceTrigger> activationTrigger;

  late final _i1.ColumnEnum<_i11.RestType> usageResetOn;

  late final _i1.ColumnEnum<_i11.RestType> setResetOn;

  late final _i1.ColumnEnum<_i8.FeatureResourceMaxRule> setMaxRule;

  late final _i1.ColumnInt setMaxValue;

  late final _i1.ColumnEnum<_i9.Ability> setMaxAbility;

  late final _i1.ColumnInt addMaxValue;

  late final _i1.ColumnBool setUnlimited;

  late final _i1.ColumnInt becomesUnlimitedAtLevel;

  _i2.ClassFeatureDataTable get classFeature {
    if (_classFeature != null) return _classFeature!;
    _classFeature = _i1.createRelationTable(
      relationFieldName: 'classFeature',
      field: FeatureResourceEffectData.t.classFeatureId,
      foreignField: _i2.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _classFeature!;
  }

  _i3.SubclassFeatureDataTable get subclassFeature {
    if (_subclassFeature != null) return _subclassFeature!;
    _subclassFeature = _i1.createRelationTable(
      relationFieldName: 'subclassFeature',
      field: FeatureResourceEffectData.t.subclassFeatureId,
      foreignField: _i3.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SubclassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _subclassFeature!;
  }

  _i4.RaceFeatureDataTable get raceFeature {
    if (_raceFeature != null) return _raceFeature!;
    _raceFeature = _i1.createRelationTable(
      relationFieldName: 'raceFeature',
      field: FeatureResourceEffectData.t.raceFeatureId,
      foreignField: _i4.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _raceFeature!;
  }

  @override
  List<_i1.Column> get columns => [
        id,
        classFeatureId,
        subclassFeatureId,
        raceFeatureId,
        type,
        targetType,
        targetResourceKey,
        targetSourceType,
        targetSourceId,
        amountRule,
        amountValue,
        amountAbility,
        activationTrigger,
        usageResetOn,
        setResetOn,
        setMaxRule,
        setMaxValue,
        setMaxAbility,
        addMaxValue,
        setUnlimited,
        becomesUnlimitedAtLevel,
      ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'classFeature') {
      return classFeature;
    }
    if (relationField == 'subclassFeature') {
      return subclassFeature;
    }
    if (relationField == 'raceFeature') {
      return raceFeature;
    }
    return null;
  }
}

class FeatureResourceEffectDataInclude extends _i1.IncludeObject {
  FeatureResourceEffectDataInclude._({
    _i2.ClassFeatureDataInclude? classFeature,
    _i3.SubclassFeatureDataInclude? subclassFeature,
    _i4.RaceFeatureDataInclude? raceFeature,
  }) {
    _classFeature = classFeature;
    _subclassFeature = subclassFeature;
    _raceFeature = raceFeature;
  }

  _i2.ClassFeatureDataInclude? _classFeature;

  _i3.SubclassFeatureDataInclude? _subclassFeature;

  _i4.RaceFeatureDataInclude? _raceFeature;

  @override
  Map<String, _i1.Include?> get includes => {
        'classFeature': _classFeature,
        'subclassFeature': _subclassFeature,
        'raceFeature': _raceFeature,
      };

  @override
  _i1.Table<int?> get table => FeatureResourceEffectData.t;
}

class FeatureResourceEffectDataIncludeList extends _i1.IncludeList {
  FeatureResourceEffectDataIncludeList._({
    _i1.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureResourceEffectData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => FeatureResourceEffectData.t;
}

class FeatureResourceEffectDataRepository {
  const FeatureResourceEffectDataRepository._();

  final attachRow = const FeatureResourceEffectDataAttachRowRepository._();

  final detachRow = const FeatureResourceEffectDataDetachRowRepository._();

  /// Returns a list of [FeatureResourceEffectData]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<FeatureResourceEffectData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureResourceEffectDataInclude? include,
  }) async {
    return session.db.find<FeatureResourceEffectData>(
      where: where?.call(FeatureResourceEffectData.t),
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [FeatureResourceEffectData] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<FeatureResourceEffectData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _i1.Transaction? transaction,
    FeatureResourceEffectDataInclude? include,
  }) async {
    return session.db.findFirstRow<FeatureResourceEffectData>(
      where: where?.call(FeatureResourceEffectData.t),
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [FeatureResourceEffectData] by its [id] or null if no such row exists.
  Future<FeatureResourceEffectData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    FeatureResourceEffectDataInclude? include,
  }) async {
    return session.db.findById<FeatureResourceEffectData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [FeatureResourceEffectData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureResourceEffectData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<FeatureResourceEffectData>> insert(
    _i1.Session session,
    List<FeatureResourceEffectData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<FeatureResourceEffectData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [FeatureResourceEffectData] and returns the inserted row.
  ///
  /// The returned [FeatureResourceEffectData] will have its `id` field set.
  Future<FeatureResourceEffectData> insertRow(
    _i1.Session session,
    FeatureResourceEffectData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureResourceEffectData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceEffectData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<FeatureResourceEffectData>> update(
    _i1.Session session,
    List<FeatureResourceEffectData> rows, {
    _i1.ColumnSelections<FeatureResourceEffectDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<FeatureResourceEffectData>(
      rows,
      columns: columns?.call(FeatureResourceEffectData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureResourceEffectData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureResourceEffectData> updateRow(
    _i1.Session session,
    FeatureResourceEffectData row, {
    _i1.ColumnSelections<FeatureResourceEffectDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureResourceEffectData>(
      row,
      columns: columns?.call(FeatureResourceEffectData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [FeatureResourceEffectData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<FeatureResourceEffectData>> delete(
    _i1.Session session,
    List<FeatureResourceEffectData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<FeatureResourceEffectData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [FeatureResourceEffectData].
  Future<FeatureResourceEffectData> deleteRow(
    _i1.Session session,
    FeatureResourceEffectData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureResourceEffectData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<FeatureResourceEffectData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<FeatureResourceEffectDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<FeatureResourceEffectData>(
      where: where(FeatureResourceEffectData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<FeatureResourceEffectData>(
      where: where?.call(FeatureResourceEffectData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class FeatureResourceEffectDataAttachRowRepository {
  const FeatureResourceEffectDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureResourceEffectData] and [ClassFeatureData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to refer to the [ClassFeatureData].
  Future<void> classFeature(
    _i1.Session session,
    FeatureResourceEffectData featureResourceEffectData,
    _i2.ClassFeatureData classFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (classFeature.id == null) {
      throw ArgumentError.notNull('classFeature.id');
    }

    var $featureResourceEffectData =
        featureResourceEffectData.copyWith(classFeatureId: classFeature.id);
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceEffectData] and [SubclassFeatureData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> subclassFeature(
    _i1.Session session,
    FeatureResourceEffectData featureResourceEffectData,
    _i3.SubclassFeatureData subclassFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (subclassFeature.id == null) {
      throw ArgumentError.notNull('subclassFeature.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
        subclassFeatureId: subclassFeature.id);
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceEffectData] and [RaceFeatureData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `raceFeatureId` to refer to the [RaceFeatureData].
  Future<void> raceFeature(
    _i1.Session session,
    FeatureResourceEffectData featureResourceEffectData,
    _i4.RaceFeatureData raceFeature, {
    _i1.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (raceFeature.id == null) {
      throw ArgumentError.notNull('raceFeature.id');
    }

    var $featureResourceEffectData =
        featureResourceEffectData.copyWith(raceFeatureId: raceFeature.id);
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }
}

class FeatureResourceEffectDataDetachRowRepository {
  const FeatureResourceEffectDataDetachRowRepository._();

  /// Detaches the relation between this [FeatureResourceEffectData] and the [ClassFeatureData] set in `classFeature`
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> classFeature(
    _i1.Session session,
    FeatureResourceEffectData featureresourceeffectdata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourceeffectdata.id == null) {
      throw ArgumentError.notNull('featureresourceeffectdata.id');
    }

    var $featureresourceeffectdata =
        featureresourceeffectdata.copyWith(classFeatureId: null);
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureresourceeffectdata,
      columns: [FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceEffectData] and the [SubclassFeatureData] set in `subclassFeature`
  /// by setting the [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subclassFeature(
    _i1.Session session,
    FeatureResourceEffectData featureresourceeffectdata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourceeffectdata.id == null) {
      throw ArgumentError.notNull('featureresourceeffectdata.id');
    }

    var $featureresourceeffectdata =
        featureresourceeffectdata.copyWith(subclassFeatureId: null);
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureresourceeffectdata,
      columns: [FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceEffectData] and the [RaceFeatureData] set in `raceFeature`
  /// by setting the [FeatureResourceEffectData]'s foreign key `raceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> raceFeature(
    _i1.Session session,
    FeatureResourceEffectData featureresourceeffectdata, {
    _i1.Transaction? transaction,
  }) async {
    if (featureresourceeffectdata.id == null) {
      throw ArgumentError.notNull('featureresourceeffectdata.id');
    }

    var $featureresourceeffectdata =
        featureresourceeffectdata.copyWith(raceFeatureId: null);
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureresourceeffectdata,
      columns: [FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }
}
