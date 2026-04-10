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
import '../../../enums/starting_equipment_block_kind.dart' as _i2;
import '../../../data/general/class/class_data.dart' as _i3;
import '../../../data/background_data.dart' as _i4;

abstract class StartingEquipmentBlockData implements _i1.SerializableModel {
  StartingEquipmentBlockData._({
    this.id,
    this.blockKey,
    this.orderIndex,
    this.kind,
    this.selectionCount,
    this.sourceClassId,
    this.sourceClass,
    this.sourceBackgroundId,
    this.sourceBackground,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentBlockData({
    int? id,
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i4.BackgroundData? sourceBackground,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentBlockDataImpl;

  factory StartingEquipmentBlockData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentBlockData(
      id: jsonSerialization['id'] as int?,
      blockKey: jsonSerialization['blockKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.StartingEquipmentBlockKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i4.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
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

  String? blockKey;

  int? orderIndex;

  _i2.StartingEquipmentBlockKind? kind;

  int? selectionCount;

  int? sourceClassId;

  _i3.ClassData? sourceClass;

  int? sourceBackgroundId;

  _i4.BackgroundData? sourceBackground;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentBlockData copyWith({
    int? id,
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i4.BackgroundData? sourceBackground,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (blockKey != null) 'blockKey': blockKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
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

class _StartingEquipmentBlockDataImpl extends StartingEquipmentBlockData {
  _StartingEquipmentBlockDataImpl({
    int? id,
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceBackgroundId,
    _i4.BackgroundData? sourceBackground,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          blockKey: blockKey,
          orderIndex: orderIndex,
          kind: kind,
          selectionCount: selectionCount,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceBackgroundId: sourceBackgroundId,
          sourceBackground: sourceBackground,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentBlockData copyWith({
    Object? id = _Undefined,
    Object? blockKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentBlockData(
      id: id is int? ? id : this.id,
      blockKey: blockKey is String? ? blockKey : this.blockKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _i2.StartingEquipmentBlockKind? ? kind : this.kind,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i3.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i4.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
