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
import '../../../data/general/class/subclass_data.dart' as _i2;

abstract class SubclassFeatureData implements _i1.SerializableModel {
  SubclassFeatureData._({
    this.id,
    required this.parentSubclassId,
    this.parentSubclass,
    this.name,
    this.description,
    required this.level,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.abilityBonuses,
    this.proficiencies,
    this.specialAbilities,
    this.variantOptions,
    this.resourceName,
    this.resourceAmount,
    this.resourceRegain,
    this.spellSlots,
    required this.knownSpells,
    required this.knownCantips,
  });

  factory SubclassFeatureData({
    int? id,
    required int parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    String? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
    required int knownSpells,
    required int knownCantips,
  }) = _SubclassFeatureDataImpl;

  factory SubclassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentSubclassId: jsonSerialization['parentSubclassId'] as int,
      parentSubclass: jsonSerialization['parentSubclass'] == null
          ? null
          : _i2.SubclassData.fromJson(
              (jsonSerialization['parentSubclass'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      level: jsonSerialization['level'] as int,
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
      proficiencies: (jsonSerialization['proficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      specialAbilities: (jsonSerialization['specialAbilities'] as List?)
          ?.map((e) => e as String)
          .toList(),
      variantOptions: jsonSerialization['variantOptions'] as String?,
      resourceName: jsonSerialization['resourceName'] as String?,
      resourceAmount: jsonSerialization['resourceAmount'] as int?,
      resourceRegain: jsonSerialization['resourceRegain'] as String?,
      spellSlots: (jsonSerialization['spellSlots'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      knownSpells: jsonSerialization['knownSpells'] as int,
      knownCantips: jsonSerialization['knownCantips'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int parentSubclassId;

  _i2.SubclassData? parentSubclass;

  String? name;

  String? description;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  Map<String, int>? abilityBonuses;

  List<String>? proficiencies;

  List<String>? specialAbilities;

  String? variantOptions;

  String? resourceName;

  int? resourceAmount;

  String? resourceRegain;

  Map<int, int>? spellSlots;

  int knownSpells;

  int knownCantips;

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubclassFeatureData copyWith({
    int? id,
    int? parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    String? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
    int? knownSpells,
    int? knownCantips,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'parentSubclassId': parentSubclassId,
      if (parentSubclass != null) 'parentSubclass': parentSubclass?.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (abilityBonuses != null) 'abilityBonuses': abilityBonuses?.toJson(),
      if (proficiencies != null) 'proficiencies': proficiencies?.toJson(),
      if (specialAbilities != null)
        'specialAbilities': specialAbilities?.toJson(),
      if (variantOptions != null) 'variantOptions': variantOptions,
      if (resourceName != null) 'resourceName': resourceName,
      if (resourceAmount != null) 'resourceAmount': resourceAmount,
      if (resourceRegain != null) 'resourceRegain': resourceRegain,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      'knownSpells': knownSpells,
      'knownCantips': knownCantips,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassFeatureDataImpl extends SubclassFeatureData {
  _SubclassFeatureDataImpl({
    int? id,
    required int parentSubclassId,
    _i2.SubclassData? parentSubclass,
    String? name,
    String? description,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, int>? abilityBonuses,
    List<String>? proficiencies,
    List<String>? specialAbilities,
    String? variantOptions,
    String? resourceName,
    int? resourceAmount,
    String? resourceRegain,
    Map<int, int>? spellSlots,
    required int knownSpells,
    required int knownCantips,
  }) : super._(
          id: id,
          parentSubclassId: parentSubclassId,
          parentSubclass: parentSubclass,
          name: name,
          description: description,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          abilityBonuses: abilityBonuses,
          proficiencies: proficiencies,
          specialAbilities: specialAbilities,
          variantOptions: variantOptions,
          resourceName: resourceName,
          resourceAmount: resourceAmount,
          resourceRegain: resourceRegain,
          spellSlots: spellSlots,
          knownSpells: knownSpells,
          knownCantips: knownCantips,
        );

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubclassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentSubclassId,
    Object? parentSubclass = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    int? level,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? abilityBonuses = _Undefined,
    Object? proficiencies = _Undefined,
    Object? specialAbilities = _Undefined,
    Object? variantOptions = _Undefined,
    Object? resourceName = _Undefined,
    Object? resourceAmount = _Undefined,
    Object? resourceRegain = _Undefined,
    Object? spellSlots = _Undefined,
    int? knownSpells,
    int? knownCantips,
  }) {
    return SubclassFeatureData(
      id: id is int? ? id : this.id,
      parentSubclassId: parentSubclassId ?? this.parentSubclassId,
      parentSubclass: parentSubclass is _i2.SubclassData?
          ? parentSubclass
          : this.parentSubclass?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      level: level ?? this.level,
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
      proficiencies: proficiencies is List<String>?
          ? proficiencies
          : this.proficiencies?.map((e0) => e0).toList(),
      specialAbilities: specialAbilities is List<String>?
          ? specialAbilities
          : this.specialAbilities?.map((e0) => e0).toList(),
      variantOptions:
          variantOptions is String? ? variantOptions : this.variantOptions,
      resourceName: resourceName is String? ? resourceName : this.resourceName,
      resourceAmount:
          resourceAmount is int? ? resourceAmount : this.resourceAmount,
      resourceRegain:
          resourceRegain is String? ? resourceRegain : this.resourceRegain,
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      knownSpells: knownSpells ?? this.knownSpells,
      knownCantips: knownCantips ?? this.knownCantips,
    );
  }
}
