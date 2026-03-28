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
import '../enums/area_of_effect_type.dart' as _i2;

abstract class SpellAreaOfEffectData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SpellAreaOfEffectData._({
    this.type,
    this.size,
  });

  factory SpellAreaOfEffectData({
    _i2.AreaOfEffectType? type,
    int? size,
  }) = _SpellAreaOfEffectDataImpl;

  factory SpellAreaOfEffectData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellAreaOfEffectData(
      type: jsonSerialization['type'] == null
          ? null
          : _i2.AreaOfEffectType.fromJson((jsonSerialization['type'] as int)),
      size: jsonSerialization['size'] as int?,
    );
  }

  _i2.AreaOfEffectType? type;

  int? size;

  /// Returns a shallow copy of this [SpellAreaOfEffectData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellAreaOfEffectData copyWith({
    _i2.AreaOfEffectType? type,
    int? size,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type?.toJson(),
      if (size != null) 'size': size,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (type != null) 'type': type?.toJson(),
      if (size != null) 'size': size,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellAreaOfEffectDataImpl extends SpellAreaOfEffectData {
  _SpellAreaOfEffectDataImpl({
    _i2.AreaOfEffectType? type,
    int? size,
  }) : super._(
          type: type,
          size: size,
        );

  /// Returns a shallow copy of this [SpellAreaOfEffectData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellAreaOfEffectData copyWith({
    Object? type = _Undefined,
    Object? size = _Undefined,
  }) {
    return SpellAreaOfEffectData(
      type: type is _i2.AreaOfEffectType? ? type : this.type,
      size: size is int? ? size : this.size,
    );
  }
}
