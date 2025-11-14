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
import '../../../data/general/class/subclass_feature_data.dart' as _i3;

abstract class SubclassData implements _i1.SerializableModel {
  SubclassData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    required this.parentClassId,
    this.parentClass,
    this.subclassFeaturesId,
    this.subclassFeatures,
    this.levelRequired,
  });

  factory SubclassData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int parentClassId,
    _i2.ClassData? parentClass,
    int? subclassFeaturesId,
    _i3.SubclassFeatureData? subclassFeatures,
    int? levelRequired,
  }) = _SubclassDataImpl;

  factory SubclassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassData(
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
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      subclassFeaturesId: jsonSerialization['subclassFeaturesId'] as int?,
      subclassFeatures: jsonSerialization['subclassFeatures'] == null
          ? null
          : _i3.SubclassFeatureData.fromJson(
              (jsonSerialization['subclassFeatures'] as Map<String, dynamic>)),
      levelRequired: jsonSerialization['levelRequired'] as int?,
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

  int parentClassId;

  _i2.ClassData? parentClass;

  int? subclassFeaturesId;

  _i3.SubclassFeatureData? subclassFeatures;

  int? levelRequired;

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubclassData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? parentClassId,
    _i2.ClassData? parentClass,
    int? subclassFeaturesId,
    _i3.SubclassFeatureData? subclassFeatures,
    int? levelRequired,
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
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (subclassFeaturesId != null) 'subclassFeaturesId': subclassFeaturesId,
      if (subclassFeatures != null)
        'subclassFeatures': subclassFeatures?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassDataImpl extends SubclassData {
  _SubclassDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int parentClassId,
    _i2.ClassData? parentClass,
    int? subclassFeaturesId,
    _i3.SubclassFeatureData? subclassFeatures,
    int? levelRequired,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          parentClassId: parentClassId,
          parentClass: parentClass,
          subclassFeaturesId: subclassFeaturesId,
          subclassFeatures: subclassFeatures,
          levelRequired: levelRequired,
        );

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubclassData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? subclassFeaturesId = _Undefined,
    Object? subclassFeatures = _Undefined,
    Object? levelRequired = _Undefined,
  }) {
    return SubclassData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i2.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      subclassFeaturesId: subclassFeaturesId is int?
          ? subclassFeaturesId
          : this.subclassFeaturesId,
      subclassFeatures: subclassFeatures is _i3.SubclassFeatureData?
          ? subclassFeatures
          : this.subclassFeatures?.copyWith(),
      levelRequired: levelRequired is int? ? levelRequired : this.levelRequired,
    );
  }
}
