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
import '../../enums/weapon_category.dart' as _i2;
import '../../enums/damage_type.dart' as _i3;

abstract class WeaponData implements _i1.SerializableModel {
  WeaponData._({
    this.id,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.damage,
    this.damageTypeValue,
    this.properties,
    this.weight,
    this.cost,
    this.rangeNormal,
    this.rangeMax,
  });

  factory WeaponData({
    int? id,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.WeaponCategory? category,
    String? damage,
    _i3.DamageType? damageTypeValue,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) = _WeaponDataImpl;

  factory WeaponData.fromJson(Map<String, dynamic> jsonSerialization) {
    return WeaponData(
      id: jsonSerialization['id'] as int?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
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
      category: jsonSerialization['category'] == null
          ? null
          : _i2.WeaponCategory.fromJson(
              (jsonSerialization['category'] as String)),
      damage: jsonSerialization['damage'] as String?,
      damageTypeValue: jsonSerialization['damageTypeValue'] == null
          ? null
          : _i3.DamageType.fromJson(
              (jsonSerialization['damageTypeValue'] as String)),
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

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  _i2.WeaponCategory? category;

  String? damage;

  _i3.DamageType? damageTypeValue;

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
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.WeaponCategory? category,
    String? damage,
    _i3.DamageType? damageTypeValue,
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
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (category != null) 'category': category?.toJson(),
      if (damage != null) 'damage': damage,
      if (damageTypeValue != null) 'damageTypeValue': damageTypeValue?.toJson(),
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
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.WeaponCategory? category,
    String? damage,
    _i3.DamageType? damageTypeValue,
    List<String>? properties,
    double? weight,
    double? cost,
    int? rangeNormal,
    int? rangeMax,
  }) : super._(
          id: id,
          referenceKey: referenceKey,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          damage: damage,
          damageTypeValue: damageTypeValue,
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
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? category = _Undefined,
    Object? damage = _Undefined,
    Object? damageTypeValue = _Undefined,
    Object? properties = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? rangeNormal = _Undefined,
    Object? rangeMax = _Undefined,
  }) {
    return WeaponData(
      id: id is int? ? id : this.id,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      category: category is _i2.WeaponCategory? ? category : this.category,
      damage: damage is String? ? damage : this.damage,
      damageTypeValue: damageTypeValue is _i3.DamageType?
          ? damageTypeValue
          : this.damageTypeValue,
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
