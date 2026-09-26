/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import '../../../enums/weapon_category.dart' as _i2;

abstract class CharacterWeaponProficiencyOverridesData
    implements _i1.SerializableModel {
  CharacterWeaponProficiencyOverridesData._({
    this.addedCategories,
    this.removedCategories,
    this.addedKeys,
    this.removedKeys,
    this.custom,
  });

  factory CharacterWeaponProficiencyOverridesData({
    List<_i2.WeaponCategory>? addedCategories,
    List<_i2.WeaponCategory>? removedCategories,
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  }) = _CharacterWeaponProficiencyOverridesDataImpl;

  factory CharacterWeaponProficiencyOverridesData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterWeaponProficiencyOverridesData(
      addedCategories: (jsonSerialization['addedCategories'] as List?)
          ?.map((e) => _i2.WeaponCategory.fromJson((e as String)))
          .toList(),
      removedCategories: (jsonSerialization['removedCategories'] as List?)
          ?.map((e) => _i2.WeaponCategory.fromJson((e as String)))
          .toList(),
      addedKeys: (jsonSerialization['addedKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      removedKeys: (jsonSerialization['removedKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      custom: (jsonSerialization['custom'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  List<_i2.WeaponCategory>? addedCategories;

  List<_i2.WeaponCategory>? removedCategories;

  List<String>? addedKeys;

  List<String>? removedKeys;

  List<String>? custom;

  /// Returns a shallow copy of this [CharacterWeaponProficiencyOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterWeaponProficiencyOverridesData copyWith({
    List<_i2.WeaponCategory>? addedCategories,
    List<_i2.WeaponCategory>? removedCategories,
    List<String>? addedKeys,
    List<String>? removedKeys,
    List<String>? custom,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (addedCategories != null)
        'addedCategories':
            addedCategories?.toJson(valueToJson: (v) => v.toJson()),
      if (removedCategories != null)
        'removedCategories':
            removedCategories?.toJson(valueToJson: (v) => v.toJson()),
      if (addedKeys != null) 'addedKeys': addedKeys?.toJson(),
      if (removedKeys != null) 'removedKeys': removedKeys?.toJson(),
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterWeaponProficiencyOverridesDataImpl
    extends CharacterWeaponProficiencyOverridesData {
  _CharacterWeaponProficiencyOverridesDataImpl({
    List<_i2.WeaponCategory>? addedCategories,
    List<_i2.WeaponCategory>? removedCategories,
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
  @_i1.useResult
  @override
  CharacterWeaponProficiencyOverridesData copyWith({
    Object? addedCategories = _Undefined,
    Object? removedCategories = _Undefined,
    Object? addedKeys = _Undefined,
    Object? removedKeys = _Undefined,
    Object? custom = _Undefined,
  }) {
    return CharacterWeaponProficiencyOverridesData(
      addedCategories: addedCategories is List<_i2.WeaponCategory>?
          ? addedCategories
          : this.addedCategories?.map((e0) => e0).toList(),
      removedCategories: removedCategories is List<_i2.WeaponCategory>?
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
