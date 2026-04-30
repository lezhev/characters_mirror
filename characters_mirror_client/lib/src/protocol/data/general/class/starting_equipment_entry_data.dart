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
import '../../../data/general/class/class_data.dart' as _i2;
import '../../../data/background_data.dart' as _i3;
import '../../../enums/starting_equipment_entry_kind.dart' as _i4;
import '../../../enums/starting_equipment_line_kind.dart' as _i5;
import '../../../enums/equipment_catalog_type.dart' as _i6;
import '../../../enums/weapon_category.dart' as _i7;

abstract class StartingEquipmentEntryData implements _i1.SerializableModel {
  StartingEquipmentEntryData._({
    this.id,
    this.sourceClassId,
    this.sourceClass,
    this.sourceBackgroundId,
    this.sourceBackground,
    this.parentEntryId,
    this.kind,
    this.orderIndex,
    this.selectionCount,
    this.lineKind,
    this.quantity,
    this.catalogType,
    this.referenceKey,
    this.allowedWeaponCategories,
    this.allowedItemCategories,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentEntryData({
    int? id,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i3.BackgroundData? sourceBackground,
    int? parentEntryId,
    _i4.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _i5.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i6.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i7.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentEntryDataImpl;

  factory StartingEquipmentEntryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentEntryData(
      id: jsonSerialization['id'] as int?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i3.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4.StartingEquipmentEntryKind.fromJson(
              (jsonSerialization['kind'] as String)),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      selectionCount: jsonSerialization['selectionCount'] as int?,
      lineKind: jsonSerialization['lineKind'] == null
          ? null
          : _i5.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['lineKind'] as String)),
      quantity: jsonSerialization['quantity'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i6.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      allowedWeaponCategories:
          (jsonSerialization['allowedWeaponCategories'] as List?)
              ?.map((e) => _i7.WeaponCategory.fromJson((e as String)))
              .toList(),
      allowedItemCategories:
          (jsonSerialization['allowedItemCategories'] as List?)
              ?.map((e) => e as String)
              .toList(),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? sourceClassId;

  _i2.ClassData? sourceClass;

  int? sourceBackgroundId;

  _i3.BackgroundData? sourceBackground;

  int? parentEntryId;

  _i4.StartingEquipmentEntryKind? kind;

  int? orderIndex;

  int? selectionCount;

  _i5.StartingEquipmentLineKind? lineKind;

  int? quantity;

  _i6.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_i7.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentEntryData copyWith({
    int? id,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i3.BackgroundData? sourceBackground,
    int? parentEntryId,
    _i4.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _i5.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i6.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i7.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (kind != null) 'kind': kind?.toJson(),
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (lineKind != null) 'lineKind': lineKind?.toJson(),
      if (quantity != null) 'quantity': quantity,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (allowedWeaponCategories != null)
        'allowedWeaponCategories':
            allowedWeaponCategories?.toJson(valueToJson: (v) => v.toJson()),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentEntryDataImpl extends StartingEquipmentEntryData {
  _StartingEquipmentEntryDataImpl({
    int? id,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i3.BackgroundData? sourceBackground,
    int? parentEntryId,
    _i4.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _i5.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i6.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i7.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceBackgroundId: sourceBackgroundId,
          sourceBackground: sourceBackground,
          parentEntryId: parentEntryId,
          kind: kind,
          orderIndex: orderIndex,
          selectionCount: selectionCount,
          lineKind: lineKind,
          quantity: quantity,
          catalogType: catalogType,
          referenceKey: referenceKey,
          allowedWeaponCategories: allowedWeaponCategories,
          allowedItemCategories: allowedItemCategories,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StartingEquipmentEntryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentEntryData copyWith({
    Object? id = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? parentEntryId = _Undefined,
    Object? kind = _Undefined,
    Object? orderIndex = _Undefined,
    Object? selectionCount = _Undefined,
    Object? lineKind = _Undefined,
    Object? quantity = _Undefined,
    Object? catalogType = _Undefined,
    Object? referenceKey = _Undefined,
    Object? allowedWeaponCategories = _Undefined,
    Object? allowedItemCategories = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentEntryData(
      id: id is int? ? id : this.id,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i2.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i3.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      kind: kind is _i4.StartingEquipmentEntryKind? ? kind : this.kind,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      lineKind:
          lineKind is _i5.StartingEquipmentLineKind? ? lineKind : this.lineKind,
      quantity: quantity is int? ? quantity : this.quantity,
      catalogType: catalogType is _i6.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      allowedWeaponCategories:
          allowedWeaponCategories is List<_i7.WeaponCategory>?
              ? allowedWeaponCategories
              : this.allowedWeaponCategories?.map((e0) => e0).toList(),
      allowedItemCategories: allowedItemCategories is List<String>?
          ? allowedItemCategories
          : this.allowedItemCategories?.map((e0) => e0).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
