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

abstract class StartingEquipmentOptionData implements _i1.SerializableModel {
  StartingEquipmentOptionData._({
    this.id,
    required this.blockId,
    this.block,
    this.optionKey,
    this.orderIndex,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentOptionData({
    int? id,
    required int blockId,
    _i2.StartingEquipmentBlockData? block,
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentOptionDataImpl;

  factory StartingEquipmentOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentOptionData(
      id: jsonSerialization['id'] as int?,
      blockId: jsonSerialization['blockId'] as int,
      block: jsonSerialization['block'] == null
          ? null
          : _i2.StartingEquipmentBlockData.fromJson(
              (jsonSerialization['block'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
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

  int blockId;

  _i2.StartingEquipmentBlockData? block;

  String? optionKey;

  int? orderIndex;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentOptionData copyWith({
    int? id,
    int? blockId,
    _i2.StartingEquipmentBlockData? block,
    String? optionKey,
    int? orderIndex,
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
      'blockId': blockId,
      if (block != null) 'block': block?.toJson(),
      if (optionKey != null) 'optionKey': optionKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
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

class _StartingEquipmentOptionDataImpl extends StartingEquipmentOptionData {
  _StartingEquipmentOptionDataImpl({
    int? id,
    required int blockId,
    _i2.StartingEquipmentBlockData? block,
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          blockId: blockId,
          block: block,
          optionKey: optionKey,
          orderIndex: orderIndex,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StartingEquipmentOptionData copyWith({
    Object? id = _Undefined,
    int? blockId,
    Object? block = _Undefined,
    Object? optionKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentOptionData(
      id: id is int? ? id : this.id,
      blockId: blockId ?? this.blockId,
      block: block is _i2.StartingEquipmentBlockData?
          ? block
          : this.block?.copyWith(),
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
