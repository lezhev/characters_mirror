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
import '../../enums/armor_category.dart' as _i2;

abstract class ArmorData implements _i1.SerializableModel {
  ArmorData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.categoryValue,
    this.baseAC,
    this.dexBonus,
    this.dexBonusMax,
    this.strengthRequirement,
    this.stealthDisadvantage,
    this.weight,
    this.cost,
  });

  factory ArmorData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.ArmorCategory? categoryValue,
    int? baseAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  }) = _ArmorDataImpl;

  factory ArmorData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArmorData(
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
      categoryValue: jsonSerialization['categoryValue'] == null
          ? null
          : _i2.ArmorCategory.fromJson(
              (jsonSerialization['categoryValue'] as String)),
      baseAC: jsonSerialization['baseAC'] as int?,
      dexBonus: jsonSerialization['dexBonus'] as bool?,
      dexBonusMax: jsonSerialization['dexBonusMax'] as int?,
      strengthRequirement: jsonSerialization['strengthRequirement'] as int?,
      stealthDisadvantage: jsonSerialization['stealthDisadvantage'] as bool?,
      weight: (jsonSerialization['weight'] as num?)?.toDouble(),
      cost: jsonSerialization['cost'] as String?,
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

  _i2.ArmorCategory? categoryValue;

  int? baseAC;

  bool? dexBonus;

  int? dexBonusMax;

  int? strengthRequirement;

  bool? stealthDisadvantage;

  double? weight;

  String? cost;

  /// Returns a shallow copy of this [ArmorData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ArmorData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.ArmorCategory? categoryValue,
    int? baseAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
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
      if (categoryValue != null) 'categoryValue': categoryValue?.toJson(),
      if (baseAC != null) 'baseAC': baseAC,
      if (dexBonus != null) 'dexBonus': dexBonus,
      if (dexBonusMax != null) 'dexBonusMax': dexBonusMax,
      if (strengthRequirement != null)
        'strengthRequirement': strengthRequirement,
      if (stealthDisadvantage != null)
        'stealthDisadvantage': stealthDisadvantage,
      if (weight != null) 'weight': weight,
      if (cost != null) 'cost': cost,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ArmorDataImpl extends ArmorData {
  _ArmorDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    _i2.ArmorCategory? categoryValue,
    int? baseAC,
    bool? dexBonus,
    int? dexBonusMax,
    int? strengthRequirement,
    bool? stealthDisadvantage,
    double? weight,
    String? cost,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          categoryValue: categoryValue,
          baseAC: baseAC,
          dexBonus: dexBonus,
          dexBonusMax: dexBonusMax,
          strengthRequirement: strengthRequirement,
          stealthDisadvantage: stealthDisadvantage,
          weight: weight,
          cost: cost,
        );

  /// Returns a shallow copy of this [ArmorData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ArmorData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? categoryValue = _Undefined,
    Object? baseAC = _Undefined,
    Object? dexBonus = _Undefined,
    Object? dexBonusMax = _Undefined,
    Object? strengthRequirement = _Undefined,
    Object? stealthDisadvantage = _Undefined,
    Object? weight = _Undefined,
    Object? cost = _Undefined,
  }) {
    return ArmorData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      categoryValue: categoryValue is _i2.ArmorCategory?
          ? categoryValue
          : this.categoryValue,
      baseAC: baseAC is int? ? baseAC : this.baseAC,
      dexBonus: dexBonus is bool? ? dexBonus : this.dexBonus,
      dexBonusMax: dexBonusMax is int? ? dexBonusMax : this.dexBonusMax,
      strengthRequirement: strengthRequirement is int?
          ? strengthRequirement
          : this.strengthRequirement,
      stealthDisadvantage: stealthDisadvantage is bool?
          ? stealthDisadvantage
          : this.stealthDisadvantage,
      weight: weight is double? ? weight : this.weight,
      cost: cost is String? ? cost : this.cost,
    );
  }
}
