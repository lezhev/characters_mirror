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
import '../../../enums/ability.dart' as _i2;
import '../../../enums/armor_category.dart' as _i3;
import '../../../enums/weapon_category.dart' as _i4;
import '../../../enums/skill.dart' as _i5;
import '../../../enums/spellcasting_progression.dart' as _i6;

abstract class ClassData implements _i1.SerializableModel {
  ClassData._({
    this.id,
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
    this.toolTraining,
    this.availableSkills,
    this.skillCount,
    this.subclassChoiceLevel,
    this.spellcastingProgression,
    this.spellcastingAbilityValue,
    this.multiclassPrerequisites,
    this.multiclassArmorTraining,
    this.multiclassWeaponTraining,
    this.multiclassToolTraining,
    this.imageURL,
  });

  factory ClassData({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_i2.Ability>? primaryAbilities,
    List<_i2.Ability>? savingThrowProficiencies,
    List<_i3.ArmorCategory>? armorTraining,
    List<_i4.WeaponCategory>? weaponTraining,
    List<String>? toolTraining,
    List<_i5.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    _i6.SpellcastingProgression? spellcastingProgression,
    _i2.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_i3.ArmorCategory>? multiclassArmorTraining,
    List<_i4.WeaponCategory>? multiclassWeaponTraining,
    List<String>? multiclassToolTraining,
    String? imageURL,
  }) = _ClassDataImpl;

