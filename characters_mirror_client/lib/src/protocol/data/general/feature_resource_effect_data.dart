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
import '../../data/general/race/race_feature_data.dart' as _iga2jap7;
import '../../data/general/spell_slot_recovery_policy_data.dart' as _i4rt3cx6;
import '../../enums/ability.dart' as _if5gaqs5;
import '../../enums/character_feature_source_type.dart' as _ilvqooqk;
import '../../enums/feature_resource_effect_type.dart' as _i6pn3c9w;
import '../../enums/feature_resource_max_rule.dart' as _i8eknyg7;
import '../../enums/feature_resource_target_type.dart' as _i8eube95;
import '../../enums/feature_resource_trigger.dart' as _id68h68o;
import '../../enums/rest_type.dart' as _i67lztjp;

abstract class FeatureResourceEffectData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FeatureResourceEffectData._({
    this.id,
    this.classFeatureId,
    this.classFeature,
    this.subclassFeatureId,
    this.subclassFeature,
    this.raceFeatureId,
    this.raceFeature,
    required this.type,
    this.choiceOptionId,
    this.choiceOption,
    this.targetType,
    this.targetResourceKey,
    this.targetSourceType,
    this.targetSourceId,
    this.amountRule,
    this.amountValue,
    this.amountAbility,
    this.activationTrigger,
    this.usageResetOn,
    this.recoveryPolicy,
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
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    required _i6pn3c9w.FeatureResourceEffectType type,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    _i8eube95.FeatureResourceTargetType? targetType,
    String? targetResourceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetSourceType,
    int? targetSourceId,
    _i8eknyg7.FeatureResourceMaxRule? amountRule,
    int? amountValue,
    _if5gaqs5.Ability? amountAbility,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _i4rt3cx6.SpellSlotRecoveryPolicyData? recoveryPolicy,
    _i67lztjp.RestType? setResetOn,
    _i8eknyg7.FeatureResourceMaxRule? setMaxRule,
    int? setMaxValue,
    _if5gaqs5.Ability? setMaxAbility,
    int? addMaxValue,
    bool? setUnlimited,
    int? becomesUnlimitedAtLevel,
  }) = _FeatureResourceEffectDataImpl;

  factory FeatureResourceEffectData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FeatureResourceEffectData(
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
      type: _i6pn3c9w.FeatureResourceEffectType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iu6wj5qy.ChoiceOptionData>(
              jsonSerialization['choiceOption'],
            ),
      targetType: jsonSerialization['targetType'] == null
          ? null
          : _i8eube95.FeatureResourceTargetType.fromJson(
              (jsonSerialization['targetType'] as String),
            ),
      targetResourceKey: jsonSerialization['targetResourceKey'] as String?,
      targetSourceType: jsonSerialization['targetSourceType'] == null
          ? null
          : _ilvqooqk.CharacterFeatureSourceType.fromJson(
              (jsonSerialization['targetSourceType'] as String),
            ),
      targetSourceId: jsonSerialization['targetSourceId'] as int?,
      amountRule: jsonSerialization['amountRule'] == null
          ? null
          : _i8eknyg7.FeatureResourceMaxRule.fromJson(
              (jsonSerialization['amountRule'] as String),
            ),
      amountValue: jsonSerialization['amountValue'] as int?,
      amountAbility: jsonSerialization['amountAbility'] == null
          ? null
          : _if5gaqs5.Ability.fromJson(
              (jsonSerialization['amountAbility'] as String),
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
      recoveryPolicy: jsonSerialization['recoveryPolicy'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_i4rt3cx6.SpellSlotRecoveryPolicyData>(
                  jsonSerialization['recoveryPolicy'],
                ),
      setResetOn: jsonSerialization['setResetOn'] == null
          ? null
          : _i67lztjp.RestType.fromJson(
              (jsonSerialization['setResetOn'] as String),
            ),
      setMaxRule: jsonSerialization['setMaxRule'] == null
          ? null
          : _i8eknyg7.FeatureResourceMaxRule.fromJson(
              (jsonSerialization['setMaxRule'] as String),
            ),
      setMaxValue: jsonSerialization['setMaxValue'] as int?,
      setMaxAbility: jsonSerialization['setMaxAbility'] == null
          ? null
          : _if5gaqs5.Ability.fromJson(
              (jsonSerialization['setMaxAbility'] as String),
            ),
      addMaxValue: jsonSerialization['addMaxValue'] as int?,
      setUnlimited: jsonSerialization['setUnlimited'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['setUnlimited']),
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
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

  _i6pn3c9w.FeatureResourceEffectType type;

  int? choiceOptionId;

  _iu6wj5qy.ChoiceOptionData? choiceOption;

  _i8eube95.FeatureResourceTargetType? targetType;

  String? targetResourceKey;

  _ilvqooqk.CharacterFeatureSourceType? targetSourceType;

  int? targetSourceId;

  _i8eknyg7.FeatureResourceMaxRule? amountRule;

  int? amountValue;

  _if5gaqs5.Ability? amountAbility;

  _id68h68o.FeatureResourceTrigger? activationTrigger;

  _i67lztjp.RestType? usageResetOn;

  _i4rt3cx6.SpellSlotRecoveryPolicyData? recoveryPolicy;

  _i67lztjp.RestType? setResetOn;

  _i8eknyg7.FeatureResourceMaxRule? setMaxRule;

  int? setMaxValue;

  _if5gaqs5.Ability? setMaxAbility;

  int? addMaxValue;

  bool? setUnlimited;

  int? becomesUnlimitedAtLevel;

  /// Returns a shallow copy of this [FeatureResourceEffectData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FeatureResourceEffectData copyWith({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    _i6pn3c9w.FeatureResourceEffectType? type,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    _i8eube95.FeatureResourceTargetType? targetType,
    String? targetResourceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetSourceType,
    int? targetSourceId,
    _i8eknyg7.FeatureResourceMaxRule? amountRule,
    int? amountValue,
    _if5gaqs5.Ability? amountAbility,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _i4rt3cx6.SpellSlotRecoveryPolicyData? recoveryPolicy,
    _i67lztjp.RestType? setResetOn,
    _i8eknyg7.FeatureResourceMaxRule? setMaxRule,
    int? setMaxValue,
    _if5gaqs5.Ability? setMaxAbility,
    int? addMaxValue,
    bool? setUnlimited,
    int? becomesUnlimitedAtLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureResourceEffectData',
      if (id != null) 'id': id,
      if (classFeatureId != null) 'classFeatureId': classFeatureId,
      if (classFeature != null) 'classFeature': classFeature?.toJson(),
      if (subclassFeatureId != null) 'subclassFeatureId': subclassFeatureId,
      if (subclassFeature != null) 'subclassFeature': subclassFeature?.toJson(),
      if (raceFeatureId != null) 'raceFeatureId': raceFeatureId,
      if (raceFeature != null) 'raceFeature': raceFeature?.toJson(),
      'type': type.toJson(),
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null) 'choiceOption': choiceOption?.toJson(),
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
      if (recoveryPolicy != null) 'recoveryPolicy': recoveryPolicy?.toJson(),
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
      '__className__': 'FeatureResourceEffectData',
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
      if (choiceOptionId != null) 'choiceOptionId': choiceOptionId,
      if (choiceOption != null)
        'choiceOption': choiceOption?.toJsonForProtocol(),
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
      if (recoveryPolicy != null)
        'recoveryPolicy': recoveryPolicy?.toJsonForProtocol(),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureResourceEffectDataImpl extends FeatureResourceEffectData {
  _FeatureResourceEffectDataImpl({
    int? id,
    int? classFeatureId,
    _inxbtq9c.ClassFeatureData? classFeature,
    int? subclassFeatureId,
    _i6bcyp7i.SubclassFeatureData? subclassFeature,
    int? raceFeatureId,
    _iga2jap7.RaceFeatureData? raceFeature,
    required _i6pn3c9w.FeatureResourceEffectType type,
    int? choiceOptionId,
    _iu6wj5qy.ChoiceOptionData? choiceOption,
    _i8eube95.FeatureResourceTargetType? targetType,
    String? targetResourceKey,
    _ilvqooqk.CharacterFeatureSourceType? targetSourceType,
    int? targetSourceId,
    _i8eknyg7.FeatureResourceMaxRule? amountRule,
    int? amountValue,
    _if5gaqs5.Ability? amountAbility,
    _id68h68o.FeatureResourceTrigger? activationTrigger,
    _i67lztjp.RestType? usageResetOn,
    _i4rt3cx6.SpellSlotRecoveryPolicyData? recoveryPolicy,
    _i67lztjp.RestType? setResetOn,
    _i8eknyg7.FeatureResourceMaxRule? setMaxRule,
    int? setMaxValue,
    _if5gaqs5.Ability? setMaxAbility,
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
         choiceOptionId: choiceOptionId,
         choiceOption: choiceOption,
         targetType: targetType,
         targetResourceKey: targetResourceKey,
         targetSourceType: targetSourceType,
         targetSourceId: targetSourceId,
         amountRule: amountRule,
         amountValue: amountValue,
         amountAbility: amountAbility,
         activationTrigger: activationTrigger,
         usageResetOn: usageResetOn,
         recoveryPolicy: recoveryPolicy,
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
  @_isc.useResult
  @override
  FeatureResourceEffectData copyWith({
    Object? id = _Undefined,
    Object? classFeatureId = _Undefined,
    Object? classFeature = _Undefined,
    Object? subclassFeatureId = _Undefined,
    Object? subclassFeature = _Undefined,
    Object? raceFeatureId = _Undefined,
    Object? raceFeature = _Undefined,
    _i6pn3c9w.FeatureResourceEffectType? type,
    Object? choiceOptionId = _Undefined,
    Object? choiceOption = _Undefined,
    Object? targetType = _Undefined,
    Object? targetResourceKey = _Undefined,
    Object? targetSourceType = _Undefined,
    Object? targetSourceId = _Undefined,
    Object? amountRule = _Undefined,
    Object? amountValue = _Undefined,
    Object? amountAbility = _Undefined,
    Object? activationTrigger = _Undefined,
    Object? usageResetOn = _Undefined,
    Object? recoveryPolicy = _Undefined,
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
      type: type ?? this.type,
      choiceOptionId: choiceOptionId is int?
          ? choiceOptionId
          : this.choiceOptionId,
      choiceOption: choiceOption is _iu6wj5qy.ChoiceOptionData?
          ? choiceOption
          : this.choiceOption?.copyWith(),
      targetType: targetType is _i8eube95.FeatureResourceTargetType?
          ? targetType
          : this.targetType,
      targetResourceKey: targetResourceKey is String?
          ? targetResourceKey
          : this.targetResourceKey,
      targetSourceType:
          targetSourceType is _ilvqooqk.CharacterFeatureSourceType?
          ? targetSourceType
          : this.targetSourceType,
      targetSourceId: targetSourceId is int?
          ? targetSourceId
          : this.targetSourceId,
      amountRule: amountRule is _i8eknyg7.FeatureResourceMaxRule?
          ? amountRule
          : this.amountRule,
      amountValue: amountValue is int? ? amountValue : this.amountValue,
      amountAbility: amountAbility is _if5gaqs5.Ability?
          ? amountAbility
          : this.amountAbility,
      activationTrigger: activationTrigger is _id68h68o.FeatureResourceTrigger?
          ? activationTrigger
          : this.activationTrigger,
      usageResetOn: usageResetOn is _i67lztjp.RestType?
          ? usageResetOn
          : this.usageResetOn,
      recoveryPolicy: recoveryPolicy is _i4rt3cx6.SpellSlotRecoveryPolicyData?
          ? recoveryPolicy
          : this.recoveryPolicy?.copyWith(),
      setResetOn: setResetOn is _i67lztjp.RestType?
          ? setResetOn
          : this.setResetOn,
      setMaxRule: setMaxRule is _i8eknyg7.FeatureResourceMaxRule?
          ? setMaxRule
          : this.setMaxRule,
      setMaxValue: setMaxValue is int? ? setMaxValue : this.setMaxValue,
      setMaxAbility: setMaxAbility is _if5gaqs5.Ability?
          ? setMaxAbility
          : this.setMaxAbility,
      addMaxValue: addMaxValue is int? ? addMaxValue : this.addMaxValue,
      setUnlimited: setUnlimited is bool? ? setUnlimited : this.setUnlimited,
      becomesUnlimitedAtLevel: becomesUnlimitedAtLevel is int?
          ? becomesUnlimitedAtLevel
          : this.becomesUnlimitedAtLevel,
    );
  }
}
