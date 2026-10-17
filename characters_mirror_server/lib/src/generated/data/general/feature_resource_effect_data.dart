/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
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
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _ikmnmw29.Protocol().deserialize<_inxbtq9c.ClassFeatureData>(
              jsonSerialization['classFeature'],
            ),
      subclassFeatureId: jsonSerialization['subclassFeatureId'] as int?,
      subclassFeature: jsonSerialization['subclassFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6bcyp7i.SubclassFeatureData>(
              jsonSerialization['subclassFeature'],
            ),
      raceFeatureId: jsonSerialization['raceFeatureId'] as int?,
      raceFeature: jsonSerialization['raceFeature'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iga2jap7.RaceFeatureData>(
              jsonSerialization['raceFeature'],
            ),
      type: _i6pn3c9w.FeatureResourceEffectType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      choiceOptionId: jsonSerialization['choiceOptionId'] as int?,
      choiceOption: jsonSerialization['choiceOption'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iu6wj5qy.ChoiceOptionData>(
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
          : _ikmnmw29.Protocol()
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
          : _is.BoolJsonExtension.fromJson(jsonSerialization['setUnlimited']),
      becomesUnlimitedAtLevel:
          jsonSerialization['becomesUnlimitedAtLevel'] as int?,
    );
  }

  static final t = FeatureResourceEffectDataTable();

  static const db = FeatureResourceEffectDataRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeatureResourceEffectData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static FeatureResourceEffectDataInclude include({
    _inxbtq9c.ClassFeatureDataInclude? classFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? subclassFeature,
    _iga2jap7.RaceFeatureDataInclude? raceFeature,
    _iu6wj5qy.ChoiceOptionDataInclude? choiceOption,
  }) {
    return FeatureResourceEffectDataInclude._(
      classFeature: classFeature,
      subclassFeature: subclassFeature,
      raceFeature: raceFeature,
      choiceOption: choiceOption,
    );
  }

  static FeatureResourceEffectDataIncludeList includeList({
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    FeatureResourceEffectDataInclude? include,
  }) {
    return FeatureResourceEffectDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class FeatureResourceEffectDataUpdateTable
    extends _is.UpdateTable<FeatureResourceEffectDataTable> {
  FeatureResourceEffectDataUpdateTable(super.table);

  _is.ColumnValue<int, int> classFeatureId(int? value) =>
      _is.ColumnValue(table.classFeatureId, value);

  _is.ColumnValue<int, int> subclassFeatureId(int? value) =>
      _is.ColumnValue(table.subclassFeatureId, value);

  _is.ColumnValue<int, int> raceFeatureId(int? value) =>
      _is.ColumnValue(table.raceFeatureId, value);

  _is.ColumnValue<
    _i6pn3c9w.FeatureResourceEffectType,
    _i6pn3c9w.FeatureResourceEffectType
  >
  type(_i6pn3c9w.FeatureResourceEffectType value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<int, int> choiceOptionId(int? value) =>
      _is.ColumnValue(table.choiceOptionId, value);

  _is.ColumnValue<
    _i8eube95.FeatureResourceTargetType,
    _i8eube95.FeatureResourceTargetType
  >
  targetType(_i8eube95.FeatureResourceTargetType? value) =>
      _is.ColumnValue(table.targetType, value);

  _is.ColumnValue<String, String> targetResourceKey(String? value) =>
      _is.ColumnValue(table.targetResourceKey, value);

  _is.ColumnValue<
    _ilvqooqk.CharacterFeatureSourceType,
    _ilvqooqk.CharacterFeatureSourceType
  >
  targetSourceType(_ilvqooqk.CharacterFeatureSourceType? value) =>
      _is.ColumnValue(table.targetSourceType, value);

  _is.ColumnValue<int, int> targetSourceId(int? value) =>
      _is.ColumnValue(table.targetSourceId, value);

  _is.ColumnValue<
    _i8eknyg7.FeatureResourceMaxRule,
    _i8eknyg7.FeatureResourceMaxRule
  >
  amountRule(_i8eknyg7.FeatureResourceMaxRule? value) =>
      _is.ColumnValue(table.amountRule, value);

  _is.ColumnValue<int, int> amountValue(int? value) =>
      _is.ColumnValue(table.amountValue, value);

  _is.ColumnValue<_if5gaqs5.Ability, _if5gaqs5.Ability> amountAbility(
    _if5gaqs5.Ability? value,
  ) => _is.ColumnValue(table.amountAbility, value);

  _is.ColumnValue<
    _id68h68o.FeatureResourceTrigger,
    _id68h68o.FeatureResourceTrigger
  >
  activationTrigger(_id68h68o.FeatureResourceTrigger? value) =>
      _is.ColumnValue(table.activationTrigger, value);

  _is.ColumnValue<_i67lztjp.RestType, _i67lztjp.RestType> usageResetOn(
    _i67lztjp.RestType? value,
  ) => _is.ColumnValue(table.usageResetOn, value);

  _is.ColumnValue<
    _i4rt3cx6.SpellSlotRecoveryPolicyData,
    _i4rt3cx6.SpellSlotRecoveryPolicyData
  >
  recoveryPolicy(_i4rt3cx6.SpellSlotRecoveryPolicyData? value) =>
      _is.ColumnValue(table.recoveryPolicy, value);

  _is.ColumnValue<_i67lztjp.RestType, _i67lztjp.RestType> setResetOn(
    _i67lztjp.RestType? value,
  ) => _is.ColumnValue(table.setResetOn, value);

  _is.ColumnValue<
    _i8eknyg7.FeatureResourceMaxRule,
    _i8eknyg7.FeatureResourceMaxRule
  >
  setMaxRule(_i8eknyg7.FeatureResourceMaxRule? value) =>
      _is.ColumnValue(table.setMaxRule, value);

  _is.ColumnValue<int, int> setMaxValue(int? value) =>
      _is.ColumnValue(table.setMaxValue, value);

  _is.ColumnValue<_if5gaqs5.Ability, _if5gaqs5.Ability> setMaxAbility(
    _if5gaqs5.Ability? value,
  ) => _is.ColumnValue(table.setMaxAbility, value);

  _is.ColumnValue<int, int> addMaxValue(int? value) =>
      _is.ColumnValue(table.addMaxValue, value);

  _is.ColumnValue<bool, bool> setUnlimited(bool? value) =>
      _is.ColumnValue(table.setUnlimited, value);

  _is.ColumnValue<int, int> becomesUnlimitedAtLevel(int? value) =>
      _is.ColumnValue(table.becomesUnlimitedAtLevel, value);
}

class FeatureResourceEffectDataTable extends _is.Table<int?> {
  FeatureResourceEffectDataTable({super.tableRelation})
    : super(tableName: 'feature_resource_effect_data') {
    updateTable = FeatureResourceEffectDataUpdateTable(this);
    classFeatureId = _is.ColumnInt('classFeatureId', this);
    subclassFeatureId = _is.ColumnInt('subclassFeatureId', this);
    raceFeatureId = _is.ColumnInt('raceFeatureId', this);
    type = _is.ColumnEnum('type', this, _is.EnumSerialization.byName);
    choiceOptionId = _is.ColumnInt('choiceOptionId', this);
    targetType = _is.ColumnEnum(
      'targetType',
      this,
      _is.EnumSerialization.byName,
    );
    targetResourceKey = _is.ColumnString('targetResourceKey', this);
    targetSourceType = _is.ColumnEnum(
      'targetSourceType',
      this,
      _is.EnumSerialization.byName,
    );
    targetSourceId = _is.ColumnInt('targetSourceId', this);
    amountRule = _is.ColumnEnum(
      'amountRule',
      this,
      _is.EnumSerialization.byName,
    );
    amountValue = _is.ColumnInt('amountValue', this);
    amountAbility = _is.ColumnEnum(
      'amountAbility',
      this,
      _is.EnumSerialization.byName,
    );
    activationTrigger = _is.ColumnEnum(
      'activationTrigger',
      this,
      _is.EnumSerialization.byName,
    );
    usageResetOn = _is.ColumnEnum(
      'usageResetOn',
      this,
      _is.EnumSerialization.byName,
    );
    recoveryPolicy =
        _is.ColumnSerializable<_i4rt3cx6.SpellSlotRecoveryPolicyData>(
          'recoveryPolicy',
          this,
        );
    setResetOn = _is.ColumnEnum(
      'setResetOn',
      this,
      _is.EnumSerialization.byName,
    );
    setMaxRule = _is.ColumnEnum(
      'setMaxRule',
      this,
      _is.EnumSerialization.byName,
    );
    setMaxValue = _is.ColumnInt('setMaxValue', this);
    setMaxAbility = _is.ColumnEnum(
      'setMaxAbility',
      this,
      _is.EnumSerialization.byName,
    );
    addMaxValue = _is.ColumnInt('addMaxValue', this);
    setUnlimited = _is.ColumnBool('setUnlimited', this);
    becomesUnlimitedAtLevel = _is.ColumnInt('becomesUnlimitedAtLevel', this);
  }

  late final FeatureResourceEffectDataUpdateTable updateTable;

  late final _is.ColumnInt classFeatureId;

  _inxbtq9c.ClassFeatureDataTable? _classFeature;

  late final _is.ColumnInt subclassFeatureId;

  _i6bcyp7i.SubclassFeatureDataTable? _subclassFeature;

  late final _is.ColumnInt raceFeatureId;

  _iga2jap7.RaceFeatureDataTable? _raceFeature;

  late final _is.ColumnEnum<_i6pn3c9w.FeatureResourceEffectType> type;

  late final _is.ColumnInt choiceOptionId;

  _iu6wj5qy.ChoiceOptionDataTable? _choiceOption;

  late final _is.ColumnEnum<_i8eube95.FeatureResourceTargetType> targetType;

  late final _is.ColumnString targetResourceKey;

  late final _is.ColumnEnum<_ilvqooqk.CharacterFeatureSourceType>
  targetSourceType;

  late final _is.ColumnInt targetSourceId;

  late final _is.ColumnEnum<_i8eknyg7.FeatureResourceMaxRule> amountRule;

  late final _is.ColumnInt amountValue;

  late final _is.ColumnEnum<_if5gaqs5.Ability> amountAbility;

  late final _is.ColumnEnum<_id68h68o.FeatureResourceTrigger> activationTrigger;

  late final _is.ColumnEnum<_i67lztjp.RestType> usageResetOn;

  late final _is.ColumnSerializable<_i4rt3cx6.SpellSlotRecoveryPolicyData>
  recoveryPolicy;

  late final _is.ColumnEnum<_i67lztjp.RestType> setResetOn;

  late final _is.ColumnEnum<_i8eknyg7.FeatureResourceMaxRule> setMaxRule;

  late final _is.ColumnInt setMaxValue;

  late final _is.ColumnEnum<_if5gaqs5.Ability> setMaxAbility;

  late final _is.ColumnInt addMaxValue;

  late final _is.ColumnBool setUnlimited;

  late final _is.ColumnInt becomesUnlimitedAtLevel;

  _inxbtq9c.ClassFeatureDataTable get classFeature {
    if (_classFeature != null) return _classFeature!;
    _classFeature = _is.createRelationTable(
      relationFieldName: 'classFeature',
      field: FeatureResourceEffectData.t.classFeatureId,
      foreignField: _inxbtq9c.ClassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _inxbtq9c.ClassFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _classFeature!;
  }

  _i6bcyp7i.SubclassFeatureDataTable get subclassFeature {
    if (_subclassFeature != null) return _subclassFeature!;
    _subclassFeature = _is.createRelationTable(
      relationFieldName: 'subclassFeature',
      field: FeatureResourceEffectData.t.subclassFeatureId,
      foreignField: _i6bcyp7i.SubclassFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _i6bcyp7i.SubclassFeatureDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return _subclassFeature!;
  }

  _iga2jap7.RaceFeatureDataTable get raceFeature {
    if (_raceFeature != null) return _raceFeature!;
    _raceFeature = _is.createRelationTable(
      relationFieldName: 'raceFeature',
      field: FeatureResourceEffectData.t.raceFeatureId,
      foreignField: _iga2jap7.RaceFeatureData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iga2jap7.RaceFeatureDataTable(tableRelation: foreignTableRelation),
    );
    return _raceFeature!;
  }

  _iu6wj5qy.ChoiceOptionDataTable get choiceOption {
    if (_choiceOption != null) return _choiceOption!;
    _choiceOption = _is.createRelationTable(
      relationFieldName: 'choiceOption',
      field: FeatureResourceEffectData.t.choiceOptionId,
      foreignField: _iu6wj5qy.ChoiceOptionData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iu6wj5qy.ChoiceOptionDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceOption!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    classFeatureId,
    subclassFeatureId,
    raceFeatureId,
    type,
    choiceOptionId,
    targetType,
    targetResourceKey,
    targetSourceType,
    targetSourceId,
    amountRule,
    amountValue,
    amountAbility,
    activationTrigger,
    usageResetOn,
    recoveryPolicy,
    setResetOn,
    setMaxRule,
    setMaxValue,
    setMaxAbility,
    addMaxValue,
    setUnlimited,
    becomesUnlimitedAtLevel,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'classFeature') {
      return classFeature;
    }
    if (relationField == 'subclassFeature') {
      return subclassFeature;
    }
    if (relationField == 'raceFeature') {
      return raceFeature;
    }
    if (relationField == 'choiceOption') {
      return choiceOption;
    }
    return null;
  }
}

class FeatureResourceEffectDataInclude extends _is.IncludeObject {
  FeatureResourceEffectDataInclude._({
    _inxbtq9c.ClassFeatureDataInclude? classFeature,
    _i6bcyp7i.SubclassFeatureDataInclude? subclassFeature,
    _iga2jap7.RaceFeatureDataInclude? raceFeature,
    _iu6wj5qy.ChoiceOptionDataInclude? choiceOption,
  }) {
    _classFeature = classFeature;
    _subclassFeature = subclassFeature;
    _raceFeature = raceFeature;
    _choiceOption = choiceOption;
  }

  _inxbtq9c.ClassFeatureDataInclude? _classFeature;

  _i6bcyp7i.SubclassFeatureDataInclude? _subclassFeature;

  _iga2jap7.RaceFeatureDataInclude? _raceFeature;

  _iu6wj5qy.ChoiceOptionDataInclude? _choiceOption;

  @override
  Map<String, _is.Include?> get includes => {
    'classFeature': _classFeature,
    'subclassFeature': _subclassFeature,
    'raceFeature': _raceFeature,
    'choiceOption': _choiceOption,
  };

  @override
  _is.Table<int?> get table => FeatureResourceEffectData.t;
}

class FeatureResourceEffectDataIncludeList extends _is.IncludeList {
  FeatureResourceEffectDataIncludeList._({
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeatureResourceEffectData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeatureResourceEffectData.t;
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureResourceEffectDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeatureResourceEffectData>(
      where: where?.call(FeatureResourceEffectData.t),
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
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
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? offset,
    _is.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _is.Transaction? transaction,
    FeatureResourceEffectDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeatureResourceEffectData>(
      where: where?.call(FeatureResourceEffectData.t),
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeatureResourceEffectData] by its [id] or null if no such row exists.
  Future<FeatureResourceEffectData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    FeatureResourceEffectDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeatureResourceEffectData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeatureResourceEffectData]s in the list and returns the inserted rows.
  ///
  /// The returned [FeatureResourceEffectData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceEffectData>> insert(
    _is.DatabaseSession session,
    List<FeatureResourceEffectData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeatureResourceEffectData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeatureResourceEffectData] and returns the inserted row.
  ///
  /// The returned [FeatureResourceEffectData] will have its `id` field set.
  Future<FeatureResourceEffectData> insertRow(
    _is.DatabaseSession session,
    FeatureResourceEffectData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeatureResourceEffectData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeatureResourceEffectData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [FeatureResourceEffectData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceEffectData>> upsert(
    _is.DatabaseSession session,
    List<FeatureResourceEffectData> rows, {
    required _is.ColumnSelections<FeatureResourceEffectDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureResourceEffectDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeatureResourceEffectData>(
      rows,
      conflictColumns: conflictColumns(FeatureResourceEffectData.t),
      updateColumns: updateColumns?.call(FeatureResourceEffectData.t),
      updateWhere: updateWhere?.call(FeatureResourceEffectData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeatureResourceEffectData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [FeatureResourceEffectData] will have its `id` field set.
  Future<FeatureResourceEffectData?> upsertRow(
    _is.DatabaseSession session,
    FeatureResourceEffectData row, {
    required _is.ColumnSelections<FeatureResourceEffectDataTable>
    conflictColumns,
    _is.ColumnSelections<FeatureResourceEffectDataTable>? updateColumns,
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeatureResourceEffectData>(
      row,
      conflictColumns: conflictColumns(FeatureResourceEffectData.t),
      updateColumns: updateColumns?.call(FeatureResourceEffectData.t),
      updateWhere: updateWhere?.call(FeatureResourceEffectData.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceEffectData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceEffectData>> update(
    _is.DatabaseSession session,
    List<FeatureResourceEffectData> rows, {
    _is.ColumnSelections<FeatureResourceEffectDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeatureResourceEffectData>(
      rows,
      columns: columns?.call(FeatureResourceEffectData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeatureResourceEffectData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeatureResourceEffectData> updateRow(
    _is.DatabaseSession session,
    FeatureResourceEffectData row, {
    _is.ColumnSelections<FeatureResourceEffectDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeatureResourceEffectData>(
      row,
      columns: columns?.call(FeatureResourceEffectData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeatureResourceEffectData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeatureResourceEffectData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeatureResourceEffectDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeatureResourceEffectData>(
      id,
      columnValues: columnValues(FeatureResourceEffectData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeatureResourceEffectData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceEffectData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeatureResourceEffectDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<FeatureResourceEffectDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeatureResourceEffectData>(
      columnValues: columnValues(FeatureResourceEffectData.t.updateTable),
      where: where(FeatureResourceEffectData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeatureResourceEffectData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceEffectData>> delete(
    _is.DatabaseSession session,
    List<FeatureResourceEffectData> rows, {
    _is.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeatureResourceEffectData>(
      rows,
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeatureResourceEffectData].
  Future<FeatureResourceEffectData> deleteRow(
    _is.DatabaseSession session,
    FeatureResourceEffectData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeatureResourceEffectData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeatureResourceEffectData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureResourceEffectDataTable> where,
    _is.OrderByBuilder<FeatureResourceEffectDataTable>? orderBy,
    _is.OrderByListBuilder<FeatureResourceEffectDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeatureResourceEffectData>(
      where: where(FeatureResourceEffectData.t),
      orderBy: orderBy?.call(FeatureResourceEffectData.t),
      orderByList: orderByList?.call(FeatureResourceEffectData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeatureResourceEffectDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeatureResourceEffectData>(
      where: where?.call(FeatureResourceEffectData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeatureResourceEffectData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeatureResourceEffectDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeatureResourceEffectData>(
      where: where(FeatureResourceEffectData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class FeatureResourceEffectDataAttachRowRepository {
  const FeatureResourceEffectDataAttachRowRepository._();

  /// Creates a relation between the given [FeatureResourceEffectData] and [ClassFeatureData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to refer to the [ClassFeatureData].
  Future<void> classFeature(
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData,
    _inxbtq9c.ClassFeatureData classFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (classFeature.id == null) {
      throw ArgumentError.notNull('classFeature.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      classFeatureId: classFeature.id,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceEffectData] and [SubclassFeatureData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to refer to the [SubclassFeatureData].
  Future<void> subclassFeature(
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData,
    _i6bcyp7i.SubclassFeatureData subclassFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (subclassFeature.id == null) {
      throw ArgumentError.notNull('subclassFeature.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      subclassFeatureId: subclassFeature.id,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceEffectData] and [RaceFeatureData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `raceFeatureId` to refer to the [RaceFeatureData].
  Future<void> raceFeature(
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData,
    _iga2jap7.RaceFeatureData raceFeature, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (raceFeature.id == null) {
      throw ArgumentError.notNull('raceFeature.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      raceFeatureId: raceFeature.id,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [FeatureResourceEffectData] and [ChoiceOptionData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `choiceOptionId` to refer to the [ChoiceOptionData].
  Future<void> choiceOption(
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData,
    _iu6wj5qy.ChoiceOptionData choiceOption, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (choiceOption.id == null) {
      throw ArgumentError.notNull('choiceOption.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      choiceOptionId: choiceOption.id,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.choiceOptionId],
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
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      classFeatureId: null,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
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
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      subclassFeatureId: null,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
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
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      raceFeatureId: null,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.raceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [FeatureResourceEffectData] and the [ChoiceOptionData] set in `choiceOption`
  /// by setting the [FeatureResourceEffectData]'s foreign key `choiceOptionId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> choiceOption(
    _is.DatabaseSession session,
    FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      choiceOptionId: null,
    );
    await session.db.updateRow<FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [FeatureResourceEffectData.t.choiceOptionId],
      transaction: transaction,
    );
  }
}
