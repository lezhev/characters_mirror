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

abstract class FeatData implements _i1.SerializableModel {
  FeatData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.traits,
    this.specialAbilities,
    this.proficiencies,
    this.prerequisites,
  });

  factory FeatData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  }) = _FeatDataImpl;

  factory FeatData.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeatData(
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
      abilityBonuses:
          (jsonSerialization['abilityBonuses'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      traits: (jsonSerialization['traits'] as List?)
          ?.map((e) => e as String)
          .toList(),
      specialAbilities: (jsonSerialization['specialAbilities'] as List?)
          ?.map((e) => e as String)
          .toList(),
      proficiencies: (jsonSerialization['proficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      prerequisites:
          (jsonSerialization['prerequisites'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
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

  Map<String, int>? abilityBonuses;

  List<String>? traits;

  List<String>? specialAbilities;

  List<String>? proficiencies;

  Map<String, int>? prerequisites;

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
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
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatDataImpl extends FeatData {
  _FeatDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          traits: traits,
          specialAbilities: specialAbilities,
          proficiencies: proficiencies,
          prerequisites: prerequisites,
        );

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? traits = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? proficiencies = _Undefined,
    Object? prerequisites = _Undefined,
  }) {
    return FeatData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      abilityBonuses: abilityBonuses is Map<String, int>?
          ? abilityBonuses
          : this.abilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      proficiencies: proficiencies is List<String>?
          ? proficiencies
          : this.proficiencies?.map((e0) => e0).toList(),
      prerequisites: prerequisites is Map<String, int>?
          ? prerequisites
          : this.prerequisites?.map((
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
