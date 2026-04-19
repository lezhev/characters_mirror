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
import '../../../data/general/character/character_feature_view_data.dart'
    as _i2;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _i3;
import '../../../enums/ability.dart' as _i4;
import '../../../enums/feature_tag.dart' as _i5;
import '../../../views/character_equipment_entry_view.dart' as _i6;
import '../../../enums/damage_type.dart' as _i7;

abstract class CharacterDerivedData implements _i1.SerializableModel {
  CharacterDerivedData._({
    this.totalLevel,
    this.proficiencyBonus,
    this.abilityScores,
    this.abilityModifiers,
    this.activeFeatures,
    this.armorClass,
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
    this.toolProficiencies,
    this.armorTraining,
    this.weaponTraining,
    this.featureTags,
    this.featIds,
    this.grantedSpellKeys,
    this.grantedEquipment,
    this.senses,
    this.resistances,
    this.rebuiltAt,
  });

  factory CharacterDerivedData({
    int? totalLevel,
    int? proficiencyBonus,
    Map<String, int>? abilityScores,
    Map<String, int>? abilityModifiers,
    List<_i2.CharacterFeatureViewData>? activeFeatures,
    int? armorClass,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<String, int>? savingThrowBonuses,
    Map<String, int>? skillBonuses,
    List<_i3.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_i4.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<String>? languages,
    List<String>? toolProficiencies,
    List<String>? armorTraining,
    List<String>? weaponTraining,
    List<_i5.FeatureTag>? featureTags,
    List<int>? featIds,
    List<String>? grantedSpellKeys,
    List<_i6.CharacterEquipmentEntryView>? grantedEquipment,
    List<String>? senses,
    List<_i7.DamageType>? resistances,
    DateTime? rebuiltAt,
  }) = _CharacterDerivedDataImpl;

