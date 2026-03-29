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
import '../../../data/general/class/subclass_data.dart' as _i2;
import '../../../enums/feature_tag.dart' as _i3;

abstract class SubclassFeatureData implements _i1.SerializableModel {
  SubclassFeatureData._({
    this.id,
    required this.parentSubclassId,
    this.parentSubclass,
    this.name,
    this.description,
    required this.level,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.choiceGroupKey,
  });

  factory SubclassFeatureData({
    int? id,
    required int parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  }) = _SubclassFeatureDataImpl;

  factory SubclassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentSubclassId: jsonSerialization['parentSubclassId'] as int,
      parentSubclass: jsonSerialization['parentSubclass'] == null
          ? null
          : _i2.SubclassData.fromJson(
              (jsonSerialization['parentSubclass'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      level: jsonSerialization['level'] as int,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int parentSubclassId;

  _i2.SubclassData? parentSubclass;

  String? name;

  String? description;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<_i3.FeatureTag>? tags;

  String? choiceGroupKey;

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubclassFeatureData copyWith({
    int? id,
    int? parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'parentSubclassId': parentSubclassId,
      if (parentSubclass != null) 'parentSubclass': parentSubclass?.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassFeatureDataImpl extends SubclassFeatureData {
  _SubclassFeatureDataImpl({
    int? id,
    required int parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
  }) : super._(
          id: id,
          parentSubclassId: parentSubclassId,
          parentSubclass: parentSubclass,
          name: name,
          description: description,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          tags: tags,
          choiceGroupKey: choiceGroupKey,
        );

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubclassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentSubclassId,
    Object? parentSubclass = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    int? level,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? tags = _Undefined,
    Object? choiceGroupKey = _Undefined,
  }) {
    return SubclassFeatureData(
      id: id is int? ? id : this.id,
      parentSubclassId: parentSubclassId ?? this.parentSubclassId,
      parentSubclass: parentSubclass is _i2.SubclassData?
          ? parentSubclass
          : this.parentSubclass?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      level: level ?? this.level,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      tags: tags is List<_i3.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      choiceGroupKey:
          choiceGroupKey is String? ? choiceGroupKey : this.choiceGroupKey,
    );
  }
}
