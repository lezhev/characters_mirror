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
import '../../enums/spell/spell_school.dart' as _iusxccb8;
import '../../enums/spell_slot_recovery_mode.dart' as _iyp7lwq1;

abstract class SpellSlotRecoveryPolicyData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SpellSlotRecoveryPolicyData._({
    required this.mode,
    this.resourceKey,
    this.levelBudgetBySourceLevel,
    this.maximumSlotLevel,
    this.minimumCastLevel,
    this.spellSchool,
    this.activationSeconds,
  });

  factory SpellSlotRecoveryPolicyData({
    required _iyp7lwq1.SpellSlotRecoveryMode mode,
    String? resourceKey,
    Map<int, int>? levelBudgetBySourceLevel,
    int? maximumSlotLevel,
    int? minimumCastLevel,
    _iusxccb8.SpellSchool? spellSchool,
    int? activationSeconds,
  }) = _SpellSlotRecoveryPolicyDataImpl;

  factory SpellSlotRecoveryPolicyData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SpellSlotRecoveryPolicyData(
      mode: _iyp7lwq1.SpellSlotRecoveryMode.fromJson(
        (jsonSerialization['mode'] as String),
      ),
      resourceKey: jsonSerialization['resourceKey'] as String?,
      levelBudgetBySourceLevel:
          jsonSerialization['levelBudgetBySourceLevel'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['levelBudgetBySourceLevel'],
            ),
      maximumSlotLevel: jsonSerialization['maximumSlotLevel'] as int?,
      minimumCastLevel: jsonSerialization['minimumCastLevel'] as int?,
      spellSchool: jsonSerialization['spellSchool'] == null
          ? null
          : _iusxccb8.SpellSchool.fromJson(
              (jsonSerialization['spellSchool'] as String),
            ),
      activationSeconds: jsonSerialization['activationSeconds'] as int?,
    );
  }

  _iyp7lwq1.SpellSlotRecoveryMode mode;

  String? resourceKey;

  Map<int, int>? levelBudgetBySourceLevel;

  int? maximumSlotLevel;

  int? minimumCastLevel;

  _iusxccb8.SpellSchool? spellSchool;

  int? activationSeconds;

  /// Returns a shallow copy of this [SpellSlotRecoveryPolicyData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SpellSlotRecoveryPolicyData copyWith({
    _iyp7lwq1.SpellSlotRecoveryMode? mode,
    String? resourceKey,
    Map<int, int>? levelBudgetBySourceLevel,
    int? maximumSlotLevel,
    int? minimumCastLevel,
    _iusxccb8.SpellSchool? spellSchool,
    int? activationSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellSlotRecoveryPolicyData',
      'mode': mode.toJson(),
      if (resourceKey != null) 'resourceKey': resourceKey,
      if (levelBudgetBySourceLevel != null)
        'levelBudgetBySourceLevel': levelBudgetBySourceLevel?.toJson(),
      if (maximumSlotLevel != null) 'maximumSlotLevel': maximumSlotLevel,
      if (minimumCastLevel != null) 'minimumCastLevel': minimumCastLevel,
      if (spellSchool != null) 'spellSchool': spellSchool?.toJson(),
      if (activationSeconds != null) 'activationSeconds': activationSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellSlotRecoveryPolicyData',
      'mode': mode.toJson(),
      if (resourceKey != null) 'resourceKey': resourceKey,
      if (levelBudgetBySourceLevel != null)
        'levelBudgetBySourceLevel': levelBudgetBySourceLevel?.toJson(),
      if (maximumSlotLevel != null) 'maximumSlotLevel': maximumSlotLevel,
      if (minimumCastLevel != null) 'minimumCastLevel': minimumCastLevel,
      if (spellSchool != null) 'spellSchool': spellSchool?.toJson(),
      if (activationSeconds != null) 'activationSeconds': activationSeconds,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSlotRecoveryPolicyDataImpl extends SpellSlotRecoveryPolicyData {
  _SpellSlotRecoveryPolicyDataImpl({
    required _iyp7lwq1.SpellSlotRecoveryMode mode,
    String? resourceKey,
    Map<int, int>? levelBudgetBySourceLevel,
    int? maximumSlotLevel,
    int? minimumCastLevel,
    _iusxccb8.SpellSchool? spellSchool,
    int? activationSeconds,
  }) : super._(
         mode: mode,
         resourceKey: resourceKey,
         levelBudgetBySourceLevel: levelBudgetBySourceLevel,
         maximumSlotLevel: maximumSlotLevel,
         minimumCastLevel: minimumCastLevel,
         spellSchool: spellSchool,
         activationSeconds: activationSeconds,
       );

  /// Returns a shallow copy of this [SpellSlotRecoveryPolicyData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SpellSlotRecoveryPolicyData copyWith({
    _iyp7lwq1.SpellSlotRecoveryMode? mode,
    Object? resourceKey = _Undefined,
    Object? levelBudgetBySourceLevel = _Undefined,
    Object? maximumSlotLevel = _Undefined,
    Object? minimumCastLevel = _Undefined,
    Object? spellSchool = _Undefined,
    Object? activationSeconds = _Undefined,
  }) {
    return SpellSlotRecoveryPolicyData(
      mode: mode ?? this.mode,
      resourceKey: resourceKey is String? ? resourceKey : this.resourceKey,
      levelBudgetBySourceLevel: levelBudgetBySourceLevel is Map<int, int>?
          ? levelBudgetBySourceLevel
          : this.levelBudgetBySourceLevel?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      maximumSlotLevel: maximumSlotLevel is int?
          ? maximumSlotLevel
          : this.maximumSlotLevel,
      minimumCastLevel: minimumCastLevel is int?
          ? minimumCastLevel
          : this.minimumCastLevel,
      spellSchool: spellSchool is _iusxccb8.SpellSchool?
          ? spellSchool
          : this.spellSchool,
      activationSeconds: activationSeconds is int?
          ? activationSeconds
          : this.activationSeconds,
    );
  }
}
