/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../data/general/choice_group_data.dart' as _i2;
import '../../enums/skill.dart' as _i3;
import '../../enums/language.dart' as _i4;
import '../../enums/armor_category.dart' as _i5;
import '../../enums/weapon_category.dart' as _i6;
import '../../data/general/choice_requirement_data.dart' as _i7;
import '../../enums/feature_tag.dart' as _i8;
import '../../enums/damage_type.dart' as _i9;
import '../../enums/spell/area_of_effect_type.dart' as _i10;

abstract class ChoiceOptionData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    _i2.ChoiceGroupData? choiceGroup,
    required String optionKey,
    String? name,
    String? description,
    String? shortDescription,
    bool? automaticSelection,
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
    List<_i7.ChoiceRequirementData>? requirements,
    List<String>? grantedSpellKeys,
    List<_i8.FeatureTag>? grantedFeatureTags,
    _i9.DamageType? damageType,
    _i10.AreaOfEffectType? areaOfEffectType,
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
      shortDescription: jsonSerialization['shortDescription'] as String?,
      automaticSelection: jsonSerialization['automaticSelection'] as bool?,
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
      requirements: (jsonSerialization['requirements'] as List?)
          ?.map((e) =>
              _i7.ChoiceRequirementData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedFeatureTags: (jsonSerialization['grantedFeatureTags'] as List?)
          ?.map((e) => _i8.FeatureTag.fromJson((e as String)))
          .toList(),
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i9.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _i10.AreaOfEffectType.fromJson(
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

  static final t = ChoiceOptionDataTable();

  static const db = ChoiceOptionDataRepository._();

  @override
  int? id;

  int choiceGroupId;

  _i2.ChoiceGroupData? choiceGroup;

  String optionKey;

  String? name;

  String? description;

  String? shortDescription;

  bool? automaticSelection;

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

  List<_i7.ChoiceRequirementData>? requirements;

  List<String>? grantedSpellKeys;

  List<_i8.FeatureTag>? grantedFeatureTags;

  _i9.DamageType? damageType;

  _i10.AreaOfEffectType? areaOfEffectType;

  String? areaText;

  Map<String, String>? damageByLevel;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

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
    String? shortDescription,
    bool? automaticSelection,
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
    List<_i7.ChoiceRequirementData>? requirements,
    List<String>? grantedSpellKeys,
    List<_i8.FeatureTag>? grantedFeatureTags,
    _i9.DamageType? damageType,
    _i10.AreaOfEffectType? areaOfEffectType,
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
      if (shortDescription != null) 'shortDescription': shortDescription,
      if (automaticSelection != null) 'automaticSelection': automaticSelection,
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
      if (requirements != null)
        'requirements': requirements?.toJson(valueToJson: (v) => v.toJson()),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
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
      if (requirements != null)
        'requirements':
            requirements?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
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

  static ChoiceOptionDataInclude include(
      {_i2.ChoiceGroupDataInclude? choiceGroup}) {
    return ChoiceOptionDataInclude._(choiceGroup: choiceGroup);
  }

  static ChoiceOptionDataIncludeList includeList({
    _i1.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    ChoiceOptionDataInclude? include,
  }) {
    return ChoiceOptionDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChoiceOptionData.t),
      include: include,
    );
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
    String? shortDescription,
    bool? automaticSelection,
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
    List<_i7.ChoiceRequirementData>? requirements,
    List<String>? grantedSpellKeys,
    List<_i8.FeatureTag>? grantedFeatureTags,
    _i9.DamageType? damageType,
    _i10.AreaOfEffectType? areaOfEffectType,
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
  @_i1.useResult
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
      choiceGroup: choiceGroup is _i2.ChoiceGroupData?
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
      requirements: requirements is List<_i7.ChoiceRequirementData>?
          ? requirements
          : this.requirements?.map((e0) => e0.copyWith()).toList(),
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      grantedFeatureTags: grantedFeatureTags is List<_i8.FeatureTag>?
          ? grantedFeatureTags
          : this.grantedFeatureTags?.map((e0) => e0).toList(),
      damageType: damageType is _i9.DamageType? ? damageType : this.damageType,
      areaOfEffectType: areaOfEffectType is _i10.AreaOfEffectType?
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

class ChoiceOptionDataTable extends _i1.Table<int?> {
  ChoiceOptionDataTable({super.tableRelation})
      : super(tableName: 'choice_option_data') {
    choiceGroupId = _i1.ColumnInt(
      'choiceGroupId',
      this,
    );
    optionKey = _i1.ColumnString(
      'optionKey',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    shortDescription = _i1.ColumnString(
      'shortDescription',
      this,
    );
    automaticSelection = _i1.ColumnBool(
      'automaticSelection',
      this,
    );
    sortOrder = _i1.ColumnInt(
      'sortOrder',
      this,
    );
    grantedAbilityBonuses = _i1.ColumnSerializable(
      'grantedAbilityBonuses',
      this,
    );
    grantedSkills = _i1.ColumnSerializable(
      'grantedSkills',
      this,
    );
    grantedExpertiseSkills = _i1.ColumnSerializable(
      'grantedExpertiseSkills',
      this,
    );
    grantedLanguages = _i1.ColumnSerializable(
      'grantedLanguages',
      this,
    );
    grantedArmorTraining = _i1.ColumnSerializable(
      'grantedArmorTraining',
      this,
    );
    grantedWeaponTraining = _i1.ColumnSerializable(
      'grantedWeaponTraining',
      this,
    );
    grantedToolKeys = _i1.ColumnSerializable(
      'grantedToolKeys',
      this,
    );
    grantedExpertiseToolKeys = _i1.ColumnSerializable(
      'grantedExpertiseToolKeys',
      this,
    );
    requiredExistingSkill = _i1.ColumnEnum(
      'requiredExistingSkill',
      this,
      _i1.EnumSerialization.byName,
    );
    requiredExistingToolKey = _i1.ColumnString(
      'requiredExistingToolKey',
      this,
    );
    requirements = _i1.ColumnSerializable(
      'requirements',
      this,
    );
    grantedSpellKeys = _i1.ColumnSerializable(
      'grantedSpellKeys',
      this,
    );
    grantedFeatureTags = _i1.ColumnSerializable(
      'grantedFeatureTags',
      this,
    );
    damageType = _i1.ColumnEnum(
      'damageType',
      this,
      _i1.EnumSerialization.byName,
    );
    areaOfEffectType = _i1.ColumnEnum(
      'areaOfEffectType',
      this,
      _i1.EnumSerialization.byName,
    );
    areaText = _i1.ColumnString(
      'areaText',
      this,
    );
    damageByLevel = _i1.ColumnSerializable(
      'damageByLevel',
      this,
    );
    source = _i1.ColumnString(
      'source',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final _i1.ColumnInt choiceGroupId;

  _i2.ChoiceGroupDataTable? _choiceGroup;

  late final _i1.ColumnString optionKey;

  late final _i1.ColumnString name;

  late final _i1.ColumnString description;

  late final _i1.ColumnString shortDescription;

  late final _i1.ColumnBool automaticSelection;

  late final _i1.ColumnInt sortOrder;

  late final _i1.ColumnSerializable grantedAbilityBonuses;

  late final _i1.ColumnSerializable grantedSkills;

  late final _i1.ColumnSerializable grantedExpertiseSkills;

  late final _i1.ColumnSerializable grantedLanguages;

  late final _i1.ColumnSerializable grantedArmorTraining;

  late final _i1.ColumnSerializable grantedWeaponTraining;

  late final _i1.ColumnSerializable grantedToolKeys;

  late final _i1.ColumnSerializable grantedExpertiseToolKeys;

  late final _i1.ColumnEnum<_i3.Skill> requiredExistingSkill;

  late final _i1.ColumnString requiredExistingToolKey;

  late final _i1.ColumnSerializable requirements;

  late final _i1.ColumnSerializable grantedSpellKeys;

  late final _i1.ColumnSerializable grantedFeatureTags;

  late final _i1.ColumnEnum<_i9.DamageType> damageType;

  late final _i1.ColumnEnum<_i10.AreaOfEffectType> areaOfEffectType;

  late final _i1.ColumnString areaText;

  late final _i1.ColumnSerializable damageByLevel;

  late final _i1.ColumnString source;

  late final _i1.ColumnInt version;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  _i2.ChoiceGroupDataTable get choiceGroup {
    if (_choiceGroup != null) return _choiceGroup!;
    _choiceGroup = _i1.createRelationTable(
      relationFieldName: 'choiceGroup',
      field: ChoiceOptionData.t.choiceGroupId,
      foreignField: _i2.ChoiceGroupData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.ChoiceGroupDataTable(tableRelation: foreignTableRelation),
    );
    return _choiceGroup!;
  }

  @override
  List<_i1.Column> get columns => [
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
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'choiceGroup') {
      return choiceGroup;
    }
    return null;
  }
}

class ChoiceOptionDataInclude extends _i1.IncludeObject {
  ChoiceOptionDataInclude._({_i2.ChoiceGroupDataInclude? choiceGroup}) {
    _choiceGroup = choiceGroup;
  }

  _i2.ChoiceGroupDataInclude? _choiceGroup;

  @override
  Map<String, _i1.Include?> get includes => {'choiceGroup': _choiceGroup};

  @override
  _i1.Table<int?> get table => ChoiceOptionData.t;
}

class ChoiceOptionDataIncludeList extends _i1.IncludeList {
  ChoiceOptionDataIncludeList._({
    _i1.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChoiceOptionData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChoiceOptionData.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    ChoiceOptionDataInclude? include,
  }) async {
    return session.db.find<ChoiceOptionData>(
      where: where?.call(ChoiceOptionData.t),
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChoiceOptionDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChoiceOptionDataTable>? orderByList,
    _i1.Transaction? transaction,
    ChoiceOptionDataInclude? include,
  }) async {
    return session.db.findFirstRow<ChoiceOptionData>(
      where: where?.call(ChoiceOptionData.t),
      orderBy: orderBy?.call(ChoiceOptionData.t),
      orderByList: orderByList?.call(ChoiceOptionData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [ChoiceOptionData] by its [id] or null if no such row exists.
  Future<ChoiceOptionData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    ChoiceOptionDataInclude? include,
  }) async {
    return session.db.findById<ChoiceOptionData>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [ChoiceOptionData]s in the list and returns the inserted rows.
  ///
  /// The returned [ChoiceOptionData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<ChoiceOptionData>> insert(
    _i1.Session session,
    List<ChoiceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<ChoiceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [ChoiceOptionData] and returns the inserted row.
  ///
  /// The returned [ChoiceOptionData] will have its `id` field set.
  Future<ChoiceOptionData> insertRow(
    _i1.Session session,
    ChoiceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ChoiceOptionData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChoiceOptionData>> update(
    _i1.Session session,
    List<ChoiceOptionData> rows, {
    _i1.ColumnSelections<ChoiceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChoiceOptionData>(
      rows,
      columns: columns?.call(ChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChoiceOptionData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChoiceOptionData> updateRow(
    _i1.Session session,
    ChoiceOptionData row, {
    _i1.ColumnSelections<ChoiceOptionDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChoiceOptionData>(
      row,
      columns: columns?.call(ChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [ChoiceOptionData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChoiceOptionData>> delete(
    _i1.Session session,
    List<ChoiceOptionData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChoiceOptionData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ChoiceOptionData].
  Future<ChoiceOptionData> deleteRow(
    _i1.Session session,
    ChoiceOptionData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChoiceOptionData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChoiceOptionData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<ChoiceOptionDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChoiceOptionData>(
      where: where(ChoiceOptionData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<ChoiceOptionDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChoiceOptionData>(
      where: where?.call(ChoiceOptionData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class ChoiceOptionDataAttachRowRepository {
  const ChoiceOptionDataAttachRowRepository._();

  /// Creates a relation between the given [ChoiceOptionData] and [ChoiceGroupData]
  /// by setting the [ChoiceOptionData]'s foreign key `choiceGroupId` to refer to the [ChoiceGroupData].
  Future<void> choiceGroup(
    _i1.Session session,
    ChoiceOptionData choiceOptionData,
    _i2.ChoiceGroupData choiceGroup, {
    _i1.Transaction? transaction,
  }) async {
    if (choiceOptionData.id == null) {
      throw ArgumentError.notNull('choiceOptionData.id');
    }
    if (choiceGroup.id == null) {
      throw ArgumentError.notNull('choiceGroup.id');
    }

    var $choiceOptionData =
        choiceOptionData.copyWith(choiceGroupId: choiceGroup.id);
    await session.db.updateRow<ChoiceOptionData>(
      $choiceOptionData,
      columns: [ChoiceOptionData.t.choiceGroupId],
      transaction: transaction,
    );
  }
}
