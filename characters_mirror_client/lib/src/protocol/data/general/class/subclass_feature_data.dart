/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
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
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isnx6jbi.Protocol().deserialize<_i6yrac43.SubclassData>(
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      tags: jsonSerialization['tags'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ixkx8coo.FeatureTag>>(
              jsonSerialization['tags'],
            ),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
      grantedSkills: jsonSerialization['grantedSkills'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['grantedSkills'],
            ),
      grantedExpertiseSkills:
          jsonSerialization['grantedExpertiseSkills'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['grantedExpertiseSkills'],
            ),
      grantedLanguages: jsonSerialization['grantedLanguages'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['grantedLanguages'],
            ),
      grantedArmorTraining: jsonSerialization['grantedArmorTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['grantedArmorTraining'],
            ),
      grantedWeaponTraining: jsonSerialization['grantedWeaponTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['grantedWeaponTraining'],
            ),
      grantedToolKeys: jsonSerialization['grantedToolKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedToolKeys'],
            ),
      grantedExpertiseToolKeys:
          jsonSerialization['grantedExpertiseToolKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedExpertiseToolKeys'],
            ),
      grantedSpellKeys: jsonSerialization['grantedSpellKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedSpellKeys'],
            ),
      relatedTable: jsonSerialization['relatedTable'] as String?,
      resources: jsonSerialization['resources'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_iib0ncbr.FeatureResourceDefinitionData>>(
                  jsonSerialization['resources'],
                ),
      resourceEffects: jsonSerialization['resourceEffects'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ipujnj10.FeatureResourceEffectData>>(
                  jsonSerialization['resourceEffects'],
                ),
      spellGrants: jsonSerialization['spellGrants'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ira2m5oj.ClassSpellGrantData>>(
                  jsonSerialization['spellGrants'],
                ),
      featureModifiers: jsonSerialization['featureModifiers'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ilc9jnh2.FeatureModifierData>>(
                  jsonSerialization['featureModifiers'],
                ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [SubclassFeatureData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
