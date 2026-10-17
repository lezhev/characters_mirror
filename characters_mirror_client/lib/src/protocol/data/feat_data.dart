/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../enums/feature_tag.dart' as _ij7cgcpq;

abstract class FeatData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    this.tags,
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
    List<_ij7cgcpq.FeatureTag>? tags,
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      abilityBonuses: jsonSerialization['abilityBonuses'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['abilityBonuses'],
            ),
      traits: jsonSerialization['traits'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['traits'],
            ),
      tags: jsonSerialization['tags'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ij7cgcpq.FeatureTag>>(
              jsonSerialization['tags'],
            ),
      specialAbilities: jsonSerialization['specialAbilities'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['specialAbilities'],
            ),
      proficiencies: jsonSerialization['proficiencies'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['proficiencies'],
            ),
      prerequisites: jsonSerialization['prerequisites'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['prerequisites'],
            ),
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

  List<_ij7cgcpq.FeatureTag>? tags;

  List<String>? specialAbilities;

  List<String>? proficiencies;

  Map<String, int>? prerequisites;

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
    List<_ij7cgcpq.FeatureTag>? tags,
    List<String>? specialAbilities,
    List<String>? proficiencies,
    Map<String, int>? prerequisites,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatData',
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (prerequisites != null) 'prerequisites': prerequisites?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
    List<_ij7cgcpq.FeatureTag>? tags,
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
         tags: tags,
         specialAbilities: specialAbilities,
         proficiencies: proficiencies,
         prerequisites: prerequisites,
       );

  /// Returns a shallow copy of this [FeatData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
    Object? tags = _Undefined,
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
          : this.abilityBonuses?.map((key0, value0) => MapEntry(key0, value0)),
      traits: traits is List<String>?
          ? traits
          : this.traits?.map((e0) => e0).toList(),
      tags: tags is List<_ij7cgcpq.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      proficiencies: proficiencies is List<String>?
          ? proficiencies
          : this.proficiencies?.map((e0) => e0).toList(),
      prerequisites: prerequisites is Map<String, int>?
          ? prerequisites
          : this.prerequisites?.map((key0, value0) => MapEntry(key0, value0)),
    );
  }
}
