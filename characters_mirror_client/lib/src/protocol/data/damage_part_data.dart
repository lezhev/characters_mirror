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
import '../data/spell_scaling_data.dart' as _i5v09j9p;
import '../enums/damage_type.dart' as _ijnkp14j;

abstract class DamagePartData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DamagePartData._({this.formula, this.damageType, this.scaling, this.notes});

  factory DamagePartData({
    String? formula,
    _ijnkp14j.DamageType? damageType,
    _i5v09j9p.SpellScalingData? scaling,
    String? notes,
  }) = _DamagePartDataImpl;

  factory DamagePartData.fromJson(Map<String, dynamic> jsonSerialization) {
    return DamagePartData(
      formula: jsonSerialization['formula'] as String?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _ijnkp14j.DamageType.fromJson(
              (jsonSerialization['damageType'] as String),
            ),
      scaling: jsonSerialization['scaling'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i5v09j9p.SpellScalingData>(
              jsonSerialization['scaling'],
            ),
      notes: jsonSerialization['notes'] as String?,
    );
  }

  String? formula;

  _ijnkp14j.DamageType? damageType;

  _i5v09j9p.SpellScalingData? scaling;

  String? notes;

  /// Returns a shallow copy of this [DamagePartData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DamagePartData copyWith({
    String? formula,
    _ijnkp14j.DamageType? damageType,
    _i5v09j9p.SpellScalingData? scaling,
    String? notes,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DamagePartData',
      if (formula != null) 'formula': formula,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (scaling != null) 'scaling': scaling?.toJson(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DamagePartData',
      if (formula != null) 'formula': formula,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (scaling != null) 'scaling': scaling?.toJsonForProtocol(),
      if (notes != null) 'notes': notes,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DamagePartDataImpl extends DamagePartData {
  _DamagePartDataImpl({
    String? formula,
    _ijnkp14j.DamageType? damageType,
    _i5v09j9p.SpellScalingData? scaling,
    String? notes,
  }) : super._(
         formula: formula,
         damageType: damageType,
         scaling: scaling,
         notes: notes,
       );

  /// Returns a shallow copy of this [DamagePartData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DamagePartData copyWith({
    Object? formula = _Undefined,
    Object? damageType = _Undefined,
    Object? scaling = _Undefined,
    Object? notes = _Undefined,
  }) {
    return DamagePartData(
      formula: formula is String? ? formula : this.formula,
      damageType: damageType is _ijnkp14j.DamageType?
          ? damageType
          : this.damageType,
      scaling: scaling is _i5v09j9p.SpellScalingData?
          ? scaling
          : this.scaling?.copyWith(),
      notes: notes is String? ? notes : this.notes,
    );
  }
}
