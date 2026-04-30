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
import '../enums/damage_type.dart' as _i2;
import '../data/spell_scaling_data.dart' as _i3;

abstract class DamagePartData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DamagePartData._({
    this.formula,
    this.damageType,
    this.scaling,
    this.notes,
  });

  factory DamagePartData({
    String? formula,
    _i2.DamageType? damageType,
    _i3.SpellScalingData? scaling,
    String? notes,
  }) = _DamagePartDataImpl;

  factory DamagePartData.fromJson(Map<String, dynamic> jsonSerialization) {
    return DamagePartData(
      formula: jsonSerialization['formula'] as String?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i2.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      scaling: jsonSerialization['scaling'] == null
          ? null
          : _i3.SpellScalingData.fromJson(
              (jsonSerialization['scaling'] as Map<String, dynamic>)),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  String? formula;

  _i2.DamageType? damageType;

  _i3.SpellScalingData? scaling;

  String? notes;

  /// Returns a shallow copy of this [DamagePartData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DamagePartData copyWith({
    String? formula,
    _i2.DamageType? damageType,
    _i3.SpellScalingData? scaling,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (formula != null) 'formula': formula,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (scaling != null) 'scaling': scaling?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (formula != null) 'formula': formula,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (scaling != null) 'scaling': scaling?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DamagePartDataImpl extends DamagePartData {
  _DamagePartDataImpl({
    String? formula,
    _i2.DamageType? damageType,
    _i3.SpellScalingData? scaling,
    String? notes,
  }) : super._(
          formula: formula,
          damageType: damageType,
          scaling: scaling,
          notes: notes,
        );

  /// Returns a shallow copy of this [DamagePartData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DamagePartData copyWith({
    Object? formula = _Undefined,
    Object? damageType = _Undefined,
    Object? scaling = _Undefined,
    Object? notes = _Undefined,
  }) {
    return DamagePartData(
      formula: formula is String? ? formula : this.formula,
      damageType: damageType is _i2.DamageType? ? damageType : this.damageType,
      scaling:
          scaling is _i3.SpellScalingData? ? scaling : this.scaling?.copyWith(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
