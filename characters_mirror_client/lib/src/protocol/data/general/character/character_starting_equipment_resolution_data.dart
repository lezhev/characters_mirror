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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../../../enums/equipment_catalog_type.dart' as _i5zaboz2;

abstract class CharacterStartingEquipmentResolutionData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterStartingEquipmentResolutionData._({
    this.id,
    this.sourceLineEntryId,
    this.catalogType,
    this.referenceKey,
    this.quantity,
    this.updatedAt,
  });

  factory CharacterStartingEquipmentResolutionData({
    String? id,
    int? sourceLineEntryId,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) = _CharacterStartingEquipmentResolutionDataImpl;

  factory CharacterStartingEquipmentResolutionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterStartingEquipmentResolutionData(
      id: jsonSerialization['id'] as String?,
      sourceLineEntryId: jsonSerialization['sourceLineEntryId'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i5zaboz2.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String),
            ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  String? id;

  int? sourceLineEntryId;

  _i5zaboz2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  int? quantity;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterStartingEquipmentResolutionData copyWith({
    String? id,
    int? sourceLineEntryId,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterStartingEquipmentResolutionData',
      if (id != null) 'id': id,
      if (sourceLineEntryId != null) 'sourceLineEntryId': sourceLineEntryId,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterStartingEquipmentResolutionData',
      if (id != null) 'id': id,
      if (sourceLineEntryId != null) 'sourceLineEntryId': sourceLineEntryId,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (quantity != null) 'quantity': quantity,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterStartingEquipmentResolutionDataImpl
    extends CharacterStartingEquipmentResolutionData {
  _CharacterStartingEquipmentResolutionDataImpl({
    String? id,
    int? sourceLineEntryId,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    int? quantity,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         sourceLineEntryId: sourceLineEntryId,
         catalogType: catalogType,
         referenceKey: referenceKey,
         quantity: quantity,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CharacterStartingEquipmentResolutionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterStartingEquipmentResolutionData copyWith({
    Object? id = _Undefined,
    Object? sourceLineEntryId = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? quantity = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return CharacterStartingEquipmentResolutionData(
      id: id is String? ? id : this.id,
      sourceLineEntryId: sourceLineEntryId is int?
          ? sourceLineEntryId
          : this.sourceLineEntryId,
      catalogType: catalogType is _i5zaboz2.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      quantity: quantity is int? ? quantity : this.quantity,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
