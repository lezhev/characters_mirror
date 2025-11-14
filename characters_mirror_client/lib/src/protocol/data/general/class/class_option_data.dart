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

abstract class ClassOptionData implements _i1.SerializableModel {
  ClassOptionData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.parentClassId,
    this.levelRequired,
    this.type,
    this.isOptional,
  });

  factory ClassOptionData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
  }) = _ClassOptionDataImpl;

  factory ClassOptionData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassOptionData(
      id: jsonSerialization['id'] as int?,
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
      parentClassId: (jsonSerialization['parentClassId'] as List?)
          ?.map((e) => e as int)
          .toList(),
      levelRequired: jsonSerialization['levelRequired'] as int?,
      type: jsonSerialization['type'] as String?,
      isOptional: jsonSerialization['isOptional'] as bool?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<int>? parentClassId;

  int? levelRequired;

  String? type;

  bool? isOptional;

  /// Returns a shallow copy of this [ClassOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassOptionData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (parentClassId != null) 'parentClassId': parentClassId?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
      if (type != null) 'type': type,
      if (isOptional != null) 'isOptional': isOptional,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassOptionDataImpl extends ClassOptionData {
  _ClassOptionDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<int>? parentClassId,
    int? levelRequired,
    String? type,
    bool? isOptional,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentClassId: parentClassId,
          levelRequired: levelRequired,
          type: type,
          isOptional: isOptional,
        );

  /// Returns a shallow copy of this [ClassOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassOptionData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? parentClassId = _Undefined,
    Object? levelRequired = _Undefined,
    Object? type = _Undefined,
    Object? isOptional = _Undefined,
  }) {
    return ClassOptionData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      parentClassId: parentClassId is List<int>?
          ? parentClassId
          : this.parentClassId?.map((e0) => e0).toList(),
      levelRequired: levelRequired is int? ? levelRequired : this.levelRequired,
      type: type is String? ? type : this.type,
      isOptional: isOptional is bool? ? isOptional : this.isOptional,
    );
  }
}
