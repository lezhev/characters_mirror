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
import '../../../data/general/class/starting_equipment_line_data.dart' as _i2;

abstract class StartingEquipmentOptionData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StartingEquipmentOptionData._({
    this.optionKey,
    this.orderIndex,
    this.name,
    this.description,
    this.lines,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory StartingEquipmentOptionData({
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    List<_i2.StartingEquipmentLineData>? lines,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _StartingEquipmentOptionDataImpl;

  factory StartingEquipmentOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return StartingEquipmentOptionData(
      optionKey: jsonSerialization['optionKey'] as String?,
      orderIndex: jsonSerialization['orderIndex'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      lines: (jsonSerialization['lines'] as List?)
          ?.map((e) => _i2.StartingEquipmentLineData.fromJson(
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

  String? optionKey;

  int? orderIndex;

  String? name;

  String? description;

  List<_i2.StartingEquipmentLineData>? lines;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [StartingEquipmentOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StartingEquipmentOptionData copyWith({
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    List<_i2.StartingEquipmentLineData>? lines,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (optionKey != null) 'optionKey': optionKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (lines != null) 'lines': lines?.toJson(valueToJson: (v) => v.toJson()),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (optionKey != null) 'optionKey': optionKey,
      if (orderIndex != null) 'orderIndex': orderIndex,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (lines != null)
        'lines': lines?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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
    String? optionKey,
    int? orderIndex,
    String? name,
    String? description,
    List<_i2.StartingEquipmentLineData>? lines,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          optionKey: optionKey,
          orderIndex: orderIndex,
          name: name,
          description: description,
          lines: lines,
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
    Object? optionKey = _Undefined,
    Object? orderIndex = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? lines = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return StartingEquipmentOptionData(
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      orderIndex: orderIndex is int? ? orderIndex : this.orderIndex,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      lines: lines is List<_i2.StartingEquipmentLineData>?
          ? lines
          : this.lines?.map((e0) => e0.copyWith()).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
