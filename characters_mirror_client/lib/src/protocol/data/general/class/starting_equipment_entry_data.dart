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
import '../../../data/background_data.dart' as _i1utzyju;
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../enums/equipment_catalog_type.dart' as _i5zaboz2;
import '../../../enums/starting_equipment_entry_kind.dart' as _ibdnjdmg;
import '../../../enums/starting_equipment_line_kind.dart' as _iupdx0br;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class StartingEquipmentEntryData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _i7s9vfyh.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i1utzyju.BackgroundData? sourceBackground,
    int? parentEntryId,
    _ibdnjdmg.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _iupdx0br.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentEntryDataImpl;

  factory StartingEquipmentEntryData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StartingEquipmentEntryData(
      id: jsonSerialization['id'] as int?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['sourceClass'],
            ),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i1utzyju.BackgroundData>(
              jsonSerialization['sourceBackground'],
            ),
      parentEntryId: jsonSerialization['parentEntryId'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _ibdnjdmg.StartingEquipmentEntryKind.fromJson(
              (jsonSerialization['kind'] as String),
            ),
      orderIndex: jsonSerialization['orderIndex'] as int?,
      selectionCount: jsonSerialization['selectionCount'] as int?,
      lineKind: jsonSerialization['lineKind'] == null
          ? null
          : _iupdx0br.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['lineKind'] as String),
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
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? sourceClassId;

  _i7s9vfyh.ClassData? sourceClass;

  int? sourceBackgroundId;

  _i1utzyju.BackgroundData? sourceBackground;

  int? parentEntryId;

  _ibdnjdmg.StartingEquipmentEntryKind? kind;

  int? orderIndex;

  int? selectionCount;

  _iupdx0br.StartingEquipmentLineKind? lineKind;

  int? quantity;

  _i5zaboz2.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentEntryData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  StartingEquipmentEntryData copyWith({
    int? id,
    int? sourceClassId,
    _i7s9vfyh.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i1utzyju.BackgroundData? sourceBackground,
    int? parentEntryId,
    _ibdnjdmg.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _iupdx0br.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StartingEquipmentEntryData',
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
        'allowedWeaponCategories': allowedWeaponCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (allowedItemCategories != null)
        'allowedItemCategories': allowedItemCategories?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StartingEquipmentEntryData',
      if (id != null) 'id': id,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJsonForProtocol(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJsonForProtocol(),
      if (parentEntryId != null) 'parentEntryId': parentEntryId,
      if (kind != null) 'kind': kind?.toJson(),
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (lineKind != null) 'lineKind': lineKind?.toJson(),
      if (quantity != null) 'quantity': quantity,
      if (catalogType != null) 'catalogType': catalogType?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (allowedWeaponCategories != null)
        'allowedWeaponCategories': allowedWeaponCategories?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StartingEquipmentEntryDataImpl extends StartingEquipmentEntryData {
  _StartingEquipmentEntryDataImpl({
    int? id,
    int? sourceClassId,
    _i7s9vfyh.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i1utzyju.BackgroundData? sourceBackground,
    int? parentEntryId,
    _ibdnjdmg.StartingEquipmentEntryKind? kind,
    int? orderIndex,
    int? selectionCount,
    _iupdx0br.StartingEquipmentLineKind? lineKind,
    int? quantity,
    _i5zaboz2.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_ibtz7e0l.WeaponCategory>? allowedWeaponCategories,
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
  @_isc.useResult
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
      sourceClass: sourceClass is _i7s9vfyh.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i1utzyju.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      parentEntryId: parentEntryId is int? ? parentEntryId : this.parentEntryId,
      kind: kind is _ibdnjdmg.StartingEquipmentEntryKind? ? kind : this.kind,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      selectionCount: selectionCount is int?
          ? selectionCount
          : this.selectionCount,
      lineKind: lineKind is _iupdx0br.StartingEquipmentLineKind?
          ? lineKind
          : this.lineKind,
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
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
