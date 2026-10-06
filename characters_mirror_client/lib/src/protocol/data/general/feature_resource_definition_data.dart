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
import '../../data/general/choice_option_data.dart' as _i5;
import '../../enums/feature_resource_kind.dart' as _i6;
import '../../enums/feature_resource_max_rule.dart' as _i7;
import '../../enums/ability.dart' as _i8;
import '../../enums/rest_type.dart' as _i9;
import '../../enums/feature_resource_trigger.dart' as _i10;
import '../../enums/feature_resource_progression_key.dart' as _i11;
import '../../data/general/feature_resource_progression_value_data.dart'
    as _i12;

abstract class FeatureResourceDefinitionData implements _i1.SerializableModel {
  FeatureResourceDefinitionData._({
    this.id,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    this.raceFeatureId,
    this.raceFeature,
    required this.key,
    this.choiceOptionId,
    this.choiceOption,
    this.name,
    required this.kind,
    required this.maxRule,
    this.maxValue,
    this.maxAbility,
    this.resetOn,
    this.activationTrigger,
    this.usageResetOn,
    this.progressionKey,
    this.becomesUnlimitedAtLevel,
    this.progressionValues,
  });

  factory FeatureResourceDefinitionData({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    required String key,
    int? choiceOptionId,
    _i5.ChoiceOptionData? choiceOption,
    String? name,
    required _i6.FeatureResourceKind kind,
    required _i7.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _i8.Ability? maxAbility,
    _i9.RestType? resetOn,
    _i10.FeatureResourceTrigger? activationTrigger,
    _i9.RestType? usageResetOn,
    _i11.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i12.FeatureResourceProgressionValueData>? progressionValues,
  }) = _FeatureResourceDefinitionDataImpl;

