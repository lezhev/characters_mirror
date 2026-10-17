/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/class_spell_grant_data.dart' as _ira2m5oj;
import '../../../data/general/class/class_data.dart' as _i7s9vfyh;
import '../../../data/general/feature_modifier_data.dart' as _ilc9jnh2;
import '../../../data/general/feature_resource_definition_data.dart'
    as _iib0ncbr;
import '../../../data/general/feature_resource_effect_data.dart' as _ipujnj10;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/feature_tag.dart' as _ixkx8coo;
import '../../../enums/language.dart' as _iiw0j43j;
import '../../../enums/skill.dart' as _iqrhamom;
import '../../../enums/unarmored_defense_rule.dart' as _inypkr0b;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class ClassFeatureData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    _i7s9vfyh.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ixkx8coo.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_iiw0j43j.Language>? grantedLanguages,
    List<_iqrhamom.Skill>? grantedSkills,
    List<_iqrhamom.Skill>? grantedExpertiseSkills,
    List<_irzuusaf.ArmorCategory>? grantedArmorTraining,
    List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    _inypkr0b.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ira2m5oj.ClassSpellGrantData>? spellGrants,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
  }) = _ClassFeatureDataImpl;

  factory ClassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentClassId: jsonSerialization['parentClassId'] as int,
      parentClass: jsonSerialization['parentClass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i7s9vfyh.ClassData>(
              jsonSerialization['parentClass'],
            ),
      name: jsonSerialization['name'] as String?,
      referenceKey: jsonSerialization['referenceKey'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      level: jsonSerialization['level'] as int,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      tags: jsonSerialization['tags'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ixkx8coo.FeatureTag>>(
              jsonSerialization['tags'],
            ),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
      grantedLanguages: jsonSerialization['grantedLanguages'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['grantedLanguages'],
            ),
      grantedSkills: jsonSerialization['grantedSkills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['grantedSkills'],
            ),
      grantedExpertiseSkills:
          jsonSerialization['grantedExpertiseSkills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['grantedExpertiseSkills'],
            ),
      grantedArmorTraining: jsonSerialization['grantedArmorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['grantedArmorTraining'],
            ),
      grantedWeaponTraining: jsonSerialization['grantedWeaponTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['grantedWeaponTraining'],
            ),
      grantedToolKeys: jsonSerialization['grantedToolKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedToolKeys'],
            ),
      grantedExpertiseToolKeys:
          jsonSerialization['grantedExpertiseToolKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedExpertiseToolKeys'],
            ),
      grantedSpellKeys: jsonSerialization['grantedSpellKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedSpellKeys'],
            ),
      unarmoredDefenseRule: jsonSerialization['unarmoredDefenseRule'] == null
          ? null
          : _inypkr0b.UnarmoredDefenseRule.fromJson(
              (jsonSerialization['unarmoredDefenseRule'] as String),
            ),
      relatedTable: jsonSerialization['relatedTable'] as String?,
      resources: jsonSerialization['resources'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iib0ncbr.FeatureResourceDefinitionData>>(
                  jsonSerialization['resources'],
                ),
      resourceEffects: jsonSerialization['resourceEffects'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ipujnj10.FeatureResourceEffectData>>(
                  jsonSerialization['resourceEffects'],
                ),
      spellGrants: jsonSerialization['spellGrants'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ira2m5oj.ClassSpellGrantData>>(
                  jsonSerialization['spellGrants'],
                ),
      featureModifiers: jsonSerialization['featureModifiers'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ilc9jnh2.FeatureModifierData>>(
                  jsonSerialization['featureModifiers'],
                ),
    );
  }

  static final t = ClassFeatureDataTable();

  static const db = ClassFeatureDataRepository._();

  @override
  int? id;

  int parentClassId;

  _i7s9vfyh.ClassData? parentClass;

  String? name;

  String? referenceKey;

  String? description;

  String? shortDescription;

  int level;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  List<_ixkx8coo.FeatureTag>? tags;

  String? choiceGroupKey;

  List<_iiw0j43j.Language>? grantedLanguages;

  List<_iqrhamom.Skill>? grantedSkills;

  List<_iqrhamom.Skill>? grantedExpertiseSkills;

  List<_irzuusaf.ArmorCategory>? grantedArmorTraining;

  List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedExpertiseToolKeys;

  List<String>? grantedSpellKeys;

  _inypkr0b.UnarmoredDefenseRule? unarmoredDefenseRule;

  String? relatedTable;

  List<_iib0ncbr.FeatureResourceDefinitionData>? resources;

  List<_ipujnj10.FeatureResourceEffectData>? resourceEffects;

  List<_ira2m5oj.ClassSpellGrantData>? spellGrants;

  List<_ilc9jnh2.FeatureModifierData>? featureModifiers;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ClassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ClassFeatureData copyWith({
    int? id,
    int? parentClassId,
    _i7s9vfyh.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    int? level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ixkx8coo.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_iiw0j43j.Language>? grantedLanguages,
    List<_iqrhamom.Skill>? grantedSkills,
    List<_iqrhamom.Skill>? grantedExpertiseSkills,
    List<_irzuusaf.ArmorCategory>? grantedArmorTraining,
    List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    _inypkr0b.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ira2m5oj.ClassSpellGrantData>? spellGrants,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassFeatureData',
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
        'grantedLanguages': grantedLanguages?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedExpertiseSkills != null)
        'grantedExpertiseSkills': grantedExpertiseSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedArmorTraining != null)
        'grantedArmorTraining': grantedArmorTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedWeaponTraining != null)
        'grantedWeaponTraining': grantedWeaponTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
        'resourceEffects': resourceEffects?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(valueToJson: (v) => v.toJson()),
      if (featureModifiers != null)
        'featureModifiers': featureModifiers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassFeatureData',
      if (id != null) 'id': id,
      'parentClassId': parentClassId,
      if (parentClass != null) 'parentClass': parentClass?.toJsonForProtocol(),
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
        'grantedLanguages': grantedLanguages?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedExpertiseSkills != null)
        'grantedExpertiseSkills': grantedExpertiseSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedArmorTraining != null)
        'grantedArmorTraining': grantedArmorTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedWeaponTraining != null)
        'grantedWeaponTraining': grantedWeaponTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedToolKeys != null) 'grantedToolKeys': grantedToolKeys?.toJson(),
      if (grantedExpertiseToolKeys != null)
        'grantedExpertiseToolKeys': grantedExpertiseToolKeys?.toJson(),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (unarmoredDefenseRule != null)
        'unarmoredDefenseRule': unarmoredDefenseRule?.toJson(),
      if (relatedTable != null) 'relatedTable': relatedTable,
      if (resources != null)
        'resources': resources?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (resourceEffects != null)
        'resourceEffects': resourceEffects?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (spellGrants != null)
        'spellGrants': spellGrants?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (featureModifiers != null)
        'featureModifiers': featureModifiers?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  static ClassFeatureDataInclude include({
    _i7s9vfyh.ClassDataInclude? parentClass,
    _iib0ncbr.FeatureResourceDefinitionDataIncludeList? resources,
    _ipujnj10.FeatureResourceEffectDataIncludeList? resourceEffects,
    _ira2m5oj.ClassSpellGrantDataIncludeList? spellGrants,
    _ilc9jnh2.FeatureModifierDataIncludeList? featureModifiers,
  }) {
    return ClassFeatureDataInclude._(
      parentClass: parentClass,
      resources: resources,
      resourceEffects: resourceEffects,
      spellGrants: spellGrants,
      featureModifiers: featureModifiers,
    );
  }

  static ClassFeatureDataIncludeList includeList({
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    ClassFeatureDataInclude? include,
  }) {
    return ClassFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassFeatureDataImpl extends ClassFeatureData {
  _ClassFeatureDataImpl({
    int? id,
    required int parentClassId,
    _i7s9vfyh.ClassData? parentClass,
    String? name,
    String? referenceKey,
    String? description,
    String? shortDescription,
    required int level,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<_ixkx8coo.FeatureTag>? tags,
    String? choiceGroupKey,
    List<_iiw0j43j.Language>? grantedLanguages,
    List<_iqrhamom.Skill>? grantedSkills,
    List<_iqrhamom.Skill>? grantedExpertiseSkills,
    List<_irzuusaf.ArmorCategory>? grantedArmorTraining,
    List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    _inypkr0b.UnarmoredDefenseRule? unarmoredDefenseRule,
    String? relatedTable,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ira2m5oj.ClassSpellGrantData>? spellGrants,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
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
  @_is.useResult
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
      parentClass: parentClass is _i7s9vfyh.ClassData?
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
      tags: tags is List<_ixkx8coo.FeatureTag>?
          ? tags
          : this.tags?.map((e0) => e0).toList(),
      choiceGroupKey: choiceGroupKey is String?
          ? choiceGroupKey
          : this.choiceGroupKey,
      grantedLanguages: grantedLanguages is List<_iiw0j43j.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
      grantedSkills: grantedSkills is List<_iqrhamom.Skill>?
          ? grantedSkills
          : this.grantedSkills?.map((e0) => e0).toList(),
      grantedExpertiseSkills: grantedExpertiseSkills is List<_iqrhamom.Skill>?
          ? grantedExpertiseSkills
          : this.grantedExpertiseSkills?.map((e0) => e0).toList(),
      grantedArmorTraining:
          grantedArmorTraining is List<_irzuusaf.ArmorCategory>?
          ? grantedArmorTraining
          : this.grantedArmorTraining?.map((e0) => e0).toList(),
      grantedWeaponTraining:
          grantedWeaponTraining is List<_ibtz7e0l.WeaponCategory>?
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
      unarmoredDefenseRule:
          unarmoredDefenseRule is _inypkr0b.UnarmoredDefenseRule?
          ? unarmoredDefenseRule
          : this.unarmoredDefenseRule,
      relatedTable: relatedTable is String? ? relatedTable : this.relatedTable,
      resources: resources is List<_iib0ncbr.FeatureResourceDefinitionData>?
          ? resources
          : this.resources?.map((e0) => e0.copyWith()).toList(),
      resourceEffects:
          resourceEffects is List<_ipujnj10.FeatureResourceEffectData>?
          ? resourceEffects
          : this.resourceEffects?.map((e0) => e0.copyWith()).toList(),
      spellGrants: spellGrants is List<_ira2m5oj.ClassSpellGrantData>?
          ? spellGrants
          : this.spellGrants?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_ilc9jnh2.FeatureModifierData>?
          ? featureModifiers
          : this.featureModifiers?.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class ClassFeatureDataUpdateTable
    extends _is.UpdateTable<ClassFeatureDataTable> {
  ClassFeatureDataUpdateTable(super.table);

  _is.ColumnValue<int, int> parentClassId(int value) =>
      _is.ColumnValue(table.parentClassId, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> referenceKey(String? value) =>
      _is.ColumnValue(table.referenceKey, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> shortDescription(String? value) =>
      _is.ColumnValue(table.shortDescription, value);

  _is.ColumnValue<int, int> level(int value) =>
      _is.ColumnValue(table.level, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<List<_ixkx8coo.FeatureTag>, List<_ixkx8coo.FeatureTag>> tags(
    List<_ixkx8coo.FeatureTag>? value,
  ) => _is.ColumnValue(table.tags, value);

  _is.ColumnValue<String, String> choiceGroupKey(String? value) =>
      _is.ColumnValue(table.choiceGroupKey, value);

  _is.ColumnValue<List<_iiw0j43j.Language>, List<_iiw0j43j.Language>>
  grantedLanguages(List<_iiw0j43j.Language>? value) =>
      _is.ColumnValue(table.grantedLanguages, value);

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>> grantedSkills(
    List<_iqrhamom.Skill>? value,
  ) => _is.ColumnValue(table.grantedSkills, value);

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>>
  grantedExpertiseSkills(List<_iqrhamom.Skill>? value) =>
      _is.ColumnValue(table.grantedExpertiseSkills, value);

  _is.ColumnValue<List<_irzuusaf.ArmorCategory>, List<_irzuusaf.ArmorCategory>>
  grantedArmorTraining(List<_irzuusaf.ArmorCategory>? value) =>
      _is.ColumnValue(table.grantedArmorTraining, value);

  _is.ColumnValue<
    List<_ibtz7e0l.WeaponCategory>,
    List<_ibtz7e0l.WeaponCategory>
  >
  grantedWeaponTraining(List<_ibtz7e0l.WeaponCategory>? value) =>
      _is.ColumnValue(table.grantedWeaponTraining, value);

  _is.ColumnValue<List<String>, List<String>> grantedToolKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.grantedToolKeys, value);

  _is.ColumnValue<List<String>, List<String>> grantedExpertiseToolKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.grantedExpertiseToolKeys, value);

  _is.ColumnValue<List<String>, List<String>> grantedSpellKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.grantedSpellKeys, value);

  _is.ColumnValue<
    _inypkr0b.UnarmoredDefenseRule,
    _inypkr0b.UnarmoredDefenseRule
  >
  unarmoredDefenseRule(_inypkr0b.UnarmoredDefenseRule? value) =>
      _is.ColumnValue(table.unarmoredDefenseRule, value);

  _is.ColumnValue<String, String> relatedTable(String? value) =>
      _is.ColumnValue(table.relatedTable, value);
}

class ClassFeatureDataTable extends _is.Table<int?> {
  ClassFeatureDataTable({super.tableRelation})
    : super(tableName: 'class_feature_data') {
    updateTable = ClassFeatureDataUpdateTable(this);
    parentClassId = _is.ColumnInt('parentClassId', this);
    name = _is.ColumnString('name', this);
    referenceKey = _is.ColumnString('referenceKey', this);
    description = _is.ColumnString('description', this);
    shortDescription = _is.ColumnString('shortDescription', this);
    level = _is.ColumnInt('level', this);
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    tags = _is.ColumnSerializable<List<_ixkx8coo.FeatureTag>>('tags', this);
    choiceGroupKey = _is.ColumnString('choiceGroupKey', this);
    grantedLanguages = _is.ColumnSerializable<List<_iiw0j43j.Language>>(
      'grantedLanguages',
      this,
    );
    grantedSkills = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'grantedSkills',
      this,
    );
    grantedExpertiseSkills = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'grantedExpertiseSkills',
      this,
    );
    grantedArmorTraining =
        _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>(
          'grantedArmorTraining',
          this,
        );
    grantedWeaponTraining =
        _is.ColumnSerializable<List<_ibtz7e0l.WeaponCategory>>(
          'grantedWeaponTraining',
          this,
        );
    grantedToolKeys = _is.ColumnSerializable<List<String>>(
      'grantedToolKeys',
      this,
    );
    grantedExpertiseToolKeys = _is.ColumnSerializable<List<String>>(
      'grantedExpertiseToolKeys',
      this,
    );
    grantedSpellKeys = _is.ColumnSerializable<List<String>>(
      'grantedSpellKeys',
      this,
    );
    unarmoredDefenseRule = _is.ColumnEnum(
      'unarmoredDefenseRule',
      this,
      _is.EnumSerialization.byName,
    );
    relatedTable = _is.ColumnString('relatedTable', this);
  }

  late final ClassFeatureDataUpdateTable updateTable;

  late final _is.ColumnInt parentClassId;

  _i7s9vfyh.ClassDataTable? _parentClass;

  late final _is.ColumnString name;

  late final _is.ColumnString referenceKey;

  late final _is.ColumnString description;

  late final _is.ColumnString shortDescription;

  late final _is.ColumnInt level;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnSerializable<List<_ixkx8coo.FeatureTag>> tags;

  late final _is.ColumnString choiceGroupKey;

  late final _is.ColumnSerializable<List<_iiw0j43j.Language>> grantedLanguages;

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>> grantedSkills;

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>>
  grantedExpertiseSkills;

  late final _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>
  grantedArmorTraining;

  late final _is.ColumnSerializable<List<_ibtz7e0l.WeaponCategory>>
  grantedWeaponTraining;

  late final _is.ColumnSerializable<List<String>> grantedToolKeys;

  late final _is.ColumnSerializable<List<String>> grantedExpertiseToolKeys;

  late final _is.ColumnSerializable<List<String>> grantedSpellKeys;

  late final _is.ColumnEnum<_inypkr0b.UnarmoredDefenseRule>
  unarmoredDefenseRule;

  late final _is.ColumnString relatedTable;

  _iib0ncbr.FeatureResourceDefinitionDataTable? ___resources;

  _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable>? _resources;

  _ipujnj10.FeatureResourceEffectDataTable? ___resourceEffects;

  _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>? _resourceEffects;

  _ira2m5oj.ClassSpellGrantDataTable? ___spellGrants;

  _is.ManyRelation<_ira2m5oj.ClassSpellGrantDataTable>? _spellGrants;

  _ilc9jnh2.FeatureModifierDataTable? ___featureModifiers;

  _is.ManyRelation<_ilc9jnh2.FeatureModifierDataTable>? _featureModifiers;

  _i7s9vfyh.ClassDataTable get parentClass {
    if (_parentClass != null) return _parentClass!;
    _parentClass = _is.createRelationTable(
      relationFieldName: 'parentClass',
      field: ClassFeatureData.t.parentClassId,
      foreignField: _i7s9vfyh.ClassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i7s9vfyh.ClassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentClass!;
  }

  _iib0ncbr.FeatureResourceDefinitionDataTable get __resources {
    if (___resources != null) return ___resources!;
    ___resources = _is.createRelationTable(
      relationFieldName: '__resources',
      field: ClassFeatureData.t.id,
      foreignField: _iib0ncbr.FeatureResourceDefinitionData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iib0ncbr.FeatureResourceDefinitionDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___resources!;
  }

  _ipujnj10.FeatureResourceEffectDataTable get __resourceEffects {
    if (___resourceEffects != null) return ___resourceEffects!;
    ___resourceEffects = _is.createRelationTable(
      relationFieldName: '__resourceEffects',
      field: ClassFeatureData.t.id,
      foreignField: _ipujnj10.FeatureResourceEffectData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ipujnj10.FeatureResourceEffectDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    return ___resourceEffects!;
  }

  _ira2m5oj.ClassSpellGrantDataTable get __spellGrants {
    if (___spellGrants != null) return ___spellGrants!;
    ___spellGrants = _is.createRelationTable(
      relationFieldName: '__spellGrants',
      field: ClassFeatureData.t.id,
      foreignField: _ira2m5oj.ClassSpellGrantData.t.sourceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _ira2m5oj.ClassSpellGrantDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return ___spellGrants!;
  }

  _ilc9jnh2.FeatureModifierDataTable get __featureModifiers {
    if (___featureModifiers != null) return ___featureModifiers!;
    ___featureModifiers = _is.createRelationTable(
      relationFieldName: '__featureModifiers',
      field: ClassFeatureData.t.id,
      foreignField: _ilc9jnh2.FeatureModifierData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _ilc9jnh2.FeatureModifierDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    return ___featureModifiers!;
  }

  _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable> get resources {
    if (_resources != null) return _resources!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'resources',
      field: ClassFeatureData.t.id,
      foreignField: _iib0ncbr.FeatureResourceDefinitionData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iib0ncbr.FeatureResourceDefinitionDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _resources = _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable>(
      tableWithRelations: relationTable,
      table: _iib0ncbr.FeatureResourceDefinitionDataTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _resources!;
  }

  _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>
  get resourceEffects {
    if (_resourceEffects != null) return _resourceEffects!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'resourceEffects',
      field: ClassFeatureData.t.id,
      foreignField: _ipujnj10.FeatureResourceEffectData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ipujnj10.FeatureResourceEffectDataTable(
            tableRelation: foreignTableRelation,
          ),
    );
    _resourceEffects =
        _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>(
          tableWithRelations: relationTable,
          table: _ipujnj10.FeatureResourceEffectDataTable(
            tableRelation: relationTable.tableRelation!.lastRelation,
          ),
        );
    return _resourceEffects!;
  }

  _is.ManyRelation<_ira2m5oj.ClassSpellGrantDataTable> get spellGrants {
    if (_spellGrants != null) return _spellGrants!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'spellGrants',
      field: ClassFeatureData.t.id,
      foreignField: _ira2m5oj.ClassSpellGrantData.t.sourceFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _ira2m5oj.ClassSpellGrantDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    _spellGrants = _is.ManyRelation<_ira2m5oj.ClassSpellGrantDataTable>(
      tableWithRelations: relationTable,
      table: _ira2m5oj.ClassSpellGrantDataTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _spellGrants!;
  }

  _is.ManyRelation<_ilc9jnh2.FeatureModifierDataTable> get featureModifiers {
    if (_featureModifiers != null) return _featureModifiers!;
    var relationTable = _is.createRelationTable(
      relationFieldName: 'featureModifiers',
      field: ClassFeatureData.t.id,
      foreignField: _ilc9jnh2.FeatureModifierData.t.classFeatureId,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) => _ilc9jnh2.FeatureModifierDataTable(
        tableRelation: foreignTableRelation,
      ),
    );
    _featureModifiers = _is.ManyRelation<_ilc9jnh2.FeatureModifierDataTable>(
      tableWithRelations: relationTable,
      table: _ilc9jnh2.FeatureModifierDataTable(
        tableRelation: relationTable.tableRelation!.lastRelation,
      ),
    );
    return _featureModifiers!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    parentClassId,
    name,
    referenceKey,
    description,
    shortDescription,
    level,
    source,
    version,
    createdAt,
    updatedAt,
    tags,
    choiceGroupKey,
    grantedLanguages,
    grantedSkills,
    grantedExpertiseSkills,
    grantedArmorTraining,
    grantedWeaponTraining,
    grantedToolKeys,
    grantedExpertiseToolKeys,
    grantedSpellKeys,
    unarmoredDefenseRule,
    relatedTable,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'parentClass') {
      return parentClass;
    }
    if (relationField == 'resources') {
      return __resources;
    }
    if (relationField == 'resourceEffects') {
      return __resourceEffects;
    }
    if (relationField == 'spellGrants') {
      return __spellGrants;
    }
    if (relationField == 'featureModifiers') {
      return __featureModifiers;
    }
    return null;
  }
}

class ClassFeatureDataInclude extends _is.IncludeObject {
  ClassFeatureDataInclude._({
    _i7s9vfyh.ClassDataInclude? parentClass,
    _iib0ncbr.FeatureResourceDefinitionDataIncludeList? resources,
    _ipujnj10.FeatureResourceEffectDataIncludeList? resourceEffects,
    _ira2m5oj.ClassSpellGrantDataIncludeList? spellGrants,
    _ilc9jnh2.FeatureModifierDataIncludeList? featureModifiers,
  }) {
    _parentClass = parentClass;
    _resources = resources;
    _resourceEffects = resourceEffects;
    _spellGrants = spellGrants;
    _featureModifiers = featureModifiers;
  }

  _i7s9vfyh.ClassDataInclude? _parentClass;

  _iib0ncbr.FeatureResourceDefinitionDataIncludeList? _resources;

  _ipujnj10.FeatureResourceEffectDataIncludeList? _resourceEffects;

  _ira2m5oj.ClassSpellGrantDataIncludeList? _spellGrants;

  _ilc9jnh2.FeatureModifierDataIncludeList? _featureModifiers;

  @override
  Map<String, _is.Include?> get includes => {
    'parentClass': _parentClass,
    'resources': _resources,
    'resourceEffects': _resourceEffects,
    'spellGrants': _spellGrants,
    'featureModifiers': _featureModifiers,
  };

  @override
  _is.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataIncludeList extends _is.IncludeList {
  ClassFeatureDataIncludeList._({
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ClassFeatureData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ClassFeatureData.t;
}

class ClassFeatureDataRepository {
  const ClassFeatureDataRepository._();

  final attach = const ClassFeatureDataAttachRepository._();

  final attachRow = const ClassFeatureDataAttachRowRepository._();

  final detach = const ClassFeatureDataDetachRepository._();

  final detachRow = const ClassFeatureDataDetachRowRepository._();

  /// Returns a list of [ClassFeatureData]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<ClassFeatureData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    ClassFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ClassFeatureData] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<ClassFeatureData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    ClassFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ClassFeatureData] by its [id] or null if no such row exists.
  Future<ClassFeatureData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ClassFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ClassFeatureData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ClassFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [ClassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassFeatureData>> insert(
    _is.DatabaseSession session,
    List<ClassFeatureData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ClassFeatureData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ClassFeatureData] and returns the inserted row.
  ///
  /// The returned [ClassFeatureData] will have its `id` field set.
  Future<ClassFeatureData> insertRow(
    _is.DatabaseSession session,
    ClassFeatureData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ClassFeatureData]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ClassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassFeatureData>> upsert(
    _is.DatabaseSession session,
    List<ClassFeatureData> rows, {
    required _is.ColumnSelections<ClassFeatureDataTable> conflictColumns,
    _is.ColumnSelections<ClassFeatureDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ClassFeatureData>(
      rows,
      conflictColumns: conflictColumns(ClassFeatureData.t),
      updateColumns: updateColumns?.call(ClassFeatureData.t),
      updateWhere: updateWhere?.call(ClassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ClassFeatureData] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ClassFeatureData] will have its `id` field set.
  Future<ClassFeatureData?> upsertRow(
    _is.DatabaseSession session,
    ClassFeatureData row, {
    required _is.ColumnSelections<ClassFeatureDataTable> conflictColumns,
    _is.ColumnSelections<ClassFeatureDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ClassFeatureData>(
      row,
      conflictColumns: conflictColumns(ClassFeatureData.t),
      updateColumns: updateColumns?.call(ClassFeatureData.t),
      updateWhere: updateWhere?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ClassFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassFeatureData>> update(
    _is.DatabaseSession session,
    List<ClassFeatureData> rows, {
    _is.ColumnSelections<ClassFeatureDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ClassFeatureData>(
      rows,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ClassFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ClassFeatureData> updateRow(
    _is.DatabaseSession session,
    ClassFeatureData row, {
    _is.ColumnSelections<ClassFeatureDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ClassFeatureData>(
      row,
      columns: columns?.call(ClassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ClassFeatureData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ClassFeatureData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ClassFeatureDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ClassFeatureData>(
      id,
      columnValues: columnValues(ClassFeatureData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ClassFeatureData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassFeatureData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ClassFeatureDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ClassFeatureDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ClassFeatureData>(
      columnValues: columnValues(ClassFeatureData.t.updateTable),
      where: where(ClassFeatureData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ClassFeatureData]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassFeatureData>> delete(
    _is.DatabaseSession session,
    List<ClassFeatureData> rows, {
    _is.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ClassFeatureData>(
      rows,
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ClassFeatureData].
  Future<ClassFeatureData> deleteRow(
    _is.DatabaseSession session,
    ClassFeatureData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ClassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ClassFeatureData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClassFeatureDataTable> where,
    _is.OrderByBuilder<ClassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<ClassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ClassFeatureData>(
      where: where(ClassFeatureData.t),
      orderBy: orderBy?.call(ClassFeatureData.t),
      orderByList: orderByList?.call(ClassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ClassFeatureDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ClassFeatureData>(
      where: where?.call(ClassFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ClassFeatureData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ClassFeatureDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ClassFeatureData>(
      where: where(ClassFeatureData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ClassFeatureDataAttachRepository {
  const ClassFeatureDataAttachRepository._();

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]s
  /// by setting each [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resources(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    List<_iib0ncbr.FeatureResourceDefinitionData>
    featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(classFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]s
  /// by setting each [FeatureResourceEffectData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    List<_ipujnj10.FeatureResourceEffectData> featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(classFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [ClassSpellGrantData]s
  /// by setting each [ClassSpellGrantData]'s foreign key `sourceFeatureId` to refer to this [ClassFeatureData].
  Future<void> spellGrants(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    List<_ira2m5oj.ClassSpellGrantData> classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $classSpellGrantData = classSpellGrantData
        .map((e) => e.copyWith(sourceFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureModifierData]s
  /// by setting each [FeatureModifierData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> featureModifiers(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    List<_ilc9jnh2.FeatureModifierData> featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureModifierData = featureModifierData
        .map((e) => e.copyWith(classFeatureId: classFeatureData.id))
        .toList();
    await session.db.update<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}

class ClassFeatureDataAttachRowRepository {
  const ClassFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [ClassFeatureData] and [ClassData]
  /// by setting the [ClassFeatureData]'s foreign key `parentClassId` to refer to the [ClassData].
  Future<void> parentClass(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    _i7s9vfyh.ClassData parentClass, {
    _is.Transaction? transaction,
  }) async {
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }
    if (parentClass.id == null) {
      throw ArgumentError.notNull('parentClass.id');
    }

    var $classFeatureData = classFeatureData.copyWith(
      parentClassId: parentClass.id,
    );
    await session.db.updateRow<ClassFeatureData>(
      $classFeatureData,
      columns: [ClassFeatureData.t.parentClassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resources(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    _iib0ncbr.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      classFeatureId: classFeatureData.id,
    );
    await session.db.updateRow<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    _ipujnj10.FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      classFeatureId: classFeatureData.id,
    );
    await session.db.updateRow<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to refer to this [ClassFeatureData].
  Future<void> spellGrants(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    _ira2m5oj.ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceFeatureId: classFeatureData.id,
    );
    await session.db.updateRow<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [ClassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to refer to this [ClassFeatureData].
  Future<void> featureModifiers(
    _is.DatabaseSession session,
    ClassFeatureData classFeatureData,
    _ilc9jnh2.FeatureModifierData featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (classFeatureData.id == null) {
      throw ArgumentError.notNull('classFeatureData.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      classFeatureId: classFeatureData.id,
    );
    await session.db.updateRow<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}

class ClassFeatureDataDetachRepository {
  const ClassFeatureDataDetachRepository._();

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resources(
    _is.DatabaseSession session,
    List<_iib0ncbr.FeatureResourceDefinitionData>
    featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(classFeatureId: null))
        .toList();
    await session.db.update<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    List<_ipujnj10.FeatureResourceEffectData> featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(classFeatureId: null))
        .toList();
    await session.db.update<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spellGrants(
    _is.DatabaseSession session,
    List<_ira2m5oj.ClassSpellGrantData> classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData
        .map((e) => e.copyWith(sourceFeatureId: null))
        .toList();
    await session.db.update<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> featureModifiers(
    _is.DatabaseSession session,
    List<_ilc9jnh2.FeatureModifierData> featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureModifierData.id');
    }

    var $featureModifierData = featureModifierData
        .map((e) => e.copyWith(classFeatureId: null))
        .toList();
    await session.db.update<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}

class ClassFeatureDataDetachRowRepository {
  const ClassFeatureDataDetachRowRepository._();

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resources(
    _is.DatabaseSession session,
    _iib0ncbr.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      classFeatureId: null,
    );
    await session.db.updateRow<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    _ipujnj10.FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      classFeatureId: null,
    );
    await session.db.updateRow<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.classFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> spellGrants(
    _is.DatabaseSession session,
    _ira2m5oj.ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceFeatureId: null,
    );
    await session.db.updateRow<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [ClassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `classFeatureId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> featureModifiers(
    _is.DatabaseSession session,
    _ilc9jnh2.FeatureModifierData featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      classFeatureId: null,
    );
    await session.db.updateRow<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.classFeatureId],
      transaction: transaction,
    );
  }
}
