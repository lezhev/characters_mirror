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
import '../../../enums/starting_equipment_block_kind.dart' as _i2;
import '../../../data/general/class/starting_equipment_line_data.dart' as _i3;
import '../../../data/general/class/starting_equipment_option_data.dart' as _i4;

abstract class StartingEquipmentBlockData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StartingEquipmentBlockData._({
    this.blockKey,
    this.orderIndex,
    this.kind,
    this.selectionCount,
    this.name,
    this.description,
    this.fixedLines,
    this.options,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentBlockData({
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    String? name,
    String? description,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionData>? options,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentBlockDataImpl;

  factory StartingEquipmentBlockData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentBlockData(
      blockKey: jsonSerialization['blockKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      kind: jsonSerialization['kind'] == null
          ? null
          : _i2.StartingEquipmentBlockKind.fromJson(
              (jsonSerialization['kind'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      fixedLines: (jsonSerialization['fixedLines'] as List?)
          ?.map((e) => _i3.StartingEquipmentLineData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => _i4.StartingEquipmentOptionData.fromJson(
              (e as Map<String, dynamic>)))
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

  String? blockKey;

  int? orderIndex;

  _i2.StartingEquipmentBlockKind? kind;

  int? selectionCount;

  String? name;

  String? description;

  List<_i3.StartingEquipmentLineData>? fixedLines;

  List<_i4.StartingEquipmentOptionData>? options;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentBlockData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentBlockData copyWith({
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    String? name,
    String? description,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionData>? options,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (blockKey != null) 'blockKey': blockKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (fixedLines != null)
        'fixedLines': fixedLines?.toJson(valueToJson: (v) => v.toJson()),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (blockKey != null) 'blockKey': blockKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (kind != null) 'kind': kind?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (fixedLines != null)
        'fixedLines':
            fixedLines?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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
    String? blockKey,
    int? orderIndex,
    _i2.StartingEquipmentBlockKind? kind,
    int? selectionCount,
    String? name,
    String? description,
    List<_i3.StartingEquipmentLineData>? fixedLines,
    List<_i4.StartingEquipmentOptionData>? options,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          blockKey: blockKey,
          orderIndex: orderIndex,
          kind: kind,
          selectionCount: selectionCount,
          name: name,
          description: description,
          fixedLines: fixedLines,
          options: options,
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
    Object? blockKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? kind = _Undefined,
    Object? selectionCount = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? fixedLines = _Undefined,
    Object? options = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentBlockData(
      blockKey: blockKey is String? ? blockKey : this.blockKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      kind: kind is _i2.StartingEquipmentBlockKind? ? kind : this.kind,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      fixedLines: fixedLines is List<_i3.StartingEquipmentLineData>?
          ? fixedLines
          : this.fixedLines?.map((e0) => e0.copyWith()).toList(),
      options: options is List<_i4.StartingEquipmentOptionData>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
