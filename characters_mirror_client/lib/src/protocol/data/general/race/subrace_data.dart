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
import '../../../data/general/race/race_data.dart' as _i2;
import '../../../data/general/race/race_option_data.dart' as _i3;

abstract class SubraceData implements _i1.SerializableModel {
  SubraceData._({
    this.id,
    this.name,
    required this.parentRaceId,
    this.parentRace,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.traits,
    this.specialAbilities,
    this.skillProficiencies,
    this.resistances,
    this.variantOptions,
  });

  factory SubraceData({
    int? id,
    String? name,
    required int parentRaceId,
    _i2.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    List<String>? resistances,
    List<_i3.RaceOptionData>? variantOptions,
  }) = _SubraceDataImpl;

  factory SubraceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubraceData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      parentRaceId: jsonSerialization['parentRaceId'] as int,
      parentRace: jsonSerialization['parentRace'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['parentRace'] as Map<String, dynamic>)),
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
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => e as String)
          .toList(),
      variantOptions: (jsonSerialization['variantOptions'] as List?)
          ?.map((e) => _i3.RaceOptionData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  int parentRaceId;

  _i2.RaceData? parentRace;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, int>? abilityBonuses;

  List<String>? traits;

  List<String>? specialAbilities;

  List<String>? skillProficiencies;

  List<String>? resistances;

  List<_i3.RaceOptionData>? variantOptions;

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubraceData copyWith({
    int? id,
    String? name,
    int? parentRaceId,
    _i2.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    List<String>? resistances,
    List<_i3.RaceOptionData>? variantOptions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      'parentRaceId': parentRaceId,
      if (parentRace != null) 'parentRace': parentRace?.toJson(),
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (traits != null) 'traits': traits?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (resistances != null) 'resistances': resistances?.toJson(),
      if (variantOptions != null)
        'variantOptions':
            variantOptions?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubraceDataImpl extends SubraceData {
  _SubraceDataImpl({
    int? id,
    String? name,
    required int parentRaceId,
    _i2.RaceData? parentRace,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    List<String>? resistances,
    List<_i3.RaceOptionData>? variantOptions,
  }) : super._(
          id: id,
          name: name,
          parentRaceId: parentRaceId,
          parentRace: parentRace,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          traits: traits,
          specialAbilities: specialAbilities,
          skillProficiencies: skillProficiencies,
          resistances: resistances,
          variantOptions: variantOptions,
        );

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubraceData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    int? parentRaceId,
    Object? parentRace = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? traits = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? resistances = _Undefined,
    Object? variantOptions = _Undefined,
  }) {
    return SubraceData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      parentRaceId: parentRaceId ?? this.parentRaceId,
      parentRace: parentRace is _i2.RaceData?
          ? parentRace
          : this.parentRace?.copyWith(),
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
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      resistances: resistances is List<String>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      variantOptions: variantOptions is List<_i3.RaceOptionData>?
          ? variantOptions
          : this.variantOptions?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
