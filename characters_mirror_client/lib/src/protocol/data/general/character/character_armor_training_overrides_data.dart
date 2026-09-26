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
import '../../../enums/armor_category.dart' as _i2;

abstract class CharacterArmorTrainingOverridesData
    implements _i1.SerializableModel {
  CharacterArmorTrainingOverridesData._({
    this.addedCategories,
    this.removedCategories,
    this.custom,
  });

  factory CharacterArmorTrainingOverridesData({
    List<_i2.ArmorCategory>? addedCategories,
    List<_i2.ArmorCategory>? removedCategories,
    List<String>? custom,
  }) = _CharacterArmorTrainingOverridesDataImpl;

  factory CharacterArmorTrainingOverridesData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterArmorTrainingOverridesData(
      addedCategories: (jsonSerialization['addedCategories'] as List?)
          ?.map((e) => _i2.ArmorCategory.fromJson((e as String)))
          .toList(),
      removedCategories: (jsonSerialization['removedCategories'] as List?)
          ?.map((e) => _i2.ArmorCategory.fromJson((e as String)))
          .toList(),
      custom: (jsonSerialization['custom'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  List<_i2.ArmorCategory>? addedCategories;

  List<_i2.ArmorCategory>? removedCategories;

  List<String>? custom;

  /// Returns a shallow copy of this [CharacterArmorTrainingOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterArmorTrainingOverridesData copyWith({
    List<_i2.ArmorCategory>? addedCategories,
    List<_i2.ArmorCategory>? removedCategories,
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
      if (custom != null) 'custom': custom?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterArmorTrainingOverridesDataImpl
    extends CharacterArmorTrainingOverridesData {
  _CharacterArmorTrainingOverridesDataImpl({
    List<_i2.ArmorCategory>? addedCategories,
    List<_i2.ArmorCategory>? removedCategories,
    List<String>? custom,
  }) : super._(
          addedCategories: addedCategories,
          removedCategories: removedCategories,
          custom: custom,
        );

  /// Returns a shallow copy of this [CharacterArmorTrainingOverridesData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterArmorTrainingOverridesData copyWith({
    Object? addedCategories = _Undefined,
    Object? removedCategories = _Undefined,
    Object? custom = _Undefined,
  }) {
    return CharacterArmorTrainingOverridesData(
      addedCategories: addedCategories is List<_i2.ArmorCategory>?
          ? addedCategories
          : this.addedCategories?.map((e0) => e0).toList(),
      removedCategories: removedCategories is List<_i2.ArmorCategory>?
          ? removedCategories
          : this.removedCategories?.map((e0) => e0).toList(),
      custom: custom is List<String>?
          ? custom
          : this.custom?.map((e0) => e0).toList(),
    );
  }
}
