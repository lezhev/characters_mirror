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
import '../../../data/general/character/character_feature_view_data.dart'
    as _i3;
import '../../../data/general/feature_modifier_data.dart' as _i4;
import '../../../enums/skill.dart' as _i5;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _i6;
import '../../../enums/language.dart' as _i7;
import '../../../enums/armor_category.dart' as _i8;
import '../../../enums/weapon_category.dart' as _i9;
import '../../../views/character_equipment_entry_view.dart' as _i10;
import '../../../enums/damage_type.dart' as _i11;

abstract class CharacterDerivedData implements _i1.SerializableModel {
  CharacterDerivedData._({
    this.totalLevel,
    this.proficiencyBonus,
    this.abilityScores,
    this.abilityModifiers,
    this.activeFeatures,
    this.featureModifiers,
    this.armorClass,
    this.armorClassSource,
    this.armorClassFormula,
    this.initiative,
    this.speed,
    this.maxHp,
    this.passivePerception,
    this.passiveInvestigation,
    this.passiveInsight,
    this.savingThrowBonuses,
    this.skillBonuses,
    this.skillProficiencyLevels,
    this.savingThrowProficiencies,
    this.spellSlots,
    this.pactSlots,
    this.hitDiceSummary,
    this.languages,
    this.toolProficiencyKeys,
    this.toolExpertiseKeys,
    this.armorTraining,
    this.weaponTraining,
    this.weaponProficiencyKeys,
    this.customLanguages,
    this.customToolProficiencies,
    this.customWeaponProficiencies,
    this.customArmorTraining,
    this.grantedSpellKeys,
    this.alwaysPreparedSpellKeys,
    this.grantedEquipment,
    this.resistances,
  });

  factory CharacterDerivedData({
    int? totalLevel,
    int? proficiencyBonus,
    Map<_i2.Ability, int>? abilityScores,
    Map<_i2.Ability, int>? abilityModifiers,
    List<_i3.CharacterFeatureViewData>? activeFeatures,
    List<_i4.FeatureModifierData>? featureModifiers,
    int? armorClass,
    String? armorClassSource,
    String? armorClassFormula,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<_i2.Ability, int>? savingThrowBonuses,
    Map<_i5.Skill, int>? skillBonuses,
    List<_i6.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_i2.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<_i7.Language>? languages,
    List<String>? toolProficiencyKeys,
    List<String>? toolExpertiseKeys,
    List<_i8.ArmorCategory>? armorTraining,
    List<_i9.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? customLanguages,
    List<String>? customToolProficiencies,
    List<String>? customWeaponProficiencies,
    List<String>? customArmorTraining,
    List<String>? grantedSpellKeys,
    List<String>? alwaysPreparedSpellKeys,
    List<_i10.CharacterEquipmentEntryView>? grantedEquipment,
    List<_i11.DamageType>? resistances,
  }) = _CharacterDerivedDataImpl;

