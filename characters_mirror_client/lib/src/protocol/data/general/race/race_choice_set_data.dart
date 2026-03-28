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
import '../../../data/general/race/race_feature_data.dart' as _i4;
import '../../../enums/race_choice_kind.dart' as _i5;

abstract class RaceChoiceSetData implements _i1.SerializableModel {
  RaceChoiceSetData._({
    this.id,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.featureId,
    this.feature,
    this.kind,
    this.pickCount,
    this.options,
    this.optionValue,
    this.mustBeDistinct,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceChoiceSetData({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceChoiceSetDataImpl;

  factory RaceChoiceSetData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceChoiceSetData(
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
      featureId: jsonSerialization['featureId'] as int?,
      feature: jsonSerialization['feature'] == null
          ? null
          : _i4.RaceFeatureData.fromJson(
              (jsonSerialization['feature'] as Map<String, dynamic>)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _i5.RaceChoiceKind.fromJson((jsonSerialization['kind'] as int)),
      pickCount: jsonSerialization['pickCount'] as int?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => e as String)
          .toList(),
      optionValue: jsonSerialization['optionValue'] as int?,
      mustBeDistinct: jsonSerialization['mustBeDistinct'] as bool?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
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

  int? featureId;

  _i4.RaceFeatureData? feature;

  _i5.RaceChoiceKind? kind;

  int? pickCount;

  List<String>? options;

  int? optionValue;

  bool? mustBeDistinct;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [RaceChoiceSetData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceChoiceSetData copyWith({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (featureId != null) 'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (pickCount != null) 'pickCount': pickCount,
      if (options != null) 'options': options?.toJson(),
      if (optionValue != null) 'optionValue': optionValue,
      if (mustBeDistinct != null) 'mustBeDistinct': mustBeDistinct,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceChoiceSetDataImpl extends RaceChoiceSetData {
  _RaceChoiceSetDataImpl({
    int? id,
    int? raceId,
    _i2.RaceData? race,
    int? subraceId,
    _i3.SubraceData? subrace,
    int? featureId,
    _i4.RaceFeatureData? feature,
    _i5.RaceChoiceKind? kind,
    int? pickCount,
    List<String>? options,
    int? optionValue,
    bool? mustBeDistinct,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          raceId: raceId,
          race: race,
          subraceId: subraceId,
          subrace: subrace,
          featureId: featureId,
          feature: feature,
          kind: kind,
          pickCount: pickCount,
          options: options,
          optionValue: optionValue,
          mustBeDistinct: mustBeDistinct,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RaceChoiceSetData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceChoiceSetData copyWith({
    Object? id = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? featureId = _Undefined,
    Object? feature = _Undefined,
    Object? kind = _Undefined,
    Object? pickCount = _Undefined,
    Object? options = _Undefined,
    Object? optionValue = _Undefined,
    Object? mustBeDistinct = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceChoiceSetData(
      id: id is int? ? id : this.id,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i3.SubraceData? ? subrace : this.subrace?.copyWith(),
      featureId: featureId is int? ? featureId : this.featureId,
      feature:
          feature is _i4.RaceFeatureData? ? feature : this.feature?.copyWith(),
      kind: kind is _i5.RaceChoiceKind? ? kind : this.kind,
      pickCount: pickCount is int? ? pickCount : this.pickCount,
      options: options is List<String>?
          ? options
          : this.options?.map((e0) => e0).toList(),
      optionValue: optionValue is int? ? optionValue : this.optionValue,
      mustBeDistinct:
          mustBeDistinct is bool? ? mustBeDistinct : this.mustBeDistinct,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
