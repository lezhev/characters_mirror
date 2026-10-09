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
import '../enums/ability.dart' as _i2;
import '../data/general/spell_activation_data.dart' as _i3;
import '../enums/character_feature_source_type.dart' as _i4;
import '../enums/rest_type.dart' as _i5;

abstract class SpellSourceContextData implements _i1.SerializableModel {
  SpellSourceContextData._({
    required this.sourceKey,
    required this.label,
    this.classDataId,
    this.castingAbility,
    required this.known,
    required this.prepared,
    required this.alwaysPrepared,
    required this.granted,
    required this.canUseSlots,
    this.activation,
    this.resourceSourceType,
    this.resourceSourceId,
    this.castAtSpellLevel,
    this.freeCastsFormula,
    this.freeCastsPerRest,
  });

  factory SpellSourceContextData({
    required String sourceKey,
    required String label,
    int? classDataId,
    _i2.Ability? castingAbility,
    required bool known,
    required bool prepared,
    required bool alwaysPrepared,
    required bool granted,
    required bool canUseSlots,
    _i3.SpellActivationData? activation,
    _i4.CharacterFeatureSourceType? resourceSourceType,
    int? resourceSourceId,
    int? castAtSpellLevel,
    String? freeCastsFormula,
    _i5.RestType? freeCastsPerRest,
  }) = _SpellSourceContextDataImpl;

  factory SpellSourceContextData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellSourceContextData(
      sourceKey: jsonSerialization['sourceKey'] as String,
      label: jsonSerialization['label'] as String,
      classDataId: jsonSerialization['classDataId'] as int?,
      castingAbility: jsonSerialization['castingAbility'] == null
          ? null
          : _i2.Ability.fromJson(
              (jsonSerialization['castingAbility'] as String)),
      known: jsonSerialization['known'] as bool,
      prepared: jsonSerialization['prepared'] as bool,
      alwaysPrepared: jsonSerialization['alwaysPrepared'] as bool,
      granted: jsonSerialization['granted'] as bool,
      canUseSlots: jsonSerialization['canUseSlots'] as bool,
      activation: jsonSerialization['activation'] == null
          ? null
          : _i3.SpellActivationData.fromJson(
              (jsonSerialization['activation'] as Map<String, dynamic>)),
      resourceSourceType: jsonSerialization['resourceSourceType'] == null
          ? null
          : _i4.CharacterFeatureSourceType.fromJson(
              (jsonSerialization['resourceSourceType'] as String)),
      resourceSourceId: jsonSerialization['resourceSourceId'] as int?,
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
      freeCastsFormula: jsonSerialization['freeCastsFormula'] as String?,
      freeCastsPerRest: jsonSerialization['freeCastsPerRest'] == null
          ? null
          : _i5.RestType.fromJson(
              (jsonSerialization['freeCastsPerRest'] as String)),
    );
  }

  String sourceKey;

  String label;

  int? classDataId;

  _i2.Ability? castingAbility;

  bool known;

  bool prepared;

  bool alwaysPrepared;

  bool granted;

  bool canUseSlots;

  _i3.SpellActivationData? activation;

  _i4.CharacterFeatureSourceType? resourceSourceType;

  int? resourceSourceId;

  int? castAtSpellLevel;

  String? freeCastsFormula;

  _i5.RestType? freeCastsPerRest;

  /// Returns a shallow copy of this [SpellSourceContextData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellSourceContextData copyWith({
    String? sourceKey,
    String? label,
    int? classDataId,
    _i2.Ability? castingAbility,
    bool? known,
    bool? prepared,
    bool? alwaysPrepared,
    bool? granted,
    bool? canUseSlots,
    _i3.SpellActivationData? activation,
    _i4.CharacterFeatureSourceType? resourceSourceType,
    int? resourceSourceId,
    int? castAtSpellLevel,
    String? freeCastsFormula,
    _i5.RestType? freeCastsPerRest,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'sourceKey': sourceKey,
      'label': label,
      if (classDataId != null) 'classDataId': classDataId,
      if (castingAbility != null) 'castingAbility': castingAbility?.toJson(),
      'known': known,
      'prepared': prepared,
      'alwaysPrepared': alwaysPrepared,
      'granted': granted,
      'canUseSlots': canUseSlots,
      if (activation != null) 'activation': activation?.toJson(),
      if (resourceSourceType != null)
        'resourceSourceType': resourceSourceType?.toJson(),
      if (resourceSourceId != null) 'resourceSourceId': resourceSourceId,
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSourceContextDataImpl extends SpellSourceContextData {
  _SpellSourceContextDataImpl({
    required String sourceKey,
    required String label,
    int? classDataId,
    _i2.Ability? castingAbility,
    required bool known,
    required bool prepared,
    required bool alwaysPrepared,
    required bool granted,
    required bool canUseSlots,
    _i3.SpellActivationData? activation,
    _i4.CharacterFeatureSourceType? resourceSourceType,
    int? resourceSourceId,
    int? castAtSpellLevel,
    String? freeCastsFormula,
    _i5.RestType? freeCastsPerRest,
  }) : super._(
          sourceKey: sourceKey,
          label: label,
          classDataId: classDataId,
          castingAbility: castingAbility,
          known: known,
          prepared: prepared,
          alwaysPrepared: alwaysPrepared,
          granted: granted,
          canUseSlots: canUseSlots,
          activation: activation,
          resourceSourceType: resourceSourceType,
          resourceSourceId: resourceSourceId,
          castAtSpellLevel: castAtSpellLevel,
          freeCastsFormula: freeCastsFormula,
          freeCastsPerRest: freeCastsPerRest,
        );

  /// Returns a shallow copy of this [SpellSourceContextData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellSourceContextData copyWith({
    String? sourceKey,
    String? label,
    Object? classDataId = _Undefined,
    Object? castingAbility = _Undefined,
    bool? known,
    bool? prepared,
    bool? alwaysPrepared,
    bool? granted,
    bool? canUseSlots,
    Object? activation = _Undefined,
    Object? resourceSourceType = _Undefined,
    Object? resourceSourceId = _Undefined,
    Object? castAtSpellLevel = _Undefined,
    Object? freeCastsFormula = _Undefined,
    Object? freeCastsPerRest = _Undefined,
  }) {
    return SpellSourceContextData(
      sourceKey: sourceKey ?? this.sourceKey,
      label: label ?? this.label,
      classDataId: classDataId is int? ? classDataId : this.classDataId,
      castingAbility:
          castingAbility is _i2.Ability? ? castingAbility : this.castingAbility,
      known: known ?? this.known,
      prepared: prepared ?? this.prepared,
      alwaysPrepared: alwaysPrepared ?? this.alwaysPrepared,
      granted: granted ?? this.granted,
      canUseSlots: canUseSlots ?? this.canUseSlots,
      activation: activation is _i3.SpellActivationData?
          ? activation
          : this.activation?.copyWith(),
      resourceSourceType: resourceSourceType is _i4.CharacterFeatureSourceType?
          ? resourceSourceType
          : this.resourceSourceType,
      resourceSourceId:
          resourceSourceId is int? ? resourceSourceId : this.resourceSourceId,
      castAtSpellLevel:
          castAtSpellLevel is int? ? castAtSpellLevel : this.castAtSpellLevel,
      freeCastsFormula: freeCastsFormula is String?
          ? freeCastsFormula
          : this.freeCastsFormula,
      freeCastsPerRest: freeCastsPerRest is _i5.RestType?
          ? freeCastsPerRest
          : this.freeCastsPerRest,
    );
  }
}
