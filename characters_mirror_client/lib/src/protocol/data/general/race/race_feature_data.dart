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
import '../../../data/general/race/subrace_data.dart' as _i3;
import '../../../enums/feature_tag.dart' as _i4;
import '../../../data/general/race/race_feature_spell_grant_data.dart' as _i5;
import '../../../data/general/race/race_choice_set_data.dart' as _i6;

abstract class RaceFeatureData implements _i1.SerializableModel {
  RaceFeatureData._({
    this.id,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.spells,
    this.usesPerRest,
    this.usesFormula,
    this.tags,
    this.spellGrants,
    this.choiceSets,
  });

  factory RaceFeatureData({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    Map<String, int>? spells,
    String? usesPerRest,
    String? usesFormula,
    List<_i4.FeatureTag>? tags,
    List<_i5.RaceFeatureSpellGrantData>? spellGrants,
    List<_i6.RaceChoiceSetData>? choiceSets,
  }) = _RaceFeatureDataImpl;

  factory RaceFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceFeatureData(
      id: jsonSerialization['id'] as int?,
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i3.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
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
      level: jsonSerialization['level'] as int?,
      spells: (jsonSerialization['spells'] as Map?)?.map((k, v) => MapEntry(
            k as String,
            v as int,
          )),
      usesPerRest: jsonSerialization['usesPerRest'] as String?,
      usesFormula: jsonSerialization['usesFormula'] as String?,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i4.FeatureTag.fromJson((e as String)))
          .toList(),
      spellGrants: (jsonSerialization['spellGrants'] as List?)
          ?.map((e) => _i5.RaceFeatureSpellGrantData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      choiceSets: (jsonSerialization['choiceSets'] as List?)
          ?.map((e) =>
              _i6.RaceChoiceSetData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? raceId;

  _i2.RaceData? race;

  int? subraceId;

  _i3.SubraceData? subrace;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? level;

  Map<String, int>? spells;

  String? usesPerRest;

  String? usesFormula;

  List<_i4.FeatureTag>? tags;

  List<_i5.RaceFeatureSpellGrantData>? spellGrants;

  List<_i6.RaceChoiceSetData>? choiceSets;

  /// Returns a shallow copy of this [RaceFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceFeatureData copyWith({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    Map<String, int>? spells,
    String? usesPerRest,
    String? usesFormula,
    List<_i4.FeatureTag>? tags,
    List<_i5.RaceFeatureSpellGrantData>? spellGrants,
    List<_i6.RaceChoiceSetData>? choiceSets,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (level != null) 'level': level,
      if (spells != null) 'spells': spells?.toJson(),
      if (usesPerRest != null) 'usesPerRest': usesPerRest,
      if (usesFormula != null) 'usesFormula': usesFormula,
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(valueToJson: (v) => v.toJson()),
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

class _RaceFeatureDataImpl extends RaceFeatureData {
  _RaceFeatureDataImpl({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    Map<String, int>? spells,
    String? usesPerRest,
    String? usesFormula,
    List<_i4.FeatureTag>? tags,
    List<_i5.RaceFeatureSpellGrantData>? spellGrants,
    List<_i6.RaceChoiceSetData>? choiceSets,
  }) : super._(
          id: id,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          level: level,
          spells: spells,
          usesPerRest: usesPerRest,
          usesFormula: usesFormula,
          tags: tags,
          spellGrants: spellGrants,
          choiceSets: choiceSets,
        );

  /// Returns a shallow copy of this [RaceFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceFeatureData copyWith({
    Object? id = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? level = _Undefined,
    Object? spells = _Undefined,
    Object? usesPerRest = _Undefined,
    Object? usesFormula = _Undefined,
    Object? tags = _Undefined,
    Object? spellGrants = _Undefined,
    Object? choiceSets = _Undefined,
  }) {
    return RaceFeatureData(
      id: id is int? ? id : this.id,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i3.SubraceData? ? subrace : this.subrace?.copyWith(),
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      level: level is int? ? level : this.level,
      spells: spells is Map<String, int>?
          ? spells
          : this.spells?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      usesPerRest: usesPerRest is String? ? usesPerRest : this.usesPerRest,
      usesFormula: usesFormula is String? ? usesFormula : this.usesFormula,
      tags: tags is List<_i4.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      spellGrants: spellGrants is List<_i5.RaceFeatureSpellGrantData>?
          ? spellGrants
          : this.spellGrants?.map((e0) => e0.copyWith()).toList(),
      choiceSets: choiceSets is List<_i6.RaceChoiceSetData>?
          ? choiceSets
          : this.choiceSets?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
