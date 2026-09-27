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

abstract class CharacterEquipmentSelectionData
    implements _i1.SerializableModel {
  CharacterEquipmentSelectionData._({
    this.referenceKey,
    required this.name,
  });

  factory CharacterEquipmentSelectionData({
    String? referenceKey,
    required String name,
  }) = _CharacterEquipmentSelectionDataImpl;

  factory CharacterEquipmentSelectionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterEquipmentSelectionData(
      referenceKey: jsonSerialization['referenceKey'] as String?,
      name: jsonSerialization['name'] as String,
    );
  }

  String? referenceKey;

  String name;

  /// Returns a shallow copy of this [CharacterEquipmentSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterEquipmentSelectionData copyWith({
    String? referenceKey,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (referenceKey != null) 'referenceKey': referenceKey,
      'name': name,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterEquipmentSelectionDataImpl
    extends CharacterEquipmentSelectionData {
  _CharacterEquipmentSelectionDataImpl({
    String? referenceKey,
    required String name,
  }) : super._(
          referenceKey: referenceKey,
          name: name,
        );

  /// Returns a shallow copy of this [CharacterEquipmentSelectionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterEquipmentSelectionData copyWith({
    Object? referenceKey = _Undefined,
    String? name,
  }) {
    return CharacterEquipmentSelectionData(
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name ?? this.name,
    );
  }
}
