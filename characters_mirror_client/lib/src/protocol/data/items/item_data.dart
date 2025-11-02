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

abstract class ItemData implements _i1.SerializableModel {
  ItemData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.weight,
    this.cost,
    this.effects,
  });

  factory ItemData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  }) = _ItemDataImpl;

  factory ItemData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ItemData(
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
      category: jsonSerialization['category'] as String?,
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: jsonSerialization['cost'] as int?,
      effects: (jsonSerialization['effects'] as List?)
          ?.map((e) => e as String)
          .toList(),
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

  String? category;

  double? weight;

  int? cost;

  List<String>? effects;

  /// Returns a shallow copy of this [ItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ItemData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
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
      if (category != null) 'category': category,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
      if (effects != null) 'effects': effects?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ItemDataImpl extends ItemData {
  _ItemDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? category,
    double? weight,
    int? cost,
    List<String>? effects,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          category: category,
          weight: weight,
          cost: cost,
          effects: effects,
        );

  /// Returns a shallow copy of this [ItemData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ItemData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? category = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
    Object? effects = _Undefined,
  }) {
    return ItemData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      category: category is String? ? category : this.category,
      weight: weight is double? ? weight : this.weight,
      cost: cost is int? ? cost : this.cost,
      effects: effects is List<String>?
          ? effects
          : this.effects?.map((e0) => e0).toList(),
    );
  }
}