  factory FeatureResourceDefinitionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureResourceDefinitionData(
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
      key: jsonSerialization['key'] as String,
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _i5.ChoiceOptionData.fromJson(
              (jsonSerialization['choiceOption'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      kind: _i6.FeatureResourceKind.fromJson(
          (jsonSerialization['kind'] as String)),
      maxRule: _i7.FeatureResourceMaxRule.fromJson(
          (jsonSerialization['maxRule'] as String)),
      maxValue: jsonSerialization['maxValue'] as int?,
      maxAbility: jsonSerialization['maxAbility'] == null
          ? null
          : _i8.Ability.fromJson((jsonSerialization['maxAbility'] as String)),
      resetOn: jsonSerialization['resetOn'] == null
          ? null
          : _i9.RestType.fromJson((jsonSerialization['resetOn'] as String)),
      activationTrigger: jsonSerialization['activationTrigger'] == null
          ? null
          : _i10.FeatureResourceTrigger.fromJson(
              (jsonSerialization['activationTrigger'] as String)),
      usageResetOn: jsonSerialization['usageResetOn'] == null
          ? null
          : _i9.RestType.fromJson(
              (jsonSerialization['usageResetOn'] as String)),
      progressionKey: jsonSerialization['progressionKey'] == null
          ? null
          : _i11.FeatureResourceProgressionKey.fromJson(
              (jsonSerialization['progressionKey'] as String)),
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
      progressionValues: (jsonSerialization['progressionValues'] as List?)
          ?.map((e) => _i12.FeatureResourceProgressionValueData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
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

  String key;

  int? choiceOptionId;

  _i5.ChoiceOptionData? choiceOption;

  String? name;

  _i6.FeatureResourceKind kind;

  _i7.FeatureResourceMaxRule maxRule;

  int? maxValue;

  _i8.Ability? maxAbility;

  _i9.RestType? resetOn;

  _i10.FeatureResourceTrigger? activationTrigger;

  _i9.RestType? usageResetOn;

  _i11.FeatureResourceProgressionKey? progressionKey;

  int? becomesUnlimitedAtLevel;

  List<_i12.FeatureResourceProgressionValueData>? progressionValues;

  /// Returns a shallow copy of this [FeatureResourceDefinitionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureResourceDefinitionData copyWith({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    String? key,
    int? choiceOptionId,
    _i5.ChoiceOptionData? choiceOption,
    String? name,
    _i6.FeatureResourceKind? kind,
    _i7.FeatureResourceMaxRule? maxRule,
    int? maxValue,
    _i8.Ability? maxAbility,
    _i9.RestType? resetOn,
    _i10.FeatureResourceTrigger? activationTrigger,
    _i9.RestType? usageResetOn,
    _i11.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i12.FeatureResourceProgressionValueData>? progressionValues,
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
      'key': key,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null) 'choiceOption': choiceOption?.toJson(),
      if (name != null) 'name': name,
      'kind': kind.toJson(),
      'maxRule': maxRule.toJson(),
      if (maxValue != null) 'maxValue': maxValue,
      if (maxAbility != null) 'maxAbility': maxAbility?.toJson(),
      if (resetOn != null) 'resetOn': resetOn?.toJson(),
      if (activationTrigger != null)
        'activationTrigger': activationTrigger?.toJson(),
      if (usageResetOn != null) 'usageResetOn': usageResetOn?.toJson(),
      if (progressionKey != null) 'progressionKey': progressionKey?.toJson(),
      if (becomesUnlimitedAtLevel != null)
        'becomesUnlimitedAtLevel': becomesUnlimitedAtLevel,
      if (progressionValues != null)
        'progressionValues':
            progressionValues?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceDefinitionDataImpl extends FeatureResourceDefinitionData {
  _FeatureResourceDefinitionDataImpl({
    int? id,
    int? classFeatureId,
    _i2.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i3.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _i4.RaceFeatureData? raceFeature,
    required String key,
    int? choiceOptionId,
    _i5.ChoiceOptionData? choiceOption,
    String? name,
    required _i6.FeatureResourceKind kind,
    required _i7.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _i8.Ability? maxAbility,
    _i9.RestType? resetOn,
    _i10.FeatureResourceTrigger? activationTrigger,
    _i9.RestType? usageResetOn,
    _i11.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i12.FeatureResourceProgressionValueData>? progressionValues,
  }) : super._(
          id: id,
          classFeatureId: classFeatureId,
          classFeature: classFeature,
          subclassFeatureId: subclassFeatureId,
          subclassFeature: subclassFeature,
          raceFeatureId: raceFeatureId,
          raceFeature: raceFeature,
          key: key,
          choiceOptionId: choiceOptionId,
          choiceOption: choiceOption,
          name: name,
          kind: kind,
          maxRule: maxRule,
          maxValue: maxValue,
          maxAbility: maxAbility,
          resetOn: resetOn,
          activationTrigger: activationTrigger,
          usageResetOn: usageResetOn,
          progressionKey: progressionKey,
          becomesUnlimitedAtLevel: becomesUnlimitedAtLevel,
          progressionValues: progressionValues,
        );

  /// Returns a shallow copy of this [FeatureResourceDefinitionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureResourceDefinitionData copyWith({
    Object? id = _Undefined,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    Object? raceFeatureId = _Undefined,
    Object? raceFeature = _Undefined,
    String? key,
    Object? choiceOptionId = _Undefined,
    Object? choiceOption = _Undefined,
    Object? name = _Undefined,
    _i6.FeatureResourceKind? kind,
    _i7.FeatureResourceMaxRule? maxRule,
    Object? maxValue = _Undefined,
    Object? maxAbility = _Undefined,
    Object? resetOn = _Undefined,
    Object? activationTrigger = _Undefined,
    Object? usageResetOn = _Undefined,
    Object? progressionKey = _Undefined,
    Object? becomesUnlimitedAtLevel = _Undefined,
    Object? progressionValues = _Undefined,
  }) {
    return FeatureResourceDefinitionData(
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
      key: key ?? this.key,
      choiceOptionId:
          choiceOptionId is int? ? choiceOptionId : this.choiceOptionId,
      choiceOption: choiceOption is _i5.ChoiceOptionData?
          ? choiceOption
          : this.choiceOption?.copyWith(),
      name: name is String? ? name : this.name,
      kind: kind ?? this.kind,
      maxRule: maxRule ?? this.maxRule,
      maxValue: maxValue is int? ? maxValue : this.maxValue,
      maxAbility: maxAbility is _i8.Ability? ? maxAbility : this.maxAbility,
      resetOn: resetOn is _i9.RestType? ? resetOn : this.resetOn,
      activationTrigger: activationTrigger is _i10.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
      usageResetOn:
          usageResetOn is _i9.RestType? ? usageResetOn : this.usageResetOn,
      progressionKey: progressionKey is _i11.FeatureResourceProgressionKey?
          ? progressionKey
          : this.progressionKey,
      becomesUnlimitedAtLevel: becomesUnlimitedAtLevel is int?
          ? becomesUnlimitedAtLevel
          : this.becomesUnlimitedAtLevel,
      progressionValues:
          progressionValues is List<_i12.FeatureResourceProgressionValueData>?
              ? progressionValues
              : this.progressionValues?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
