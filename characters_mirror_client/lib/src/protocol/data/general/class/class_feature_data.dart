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
import '../../../enums/feature_tag.dart' as _i3;
import '../../../enums/language.dart' as _i4;
import '../../../enums/skill.dart' as _i5;
import '../../../enums/armor_category.dart' as _i6;
import '../../../enums/weapon_category.dart' as _i7;
import '../../../enums/unarmored_defense_rule.dart' as _i8;
import '../../../data/general/feature_resource_definition_data.dart' as _i9;
import '../../../data/general/feature_resource_effect_data.dart' as _i10;
import '../../../data/class_spell_grant_data.dart' as _i11;
import '../../../data/general/feature_modifier_data.dart' as _i12;

abstract class ClassFeatureData implements _i1.SerializableModel {
  ClassFeatureData._({
    this.id,
    required this.parentClassId,
    this.parentClass,
    this.name,
    this.referenceKey,
    this.description,
    this.shortDescription,
    required this.level,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.choiceGroupKey,
    this.grantedLanguages,
    this.grantedSkills,
    this.grantedExpertiseSkills,
    this.grantedArmorTraining,
    this.grantedWeaponTraining,
    this.grantedToolKeys,
    this.grantedExpertiseToolKeys,
    this.grantedSpellKeys,
    this.unarmoredDefenseRule,
    this.relatedTable,
    this.resources,
    this.resourceEffects,
    this.spellGrants,
    this.featureModifiers,
  });

  factory ClassFeatureData({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_i4.Language>? grantedLanguages,
    List<_i5.Skill>? grantedSkills,
    List<_i5.Skill>? grantedExpertiseSkills,
    List<_i6.ArmorCategory>? grantedArmorTraining,
    List<_i7.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    _i8.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_i9.FeatureResourceDefinitionData>? resources,
    List<_i10.FeatureResourceEffectData>? resourceEffects,
    List<_i11.ClassSpellGrantData>? spellGrants,
    List<_i12.FeatureModifierData>? featureModifiers,
  }) = _ClassFeatureDataImpl;

