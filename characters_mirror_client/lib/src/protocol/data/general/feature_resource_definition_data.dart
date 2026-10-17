/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../data/general/choice_option_data.dart' as _iu6wj5qy;
import '../../data/general/class/class_feature_data.dart' as _inxbtq9c;
import '../../data/general/class/subclass_feature_data.dart' as _i6bcyp7i;
import '../../data/general/feature_resource_progression_value_data.dart'
    as _i40dz5tv;
import '../../data/general/race/race_feature_data.dart' as _iga2jap7;
import '../../enums/ability.dart' as _if5gaqs5;
import '../../enums/feature_resource_kind.dart' as _idk2deej;
import '../../enums/feature_resource_max_rule.dart' as _i8eknyg7;
import '../../enums/feature_resource_progression_key.dart' as _int4z9wn;
import '../../enums/feature_resource_trigger.dart' as _id68h68o;
import '../../enums/rest_type.dart' as _i67lztjp;

abstract class FeatureResourceDefinitionData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    required String key,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    String? name,
    required _idk2deej.FeatureResourceKind kind,
    required _i8eknyg7.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _if5gaqs5.Ability? maxAbility,
    _i67lztjp.RestType? resetOn,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _int4z9wn.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues,
  }) = _FeatureResourceDefinitionDataImpl;

  factory FeatureResourceDefinitionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FeatureResourceDefinitionData(
      id: jsonSerialization['id'] as int?,
      classFeatureId: jsonSerialization['classFeatureId'] as int?,
      classFeature: jsonSerialization['classFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['classFeature'],
            ),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['subclassFeature'],
            ),
      raceFeatureId: jsonSerialization['raceFeatureId'] as int?,
      raceFeature: jsonSerialization['raceFeature'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iga2jap7.RaceFeatureData>(
              jsonSerialization['raceFeature'],
            ),
      key: jsonSerialization['key'] as String,
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iu6wj5qy.ChoiceOptionData>(
              jsonSerialization['choiceOption'],
            ),
      name: jsonSerialization['name'] as String?,
      kind: _idk2deej.FeatureResourceKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      maxRule: _i8eknyg7.FeatureResourceMaxRule.fromJson(
        (jsonSerialization['maxRule'] as String),
      ),
      maxValue: jsonSerialization['maxValue'] as int?,
      maxAbility: jsonSerialization['maxAbility'] == null
          ? null
          : _if5gaqs5.Ability.fromJson(
              (jsonSerialization['maxAbility'] as String),
            ),
      resetOn: jsonSerialization['resetOn'] == null
          ? null
          : _i67lztjp.RestType.fromJson(
              (jsonSerialization['resetOn'] as String),
            ),
      activationTrigger: jsonSerialization['activationTrigger'] == null
          ? null
          : _id68h68o.FeatureResourceTrigger.fromJson(
              (jsonSerialization['activationTrigger'] as String),
            ),
      usageResetOn: jsonSerialization['usageResetOn'] == null
          ? null
          : _i67lztjp.RestType.fromJson(
              (jsonSerialization['usageResetOn'] as String),
            ),
      progressionKey: jsonSerialization['progressionKey'] == null
          ? null
          : _int4z9wn.FeatureResourceProgressionKey.fromJson(
              (jsonSerialization['progressionKey'] as String),
            ),
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
      progressionValues: jsonSerialization['progressionValues'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<
              List<_i40dz5tv.FeatureResourceProgressionValueData>
            >(jsonSerialization['progressionValues']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? classFeatureId;

  _inxbtq9c.ClassFeatureData? classFeature;

  int? subclassFeatureId;

  _i6bcyp7i.SubclassFeatureData? subclassFeature;

  int? raceFeatureId;

  _iga2jap7.RaceFeatureData? raceFeature;

  String key;

  int? choiceOptionId;

  _iu6wj5qy.ChoiceOptionData? choiceOption;

  String? name;

  _idk2deej.FeatureResourceKind kind;

  _i8eknyg7.FeatureResourceMaxRule maxRule;

  int? maxValue;

  _if5gaqs5.Ability? maxAbility;

  _i67lztjp.RestType? resetOn;

  _id68h68o.FeatureResourceTrigger? activationTrigger;

  _i67lztjp.RestType? usageResetOn;

  _int4z9wn.FeatureResourceProgressionKey? progressionKey;

  int? becomesUnlimitedAtLevel;

  List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues;

  /// Returns a shallow copy of this [FeatureResourceDefinitionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeatureResourceDefinitionData copyWith({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    String? key,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    String? name,
    _idk2deej.FeatureResourceKind? kind,
    _i8eknyg7.FeatureResourceMaxRule? maxRule,
    int? maxValue,
    _if5gaqs5.Ability? maxAbility,
    _i67lztjp.RestType? resetOn,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _int4z9wn.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureResourceDefinitionData',
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
        'progressionValues': progressionValues?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureResourceDefinitionData',
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null)
        'classFeature': classFeature?.toJsonForProtocol(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null)
        'subclassFeature': subclassFeature?.toJsonForProtocol(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJsonForProtocol(),
      'key': key,
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null)
        'choiceOption': choiceOption?.toJsonForProtocol(),
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
        'progressionValues': progressionValues?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceDefinitionDataImpl extends FeatureResourceDefinitionData {
  _FeatureResourceDefinitionDataImpl({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    required String key,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    String? name,
    required _idk2deej.FeatureResourceKind kind,
    required _i8eknyg7.FeatureResourceMaxRule maxRule,
    int? maxValue,
    _if5gaqs5.Ability? maxAbility,
    _i67lztjp.RestType? resetOn,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _int4z9wn.FeatureResourceProgressionKey? progressionKey,
    int? becomesUnlimitedAtLevel,
    List<_i40dz5tv.FeatureResourceProgressionValueData>? progressionValues,
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
  @_isc.useResult
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
    _idk2deej.FeatureResourceKind? kind,
    _i8eknyg7.FeatureResourceMaxRule? maxRule,
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
      classFeatureId: classFeatureId is int?
          ? classFeatureId
          : this.classFeatureId,
      classFeature: classFeature is _inxbtq9c.ClassFeatureData?
          ? classFeature
          : this.classFeature?.copyWith(),
      subclassFeatureId: subclassFeatureId is int?
          ? subclassFeatureId
          : this.subclassFeatureId,
      subclassFeature: subclassFeature is _i6bcyp7i.SubclassFeatureData?
          ? subclassFeature
          : this.subclassFeature?.copyWith(),
      raceFeatureId: raceFeatureId is int? ? raceFeatureId : this.raceFeatureId,
      raceFeature: raceFeature is _iga2jap7.RaceFeatureData?
          ? raceFeature
          : this.raceFeature?.copyWith(),
      key: key ?? this.key,
      choiceOptionId: choiceOptionId is int?
          ? choiceOptionId
          : this.choiceOptionId,
      choiceOption: choiceOption is _iu6wj5qy.ChoiceOptionData?
          ? choiceOption
          : this.choiceOption?.copyWith(),
      name: name is String? ? name : this.name,
      kind: kind ?? this.kind,
      maxRule: maxRule ?? this.maxRule,
      maxValue: maxValue is int? ? maxValue : this.maxValue,
      maxAbility: maxAbility is _if5gaqs5.Ability?
          ? maxAbility
          : this.maxAbility,
      resetOn: resetOn is _i67lztjp.RestType? ? resetOn : this.resetOn,
      activationTrigger: activationTrigger is _id68h68o.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
      usageResetOn: usageResetOn is _i67lztjp.RestType?
          ? usageResetOn
          : this.usageResetOn,
      progressionKey: progressionKey is _int4z9wn.FeatureResourceProgressionKey?
          ? progressionKey
          : this.progressionKey,
      becomesUnlimitedAtLevel: becomesUnlimitedAtLevel is int?
          ? becomesUnlimitedAtLevel
          : this.becomesUnlimitedAtLevel,
      progressionValues:
          progressionValues
              is List<_i40dz5tv.FeatureResourceProgressionValueData>?
          ? progressionValues
          : this.progressionValues?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
