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
import '../data/general/class/subclass_data.dart' as _i4;
import '../data/general/class/class_feature_data.dart' as _i5;
import '../data/general/class/subclass_feature_data.dart' as _i6;

abstract class ClassSpellGrantData implements _i1.SerializableModel {
  ClassSpellGrantData._({
    this.id,
    this.spellId,
    this.spell,
    this.spellReferenceKey,
    this.sourceClassId,
    this.sourceClass,
    this.sourceSubclassId,
    this.sourceSubclass,
    this.sourceFeatureId,
    this.sourceFeature,
    this.sourceSubclassFeatureId,
    this.sourceSubclassFeature,
    this.grantedAtLevel,
    this.alwaysPrepared,
    this.notes,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassSpellGrantData({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceSubclassId,
    _i4.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i5.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    bool? alwaysPrepared,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassSpellGrantDataImpl;

  factory ClassSpellGrantData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassSpellGrantData(
      id: jsonSerialization['id'] as int?,
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i2.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      spellReferenceKey: jsonSerialization['spellReferenceKey'] as String?,
      sourceClassId: jsonSerialization['sourceClassId'] as int?,
      sourceClass: jsonSerialization['sourceClass'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['sourceClass'] as Map<String, dynamic>)),
      sourceSubclassId: jsonSerialization['sourceSubclassId'] as int?,
      sourceSubclass: jsonSerialization['sourceSubclass'] == null
          ? null
          : _i4.SubclassData.fromJson(
              (jsonSerialization['sourceSubclass'] as Map<String, dynamic>)),
      sourceFeatureId: jsonSerialization['sourceFeatureId'] as int?,
      sourceFeature: jsonSerialization['sourceFeature'] == null
          ? null
          : _i5.ClassFeatureData.fromJson(
              (jsonSerialization['sourceFeature'] as Map<String, dynamic>)),
      sourceSubclassFeatureId:
          jsonSerialization['sourceSubclassFeatureId'] as int?,
      sourceSubclassFeature: jsonSerialization['sourceSubclassFeature'] == null
          ? null
          : _i6.SubclassFeatureData.fromJson(
              (jsonSerialization['sourceSubclassFeature']
                  as Map<String, dynamic>)),
      grantedAtLevel: jsonSerialization['grantedAtLevel'] as int?,
      alwaysPrepared: jsonSerialization['alwaysPrepared'] as bool?,
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

  int? spellId;

  _i2.SpellData? spell;

  String? spellReferenceKey;

  int? sourceClassId;

  _i3.ClassData? sourceClass;

  int? sourceSubclassId;

  _i4.SubclassData? sourceSubclass;

  int? sourceFeatureId;

  _i5.ClassFeatureData? sourceFeature;

  int? sourceSubclassFeatureId;

  _i6.SubclassFeatureData? sourceSubclassFeature;

  int? grantedAtLevel;

  bool? alwaysPrepared;

  String? notes;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassSpellGrantData copyWith({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceSubclassId,
    _i4.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i5.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    bool? alwaysPrepared,
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
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (spellReferenceKey != null) 'spellReferenceKey': spellReferenceKey,
      if (sourceClassId != null) 'sourceClassId': sourceClassId,
      if (sourceClass != null) 'sourceClass': sourceClass?.toJson(),
      if (sourceSubclassId != null) 'sourceSubclassId': sourceSubclassId,
      if (sourceSubclass != null) 'sourceSubclass': sourceSubclass?.toJson(),
      if (sourceFeatureId != null) 'sourceFeatureId': sourceFeatureId,
      if (sourceFeature != null) 'sourceFeature': sourceFeature?.toJson(),
      if (sourceSubclassFeatureId != null)
        'sourceSubclassFeatureId': sourceSubclassFeatureId,
      if (sourceSubclassFeature != null)
        'sourceSubclassFeature': sourceSubclassFeature?.toJson(),
      if (grantedAtLevel != null) 'grantedAtLevel': grantedAtLevel,
      if (alwaysPrepared != null) 'alwaysPrepared': alwaysPrepared,
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

class _ClassSpellGrantDataImpl extends ClassSpellGrantData {
  _ClassSpellGrantDataImpl({
    int? id,
    int? spellId,
    _i2.SpellData? spell,
    String? spellReferenceKey,
    int? sourceClassId,
    _i3.ClassData? sourceClass,
    int? sourceSubclassId,
    _i4.SubclassData? sourceSubclass,
    int? sourceFeatureId,
    _i5.ClassFeatureData? sourceFeature,
    int? sourceSubclassFeatureId,
    _i6.SubclassFeatureData? sourceSubclassFeature,
    int? grantedAtLevel,
    bool? alwaysPrepared,
    String? notes,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          spellId: spellId,
          spell: spell,
          spellReferenceKey: spellReferenceKey,
          sourceClassId: sourceClassId,
          sourceClass: sourceClass,
          sourceSubclassId: sourceSubclassId,
          sourceSubclass: sourceSubclass,
          sourceFeatureId: sourceFeatureId,
          sourceFeature: sourceFeature,
          sourceSubclassFeatureId: sourceSubclassFeatureId,
          sourceSubclassFeature: sourceSubclassFeature,
          grantedAtLevel: grantedAtLevel,
          alwaysPrepared: alwaysPrepared,
          notes: notes,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassSpellGrantData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassSpellGrantData copyWith({
    Object? id = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? spellReferenceKey = _Undefined,
    Object? sourceClassId = _Undefined,
    Object? sourceClass = _Undefined,
    Object? sourceSubclassId = _Undefined,
    Object? sourceSubclass = _Undefined,
    Object? sourceFeatureId = _Undefined,
    Object? sourceFeature = _Undefined,
    Object? sourceSubclassFeatureId = _Undefined,
    Object? sourceSubclassFeature = _Undefined,
    Object? grantedAtLevel = _Undefined,
    Object? alwaysPrepared = _Undefined,
    Object? notes = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassSpellGrantData(
      id: id is int? ? id : this.id,
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _i2.SpellData? ? spell : this.spell?.copyWith(),
      spellReferenceKey: spellReferenceKey is String?
          ? spellReferenceKey
          : this.spellReferenceKey,
      sourceClassId: sourceClassId is int? ? sourceClassId : this.sourceClassId,
      sourceClass: sourceClass is _i3.ClassData?
          ? sourceClass
          : this.sourceClass?.copyWith(),
      sourceSubclassId:
          sourceSubclassId is int? ? sourceSubclassId : this.sourceSubclassId,
      sourceSubclass: sourceSubclass is _i4.SubclassData?
          ? sourceSubclass
          : this.sourceSubclass?.copyWith(),
      sourceFeatureId:
          sourceFeatureId is int? ? sourceFeatureId : this.sourceFeatureId,
      sourceFeature: sourceFeature is _i5.ClassFeatureData?
          ? sourceFeature
          : this.sourceFeature?.copyWith(),
      sourceSubclassFeatureId: sourceSubclassFeatureId is int?
          ? sourceSubclassFeatureId
          : this.sourceSubclassFeatureId,
      sourceSubclassFeature: sourceSubclassFeature is _i6.SubclassFeatureData?
          ? sourceSubclassFeature
          : this.sourceSubclassFeature?.copyWith(),
      grantedAtLevel:
          grantedAtLevel is int? ? grantedAtLevel : this.grantedAtLevel,
      alwaysPrepared:
          alwaysPrepared is bool? ? alwaysPrepared : this.alwaysPrepared,
      notes: notes is String? ? notes : this.notes,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
