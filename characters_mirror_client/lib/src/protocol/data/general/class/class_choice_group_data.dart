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
import '../../../data/general/class/subclass_data.dart' as _i3;
import '../../../data/general/class/class_feature_data.dart' as _i4;
import '../../../data/general/race/race_data.dart' as _i5;
import '../../../data/general/race/subrace_data.dart' as _i6;
import '../../../data/background_data.dart' as _i7;
import '../../../enums/class_choice_type.dart' as _i8;

abstract class ClassChoiceGroupData implements _i1.SerializableModel {
  ClassChoiceGroupData._({
    this.id,
    this.name,
    this.description,
    this.sourceClassId,
    this.sourceClass,
    this.sourceSubclassId,
    this.sourceSubclass,
    this.sourceFeatureId,
    this.sourceFeature,
    this.sourceRaceId,
    this.sourceRace,
    this.sourceSubraceId,
    this.sourceSubrace,
    this.sourceBackgroundId,
    this.sourceBackground,
    this.level,
    this.type,
    this.selectionCount,
    this.appliesAtCharacterLevel,
    this.exclusiveKey,
    this.allowDuplicates,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassChoiceGroupData({
    int? id,
    String? name,
    String? description,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceSubclassId,
    _i3.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i4.ClassFeatureData? sourceFeature,
    int? sourceRaceId,
    _i5.RaceData? sourceRace,
    int? sourceSubraceId,
    _i6.SubraceData? sourceSubrace,
    int? sourceBackgroundId,
    _i7.BackgroundData? sourceBackground,
    int? level,
    _i8.ClassChoiceType? type,
    int? selectionCount,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassChoiceGroupDataImpl;

  factory ClassChoiceGroupData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassChoiceGroupData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _i3.SubclassData.fromJson(
              (jsonSerialization['sourceSubclass'] as Map<String, dynamic>)),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _i4.ClassFeatureData.fromJson(
              (jsonSerialization['sourceFeature'] as Map<String, dynamic>)),
      sourceRaceId: jsonSerialization['sourceRaceId'] as int?,
      sourceRace: jsonSerialization['sourceRace'] == null
          ? null
          : _i5.RaceData.fromJson(
              (jsonSerialization['sourceRace'] as Map<String, dynamic>)),
      sourceSubraceId: jsonSerialization['sourceSubraceId'] as int?,
      sourceSubrace: jsonSerialization['sourceSubrace'] == null
          ? null
          : _i6.SubraceData.fromJson(
              (jsonSerialization['sourceSubrace'] as Map<String, dynamic>)),
      sourceBackgroundId: jsonSerialization['sourceBackgroundId'] as int?,
      sourceBackground: jsonSerialization['sourceBackground'] == null
          ? null
          : _i7.BackgroundData.fromJson(
              (jsonSerialization['sourceBackground'] as Map<String, dynamic>)),
      level: jsonSerialization['level'] as int?,
      type: jsonSerialization['type'] == null
          ? null
          : _i8.ClassChoiceType.fromJson((jsonSerialization['type'] as String)),
      selectionCount: jsonSerialization['selectionCount'] as int?,
      appliesAtCharacterLevel:
          jsonSerialization['appliesAtCharacterLevel'] as bool?,
      exclusiveKey: jsonSerialization['exclusiveKey'] as String?,
      allowDuplicates: jsonSerialization['allowDuplicates'] as bool?,
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

  String? name;

  String? description;

  int? sourceClassId;

  _i2.ClassData? sourceClass;

  int? sourceSubclassId;

  _i3.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _i4.ClassFeatureData? sourceFeature;

  int? sourceRaceId;

  _i5.RaceData? sourceRace;

  int? sourceSubraceId;

  _i6.SubraceData? sourceSubrace;

  int? sourceBackgroundId;

  _i7.BackgroundData? sourceBackground;

  int? level;

  _i8.ClassChoiceType? type;

  int? selectionCount;

  bool? appliesAtCharacterLevel;

  String? exclusiveKey;

  bool? allowDuplicates;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ClassChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassChoiceGroupData copyWith({
    int? id,
    String? name,
    String? description,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceSubclassId,
    _i3.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i4.ClassFeatureData? sourceFeature,
    int? sourceRaceId,
    _i5.RaceData? sourceRace,
    int? sourceSubraceId,
    _i6.SubraceData? sourceSubrace,
    int? sourceBackgroundId,
    _i7.BackgroundData? sourceBackground,
    int? level,
    _i8.ClassChoiceType? type,
    int? selectionCount,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null) 'sourceSubclass': sourceSubclass?.toJson(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null) 'sourceFeature': sourceFeature?.toJson(),
      if (sourceRaceId != null) 'sourceRaceId': sourceRaceId,
      if (sourceRace != null) 'sourceRace': sourceRace?.toJson(),
      if (sourceSubraceId != null) 'sourceSubraceId': sourceSubraceId,
      if (sourceSubrace != null) 'sourceSubrace': sourceSubrace?.toJson(),
      if (sourceBackgroundId != null) 'sourceBackgroundId': sourceBackgroundId,
      if (sourceBackground != null)
        'sourceBackground': sourceBackground?.toJson(),
      if (level != null) 'level': level,
      if (type != null) 'type': type?.toJson(),
      if (selectionCount != null) 'selectionCount': selectionCount,
      if (appliesAtCharacterLevel != null)
        'appliesAtCharacterLevel': appliesAtCharacterLevel,
      if (exclusiveKey != null) 'exclusiveKey': exclusiveKey,
      if (allowDuplicates != null) 'allowDuplicates': allowDuplicates,
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

class _ClassChoiceGroupDataImpl extends ClassChoiceGroupData {
  _ClassChoiceGroupDataImpl({
    int? id,
    String? name,
    String? description,
    int? sourceClassId,
    _i2.ClassData? sourceClass,
    int? sourceSubclassId,
    _i3.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i4.ClassFeatureData? sourceFeature,
    int? sourceRaceId,
    _i5.RaceData? sourceRace,
    int? sourceSubraceId,
    _i6.SubraceData? sourceSubrace,
    int? sourceBackgroundId,
    _i7.BackgroundData? sourceBackground,
    int? level,
    _i8.ClassChoiceType? type,
    int? selectionCount,
    bool? appliesAtCharacterLevel,
    String? exclusiveKey,
    bool? allowDuplicates,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          name: name,
          description: description,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceSubclassId: sourceSubclassId,
          sourceSubclass: sourceSubclass,
          sourceFeatureId: sourceFeatureId,
          sourceFeature: sourceFeature,
          sourceRaceId: sourceRaceId,
          sourceRace: sourceRace,
          sourceSubraceId: sourceSubraceId,
          sourceSubrace: sourceSubrace,
          sourceBackgroundId: sourceBackgroundId,
          sourceBackground: sourceBackground,
          level: level,
          type: type,
          selectionCount: selectionCount,
          appliesAtCharacterLevel: appliesAtCharacterLevel,
          exclusiveKey: exclusiveKey,
          allowDuplicates: allowDuplicates,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassChoiceGroupData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassChoiceGroupData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceSubclassId = _Undefined,
    Object? sourceSubclass = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? sourceFeature = _Undefined,
    Object? sourceRaceId = _Undefined,
    Object? sourceRace = _Undefined,
    Object? sourceSubraceId = _Undefined,
    Object? sourceSubrace = _Undefined,
    Object? sourceBackgroundId = _Undefined,
    Object? sourceBackground = _Undefined,
    Object? level = _Undefined,
    Object? type = _Undefined,
    Object? selectionCount = _Undefined,
    Object? appliesAtCharacterLevel = _Undefined,
    Object? exclusiveKey = _Undefined,
    Object? allowDuplicates = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassChoiceGroupData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i2.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId:
          sourceSubclassId is int? ? sourceSubclassId : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _i3.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId:
          sourceFeatureId is int? ? sourceFeatureId : this.sourceFeatureId,
      sourceFeature: sourceFeature is _i4.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceRaceId: sourceRaceId is int? ? sourceRaceId : this.sourceRaceId,
      sourceRace: sourceRace is _i5.RaceData?
          ? sourceRace
          : this.sourceRace?.copyWith(),
      sourceSubraceId:
          sourceSubraceId is int? ? sourceSubraceId : this.sourceSubraceId,
      sourceSubrace: sourceSubrace is _i6.SubraceData?
          ? sourceSubrace
          : this.sourceSubrace?.copyWith(),
      sourceBackgroundId: sourceBackgroundId is int?
          ? sourceBackgroundId
          : this.sourceBackgroundId,
      sourceBackground: sourceBackground is _i7.BackgroundData?
          ? sourceBackground
          : this.sourceBackground?.copyWith(),
      level: level is int? ? level : this.level,
      type: type is _i8.ClassChoiceType? ? type : this.type,
      selectionCount:
          selectionCount is int? ? selectionCount : this.selectionCount,
      appliesAtCharacterLevel: appliesAtCharacterLevel is bool?
          ? appliesAtCharacterLevel
          : this.appliesAtCharacterLevel,
      exclusiveKey: exclusiveKey is String? ? exclusiveKey : this.exclusiveKey,
      allowDuplicates:
          allowDuplicates is bool? ? allowDuplicates : this.allowDuplicates,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
