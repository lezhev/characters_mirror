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
import '../../../enums/equipment_catalog_type.dart' as _i2;

abstract class CharacterStartingEquipmentResolutionData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterStartingEquipmentResolutionData._({
    this.id,
    this.lineKey,
    this.catalogType,
    this.referenceKey,
    this.quantity,
    this.updatedAt,
  });

  factory CharacterStartingEquipmentResolutionData({
    String? id,
    String? lineKey,
    _i2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) = _CharacterStartingEquipmentResolutionDataImpl;

  factory CharacterStartingEquipmentResolutionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterStartingEquipmentResolutionData(
      id: jsonSerialization['id'] as String?,
      lineKey: jsonSerialization['lineKey'] as String?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i2.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  String? lineKey;

  _i2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  int? quantity;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterStartingEquipmentResolutionData copyWith({
    String? id,
    String? lineKey,
    _i2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (lineKey != null) 'lineKey': lineKey,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (lineKey != null) 'lineKey': lineKey,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentResolutionDataImpl
    extends CharacterStartingEquipmentResolutionData {
  _CharacterStartingEquipmentResolutionDataImpl({
    String? id,
    String? lineKey,
    _i2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          lineKey: lineKey,
          catalogType: catalogType,
          referenceKey: referenceKey,
          quantity: quantity,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterStartingEquipmentResolutionData copyWith({
    Object? id = _Undefined,
    Object? lineKey = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? quantity = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterStartingEquipmentResolutionData(
      id: id is String? ? id : this.id,
      lineKey: lineKey is String? ? lineKey : this.lineKey,
      catalogType: catalogType is _i2.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      quantity: quantity is int? ? quantity : this.quantity,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
