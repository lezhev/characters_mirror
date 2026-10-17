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
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class CharacterWeaponProficiencyOverridesData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CharacterWeaponProficiencyOverridesData._({
    this.addedCategories,
    this.removedCategories,
    this.addedKeys,
    this.removedKeys,
    this.custom,
  });

  factory CharacterWeaponProficiencyOverridesData({
    List<_ibtz7e0l.WeaponCategory>? addedCategories,
    List<_ibtz7e0l.WeaponCategory>? removedCategories,
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  }) = _CharacterWeaponProficiencyOverridesDataImpl;

  factory CharacterWeaponProficiencyOverridesData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterWeaponProficiencyOverridesData(
      addedCategories: jsonSerialization['addedCategories'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['addedCategories'],
            ),
      removedCategories: jsonSerialization['removedCategories'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['removedCategories'],
            ),
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

  List<_ibtz7e0l.WeaponCategory>? addedCategories;

  List<_ibtz7e0l.WeaponCategory>? removedCategories;

  List<String>? addedKeys;

  List<String>? removedKeys;

  List<String>? custom;

  /// Returns a shallow copy of this [CharacterWeaponProficiencyOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterWeaponProficiencyOverridesData copyWith({
    List<_ibtz7e0l.WeaponCategory>? addedCategories,
    List<_ibtz7e0l.WeaponCategory>? removedCategories,
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterWeaponProficiencyOverridesData',
      if (addedCategories != null)
        'addedCategories': addedCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (removedCategories != null)
        'removedCategories': removedCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (addedKeys != null) 'addedKeys': addedKeys?.toJson(),
      if (removedKeys != null) 'removedKeys': removedKeys?.toJson(),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterWeaponProficiencyOverridesData',
      if (addedCategories != null)
        'addedCategories': addedCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (removedCategories != null)
        'removedCategories': removedCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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

class _CharacterWeaponProficiencyOverridesDataImpl
    extends CharacterWeaponProficiencyOverridesData {
  _CharacterWeaponProficiencyOverridesDataImpl({
    List<_ibtz7e0l.WeaponCategory>? addedCategories,
    List<_ibtz7e0l.WeaponCategory>? removedCategories,
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  }) : super._(
         addedCategories: addedCategories,
         removedCategories: removedCategories,
         addedKeys: addedKeys,
         removedKeys: removedKeys,
         custom: custom,
       );

  /// Returns a shallow copy of this [CharacterWeaponProficiencyOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterWeaponProficiencyOverridesData copyWith({
    Object? addedCategories = _Undefined,
    Object? removedCategories = _Undefined,
    Object? addedKeys = _Undefined,
    Object? removedKeys = _Undefined,
    Object? custom = _Undefined,
  }) {
    return CharacterWeaponProficiencyOverridesData(
      addedCategories: addedCategories is List<_ibtz7e0l.WeaponCategory>?
          ? addedCategories
          : this.addedCategories?.map((e0) => e0).toList(),
      removedCategories: removedCategories is List<_ibtz7e0l.WeaponCategory>?
          ? removedCategories
          : this.removedCategories?.map((e0) => e0).toList(),
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
