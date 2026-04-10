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
import '../../../data/general/class/class_choice_group_data.dart' as _i2;
import '../../../enums/skill.dart' as _i3;
import '../../../enums/language.dart' as _i4;
import '../../../enums/armor_category.dart' as _i5;
import '../../../enums/weapon_category.dart' as _i6;
import '../../../enums/feature_tag.dart' as _i7;

abstract class ClassChoiceOptionData implements _i1.SerializableModel {
  ClassChoiceOptionData._({
    this.id,
    required this.choiceGroupId,
    this.choiceGroup,
    this.optionKey,
    this.name,
    this.description,
    this.grantedAbilityBonuses,
    this.grantedSkills,
    this.grantedLanguages,
    this.grantedArmorTraining,
    this.grantedWeaponTraining,
    this.grantedToolKeys,
    this.grantedSpellKeys,
    this.grantedFeatureTags,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory ClassChoiceOptionData({
    int? id,
    required int choiceGroupId,
    _i2.ClassChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ClassChoiceOptionDataImpl;

  factory ClassChoiceOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ClassChoiceOptionData(
      id: jsonSerialization['id'] as int?,
      choiceGroupId: jsonSerialization['choiceGroupId'] as int,
      choiceGroup: jsonSerialization['choiceGroup'] == null
          ? null
          : _i2.ClassChoiceGroupData.fromJson(
              (jsonSerialization['choiceGroup'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      grantedAbilityBonuses:
          (jsonSerialization['grantedAbilityBonuses'] as Map?)
              ?.map((k, v) => MapEntry(
                    k as String,
                    v as int,
                  )),
      grantedSkills: (jsonSerialization['grantedSkills'] as List?)
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
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedFeatureTags: (jsonSerialization['grantedFeatureTags'] as List?)
          ?.map((e) => _i7.FeatureTag.fromJson((e as String)))
          .toList(),
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

  _i2.ClassChoiceGroupData? choiceGroup;

  String? optionKey;

  String? name;

  String? description;

  Map<String, int>? grantedAbilityBonuses;

  List<_i3.Skill>? grantedSkills;

  List<_i4.Language>? grantedLanguages;

  List<_i5.ArmorCategory>? grantedArmorTraining;

  List<_i6.WeaponCategory>? grantedWeaponTraining;

  List<String>? grantedToolKeys;

  List<String>? grantedSpellKeys;

  List<_i7.FeatureTag>? grantedFeatureTags;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [ClassChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassChoiceOptionData copyWith({
    int? id,
    int? choiceGroupId,
    _i2.ClassChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
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
      if (optionKey != null) 'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (grantedAbilityBonuses != null)
        'grantedAbilityBonuses': grantedAbilityBonuses?.toJson(),
      if (grantedSkills != null)
        'grantedSkills': grantedSkills?.toJson(valueToJson: (v) => v.toJson()),
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
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedFeatureTags != null)
        'grantedFeatureTags':
            grantedFeatureTags?.toJson(valueToJson: (v) => v.toJson()),
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

class _ClassChoiceOptionDataImpl extends ClassChoiceOptionData {
  _ClassChoiceOptionDataImpl({
    int? id,
    required int choiceGroupId,
    _i2.ClassChoiceGroupData? choiceGroup,
    String? optionKey,
    String? name,
    String? description,
    Map<String, int>? grantedAbilityBonuses,
    List<_i3.Skill>? grantedSkills,
    List<_i4.Language>? grantedLanguages,
    List<_i5.ArmorCategory>? grantedArmorTraining,
    List<_i6.WeaponCategory>? grantedWeaponTraining,
    List<String>? grantedToolKeys,
    List<String>? grantedSpellKeys,
    List<_i7.FeatureTag>? grantedFeatureTags,
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
          grantedAbilityBonuses: grantedAbilityBonuses,
          grantedSkills: grantedSkills,
          grantedLanguages: grantedLanguages,
          grantedArmorTraining: grantedArmorTraining,
          grantedWeaponTraining: grantedWeaponTraining,
          grantedToolKeys: grantedToolKeys,
          grantedSpellKeys: grantedSpellKeys,
          grantedFeatureTags: grantedFeatureTags,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ClassChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassChoiceOptionData copyWith({
    Object? id = _Undefined,
    int? choiceGroupId,
    Object? choiceGroup = _Undefined,
    Object? optionKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? grantedAbilityBonuses = _Undefined,
    Object? grantedSkills = _Undefined,
    Object? grantedLanguages = _Undefined,
    Object? grantedArmorTraining = _Undefined,
    Object? grantedWeaponTraining = _Undefined,
    Object? grantedToolKeys = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? grantedFeatureTags = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return ClassChoiceOptionData(
      id: id is int? ? id : this.id,
      choiceGroupId: choiceGroupId ?? this.choiceGroupId,
      choiceGroup: choiceGroup is _i2.ClassChoiceGroupData?
          ? choiceGroup
          : this.choiceGroup?.copyWith(),
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
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
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      grantedFeatureTags: grantedFeatureTags is List<_i7.FeatureTag>?
          ? grantedFeatureTags
          : this.grantedFeatureTags?.map((e0) => e0).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
