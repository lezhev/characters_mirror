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
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _ikmnmw29.Protocol().deserialize<_iz5y1q0y.ChoiceGroupData>(
              jsonSerialization['choiceGroup'],
            ),
      optionKey: jsonSerialization['optionKey'] as String,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      shortDescription: jsonSerialization['shortDescription'] as String?,
      automaticSelection: jsonSerialization['automaticSelection'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['automaticSelection'],
            ),
      sortOrder: jsonSerialization['sortOrder'] as int?,
      grantedAbilityBonuses: jsonSerialization['grantedAbilityBonuses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['grantedAbilityBonuses'],
            ),
      grantedSkills: jsonSerialization['grantedSkills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i6w9mv0m.Skill>>(
              jsonSerialization['grantedSkills'],
            ),
      grantedExpertiseSkills:
          jsonSerialization['grantedExpertiseSkills'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i6w9mv0m.Skill>>(
              jsonSerialization['grantedExpertiseSkills'],
            ),
      grantedLanguages: jsonSerialization['grantedLanguages'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iuo43pdt.Language>>(
              jsonSerialization['grantedLanguages'],
            ),
      grantedArmorTraining: jsonSerialization['grantedArmorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ixuui93s.ArmorCategory>>(
              jsonSerialization['grantedArmorTraining'],
            ),
      grantedWeaponTraining: jsonSerialization['grantedWeaponTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iya6mjd5.WeaponCategory>>(
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
      requiredExistingSkill: jsonSerialization['requiredExistingSkill'] == null
          ? null
          : _i6w9mv0m.Skill.fromJson(
              (jsonSerialization['requiredExistingSkill'] as String),
            ),
      requiredExistingToolKey:
          jsonSerialization['requiredExistingToolKey'] as String?,
      requirements: jsonSerialization['requirements'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_igf6e3qg.ChoiceRequirementData>>(
                  jsonSerialization['requirements'],
                ),
      grantedSpellKeys: jsonSerialization['grantedSpellKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedSpellKeys'],
            ),
      grantedFeatureTags: jsonSerialization['grantedFeatureTags'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i47d6u5x.FeatureTag>>(
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
          : _ikmnmw29.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['damageByLevel'],
            ),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ChoiceOptionDataTable();

  static const db = ChoiceOptionDataRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ChoiceOptionDataInclude include({
    _iz5y1q0y.ChoiceGroupDataInclude? choiceGroup,
  }) {
    return ChoiceOptionDataInclude._(choiceGroup: choiceGroup);
  }

  static ChoiceOptionDataIncludeList includeList({
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    ChoiceOptionDataInclude? include,
  }) {
    return ChoiceOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ChoiceOptionDataUpdateTable
    extends _is.UpdateTable<ChoiceOptionDataTable> {
  ChoiceOptionDataUpdateTable(super.table);

  _is.ColumnValue<int, int> choiceGroupId(int value) =>
      _is.ColumnValue(table.choiceGroupId, value);

  _is.ColumnValue<String, String> optionKey(String value) =>
      _is.ColumnValue(table.optionKey, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<String, String> shortDescription(String? value) =>
      _is.ColumnValue(table.shortDescription, value);

  _is.ColumnValue<bool, bool> automaticSelection(bool? value) =>
      _is.ColumnValue(table.automaticSelection, value);

  _is.ColumnValue<int, int> sortOrder(int? value) =>
      _is.ColumnValue(table.sortOrder, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> grantedAbilityBonuses(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.grantedAbilityBonuses, value);

  _is.ColumnValue<List<_i6w9mv0m.Skill>, List<_i6w9mv0m.Skill>> grantedSkills(
    List<_i6w9mv0m.Skill>? value,
  ) => _is.ColumnValue(table.grantedSkills, value);

  _is.ColumnValue<List<_i6w9mv0m.Skill>, List<_i6w9mv0m.Skill>>
  grantedExpertiseSkills(List<_i6w9mv0m.Skill>? value) =>
      _is.ColumnValue(table.grantedExpertiseSkills, value);

  _is.ColumnValue<List<_iuo43pdt.Language>, List<_iuo43pdt.Language>>
  grantedLanguages(List<_iuo43pdt.Language>? value) =>
      _is.ColumnValue(table.grantedLanguages, value);

  _is.ColumnValue<List<_ixuui93s.ArmorCategory>, List<_ixuui93s.ArmorCategory>>
  grantedArmorTraining(List<_ixuui93s.ArmorCategory>? value) =>
      _is.ColumnValue(table.grantedArmorTraining, value);

  _is.ColumnValue<
    List<_iya6mjd5.WeaponCategory>,
    List<_iya6mjd5.WeaponCategory>
  >
  grantedWeaponTraining(List<_iya6mjd5.WeaponCategory>? value) =>
      _is.ColumnValue(table.grantedWeaponTraining, value);

  _is.ColumnValue<List<String>, List<String>> grantedToolKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.grantedToolKeys, value);

  _is.ColumnValue<List<String>, List<String>> grantedExpertiseToolKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.grantedExpertiseToolKeys, value);

  _is.ColumnValue<_i6w9mv0m.Skill, _i6w9mv0m.Skill> requiredExistingSkill(
    _i6w9mv0m.Skill? value,
  ) => _is.ColumnValue(table.requiredExistingSkill, value);

  _is.ColumnValue<String, String> requiredExistingToolKey(String? value) =>
      _is.ColumnValue(table.requiredExistingToolKey, value);

  _is.ColumnValue<
    List<_igf6e3qg.ChoiceRequirementData>,
    List<_igf6e3qg.ChoiceRequirementData>
  >
  requirements(List<_igf6e3qg.ChoiceRequirementData>? value) =>
      _is.ColumnValue(table.requirements, value);

  _is.ColumnValue<List<String>, List<String>> grantedSpellKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.grantedSpellKeys, value);

  _is.ColumnValue<List<_i47d6u5x.FeatureTag>, List<_i47d6u5x.FeatureTag>>
  grantedFeatureTags(List<_i47d6u5x.FeatureTag>? value) =>
      _is.ColumnValue(table.grantedFeatureTags, value);

  _is.ColumnValue<_iei1ksog.DamageType, _iei1ksog.DamageType> damageType(
    _iei1ksog.DamageType? value,
  ) => _is.ColumnValue(table.damageType, value);

  _is.ColumnValue<_il0t2tw3.AreaOfEffectType, _il0t2tw3.AreaOfEffectType>
  areaOfEffectType(_il0t2tw3.AreaOfEffectType? value) =>
      _is.ColumnValue(table.areaOfEffectType, value);

  _is.ColumnValue<String, String> areaText(String? value) =>
      _is.ColumnValue(table.areaText, value);

  _is.ColumnValue<Map<String, String>, Map<String, String>> damageByLevel(
    Map<String, String>? value,
  ) => _is.ColumnValue(table.damageByLevel, value);

  _is.ColumnValue<String, String> source(String? value) =>
      _is.ColumnValue(table.source, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);
}

class ChoiceOptionDataTable extends _is.Table<int?> {
  ChoiceOptionDataTable({super.tableRelation})
    : super(tableName: 'choice_option_data') {
    updateTable = ChoiceOptionDataUpdateTable(this);
    choiceGroupId = _is.ColumnInt('choiceGroupId', this);
    optionKey = _is.ColumnString('optionKey', this);
    name = _is.ColumnString('name', this);
    description = _is.ColumnString('description', this);
    shortDescription = _is.ColumnString('shortDescription', this);
    automaticSelection = _is.ColumnBool('automaticSelection', this);
    sortOrder = _is.ColumnInt('sortOrder', this);
    grantedAbilityBonuses = _is.ColumnSerializable<Map<String, int>>(
      'grantedAbilityBonuses',
      this,
    );
    grantedSkills = _is.ColumnSerializable<List<_i6w9mv0m.Skill>>(
      'grantedSkills',
      this,
    );
    grantedExpertiseSkills = _is.ColumnSerializable<List<_i6w9mv0m.Skill>>(
      'grantedExpertiseSkills',
      this,
    );
    grantedLanguages = _is.ColumnSerializable<List<_iuo43pdt.Language>>(
      'grantedLanguages',
      this,
    );
    grantedArmorTraining =
        _is.ColumnSerializable<List<_ixuui93s.ArmorCategory>>(
          'grantedArmorTraining',
          this,
        );
    grantedWeaponTraining =
        _is.ColumnSerializable<List<_iya6mjd5.WeaponCategory>>(
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
    requiredExistingSkill = _is.ColumnEnum(
      'requiredExistingSkill',
      this,
      _is.EnumSerialization.byName,
    );
    requiredExistingToolKey = _is.ColumnString('requiredExistingToolKey', this);
    requirements =
        _is.ColumnSerializable<List<_igf6e3qg.ChoiceRequirementData>>(
          'requirements',
          this,
        );
    grantedSpellKeys = _is.ColumnSerializable<List<String>>(
      'grantedSpellKeys',
      this,
    );
    grantedFeatureTags = _is.ColumnSerializable<List<_i47d6u5x.FeatureTag>>(
      'grantedFeatureTags',
      this,
    );
    damageType = _is.ColumnEnum(
      'damageType',
      this,
      _is.EnumSerialization.byName,
    );
    areaOfEffectType = _is.ColumnEnum(
      'areaOfEffectType',
      this,
      _is.EnumSerialization.byName,
    );
    areaText = _is.ColumnString('areaText', this);
    damageByLevel = _is.ColumnSerializable<Map<String, String>>(
      'damageByLevel',
      this,
    );
    source = _is.ColumnString('source', this);
    version = _is.ColumnInt('version', this);
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
  }

  late final ChoiceOptionDataUpdateTable updateTable;

  late final _is.ColumnInt choiceGroupId;

  _iz5y1q0y.ChoiceGroupDataTable? _choiceGroup;

  late final _is.ColumnString optionKey;

  late final _is.ColumnString name;

  late final _is.ColumnString description;

  late final _is.ColumnString shortDescription;

  late final _is.ColumnBool automaticSelection;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnSerializable<Map<String, int>> grantedAbilityBonuses;

  late final _is.ColumnSerializable<List<_i6w9mv0m.Skill>> grantedSkills;

  late final _is.ColumnSerializable<List<_i6w9mv0m.Skill>>
  grantedExpertiseSkills;

  late final _is.ColumnSerializable<List<_iuo43pdt.Language>> grantedLanguages;

  late final _is.ColumnSerializable<List<_ixuui93s.ArmorCategory>>
  grantedArmorTraining;

  late final _is.ColumnSerializable<List<_iya6mjd5.WeaponCategory>>
  grantedWeaponTraining;

  late final _is.ColumnSerializable<List<String>> grantedToolKeys;

  late final _is.ColumnSerializable<List<String>> grantedExpertiseToolKeys;

  late final _is.ColumnEnum<_i6w9mv0m.Skill> requiredExistingSkill;

  late final _is.ColumnString requiredExistingToolKey;

  late final _is.ColumnSerializable<List<_igf6e3qg.ChoiceRequirementData>>
  requirements;

  late final _is.ColumnSerializable<List<String>> grantedSpellKeys;

  late final _is.ColumnSerializable<List<_i47d6u5x.FeatureTag>>
  grantedFeatureTags;

  late final _is.ColumnEnum<_iei1ksog.DamageType> damageType;

  late final _is.ColumnEnum<_il0t2tw3.AreaOfEffectType> areaOfEffectType;

  late final _is.ColumnString areaText;

  late final _is.ColumnSerializable<Map<String, String>> damageByLevel;

  late final _is.ColumnString source;

  late final _is.ColumnInt version;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  _iz5y1q0y.ChoiceGroupDataTable get choiceGroup {
    if (_choiceGroup != null) return _choiceGroup!;
    _choiceGroup = _is.createRelationTable(
      relationFieldName: 'choiceGroup',
      field: ChoiceOptionData.t.choiceGroupId,
      foreignField: _iz5y1q0y.ChoiceGroupData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iz5y1q0y.ChoiceGroupDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceGroup!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    choiceGroupId,
    optionKey,
    name,
    description,
    shortDescription,
    automaticSelection,
    sortOrder,
    grantedAbilityBonuses,
    grantedSkills,
    grantedExpertiseSkills,
    grantedLanguages,
    grantedArmorTraining,
    grantedWeaponTraining,
    grantedToolKeys,
    grantedExpertiseToolKeys,
    requiredExistingSkill,
    requiredExistingToolKey,
    requirements,
    grantedSpellKeys,
    grantedFeatureTags,
    damageType,
    areaOfEffectType,
    areaText,
    damageByLevel,
    source,
    version,
    createdAt,
    updatedAt,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'choiceGroup') {
      return choiceGroup;
    }
    return null;
  }
}

class ChoiceOptionDataInclude extends _is.IncludeObject {
  ChoiceOptionDataInclude._({_iz5y1q0y.ChoiceGroupDataInclude? choiceGroup}) {
    _choiceGroup = choiceGroup;
  }

  _iz5y1q0y.ChoiceGroupDataInclude? _choiceGroup;

  @override
  Map<String, _is.Include?> get includes => {'choiceGroup': _choiceGroup};

  @override
  _is.Table<int?> get table => ChoiceOptionData.t;
}

class ChoiceOptionDataIncludeList extends _is.IncludeList {
  ChoiceOptionDataIncludeList._({
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChoiceOptionData.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ChoiceOptionData.t;
}

class ChoiceOptionDataRepository {
  const ChoiceOptionDataRepository._();

  final attachRow = const ChoiceOptionDataAttachRowRepository._();

  /// Returns a list of [ChoiceOptionData]s matching the given query parameters.
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
  Future<List<ChoiceOptionData>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _is.Transaction? transaction,
    ChoiceOptionDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChoiceOptionData>(
      where: where?.call(ChoiceOptionData.t),
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChoiceOptionData] matching the given query parameters.
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
  Future<ChoiceOptionData?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? offset,
    _is.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _is.Transaction? transaction,
    ChoiceOptionDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChoiceOptionData>(
      where: where?.call(ChoiceOptionData.t),
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChoiceOptionData] by its [id] or null if no such row exists.
  Future<ChoiceOptionData?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    ChoiceOptionDataInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChoiceOptionData>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChoiceOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [ChoiceOptionData]s will have their `id` fields set.
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
  Future<List<ChoiceOptionData>> insert(
    _is.DatabaseSession session,
    List<ChoiceOptionData> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ChoiceOptionData>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ChoiceOptionData] and returns the inserted row.
  ///
  /// The returned [ChoiceOptionData] will have its `id` field set.
  Future<ChoiceOptionData> insertRow(
    _is.DatabaseSession session,
    ChoiceOptionData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ChoiceOptionData]s in the list and returns the resulting rows.
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
  /// The returned [ChoiceOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceOptionData>> upsert(
    _is.DatabaseSession session,
    List<ChoiceOptionData> rows, {
    required _is.ColumnSelections<ChoiceOptionDataTable> conflictColumns,
    _is.ColumnSelections<ChoiceOptionDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ChoiceOptionData>(
      rows,
      conflictColumns: conflictColumns(ChoiceOptionData.t),
      updateColumns: updateColumns?.call(ChoiceOptionData.t),
      updateWhere: updateWhere?.call(ChoiceOptionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ChoiceOptionData] and returns the resulting row.
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
  /// The returned [ChoiceOptionData] will have its `id` field set.
  Future<ChoiceOptionData?> upsertRow(
    _is.DatabaseSession session,
    ChoiceOptionData row, {
    required _is.ColumnSelections<ChoiceOptionDataTable> conflictColumns,
    _is.ColumnSelections<ChoiceOptionDataTable>? updateColumns,
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ChoiceOptionData>(
      row,
      conflictColumns: conflictColumns(ChoiceOptionData.t),
      updateColumns: updateColumns?.call(ChoiceOptionData.t),
      updateWhere: updateWhere?.call(ChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates all [ChoiceOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceOptionData>> update(
    _is.DatabaseSession session,
    List<ChoiceOptionData> rows, {
    _is.ColumnSelections<ChoiceOptionDataTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ChoiceOptionData>(
      rows,
      columns: columns?.call(ChoiceOptionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ChoiceOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChoiceOptionData> updateRow(
    _is.DatabaseSession session,
    ChoiceOptionData row, {
    _is.ColumnSelections<ChoiceOptionDataTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChoiceOptionData>(
      row,
      columns: columns?.call(ChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChoiceOptionData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChoiceOptionData?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ChoiceOptionDataUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ChoiceOptionData>(
      id,
      columnValues: columnValues(ChoiceOptionData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChoiceOptionData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ChoiceOptionData>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ChoiceOptionDataUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<ChoiceOptionDataTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ChoiceOptionData>(
      columnValues: columnValues(ChoiceOptionData.t.updateTable),
      where: where(ChoiceOptionData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ChoiceOptionData]s in the list and returns the deleted rows.
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
  Future<List<ChoiceOptionData>> delete(
    _is.DatabaseSession session,
    List<ChoiceOptionData> rows, {
    _is.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ChoiceOptionData>(
      rows,
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ChoiceOptionData].
  Future<ChoiceOptionData> deleteRow(
    _is.DatabaseSession session,
    ChoiceOptionData row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChoiceOptionData>(
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
  Future<List<ChoiceOptionData>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChoiceOptionDataTable> where,
    _is.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    _is.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ChoiceOptionData>(
      where: where(ChoiceOptionData.t),
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ChoiceOptionData>(
      where: where?.call(ChoiceOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChoiceOptionData] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ChoiceOptionDataTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChoiceOptionData>(
      where: where(ChoiceOptionData.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ChoiceOptionDataAttachRowRepository {
  const ChoiceOptionDataAttachRowRepository._();

  /// Creates a relation between the given [ChoiceOptionData] and [ChoiceGroupData]
  /// by setting the [ChoiceOptionData]'s foreign key `choiceGroupId` to refer to the [ChoiceGroupData].
  Future<void> choiceGroup(
    _is.DatabaseSession session,
    ChoiceOptionData choiceOptionData,
    _iz5y1q0y.ChoiceGroupData choiceGroup, {
    _is.Transaction? transaction,
  }) async {
    if (choiceOptionData.id == null) {
      throw ArgumentError.notNull('choiceOptionData.id');
    }
    if (choiceGroup.id == null) {
      throw ArgumentError.notNull('choiceGroup.id');
    }

    var $choiceOptionData = choiceOptionData.copyWith(
      choiceGroupId: choiceGroup.id,
    );
    await session.db.updateRow<ChoiceOptionData>(
      $choiceOptionData,
      columns: [ChoiceOptionData.t.choiceGroupId],
      transaction: transaction,
    );
  }
}
