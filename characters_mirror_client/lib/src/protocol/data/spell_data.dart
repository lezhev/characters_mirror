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
import '../enums/spell_school.dart' as _i2;

abstract class SpellData implements _i1.SerializableModel {
  SpellData._({
    this.id,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.level,
    this.schoolValue,
    this.castingTime,
    this.range,
    this.duration,
    this.components,
    this.concentration,
    this.ritual,
    this.higherLevel,
    this.availableForClassIds,
  });

  factory SpellData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _i2.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClassIds,
  }) = _SpellDataImpl;

  factory SpellData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpellData(
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
      level: jsonSerialization['level'] as int?,
      schoolValue: jsonSerialization['schoolValue'] == null
          ? null
          : _i2.SpellSchool.fromJson((jsonSerialization['schoolValue'] as int)),
      castingTime: jsonSerialization['castingTime'] as String?,
      range: jsonSerialization['range'] as String?,
      duration: jsonSerialization['duration'] as String?,
      components: (jsonSerialization['components'] as List?)
          ?.map((e) => e as String)
          .toList(),
      concentration: jsonSerialization['concentration'] as bool?,
      ritual: jsonSerialization['ritual'] as bool?,
      higherLevel: jsonSerialization['higherLevel'] as String?,
      availableForClassIds: (jsonSerialization['availableForClassIds'] as List?)
          ?.map((e) => e as int)
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

  int? level;

  _i2.SpellSchool? schoolValue;

  String? castingTime;

  String? range;

  String? duration;

  List<String>? components;

  bool? concentration;

  bool? ritual;

  String? higherLevel;

  List<int>? availableForClassIds;

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _i2.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClassIds,
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
      if (level != null) 'level': level,
      if (schoolValue != null) 'schoolValue': schoolValue?.toJson(),
      if (castingTime != null) 'castingTime': castingTime,
      if (range != null) 'range': range,
      if (duration != null) 'duration': duration,
      if (components != null) 'components': components?.toJson(),
      if (concentration != null) 'concentration': concentration,
      if (ritual != null) 'ritual': ritual,
      if (higherLevel != null) 'higherLevel': higherLevel,
      if (availableForClassIds != null)
        'availableForClassIds': availableForClassIds?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellDataImpl extends SpellData {
  _SpellDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    _i2.SpellSchool? schoolValue,
    String? castingTime,
    String? range,
    String? duration,
    List<String>? components,
    bool? concentration,
    bool? ritual,
    String? higherLevel,
    List<int>? availableForClassIds,
  }) : super._(
          id: id,
          name: name,
          description: description,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          level: level,
          schoolValue: schoolValue,
          castingTime: castingTime,
          range: range,
          duration: duration,
          components: components,
          concentration: concentration,
          ritual: ritual,
          higherLevel: higherLevel,
          availableForClassIds: availableForClassIds,
        );

  /// Returns a shallow copy of this [SpellData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? level = _Undefined,
    Object? schoolValue = _Undefined,
    Object? castingTime = _Undefined,
    Object? range = _Undefined,
    Object? duration = _Undefined,
    Object? components = _Undefined,
    Object? concentration = _Undefined,
    Object? ritual = _Undefined,
    Object? higherLevel = _Undefined,
    Object? availableForClassIds = _Undefined,
  }) {
    return SpellData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      level: level is int? ? level : this.level,
      schoolValue:
          schoolValue is _i2.SpellSchool? ? schoolValue : this.schoolValue,
      castingTime: castingTime is String? ? castingTime : this.castingTime,
      range: range is String? ? range : this.range,
      duration: duration is String? ? duration : this.duration,
      components: components is List<String>?
          ? components
          : this.components?.map((e0) => e0).toList(),
      concentration:
          concentration is bool? ? concentration : this.concentration,
      ritual: ritual is bool? ? ritual : this.ritual,
      higherLevel: higherLevel is String? ? higherLevel : this.higherLevel,
      availableForClassIds: availableForClassIds is List<int>?
          ? availableForClassIds
          : this.availableForClassIds?.map((e0) => e0).toList(),
    );
  }
}
