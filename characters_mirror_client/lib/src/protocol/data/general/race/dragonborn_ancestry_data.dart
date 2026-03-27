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

abstract class DragonbornAncestryData implements _i1.SerializableModel {
  DragonbornAncestryData._({
    this.id,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.damageType,
    this.breathShape,
    this.area,
    this.damageByLevel,
  });

  factory DragonbornAncestryData({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? damageType,
    String? breathShape,
    String? area,
    Map<String, String>? damageByLevel,
  }) = _DragonbornAncestryDataImpl;

  factory DragonbornAncestryData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return DragonbornAncestryData(
      id: jsonSerialization['id'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      name: jsonSerialization['name'] as String?,
      damageType: jsonSerialization['damageType'] as String?,
      breathShape: jsonSerialization['breathShape'] as String?,
      area: jsonSerialization['area'] as String?,
      damageByLevel:
          (jsonSerialization['damageByLevel'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? name;

  String? damageType;

  String? breathShape;

  String? area;

  Map<String, String>? damageByLevel;

  /// Returns a shallow copy of this [DragonbornAncestryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DragonbornAncestryData copyWith({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? damageType,
    String? breathShape,
    String? area,
    Map<String, String>? damageByLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (name != null) 'name': name,
      if (damageType != null) 'damageType': damageType,
      if (breathShape != null) 'breathShape': breathShape,
      if (area != null) 'area': area,
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DragonbornAncestryDataImpl extends DragonbornAncestryData {
  _DragonbornAncestryDataImpl({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? damageType,
    String? breathShape,
    String? area,
    Map<String, String>? damageByLevel,
  }) : super._(
          id: id,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          name: name,
          damageType: damageType,
          breathShape: breathShape,
          area: area,
          damageByLevel: damageByLevel,
        );

  /// Returns a shallow copy of this [DragonbornAncestryData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DragonbornAncestryData copyWith({
    Object? id = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? name = _Undefined,
    Object? damageType = _Undefined,
    Object? breathShape = _Undefined,
    Object? area = _Undefined,
    Object? damageByLevel = _Undefined,
  }) {
    return DragonbornAncestryData(
      id: id is int? ? id : this.id,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      name: name is String? ? name : this.name,
      damageType: damageType is String? ? damageType : this.damageType,
      breathShape: breathShape is String? ? breathShape : this.breathShape,
      area: area is String? ? area : this.area,
      damageByLevel: damageByLevel is Map<String, String>?
          ? damageByLevel
          : this.damageByLevel?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
    );
  }
}
