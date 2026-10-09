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
import '../../data/general/spell_resource_upcast_policy_data.dart' as _i2;
import '../../enums/rest_type.dart' as _i3;

abstract class SpellActivationData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SpellActivationData._({
    required this.canUseStandardSlots,
    required this.canUsePactSlots,
    required this.slotless,
    required this.atWill,
    this.resourceKey,
    this.resourceCost,
    this.resourceUpcastPolicy,
    this.freeCasts,
    this.resetOn,
    this.maxCasts,
    this.castsResetOn,
    this.castAtSpellLevel,
  });

  factory SpellActivationData({
    required bool canUseStandardSlots,
    required bool canUsePactSlots,
    required bool slotless,
    required bool atWill,
    String? resourceKey,
    int? resourceCost,
    _i2.SpellResourceUpcastPolicyData? resourceUpcastPolicy,
    int? freeCasts,
    _i3.RestType? resetOn,
    int? maxCasts,
    _i3.RestType? castsResetOn,
    int? castAtSpellLevel,
  }) = _SpellActivationDataImpl;

  factory SpellActivationData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpellActivationData(
      canUseStandardSlots: jsonSerialization['canUseStandardSlots'] as bool,
      canUsePactSlots: jsonSerialization['canUsePactSlots'] as bool,
      slotless: jsonSerialization['slotless'] as bool,
      atWill: jsonSerialization['atWill'] as bool,
      resourceKey: jsonSerialization['resourceKey'] as String?,
      resourceCost: jsonSerialization['resourceCost'] as int?,
      resourceUpcastPolicy: jsonSerialization['resourceUpcastPolicy'] == null
          ? null
          : _i2.SpellResourceUpcastPolicyData.fromJson(
              (jsonSerialization['resourceUpcastPolicy']
                  as Map<String, dynamic>)),
      freeCasts: jsonSerialization['freeCasts'] as int?,
      resetOn: jsonSerialization['resetOn'] == null
          ? null
          : _i3.RestType.fromJson((jsonSerialization['resetOn'] as String)),
      maxCasts: jsonSerialization['maxCasts'] as int?,
      castsResetOn: jsonSerialization['castsResetOn'] == null
          ? null
          : _i3.RestType.fromJson(
              (jsonSerialization['castsResetOn'] as String)),
      castAtSpellLevel: jsonSerialization['castAtSpellLevel'] as int?,
    );
  }

  bool canUseStandardSlots;

  bool canUsePactSlots;

  bool slotless;

  bool atWill;

  String? resourceKey;

  int? resourceCost;

  _i2.SpellResourceUpcastPolicyData? resourceUpcastPolicy;

  int? freeCasts;

  _i3.RestType? resetOn;

  int? maxCasts;

  _i3.RestType? castsResetOn;

  int? castAtSpellLevel;

  /// Returns a shallow copy of this [SpellActivationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellActivationData copyWith({
    bool? canUseStandardSlots,
    bool? canUsePactSlots,
    bool? slotless,
    bool? atWill,
    String? resourceKey,
    int? resourceCost,
    _i2.SpellResourceUpcastPolicyData? resourceUpcastPolicy,
    int? freeCasts,
    _i3.RestType? resetOn,
    int? maxCasts,
    _i3.RestType? castsResetOn,
    int? castAtSpellLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'canUseStandardSlots': canUseStandardSlots,
      'canUsePactSlots': canUsePactSlots,
      'slotless': slotless,
      'atWill': atWill,
      if (resourceKey != null) 'resourceKey': resourceKey,
      if (resourceCost != null) 'resourceCost': resourceCost,
      if (resourceUpcastPolicy != null)
        'resourceUpcastPolicy': resourceUpcastPolicy?.toJson(),
      if (freeCasts != null) 'freeCasts': freeCasts,
      if (resetOn != null) 'resetOn': resetOn?.toJson(),
      if (maxCasts != null) 'maxCasts': maxCasts,
      if (castsResetOn != null) 'castsResetOn': castsResetOn?.toJson(),
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'canUseStandardSlots': canUseStandardSlots,
      'canUsePactSlots': canUsePactSlots,
      'slotless': slotless,
      'atWill': atWill,
      if (resourceKey != null) 'resourceKey': resourceKey,
      if (resourceCost != null) 'resourceCost': resourceCost,
      if (resourceUpcastPolicy != null)
        'resourceUpcastPolicy': resourceUpcastPolicy?.toJsonForProtocol(),
      if (freeCasts != null) 'freeCasts': freeCasts,
      if (resetOn != null) 'resetOn': resetOn?.toJson(),
      if (maxCasts != null) 'maxCasts': maxCasts,
      if (castsResetOn != null) 'castsResetOn': castsResetOn?.toJson(),
      if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellActivationDataImpl extends SpellActivationData {
  _SpellActivationDataImpl({
    required bool canUseStandardSlots,
    required bool canUsePactSlots,
    required bool slotless,
    required bool atWill,
    String? resourceKey,
    int? resourceCost,
    _i2.SpellResourceUpcastPolicyData? resourceUpcastPolicy,
    int? freeCasts,
    _i3.RestType? resetOn,
    int? maxCasts,
    _i3.RestType? castsResetOn,
    int? castAtSpellLevel,
  }) : super._(
          canUseStandardSlots: canUseStandardSlots,
          canUsePactSlots: canUsePactSlots,
          slotless: slotless,
          atWill: atWill,
          resourceKey: resourceKey,
          resourceCost: resourceCost,
          resourceUpcastPolicy: resourceUpcastPolicy,
          freeCasts: freeCasts,
          resetOn: resetOn,
          maxCasts: maxCasts,
          castsResetOn: castsResetOn,
          castAtSpellLevel: castAtSpellLevel,
        );

  /// Returns a shallow copy of this [SpellActivationData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellActivationData copyWith({
    bool? canUseStandardSlots,
    bool? canUsePactSlots,
    bool? slotless,
    bool? atWill,
    Object? resourceKey = _Undefined,
    Object? resourceCost = _Undefined,
    Object? resourceUpcastPolicy = _Undefined,
    Object? freeCasts = _Undefined,
    Object? resetOn = _Undefined,
    Object? maxCasts = _Undefined,
    Object? castsResetOn = _Undefined,
    Object? castAtSpellLevel = _Undefined,
  }) {
    return SpellActivationData(
      canUseStandardSlots: canUseStandardSlots ?? this.canUseStandardSlots,
      canUsePactSlots: canUsePactSlots ?? this.canUsePactSlots,
      slotless: slotless ?? this.slotless,
      atWill: atWill ?? this.atWill,
      resourceKey: resourceKey is String? ? resourceKey : this.resourceKey,
      resourceCost: resourceCost is int? ? resourceCost : this.resourceCost,
      resourceUpcastPolicy:
          resourceUpcastPolicy is _i2.SpellResourceUpcastPolicyData?
              ? resourceUpcastPolicy
              : this.resourceUpcastPolicy?.copyWith(),
      freeCasts: freeCasts is int? ? freeCasts : this.freeCasts,
      resetOn: resetOn is _i3.RestType? ? resetOn : this.resetOn,
      maxCasts: maxCasts is int? ? maxCasts : this.maxCasts,
      castsResetOn:
          castsResetOn is _i3.RestType? ? castsResetOn : this.castsResetOn,
      castAtSpellLevel:
          castAtSpellLevel is int? ? castAtSpellLevel : this.castAtSpellLevel,
    );
  }
}