  factory ClassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _i2.ClassData.fromJson(
              (jsonSerialization['parentClass'] as Map<String, dynamic>)),
      name: jsonSerialization['name'] as String?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      level: jsonSerialization['level'] as int,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => _i3.FeatureTag.fromJson((e as String)))
          .toList(),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
      grantedLanguages: (jsonSerialization['grantedLanguages'] as List?)
          ?.map((e) => _i4.Language.fromJson((e as String)))
          .toList(),
      grantedSkills: (jsonSerialization['grantedSkills'] as List?)
          ?.map((e) => _i5.Skill.fromJson((e as String)))
          .toList(),
      grantedExpertiseSkills:
          (jsonSerialization['grantedExpertiseSkills'] as List?)
              ?.map((e) => _i5.Skill.fromJson((e as String)))
              .toList(),
      grantedArmorTraining: (jsonSerialization['grantedArmorTraining'] as List?)
          ?.map((e) => _i6.ArmorCategory.fromJson((e as String)))
          .toList(),
      grantedWeaponTraining:
          (jsonSerialization['grantedWeaponTraining'] as List?)
              ?.map((e) => _i7.WeaponCategory.fromJson((e as String)))
              .toList(),
      grantedToolKeys: (jsonSerialization['grantedToolKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedExpertiseToolKeys:
          (jsonSerialization['grantedExpertiseToolKeys'] as List?)
              ?.map((e) => e as String)
              .toList(),
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      unarmoredDefenseRule: jsonSerialization['unarmoredDefenseRule'] == null
          ? null
          : _i8.UnarmoredDefenseRule.fromJson(
              (jsonSerialization['unarmoredDefenseRule'] as String)),
      relatedTable: jsonSerialization['relatedTable'] as String?,
      resources: (jsonSerialization['resources'] as List?)
          ?.map((e) => _i9.FeatureResourceDefinitionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      resourceEffects: (jsonSerialization['resourceEffects'] as List?)
          ?.map((e) => _i10.FeatureResourceEffectData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      spellGrants: (jsonSerialization['spellGrants'] as List?)
          ?.map((e) =>
              _i11.ClassSpellGrantData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      featureModifiers: (jsonSerialization['featureModifiers'] as List?)
          ?.map((e) =>
              _i12.FeatureModifierData.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int parentClassId;

  _i2.ClassData? parentClass;

  String? name;

  String? referenceKey;

  String? description;

  String? shortDescription;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<_i3.FeatureTag>? tags;

  String? choiceGroupKey;

  List<_i4.Language>? grantedLanguages;

  List<_i5.Skill>? grantedSkills;

  List<_i5.Skill>? grantedExpertiseSkills;

  List<_i6.ArmorCategory>? grantedArmorTraining;

  List<_i7.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedExpertiseToolKeys;

  List<String>? grantedSpellKeys;

  _i8.UnarmoredDefenseRule? unarmoredDefenseRule;

  String? relatedTable;

  List<_i9.FeatureResourceDefinitionData>? resources;

  List<_i10.FeatureResourceEffectData>? resourceEffects;

  List<_i11.ClassSpellGrantData>? spellGrants;

  List<_i12.FeatureModifierData>? featureModifiers;

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassFeatureData copyWith({
    int? id,
    int? parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_i4.Language>? grantedLanguages,
    List<_i5.Skill>? grantedSkills,
    List<_i5.Skill>? grantedExpertiseSkills,
    List<_i6.ArmorCategory>? grantedArmorTraining,
    List<_i7.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    _i8.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_i9.FeatureResourceDefinitionData>? resources,
    List<_i10.FeatureResourceEffectData>? resourceEffects,
    List<_i11.ClassSpellGrantData>? spellGrants,
    List<_i12.FeatureModifierData>? featureModifiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJson(),
      if (name != null) 'name': name,
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      'level': level,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (tags != null) 'tags': tags?.toJson(valueToJson: (v) => v.toJson()),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
      if (grantedLanguages != null)
        'grantedLanguages':
            grantedLanguages?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedExpertiseSkills != null)
        'grantedExpertiseSkills':
            grantedExpertiseSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedArmorTraining != null)
        'grantedArmorTraining':
            grantedArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedWeaponTraining != null)
        'grantedWeaponTraining':
            grantedWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedToolKeys != null) 'grantedToolKeys': grantedToolKeys?.toJson(),
      if (grantedExpertiseToolKeys != null)
        'grantedExpertiseToolKeys': grantedExpertiseToolKeys?.toJson(),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (unarmoredDefenseRule != null)
        'unarmoredDefenseRule': unarmoredDefenseRule?.toJson(),
      if (relatedTable != null) 'relatedTable': relatedTable,
      if (resources != null)
        'resources': resources?.toJson(valueToJson: (v) => v.toJson()),
      if (resourceEffects != null)
        'resourceEffects':
            resourceEffects?.toJson(valueToJson: (v) => v.toJson()),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(valueToJson: (v) => v.toJson()),
      if (featureModifiers != null)
        'featureModifiers':
            featureModifiers?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassFeatureDataImpl extends ClassFeatureData {
  _ClassFeatureDataImpl({
    int? id,
    required int parentClassId,
    _i2.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_i3.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_i4.Language>? grantedLanguages,
    List<_i5.Skill>? grantedSkills,
    List<_i5.Skill>? grantedExpertiseSkills,
    List<_i6.ArmorCategory>? grantedArmorTraining,
    List<_i7.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    _i8.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_i9.FeatureResourceDefinitionData>? resources,
    List<_i10.FeatureResourceEffectData>? resourceEffects,
    List<_i11.ClassSpellGrantData>? spellGrants,
    List<_i12.FeatureModifierData>? featureModifiers,
  }) : super._(
          id: id,
          parentClassId: parentClassId,
          parentClass: parentClass,
          name: name,
          referenceKey: referenceKey,
          description: description,
          shortDescription: shortDescription,
          level: level,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
          tags: tags,
          choiceGroupKey: choiceGroupKey,
          grantedLanguages: grantedLanguages,
          grantedSkills: grantedSkills,
          grantedExpertiseSkills: grantedExpertiseSkills,
          grantedArmorTraining: grantedArmorTraining,
          grantedWeaponTraining: grantedWeaponTraining,
          grantedToolKeys: grantedToolKeys,
          grantedExpertiseToolKeys: grantedExpertiseToolKeys,
          grantedSpellKeys: grantedSpellKeys,
          unarmoredDefenseRule: unarmoredDefenseRule,
          relatedTable: relatedTable,
          resources: resources,
          resourceEffects: resourceEffects,
          spellGrants: spellGrants,
          featureModifiers: featureModifiers,
        );

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentClassId,
    Object? parentClass = _Undefined,
    Object? name = _Undefined,
    Object? referenceKey = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    int? level,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? tags = _Undefined,
    Object? choiceGroupKey = _Undefined,
    Object? grantedLanguages = _Undefined,
    Object? grantedSkills = _Undefined,
    Object? grantedExpertiseSkills = _Undefined,
    Object? grantedArmorTraining = _Undefined,
    Object? grantedWeaponTraining = _Undefined,
    Object? grantedToolKeys = _Undefined,
    Object? grantedExpertiseToolKeys = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? unarmoredDefenseRule = _Undefined,
    Object? relatedTable = _Undefined,
    Object? resources = _Undefined,
    Object? resourceEffects = _Undefined,
    Object? spellGrants = _Undefined,
    Object? featureModifiers = _Undefined,
  }) {
    return ClassFeatureData(
      id: id is int? ? id : this.id,
      parentClassId: parentClassId ?? this.parentClassId,
      parentClass: parentClass is _i2.ClassData?
          ? parentClass
          : this.parentClass?.copyWith(),
      name: name is String? ? name : this.name,
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      level: level ?? this.level,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      tags: tags is List<_i3.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      choiceGroupKey:
          choiceGroupKey is String? ? choiceGroupKey : this.choiceGroupKey,
      grantedLanguages: grantedLanguages is List<_i4.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
      grantedSkills: grantedSkills is List<_i5.Skill>?
          ? grantedSkills
          : this.grantedSkills?.map((e0) => e0).toList(),
      grantedExpertiseSkills: grantedExpertiseSkills is List<_i5.Skill>?
          ? grantedExpertiseSkills
          : this.grantedExpertiseSkills?.map((e0) => e0).toList(),
      grantedArmorTraining: grantedArmorTraining is List<_i6.ArmorCategory>?
          ? grantedArmorTraining
          : this.grantedArmorTraining?.map((e0) => e0).toList(),
      grantedWeaponTraining: grantedWeaponTraining is List<_i7.WeaponCategory>?
          ? grantedWeaponTraining
          : this.grantedWeaponTraining?.map((e0) => e0).toList(),
      grantedToolKeys: grantedToolKeys is List<String>?
          ? grantedToolKeys
          : this.grantedToolKeys?.map((e0) => e0).toList(),
      grantedExpertiseToolKeys: grantedExpertiseToolKeys is List<String>?
          ? grantedExpertiseToolKeys
          : this.grantedExpertiseToolKeys?.map((e0) => e0).toList(),
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      unarmoredDefenseRule: unarmoredDefenseRule is _i8.UnarmoredDefenseRule?
          ? unarmoredDefenseRule
          : this.unarmoredDefenseRule,
      relatedTable: relatedTable is String? ? relatedTable : this.relatedTable,
      resources: resources is List<_i9.FeatureResourceDefinitionData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
      resourceEffects: resourceEffects is List<_i10.FeatureResourceEffectData>?
          ? resourceEffects
          : this.resourceEffects?.map((e0) => e0.copyWith()).toList(),
      spellGrants: spellGrants is List<_i11.ClassSpellGrantData>?
          ? spellGrants
          : this.spellGrants?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_i12.FeatureModifierData>?
          ? featureModifiers
          : this.featureModifiers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