  factory ClassData.fromJson(Map<String, dynamic> jsonSerialization) {
    return ClassData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      description: jsonSerialization['description'] as String?,
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      hitDieValue: jsonSerialization['hitDieValue'] as int?,
      primaryAbilities: (jsonSerialization['primaryAbilities'] as List?)
          ?.map((e) => _i2.Ability.fromJson((e as String)))
          .toList(),
      savingThrowProficiencies:
          (jsonSerialization['savingThrowProficiencies'] as List?)
              ?.map((e) => _i2.Ability.fromJson((e as String)))
              .toList(),
      armorTraining: (jsonSerialization['armorTraining'] as List?)
          ?.map((e) => _i3.ArmorCategory.fromJson((e as String)))
          .toList(),
      weaponTraining: (jsonSerialization['weaponTraining'] as List?)
          ?.map((e) => _i4.WeaponCategory.fromJson((e as String)))
          .toList(),
      toolTraining: (jsonSerialization['toolTraining'] as List?)
          ?.map((e) => e as String)
          .toList(),
      availableSkills: (jsonSerialization['availableSkills'] as List?)
          ?.map((e) => _i5.Skill.fromJson((e as String)))
          .toList(),
      skillCount: jsonSerialization['skillCount'] as int?,
      subclassChoiceLevel: jsonSerialization['subclassChoiceLevel'] as int?,
      spellcastingProgression:
          jsonSerialization['spellcastingProgression'] == null
              ? null
              : _i6.SpellcastingProgression.fromJson(
                  (jsonSerialization['spellcastingProgression'] as String)),
      spellcastingAbilityValue:
          jsonSerialization['spellcastingAbilityValue'] == null
              ? null
              : _i2.Ability.fromJson(
                  (jsonSerialization['spellcastingAbilityValue'] as String)),
      multiclassPrerequisites:
          (jsonSerialization['multiclassPrerequisites'] as Map?)
              ?.map((k, v) => MapEntry(
                    k as String,
                    v as int,
                  )),
      multiclassArmorTraining:
          (jsonSerialization['multiclassArmorTraining'] as List?)
              ?.map((e) => _i3.ArmorCategory.fromJson((e as String)))
              .toList(),
      multiclassWeaponTraining:
          (jsonSerialization['multiclassWeaponTraining'] as List?)
              ?.map((e) => _i4.WeaponCategory.fromJson((e as String)))
              .toList(),
      multiclassToolTraining:
          (jsonSerialization['multiclassToolTraining'] as List?)
              ?.map((e) => e as String)
              .toList(),
      imageURL: jsonSerialization['imageURL'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? name;

  String? description;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? hitDieValue;

  List<_i2.Ability>? primaryAbilities;

  List<_i2.Ability>? savingThrowProficiencies;

  List<_i3.ArmorCategory>? armorTraining;

  List<_i4.WeaponCategory>? weaponTraining;

  List<String>? toolTraining;

  List<_i5.Skill>? availableSkills;

  int? skillCount;

  int? subclassChoiceLevel;

  _i6.SpellcastingProgression? spellcastingProgression;

  _i2.Ability? spellcastingAbilityValue;

  Map<String, int>? multiclassPrerequisites;

  List<_i3.ArmorCategory>? multiclassArmorTraining;

  List<_i4.WeaponCategory>? multiclassWeaponTraining;

  List<String>? multiclassToolTraining;

  String? imageURL;

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ClassData copyWith({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_i2.Ability>? primaryAbilities,
    List<_i2.Ability>? savingThrowProficiencies,
    List<_i3.ArmorCategory>? armorTraining,
    List<_i4.WeaponCategory>? weaponTraining,
    List<String>? toolTraining,
    List<_i5.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    _i6.SpellcastingProgression? spellcastingProgression,
    _i2.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_i3.ArmorCategory>? multiclassArmorTraining,
    List<_i4.WeaponCategory>? multiclassWeaponTraining,
    List<String>? multiclassToolTraining,
    String? imageURL,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (hitDieValue != null) 'hitDieValue': hitDieValue,
      if (primaryAbilities != null)
        'primaryAbilities':
            primaryAbilities?.toJson(valueToJson: (v) => v.toJson()),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies':
            savingThrowProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining':
            weaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (toolTraining != null) 'toolTraining': toolTraining?.toJson(),
      if (availableSkills != null)
        'availableSkills':
            availableSkills?.toJson(valueToJson: (v) => v.toJson()),
      if (skillCount != null) 'skillCount': skillCount,
      if (subclassChoiceLevel != null)
        'subclassChoiceLevel': subclassChoiceLevel,
      if (spellcastingProgression != null)
        'spellcastingProgression': spellcastingProgression?.toJson(),
      if (spellcastingAbilityValue != null)
        'spellcastingAbilityValue': spellcastingAbilityValue?.toJson(),
      if (multiclassPrerequisites != null)
        'multiclassPrerequisites': multiclassPrerequisites?.toJson(),
      if (multiclassArmorTraining != null)
        'multiclassArmorTraining':
            multiclassArmorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (multiclassWeaponTraining != null)
        'multiclassWeaponTraining':
            multiclassWeaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (multiclassToolTraining != null)
        'multiclassToolTraining': multiclassToolTraining?.toJson(),
      if (imageURL != null) 'imageURL': imageURL,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ClassDataImpl extends ClassData {
  _ClassDataImpl({
    int? id,
    String? name,
    String? description,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hitDieValue,
    List<_i2.Ability>? primaryAbilities,
    List<_i2.Ability>? savingThrowProficiencies,
    List<_i3.ArmorCategory>? armorTraining,
    List<_i4.WeaponCategory>? weaponTraining,
    List<String>? toolTraining,
    List<_i5.Skill>? availableSkills,
    int? skillCount,
    int? subclassChoiceLevel,
    _i6.SpellcastingProgression? spellcastingProgression,
    _i2.Ability? spellcastingAbilityValue,
    Map<String, int>? multiclassPrerequisites,
    List<_i3.ArmorCategory>? multiclassArmorTraining,
    List<_i4.WeaponCategory>? multiclassWeaponTraining,
    List<String>? multiclassToolTraining,
    String? imageURL,
  }) : super._(
          id: id,
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
          toolTraining: toolTraining,
          availableSkills: availableSkills,
          skillCount: skillCount,
          subclassChoiceLevel: subclassChoiceLevel,
          spellcastingProgression: spellcastingProgression,
          spellcastingAbilityValue: spellcastingAbilityValue,
          multiclassPrerequisites: multiclassPrerequisites,
          multiclassArmorTraining: multiclassArmorTraining,
          multiclassWeaponTraining: multiclassWeaponTraining,
          multiclassToolTraining: multiclassToolTraining,
          imageURL: imageURL,
        );

  /// Returns a shallow copy of this [ClassData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ClassData copyWith({
    Object? id = _Undefined,
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
    Object? toolTraining = _Undefined,
    Object? availableSkills = _Undefined,
    Object? skillCount = _Undefined,
    Object? subclassChoiceLevel = _Undefined,
    Object? spellcastingProgression = _Undefined,
    Object? spellcastingAbilityValue = _Undefined,
    Object? multiclassPrerequisites = _Undefined,
    Object? multiclassArmorTraining = _Undefined,
    Object? multiclassWeaponTraining = _Undefined,
    Object? multiclassToolTraining = _Undefined,
    Object? imageURL = _Undefined,
  }) {
    return ClassData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      description: description is String? ? description : this.description,
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      hitDieValue: hitDieValue is int? ? hitDieValue : this.hitDieValue,
      primaryAbilities: primaryAbilities is List<_i2.Ability>?
          ? primaryAbilities
          : this.primaryAbilities?.map((e0) => e0).toList(),
      savingThrowProficiencies: savingThrowProficiencies is List<_i2.Ability>?
          ? savingThrowProficiencies
          : this.savingThrowProficiencies?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_i3.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<_i4.WeaponCategory>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      toolTraining: toolTraining is List<String>?
          ? toolTraining
          : this.toolTraining?.map((e0) => e0).toList(),
      availableSkills: availableSkills is List<_i5.Skill>?
          ? availableSkills
          : this.availableSkills?.map((e0) => e0).toList(),
      skillCount: skillCount is int? ? skillCount : this.skillCount,
      subclassChoiceLevel: subclassChoiceLevel is int?
          ? subclassChoiceLevel
          : this.subclassChoiceLevel,
      spellcastingProgression:
          spellcastingProgression is _i6.SpellcastingProgression?
              ? spellcastingProgression
              : this.spellcastingProgression,
      spellcastingAbilityValue: spellcastingAbilityValue is _i2.Ability?
          ? spellcastingAbilityValue
          : this.spellcastingAbilityValue,
      multiclassPrerequisites: multiclassPrerequisites is Map<String, int>?
          ? multiclassPrerequisites
          : this.multiclassPrerequisites?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      multiclassArmorTraining:
          multiclassArmorTraining is List<_i3.ArmorCategory>?
              ? multiclassArmorTraining
              : this.multiclassArmorTraining?.map((e0) => e0).toList(),
      multiclassWeaponTraining:
          multiclassWeaponTraining is List<_i4.WeaponCategory>?
              ? multiclassWeaponTraining
              : this.multiclassWeaponTraining?.map((e0) => e0).toList(),
      multiclassToolTraining: multiclassToolTraining is List<String>?
          ? multiclassToolTraining
          : this.multiclassToolTraining?.map((e0) => e0).toList(),
      imageURL: imageURL is String? ? imageURL : this.imageURL,
    );
  }
}
