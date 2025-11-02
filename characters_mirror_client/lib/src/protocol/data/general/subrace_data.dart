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

abstract class SubraceData implements _i1.SerializableModel {
  SubraceData._({
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
    this.skillProficiencies,
    this.speedBonus,
    this.swimSpeed,
    this.climbSpeed,
    this.flySpeed,
    this.visionType,
    this.resistances,
    this.variantOptions,
    this.ageDescription,
    this.alignmentDescription,
    this.physicalDescription,
  });

  factory SubraceData({
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
    List<String>? skillProficiencies,
    int? speedBonus,
    int? swimSpeed,
    int? climbSpeed,
    int? flySpeed,
    String? visionType,
    List<String>? resistances,
    List<String>? variantOptions,
    String? ageDescription,
    String? alignmentDescription,
    String? physicalDescription,
  }) = _SubraceDataImpl;

  factory SubraceData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubraceData(
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
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      speedBonus: jsonSerialization['speedBonus'] as int?,
      swimSpeed: jsonSerialization['swimSpeed'] as int?,
      climbSpeed: jsonSerialization['climbSpeed'] as int?,
      flySpeed: jsonSerialization['flySpeed'] as int?,
      visionType: jsonSerialization['visionType'] as String?,
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => e as String)
          .toList(),
      variantOptions: (jsonSerialization['variantOptions'] as List?)
          ?.map((e) => e as String)
          .toList(),
      ageDescription: jsonSerialization['ageDescription'] as String?,
      alignmentDescription:
          jsonSerialization['alignmentDescription'] as String?,
      physicalDescription: jsonSerialization['physicalDescription'] as String?,
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

  List<String>? skillProficiencies;

  int? speedBonus;

  int? swimSpeed;

  int? climbSpeed;

  int? flySpeed;

  String? visionType;

  List<String>? resistances;

  List<String>? variantOptions;

  String? ageDescription;

  String? alignmentDescription;

  String? physicalDescription;

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubraceData copyWith({
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
    List<String>? skillProficiencies,
    int? speedBonus,
    int? swimSpeed,
    int? climbSpeed,
    int? flySpeed,
    String? visionType,
    List<String>? resistances,
    List<String>? variantOptions,
    String? ageDescription,
    String? alignmentDescription,
    String? physicalDescription,
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
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (speedBonus != null) 'speedBonus': speedBonus,
      if (swimSpeed != null) 'swimSpeed': swimSpeed,
      if (climbSpeed != null) 'climbSpeed': climbSpeed,
      if (flySpeed != null) 'flySpeed': flySpeed,
      if (visionType != null) 'visionType': visionType,
      if (resistances != null) 'resistances': resistances?.toJson(),
      if (variantOptions != null) 'variantOptions': variantOptions?.toJson(),
      if (ageDescription != null) 'ageDescription': ageDescription,
      if (alignmentDescription != null)
        'alignmentDescription': alignmentDescription,
      if (physicalDescription != null)
        'physicalDescription': physicalDescription,
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
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? traits,
    List<String>? specialAbilities,
    List<String>? skillProficiencies,
    int? speedBonus,
    int? swimSpeed,
    int? climbSpeed,
    int? flySpeed,
    String? visionType,
    List<String>? resistances,
    List<String>? variantOptions,
    String? ageDescription,
    String? alignmentDescription,
    String? physicalDescription,
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
          skillProficiencies: skillProficiencies,
          speedBonus: speedBonus,
          swimSpeed: swimSpeed,
          climbSpeed: climbSpeed,
          flySpeed: flySpeed,
          visionType: visionType,
          resistances: resistances,
          variantOptions: variantOptions,
          ageDescription: ageDescription,
          alignmentDescription: alignmentDescription,
          physicalDescription: physicalDescription,
        );

  /// Returns a shallow copy of this [SubraceData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubraceData copyWith({
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
    Object? skillProficiencies = _Undefined,
    Object? speedBonus = _Undefined,
    Object? swimSpeed = _Undefined,
    Object? climbSpeed = _Undefined,
    Object? flySpeed = _Undefined,
    Object? visionType = _Undefined,
    Object? resistances = _Undefined,
    Object? variantOptions = _Undefined,
    Object? ageDescription = _Undefined,
    Object? alignmentDescription = _Undefined,
    Object? physicalDescription = _Undefined,
  }) {
    return SubraceData(
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
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      speedBonus: speedBonus is int? ? speedBonus : this.speedBonus,
      swimSpeed: swimSpeed is int? ? swimSpeed : this.swimSpeed,
      climbSpeed: climbSpeed is int? ? climbSpeed : this.climbSpeed,
      flySpeed: flySpeed is int? ? flySpeed : this.flySpeed,
      visionType: visionType is String? ? visionType : this.visionType,
      resistances: resistances is List<String>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      variantOptions: variantOptions is List<String>?
          ? variantOptions
          : this.variantOptions?.map((e0) => e0).toList(),
      ageDescription:
          ageDescription is String? ? ageDescription : this.ageDescription,
      alignmentDescription: alignmentDescription is String?
          ? alignmentDescription
          : this.alignmentDescription,
      physicalDescription: physicalDescription is String?
          ? physicalDescription
          : this.physicalDescription,
    );
  }
}
