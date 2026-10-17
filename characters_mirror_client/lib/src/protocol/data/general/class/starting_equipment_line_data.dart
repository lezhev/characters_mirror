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
import '../../../enums/equipment_catalog_type.dart' as _i5zaboz2;
import '../../../enums/starting_equipment_line_kind.dart' as _iupdx0br;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class StartingEquipmentLineData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  StartingEquipmentLineData._({
    this.entryId,
    this.parentEntryId,
    this.orderIndex,
    this.kind,
    this.quantity,
    this.catalogType,
    this.referenceKey,
    this.allowedWeaponCategories,
    this.allowedItemCategories,
  });

  factory StartingEquipmentLineData({
    int? entryId,
    int? parentEntryId,
    int? orderIndex,
    _iupdx0br.StartingEquipmentLineKind? kind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
  }) = _StartingEquipmentLineDataImpl;

  factory StartingEquipmentLineData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StartingEquipmentLineData(
      entryId: jsonSerialization['entryId'] as int?,
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _iupdx0br.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      quantity: jsonSerialization['quantity'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i5zaboz2.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String),
            ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      allowedWeaponCategories:
          jsonSerialization['allowedWeaponCategories'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['allowedWeaponCategories'],
            ),
      allowedItemCategories: jsonSerialization['allowedItemCategories'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['allowedItemCategories'],
            ),
    );
  }

  int? entryId;

  int? parentEntryId;

  int? orderIndex;

  _iupdx0br.StartingEquipmentLineKind? kind;

  int? quantity;

  _i5zaboz2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  /// Returns a shallow copy of this [StartingEquipmentLineData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartingEquipmentLineData copyWith({
    int? entryId,
    int? parentEntryId,
    int? orderIndex,
    _iupdx0br.StartingEquipmentLineKind? kind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartingEquipmentLineData',
      if (entryId != null) 'entryId': entryId,
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (quantity != null) 'quantity': quantity,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (allowedWeaponCategories != null)
        'allowedWeaponCategories': allowedWeaponCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartingEquipmentLineData',
      if (entryId != null) 'entryId': entryId,
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (quantity != null) 'quantity': quantity,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (allowedWeaponCategories != null)
        'allowedWeaponCategories': allowedWeaponCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentLineDataImpl extends StartingEquipmentLineData {
  _StartingEquipmentLineDataImpl({
    int? entryId,
    int? parentEntryId,
    int? orderIndex,
    _iupdx0br.StartingEquipmentLineKind? kind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
  }) : super._(
         entryId: entryId,
         parentEntryId: parentEntryId,
         orderIndex: orderIndex,
         kind: kind,
         quantity: quantity,
         catalogType: catalogType,
         referenceKey: referenceKey,
         allowedWeaponCategories: allowedWeaponCategories,
         allowedItemCategories: allowedItemCategories,
       );

  /// Returns a shallow copy of this [StartingEquipmentLineData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  StartingEquipmentLineData copyWith({
    Object? entryId = _Undefined,
    Object? parentEntryId = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? quantity = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? allowedWeaponCategories = _Undefined,
    Object? allowedItemCategories = _Undefined,
  }) {
    return StartingEquipmentLineData(
      entryId: entryId is int? ? entryId : this.entryId,
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _iupdx0br.StartingEquipmentLineKind? ? kind : this.kind,
      quantity: quantity is int? ? quantity : this.quantity,
      catalogType: catalogType is _i5zaboz2.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      allowedWeaponCategories:
          allowedWeaponCategories is List<_ibtz7e0l.WeaponCategory>?
          ? allowedWeaponCategories
          : this.allowedWeaponCategories?.map((e0) => e0).toList(),
      allowedItemCategories: allowedItemCategories is List<String>?
          ? allowedItemCategories
          : this.allowedItemCategories?.map((e0) => e0).toList(),
    );
  }
}
