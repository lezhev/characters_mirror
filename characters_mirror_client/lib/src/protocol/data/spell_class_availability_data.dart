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
import '../data/spell_data.dart' as _i2;
import '../data/general/class/class_data.dart' as _i3;

abstract class SpellClassAvailabilityData implements _i1.SerializableModel {
  SpellClassAvailabilityData._({
    this.id,
    required this.spellId,
    this.spell,
    required this.classDataId,
    this.classData,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory SpellClassAvailabilityData({
    int? id,
    required int spellId,
    _i2.SpellData? spell,
    required int classDataId,
    _i3.ClassData? classData,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpellClassAvailabilityDataImpl;

  factory SpellClassAvailabilityData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellClassAvailabilityData(
      id: jsonSerialization['id'] as int?,
      spellId: jsonSerialization['spellId'] as int,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i2.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
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

  int spellId;

  _i2.SpellData? spell;

  int classDataId;

  _i3.ClassData? classData;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [SpellClassAvailabilityData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellClassAvailabilityData copyWith({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    int? classDataId,
    _i3.ClassData? classData,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
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

class _SpellClassAvailabilityDataImpl extends SpellClassAvailabilityData {
  _SpellClassAvailabilityDataImpl({
    int? id,
    required int spellId,
    _i2.SpellData? spell,
    required int classDataId,
    _i3.ClassData? classData,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          spellId: spellId,
          spell: spell,
          classDataId: classDataId,
          classData: classData,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SpellClassAvailabilityData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellClassAvailabilityData copyWith({
    Object? id = _Undefined,
    int? spellId,
    Object? spell = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return SpellClassAvailabilityData(
      id: id is int? ? id : this.id,
      spellId: spellId ?? this.spellId,
      spell: spell is _i2.SpellData? ? spell : this.spell?.copyWith(),
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i3.ClassData? ? classData : this.classData?.copyWith(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
