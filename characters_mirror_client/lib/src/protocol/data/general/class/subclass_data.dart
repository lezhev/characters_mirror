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
import '../../../data/general/spell_selection_filter_data.dart' as _i2;
import '../../../data/general/class/class_data.dart' as _i3;
import '../../../enums/spellcasting_progression.dart' as _i4;
import '../../../enums/class_spell_selection_mode.dart' as _i5;
import '../../../enums/ability.dart' as _i6;

abstract class SubclassData implements _i1.SerializableModel {
  SubclassData._({
    this.id,
    this.spellSelectionFilter,
    this.referenceKey,
    this.name,
    this.description,
    this.shortDescription,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.subclassName,
    required this.parentClassId,
    this.parentClass,
    this.levelRequired,
    this.spellcastingStartLevel,
    this.spellcastingProgression,
    this.spellSelectionMode,
    this.spellcastingAbilityValue,
  });

  factory SubclassData({
    int? id,
    _i2.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subclassName,
    required int parentClassId,
    _i3.ClassData? parentClass,
    int? levelRequired,
    int? spellcastingStartLevel,
    _i4.SpellcastingProgression? spellcastingProgression,
    _i5.ClassSpellSelectionMode? spellSelectionMode,
    _i6.Ability? spellcastingAbilityValue,
  }) = _SubclassDataImpl;

  factory SubclassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassData(
      id: jsonSerialization['id'] as int?,
      spellSelectionFilter: jsonSerialization['spellSelectionFilter'] == null
          ? null
          : _i2.SpellSelectionFilterData.fromJson(
              (jsonSerialization['spellSelectionFilter']
                  as Map<String, dynamic>)),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      subclassName: jsonSerialization['subclassName'] as String?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i3.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      levelRequired: jsonSerialization['levelRequired'] as int?,
      spellcastingStartLevel:
          jsonSerialization['spellcastingStartLevel'] as int?,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] == null
              ? null
              : _i4.SpellcastingProgression.fromJson(
                  (jsonSerialization['spellcastingProgression'] as String)),
      spellSelectionMode: jsonSerialization['spellSelectionMode'] == null
          ? null
          : _i5.ClassSpellSelectionMode.fromJson(
              (jsonSerialization['spellSelectionMode'] as String)),
      spellcastingAbilityValue:
          jsonSerialization['spellcastingAbilityValue'] == null
              ? null
              : _i6.Ability.fromJson(
                  (jsonSerialization['spellcastingAbilityValue'] as String)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i2.SpellSelectionFilterData? spellSelectionFilter;

  String? referenceKey;

  String? name;

  String? description;

  String? shortDescription;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  String? subclassName;

  int parentClassId;

  _i3.ClassData? parentClass;

  int? levelRequired;

  int? spellcastingStartLevel;

  _i4.SpellcastingProgression? spellcastingProgression;

  _i5.ClassSpellSelectionMode? spellSelectionMode;

  _i6.Ability? spellcastingAbilityValue;

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubclassData copyWith({
    int? id,
    _i2.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subclassName,
    int? parentClassId,
    _i3.ClassData? parentClass,
    int? levelRequired,
    int? spellcastingStartLevel,
    _i4.SpellcastingProgression? spellcastingProgression,
    _i5.ClassSpellSelectionMode? spellSelectionMode,
    _i6.Ability? spellcastingAbilityValue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (subclassName != null) 'subclassName': subclassName,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (levelRequired != null) 'levelRequired': levelRequired,
      if (spellcastingStartLevel != null)
        'spellcastingStartLevel': spellcastingStartLevel,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassDataImpl extends SubclassData {
  _SubclassDataImpl({
    int? id,
    _i2.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? shortDescription,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? subclassName,
    required int parentClassId,
    _i3.ClassData? parentClass,
    int? levelRequired,
    int? spellcastingStartLevel,
    _i4.SpellcastingProgression? spellcastingProgression,
    _i5.ClassSpellSelectionMode? spellSelectionMode,
    _i6.Ability? spellcastingAbilityValue,
  }) : super._(
          id: id,
          spellSelectionFilter: spellSelectionFilter,
          referenceKey: referenceKey,
          name: name,
          description: description,
          shortDescription: shortDescription,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          subclassName: subclassName,
          parentClassId: parentClassId,
          parentClass: parentClass,
          levelRequired: levelRequired,
          spellcastingStartLevel: spellcastingStartLevel,
          spellcastingProgression: spellcastingProgression,
          spellSelectionMode: spellSelectionMode,
          spellcastingAbilityValue: spellcastingAbilityValue,
        );

  /// Returns a shallow copy of this [SubclassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubclassData copyWith({
    Object? id = _Undefined,
    Object? spellSelectionFilter = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? subclassName = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? levelRequired = _Undefined,
    Object? spellcastingStartLevel = _Undefined,
    Object? spellcastingProgression = _Undefined,
    Object? spellSelectionMode = _Undefined,
    Object? spellcastingAbilityValue = _Undefined,
  }) {
    return SubclassData(
      id: id is int? ? id : this.id,
      spellSelectionFilter:
          spellSelectionFilter is _i2.SpellSelectionFilterData?
              ? spellSelectionFilter
              : this.spellSelectionFilter?.copyWith(),
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      subclassName: subclassName is String? ? subclassName : this.subclassName,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i3.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      levelRequired: levelRequired is int? ? levelRequired : this.levelRequired,
      spellcastingStartLevel: spellcastingStartLevel is int?
          ? spellcastingStartLevel
          : this.spellcastingStartLevel,
      spellcastingProgression:
          spellcastingProgression is _i4.SpellcastingProgression?
              ? spellcastingProgression
              : this.spellcastingProgression,
      spellSelectionMode: spellSelectionMode is _i5.ClassSpellSelectionMode?
          ? spellSelectionMode
          : this.spellSelectionMode,
      spellcastingAbilityValue: spellcastingAbilityValue is _i6.Ability?
          ? spellcastingAbilityValue
          : this.spellcastingAbilityValue,
    );
  }
}