  factory CharacterDerivedData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterDerivedData(
      totalLevel: jsonSerialization['totalLevel'] as int?,
      proficiencyBonus: jsonSerialization['proficiencyBonus'] as int?,
      abilityScores: (jsonSerialization['abilityScores'] as List?)
          ?.fold<Map<_i2.Ability, int>>(
              {},
              (t, e) => {
                    ...t,
                    _i2.Ability.fromJson((e['k'] as String)): e['v'] as int
                  }),
      abilityModifiers: (jsonSerialization['abilityModifiers'] as List?)
          ?.fold<Map<_i2.Ability, int>>(
              {},
              (t, e) => {
                    ...t,
                    _i2.Ability.fromJson((e['k'] as String)): e['v'] as int
                  }),
      activeFeatures: (jsonSerialization['activeFeatures'] as List?)
          ?.map((e) => _i3.CharacterFeatureViewData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      featureModifiers: (jsonSerialization['featureModifiers'] as List?)
          ?.map((e) =>
              _i4.FeatureModifierData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      armorClass: jsonSerialization['armorClass'] as int?,
      armorClassSource: jsonSerialization['armorClassSource'] as String?,
      armorClassFormula: jsonSerialization['armorClassFormula'] as String?,
      initiative: jsonSerialization['initiative'] as int?,
      speed: jsonSerialization['speed'] as int?,
      maxHp: jsonSerialization['maxHp'] as int?,
      passivePerception: jsonSerialization['passivePerception'] as int?,
      passiveInvestigation: jsonSerialization['passiveInvestigation'] as int?,
      passiveInsight: jsonSerialization['passiveInsight'] as int?,
      savingThrowBonuses: (jsonSerialization['savingThrowBonuses'] as List?)
          ?.fold<Map<_i2.Ability, int>>(
              {},
              (t, e) => {
                    ...t,
                    _i2.Ability.fromJson((e['k'] as String)): e['v'] as int
                  }),
      skillBonuses: (jsonSerialization['skillBonuses'] as List?)
          ?.fold<Map<_i5.Skill, int>>(
              {},
              (t, e) => {
                    ...t,
                    _i5.Skill.fromJson((e['k'] as String)): e['v'] as int
                  }),
      skillProficiencyLevels:
          (jsonSerialization['skillProficiencyLevels'] as List?)
              ?.map((e) => _i6.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      savingThrowProficiencies:
          (jsonSerialization['savingThrowProficiencies'] as List?)
              ?.map((e) => _i2.Ability.fromJson((e as String)))
              .toList(),
      spellSlots: (jsonSerialization['spellSlots'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      pactSlots: (jsonSerialization['pactSlots'] as List?)?.fold<Map<int, int>>(
          {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      hitDiceSummary:
          (jsonSerialization['hitDiceSummary'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      languages: (jsonSerialization['languages'] as List?)
          ?.map((e) => _i7.Language.fromJson((e as String)))
          .toList(),
      toolProficiencyKeys: (jsonSerialization['toolProficiencyKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      toolExpertiseKeys: (jsonSerialization['toolExpertiseKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      armorTraining: (jsonSerialization['armorTraining'] as List?)
          ?.map((e) => _i8.ArmorCategory.fromJson((e as String)))
          .toList(),
      weaponTraining: (jsonSerialization['weaponTraining'] as List?)
          ?.map((e) => _i9.WeaponCategory.fromJson((e as String)))
          .toList(),
      weaponProficiencyKeys:
          (jsonSerialization['weaponProficiencyKeys'] as List?)
              ?.map((e) => e as String)
              .toList(),
      customLanguages: (jsonSerialization['customLanguages'] as List?)
          ?.map((e) => e as String)
          .toList(),
      customToolProficiencies:
          (jsonSerialization['customToolProficiencies'] as List?)
              ?.map((e) => e as String)
              .toList(),
      customWeaponProficiencies:
          (jsonSerialization['customWeaponProficiencies'] as List?)
              ?.map((e) => e as String)
              .toList(),
      customArmorTraining: (jsonSerialization['customArmorTraining'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      alwaysPreparedSpellKeys:
          (jsonSerialization['alwaysPreparedSpellKeys'] as List?)
              ?.map((e) => e as String)
              .toList(),
      grantedEquipment: (jsonSerialization['grantedEquipment'] as List?)
          ?.map((e) => _i10.CharacterEquipmentEntryView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => _i11.DamageType.fromJson((e as String)))
          .toList(),
    );
  }

  int? totalLevel;

  int? proficiencyBonus;

  Map<_i2.Ability, int>? abilityScores;

  Map<_i2.Ability, int>? abilityModifiers;

  List<_i3.CharacterFeatureViewData>? activeFeatures;

  List<_i4.FeatureModifierData>? featureModifiers;

  int? armorClass;

  String? armorClassSource;

  String? armorClassFormula;

  int? initiative;

  int? speed;

  int? maxHp;

  int? passivePerception;

  int? passiveInvestigation;

  int? passiveInsight;

  Map<_i2.Ability, int>? savingThrowBonuses;

  Map<_i5.Skill, int>? skillBonuses;

  List<_i6.CharacterSkillProficiencyState>? skillProficiencyLevels;

  List<_i2.Ability>? savingThrowProficiencies;

  Map<int, int>? spellSlots;

  Map<int, int>? pactSlots;

  Map<String, int>? hitDiceSummary;

  List<_i7.Language>? languages;

  List<String>? toolProficiencyKeys;

  List<String>? toolExpertiseKeys;

  List<_i8.ArmorCategory>? armorTraining;

  List<_i9.WeaponCategory>? weaponTraining;

  List<String>? weaponProficiencyKeys;

  List<String>? customLanguages;

  List<String>? customToolProficiencies;

  List<String>? customWeaponProficiencies;

  List<String>? customArmorTraining;

  List<String>? grantedSpellKeys;

  List<String>? alwaysPreparedSpellKeys;

  List<_i10.CharacterEquipmentEntryView>? grantedEquipment;

  List<_i11.DamageType>? resistances;

  /// Returns a shallow copy of this [CharacterDerivedData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterDerivedData copyWith({
    int? totalLevel,
    int? proficiencyBonus,
    Map<_i2.Ability, int>? abilityScores,
    Map<_i2.Ability, int>? abilityModifiers,
    List<_i3.CharacterFeatureViewData>? activeFeatures,
    List<_i4.FeatureModifierData>? featureModifiers,
    int? armorClass,
    String? armorClassSource,
    String? armorClassFormula,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<_i2.Ability, int>? savingThrowBonuses,
    Map<_i5.Skill, int>? skillBonuses,
    List<_i6.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_i2.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<_i7.Language>? languages,
    List<String>? toolProficiencyKeys,
    List<String>? toolExpertiseKeys,
    List<_i8.ArmorCategory>? armorTraining,
    List<_i9.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? customLanguages,
    List<String>? customToolProficiencies,
    List<String>? customWeaponProficiencies,
    List<String>? customArmorTraining,
    List<String>? grantedSpellKeys,
    List<String>? alwaysPreparedSpellKeys,
    List<_i10.CharacterEquipmentEntryView>? grantedEquipment,
    List<_i11.DamageType>? resistances,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (totalLevel != null) 'totalLevel': totalLevel,
      if (proficiencyBonus != null) 'proficiencyBonus': proficiencyBonus,
      if (abilityScores != null)
        'abilityScores': abilityScores?.toJson(keyToJson: (k) => k.toJson()),
      if (abilityModifiers != null)
        'abilityModifiers':
            abilityModifiers?.toJson(keyToJson: (k) => k.toJson()),
      if (activeFeatures != null)
        'activeFeatures':
            activeFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (featureModifiers != null)
        'featureModifiers':
            featureModifiers?.toJson(valueToJson: (v) => v.toJson()),
      if (armorClass != null) 'armorClass': armorClass,
      if (armorClassSource != null) 'armorClassSource': armorClassSource,
      if (armorClassFormula != null) 'armorClassFormula': armorClassFormula,
      if (initiative != null) 'initiative': initiative,
      if (speed != null) 'speed': speed,
      if (maxHp != null) 'maxHp': maxHp,
      if (passivePerception != null) 'passivePerception': passivePerception,
      if (passiveInvestigation != null)
        'passiveInvestigation': passiveInvestigation,
      if (passiveInsight != null) 'passiveInsight': passiveInsight,
      if (savingThrowBonuses != null)
        'savingThrowBonuses':
            savingThrowBonuses?.toJson(keyToJson: (k) => k.toJson()),
      if (skillBonuses != null)
        'skillBonuses': skillBonuses?.toJson(keyToJson: (k) => k.toJson()),
      if (skillProficiencyLevels != null)
        'skillProficiencyLevels':
            skillProficiencyLevels?.toJson(valueToJson: (v) => v.toJson()),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies':
            savingThrowProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (pactSlots != null) 'pactSlots': pactSlots?.toJson(),
      if (hitDiceSummary != null) 'hitDiceSummary': hitDiceSummary?.toJson(),
      if (languages != null)
        'languages': languages?.toJson(valueToJson: (v) => v.toJson()),
      if (toolProficiencyKeys != null)
        'toolProficiencyKeys': toolProficiencyKeys?.toJson(),
      if (toolExpertiseKeys != null)
        'toolExpertiseKeys': toolExpertiseKeys?.toJson(),
      if (armorTraining != null)
        'armorTraining': armorTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponTraining != null)
        'weaponTraining':
            weaponTraining?.toJson(valueToJson: (v) => v.toJson()),
      if (weaponProficiencyKeys != null)
        'weaponProficiencyKeys': weaponProficiencyKeys?.toJson(),
      if (customLanguages != null) 'customLanguages': customLanguages?.toJson(),
      if (customToolProficiencies != null)
        'customToolProficiencies': customToolProficiencies?.toJson(),
      if (customWeaponProficiencies != null)
        'customWeaponProficiencies': customWeaponProficiencies?.toJson(),
      if (customArmorTraining != null)
        'customArmorTraining': customArmorTraining?.toJson(),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (alwaysPreparedSpellKeys != null)
        'alwaysPreparedSpellKeys': alwaysPreparedSpellKeys?.toJson(),
      if (grantedEquipment != null)
        'grantedEquipment':
            grantedEquipment?.toJson(valueToJson: (v) => v.toJson()),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterDerivedDataImpl extends CharacterDerivedData {
  _CharacterDerivedDataImpl({
    int? totalLevel,
    int? proficiencyBonus,
    Map<_i2.Ability, int>? abilityScores,
    Map<_i2.Ability, int>? abilityModifiers,
    List<_i3.CharacterFeatureViewData>? activeFeatures,
    List<_i4.FeatureModifierData>? featureModifiers,
    int? armorClass,
    String? armorClassSource,
    String? armorClassFormula,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<_i2.Ability, int>? savingThrowBonuses,
    Map<_i5.Skill, int>? skillBonuses,
    List<_i6.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_i2.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<_i7.Language>? languages,
    List<String>? toolProficiencyKeys,
    List<String>? toolExpertiseKeys,
    List<_i8.ArmorCategory>? armorTraining,
    List<_i9.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? customLanguages,
    List<String>? customToolProficiencies,
    List<String>? customWeaponProficiencies,
    List<String>? customArmorTraining,
    List<String>? grantedSpellKeys,
    List<String>? alwaysPreparedSpellKeys,
    List<_i10.CharacterEquipmentEntryView>? grantedEquipment,
    List<_i11.DamageType>? resistances,
  }) : super._(
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          abilityScores: abilityScores,
          abilityModifiers: abilityModifiers,
          activeFeatures: activeFeatures,
          featureModifiers: featureModifiers,
          armorClass: armorClass,
          armorClassSource: armorClassSource,
          armorClassFormula: armorClassFormula,
          initiative: initiative,
          speed: speed,
          maxHp: maxHp,
          passivePerception: passivePerception,
          passiveInvestigation: passiveInvestigation,
          passiveInsight: passiveInsight,
          savingThrowBonuses: savingThrowBonuses,
          skillBonuses: skillBonuses,
          skillProficiencyLevels: skillProficiencyLevels,
          savingThrowProficiencies: savingThrowProficiencies,
          spellSlots: spellSlots,
          pactSlots: pactSlots,
          hitDiceSummary: hitDiceSummary,
          languages: languages,
          toolProficiencyKeys: toolProficiencyKeys,
          toolExpertiseKeys: toolExpertiseKeys,
          armorTraining: armorTraining,
          weaponTraining: weaponTraining,
          weaponProficiencyKeys: weaponProficiencyKeys,
          customLanguages: customLanguages,
          customToolProficiencies: customToolProficiencies,
          customWeaponProficiencies: customWeaponProficiencies,
          customArmorTraining: customArmorTraining,
          grantedSpellKeys: grantedSpellKeys,
          alwaysPreparedSpellKeys: alwaysPreparedSpellKeys,
          grantedEquipment: grantedEquipment,
          resistances: resistances,
        );

  /// Returns a shallow copy of this [CharacterDerivedData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterDerivedData copyWith({
    Object? totalLevel = _Undefined,
    Object? proficiencyBonus = _Undefined,
    Object? abilityScores = _Undefined,
    Object? abilityModifiers = _Undefined,
    Object? activeFeatures = _Undefined,
    Object? featureModifiers = _Undefined,
    Object? armorClass = _Undefined,
    Object? armorClassSource = _Undefined,
    Object? armorClassFormula = _Undefined,
    Object? initiative = _Undefined,
    Object? speed = _Undefined,
    Object? maxHp = _Undefined,
    Object? passivePerception = _Undefined,
    Object? passiveInvestigation = _Undefined,
    Object? passiveInsight = _Undefined,
    Object? savingThrowBonuses = _Undefined,
    Object? skillBonuses = _Undefined,
    Object? skillProficiencyLevels = _Undefined,
    Object? savingThrowProficiencies = _Undefined,
    Object? spellSlots = _Undefined,
    Object? pactSlots = _Undefined,
    Object? hitDiceSummary = _Undefined,
    Object? languages = _Undefined,
    Object? toolProficiencyKeys = _Undefined,
    Object? toolExpertiseKeys = _Undefined,
    Object? armorTraining = _Undefined,
    Object? weaponTraining = _Undefined,
    Object? weaponProficiencyKeys = _Undefined,
    Object? customLanguages = _Undefined,
    Object? customToolProficiencies = _Undefined,
    Object? customWeaponProficiencies = _Undefined,
    Object? customArmorTraining = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? alwaysPreparedSpellKeys = _Undefined,
    Object? grantedEquipment = _Undefined,
    Object? resistances = _Undefined,
  }) {
    return CharacterDerivedData(
      totalLevel: totalLevel is int? ? totalLevel : this.totalLevel,
      proficiencyBonus:
          proficiencyBonus is int? ? proficiencyBonus : this.proficiencyBonus,
      abilityScores: abilityScores is Map<_i2.Ability, int>?
          ? abilityScores
          : this.abilityScores?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      abilityModifiers: abilityModifiers is Map<_i2.Ability, int>?
          ? abilityModifiers
          : this.abilityModifiers?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      activeFeatures: activeFeatures is List<_i3.CharacterFeatureViewData>?
          ? activeFeatures
          : this.activeFeatures?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_i4.FeatureModifierData>?
          ? featureModifiers
          : this.featureModifiers?.map((e0) => e0.copyWith()).toList(),
      armorClass: armorClass is int? ? armorClass : this.armorClass,
      armorClassSource: armorClassSource is String?
          ? armorClassSource
          : this.armorClassSource,
      armorClassFormula: armorClassFormula is String?
          ? armorClassFormula
          : this.armorClassFormula,
      initiative: initiative is int? ? initiative : this.initiative,
      speed: speed is int? ? speed : this.speed,
      maxHp: maxHp is int? ? maxHp : this.maxHp,
      passivePerception: passivePerception is int?
          ? passivePerception
          : this.passivePerception,
      passiveInvestigation: passiveInvestigation is int?
          ? passiveInvestigation
          : this.passiveInvestigation,
      passiveInsight:
          passiveInsight is int? ? passiveInsight : this.passiveInsight,
      savingThrowBonuses: savingThrowBonuses is Map<_i2.Ability, int>?
          ? savingThrowBonuses
          : this.savingThrowBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      skillBonuses: skillBonuses is Map<_i5.Skill, int>?
          ? skillBonuses
          : this.skillBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      skillProficiencyLevels: skillProficiencyLevels
              is List<_i6.CharacterSkillProficiencyState>?
          ? skillProficiencyLevels
          : this.skillProficiencyLevels?.map((e0) => e0.copyWith()).toList(),
      savingThrowProficiencies: savingThrowProficiencies is List<_i2.Ability>?
          ? savingThrowProficiencies
          : this.savingThrowProficiencies?.map((e0) => e0).toList(),
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      pactSlots: pactSlots is Map<int, int>?
          ? pactSlots
          : this.pactSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      hitDiceSummary: hitDiceSummary is Map<String, int>?
          ? hitDiceSummary
          : this.hitDiceSummary?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      languages: languages is List<_i7.Language>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      toolProficiencyKeys: toolProficiencyKeys is List<String>?
          ? toolProficiencyKeys
          : this.toolProficiencyKeys?.map((e0) => e0).toList(),
      toolExpertiseKeys: toolExpertiseKeys is List<String>?
          ? toolExpertiseKeys
          : this.toolExpertiseKeys?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_i8.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<_i9.WeaponCategory>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      weaponProficiencyKeys: weaponProficiencyKeys is List<String>?
          ? weaponProficiencyKeys
          : this.weaponProficiencyKeys?.map((e0) => e0).toList(),
      customLanguages: customLanguages is List<String>?
          ? customLanguages
          : this.customLanguages?.map((e0) => e0).toList(),
      customToolProficiencies: customToolProficiencies is List<String>?
          ? customToolProficiencies
          : this.customToolProficiencies?.map((e0) => e0).toList(),
      customWeaponProficiencies: customWeaponProficiencies is List<String>?
          ? customWeaponProficiencies
          : this.customWeaponProficiencies?.map((e0) => e0).toList(),
      customArmorTraining: customArmorTraining is List<String>?
          ? customArmorTraining
          : this.customArmorTraining?.map((e0) => e0).toList(),
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      alwaysPreparedSpellKeys: alwaysPreparedSpellKeys is List<String>?
          ? alwaysPreparedSpellKeys
          : this.alwaysPreparedSpellKeys?.map((e0) => e0).toList(),
      grantedEquipment:
          grantedEquipment is List<_i10.CharacterEquipmentEntryView>?
              ? grantedEquipment
              : this.grantedEquipment?.map((e0) => e0.copyWith()).toList(),
      resistances: resistances is List<_i11.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
    );
  }
}
