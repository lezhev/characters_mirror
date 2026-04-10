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
import '../../../data/general/class/starting_equipment_block_data.dart' as _i2;
import '../../../data/general/class/starting_equipment_option_data.dart' as _i3;
import '../../../enums/starting_equipment_line_kind.dart' as _i4;
import '../../../enums/equipment_catalog_type.dart' as _i5;
import '../../../enums/weapon_category.dart' as _i6;

abstract class StartingEquipmentLineData implements _i1.SerializableModel {
  StartingEquipmentLineData._({
    this.id,
    this.blockId,
    this.block,
    this.optionId,
    this.option,
    this.lineKey,
    this.orderIndex,
    this.kind,
    this.displayText,
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

  factory StartingEquipmentLineData({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    int? optionId,
    _i3.StartingEquipmentOptionData? option,
    String? lineKey,
    int? orderIndex,
    _i4.StartingEquipmentLineKind? kind,
    String? displayText,
    int? quantity,
    _i5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i6.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentLineDataImpl;

  factory StartingEquipmentLineData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentLineData(
      id: jsonSerialization['id'] as int?,
      blockId: jsonSerialization['blockId'] as int?,
      block: jsonSerialization['block'] == null
          ? null
          : _i2.StartingEquipmentBlockData.fromJson(
              (jsonSerialization['block'] as Map<String, dynamic>)),
      optionId: jsonSerialization['optionId'] as int?,
      option: jsonSerialization['option'] == null
          ? null
          : _i3.StartingEquipmentOptionData.fromJson(
              (jsonSerialization['option'] as Map<String, dynamic>)),
      lineKey: jsonSerialization['lineKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i4.StartingEquipmentLineKind.fromJson(
              (jsonSerialization['kind'] as String)),
      displayText: jsonSerialization['displayText'] as String?,
      quantity: jsonSerialization['quantity'] as int?,
      catalogType: jsonSerialization['catalogType'] == null
          ? null
          : _i5.EquipmentCatalogType.fromJson(
              (jsonSerialization['catalogType'] as String)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      allowedWeaponCategories:
          (jsonSerialization['allowedWeaponCategories'] as List?)
              ?.map((e) => _i6.WeaponCategory.fromJson((e as String)))
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

  int? blockId;

  _i2.StartingEquipmentBlockData? block;

  int? optionId;

  _i3.StartingEquipmentOptionData? option;

  String? lineKey;

  int? orderIndex;

  _i4.StartingEquipmentLineKind? kind;

  String? displayText;

  int? quantity;

  _i5.EquipmentCatalogType? catalogType;

  String? referenceKey;

  List<_i6.WeaponCategory>? allowedWeaponCategories;

  List<String>? allowedItemCategories;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentLineData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentLineData copyWith({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    int? optionId,
    _i3.StartingEquipmentOptionData? option,
    String? lineKey,
    int? orderIndex,
    _i4.StartingEquipmentLineKind? kind,
    String? displayText,
    int? quantity,
    _i5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i6.WeaponCategory>? allowedWeaponCategories,
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
      if (blockId != null) 'blockId': blockId,
      if (block != null) 'block': block?.toJson(),
      if (optionId != null) 'optionId': optionId,
      if (option != null) 'option': option?.toJson(),
      if (lineKey != null) 'lineKey': lineKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (displayText != null) 'displayText': displayText,
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

class _StartingEquipmentLineDataImpl extends StartingEquipmentLineData {
  _StartingEquipmentLineDataImpl({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    int? optionId,
    _i3.StartingEquipmentOptionData? option,
    String? lineKey,
    int? orderIndex,
    _i4.StartingEquipmentLineKind? kind,
    String? displayText,
    int? quantity,
    _i5.EquipmentCatalogType? catalogType,
    String? referenceKey,
    List<_i6.WeaponCategory>? allowedWeaponCategories,
    List<String>? allowedItemCategories,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          blockId: blockId,
          block: block,
          optionId: optionId,
          option: option,
          lineKey: lineKey,
          orderIndex: orderIndex,
          kind: kind,
          displayText: displayText,
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

  /// Returns a shallow copy of this [StartingEquipmentLineData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentLineData copyWith({
    Object? id = _Undefined,
    Object? blockId = _Undefined,
    Object? block = _Undefined,
    Object? optionId = _Undefined,
    Object? option = _Undefined,
    Object? lineKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? displayText = _Undefined,
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
    return StartingEquipmentLineData(
      id: id is int? ? id : this.id,
      blockId: blockId is int? ? blockId : this.blockId,
      block: block is _i2.StartingEquipmentBlockData?
          ? block
          : this.block?.copyWith(),
      optionId: optionId is int? ? optionId : this.optionId,
      option: option is _i3.StartingEquipmentOptionData?
          ? option
          : this.option?.copyWith(),
      lineKey: lineKey is String? ? lineKey : this.lineKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _i4.StartingEquipmentLineKind? ? kind : this.kind,
      displayText: displayText is String? ? displayText : this.displayText,
      quantity: quantity is int? ? quantity : this.quantity,
      catalogType: catalogType is _i5.EquipmentCatalogType?
          ? catalogType
          : this.catalogType,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      allowedWeaponCategories:
          allowedWeaponCategories is List<_i6.WeaponCategory>?
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
