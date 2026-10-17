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
import '../../data/general/choice_group_data.dart' as _iz5y1q0y;
import '../../data/general/choice_requirement_data.dart' as _igf6e3qg;
import '../../enums/armor_category.dart' as _ixuui93s;
import '../../enums/damage_type.dart' as _iei1ksog;
import '../../enums/feature_tag.dart' as _i47d6u5x;
import '../../enums/language.dart' as _iuo43pdt;
import '../../enums/skill.dart' as _i6w9mv0m;
import '../../enums/spell/area_of_effect_type.dart' as _il0t2tw3;
import '../../enums/weapon_category.dart' as _iya6mjd5;

abstract class ChoiceOptionData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ChoiceOptionData._({
    this.id,
    required this.choiceGroupId,
    this.choiceGroup,
    required this.optionKey,
    this.name,
    this.description,
    this.shortDescription,
    this.automaticSelection,
    this.sortOrder,
    this.grantedAbilityBonuses,
    this.grantedSkills,
    this.grantedExpertiseSkills,
    this.grantedLanguages,
    this.grantedArmorTraining,
    this.grantedWeaponTraining,
    this.grantedToolKeys,
    this.grantedExpertiseToolKeys,
    this.requiredExistingSkill,
    this.requiredExistingToolKey,
    this.requirements,
    this.grantedSpellKeys,
    this.grantedFeatureTags,
    this.damageType,
    this.areaOfEffectType,
    this.areaText,
    this.damageByLevel,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ChoiceOptionData({
    int? id,
    required int choiceGroupId,
    _iz5y1q0y.ChoiceGroupData? choiceGroup,
    required String optionKey,
    String? name,
    String? description,
    String? shortDescription,
    bool? automaticSelection,
    int? sortOrder,
    Map<String, int>? grantedAbilityBonuses,
    List<_i6w9mv0m.Skill>? grantedSkills,
    List<_i6w9mv0m.Skill>? grantedExpertiseSkills,
    List<_iuo43pdt.Language>? grantedLanguages,
    List<_ixuui93s.ArmorCategory>? grantedArmorTraining,
    List<_iya6mjd5.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    _i6w9mv0m.Skill? requiredExistingSkill,
    String? requiredExistingToolKey,
    List<_igf6e3qg.ChoiceRequirementData>? requirements,
    List<String>? grantedSpellKeys,
    List<_i47d6u5x.FeatureTag>? grantedFeatureTags,
    _iei1ksog.DamageType? damageType,
    _il0t2tw3.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    Map<String, String>? damageByLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChoiceOptionDataImpl;

  factory ChoiceOptionData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChoiceOptionData(
      id: jsonSerialization['id'] as int?,
      choiceGroupId: jsonSerialization['choiceGroupId'] as int,
      choiceGroup: jsonSerialization['choiceGroup'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_iz5y1q0y.ChoiceGroupData>(
              jsonSerialization['choiceGroup'],
            ),
      optionKey: jsonSerialization['optionKey'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      automaticSelection: jsonSerialization['automaticSelection'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(
              jsonSerialization['automaticSelection'],
            ),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      grantedAbilityBonuses: jsonSerialization['grantedAbilityBonuses'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['grantedAbilityBonuses'],
            ),
      grantedSkills: jsonSerialization['grantedSkills'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_i6w9mv0m.Skill>>(
              jsonSerialization['grantedSkills'],
            ),
      grantedExpertiseSkills:
          jsonSerialization['grantedExpertiseSkills'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_i6w9mv0m.Skill>>(
              jsonSerialization['grantedExpertiseSkills'],
            ),
      grantedLanguages: jsonSerialization['grantedLanguages'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iuo43pdt.Language>>(
              jsonSerialization['grantedLanguages'],
            ),
      grantedArmorTraining: jsonSerialization['grantedArmorTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_ixuui93s.ArmorCategory>>(
              jsonSerialization['grantedArmorTraining'],
            ),
      grantedWeaponTraining: jsonSerialization['grantedWeaponTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iya6mjd5.WeaponCategory>>(
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
      requiredExistingSkill: jsonSerialization['requiredExistingSkill'] == null
          ? null
          : _i6w9mv0m.Skill.fromJson(
              (jsonSerialization['requiredExistingSkill'] as String),
            ),
      requiredExistingToolKey:
          jsonSerialization['requiredExistingToolKey'] as String?,
      requirements: jsonSerialization['requirements'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_igf6e3qg.ChoiceRequirementData>>(
                  jsonSerialization['requirements'],
                ),
      grantedSpellKeys: jsonSerialization['grantedSpellKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedSpellKeys'],
            ),
      grantedFeatureTags: jsonSerialization['grantedFeatureTags'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_i47d6u5x.FeatureTag>>(
              jsonSerialization['grantedFeatureTags'],
            ),
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _iei1ksog.DamageType.fromJson(
              (jsonSerialization['damageType'] as String),
            ),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _il0t2tw3.AreaOfEffectType.fromJson(
              (jsonSerialization['areaOfEffectType'] as String),
            ),
      areaText: jsonSerialization['areaText'] as String?,
      damageByLevel: jsonSerialization['damageByLevel'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['damageByLevel'],
            ),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int choiceGroupId;

  _iz5y1q0y.ChoiceGroupData? choiceGroup;

  String optionKey;

  String? name;

  String? description;

  String? shortDescription;

  bool? automaticSelection;

  int? sortOrder;

  Map<String, int>? grantedAbilityBonuses;

  List<_i6w9mv0m.Skill>? grantedSkills;

  List<_i6w9mv0m.Skill>? grantedExpertiseSkills;

  List<_iuo43pdt.Language>? grantedLanguages;

  List<_ixuui93s.ArmorCategory>? grantedArmorTraining;

  List<_iya6mjd5.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedExpertiseToolKeys;

  _i6w9mv0m.Skill? requiredExistingSkill;

  String? requiredExistingToolKey;

  List<_igf6e3qg.ChoiceRequirementData>? requirements;

  List<String>? grantedSpellKeys;

  List<_i47d6u5x.FeatureTag>? grantedFeatureTags;

  _iei1ksog.DamageType? damageType;

  _il0t2tw3.AreaOfEffectType? areaOfEffectType;

  String? areaText;

  Map<String, String>? damageByLevel;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ChoiceOptionData copyWith({
    int? id,
    int? choiceGroupId,
    _iz5y1q0y.ChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    String? shortDescription,
    bool? automaticSelection,
    int? sortOrder,
    Map<String, int>? grantedAbilityBonuses,
    List<_i6w9mv0m.Skill>? grantedSkills,
    List<_i6w9mv0m.Skill>? grantedExpertiseSkills,
    List<_iuo43pdt.Language>? grantedLanguages,
    List<_ixuui93s.ArmorCategory>? grantedArmorTraining,
    List<_iya6mjd5.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    _i6w9mv0m.Skill? requiredExistingSkill,
    String? requiredExistingToolKey,
    List<_igf6e3qg.ChoiceRequirementData>? requirements,
    List<String>? grantedSpellKeys,
    List<_i47d6u5x.FeatureTag>? grantedFeatureTags,
    _iei1ksog.DamageType? damageType,
    _il0t2tw3.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    Map<String, String>? damageByLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChoiceOptionData',
      if (id != null) 'id': id,
      'choiceGroupId': choiceGroupId,
      if (choiceGroup != null) 'choiceGroup': choiceGroup?.toJson(),
      'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (automaticSelection != null) 'automaticSelection': automaticSelection,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (grantedAbilityBonuses != null)
        'grantedAbilityBonuses': grantedAbilityBonuses?.toJson(),
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
      if (requiredExistingSkill != null)
        'requiredExistingSkill': requiredExistingSkill?.toJson(),
      if (requiredExistingToolKey != null)
        'requiredExistingToolKey': requiredExistingToolKey,
      if (requirements != null)
        'requirements': requirements?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedFeatureTags != null)
        'grantedFeatureTags': grantedFeatureTags?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaText != null) 'areaText': areaText,
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChoiceOptionData',
      if (id != null) 'id': id,
      'choiceGroupId': choiceGroupId,
      if (choiceGroup != null) 'choiceGroup': choiceGroup?.toJsonForProtocol(),
      'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (automaticSelection != null) 'automaticSelection': automaticSelection,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (grantedAbilityBonuses != null)
        'grantedAbilityBonuses': grantedAbilityBonuses?.toJson(),
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
      if (requiredExistingSkill != null)
        'requiredExistingSkill': requiredExistingSkill?.toJson(),
      if (requiredExistingToolKey != null)
        'requiredExistingToolKey': requiredExistingToolKey,
      if (requirements != null)
        'requirements': requirements?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedFeatureTags != null)
        'grantedFeatureTags': grantedFeatureTags?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaText != null) 'areaText': areaText,
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceOptionDataImpl extends ChoiceOptionData {
  _ChoiceOptionDataImpl({
    int? id,
    required int choiceGroupId,
    _iz5y1q0y.ChoiceGroupData? choiceGroup,
    required String optionKey,
    String? name,
    String? description,
    String? shortDescription,
    bool? automaticSelection,
    int? sortOrder,
    Map<String, int>? grantedAbilityBonuses,
    List<_i6w9mv0m.Skill>? grantedSkills,
    List<_i6w9mv0m.Skill>? grantedExpertiseSkills,
    List<_iuo43pdt.Language>? grantedLanguages,
    List<_ixuui93s.ArmorCategory>? grantedArmorTraining,
    List<_iya6mjd5.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    _i6w9mv0m.Skill? requiredExistingSkill,
    String? requiredExistingToolKey,
    List<_igf6e3qg.ChoiceRequirementData>? requirements,
    List<String>? grantedSpellKeys,
    List<_i47d6u5x.FeatureTag>? grantedFeatureTags,
    _iei1ksog.DamageType? damageType,
    _il0t2tw3.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    Map<String, String>? damageByLevel,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         choiceGroupId: choiceGroupId,
         choiceGroup: choiceGroup,
         optionKey: optionKey,
         name: name,
         description: description,
         shortDescription: shortDescription,
         automaticSelection: automaticSelection,
         sortOrder: sortOrder,
         grantedAbilityBonuses: grantedAbilityBonuses,
         grantedSkills: grantedSkills,
         grantedExpertiseSkills: grantedExpertiseSkills,
         grantedLanguages: grantedLanguages,
         grantedArmorTraining: grantedArmorTraining,
         grantedWeaponTraining: grantedWeaponTraining,
         grantedToolKeys: grantedToolKeys,
         grantedExpertiseToolKeys: grantedExpertiseToolKeys,
         requiredExistingSkill: requiredExistingSkill,
         requiredExistingToolKey: requiredExistingToolKey,
         requirements: requirements,
         grantedSpellKeys: grantedSpellKeys,
         grantedFeatureTags: grantedFeatureTags,
         damageType: damageType,
         areaOfEffectType: areaOfEffectType,
         areaText: areaText,
         damageByLevel: damageByLevel,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ChoiceOptionData copyWith({
    Object? id = _Undefined,
    int? choiceGroupId,
    Object? choiceGroup = _Undefined,
    String? optionKey,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? shortDescription = _Undefined,
    Object? automaticSelection = _Undefined,
    Object? sortOrder = _Undefined,
    Object? grantedAbilityBonuses = _Undefined,
    Object? grantedSkills = _Undefined,
    Object? grantedExpertiseSkills = _Undefined,
    Object? grantedLanguages = _Undefined,
    Object? grantedArmorTraining = _Undefined,
    Object? grantedWeaponTraining = _Undefined,
    Object? grantedToolKeys = _Undefined,
    Object? grantedExpertiseToolKeys = _Undefined,
    Object? requiredExistingSkill = _Undefined,
    Object? requiredExistingToolKey = _Undefined,
    Object? requirements = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? grantedFeatureTags = _Undefined,
    Object? damageType = _Undefined,
    Object? areaOfEffectType = _Undefined,
    Object? areaText = _Undefined,
    Object? damageByLevel = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ChoiceOptionData(
      id: id is int? ? id : this.id,
      choiceGroupId: choiceGroupId ?? this.choiceGroupId,
      choiceGroup: choiceGroup is _iz5y1q0y.ChoiceGroupData?
          ? choiceGroup
          : this.choiceGroup?.copyWith(),
      optionKey: optionKey ?? this.optionKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      shortDescription: shortDescription is String?
          ? shortDescription
          : this.shortDescription,
      automaticSelection: automaticSelection is bool?
          ? automaticSelection
          : this.automaticSelection,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      grantedAbilityBonuses: grantedAbilityBonuses is Map<String, int>?
          ? grantedAbilityBonuses
          : this.grantedAbilityBonuses?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      grantedSkills: grantedSkills is List<_i6w9mv0m.Skill>?
          ? grantedSkills
          : this.grantedSkills?.map((e0) => e0).toList(),
      grantedExpertiseSkills: grantedExpertiseSkills is List<_i6w9mv0m.Skill>?
          ? grantedExpertiseSkills
          : this.grantedExpertiseSkills?.map((e0) => e0).toList(),
      grantedLanguages: grantedLanguages is List<_iuo43pdt.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
      grantedArmorTraining:
          grantedArmorTraining is List<_ixuui93s.ArmorCategory>?
          ? grantedArmorTraining
          : this.grantedArmorTraining?.map((e0) => e0).toList(),
      grantedWeaponTraining:
          grantedWeaponTraining is List<_iya6mjd5.WeaponCategory>?
          ? grantedWeaponTraining
          : this.grantedWeaponTraining?.map((e0) => e0).toList(),
      grantedToolKeys: grantedToolKeys is List<String>?
          ? grantedToolKeys
          : this.grantedToolKeys?.map((e0) => e0).toList(),
      grantedExpertiseToolKeys: grantedExpertiseToolKeys is List<String>?
          ? grantedExpertiseToolKeys
          : this.grantedExpertiseToolKeys?.map((e0) => e0).toList(),
      requiredExistingSkill: requiredExistingSkill is _i6w9mv0m.Skill?
          ? requiredExistingSkill
          : this.requiredExistingSkill,
      requiredExistingToolKey: requiredExistingToolKey is String?
          ? requiredExistingToolKey
          : this.requiredExistingToolKey,
      requirements: requirements is List<_igf6e3qg.ChoiceRequirementData>?
          ? requirements
          : this.requirements?.map((e0) => e0.copyWith()).toList(),
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      grantedFeatureTags: grantedFeatureTags is List<_i47d6u5x.FeatureTag>?
          ? grantedFeatureTags
          : this.grantedFeatureTags?.map((e0) => e0).toList(),
      damageType: damageType is _iei1ksog.DamageType?
          ? damageType
          : this.damageType,
      areaOfEffectType: areaOfEffectType is _il0t2tw3.AreaOfEffectType?
          ? areaOfEffectType
          : this.areaOfEffectType,
      areaText: areaText is String? ? areaText : this.areaText,
      damageByLevel: damageByLevel is Map<String, String>?
          ? damageByLevel
          : this.damageByLevel?.map((key0, value0) => MapEntry(key0, value0)),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
