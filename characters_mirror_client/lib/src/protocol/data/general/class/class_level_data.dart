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
import '../../../data/general/class/class_data.dart' as _i2;

abstract class ClassLevelData implements _i1.SerializableModel {
  ClassLevelData._({
    this.id,
    required this.classDataId,
    this.classData,
    required this.level,
    this.featureIds,
    this.subclassFeatureIds,
    this.knownCantrips,
    this.knownSpells,
    this.preparedSpellFormula,
    this.resourceSummary,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassLevelData({
    int? id,
    required int classDataId,
    _i2.ClassData? classData,
    required int level,
    List<int>? featureIds,
    List<int>? subclassFeatureIds,
    int? knownCantrips,
    int? knownSpells,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassLevelDataImpl;

  factory ClassLevelData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassLevelData(
      id: jsonSerialization['id'] as int?,
      classDataId: jsonSerialization['classDataId'] as int,
      classData: jsonSerialization['classData'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['classData'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int,
      featureIds: (jsonSerialization['featureIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      subclassFeatureIds: (jsonSerialization['subclassFeatureIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      knownCantrips: jsonSerialization['knownCantrips'] as int?,
      knownSpells: jsonSerialization['knownSpells'] as int?,
      preparedSpellFormula:
          jsonSerialization['preparedSpellFormula'] as String?,
      resourceSummary: jsonSerialization['resourceSummary'] as String?,
      notes: jsonSerialization['notes'] as String?,
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

  int classDataId;

  _i2.ClassData? classData;

  int level;

  List<int>? featureIds;

  List<int>? subclassFeatureIds;

  int? knownCantrips;

  int? knownSpells;

  String? preparedSpellFormula;

  String? resourceSummary;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ClassLevelData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassLevelData copyWith({
    int? id,
    int? classDataId,
    _i2.ClassData? classData,
    int? level,
    List<int>? featureIds,
    List<int>? subclassFeatureIds,
    int? knownCantrips,
    int? knownSpells,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'classDataId': classDataId,
      if (classData != null) 'classData': classData?.toJson(),
      'level': level,
      if (featureIds != null) 'featureIds': featureIds?.toJson(),
      if (subclassFeatureIds != null)
        'subclassFeatureIds': subclassFeatureIds?.toJson(),
      if (knownCantrips != null) 'knownCantrips': knownCantrips,
      if (knownSpells != null) 'knownSpells': knownSpells,
      if (preparedSpellFormula != null)
        'preparedSpellFormula': preparedSpellFormula,
      if (resourceSummary != null) 'resourceSummary': resourceSummary,
      if (notes != null) 'notes': notes,
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

class _ClassLevelDataImpl extends ClassLevelData {
  _ClassLevelDataImpl({
    int? id,
    required int classDataId,
    _i2.ClassData? classData,
    required int level,
    List<int>? featureIds,
    List<int>? subclassFeatureIds,
    int? knownCantrips,
    int? knownSpells,
    String? preparedSpellFormula,
    String? resourceSummary,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          classDataId: classDataId,
          classData: classData,
          level: level,
          featureIds: featureIds,
          subclassFeatureIds: subclassFeatureIds,
          knownCantrips: knownCantrips,
          knownSpells: knownSpells,
          preparedSpellFormula: preparedSpellFormula,
          resourceSummary: resourceSummary,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassLevelData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassLevelData copyWith({
    Object? id = _Undefined,
    int? classDataId,
    Object? classData = _Undefined,
    int? level,
    Object? featureIds = _Undefined,
    Object? subclassFeatureIds = _Undefined,
    Object? knownCantrips = _Undefined,
    Object? knownSpells = _Undefined,
    Object? preparedSpellFormula = _Undefined,
    Object? resourceSummary = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassLevelData(
      id: id is int? ? id : this.id,
      classDataId: classDataId ?? this.classDataId,
      classData:
          classData is _i2.ClassData? ? classData : this.classData?.copyWith(),
      level: level ?? this.level,
      featureIds: featureIds is List<int>?
          ? featureIds
          : this.featureIds?.map((e0) => e0).toList(),
      subclassFeatureIds: subclassFeatureIds is List<int>?
          ? subclassFeatureIds
          : this.subclassFeatureIds?.map((e0) => e0).toList(),
      knownCantrips: knownCantrips is int? ? knownCantrips : this.knownCantrips,
      knownSpells: knownSpells is int? ? knownSpells : this.knownSpells,
      preparedSpellFormula: preparedSpellFormula is String?
          ? preparedSpellFormula
          : this.preparedSpellFormula,
      resourceSummary:
          resourceSummary is String? ? resourceSummary : this.resourceSummary,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
