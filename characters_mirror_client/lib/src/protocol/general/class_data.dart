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

abstract class ClassData implements _i1.SerializableModel {
  ClassData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.hitDie,
    this.savingThrows,
    this.proficienciesArmor,
    this.proficienciesWeapons,
    this.proficienciesTools,
    this.skills,
    this.skillCount,
    this.spellcasting,
    this.spellcastingAbility,
    this.startingEquipment,
  });

  factory ClassData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? hitDie,
    List<String>? savingThrows,
    List<String>? proficienciesArmor,
    List<String>? proficienciesWeapons,
    List<String>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<String>? startingEquipment,
  }) = _ClassDataImpl;

  factory ClassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassData(
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
      hitDie: jsonSerialization['hitDie'] as String?,
      savingThrows: (jsonSerialization['savingThrows'] as List?)
          ?.map((e) => e as String)
          .toList(),
      proficienciesArmor: (jsonSerialization['proficienciesArmor'] as List?)
          ?.map((e) => e as String)
          .toList(),
      proficienciesWeapons: (jsonSerialization['proficienciesWeapons'] as List?)
          ?.map((e) => e as String)
          .toList(),
      proficienciesTools: (jsonSerialization['proficienciesTools'] as List?)
          ?.map((e) => e as String)
          .toList(),
      skills: (jsonSerialization['skills'] as List?)
          ?.map((e) => e as String)
          .toList(),
      skillCount: jsonSerialization['skillCount'] as int?,
      spellcasting: jsonSerialization['spellcasting'] as bool?,
      spellcastingAbility: jsonSerialization['spellcastingAbility'] as String?,
      startingEquipment: (jsonSerialization['startingEquipment'] as List?)
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

  String? hitDie;

  List<String>? savingThrows;

  List<String>? proficienciesArmor;

  List<String>? proficienciesWeapons;

  List<String>? proficienciesTools;

  List<String>? skills;

  int? skillCount;

  bool? spellcasting;

  String? spellcastingAbility;

  List<String>? startingEquipment;

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? hitDie,
    List<String>? savingThrows,
    List<String>? proficienciesArmor,
    List<String>? proficienciesWeapons,
    List<String>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<String>? startingEquipment,
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
      if (hitDie != null) 'hitDie': hitDie,
      if (savingThrows != null) 'savingThrows': savingThrows?.toJson(),
      if (proficienciesArmor != null)
        'proficienciesArmor': proficienciesArmor?.toJson(),
      if (proficienciesWeapons != null)
        'proficienciesWeapons': proficienciesWeapons?.toJson(),
      if (proficienciesTools != null)
        'proficienciesTools': proficienciesTools?.toJson(),
      if (skills != null) 'skills': skills?.toJson(),
      if (skillCount != null) 'skillCount': skillCount,
      if (spellcasting != null) 'spellcasting': spellcasting,
      if (spellcastingAbility != null)
        'spellcastingAbility': spellcastingAbility,
      if (startingEquipment != null)
        'startingEquipment': startingEquipment?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassDataImpl extends ClassData {
  _ClassDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? hitDie,
    List<String>? savingThrows,
    List<String>? proficienciesArmor,
    List<String>? proficienciesWeapons,
    List<String>? proficienciesTools,
    List<String>? skills,
    int? skillCount,
    bool? spellcasting,
    String? spellcastingAbility,
    List<String>? startingEquipment,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          hitDie: hitDie,
          savingThrows: savingThrows,
          proficienciesArmor: proficienciesArmor,
          proficienciesWeapons: proficienciesWeapons,
          proficienciesTools: proficienciesTools,
          skills: skills,
          skillCount: skillCount,
          spellcasting: spellcasting,
          spellcastingAbility: spellcastingAbility,
          startingEquipment: startingEquipment,
        );

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? hitDie = _Undefined,
    Object? savingThrows = _Undefined,
    Object? proficienciesArmor = _Undefined,
    Object? proficienciesWeapons = _Undefined,
    Object? proficienciesTools = _Undefined,
    Object? skills = _Undefined,
    Object? skillCount = _Undefined,
    Object? spellcasting = _Undefined,
    Object? spellcastingAbility = _Undefined,
    Object? startingEquipment = _Undefined,
  }) {
    return ClassData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      hitDie: hitDie is String? ? hitDie : this.hitDie,
      savingThrows: savingThrows is List<String>?
          ? savingThrows
          : this.savingThrows?.map((e0) => e0).toList(),
      proficienciesArmor: proficienciesArmor is List<String>?
          ? proficienciesArmor
          : this.proficienciesArmor?.map((e0) => e0).toList(),
      proficienciesWeapons: proficienciesWeapons is List<String>?
          ? proficienciesWeapons
          : this.proficienciesWeapons?.map((e0) => e0).toList(),
      proficienciesTools: proficienciesTools is List<String>?
          ? proficienciesTools
          : this.proficienciesTools?.map((e0) => e0).toList(),
      skills: skills is List<String>?
          ? skills
          : this.skills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      spellcasting: spellcasting is bool? ? spellcasting : this.spellcasting,
      spellcastingAbility: spellcastingAbility is String?
          ? spellcastingAbility
          : this.spellcastingAbility,
      startingEquipment: startingEquipment is List<String>?
          ? startingEquipment
          : this.startingEquipment?.map((e0) => e0).toList(),
    );
  }
}
