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
import '../../../data/general/class/subclass_data.dart' as _i6yrac43;
import '../../../data/general/feature_modifier_data.dart' as _ilc9jnh2;
import '../../../data/general/feature_resource_definition_data.dart'
    as _iib0ncbr;
import '../../../data/general/feature_resource_effect_data.dart' as _ipujnj10;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/feature_tag.dart' as _ixkx8coo;
import '../../../enums/language.dart' as _iiw0j43j;
import '../../../enums/skill.dart' as _iqrhamom;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;

abstract class SubclassFeatureData
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SubclassFeatureData._({
    this.id,
    required this.parentSubclassId,
    this.parentSubclass,
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
    this.grantedSkills,
    this.grantedExpertiseSkills,
    this.grantedLanguages,
    this.grantedArmorTraining,
    this.grantedWeaponTraining,
    this.grantedToolKeys,
    this.grantedExpertiseToolKeys,
    this.grantedSpellKeys,
    this.relatedTable,
    this.resources,
    this.resourceEffects,
    this.spellGrants,
    this.featureModifiers,
  });

  factory SubclassFeatureData({
    int? id,
    required int parentSubclassId,
    _i6yrac43.SubclassData? parentSubclass,
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
    List<_iqrhamom.Skill>? grantedSkills,
    List<_iqrhamom.Skill>? grantedExpertiseSkills,
    List<_iiw0j43j.Language>? grantedLanguages,
    List<_irzuusaf.ArmorCategory>? grantedArmorTraining,
    List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    String? relatedTable,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ira2m5oj.ClassSpellGrantData>? spellGrants,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
  }) = _SubclassFeatureDataImpl;

  factory SubclassFeatureData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubclassFeatureData(
      id: jsonSerialization['id'] as int?,
      parentSubclassId: jsonSerialization['parentSubclassId'] as int,
      parentSubclass: jsonSerialization['parentSubclass'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i6yrac43.SubclassData>(
              jsonSerialization['parentSubclass'],
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
      grantedLanguages: jsonSerialization['grantedLanguages'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['grantedLanguages'],
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

  static final t = SubclassFeatureDataTable();

  static const db = SubclassFeatureDataRepository._();

  @override
  int? id;

  int parentSubclassId;

  _i6yrac43.SubclassData? parentSubclass;

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

  List<_iqrhamom.Skill>? grantedSkills;

  List<_iqrhamom.Skill>? grantedExpertiseSkills;

  List<_iiw0j43j.Language>? grantedLanguages;

  List<_irzuusaf.ArmorCategory>? grantedArmorTraining;

  List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedExpertiseToolKeys;

  List<String>? grantedSpellKeys;

  String? relatedTable;

  List<_iib0ncbr.FeatureResourceDefinitionData>? resources;

  List<_ipujnj10.FeatureResourceEffectData>? resourceEffects;

  List<_ira2m5oj.ClassSpellGrantData>? spellGrants;

  List<_ilc9jnh2.FeatureModifierData>? featureModifiers;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SubclassFeatureData copyWith({
    int? id,
    int? parentSubclassId,
    _i6yrac43.SubclassData? parentSubclass,
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
    List<_iqrhamom.Skill>? grantedSkills,
    List<_iqrhamom.Skill>? grantedExpertiseSkills,
    List<_iiw0j43j.Language>? grantedLanguages,
    List<_irzuusaf.ArmorCategory>? grantedArmorTraining,
    List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    String? relatedTable,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ira2m5oj.ClassSpellGrantData>? spellGrants,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubclassFeatureData',
      if (id != null) 'id': id,
      'parentSubclassId': parentSubclassId,
      if (parentSubclass != null) 'parentSubclass': parentSubclass?.toJson(),
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
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedExpertiseSkills != null)
        'grantedExpertiseSkills': grantedExpertiseSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedLanguages != null)
        'grantedLanguages': grantedLanguages?.toJson(
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
      '__className__': 'SubclassFeatureData',
      if (id != null) 'id': id,
      'parentSubclassId': parentSubclassId,
      if (parentSubclass != null)
        'parentSubclass': parentSubclass?.toJsonForProtocol(),
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
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedExpertiseSkills != null)
        'grantedExpertiseSkills': grantedExpertiseSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedLanguages != null)
        'grantedLanguages': grantedLanguages?.toJson(
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

  static SubclassFeatureDataInclude include({
    _i6yrac43.SubclassDataInclude? parentSubclass,
    _iib0ncbr.FeatureResourceDefinitionDataIncludeList? resources,
    _ipujnj10.FeatureResourceEffectDataIncludeList? resourceEffects,
    _ira2m5oj.ClassSpellGrantDataIncludeList? spellGrants,
    _ilc9jnh2.FeatureModifierDataIncludeList? featureModifiers,
  }) {
    return SubclassFeatureDataInclude._(
      parentSubclass: parentSubclass,
      resources: resources,
      resourceEffects: resourceEffects,
      spellGrants: spellGrants,
      featureModifiers: featureModifiers,
    );
  }

  static SubclassFeatureDataIncludeList includeList({
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    SubclassFeatureDataInclude? include,
  }) {
    return SubclassFeatureDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubclassFeatureDataImpl extends SubclassFeatureData {
  _SubclassFeatureDataImpl({
    int? id,
    required int parentSubclassId,
    _i6yrac43.SubclassData? parentSubclass,
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
    List<_iqrhamom.Skill>? grantedSkills,
    List<_iqrhamom.Skill>? grantedExpertiseSkills,
    List<_iiw0j43j.Language>? grantedLanguages,
    List<_irzuusaf.ArmorCategory>? grantedArmorTraining,
    List<_ibtz7e0l.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    List<String>? grantedSpellKeys,
    String? relatedTable,
    List<_iib0ncbr.FeatureResourceDefinitionData>? resources,
    List<_ipujnj10.FeatureResourceEffectData>? resourceEffects,
    List<_ira2m5oj.ClassSpellGrantData>? spellGrants,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
  }) : super._(
         id: id,
         parentSubclassId: parentSubclassId,
         parentSubclass: parentSubclass,
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
         grantedSkills: grantedSkills,
         grantedExpertiseSkills: grantedExpertiseSkills,
         grantedLanguages: grantedLanguages,
         grantedArmorTraining: grantedArmorTraining,
         grantedWeaponTraining: grantedWeaponTraining,
         grantedToolKeys: grantedToolKeys,
         grantedExpertiseToolKeys: grantedExpertiseToolKeys,
         grantedSpellKeys: grantedSpellKeys,
         relatedTable: relatedTable,
         resources: resources,
         resourceEffects: resourceEffects,
         spellGrants: spellGrants,
         featureModifiers: featureModifiers,
       );

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SubclassFeatureData copyWith({
    Object? id = _Undefined,
    int? parentSubclassId,
    Object? parentSubclass = _Undefined,
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
    Object? grantedSkills = _Undefined,
    Object? grantedExpertiseSkills = _Undefined,
    Object? grantedLanguages = _Undefined,
    Object? grantedArmorTraining = _Undefined,
    Object? grantedWeaponTraining = _Undefined,
    Object? grantedToolKeys = _Undefined,
    Object? grantedExpertiseToolKeys = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? relatedTable = _Undefined,
    Object? resources = _Undefined,
    Object? resourceEffects = _Undefined,
    Object? spellGrants = _Undefined,
    Object? featureModifiers = _Undefined,
  }) {
    return SubclassFeatureData(
      id: id is int? ? id : this.id,
      parentSubclassId: parentSubclassId ?? this.parentSubclassId,
      parentSubclass: parentSubclass is _i6yrac43.SubclassData?
          ? parentSubclass
          : this.parentSubclass?.copyWith(),
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
      grantedSkills: grantedSkills is List<_iqrhamom.Skill>?
          ? grantedSkills
          : this.grantedSkills?.map((e0) => e0).toList(),
      grantedExpertiseSkills: grantedExpertiseSkills is List<_iqrhamom.Skill>?
          ? grantedExpertiseSkills
          : this.grantedExpertiseSkills?.map((e0) => e0).toList(),
      grantedLanguages: grantedLanguages is List<_iiw0j43j.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
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

class SubclassFeatureDataUpdateTable
    extends _is.UpdateTable<SubclassFeatureDataTable> {
  SubclassFeatureDataUpdateTable(super.table);

  _is.ColumnValue<int, int> parentSubclassId(int value) =>
      _is.ColumnValue(table.parentSubclassId, value);

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

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>> grantedSkills(
    List<_iqrhamom.Skill>? value,
  ) => _is.ColumnValue(table.grantedSkills, value);

  _is.ColumnValue<List<_iqrhamom.Skill>, List<_iqrhamom.Skill>>
  grantedExpertiseSkills(List<_iqrhamom.Skill>? value) =>
      _is.ColumnValue(table.grantedExpertiseSkills, value);

  _is.ColumnValue<List<_iiw0j43j.Language>, List<_iiw0j43j.Language>>
  grantedLanguages(List<_iiw0j43j.Language>? value) =>
      _is.ColumnValue(table.grantedLanguages, value);

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

  _is.ColumnValue<String, String> relatedTable(String? value) =>
      _is.ColumnValue(table.relatedTable, value);
}

class SubclassFeatureDataTable extends _is.Table<int?> {
  SubclassFeatureDataTable({super.tableRelation})
    : super(tableName: 'subclass_feature_data') {
    updateTable = SubclassFeatureDataUpdateTable(this);
    parentSubclassId = _is.ColumnInt('parentSubclassId', this);
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
    grantedSkills = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'grantedSkills',
      this,
    );
    grantedExpertiseSkills = _is.ColumnSerializable<List<_iqrhamom.Skill>>(
      'grantedExpertiseSkills',
      this,
    );
    grantedLanguages = _is.ColumnSerializable<List<_iiw0j43j.Language>>(
      'grantedLanguages',
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
    relatedTable = _is.ColumnString('relatedTable', this);
  }

  late final SubclassFeatureDataUpdateTable updateTable;

  late final _is.ColumnInt parentSubclassId;

  _i6yrac43.SubclassDataTable? _parentSubclass;

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

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>> grantedSkills;

  late final _is.ColumnSerializable<List<_iqrhamom.Skill>>
  grantedExpertiseSkills;

  late final _is.ColumnSerializable<List<_iiw0j43j.Language>> grantedLanguages;

  late final _is.ColumnSerializable<List<_irzuusaf.ArmorCategory>>
  grantedArmorTraining;

  late final _is.ColumnSerializable<List<_ibtz7e0l.WeaponCategory>>
  grantedWeaponTraining;

  late final _is.ColumnSerializable<List<String>> grantedToolKeys;

  late final _is.ColumnSerializable<List<String>> grantedExpertiseToolKeys;

  late final _is.ColumnSerializable<List<String>> grantedSpellKeys;

  late final _is.ColumnString relatedTable;

  _iib0ncbr.FeatureResourceDefinitionDataTable? ___resources;

  _is.ManyRelation<_iib0ncbr.FeatureResourceDefinitionDataTable>? _resources;

  _ipujnj10.FeatureResourceEffectDataTable? ___resourceEffects;

  _is.ManyRelation<_ipujnj10.FeatureResourceEffectDataTable>? _resourceEffects;

  _ira2m5oj.ClassSpellGrantDataTable? ___spellGrants;

  _is.ManyRelation<_ira2m5oj.ClassSpellGrantDataTable>? _spellGrants;

  _ilc9jnh2.FeatureModifierDataTable? ___featureModifiers;

  _is.ManyRelation<_ilc9jnh2.FeatureModifierDataTable>? _featureModifiers;

  _i6yrac43.SubclassDataTable get parentSubclass {
    if (_parentSubclass != null) return _parentSubclass!;
    _parentSubclass = _is.createRelationTable(
      relationFieldName: 'parentSubclass',
      field: SubclassFeatureData.t.parentSubclassId,
      foreignField: _i6yrac43.SubclassData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i6yrac43.SubclassDataTable(tableRelation: foreignTableRelation),
    );
    return _parentSubclass!;
  }

  _iib0ncbr.FeatureResourceDefinitionDataTable get __resources {
    if (___resources != null) return ___resources!;
    ___resources = _is.createRelationTable(
      relationFieldName: '__resources',
      field: SubclassFeatureData.t.id,
      foreignField: _iib0ncbr.FeatureResourceDefinitionData.t.subclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _ipujnj10.FeatureResourceEffectData.t.subclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _ira2m5oj.ClassSpellGrantData.t.sourceSubclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _ilc9jnh2.FeatureModifierData.t.subclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _iib0ncbr.FeatureResourceDefinitionData.t.subclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _ipujnj10.FeatureResourceEffectData.t.subclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _ira2m5oj.ClassSpellGrantData.t.sourceSubclassFeatureId,
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
      field: SubclassFeatureData.t.id,
      foreignField: _ilc9jnh2.FeatureModifierData.t.subclassFeatureId,
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
    parentSubclassId,
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
    grantedSkills,
    grantedExpertiseSkills,
    grantedLanguages,
    grantedArmorTraining,
    grantedWeaponTraining,
    grantedToolKeys,
    grantedExpertiseToolKeys,
    grantedSpellKeys,
    relatedTable,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'parentSubclass') {
      return parentSubclass;
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

class SubclassFeatureDataInclude extends _is.IncludeObject {
  SubclassFeatureDataInclude._({
    _i6yrac43.SubclassDataInclude? parentSubclass,
    _iib0ncbr.FeatureResourceDefinitionDataIncludeList? resources,
    _ipujnj10.FeatureResourceEffectDataIncludeList? resourceEffects,
    _ira2m5oj.ClassSpellGrantDataIncludeList? spellGrants,
    _ilc9jnh2.FeatureModifierDataIncludeList? featureModifiers,
  }) {
    _parentSubclass = parentSubclass;
    _resources = resources;
    _resourceEffects = resourceEffects;
    _spellGrants = spellGrants;
    _featureModifiers = featureModifiers;
  }

  _i6yrac43.SubclassDataInclude? _parentSubclass;

  _iib0ncbr.FeatureResourceDefinitionDataIncludeList? _resources;

  _ipujnj10.FeatureResourceEffectDataIncludeList? _resourceEffects;

  _ira2m5oj.ClassSpellGrantDataIncludeList? _spellGrants;

  _ilc9jnh2.FeatureModifierDataIncludeList? _featureModifiers;

  @override
  Map<String, _is.Include?> get includes => {
    'parentSubclass': _parentSubclass,
    'resources': _resources,
    'resourceEffects': _resourceEffects,
    'spellGrants': _spellGrants,
    'featureModifiers': _featureModifiers,
  };

  @override
  _is.Table<int?> get table => SubclassFeatureData.t;
}

class SubclassFeatureDataIncludeList extends _is.IncludeList {
  SubclassFeatureDataIncludeList._({
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SubclassFeatureData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SubclassFeatureData.t;
}

class SubclassFeatureDataRepository {
  const SubclassFeatureDataRepository._();

  final attach = const SubclassFeatureDataAttachRepository._();

  final attachRow = const SubclassFeatureDataAttachRowRepository._();

  final detach = const SubclassFeatureDataDetachRepository._();

  final detachRow = const SubclassFeatureDataDetachRowRepository._();

  /// Returns a list of [SubclassFeatureData]s matching the given query parameters.
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
  Future<List<SubclassFeatureData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    SubclassFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SubclassFeatureData>(
      where: where?.call(SubclassFeatureData.t),
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SubclassFeatureData] matching the given query parameters.
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
  Future<SubclassFeatureData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? offset,
    _is.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    SubclassFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SubclassFeatureData>(
      where: where?.call(SubclassFeatureData.t),
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SubclassFeatureData] by its [id] or null if no such row exists.
  Future<SubclassFeatureData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SubclassFeatureDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SubclassFeatureData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SubclassFeatureData]s in the list and returns the inserted rows.
  ///
  /// The returned [SubclassFeatureData]s will have their `id` fields set.
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
  Future<List<SubclassFeatureData>> insert(
    _is.DatabaseSession session,
    List<SubclassFeatureData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SubclassFeatureData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SubclassFeatureData] and returns the inserted row.
  ///
  /// The returned [SubclassFeatureData] will have its `id` field set.
  Future<SubclassFeatureData> insertRow(
    _is.DatabaseSession session,
    SubclassFeatureData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SubclassFeatureData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [SubclassFeatureData]s in the list and returns the resulting rows.
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
  /// The returned [SubclassFeatureData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassFeatureData>> upsert(
    _is.DatabaseSession session,
    List<SubclassFeatureData> rows, {
    required _is.ColumnSelections<SubclassFeatureDataTable> conflictColumns,
    _is.ColumnSelections<SubclassFeatureDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SubclassFeatureData>(
      rows,
      conflictColumns: conflictColumns(SubclassFeatureData.t),
      updateColumns: updateColumns?.call(SubclassFeatureData.t),
      updateWhere: updateWhere?.call(SubclassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SubclassFeatureData] and returns the resulting row.
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
  /// The returned [SubclassFeatureData] will have its `id` field set.
  Future<SubclassFeatureData?> upsertRow(
    _is.DatabaseSession session,
    SubclassFeatureData row, {
    required _is.ColumnSelections<SubclassFeatureDataTable> conflictColumns,
    _is.ColumnSelections<SubclassFeatureDataTable>? updateColumns,
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SubclassFeatureData>(
      row,
      conflictColumns: conflictColumns(SubclassFeatureData.t),
      updateColumns: updateColumns?.call(SubclassFeatureData.t),
      updateWhere: updateWhere?.call(SubclassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates all [SubclassFeatureData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassFeatureData>> update(
    _is.DatabaseSession session,
    List<SubclassFeatureData> rows, {
    _is.ColumnSelections<SubclassFeatureDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SubclassFeatureData>(
      rows,
      columns: columns?.call(SubclassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SubclassFeatureData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SubclassFeatureData> updateRow(
    _is.DatabaseSession session,
    SubclassFeatureData row, {
    _is.ColumnSelections<SubclassFeatureDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SubclassFeatureData>(
      row,
      columns: columns?.call(SubclassFeatureData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SubclassFeatureData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SubclassFeatureData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SubclassFeatureDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SubclassFeatureData>(
      id,
      columnValues: columnValues(SubclassFeatureData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SubclassFeatureData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SubclassFeatureData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SubclassFeatureDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<SubclassFeatureDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SubclassFeatureData>(
      columnValues: columnValues(SubclassFeatureData.t.updateTable),
      where: where(SubclassFeatureData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SubclassFeatureData]s in the list and returns the deleted rows.
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
  Future<List<SubclassFeatureData>> delete(
    _is.DatabaseSession session,
    List<SubclassFeatureData> rows, {
    _is.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SubclassFeatureData>(
      rows,
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SubclassFeatureData].
  Future<SubclassFeatureData> deleteRow(
    _is.DatabaseSession session,
    SubclassFeatureData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SubclassFeatureData>(
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
  Future<List<SubclassFeatureData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SubclassFeatureDataTable> where,
    _is.OrderByBuilder<SubclassFeatureDataTable>? orderBy,
    _is.OrderByListBuilder<SubclassFeatureDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SubclassFeatureData>(
      where: where(SubclassFeatureData.t),
      orderBy: orderBy?.call(SubclassFeatureData.t),
      orderByList: orderByList?.call(SubclassFeatureData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SubclassFeatureDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SubclassFeatureData>(
      where: where?.call(SubclassFeatureData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SubclassFeatureData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SubclassFeatureDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SubclassFeatureData>(
      where: where(SubclassFeatureData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SubclassFeatureDataAttachRepository {
  const SubclassFeatureDataAttachRepository._();

  /// Creates a relation between this [SubclassFeatureData] and the given [FeatureResourceDefinitionData]s
  /// by setting each [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> resources(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    List<_iib0ncbr.FeatureResourceDefinitionData>
    featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData
        .map((e) => e.copyWith(subclassFeatureId: subclassFeatureData.id))
        .toList();
    await session.db.update<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [FeatureResourceEffectData]s
  /// by setting each [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    List<_ipujnj10.FeatureResourceEffectData> featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData
        .map((e) => e.copyWith(subclassFeatureId: subclassFeatureData.id))
        .toList();
    await session.db.update<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [ClassSpellGrantData]s
  /// by setting each [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> spellGrants(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    List<_ira2m5oj.ClassSpellGrantData> classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $classSpellGrantData = classSpellGrantData
        .map((e) => e.copyWith(sourceSubclassFeatureId: subclassFeatureData.id))
        .toList();
    await session.db.update<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [FeatureModifierData]s
  /// by setting each [FeatureModifierData]'s foreign key `subclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> featureModifiers(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    List<_ilc9jnh2.FeatureModifierData> featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.any((e) => e.id == null)) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $featureModifierData = featureModifierData
        .map((e) => e.copyWith(subclassFeatureId: subclassFeatureData.id))
        .toList();
    await session.db.update<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}

class SubclassFeatureDataAttachRowRepository {
  const SubclassFeatureDataAttachRowRepository._();

  /// Creates a relation between the given [SubclassFeatureData] and [SubclassData]
  /// by setting the [SubclassFeatureData]'s foreign key `parentSubclassId` to refer to the [SubclassData].
  Future<void> parentSubclass(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    _i6yrac43.SubclassData parentSubclass, {
    _is.Transaction? transaction,
  }) async {
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }
    if (parentSubclass.id == null) {
      throw ArgumentError.notNull('parentSubclass.id');
    }

    var $subclassFeatureData = subclassFeatureData.copyWith(
      parentSubclassId: parentSubclass.id,
    );
    await session.db.updateRow<SubclassFeatureData>(
      $subclassFeatureData,
      columns: [SubclassFeatureData.t.parentSubclassId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> resources(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    _iib0ncbr.FeatureResourceDefinitionData featureResourceDefinitionData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceDefinitionData.id == null) {
      throw ArgumentError.notNull('featureResourceDefinitionData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $featureResourceDefinitionData = featureResourceDefinitionData.copyWith(
      subclassFeatureId: subclassFeatureData.id,
    );
    await session.db.updateRow<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> resourceEffects(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    _ipujnj10.FeatureResourceEffectData featureResourceEffectData, {
    _is.Transaction? transaction,
  }) async {
    if (featureResourceEffectData.id == null) {
      throw ArgumentError.notNull('featureResourceEffectData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $featureResourceEffectData = featureResourceEffectData.copyWith(
      subclassFeatureId: subclassFeatureData.id,
    );
    await session.db.updateRow<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> spellGrants(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    _ira2m5oj.ClassSpellGrantData classSpellGrantData, {
    _is.Transaction? transaction,
  }) async {
    if (classSpellGrantData.id == null) {
      throw ArgumentError.notNull('classSpellGrantData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $classSpellGrantData = classSpellGrantData.copyWith(
      sourceSubclassFeatureId: subclassFeatureData.id,
    );
    await session.db.updateRow<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Creates a relation between this [SubclassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to refer to this [SubclassFeatureData].
  Future<void> featureModifiers(
    _is.DatabaseSession session,
    SubclassFeatureData subclassFeatureData,
    _ilc9jnh2.FeatureModifierData featureModifierData, {
    _is.Transaction? transaction,
  }) async {
    if (featureModifierData.id == null) {
      throw ArgumentError.notNull('featureModifierData.id');
    }
    if (subclassFeatureData.id == null) {
      throw ArgumentError.notNull('subclassFeatureData.id');
    }

    var $featureModifierData = featureModifierData.copyWith(
      subclassFeatureId: subclassFeatureData.id,
    );
    await session.db.updateRow<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}

class SubclassFeatureDataDetachRepository {
  const SubclassFeatureDataDetachRepository._();

  /// Detaches the relation between this [SubclassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to `null`.
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
        .map((e) => e.copyWith(subclassFeatureId: null))
        .toList();
    await session.db.update<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SubclassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to `null`.
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
        .map((e) => e.copyWith(subclassFeatureId: null))
        .toList();
    await session.db.update<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SubclassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to `null`.
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
        .map((e) => e.copyWith(sourceSubclassFeatureId: null))
        .toList();
    await session.db.update<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SubclassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to `null`.
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
        .map((e) => e.copyWith(subclassFeatureId: null))
        .toList();
    await session.db.update<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}

class SubclassFeatureDataDetachRowRepository {
  const SubclassFeatureDataDetachRowRepository._();

  /// Detaches the relation between this [SubclassFeatureData] and the given [FeatureResourceDefinitionData]
  /// by setting the [FeatureResourceDefinitionData]'s foreign key `subclassFeatureId` to `null`.
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
      subclassFeatureId: null,
    );
    await session.db.updateRow<_iib0ncbr.FeatureResourceDefinitionData>(
      $featureResourceDefinitionData,
      columns: [_iib0ncbr.FeatureResourceDefinitionData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SubclassFeatureData] and the given [FeatureResourceEffectData]
  /// by setting the [FeatureResourceEffectData]'s foreign key `subclassFeatureId` to `null`.
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
      subclassFeatureId: null,
    );
    await session.db.updateRow<_ipujnj10.FeatureResourceEffectData>(
      $featureResourceEffectData,
      columns: [_ipujnj10.FeatureResourceEffectData.t.subclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SubclassFeatureData] and the given [ClassSpellGrantData]
  /// by setting the [ClassSpellGrantData]'s foreign key `sourceSubclassFeatureId` to `null`.
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
      sourceSubclassFeatureId: null,
    );
    await session.db.updateRow<_ira2m5oj.ClassSpellGrantData>(
      $classSpellGrantData,
      columns: [_ira2m5oj.ClassSpellGrantData.t.sourceSubclassFeatureId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [SubclassFeatureData] and the given [FeatureModifierData]
  /// by setting the [FeatureModifierData]'s foreign key `subclassFeatureId` to `null`.
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
      subclassFeatureId: null,
    );
    await session.db.updateRow<_ilc9jnh2.FeatureModifierData>(
      $featureModifierData,
      columns: [_ilc9jnh2.FeatureModifierData.t.subclassFeatureId],
      transaction: transaction,
    );
  }
}
