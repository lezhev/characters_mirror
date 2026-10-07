/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../enums/character_feature_source_type.dart' as _i2;
import '../../../enums/rest_type.dart' as _i3;

abstract class CharacterSemanticActionData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterSemanticActionData._({
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
  });

  factory CharacterSemanticActionData({
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
  }) = _CharacterSemanticActionDataImpl;

  factory CharacterSemanticActionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSemanticActionData(
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
    );
  }

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

  /// Returns a shallow copy of this [CharacterSemanticActionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSemanticActionData copyWith({
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
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
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
  }) : super._(
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
        );

  /// Returns a shallow copy of this [CharacterSemanticActionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSemanticActionData copyWith({
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
  }) {
    return CharacterSemanticActionData(
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
    );
  }
}
