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

abstract class CharacterToolProficiencyOverridesData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CharacterToolProficiencyOverridesData._({
    this.addedKeys,
    this.removedKeys,
    this.custom,
  });

  factory CharacterToolProficiencyOverridesData({
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  }) = _CharacterToolProficiencyOverridesDataImpl;

  factory CharacterToolProficiencyOverridesData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterToolProficiencyOverridesData(
      addedKeys: jsonSerialization['addedKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['addedKeys'],
            ),
      removedKeys: jsonSerialization['removedKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['removedKeys'],
            ),
      custom: jsonSerialization['custom'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['custom'],
            ),
    );
  }

  List<String>? addedKeys;

  List<String>? removedKeys;

  List<String>? custom;

  /// Returns a shallow copy of this [CharacterToolProficiencyOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterToolProficiencyOverridesData copyWith({
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterToolProficiencyOverridesData',
      if (addedKeys != null) 'addedKeys': addedKeys?.toJson(),
      if (removedKeys != null) 'removedKeys': removedKeys?.toJson(),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterToolProficiencyOverridesData',
      if (addedKeys != null) 'addedKeys': addedKeys?.toJson(),
      if (removedKeys != null) 'removedKeys': removedKeys?.toJson(),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterToolProficiencyOverridesDataImpl
    extends CharacterToolProficiencyOverridesData {
  _CharacterToolProficiencyOverridesDataImpl({
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  }) : super._(addedKeys: addedKeys, removedKeys: removedKeys, custom: custom);

  /// Returns a shallow copy of this [CharacterToolProficiencyOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterToolProficiencyOverridesData copyWith({
    Object? addedKeys = _Undefined,
    Object? removedKeys = _Undefined,
    Object? custom = _Undefined,
  }) {
    return CharacterToolProficiencyOverridesData(
      addedKeys: addedKeys is List<String>?
          ? addedKeys
          : this.addedKeys?.map((e0) => e0).toList(),
      removedKeys: removedKeys is List<String>?
          ? removedKeys
          : this.removedKeys?.map((e0) => e0).toList(),
      custom: custom is List<String>?
          ? custom
          : this.custom?.map((e0) => e0).toList(),
    );
  }
}
