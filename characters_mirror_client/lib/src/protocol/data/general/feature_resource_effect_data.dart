/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
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

abstract class FeatureResourceEffectData implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
