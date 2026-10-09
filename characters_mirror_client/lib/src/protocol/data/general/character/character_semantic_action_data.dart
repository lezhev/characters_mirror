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
import '../../../enums/character_feature_source_type.dart' as _i2;
import '../../../enums/rest_type.dart' as _i3;

abstract class CharacterSemanticActionData implements _i1.SerializableModel {
  CharacterSemanticActionData._({
    this.spellPayment,
    this.amount,
    this.delta,
    this.level,
    this.spellKey,
    this.spellSourceKey,
    this.slotSource,
    this.spellName,
    this.startsConcentration,
    this.dieKind,
    this.sourceType,
    this.sourceId,
    this.resourceKey,
    this.restType,
    this.baseBarrierTokens,
    this.recoveryEffectId,
    this.slotsToRestore,
    this.recoveryTriggerId,
  });

  factory CharacterSemanticActionData({
    String? spellPayment,
    int? amount,
    int? delta,
    int? level,
    String? spellKey,
    String? spellSourceKey,
    String? slotSource,
    String? spellName,
    bool? startsConcentration,
    String? dieKind,
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? resourceKey,
    _i3.RestType? restType,
    Map<String, String>? baseBarrierTokens,
    int? recoveryEffectId,
    Map<int, int>? slotsToRestore,
    String? recoveryTriggerId,
  }) = _CharacterSemanticActionDataImpl;

