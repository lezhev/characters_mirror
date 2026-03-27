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

abstract class RaceOptionData implements _i1.SerializableModel {
  RaceOptionData._({
    this.id,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    required this.raceId,
    this.race,
    this.type,
    this.uses,
    this.options,
  });

  factory RaceOptionData({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int raceId,
    _i2.RaceData? race,
    String? type,
    int? uses,
    List<String>? options,
  }) = _RaceOptionDataImpl;

  factory RaceOptionData.fromJson(Map<String, dynamic> jsonSerialization) {
    return RaceOptionData(
      id: jsonSerialization['id'] as int?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      raceId: jsonSerialization['raceId'] as int,
      race: jsonSerialization['race'] == null
          ? null
          : _i2.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      type: jsonSerialization['type'] as String?,
      uses: jsonSerialization['uses'] as int?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int raceId;

  _i2.RaceData? race;

  String? type;

  int? uses;

  List<String>? options;

  /// Returns a shallow copy of this [RaceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceOptionData copyWith({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? raceId,
    _i2.RaceData? race,
    String? type,
    int? uses,
    List<String>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (type != null) 'type': type,
      if (uses != null) 'uses': uses,
      if (options != null) 'options': options?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RaceOptionDataImpl extends RaceOptionData {
  _RaceOptionDataImpl({
    int? id,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    required int raceId,
    _i2.RaceData? race,
    String? type,
    int? uses,
    List<String>? options,
  }) : super._(
          id: id,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          raceId: raceId,
          race: race,
          type: type,
          uses: uses,
          options: options,
        );

  /// Returns a shallow copy of this [RaceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceOptionData copyWith({
    Object? id = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    int? raceId,
    Object? race = _Undefined,
    Object? type = _Undefined,
    Object? uses = _Undefined,
    Object? options = _Undefined,
  }) {
    return RaceOptionData(
      id: id is int? ? id : this.id,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      raceId: raceId ?? this.raceId,
      race: race is _i2.RaceData? ? race : this.race?.copyWith(),
      type: type is String? ? type : this.type,
      uses: uses is int? ? uses : this.uses,
      options: options is List<String>?
          ? options
          : this.options?.map((e0) => e0).toList(),
    );
  }
}
