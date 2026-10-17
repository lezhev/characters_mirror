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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../enums/feature_resource_trigger.dart' as _i8tdz0hj;

abstract class SpellSlotRecoveryTriggerData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SpellSlotRecoveryTriggerData._({
    required this.sourceActionId,
    required this.trigger,
    this.castLevel,
  });

  factory SpellSlotRecoveryTriggerData({
    required String sourceActionId,
    required _i8tdz0hj.FeatureResourceTrigger trigger,
    int? castLevel,
  }) = _SpellSlotRecoveryTriggerDataImpl;

  factory SpellSlotRecoveryTriggerData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SpellSlotRecoveryTriggerData(
      sourceActionId: jsonSerialization['sourceActionId'] as String,
      trigger: _i8tdz0hj.FeatureResourceTrigger.fromJson(
        (jsonSerialization['trigger'] as String),
      ),
      castLevel: jsonSerialization['castLevel'] as int?,
    );
  }

  String sourceActionId;

  _i8tdz0hj.FeatureResourceTrigger trigger;

  int? castLevel;

  /// Returns a shallow copy of this [SpellSlotRecoveryTriggerData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SpellSlotRecoveryTriggerData copyWith({
    String? sourceActionId,
    _i8tdz0hj.FeatureResourceTrigger? trigger,
    int? castLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellSlotRecoveryTriggerData',
      'sourceActionId': sourceActionId,
      'trigger': trigger.toJson(),
      if (castLevel != null) 'castLevel': castLevel,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellSlotRecoveryTriggerData',
      'sourceActionId': sourceActionId,
      'trigger': trigger.toJson(),
      if (castLevel != null) 'castLevel': castLevel,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSlotRecoveryTriggerDataImpl extends SpellSlotRecoveryTriggerData {
  _SpellSlotRecoveryTriggerDataImpl({
    required String sourceActionId,
    required _i8tdz0hj.FeatureResourceTrigger trigger,
    int? castLevel,
  }) : super._(
         sourceActionId: sourceActionId,
         trigger: trigger,
         castLevel: castLevel,
       );

  /// Returns a shallow copy of this [SpellSlotRecoveryTriggerData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SpellSlotRecoveryTriggerData copyWith({
    String? sourceActionId,
    _i8tdz0hj.FeatureResourceTrigger? trigger,
    Object? castLevel = _Undefined,
  }) {
    return SpellSlotRecoveryTriggerData(
      sourceActionId: sourceActionId ?? this.sourceActionId,
      trigger: trigger ?? this.trigger,
      castLevel: castLevel is int? ? castLevel : this.castLevel,
    );
  }
}
