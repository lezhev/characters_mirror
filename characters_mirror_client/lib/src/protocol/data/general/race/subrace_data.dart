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
import '../../../data/general/race/race_choice_set_data.dart' as _i3;

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
    this.speedOverride,
    this.visionRangeOverride,
    this.skillProficiencies,
    this.resistances,
    this.armorProficiencies,
    this.weaponProficiencies,
    this.toolProficiencies,
    this.choiceSets,
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
    int? speedOverride,
    int? visionRangeOverride,
    List<String>? skillProficiencies,
    List<String>? resistances,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i3.RaceChoiceSetData>? choiceSets,
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
      speedOverride: jsonSerialization['speedOverride'] as int?,
      visionRangeOverride: jsonSerialization['visionRangeOverride'] as int?,
      skillProficiencies: (jsonSerialization['skillProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => e as String)
          .toList(),
      armorProficiencies: (jsonSerialization['armorProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      weaponProficiencies: (jsonSerialization['weaponProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      toolProficiencies: (jsonSerialization['toolProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      choiceSets: (jsonSerialization['choiceSets'] as List?)
          ?.map((e) =>
              _i3.RaceChoiceSetData.fromJson((e as Map<String, dynamic>)))
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

  int? speedOverride;

  int? visionRangeOverride;

  List<String>? skillProficiencies;

  List<String>? resistances;

  List<String>? armorProficiencies;

  List<String>? weaponProficiencies;

  List<String>? toolProficiencies;

  List<_i3.RaceChoiceSetData>? choiceSets;

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
    int? speedOverride,
    int? visionRangeOverride,
    List<String>? skillProficiencies,
    List<String>? resistances,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i3.RaceChoiceSetData>? choiceSets,
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
      if (speedOverride != null) 'speedOverride': speedOverride,
      if (visionRangeOverride != null)
        'visionRangeOverride': visionRangeOverride,
      if (skillProficiencies != null)
        'skillProficiencies': skillProficiencies?.toJson(),
      if (resistances != null) 'resistances': resistances?.toJson(),
      if (armorProficiencies != null)
        'armorProficiencies': armorProficiencies?.toJson(),
      if (weaponProficiencies != null)
        'weaponProficiencies': weaponProficiencies?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (choiceSets != null)
        'choiceSets': choiceSets?.toJson(valueToJson: (v) => v.toJson()),
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
    int? speedOverride,
    int? visionRangeOverride,
    List<String>? skillProficiencies,
    List<String>? resistances,
    List<String>? armorProficiencies,
    List<String>? weaponProficiencies,
    List<String>? toolProficiencies,
    List<_i3.RaceChoiceSetData>? choiceSets,
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
          speedOverride: speedOverride,
          visionRangeOverride: visionRangeOverride,
          skillProficiencies: skillProficiencies,
          resistances: resistances,
          armorProficiencies: armorProficiencies,
          weaponProficiencies: weaponProficiencies,
          toolProficiencies: toolProficiencies,
          choiceSets: choiceSets,
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
    Object? speedOverride = _Undefined,
    Object? visionRangeOverride = _Undefined,
    Object? skillProficiencies = _Undefined,
    Object? resistances = _Undefined,
    Object? armorProficiencies = _Undefined,
    Object? weaponProficiencies = _Undefined,
    Object? toolProficiencies = _Undefined,
    Object? choiceSets = _Undefined,
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
      speedOverride: speedOverride is int? ? speedOverride : this.speedOverride,
      visionRangeOverride: visionRangeOverride is int?
          ? visionRangeOverride
          : this.visionRangeOverride,
      skillProficiencies: skillProficiencies is List<String>?
          ? skillProficiencies
          : this.skillProficiencies?.map((e0) => e0).toList(),
      resistances: resistances is List<String>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      armorProficiencies: armorProficiencies is List<String>?
          ? armorProficiencies
          : this.armorProficiencies?.map((e0) => e0).toList(),
      weaponProficiencies: weaponProficiencies is List<String>?
          ? weaponProficiencies
          : this.weaponProficiencies?.map((e0) => e0).toList(),
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      choiceSets: choiceSets is List<_i3.RaceChoiceSetData>?
          ? choiceSets
          : this.choiceSets?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
