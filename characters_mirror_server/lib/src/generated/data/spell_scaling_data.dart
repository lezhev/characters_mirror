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
import '../enums/spell_scaling_mode.dart' as _i2;

abstract class SpellScalingData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SpellScalingData._({
    this.mode,
    this.scalingBySlotLevel,
    this.scalingByCasterLevel,
    this.notes,
  });

  factory SpellScalingData({
    _i2.SpellScalingMode? mode,
    Map<int, String>? scalingBySlotLevel,
    Map<int, String>? scalingByCasterLevel,
    String? notes,
  }) = _SpellScalingDataImpl;

  factory SpellScalingData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpellScalingData(
      mode: jsonSerialization['mode'] == null
          ? null
          : _i2.SpellScalingMode.fromJson((jsonSerialization['mode'] as int)),
      scalingBySlotLevel: (jsonSerialization['scalingBySlotLevel'] as List?)
          ?.fold<Map<int, String>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as String}),
      scalingByCasterLevel: (jsonSerialization['scalingByCasterLevel'] as List?)
          ?.fold<Map<int, String>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as String}),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  _i2.SpellScalingMode? mode;

  Map<int, String>? scalingBySlotLevel;

  Map<int, String>? scalingByCasterLevel;

  String? notes;

  /// Returns a shallow copy of this [SpellScalingData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellScalingData copyWith({
    _i2.SpellScalingMode? mode,
    Map<int, String>? scalingBySlotLevel,
    Map<int, String>? scalingByCasterLevel,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellScalingDataImpl extends SpellScalingData {
  _SpellScalingDataImpl({
    _i2.SpellScalingMode? mode,
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
  @_i1.useResult
  @override
  SpellScalingData copyWith({
    Object? mode = _Undefined,
    Object? scalingBySlotLevel = _Undefined,
    Object? scalingByCasterLevel = _Undefined,
    Object? notes = _Undefined,
  }) {
    return SpellScalingData(
      mode: mode is _i2.SpellScalingMode? ? mode : this.mode,
      scalingBySlotLevel: scalingBySlotLevel is Map<int, String>?
          ? scalingBySlotLevel
          : this.scalingBySlotLevel?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      scalingByCasterLevel: scalingByCasterLevel is Map<int, String>?
          ? scalingByCasterLevel
          : this.scalingByCasterLevel?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