  factory CharacterDerivedData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterDerivedData(
      totalLevel: jsonSerialization['totalLevel'] as int?,
      proficiencyBonus: jsonSerialization['proficiencyBonus'] as int?,
      abilityScores:
          (jsonSerialization['abilityScores'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      abilityModifiers: (jsonSerialization['abilityModifiers'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      activeFeatures: (jsonSerialization['activeFeatures'] as List?)
          ?.map((e) => _i2.CharacterFeatureViewData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      armorClass: jsonSerialization['armorClass'] as int?,
      initiative: jsonSerialization['initiative'] as int?,
      speed: jsonSerialization['speed'] as int?,
      maxHp: jsonSerialization['maxHp'] as int?,
      passivePerception: jsonSerialization['passivePerception'] as int?,
      passiveInvestigation: jsonSerialization['passiveInvestigation'] as int?,
      passiveInsight: jsonSerialization['passiveInsight'] as int?,
      savingThrowBonuses: (jsonSerialization['savingThrowBonuses'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      skillBonuses:
          (jsonSerialization['skillBonuses'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      skillProficiencyLevels:
          (jsonSerialization['skillProficiencyLevels'] as List?)
              ?.map((e) => _i3.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      savingThrowProficiencies:
          (jsonSerialization['savingThrowProficiencies'] as List?)
              ?.map((e) => _i4.Ability.fromJson((e as String)))
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
          ?.map((e) => e as String)
          .toList(),
      toolProficiencies: (jsonSerialization['toolProficiencies'] as List?)
          ?.map((e) => e as String)
          .toList(),
      armorTraining: (jsonSerialization['armorTraining'] as List?)
          ?.map((e) => e as String)
          .toList(),
      weaponTraining: (jsonSerialization['weaponTraining'] as List?)
          ?.map((e) => e as String)
          .toList(),
      featureTags: (jsonSerialization['featureTags'] as List?)
          ?.map((e) => _i5.FeatureTag.fromJson((e as String)))
          .toList(),
      featIds: (jsonSerialization['featIds'] as List?)
          ?.map((e) => e as int)
          .toList(),
      grantedSpellKeys: (jsonSerialization['grantedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      grantedEquipment: (jsonSerialization['grantedEquipment'] as List?)
          ?.map((e) => _i6.CharacterEquipmentEntryView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      senses: (jsonSerialization['senses'] as List?)
          ?.map((e) => e as String)
          .toList(),
      resistances: (jsonSerialization['resistances'] as List?)
          ?.map((e) => _i7.DamageType.fromJson((e as String)))
          .toList(),
      rebuiltAt: jsonSerialization['rebuiltAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['rebuiltAt']),
    );
  }

  int? totalLevel;

  int? proficiencyBonus;

  Map<String, int>? abilityScores;

  Map<String, int>? abilityModifiers;

  List<_i2.CharacterFeatureViewData>? activeFeatures;

  int? armorClass;

  int? initiative;

  int? speed;

  int? maxHp;

  int? passivePerception;

  int? passiveInvestigation;

  int? passiveInsight;

  Map<String, int>? savingThrowBonuses;

  Map<String, int>? skillBonuses;

  List<_i3.CharacterSkillProficiencyState>? skillProficiencyLevels;

  List<_i4.Ability>? savingThrowProficiencies;

  Map<int, int>? spellSlots;

  Map<int, int>? pactSlots;

  Map<String, int>? hitDiceSummary;

  List<String>? languages;

  List<String>? toolProficiencies;

  List<String>? armorTraining;

  List<String>? weaponTraining;

  List<_i5.FeatureTag>? featureTags;

  List<int>? featIds;

  List<String>? grantedSpellKeys;

  List<_i6.CharacterEquipmentEntryView>? grantedEquipment;

  List<String>? senses;

  List<_i7.DamageType>? resistances;

  DateTime? rebuiltAt;

  /// Returns a shallow copy of this [CharacterDerivedData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterDerivedData copyWith({
    int? totalLevel,
    int? proficiencyBonus,
    Map<String, int>? abilityScores,
    Map<String, int>? abilityModifiers,
    List<_i2.CharacterFeatureViewData>? activeFeatures,
    int? armorClass,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<String, int>? savingThrowBonuses,
    Map<String, int>? skillBonuses,
    List<_i3.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_i4.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<String>? languages,
    List<String>? toolProficiencies,
    List<String>? armorTraining,
    List<String>? weaponTraining,
    List<_i5.FeatureTag>? featureTags,
    List<int>? featIds,
    List<String>? grantedSpellKeys,
    List<_i6.CharacterEquipmentEntryView>? grantedEquipment,
    List<String>? senses,
    List<_i7.DamageType>? resistances,
    DateTime? rebuiltAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (totalLevel != null) 'totalLevel': totalLevel,
      if (proficiencyBonus != null) 'proficiencyBonus': proficiencyBonus,
      if (abilityScores != null) 'abilityScores': abilityScores?.toJson(),
      if (abilityModifiers != null)
        'abilityModifiers': abilityModifiers?.toJson(),
      if (activeFeatures != null)
        'activeFeatures':
            activeFeatures?.toJson(valueToJson: (v) => v.toJson()),
      if (armorClass != null) 'armorClass': armorClass,
      if (initiative != null) 'initiative': initiative,
      if (speed != null) 'speed': speed,
      if (maxHp != null) 'maxHp': maxHp,
      if (passivePerception != null) 'passivePerception': passivePerception,
      if (passiveInvestigation != null)
        'passiveInvestigation': passiveInvestigation,
      if (passiveInsight != null) 'passiveInsight': passiveInsight,
      if (savingThrowBonuses != null)
        'savingThrowBonuses': savingThrowBonuses?.toJson(),
      if (skillBonuses != null) 'skillBonuses': skillBonuses?.toJson(),
      if (skillProficiencyLevels != null)
        'skillProficiencyLevels':
            skillProficiencyLevels?.toJson(valueToJson: (v) => v.toJson()),
      if (savingThrowProficiencies != null)
        'savingThrowProficiencies':
            savingThrowProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (pactSlots != null) 'pactSlots': pactSlots?.toJson(),
      if (hitDiceSummary != null) 'hitDiceSummary': hitDiceSummary?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (toolProficiencies != null)
        'toolProficiencies': toolProficiencies?.toJson(),
      if (armorTraining != null) 'armorTraining': armorTraining?.toJson(),
      if (weaponTraining != null) 'weaponTraining': weaponTraining?.toJson(),
      if (featureTags != null)
        'featureTags': featureTags?.toJson(valueToJson: (v) => v.toJson()),
      if (featIds != null) 'featIds': featIds?.toJson(),
      if (grantedSpellKeys != null)
        'grantedSpellKeys': grantedSpellKeys?.toJson(),
      if (grantedEquipment != null)
        'grantedEquipment':
            grantedEquipment?.toJson(valueToJson: (v) => v.toJson()),
      if (senses != null) 'senses': senses?.toJson(),
      if (resistances != null)
        'resistances': resistances?.toJson(valueToJson: (v) => v.toJson()),
      if (rebuiltAt != null) 'rebuiltAt': rebuiltAt?.toJson(),
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
    Map<String, int>? abilityScores,
    Map<String, int>? abilityModifiers,
    List<_i2.CharacterFeatureViewData>? activeFeatures,
    int? armorClass,
    int? initiative,
    int? speed,
    int? maxHp,
    int? passivePerception,
    int? passiveInvestigation,
    int? passiveInsight,
    Map<String, int>? savingThrowBonuses,
    Map<String, int>? skillBonuses,
    List<_i3.CharacterSkillProficiencyState>? skillProficiencyLevels,
    List<_i4.Ability>? savingThrowProficiencies,
    Map<int, int>? spellSlots,
    Map<int, int>? pactSlots,
    Map<String, int>? hitDiceSummary,
    List<String>? languages,
    List<String>? toolProficiencies,
    List<String>? armorTraining,
    List<String>? weaponTraining,
    List<_i5.FeatureTag>? featureTags,
    List<int>? featIds,
    List<String>? grantedSpellKeys,
    List<_i6.CharacterEquipmentEntryView>? grantedEquipment,
    List<String>? senses,
    List<_i7.DamageType>? resistances,
    DateTime? rebuiltAt,
  }) : super._(
          totalLevel: totalLevel,
          proficiencyBonus: proficiencyBonus,
          abilityScores: abilityScores,
          abilityModifiers: abilityModifiers,
          activeFeatures: activeFeatures,
          armorClass: armorClass,
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
          toolProficiencies: toolProficiencies,
          armorTraining: armorTraining,
          weaponTraining: weaponTraining,
          featureTags: featureTags,
          featIds: featIds,
          grantedSpellKeys: grantedSpellKeys,
          grantedEquipment: grantedEquipment,
          senses: senses,
          resistances: resistances,
          rebuiltAt: rebuiltAt,
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
    Object? armorClass = _Undefined,
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
    Object? toolProficiencies = _Undefined,
    Object? armorTraining = _Undefined,
    Object? weaponTraining = _Undefined,
    Object? featureTags = _Undefined,
    Object? featIds = _Undefined,
    Object? grantedSpellKeys = _Undefined,
    Object? grantedEquipment = _Undefined,
    Object? senses = _Undefined,
    Object? resistances = _Undefined,
    Object? rebuiltAt = _Undefined,
  }) {
    return CharacterDerivedData(
      totalLevel: totalLevel is int? ? totalLevel : this.totalLevel,
      proficiencyBonus:
          proficiencyBonus is int? ? proficiencyBonus : this.proficiencyBonus,
      abilityScores: abilityScores is Map<String, int>?
          ? abilityScores
          : this.abilityScores?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      abilityModifiers: abilityModifiers is Map<String, int>?
          ? abilityModifiers
          : this.abilityModifiers?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      activeFeatures: activeFeatures is List<_i2.CharacterFeatureViewData>?
          ? activeFeatures
          : this.activeFeatures?.map((e0) => e0.copyWith()).toList(),
      armorClass: armorClass is int? ? armorClass : this.armorClass,
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
      savingThrowBonuses: savingThrowBonuses is Map<String, int>?
          ? savingThrowBonuses
          : this.savingThrowBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      skillBonuses: skillBonuses is Map<String, int>?
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
              is List<_i3.CharacterSkillProficiencyState>?
          ? skillProficiencyLevels
          : this.skillProficiencyLevels?.map((e0) => e0.copyWith()).toList(),
      savingThrowProficiencies: savingThrowProficiencies is List<_i4.Ability>?
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
      languages: languages is List<String>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      toolProficiencies: toolProficiencies is List<String>?
          ? toolProficiencies
          : this.toolProficiencies?.map((e0) => e0).toList(),
      armorTraining: armorTraining is List<String>?
          ? armorTraining
          : this.armorTraining?.map((e0) => e0).toList(),
      weaponTraining: weaponTraining is List<String>?
          ? weaponTraining
          : this.weaponTraining?.map((e0) => e0).toList(),
      featureTags: featureTags is List<_i5.FeatureTag>?
          ? featureTags
          : this.featureTags?.map((e0) => e0).toList(),
      featIds: featIds is List<int>?
          ? featIds
          : this.featIds?.map((e0) => e0).toList(),
      grantedSpellKeys: grantedSpellKeys is List<String>?
          ? grantedSpellKeys
          : this.grantedSpellKeys?.map((e0) => e0).toList(),
      grantedEquipment:
          grantedEquipment is List<_i6.CharacterEquipmentEntryView>?
              ? grantedEquipment
              : this.grantedEquipment?.map((e0) => e0.copyWith()).toList(),
      senses: senses is List<String>?
          ? senses
          : this.senses?.map((e0) => e0).toList(),
      resistances: resistances is List<_i7.DamageType>?
          ? resistances
          : this.resistances?.map((e0) => e0).toList(),
      rebuiltAt: rebuiltAt is DateTime? ? rebuiltAt : this.rebuiltAt,
    );
  }
}
