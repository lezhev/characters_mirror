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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/spell/spell_scaling_mode.dart' as _izmib1zd;

abstract class SpellScalingData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SpellScalingData._({
    this.mode,
    this.scalingBySlotLevel,
    this.scalingByCasterLevel,
    this.notes,
  });

  factory SpellScalingData({
    _izmib1zd.SpellScalingMode? mode,
    Map<int, String>? scalingBySlotLevel,
    Map<int, String>? scalingByCasterLevel,
    String? notes,
  }) = _SpellScalingDataImpl;

  factory SpellScalingData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpellScalingData(
      mode: jsonSerialization['mode'] == null
          ? null
          : _izmib1zd.SpellScalingMode.fromJson(
              (jsonSerialization['mode'] as String),
            ),
      scalingBySlotLevel: jsonSerialization['scalingBySlotLevel'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, String>>(
              jsonSerialization['scalingBySlotLevel'],
            ),
      scalingByCasterLevel: jsonSerialization['scalingByCasterLevel'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, String>>(
              jsonSerialization['scalingByCasterLevel'],
            ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  _izmib1zd.SpellScalingMode? mode;

  Map<int, String>? scalingBySlotLevel;

  Map<int, String>? scalingByCasterLevel;

  String? notes;

  /// Returns a shallow copy of this [SpellScalingData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SpellScalingData copyWith({
    _izmib1zd.SpellScalingMode? mode,
    Map<int, String>? scalingBySlotLevel,
    Map<int, String>? scalingByCasterLevel,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellScalingData',
      if (mode != null) 'mode': mode?.toJson(),
      if (scalingBySlotLevel != null)
        'scalingBySlotLevel': scalingBySlotLevel?.toJson(),
      if (scalingByCasterLevel != null)
        'scalingByCasterLevel': scalingByCasterLevel?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellScalingData',
      if (mode != null) 'mode': mode?.toJson(),
      if (scalingBySlotLevel != null)
        'scalingBySlotLevel': scalingBySlotLevel?.toJson(),
      if (scalingByCasterLevel != null)
        'scalingByCasterLevel': scalingByCasterLevel?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellScalingDataImpl extends SpellScalingData {
  _SpellScalingDataImpl({
    _izmib1zd.SpellScalingMode? mode,
    Map<int, String>? scalingBySlotLevel,
    Map<int, String>? scalingByCasterLevel,
    String? notes,
  }) : super._(
         mode: mode,
         scalingBySlotLevel: scalingBySlotLevel,
         scalingByCasterLevel: scalingByCasterLevel,
         notes: notes,
       );

  /// Returns a shallow copy of this [SpellScalingData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SpellScalingData copyWith({
    Object? mode = _Undefined,
    Object? scalingBySlotLevel = _Undefined,
    Object? scalingByCasterLevel = _Undefined,
    Object? notes = _Undefined,
  }) {
    return SpellScalingData(
      mode: mode is _izmib1zd.SpellScalingMode? ? mode : this.mode,
      scalingBySlotLevel: scalingBySlotLevel is Map<int, String>?
          ? scalingBySlotLevel
          : this.scalingBySlotLevel?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      scalingByCasterLevel: scalingByCasterLevel is Map<int, String>?
          ? scalingByCasterLevel
          : this.scalingByCasterLevel?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
