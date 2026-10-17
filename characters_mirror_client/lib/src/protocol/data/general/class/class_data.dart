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
import '../../../data/general/spell_selection_filter_data.dart' as _iv73j5oi;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/class_spell_selection_mode.dart' as _iax70tek;
import '../../../enums/skill.dart' as _iqrhamom;
import '../../../enums/spellcasting_progression.dart' as _if4imcqg;

abstract class ClassData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ClassData._({
    this.id,
    this.spellSelectionFilter,
    this.referenceKey,
    this.name,
    this.description,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.hitDieValue,
    this.primaryAbilities,
    this.savingThrowProficiencies,
    this.armorTraining,
    this.weaponTraining,
    this.toolTrainingKeys,
    this.availableSkills,
    this.skillCount,
    this.subclassChoiceLevel,
    this.subclassChoiceFeatureId,
    this.spellcastingProgression,
    this.spellSelectionMode,
    this.spellcastingAbilityValue,
    this.multiclassPrerequisites,
    this.multiclassArmorTraining,
    this.multiclassWeaponTraining,
    this.multiclassToolTrainingKeys,
    this.imageURL,
  });

  factory ClassData({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_iw3bk51e.Ability>? primaryAbilities,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<String>? weaponTraining,
    List<String>? toolTrainingKeys,
    List<_iqrhamom.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    int? subclassChoiceFeatureId,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_irzuusaf.ArmorCategory>? multiclassArmorTraining,
    List<String>? multiclassWeaponTraining,
    List<String>? multiclassToolTrainingKeys,
    String? imageURL,
  }) = _ClassDataImpl;

  factory ClassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassData(
      id: jsonSerialization['id'] as int?,
      spellSelectionFilter: jsonSerialization['spellSelectionFilter'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<_iv73j5oi.SpellSelectionFilterData>(
                  jsonSerialization['spellSelectionFilter'],
                ),
      referenceKey: jsonSerialization['referenceKey'] as String?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      hitDieValue: jsonSerialization['hitDieValue'] as int?,
      primaryAbilities: jsonSerialization['primaryAbilities'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['primaryAbilities'],
            ),
      savingThrowProficiencies:
          jsonSerialization['savingThrowProficiencies'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['savingThrowProficiencies'],
            ),
      armorTraining: jsonSerialization['armorTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['armorTraining'],
            ),
      weaponTraining: jsonSerialization['weaponTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['weaponTraining'],
            ),
      toolTrainingKeys: jsonSerialization['toolTrainingKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['toolTrainingKeys'],
            ),
      availableSkills: jsonSerialization['availableSkills'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_iqrhamom.Skill>>(
              jsonSerialization['availableSkills'],
            ),
      skillCount: jsonSerialization['skillCount'] as int?,
      subclassChoiceLevel: jsonSerialization['subclassChoiceLevel'] as int?,
      subclassChoiceFeatureId:
          jsonSerialization['subclassChoiceFeatureId'] as int?,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] == null
          ? null
          : _if4imcqg.SpellcastingProgression.fromJson(
              (jsonSerialization['spellcastingProgression'] as String),
            ),
      spellSelectionMode: jsonSerialization['spellSelectionMode'] == null
          ? null
          : _iax70tek.ClassSpellSelectionMode.fromJson(
              (jsonSerialization['spellSelectionMode'] as String),
            ),
      spellcastingAbilityValue:
          jsonSerialization['spellcastingAbilityValue'] == null
          ? null
          : _iw3bk51e.Ability.fromJson(
              (jsonSerialization['spellcastingAbilityValue'] as String),
            ),
      multiclassPrerequisites:
          jsonSerialization['multiclassPrerequisites'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['multiclassPrerequisites'],
            ),
      multiclassArmorTraining:
          jsonSerialization['multiclassArmorTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['multiclassArmorTraining'],
            ),
      multiclassWeaponTraining:
          jsonSerialization['multiclassWeaponTraining'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['multiclassWeaponTraining'],
            ),
      multiclassToolTrainingKeys:
          jsonSerialization['multiclassToolTrainingKeys'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['multiclassToolTrainingKeys'],
            ),
      imageURL: jsonSerialization['imageURL'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter;

  String? referenceKey;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? hitDieValue;

  List<_iw3bk51e.Ability>? primaryAbilities;

  List<_iw3bk51e.Ability>? savingThrowProficiencies;

  List<_irzuusaf.ArmorCategory>? armorTraining;

  List<String>? weaponTraining;

  List<String>? toolTrainingKeys;

  List<_iqrhamom.Skill>? availableSkills;

  int? skillCount;

  int? subclassChoiceLevel;

  int? subclassChoiceFeatureId;

  _if4imcqg.SpellcastingProgression? spellcastingProgression;

  _iax70tek.ClassSpellSelectionMode? spellSelectionMode;

  _iw3bk51e.Ability? spellcastingAbilityValue;

  Map<String, int>? multiclassPrerequisites;

  List<_irzuusaf.ArmorCategory>? multiclassArmorTraining;

  List<String>? multiclassWeaponTraining;

  List<String>? multiclassToolTrainingKeys;

  String? imageURL;

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ClassData copyWith({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_iw3bk51e.Ability>? primaryAbilities,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<String>? weaponTraining,
    List<String>? toolTrainingKeys,
    List<_iqrhamom.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    int? subclassChoiceFeatureId,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_irzuusaf.ArmorCategory>? multiclassArmorTraining,
    List<String>? multiclassWeaponTraining,
    List<String>? multiclassToolTrainingKeys,
    String? imageURL,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ClassData',
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJson(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities': primaryAbilities?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies': savingThrowProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null) 'weaponTraining': weaponTraining?.toJson(),
      if (toolTrainingKeys != null)
        'toolTrainingKeys': toolTrainingKeys?.toJson(),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (subclassChoiceFeatureId != null)
        'subclassChoiceFeatureId': subclassChoiceFeatureId,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining': multiclassArmorTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining': multiclassWeaponTraining?.toJson(),
      if (multiclassToolTrainingKeys != null)
        'multiclassToolTrainingKeys': multiclassToolTrainingKeys?.toJson(),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ClassData',
      if (id != null) 'id': id,
      if (spellSelectionFilter != null)
        'spellSelectionFilter': spellSelectionFilter?.toJsonForProtocol(),
      if (referenceKey != null) 'referenceKey': referenceKey,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities': primaryAbilities?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies': savingThrowProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null) 'weaponTraining': weaponTraining?.toJson(),
      if (toolTrainingKeys != null)
        'toolTrainingKeys': toolTrainingKeys?.toJson(),
      if (availableSkills != null)
        'availableSkills': availableSkills?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (subclassChoiceFeatureId != null)
        'subclassChoiceFeatureId': subclassChoiceFeatureId,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellSelectionMode != null)
        'spellSelectionMode': spellSelectionMode?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining': multiclassArmorTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining': multiclassWeaponTraining?.toJson(),
      if (multiclassToolTrainingKeys != null)
        'multiclassToolTrainingKeys': multiclassToolTrainingKeys?.toJson(),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassDataImpl extends ClassData {
  _ClassDataImpl({
    int? id,
    _iv73j5oi.SpellSelectionFilterData? spellSelectionFilter,
    String? referenceKey,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_iw3bk51e.Ability>? primaryAbilities,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<String>? weaponTraining,
    List<String>? toolTrainingKeys,
    List<_iqrhamom.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    int? subclassChoiceFeatureId,
    _if4imcqg.SpellcastingProgression? spellcastingProgression,
    _iax70tek.ClassSpellSelectionMode? spellSelectionMode,
    _iw3bk51e.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_irzuusaf.ArmorCategory>? multiclassArmorTraining,
    List<String>? multiclassWeaponTraining,
    List<String>? multiclassToolTrainingKeys,
    String? imageURL,
  }) : super._(
         id: id,
         spellSelectionFilter: spellSelectionFilter,
         referenceKey: referenceKey,
         name: name,
         description: description,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
         hitDieValue: hitDieValue,
         primaryAbilities: primaryAbilities,
         savingThrowProficiencies: savingThrowProficiencies,
         armorTraining: armorTraining,
         weaponTraining: weaponTraining,
         toolTrainingKeys: toolTrainingKeys,
         availableSkills: availableSkills,
         skillCount: skillCount,
         subclassChoiceLevel: subclassChoiceLevel,
         subclassChoiceFeatureId: subclassChoiceFeatureId,
         spellcastingProgression: spellcastingProgression,
         spellSelectionMode: spellSelectionMode,
         spellcastingAbilityValue: spellcastingAbilityValue,
         multiclassPrerequisites: multiclassPrerequisites,
         multiclassArmorTraining: multiclassArmorTraining,
         multiclassWeaponTraining: multiclassWeaponTraining,
         multiclassToolTrainingKeys: multiclassToolTrainingKeys,
         imageURL: imageURL,
       );

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ClassData copyWith({
    Object? id = _Undefined,
    Object? spellSelectionFilter = _Undefined,
    Object? referenceKey = _Undefined,
    Object? name = _Undefined,
    Object? description = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? hitDieValue = _Undefined,
    Object? primaryAbilities = _Undefined,
    Object? savingThrowProficiencies = _Undefined,
    Object? armorTraining = _Undefined,
    Object? weaponTraining = _Undefined,
    Object? toolTrainingKeys = _Undefined,
    Object? availableSkills = _Undefined,
    Object? skillCount = _Undefined,
    Object? subclassChoiceLevel = _Undefined,
    Object? subclassChoiceFeatureId = _Undefined,
    Object? spellcastingProgression = _Undefined,
    Object? spellSelectionMode = _Undefined,
    Object? spellcastingAbilityValue = _Undefined,
    Object? multiclassPrerequisites = _Undefined,
    Object? multiclassArmorTraining = _Undefined,
    Object? multiclassWeaponTraining = _Undefined,
    Object? multiclassToolTrainingKeys = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return ClassData(
      id: id is int? ? id : this.id,
      spellSelectionFilter:
          spellSelectionFilter is _iv73j5oi.SpellSelectionFilterData?
          ? spellSelectionFilter
          : this.spellSelectionFilter?.copyWith(),
      referenceKey: referenceKey is String? ? referenceKey : this.referenceKey,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      hitDieValue: hitDieValue is int? ? hitDieValue : this.hitDieValue,
      primaryAbilities: primaryAbilities is List<_iw3bk51e.Ability>?
          ? primaryAbilities
          : this.primaryAbilities?.map((e0) => e0).toList(),
      savingThrowProficiencies:
          savingThrowProficiencies is List<_iw3bk51e.Ability>?
          ? savingThrowProficiencies
          : this.savingThrowProficiencies?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_irzuusaf.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<String>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      toolTrainingKeys: toolTrainingKeys is List<String>?
          ? toolTrainingKeys
          : this.toolTrainingKeys?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_iqrhamom.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      subclassChoiceLevel: subclassChoiceLevel is int?
          ? subclassChoiceLevel
          : this.subclassChoiceLevel,
      subclassChoiceFeatureId: subclassChoiceFeatureId is int?
          ? subclassChoiceFeatureId
          : this.subclassChoiceFeatureId,
      spellcastingProgression:
          spellcastingProgression is _if4imcqg.SpellcastingProgression?
          ? spellcastingProgression
          : this.spellcastingProgression,
      spellSelectionMode:
          spellSelectionMode is _iax70tek.ClassSpellSelectionMode?
          ? spellSelectionMode
          : this.spellSelectionMode,
      spellcastingAbilityValue: spellcastingAbilityValue is _iw3bk51e.Ability?
          ? spellcastingAbilityValue
          : this.spellcastingAbilityValue,
      multiclassPrerequisites: multiclassPrerequisites is Map<String, int>?
          ? multiclassPrerequisites
          : this.multiclassPrerequisites?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      multiclassArmorTraining:
          multiclassArmorTraining is List<_irzuusaf.ArmorCategory>?
          ? multiclassArmorTraining
          : this.multiclassArmorTraining?.map((e0) => e0).toList(),
      multiclassWeaponTraining: multiclassWeaponTraining is List<String>?
          ? multiclassWeaponTraining
          : this.multiclassWeaponTraining?.map((e0) => e0).toList(),
      multiclassToolTrainingKeys: multiclassToolTrainingKeys is List<String>?
          ? multiclassToolTrainingKeys
          : this.multiclassToolTrainingKeys?.map((e0) => e0).toList(),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}
