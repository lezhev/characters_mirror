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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/general/character/character_feature_view_data.dart'
    as _i66hj7xp;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _ipq2j7wi;
import '../../../data/general/feature_modifier_data.dart' as _ilc9jnh2;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/armor_category.dart' as _irzuusaf;
import '../../../enums/damage_type.dart' as _ij9bzpyl;
import '../../../enums/language.dart' as _iiw0j43j;
import '../../../enums/skill.dart' as _iqrhamom;
import '../../../enums/weapon_category.dart' as _ibtz7e0l;
import '../../../views/character_equipment_entry_view.dart' as _iewpbuzi;
import '../../../views/resolved_character_spell_data.dart' as _ijr8g5vf;

abstract class CharacterDerivedData
    implements _is.SerializableModel, _is.ProtocolSerialization {
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
    this.resolvedSpells,
    this.grantedEquipment,
    this.resistances,
  });

  factory CharacterDerivedData({
    int? totalLevel,
    int? proficiencyBonus,
    Map<_iw3bk51e.Ability, int>? abilityScores,
    Map<_iw3bk51e.Ability, int>? abilityModifiers,
    List<_i66hj7xp.CharacterFeatureViewData>? activeFeatures,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
    int? armorClass,
    String? armorClassSource,
    String? armorClassFormula,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<_iw3bk51e.Ability, int>? savingThrowBonuses,
    Map<_iqrhamom.Skill, int>? skillBonuses,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<_iiw0j43j.Language>? languages,
    List<String>? toolProficiencyKeys,
    List<String>? toolExpertiseKeys,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<_ibtz7e0l.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? customLanguages,
    List<String>? customToolProficiencies,
    List<String>? customWeaponProficiencies,
    List<String>? customArmorTraining,
    List<String>? grantedSpellKeys,
    List<String>? alwaysPreparedSpellKeys,
    List<_ijr8g5vf.ResolvedCharacterSpellData>? resolvedSpells,
    List<_iewpbuzi.CharacterEquipmentEntryView>? grantedEquipment,
    List<_ij9bzpyl.DamageType>? resistances,
  }) = _CharacterDerivedDataImpl;

  factory CharacterDerivedData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterDerivedData(
      totalLevel: jsonSerialization['totalLevel'] as int?,
      proficiencyBonus: jsonSerialization['proficiencyBonus'] as int?,
      abilityScores: jsonSerialization['abilityScores'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<_iw3bk51e.Ability, int>>(
              jsonSerialization['abilityScores'],
            ),
      abilityModifiers: jsonSerialization['abilityModifiers'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<_iw3bk51e.Ability, int>>(
              jsonSerialization['abilityModifiers'],
            ),
      activeFeatures: jsonSerialization['activeFeatures'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_i66hj7xp.CharacterFeatureViewData>>(
                  jsonSerialization['activeFeatures'],
                ),
      featureModifiers: jsonSerialization['featureModifiers'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ilc9jnh2.FeatureModifierData>>(
                  jsonSerialization['featureModifiers'],
                ),
      armorClass: jsonSerialization['armorClass'] as int?,
      armorClassSource: jsonSerialization['armorClassSource'] as String?,
      armorClassFormula: jsonSerialization['armorClassFormula'] as String?,
      initiative: jsonSerialization['initiative'] as int?,
      speed: jsonSerialization['speed'] as int?,
      maxHp: jsonSerialization['maxHp'] as int?,
      passivePerception: jsonSerialization['passivePerception'] as int?,
      passiveInvestigation: jsonSerialization['passiveInvestigation'] as int?,
      passiveInsight: jsonSerialization['passiveInsight'] as int?,
      savingThrowBonuses: jsonSerialization['savingThrowBonuses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<_iw3bk51e.Ability, int>>(
              jsonSerialization['savingThrowBonuses'],
            ),
      skillBonuses: jsonSerialization['skillBonuses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<_iqrhamom.Skill, int>>(
              jsonSerialization['skillBonuses'],
            ),
      skillProficiencyLevels:
          jsonSerialization['skillProficiencyLevels'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ipq2j7wi.CharacterSkillProficiencyState>>(
                  jsonSerialization['skillProficiencyLevels'],
                ),
      savingThrowProficiencies:
          jsonSerialization['savingThrowProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['savingThrowProficiencies'],
            ),
      spellSlots: jsonSerialization['spellSlots'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['spellSlots'],
            ),
      pactSlots: jsonSerialization['pactSlots'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['pactSlots'],
            ),
      hitDiceSummary: jsonSerialization['hitDiceSummary'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['hitDiceSummary'],
            ),
      languages: jsonSerialization['languages'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iiw0j43j.Language>>(
              jsonSerialization['languages'],
            ),
      toolProficiencyKeys: jsonSerialization['toolProficiencyKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['toolProficiencyKeys'],
            ),
      toolExpertiseKeys: jsonSerialization['toolExpertiseKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['toolExpertiseKeys'],
            ),
      armorTraining: jsonSerialization['armorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_irzuusaf.ArmorCategory>>(
              jsonSerialization['armorTraining'],
            ),
      weaponTraining: jsonSerialization['weaponTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ibtz7e0l.WeaponCategory>>(
              jsonSerialization['weaponTraining'],
            ),
      weaponProficiencyKeys: jsonSerialization['weaponProficiencyKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['weaponProficiencyKeys'],
            ),
      customLanguages: jsonSerialization['customLanguages'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['customLanguages'],
            ),
      customToolProficiencies:
          jsonSerialization['customToolProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['customToolProficiencies'],
            ),
      customWeaponProficiencies:
          jsonSerialization['customWeaponProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['customWeaponProficiencies'],
            ),
      customArmorTraining: jsonSerialization['customArmorTraining'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['customArmorTraining'],
            ),
      grantedSpellKeys: jsonSerialization['grantedSpellKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['grantedSpellKeys'],
            ),
      alwaysPreparedSpellKeys:
          jsonSerialization['alwaysPreparedSpellKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['alwaysPreparedSpellKeys'],
            ),
      resolvedSpells: jsonSerialization['resolvedSpells'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ijr8g5vf.ResolvedCharacterSpellData>>(
                  jsonSerialization['resolvedSpells'],
                ),
      grantedEquipment: jsonSerialization['grantedEquipment'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iewpbuzi.CharacterEquipmentEntryView>>(
                  jsonSerialization['grantedEquipment'],
                ),
      resistances: jsonSerialization['resistances'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ij9bzpyl.DamageType>>(
              jsonSerialization['resistances'],
            ),
    );
  }

  int? totalLevel;

  int? proficiencyBonus;

  Map<_iw3bk51e.Ability, int>? abilityScores;

  Map<_iw3bk51e.Ability, int>? abilityModifiers;

  List<_i66hj7xp.CharacterFeatureViewData>? activeFeatures;

  List<_ilc9jnh2.FeatureModifierData>? featureModifiers;

  int? armorClass;

  String? armorClassSource;

  String? armorClassFormula;

  int? initiative;

  int? speed;

  int? maxHp;

  int? passivePerception;

  int? passiveInvestigation;

  int? passiveInsight;

  Map<_iw3bk51e.Ability, int>? savingThrowBonuses;

  Map<_iqrhamom.Skill, int>? skillBonuses;

  List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyLevels;

  List<_iw3bk51e.Ability>? savingThrowProficiencies;

  Map<int, int>? spellSlots;

  Map<int, int>? pactSlots;

  Map<String, int>? hitDiceSummary;

  List<_iiw0j43j.Language>? languages;

  List<String>? toolProficiencyKeys;

  List<String>? toolExpertiseKeys;

  List<_irzuusaf.ArmorCategory>? armorTraining;

  List<_ibtz7e0l.WeaponCategory>? weaponTraining;

  List<String>? weaponProficiencyKeys;

  List<String>? customLanguages;

  List<String>? customToolProficiencies;

  List<String>? customWeaponProficiencies;

  List<String>? customArmorTraining;

  List<String>? grantedSpellKeys;

  List<String>? alwaysPreparedSpellKeys;

  List<_ijr8g5vf.ResolvedCharacterSpellData>? resolvedSpells;

  List<_iewpbuzi.CharacterEquipmentEntryView>? grantedEquipment;

  List<_ij9bzpyl.DamageType>? resistances;

  /// Returns a shallow copy of this [CharacterDerivedData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterDerivedData copyWith({
    int? totalLevel,
    int? proficiencyBonus,
    Map<_iw3bk51e.Ability, int>? abilityScores,
    Map<_iw3bk51e.Ability, int>? abilityModifiers,
    List<_i66hj7xp.CharacterFeatureViewData>? activeFeatures,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
    int? armorClass,
    String? armorClassSource,
    String? armorClassFormula,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<_iw3bk51e.Ability, int>? savingThrowBonuses,
    Map<_iqrhamom.Skill, int>? skillBonuses,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<_iiw0j43j.Language>? languages,
    List<String>? toolProficiencyKeys,
    List<String>? toolExpertiseKeys,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<_ibtz7e0l.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? customLanguages,
    List<String>? customToolProficiencies,
    List<String>? customWeaponProficiencies,
    List<String>? customArmorTraining,
    List<String>? grantedSpellKeys,
    List<String>? alwaysPreparedSpellKeys,
    List<_ijr8g5vf.ResolvedCharacterSpellData>? resolvedSpells,
    List<_iewpbuzi.CharacterEquipmentEntryView>? grantedEquipment,
    List<_ij9bzpyl.DamageType>? resistances,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterDerivedData',
      if (totalLevel != null) 'totalLevel': totalLevel,
      if (proficiencyBonus != null) 'proficiencyBonus': proficiencyBonus,
      if (abilityScores != null)
        'abilityScores': abilityScores?.toJson(keyToJson: (k) => k.toJson()),
      if (abilityModifiers != null)
        'abilityModifiers': abilityModifiers?.toJson(
          keyToJson: (k) => k.toJson(),
        ),
      if (activeFeatures != null)
        'activeFeatures': activeFeatures?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (featureModifiers != null)
        'featureModifiers': featureModifiers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
        'savingThrowBonuses': savingThrowBonuses?.toJson(
          keyToJson: (k) => k.toJson(),
        ),
      if (skillBonuses != null)
        'skillBonuses': skillBonuses?.toJson(keyToJson: (k) => k.toJson()),
      if (skillProficiencyLevels != null)
        'skillProficiencyLevels': skillProficiencyLevels?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies': savingThrowProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
        'weaponTraining': weaponTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      if (resolvedSpells != null)
        'resolvedSpells': resolvedSpells?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (grantedEquipment != null)
        'grantedEquipment': grantedEquipment?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterDerivedData',
      if (totalLevel != null) 'totalLevel': totalLevel,
      if (proficiencyBonus != null) 'proficiencyBonus': proficiencyBonus,
      if (abilityScores != null)
        'abilityScores': abilityScores?.toJson(keyToJson: (k) => k.toJson()),
      if (abilityModifiers != null)
        'abilityModifiers': abilityModifiers?.toJson(
          keyToJson: (k) => k.toJson(),
        ),
      if (activeFeatures != null)
        'activeFeatures': activeFeatures?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (featureModifiers != null)
        'featureModifiers': featureModifiers?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
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
        'savingThrowBonuses': savingThrowBonuses?.toJson(
          keyToJson: (k) => k.toJson(),
        ),
      if (skillBonuses != null)
        'skillBonuses': skillBonuses?.toJson(keyToJson: (k) => k.toJson()),
      if (skillProficiencyLevels != null)
        'skillProficiencyLevels': skillProficiencyLevels?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies': savingThrowProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
        'weaponTraining': weaponTraining?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
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
      if (resolvedSpells != null)
        'resolvedSpells': resolvedSpells?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (grantedEquipment != null)
        'grantedEquipment': grantedEquipment?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterDerivedDataImpl extends CharacterDerivedData {
  _CharacterDerivedDataImpl({
    int? totalLevel,
    int? proficiencyBonus,
    Map<_iw3bk51e.Ability, int>? abilityScores,
    Map<_iw3bk51e.Ability, int>? abilityModifiers,
    List<_i66hj7xp.CharacterFeatureViewData>? activeFeatures,
    List<_ilc9jnh2.FeatureModifierData>? featureModifiers,
    int? armorClass,
    String? armorClassSource,
    String? armorClassFormula,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<_iw3bk51e.Ability, int>? savingThrowBonuses,
    Map<_iqrhamom.Skill, int>? skillBonuses,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_iw3bk51e.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<_iiw0j43j.Language>? languages,
    List<String>? toolProficiencyKeys,
    List<String>? toolExpertiseKeys,
    List<_irzuusaf.ArmorCategory>? armorTraining,
    List<_ibtz7e0l.WeaponCategory>? weaponTraining,
    List<String>? weaponProficiencyKeys,
    List<String>? customLanguages,
    List<String>? customToolProficiencies,
    List<String>? customWeaponProficiencies,
    List<String>? customArmorTraining,
    List<String>? grantedSpellKeys,
    List<String>? alwaysPreparedSpellKeys,
    List<_ijr8g5vf.ResolvedCharacterSpellData>? resolvedSpells,
    List<_iewpbuzi.CharacterEquipmentEntryView>? grantedEquipment,
    List<_ij9bzpyl.DamageType>? resistances,
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
         resolvedSpells: resolvedSpells,
         grantedEquipment: grantedEquipment,
         resistances: resistances,
       );

  /// Returns a shallow copy of this [CharacterDerivedData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
    Object? resolvedSpells = _Undefined,
    Object? grantedEquipment = _Undefined,
    Object? resistances = _Undefined,
  }) {
    return CharacterDerivedData(
      totalLevel: totalLevel is int? ? totalLevel : this.totalLevel,
      proficiencyBonus: proficiencyBonus is int?
          ? proficiencyBonus
          : this.proficiencyBonus,
      abilityScores: abilityScores is Map<_iw3bk51e.Ability, int>?
          ? abilityScores
          : this.abilityScores?.map((key0, value0) => MapEntry(key0, value0)),
      abilityModifiers: abilityModifiers is Map<_iw3bk51e.Ability, int>?
          ? abilityModifiers
          : this.abilityModifiers?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      activeFeatures:
          activeFeatures is List<_i66hj7xp.CharacterFeatureViewData>?
          ? activeFeatures
          : this.activeFeatures?.map((e0) => e0.copyWith()).toList(),
      featureModifiers: featureModifiers is List<_ilc9jnh2.FeatureModifierData>?
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
      passiveInsight: passiveInsight is int?
          ? passiveInsight
          : this.passiveInsight,
      savingThrowBonuses: savingThrowBonuses is Map<_iw3bk51e.Ability, int>?
          ? savingThrowBonuses
          : this.savingThrowBonuses?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      skillBonuses: skillBonuses is Map<_iqrhamom.Skill, int>?
          ? skillBonuses
          : this.skillBonuses?.map((key0, value0) => MapEntry(key0, value0)),
      skillProficiencyLevels:
          skillProficiencyLevels
              is List<_ipq2j7wi.CharacterSkillProficiencyState>?
          ? skillProficiencyLevels
          : this.skillProficiencyLevels?.map((e0) => e0.copyWith()).toList(),
      savingThrowProficiencies:
          savingThrowProficiencies is List<_iw3bk51e.Ability>?
          ? savingThrowProficiencies
          : this.savingThrowProficiencies?.map((e0) => e0).toList(),
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((key0, value0) => MapEntry(key0, value0)),
      pactSlots: pactSlots is Map<int, int>?
          ? pactSlots
          : this.pactSlots?.map((key0, value0) => MapEntry(key0, value0)),
      hitDiceSummary: hitDiceSummary is Map<String, int>?
          ? hitDiceSummary
          : this.hitDiceSummary?.map((key0, value0) => MapEntry(key0, value0)),
      languages: languages is List<_iiw0j43j.Language>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      toolProficiencyKeys: toolProficiencyKeys is List<String>?
          ? toolProficiencyKeys
          : this.toolProficiencyKeys?.map((e0) => e0).toList(),
      toolExpertiseKeys: toolExpertiseKeys is List<String>?
          ? toolExpertiseKeys
          : this.toolExpertiseKeys?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<_irzuusaf.ArmorCategory>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<_ibtz7e0l.WeaponCategory>?
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
      resolvedSpells:
          resolvedSpells is List<_ijr8g5vf.ResolvedCharacterSpellData>?
          ? resolvedSpells
          : this.resolvedSpells?.map((e0) => e0.copyWith()).toList(),
      grantedEquipment:
          grantedEquipment is List<_iewpbuzi.CharacterEquipmentEntryView>?
          ? grantedEquipment
          : this.grantedEquipment?.map((e0) => e0.copyWith()).toList(),
      resistances: resistances is List<_ij9bzpyl.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
    );
  }
}
