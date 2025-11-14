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

abstract class WeaponData implements _i1.SerializableModel {
  WeaponData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.isSimple,
    this.isMelee,
    this.damage,
    this.damageType,
    this.properties,
    this.weight,
    this.cost,
    this.rangeNormal,
    this.rangeMax,
  });

  factory WeaponData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSimple,
    bool? isMelee,
    String? damage,
    String? damageType,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) = _WeaponDataImpl;

  factory WeaponData.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeaponData(
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
      isSimple: jsonSerialization['isSimple'] as bool?,
      isMelee: jsonSerialization['isMelee'] as bool?,
      damage: jsonSerialization['damage'] as String?,
      damageType: jsonSerialization['damageType'] as String?,
      properties: (jsonSerialization['properties'] as List?)
          ?.map((e) => e as String)
          .toList(),
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: (jsonSerialization['cost'] as num?)?.toDouble(),
      rangeNormal: jsonSerialization['rangeNormal'] as int?,
      rangeMax: jsonSerialization['rangeMax'] as int?,
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

  bool? isSimple;

  bool? isMelee;

  String? damage;

  String? damageType;

  List<String>? properties;

  double? weight;

  double? cost;

  int? rangeNormal;

  int? rangeMax;

  /// Returns a shallow copy of this [WeaponData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WeaponData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSimple,
    bool? isMelee,
    String? damage,
    String? damageType,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
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
      if (isSimple != null) 'isSimple': isSimple,
      if (isMelee != null) 'isMelee': isMelee,
      if (damage != null) 'damage': damage,
      if (damageType != null) 'damageType': damageType,
      if (properties != null) 'properties': properties?.toJson(),
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (rangeNormal != null) 'rangeNormal': rangeNormal,
      if (rangeMax != null) 'rangeMax': rangeMax,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WeaponDataImpl extends WeaponData {
  _WeaponDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isSimple,
    bool? isMelee,
    String? damage,
    String? damageType,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          isSimple: isSimple,
          isMelee: isMelee,
          damage: damage,
          damageType: damageType,
          properties: properties,
          weight: weight,
          cost: cost,
          rangeNormal: rangeNormal,
          rangeMax: rangeMax,
        );

  /// Returns a shallow copy of this [WeaponData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WeaponData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? isSimple = _Undefined,
    Object? isMelee = _Undefined,
    Object? damage = _Undefined,
    Object? damageType = _Undefined,
    Object? properties = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? rangeNormal = _Undefined,
    Object? rangeMax = _Undefined,
  }) {
    return WeaponData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      isSimple: isSimple is bool? ? isSimple : this.isSimple,
      isMelee: isMelee is bool? ? isMelee : this.isMelee,
      damage: damage is String? ? damage : this.damage,
      damageType: damageType is String? ? damageType : this.damageType,
      properties: properties is List<String>?
          ? properties
          : this.properties?.map((e0) => e0).toList(),
      weight: weight is double? ? weight : this.weight,
      cost: cost is double? ? cost : this.cost,
      rangeNormal: rangeNormal is int? ? rangeNormal : this.rangeNormal,
      rangeMax: rangeMax is int? ? rangeMax : this.rangeMax,
    );
  }
}
