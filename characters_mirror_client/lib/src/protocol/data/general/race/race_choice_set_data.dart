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
import '../../../data/general/race/race_feature_data.dart' as _i2;
import '../../../enums/race_choice_kind.dart' as _i3;
import '../../../data/general/race/race_choice_option_data.dart' as _i4;

abstract class RaceChoiceSetData implements _i1.SerializableModel {
  RaceChoiceSetData._({
    this.id,
    required this.featureId,
    this.feature,
    this.kind,
    this.pickCount,
    this.mustBeDistinct,
    this.description,
    this.choiceOptions,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceChoiceSetData({
    int? id,
    required int featureId,
    _i2.RaceFeatureData? feature,
    _i3.RaceChoiceKind? kind,
    int? pickCount,
    bool? mustBeDistinct,
    String? description,
    List<_i4.RaceChoiceOptionData>? choiceOptions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceChoiceSetDataImpl;

  factory RaceChoiceSetData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceChoiceSetData(
      id: jsonSerialization['id'] as int?,
      featureId: jsonSerialization['featureId'] as int,
      feature: jsonSerialization['feature'] == null
          ? null
          : _i2.RaceFeatureData.fromJson(
              (jsonSerialization['feature'] as Map<String, dynamic>)),
      kind: jsonSerialization['kind'] == null
          ? null
          : _i3.RaceChoiceKind.fromJson((jsonSerialization['kind'] as String)),
      pickCount: jsonSerialization['pickCount'] as int?,
      mustBeDistinct: jsonSerialization['mustBeDistinct'] as bool?,
      description: jsonSerialization['description'] as String?,
      choiceOptions: (jsonSerialization['choiceOptions'] as List?)
          ?.map((e) =>
              _i4.RaceChoiceOptionData.fromJson((e as Map<String, dynamic>)))
          .toList(),
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

  int featureId;

  _i2.RaceFeatureData? feature;

  _i3.RaceChoiceKind? kind;

  int? pickCount;

  bool? mustBeDistinct;

  String? description;

  List<_i4.RaceChoiceOptionData>? choiceOptions;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [RaceChoiceSetData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceChoiceSetData copyWith({
    int? id,
    int? featureId,
    _i2.RaceFeatureData? feature,
    _i3.RaceChoiceKind? kind,
    int? pickCount,
    bool? mustBeDistinct,
    String? description,
    List<_i4.RaceChoiceOptionData>? choiceOptions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'featureId': featureId,
      if (feature != null) 'feature': feature?.toJson(),
      if (kind != null) 'kind': kind?.toJson(),
      if (pickCount != null) 'pickCount': pickCount,
      if (mustBeDistinct != null) 'mustBeDistinct': mustBeDistinct,
      if (description != null) 'description': description,
      if (choiceOptions != null)
        'choiceOptions': choiceOptions?.toJson(valueToJson: (v) => v.toJson()),
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
    required int featureId,
    _i2.RaceFeatureData? feature,
    _i3.RaceChoiceKind? kind,
    int? pickCount,
    bool? mustBeDistinct,
    String? description,
    List<_i4.RaceChoiceOptionData>? choiceOptions,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          featureId: featureId,
          feature: feature,
          kind: kind,
          pickCount: pickCount,
          mustBeDistinct: mustBeDistinct,
          description: description,
          choiceOptions: choiceOptions,
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
    int? featureId,
    Object? feature = _Undefined,
    Object? kind = _Undefined,
    Object? pickCount = _Undefined,
    Object? mustBeDistinct = _Undefined,
    Object? description = _Undefined,
    Object? choiceOptions = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceChoiceSetData(
      id: id is int? ? id : this.id,
      featureId: featureId ?? this.featureId,
      feature:
          feature is _i2.RaceFeatureData? ? feature : this.feature?.copyWith(),
      kind: kind is _i3.RaceChoiceKind? ? kind : this.kind,
      pickCount: pickCount is int? ? pickCount : this.pickCount,
      mustBeDistinct:
          mustBeDistinct is bool? ? mustBeDistinct : this.mustBeDistinct,
      description: description is String? ? description : this.description,
      choiceOptions: choiceOptions is List<_i4.RaceChoiceOptionData>?
          ? choiceOptions
          : this.choiceOptions?.map((e0) => e0.copyWith()).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
