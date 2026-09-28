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
import '../../data/general/choice_group_data.dart' as _i2;
import '../../enums/skill.dart' as _i3;
import '../../enums/language.dart' as _i4;
import '../../enums/armor_category.dart' as _i5;
import '../../enums/weapon_category.dart' as _i6;
import '../../enums/feature_tag.dart' as _i7;
import '../../enums/damage_type.dart' as _i8;
import '../../enums/spell/area_of_effect_type.dart' as _i9;

abstract class ChoiceOptionData implements _i1.SerializableModel {
  ChoiceOptionData._({
    this.id,
    required this.choiceGroupId,
    this.choiceGroup,
    required this.optionKey,
    this.name,
    this.description,
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
    _i2.ChoiceGroupData? choiceGroup,
    required String optionKey,
    String? name,
    String? description,
    int? sortOrder,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i3.Skill>? grantedExpertiseSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    _i3.Skill? requiredExistingSkill,
    String? requiredExistingToolKey,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
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
          : _i2.ChoiceGroupData.fromJson(
              (jsonSerialization['choiceGroup'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      grantedAbilityBonuses:
          (jsonSerialization['grantedAbilityBonuses'] as Map?)
              ?.map((k, v) => MapEntry(
                    k as String,
                    v as int,
                  )),
      grantedSkills: (jsonSerialization['grantedSkills'] as List?)
          ?.map((e) => _i3.Skill.fromJson((e as String)))
          .toList(),
      grantedExpertiseSkills:
          (jsonSerialization['grantedExpertiseSkills'] as List?)
              ?.map((e) => _i3.Skill.fromJson((e as String)))
              .toList(),
      grantedLanguages: (jsonSerialization['grantedLanguages'] as List?)
          ?.map((e) => _i4.Language.fromJson((e as String)))
          .toList(),
      grantedArmorTraining: (jsonSerialization['grantedArmorTraining'] as List?)
          ?.map((e) => _i5.ArmorCategory.fromJson((e as String)))
          .toList(),
      grantedWeaponTraining:
          (jsonSerialization['grantedWeaponTraining'] as List?)
              ?.map((e) => _i6.WeaponCategory.fromJson((e as String)))
              .toList(),
      grantedToolKeys: (jsonSerialization['grantedToolKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedExpertiseToolKeys:
          (jsonSerialization['grantedExpertiseToolKeys'] as List?)
              ?.map((e) => e as String)
              .toList(),
      requiredExistingSkill: jsonSerialization['requiredExistingSkill'] == null
          ? null
          : _i3.Skill.fromJson(
              (jsonSerialization['requiredExistingSkill'] as String)),
      requiredExistingToolKey:
          jsonSerialization['requiredExistingToolKey'] as String?,
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedFeatureTags: (jsonSerialization['grantedFeatureTags'] as List?)
          ?.map((e) => _i7.FeatureTag.fromJson((e as String)))
          .toList(),
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i8.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _i9.AreaOfEffectType.fromJson(
              (jsonSerialization['areaOfEffectType'] as String)),
      areaText: jsonSerialization['areaText'] as String?,
      damageByLevel:
          (jsonSerialization['damageByLevel'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
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

  int choiceGroupId;

  _i2.ChoiceGroupData? choiceGroup;

  String optionKey;

  String? name;

  String? description;

  int? sortOrder;

  Map<String, int>? grantedAbilityBonuses;

  List<_i3.Skill>? grantedSkills;

  List<_i3.Skill>? grantedExpertiseSkills;

  List<_i4.Language>? grantedLanguages;

  List<_i5.ArmorCategory>? grantedArmorTraining;

  List<_i6.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedExpertiseToolKeys;

  _i3.Skill? requiredExistingSkill;

  String? requiredExistingToolKey;

  List<String>? grantedSpellKeys;

  List<_i7.FeatureTag>? grantedFeatureTags;

  _i8.DamageType? damageType;

  _i9.AreaOfEffectType? areaOfEffectType;

  String? areaText;

  Map<String, String>? damageByLevel;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChoiceOptionData copyWith({
    int? id,
    int? choiceGroupId,
    _i2.ChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i3.Skill>? grantedExpertiseSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    _i3.Skill? requiredExistingSkill,
    String? requiredExistingToolKey,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
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
      if (id != null) 'id': id,
      'choiceGroupId': choiceGroupId,
      if (choiceGroup != null) 'choiceGroup': choiceGroup?.toJson(),
      'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (grantedAbilityBonuses != null)
        'grantedAbilityBonuses': grantedAbilityBonuses?.toJson(),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedExpertiseSkills != null)
        'grantedExpertiseSkills':
            grantedExpertiseSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedLanguages != null)
        'grantedLanguages':
            grantedLanguages?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedArmorTraining != null)
        'grantedArmorTraining':
            grantedArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedWeaponTraining != null)
        'grantedWeaponTraining':
            grantedWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (grantedToolKeys != null) 'grantedToolKeys': grantedToolKeys?.toJson(),
      if (grantedExpertiseToolKeys != null)
        'grantedExpertiseToolKeys': grantedExpertiseToolKeys?.toJson(),
      if (requiredExistingSkill != null)
        'requiredExistingSkill': requiredExistingSkill?.toJson(),
      if (requiredExistingToolKey != null)
        'requiredExistingToolKey': requiredExistingToolKey,
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedFeatureTags != null)
        'grantedFeatureTags':
            grantedFeatureTags?.toJson(valueToJson: (v) => v.toJson()),
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceOptionDataImpl extends ChoiceOptionData {
  _ChoiceOptionDataImpl({
    int? id,
    required int choiceGroupId,
    _i2.ChoiceGroupData? choiceGroup,
    required String optionKey,
    String? name,
    String? description,
    int? sortOrder,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i3.Skill>? grantedExpertiseSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedExpertiseToolKeys,
    _i3.Skill? requiredExistingSkill,
    String? requiredExistingToolKey,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
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
  @_i1.useResult
  @override
  ChoiceOptionData copyWith({
    Object? id = _Undefined,
    int? choiceGroupId,
    Object? choiceGroup = _Undefined,
    String? optionKey,
    Object? name = _Undefined,
    Object? description = _Undefined,
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
      choiceGroup: choiceGroup is _i2.ChoiceGroupData?
          ? choiceGroup
          : this.choiceGroup?.copyWith(),
      optionKey: optionKey ?? this.optionKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      grantedAbilityBonuses: grantedAbilityBonuses is Map<String, int>?
          ? grantedAbilityBonuses
          : this.grantedAbilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      grantedSkills: grantedSkills is List<_i3.Skill>?
          ? grantedSkills
          : this.grantedSkills?.map((e0) => e0).toList(),
      grantedExpertiseSkills: grantedExpertiseSkills is List<_i3.Skill>?
          ? grantedExpertiseSkills
          : this.grantedExpertiseSkills?.map((e0) => e0).toList(),
      grantedLanguages: grantedLanguages is List<_i4.Language>?
          ? grantedLanguages
          : this.grantedLanguages?.map((e0) => e0).toList(),
      grantedArmorTraining: grantedArmorTraining is List<_i5.ArmorCategory>?
          ? grantedArmorTraining
          : this.grantedArmorTraining?.map((e0) => e0).toList(),
      grantedWeaponTraining: grantedWeaponTraining is List<_i6.WeaponCategory>?
          ? grantedWeaponTraining
          : this.grantedWeaponTraining?.map((e0) => e0).toList(),
      grantedToolKeys: grantedToolKeys is List<String>?
          ? grantedToolKeys
          : this.grantedToolKeys?.map((e0) => e0).toList(),
      grantedExpertiseToolKeys: grantedExpertiseToolKeys is List<String>?
          ? grantedExpertiseToolKeys
          : this.grantedExpertiseToolKeys?.map((e0) => e0).toList(),
      requiredExistingSkill: requiredExistingSkill is _i3.Skill?
          ? requiredExistingSkill
          : this.requiredExistingSkill,
      requiredExistingToolKey: requiredExistingToolKey is String?
          ? requiredExistingToolKey
          : this.requiredExistingToolKey,
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      grantedFeatureTags: grantedFeatureTags is List<_i7.FeatureTag>?
          ? grantedFeatureTags
          : this.grantedFeatureTags?.map((e0) => e0).toList(),
      damageType: damageType is _i8.DamageType? ? damageType : this.damageType,
      areaOfEffectType: areaOfEffectType is _i9.AreaOfEffectType?
          ? areaOfEffectType
          : this.areaOfEffectType,
      areaText: areaText is String? ? areaText : this.areaText,
      damageByLevel: damageByLevel is Map<String, String>?
          ? damageByLevel
          : this.damageByLevel?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
