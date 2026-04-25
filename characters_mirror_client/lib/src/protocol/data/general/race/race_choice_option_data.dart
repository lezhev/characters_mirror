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
import '../../../data/general/race/race_choice_set_data.dart' as _i2;
import '../../../enums/ability.dart' as _i3;
import '../../../enums/skill.dart' as _i4;
import '../../../enums/language.dart' as _i5;
import '../../../data/spell_data.dart' as _i6;
import '../../../data/feat_data.dart' as _i7;
import '../../../enums/damage_type.dart' as _i8;
import '../../../enums/spell/area_of_effect_type.dart' as _i9;
import '../../../enums/feature_tag.dart' as _i10;

abstract class RaceChoiceOptionData implements _i1.SerializableModel {
  RaceChoiceOptionData._({
    this.id,
    required this.choiceSetId,
    this.choiceSet,
    this.optionKey,
    this.name,
    this.description,
    this.sortOrder,
    this.ability,
    this.skill,
    this.language,
    this.spellId,
    this.spell,
    this.featId,
    this.feat,
    this.toolKey,
    this.bonusValue,
    this.damageType,
    this.areaOfEffectType,
    this.areaText,
    this.saveAbility,
    this.damageByLevel,
    this.grantedFeatureTags,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory RaceChoiceOptionData({
    int? id,
    required int choiceSetId,
    _i2.RaceChoiceSetData? choiceSet,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    _i3.Ability? ability,
    _i4.Skill? skill,
    _i5.Language? language,
    int? spellId,
    _i6.SpellData? spell,
    int? featId,
    _i7.FeatData? feat,
    String? toolKey,
    int? bonusValue,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    _i3.Ability? saveAbility,
    Map<String, String>? damageByLevel,
    List<_i10.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _RaceChoiceOptionDataImpl;

  factory RaceChoiceOptionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return RaceChoiceOptionData(
      id: jsonSerialization['id'] as int?,
      choiceSetId: jsonSerialization['choiceSetId'] as int,
      choiceSet: jsonSerialization['choiceSet'] == null
          ? null
          : _i2.RaceChoiceSetData.fromJson(
              (jsonSerialization['choiceSet'] as Map<String, dynamic>)),
      optionKey: jsonSerialization['optionKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      ability: jsonSerialization['ability'] == null
          ? null
          : _i3.Ability.fromJson((jsonSerialization['ability'] as String)),
      skill: jsonSerialization['skill'] == null
          ? null
          : _i4.Skill.fromJson((jsonSerialization['skill'] as String)),
      language: jsonSerialization['language'] == null
          ? null
          : _i5.Language.fromJson((jsonSerialization['language'] as String)),
      spellId: jsonSerialization['spellId'] as int?,
      spell: jsonSerialization['spell'] == null
          ? null
          : _i6.SpellData.fromJson(
              (jsonSerialization['spell'] as Map<String, dynamic>)),
      featId: jsonSerialization['featId'] as int?,
      feat: jsonSerialization['feat'] == null
          ? null
          : _i7.FeatData.fromJson(
              (jsonSerialization['feat'] as Map<String, dynamic>)),
      toolKey: jsonSerialization['toolKey'] as String?,
      bonusValue: jsonSerialization['bonusValue'] as int?,
      damageType: jsonSerialization['damageType'] == null
          ? null
          : _i8.DamageType.fromJson(
              (jsonSerialization['damageType'] as String)),
      areaOfEffectType: jsonSerialization['areaOfEffectType'] == null
          ? null
          : _i9.AreaOfEffectType.fromJson(
              (jsonSerialization['areaOfEffectType'] as String)),
      areaText: jsonSerialization['areaText'] as String?,
      saveAbility: jsonSerialization['saveAbility'] == null
          ? null
          : _i3.Ability.fromJson((jsonSerialization['saveAbility'] as String)),
      damageByLevel:
          (jsonSerialization['damageByLevel'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
      grantedFeatureTags: (jsonSerialization['grantedFeatureTags'] as List?)
          ?.map((e) => _i10.FeatureTag.fromJson((e as String)))
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

  int choiceSetId;

  _i2.RaceChoiceSetData? choiceSet;

  String? optionKey;

  String? name;

  String? description;

  int? sortOrder;

  _i3.Ability? ability;

  _i4.Skill? skill;

  _i5.Language? language;

  int? spellId;

  _i6.SpellData? spell;

  int? featId;

  _i7.FeatData? feat;

  String? toolKey;

  int? bonusValue;

  _i8.DamageType? damageType;

  _i9.AreaOfEffectType? areaOfEffectType;

  String? areaText;

  _i3.Ability? saveAbility;

  Map<String, String>? damageByLevel;

  List<_i10.FeatureTag>? grantedFeatureTags;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [RaceChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RaceChoiceOptionData copyWith({
    int? id,
    int? choiceSetId,
    _i2.RaceChoiceSetData? choiceSet,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    _i3.Ability? ability,
    _i4.Skill? skill,
    _i5.Language? language,
    int? spellId,
    _i6.SpellData? spell,
    int? featId,
    _i7.FeatData? feat,
    String? toolKey,
    int? bonusValue,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    _i3.Ability? saveAbility,
    Map<String, String>? damageByLevel,
    List<_i10.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'choiceSetId': choiceSetId,
      if (choiceSet != null) 'choiceSet': choiceSet?.toJson(),
      if (optionKey != null) 'optionKey': optionKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (sortOrder != null) 'sortOrder': sortOrder,
      if (ability != null) 'ability': ability?.toJson(),
      if (skill != null) 'skill': skill?.toJson(),
      if (language != null) 'language': language?.toJson(),
      if (spellId != null) 'spellId': spellId,
      if (spell != null) 'spell': spell?.toJson(),
      if (featId != null) 'featId': featId,
      if (feat != null) 'feat': feat?.toJson(),
      if (toolKey != null) 'toolKey': toolKey,
      if (bonusValue != null) 'bonusValue': bonusValue,
      if (damageType != null) 'damageType': damageType?.toJson(),
      if (areaOfEffectType != null)
        'areaOfEffectType': areaOfEffectType?.toJson(),
      if (areaText != null) 'areaText': areaText,
      if (saveAbility != null) 'saveAbility': saveAbility?.toJson(),
      if (damageByLevel != null) 'damageByLevel': damageByLevel?.toJson(),
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

class _RaceChoiceOptionDataImpl extends RaceChoiceOptionData {
  _RaceChoiceOptionDataImpl({
    int? id,
    required int choiceSetId,
    _i2.RaceChoiceSetData? choiceSet,
    String? optionKey,
    String? name,
    String? description,
    int? sortOrder,
    _i3.Ability? ability,
    _i4.Skill? skill,
    _i5.Language? language,
    int? spellId,
    _i6.SpellData? spell,
    int? featId,
    _i7.FeatData? feat,
    String? toolKey,
    int? bonusValue,
    _i8.DamageType? damageType,
    _i9.AreaOfEffectType? areaOfEffectType,
    String? areaText,
    _i3.Ability? saveAbility,
    Map<String, String>? damageByLevel,
    List<_i10.FeatureTag>? grantedFeatureTags,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
          id: id,
          choiceSetId: choiceSetId,
          choiceSet: choiceSet,
          optionKey: optionKey,
          name: name,
          description: description,
          sortOrder: sortOrder,
          ability: ability,
          skill: skill,
          language: language,
          spellId: spellId,
          spell: spell,
          featId: featId,
          feat: feat,
          toolKey: toolKey,
          bonusValue: bonusValue,
          damageType: damageType,
          areaOfEffectType: areaOfEffectType,
          areaText: areaText,
          saveAbility: saveAbility,
          damageByLevel: damageByLevel,
          grantedFeatureTags: grantedFeatureTags,
          source: source,
          version: version,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RaceChoiceOptionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RaceChoiceOptionData copyWith({
    Object? id = _Undefined,
    int? choiceSetId,
    Object? choiceSet = _Undefined,
    Object? optionKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? sortOrder = _Undefined,
    Object? ability = _Undefined,
    Object? skill = _Undefined,
    Object? language = _Undefined,
    Object? spellId = _Undefined,
    Object? spell = _Undefined,
    Object? featId = _Undefined,
    Object? feat = _Undefined,
    Object? toolKey = _Undefined,
    Object? bonusValue = _Undefined,
    Object? damageType = _Undefined,
    Object? areaOfEffectType = _Undefined,
    Object? areaText = _Undefined,
    Object? saveAbility = _Undefined,
    Object? damageByLevel = _Undefined,
    Object? grantedFeatureTags = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return RaceChoiceOptionData(
      id: id is int? ? id : this.id,
      choiceSetId: choiceSetId ?? this.choiceSetId,
      choiceSet: choiceSet is _i2.RaceChoiceSetData?
          ? choiceSet
          : this.choiceSet?.copyWith(),
      optionKey: optionKey is String? ? optionKey : this.optionKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      sortOrder: sortOrder is int? ? sortOrder : this.sortOrder,
      ability: ability is _i3.Ability? ? ability : this.ability,
      skill: skill is _i4.Skill? ? skill : this.skill,
      language: language is _i5.Language? ? language : this.language,
      spellId: spellId is int? ? spellId : this.spellId,
      spell: spell is _i6.SpellData? ? spell : this.spell?.copyWith(),
      featId: featId is int? ? featId : this.featId,
      feat: feat is _i7.FeatData? ? feat : this.feat?.copyWith(),
      toolKey: toolKey is String? ? toolKey : this.toolKey,
      bonusValue: bonusValue is int? ? bonusValue : this.bonusValue,
      damageType: damageType is _i8.DamageType? ? damageType : this.damageType,
      areaOfEffectType: areaOfEffectType is _i9.AreaOfEffectType?
          ? areaOfEffectType
          : this.areaOfEffectType,
      areaText: areaText is String? ? areaText : this.areaText,
      saveAbility: saveAbility is _i3.Ability? ? saveAbility : this.saveAbility,
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
      grantedFeatureTags: grantedFeatureTags is List<_i10.FeatureTag>?
          ? grantedFeatureTags
          : this.grantedFeatureTags?.map((e0) => e0).toList(),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