  factory CharacterSemanticActionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSemanticActionData(
      spellPayment: jsonSerialization['spellPayment'] as String?,
      amount: jsonSerialization['amount'] as int?,
      delta: jsonSerialization['delta'] as int?,
      level: jsonSerialization['level'] as int?,
      spellKey: jsonSerialization['spellKey'] as String?,
      spellSourceKey: jsonSerialization['spellSourceKey'] as String?,
      slotSource: jsonSerialization['slotSource'] as String?,
      spellName: jsonSerialization['spellName'] as String?,
      startsConcentration: jsonSerialization['startsConcentration'] as bool?,
      dieKind: jsonSerialization['dieKind'] as String?,
      sourceType: jsonSerialization['sourceType'] == null
          ? null
          : _i2.CharacterFeatureSourceType.fromJson(
              (jsonSerialization['sourceType'] as String)),
      sourceId: jsonSerialization['sourceId'] as int?,
      resourceKey: jsonSerialization['resourceKey'] as String?,
      restType: jsonSerialization['restType'] == null
          ? null
          : _i3.RestType.fromJson((jsonSerialization['restType'] as String)),
      baseBarrierTokens: (jsonSerialization['baseBarrierTokens'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
      recoveryEffectId: jsonSerialization['recoveryEffectId'] as int?,
      slotsToRestore: (jsonSerialization['slotsToRestore'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      recoveryTriggerId: jsonSerialization['recoveryTriggerId'] as String?,
    );
  }

  String? spellPayment;

  int? amount;

  int? delta;

  int? level;

  String? spellKey;

  String? spellSourceKey;

  String? slotSource;

  String? spellName;

  bool? startsConcentration;

  String? dieKind;

  _i2.CharacterFeatureSourceType? sourceType;

  int? sourceId;

  String? resourceKey;

  _i3.RestType? restType;

  Map<String, String>? baseBarrierTokens;

  int? recoveryEffectId;

  Map<int, int>? slotsToRestore;

  String? recoveryTriggerId;

  /// Returns a shallow copy of this [CharacterSemanticActionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSemanticActionData copyWith({
    String? spellPayment,
    int? amount,
    int? delta,
    int? level,
    String? spellKey,
    String? spellSourceKey,
    String? slotSource,
    String? spellName,
    bool? startsConcentration,
    String? dieKind,
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? resourceKey,
    _i3.RestType? restType,
    Map<String, String>? baseBarrierTokens,
    int? recoveryEffectId,
    Map<int, int>? slotsToRestore,
    String? recoveryTriggerId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (spellPayment != null) 'spellPayment': spellPayment,
      if (amount != null) 'amount': amount,
      if (delta != null) 'delta': delta,
      if (level != null) 'level': level,
      if (spellKey != null) 'spellKey': spellKey,
      if (spellSourceKey != null) 'spellSourceKey': spellSourceKey,
      if (slotSource != null) 'slotSource': slotSource,
      if (spellName != null) 'spellName': spellName,
      if (startsConcentration != null)
        'startsConcentration': startsConcentration,
      if (dieKind != null) 'dieKind': dieKind,
      if (sourceType != null) 'sourceType': sourceType?.toJson(),
      if (sourceId != null) 'sourceId': sourceId,
      if (resourceKey != null) 'resourceKey': resourceKey,
      if (restType != null) 'restType': restType?.toJson(),
      if (baseBarrierTokens != null)
        'baseBarrierTokens': baseBarrierTokens?.toJson(),
      if (recoveryEffectId != null) 'recoveryEffectId': recoveryEffectId,
      if (slotsToRestore != null) 'slotsToRestore': slotsToRestore?.toJson(),
      if (recoveryTriggerId != null) 'recoveryTriggerId': recoveryTriggerId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSemanticActionDataImpl extends CharacterSemanticActionData {
  _CharacterSemanticActionDataImpl({
    String? spellPayment,
    int? amount,
    int? delta,
    int? level,
    String? spellKey,
    String? spellSourceKey,
    String? slotSource,
    String? spellName,
    bool? startsConcentration,
    String? dieKind,
    _i2.CharacterFeatureSourceType? sourceType,
    int? sourceId,
    String? resourceKey,
    _i3.RestType? restType,
    Map<String, String>? baseBarrierTokens,
    int? recoveryEffectId,
    Map<int, int>? slotsToRestore,
    String? recoveryTriggerId,
  }) : super._(
          spellPayment: spellPayment,
          amount: amount,
          delta: delta,
          level: level,
          spellKey: spellKey,
          spellSourceKey: spellSourceKey,
          slotSource: slotSource,
          spellName: spellName,
          startsConcentration: startsConcentration,
          dieKind: dieKind,
          sourceType: sourceType,
          sourceId: sourceId,
          resourceKey: resourceKey,
          restType: restType,
          baseBarrierTokens: baseBarrierTokens,
          recoveryEffectId: recoveryEffectId,
          slotsToRestore: slotsToRestore,
          recoveryTriggerId: recoveryTriggerId,
        );

  /// Returns a shallow copy of this [CharacterSemanticActionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSemanticActionData copyWith({
    Object? spellPayment = _Undefined,
    Object? amount = _Undefined,
    Object? delta = _Undefined,
    Object? level = _Undefined,
    Object? spellKey = _Undefined,
    Object? spellSourceKey = _Undefined,
    Object? slotSource = _Undefined,
    Object? spellName = _Undefined,
    Object? startsConcentration = _Undefined,
    Object? dieKind = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? resourceKey = _Undefined,
    Object? restType = _Undefined,
    Object? baseBarrierTokens = _Undefined,
    Object? recoveryEffectId = _Undefined,
    Object? slotsToRestore = _Undefined,
    Object? recoveryTriggerId = _Undefined,
  }) {
    return CharacterSemanticActionData(
      spellPayment: spellPayment is String? ? spellPayment : this.spellPayment,
      amount: amount is int? ? amount : this.amount,
      delta: delta is int? ? delta : this.delta,
      level: level is int? ? level : this.level,
      spellKey: spellKey is String? ? spellKey : this.spellKey,
      spellSourceKey:
          spellSourceKey is String? ? spellSourceKey : this.spellSourceKey,
      slotSource: slotSource is String? ? slotSource : this.slotSource,
      spellName: spellName is String? ? spellName : this.spellName,
      startsConcentration: startsConcentration is bool?
          ? startsConcentration
          : this.startsConcentration,
      dieKind: dieKind is String? ? dieKind : this.dieKind,
      sourceType: sourceType is _i2.CharacterFeatureSourceType?
          ? sourceType
          : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      resourceKey: resourceKey is String? ? resourceKey : this.resourceKey,
      restType: restType is _i3.RestType? ? restType : this.restType,
      baseBarrierTokens: baseBarrierTokens is Map<String, String>?
          ? baseBarrierTokens
          : this.baseBarrierTokens?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      recoveryEffectId:
          recoveryEffectId is int? ? recoveryEffectId : this.recoveryEffectId,
      slotsToRestore: slotsToRestore is Map<int, int>?
          ? slotsToRestore
          : this.slotsToRestore?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      recoveryTriggerId: recoveryTriggerId is String?
          ? recoveryTriggerId
          : this.recoveryTriggerId,
    );
  }
}
