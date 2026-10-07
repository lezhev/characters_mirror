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
import '../enums/ability.dart' as _i2;
import '../enums/rest_type.dart' as _i3;

abstract class SpellSourceContextData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    int? castAtSpellLevel,
    String? freeCastsFormula,
    _i3.RestType? freeCastsPerRest,
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
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
      freeCastsFormula: jsonSerialization['freeCastsFormula'] as String?,
      freeCastsPerRest: jsonSerialization['freeCastsPerRest'] == null
          ? null
          : _i3.RestType.fromJson(
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

  int? castAtSpellLevel;

  String? freeCastsFormula;

  _i3.RestType? freeCastsPerRest;

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
    int? castAtSpellLevel,
    String? freeCastsFormula,
    _i3.RestType? freeCastsPerRest,
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
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
      if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
      if (freeCastsPerRest != null)
        'freeCastsPerRest': freeCastsPerRest?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
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
    int? castAtSpellLevel,
    String? freeCastsFormula,
    _i3.RestType? freeCastsPerRest,
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
      castAtSpellLevel:
          castAtSpellLevel is int? ? castAtSpellLevel : this.castAtSpellLevel,
      freeCastsFormula: freeCastsFormula is String?
          ? freeCastsFormula
          : this.freeCastsFormula,
      freeCastsPerRest: freeCastsPerRest is _i3.RestType?
          ? freeCastsPerRest
          : this.freeCastsPerRest,
    );
  }
}
