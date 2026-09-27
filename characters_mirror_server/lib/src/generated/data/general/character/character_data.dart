/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../../../enums/character_alignment.dart' as _i2;
import '../../../data/general/race/race_data.dart' as _i3;
import '../../../data/general/race/subrace_data.dart' as _i4;
import '../../../data/background_data.dart' as _i5;
import '../../../enums/character_speed_kind.dart' as _i6;
import '../../../enums/condition_type.dart' as _i7;
import '../../../data/general/character/character_inventory_item_data.dart'
    as _i8;
import '../../../data/general/character/character_equipment_selection_data.dart'
    as _i9;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _i10;
import '../../../enums/ability.dart' as _i11;
import '../../../data/general/character/character_saving_throw_proficiency_override_data.dart'
    as _i12;
import '../../../data/general/character/character_language_overrides_data.dart'
    as _i13;
import '../../../data/general/character/character_tool_proficiency_overrides_data.dart'
    as _i14;
import '../../../data/general/character/character_weapon_proficiency_overrides_data.dart'
    as _i15;
import '../../../data/general/character/character_armor_training_overrides_data.dart'
    as _i16;
import '../../../data/general/character/character_note_data.dart' as _i17;
import '../../../data/general/character/character_attack_data.dart' as _i18;
import '../../../data/general/character/character_feature_override_data.dart'
    as _i19;
import '../../../data/general/character/character_resource_state_data.dart'
    as _i20;
import '../../../data/general/character/character_class_entry_data.dart'
    as _i21;
import '../../../data/general/character/character_choice_data.dart' as _i22;
import '../../../data/general/character/character_skill_selection_data.dart'
    as _i23;
import '../../../data/general/character/character_spell_selection_data.dart'
    as _i24;
import '../../../data/general/character/character_starting_equipment_selection_data.dart'
    as _i25;
import '../../../data/general/character/character_derived_data.dart' as _i26;

abstract class CharacterData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterData._({
    this.id,
    this.name,
    this.age,
    this.height,
    this.weight,
    this.eyes,
    this.skin,
    this.hair,
    this.appearance,
    this.backstory,
    this.goals,
    this.alliesOrganizations,
    this.personalityTraits,
    this.ideals,
    this.bonds,
    this.flaws,
    this.version,
    this.portraitVersion,
    this.syncTargetRevisions,
    this.syncBarrierTokens,
    this.createdAt,
    this.updatedAt,
    this.experience,
    this.alignmentValue,
    this.race,
    this.subrace,
    this.background,
    this.baseAbilityScores,
    this.customAbilityBonuses,
    this.useFlexibleAbilityBonuses,
    this.temporaryHp,
    this.currentHp,
    this.deathSaveSuccesses,
    this.deathSaveFailures,
    this.hpPerLevelBonus,
    this.hpFlatBonus,
    this.currentHitDice,
    this.hitDiceMaxOverrides,
    this.currentSpellSlots,
    this.activeConcentrationSpellName,
    this.customInitiativeBonus,
    this.customArmorClassBonus,
    this.walkingSpeed,
    this.swimmingSpeed,
    this.climbingSpeed,
    this.flyingSpeed,
    this.displayedSpeedKind,
    this.customSpellSaveDcBonus,
    this.customSpellAttackBonus,
    this.preparedSpellKeys,
    this.activeConditions,
    this.exhaustionLevel,
    this.inspiration,
    this.equipment,
    this.equippedArmor,
    this.equippedShield,
    this.manualSkillProficiencies,
    this.manualSavingThrowProficiencies,
    this.manualSkillProficiencyOverrides,
    this.manualSavingThrowProficiencyOverrides,
    this.manualLanguageOverrides,
    this.manualToolProficiencyOverrides,
    this.manualWeaponProficiencyOverrides,
    this.manualArmorTrainingOverrides,
    this.notes,
    this.attacks,
    this.featureOverrides,
    this.resourceStates,
    this.classEntries,
    this.choices,
    this.skillSelections,
    this.spellSelections,
    this.startingEquipmentSelections,
    this.derived,
  });

  factory CharacterData({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    int? portraitVersion,
    Map<String, int>? syncTargetRevisions,
    Map<String, String>? syncBarrierTokens,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    _i3.RaceData? race,
    _i4.SubraceData? subrace,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    int? deathSaveSuccesses,
    int? deathSaveFailures,
    int? hpPerLevelBonus,
    int? hpFlatBonus,
    Map<String, int>? currentHitDice,
    Map<String, int>? hitDiceMaxOverrides,
    Map<int, int>? currentSpellSlots,
    String? activeConcentrationSpellName,
    int? customInitiativeBonus,
    int? customArmorClassBonus,
    int? walkingSpeed,
    int? swimmingSpeed,
    int? climbingSpeed,
    int? flyingSpeed,
    _i6.CharacterSpeedKind? displayedSpeedKind,
    int? customSpellSaveDcBonus,
    int? customSpellAttackBonus,
    List<String>? preparedSpellKeys,
    List<_i7.ConditionType>? activeConditions,
    int? exhaustionLevel,
    bool? inspiration,
    List<_i8.CharacterInventoryItemData>? equipment,
    _i9.CharacterEquipmentSelectionData? equippedArmor,
    _i9.CharacterEquipmentSelectionData? equippedShield,
    List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i11.Ability>? manualSavingThrowProficiencies,
    List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencyOverrides,
    List<_i12.CharacterSavingThrowProficiencyOverrideData>?
        manualSavingThrowProficiencyOverrides,
    _i13.CharacterLanguageOverridesData? manualLanguageOverrides,
    _i14.CharacterToolProficiencyOverridesData? manualToolProficiencyOverrides,
    _i15.CharacterWeaponProficiencyOverridesData?
        manualWeaponProficiencyOverrides,
    _i16.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides,
    List<_i17.CharacterNoteData>? notes,
    List<_i18.CharacterAttackData>? attacks,
    List<_i19.CharacterFeatureOverrideData>? featureOverrides,
    List<_i20.CharacterResourceStateData>? resourceStates,
    List<_i21.CharacterClassEntryData>? classEntries,
    List<_i22.CharacterChoiceData>? choices,
    List<_i23.CharacterSkillSelectionData>? skillSelections,
    List<_i24.CharacterSpellSelectionData>? spellSelections,
    List<_i25.CharacterStartingEquipmentSelectionData>?
        startingEquipmentSelections,
    _i26.CharacterDerivedData? derived,
  }) = _CharacterDataImpl;

  factory CharacterData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterData(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String?,
      age: jsonSerialization['age'] as String?,
      height: jsonSerialization['height'] as String?,
      weight: jsonSerialization['weight'] as String?,
      eyes: jsonSerialization['eyes'] as String?,
      skin: jsonSerialization['skin'] as String?,
      hair: jsonSerialization['hair'] as String?,
      appearance: jsonSerialization['appearance'] as String?,
      backstory: jsonSerialization['backstory'] as String?,
      goals: jsonSerialization['goals'] as String?,
      alliesOrganizations: jsonSerialization['alliesOrganizations'] as String?,
      personalityTraits: jsonSerialization['personalityTraits'] as String?,
      ideals: jsonSerialization['ideals'] as String?,
      bonds: jsonSerialization['bonds'] as String?,
      flaws: jsonSerialization['flaws'] as String?,
      version: jsonSerialization['version'] as int?,
      portraitVersion: jsonSerialization['portraitVersion'] as int?,
      syncTargetRevisions: (jsonSerialization['syncTargetRevisions'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      syncBarrierTokens: (jsonSerialization['syncBarrierTokens'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as String,
              )),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      experience: jsonSerialization['experience'] as int?,
      alignmentValue: jsonSerialization['alignmentValue'] == null
          ? null
          : _i2.CharacterAlignment.fromJson(
              (jsonSerialization['alignmentValue'] as String)),
      race: jsonSerialization['race'] == null
          ? null
          : _i3.RaceData.fromJson(
              (jsonSerialization['race'] as Map<String, dynamic>)),
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _i4.SubraceData.fromJson(
              (jsonSerialization['subrace'] as Map<String, dynamic>)),
      background: jsonSerialization['background'] == null
          ? null
          : _i5.BackgroundData.fromJson(
              (jsonSerialization['background'] as Map<String, dynamic>)),
      baseAbilityScores: (jsonSerialization['baseAbilityScores'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      customAbilityBonuses: (jsonSerialization['customAbilityBonuses'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      useFlexibleAbilityBonuses:
          jsonSerialization['useFlexibleAbilityBonuses'] as bool?,
      temporaryHp: jsonSerialization['temporaryHp'] as int?,
      currentHp: jsonSerialization['currentHp'] as int?,
      deathSaveSuccesses: jsonSerialization['deathSaveSuccesses'] as int?,
      deathSaveFailures: jsonSerialization['deathSaveFailures'] as int?,
      hpPerLevelBonus: jsonSerialization['hpPerLevelBonus'] as int?,
      hpFlatBonus: jsonSerialization['hpFlatBonus'] as int?,
      currentHitDice:
          (jsonSerialization['currentHitDice'] as Map?)?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      hitDiceMaxOverrides: (jsonSerialization['hitDiceMaxOverrides'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      currentSpellSlots: (jsonSerialization['currentSpellSlots'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      activeConcentrationSpellName:
          jsonSerialization['activeConcentrationSpellName'] as String?,
      customInitiativeBonus: jsonSerialization['customInitiativeBonus'] as int?,
      customArmorClassBonus: jsonSerialization['customArmorClassBonus'] as int?,
      walkingSpeed: jsonSerialization['walkingSpeed'] as int?,
      swimmingSpeed: jsonSerialization['swimmingSpeed'] as int?,
      climbingSpeed: jsonSerialization['climbingSpeed'] as int?,
      flyingSpeed: jsonSerialization['flyingSpeed'] as int?,
      displayedSpeedKind: jsonSerialization['displayedSpeedKind'] == null
          ? null
          : _i6.CharacterSpeedKind.fromJson(
              (jsonSerialization['displayedSpeedKind'] as int)),
      customSpellSaveDcBonus:
          jsonSerialization['customSpellSaveDcBonus'] as int?,
      customSpellAttackBonus:
          jsonSerialization['customSpellAttackBonus'] as int?,
      preparedSpellKeys: (jsonSerialization['preparedSpellKeys'] as List?)
          ?.map((e) => e as String)
          .toList(),
      activeConditions: (jsonSerialization['activeConditions'] as List?)
          ?.map((e) => _i7.ConditionType.fromJson((e as String)))
          .toList(),
      exhaustionLevel: jsonSerialization['exhaustionLevel'] as int?,
      inspiration: jsonSerialization['inspiration'] as bool?,
      equipment: (jsonSerialization['equipment'] as List?)
          ?.map((e) => _i8.CharacterInventoryItemData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      equippedArmor: jsonSerialization['equippedArmor'] == null
          ? null
          : _i9.CharacterEquipmentSelectionData.fromJson(
              (jsonSerialization['equippedArmor'] as Map<String, dynamic>)),
      equippedShield: jsonSerialization['equippedShield'] == null
          ? null
          : _i9.CharacterEquipmentSelectionData.fromJson(
              (jsonSerialization['equippedShield'] as Map<String, dynamic>)),
      manualSkillProficiencies:
          (jsonSerialization['manualSkillProficiencies'] as List?)
              ?.map((e) => _i10.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      manualSavingThrowProficiencies:
          (jsonSerialization['manualSavingThrowProficiencies'] as List?)
              ?.map((e) => _i11.Ability.fromJson((e as String)))
              .toList(),
      manualSkillProficiencyOverrides:
          (jsonSerialization['manualSkillProficiencyOverrides'] as List?)
              ?.map((e) => _i10.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      manualSavingThrowProficiencyOverrides:
          (jsonSerialization['manualSavingThrowProficiencyOverrides'] as List?)
              ?.map((e) =>
                  _i12.CharacterSavingThrowProficiencyOverrideData.fromJson(
                      (e as Map<String, dynamic>)))
              .toList(),
      manualLanguageOverrides:
          jsonSerialization['manualLanguageOverrides'] == null
              ? null
              : _i13.CharacterLanguageOverridesData.fromJson(
                  (jsonSerialization['manualLanguageOverrides']
                      as Map<String, dynamic>)),
      manualToolProficiencyOverrides:
          jsonSerialization['manualToolProficiencyOverrides'] == null
              ? null
              : _i14.CharacterToolProficiencyOverridesData.fromJson(
                  (jsonSerialization['manualToolProficiencyOverrides']
                      as Map<String, dynamic>)),
      manualWeaponProficiencyOverrides:
          jsonSerialization['manualWeaponProficiencyOverrides'] == null
              ? null
              : _i15.CharacterWeaponProficiencyOverridesData.fromJson(
                  (jsonSerialization['manualWeaponProficiencyOverrides']
                      as Map<String, dynamic>)),
      manualArmorTrainingOverrides:
          jsonSerialization['manualArmorTrainingOverrides'] == null
              ? null
              : _i16.CharacterArmorTrainingOverridesData.fromJson(
                  (jsonSerialization['manualArmorTrainingOverrides']
                      as Map<String, dynamic>)),
      notes: (jsonSerialization['notes'] as List?)
          ?.map((e) =>
              _i17.CharacterNoteData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      attacks: (jsonSerialization['attacks'] as List?)
          ?.map((e) =>
              _i18.CharacterAttackData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      featureOverrides: (jsonSerialization['featureOverrides'] as List?)
          ?.map((e) => _i19.CharacterFeatureOverrideData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      resourceStates: (jsonSerialization['resourceStates'] as List?)
          ?.map((e) => _i20.CharacterResourceStateData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      classEntries: (jsonSerialization['classEntries'] as List?)
          ?.map((e) => _i21.CharacterClassEntryData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      choices: (jsonSerialization['choices'] as List?)
          ?.map((e) =>
              _i22.CharacterChoiceData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      skillSelections: (jsonSerialization['skillSelections'] as List?)
          ?.map((e) => _i23.CharacterSkillSelectionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      spellSelections: (jsonSerialization['spellSelections'] as List?)
          ?.map((e) => _i24.CharacterSpellSelectionData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      startingEquipmentSelections:
          (jsonSerialization['startingEquipmentSelections'] as List?)
              ?.map((e) =>
                  _i25.CharacterStartingEquipmentSelectionData.fromJson(
                      (e as Map<String, dynamic>)))
              .toList(),
      derived: jsonSerialization['derived'] == null
          ? null
          : _i26.CharacterDerivedData.fromJson(
              (jsonSerialization['derived'] as Map<String, dynamic>)),
    );
  }

  int? id;

  String? name;

  String? age;

  String? height;

  String? weight;

  String? eyes;

  String? skin;

  String? hair;

  String? appearance;

  String? backstory;

  String? goals;

  String? alliesOrganizations;

  String? personalityTraits;

  String? ideals;

  String? bonds;

  String? flaws;

  int? version;

  int? portraitVersion;

  Map<String, int>? syncTargetRevisions;

  Map<String, String>? syncBarrierTokens;

  DateTime? createdAt;

  DateTime? updatedAt;

  int? experience;

  _i2.CharacterAlignment? alignmentValue;

  _i3.RaceData? race;

  _i4.SubraceData? subrace;

  _i5.BackgroundData? background;

  Map<String, int>? baseAbilityScores;

  Map<String, int>? customAbilityBonuses;

  bool? useFlexibleAbilityBonuses;

  int? temporaryHp;

  int? currentHp;

  int? deathSaveSuccesses;

  int? deathSaveFailures;

  int? hpPerLevelBonus;

  int? hpFlatBonus;

  Map<String, int>? currentHitDice;

  Map<String, int>? hitDiceMaxOverrides;

  Map<int, int>? currentSpellSlots;

  String? activeConcentrationSpellName;

  int? customInitiativeBonus;

  int? customArmorClassBonus;

  int? walkingSpeed;

  int? swimmingSpeed;

  int? climbingSpeed;

  int? flyingSpeed;

  _i6.CharacterSpeedKind? displayedSpeedKind;

  int? customSpellSaveDcBonus;

  int? customSpellAttackBonus;

  List<String>? preparedSpellKeys;

  List<_i7.ConditionType>? activeConditions;

  int? exhaustionLevel;

  bool? inspiration;

  List<_i8.CharacterInventoryItemData>? equipment;

  _i9.CharacterEquipmentSelectionData? equippedArmor;

  _i9.CharacterEquipmentSelectionData? equippedShield;

  List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencies;

  List<_i11.Ability>? manualSavingThrowProficiencies;

  List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencyOverrides;

  List<_i12.CharacterSavingThrowProficiencyOverrideData>?
      manualSavingThrowProficiencyOverrides;

  _i13.CharacterLanguageOverridesData? manualLanguageOverrides;

  _i14.CharacterToolProficiencyOverridesData? manualToolProficiencyOverrides;

  _i15.CharacterWeaponProficiencyOverridesData?
      manualWeaponProficiencyOverrides;

  _i16.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides;

  List<_i17.CharacterNoteData>? notes;

  List<_i18.CharacterAttackData>? attacks;

  List<_i19.CharacterFeatureOverrideData>? featureOverrides;

  List<_i20.CharacterResourceStateData>? resourceStates;

  List<_i21.CharacterClassEntryData>? classEntries;

  List<_i22.CharacterChoiceData>? choices;

  List<_i23.CharacterSkillSelectionData>? skillSelections;

  List<_i24.CharacterSpellSelectionData>? spellSelections;

  List<_i25.CharacterStartingEquipmentSelectionData>?
      startingEquipmentSelections;

  _i26.CharacterDerivedData? derived;

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterData copyWith({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    int? portraitVersion,
    Map<String, int>? syncTargetRevisions,
    Map<String, String>? syncBarrierTokens,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    _i3.RaceData? race,
    _i4.SubraceData? subrace,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    int? deathSaveSuccesses,
    int? deathSaveFailures,
    int? hpPerLevelBonus,
    int? hpFlatBonus,
    Map<String, int>? currentHitDice,
    Map<String, int>? hitDiceMaxOverrides,
    Map<int, int>? currentSpellSlots,
    String? activeConcentrationSpellName,
    int? customInitiativeBonus,
    int? customArmorClassBonus,
    int? walkingSpeed,
    int? swimmingSpeed,
    int? climbingSpeed,
    int? flyingSpeed,
    _i6.CharacterSpeedKind? displayedSpeedKind,
    int? customSpellSaveDcBonus,
    int? customSpellAttackBonus,
    List<String>? preparedSpellKeys,
    List<_i7.ConditionType>? activeConditions,
    int? exhaustionLevel,
    bool? inspiration,
    List<_i8.CharacterInventoryItemData>? equipment,
    _i9.CharacterEquipmentSelectionData? equippedArmor,
    _i9.CharacterEquipmentSelectionData? equippedShield,
    List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i11.Ability>? manualSavingThrowProficiencies,
    List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencyOverrides,
    List<_i12.CharacterSavingThrowProficiencyOverrideData>?
        manualSavingThrowProficiencyOverrides,
    _i13.CharacterLanguageOverridesData? manualLanguageOverrides,
    _i14.CharacterToolProficiencyOverridesData? manualToolProficiencyOverrides,
    _i15.CharacterWeaponProficiencyOverridesData?
        manualWeaponProficiencyOverrides,
    _i16.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides,
    List<_i17.CharacterNoteData>? notes,
    List<_i18.CharacterAttackData>? attacks,
    List<_i19.CharacterFeatureOverrideData>? featureOverrides,
    List<_i20.CharacterResourceStateData>? resourceStates,
    List<_i21.CharacterClassEntryData>? classEntries,
    List<_i22.CharacterChoiceData>? choices,
    List<_i23.CharacterSkillSelectionData>? skillSelections,
    List<_i24.CharacterSpellSelectionData>? spellSelections,
    List<_i25.CharacterStartingEquipmentSelectionData>?
        startingEquipmentSelections,
    _i26.CharacterDerivedData? derived,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (eyes != null) 'eyes': eyes,
      if (skin != null) 'skin': skin,
      if (hair != null) 'hair': hair,
      if (appearance != null) 'appearance': appearance,
      if (backstory != null) 'backstory': backstory,
      if (goals != null) 'goals': goals,
      if (alliesOrganizations != null)
        'alliesOrganizations': alliesOrganizations,
      if (personalityTraits != null) 'personalityTraits': personalityTraits,
      if (ideals != null) 'ideals': ideals,
      if (bonds != null) 'bonds': bonds,
      if (flaws != null) 'flaws': flaws,
      if (version != null) 'version': version,
      if (portraitVersion != null) 'portraitVersion': portraitVersion,
      if (syncTargetRevisions != null)
        'syncTargetRevisions': syncTargetRevisions?.toJson(),
      if (syncBarrierTokens != null)
        'syncBarrierTokens': syncBarrierTokens?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (experience != null) 'experience': experience,
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (race != null) 'race': race?.toJson(),
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (background != null) 'background': background?.toJson(),
      if (baseAbilityScores != null)
        'baseAbilityScores': baseAbilityScores?.toJson(),
      if (customAbilityBonuses != null)
        'customAbilityBonuses': customAbilityBonuses?.toJson(),
      if (useFlexibleAbilityBonuses != null)
        'useFlexibleAbilityBonuses': useFlexibleAbilityBonuses,
      if (temporaryHp != null) 'temporaryHp': temporaryHp,
      if (currentHp != null) 'currentHp': currentHp,
      if (deathSaveSuccesses != null) 'deathSaveSuccesses': deathSaveSuccesses,
      if (deathSaveFailures != null) 'deathSaveFailures': deathSaveFailures,
      if (hpPerLevelBonus != null) 'hpPerLevelBonus': hpPerLevelBonus,
      if (hpFlatBonus != null) 'hpFlatBonus': hpFlatBonus,
      if (currentHitDice != null) 'currentHitDice': currentHitDice?.toJson(),
      if (hitDiceMaxOverrides != null)
        'hitDiceMaxOverrides': hitDiceMaxOverrides?.toJson(),
      if (currentSpellSlots != null)
        'currentSpellSlots': currentSpellSlots?.toJson(),
      if (activeConcentrationSpellName != null)
        'activeConcentrationSpellName': activeConcentrationSpellName,
      if (customInitiativeBonus != null)
        'customInitiativeBonus': customInitiativeBonus,
      if (customArmorClassBonus != null)
        'customArmorClassBonus': customArmorClassBonus,
      if (walkingSpeed != null) 'walkingSpeed': walkingSpeed,
      if (swimmingSpeed != null) 'swimmingSpeed': swimmingSpeed,
      if (climbingSpeed != null) 'climbingSpeed': climbingSpeed,
      if (flyingSpeed != null) 'flyingSpeed': flyingSpeed,
      if (displayedSpeedKind != null)
        'displayedSpeedKind': displayedSpeedKind?.toJson(),
      if (customSpellSaveDcBonus != null)
        'customSpellSaveDcBonus': customSpellSaveDcBonus,
      if (customSpellAttackBonus != null)
        'customSpellAttackBonus': customSpellAttackBonus,
      if (preparedSpellKeys != null)
        'preparedSpellKeys': preparedSpellKeys?.toJson(),
      if (activeConditions != null)
        'activeConditions':
            activeConditions?.toJson(valueToJson: (v) => v.toJson()),
      if (exhaustionLevel != null) 'exhaustionLevel': exhaustionLevel,
      if (inspiration != null) 'inspiration': inspiration,
      if (equipment != null)
        'equipment': equipment?.toJson(valueToJson: (v) => v.toJson()),
      if (equippedArmor != null) 'equippedArmor': equippedArmor?.toJson(),
      if (equippedShield != null) 'equippedShield': equippedShield?.toJson(),
      if (manualSkillProficiencies != null)
        'manualSkillProficiencies':
            manualSkillProficiencies?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSavingThrowProficiencies != null)
        'manualSavingThrowProficiencies': manualSavingThrowProficiencies
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSkillProficiencyOverrides != null)
        'manualSkillProficiencyOverrides': manualSkillProficiencyOverrides
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSavingThrowProficiencyOverrides != null)
        'manualSavingThrowProficiencyOverrides':
            manualSavingThrowProficiencyOverrides?.toJson(
                valueToJson: (v) => v.toJson()),
      if (manualLanguageOverrides != null)
        'manualLanguageOverrides': manualLanguageOverrides?.toJson(),
      if (manualToolProficiencyOverrides != null)
        'manualToolProficiencyOverrides':
            manualToolProficiencyOverrides?.toJson(),
      if (manualWeaponProficiencyOverrides != null)
        'manualWeaponProficiencyOverrides':
            manualWeaponProficiencyOverrides?.toJson(),
      if (manualArmorTrainingOverrides != null)
        'manualArmorTrainingOverrides': manualArmorTrainingOverrides?.toJson(),
      if (notes != null) 'notes': notes?.toJson(valueToJson: (v) => v.toJson()),
      if (attacks != null)
        'attacks': attacks?.toJson(valueToJson: (v) => v.toJson()),
      if (featureOverrides != null)
        'featureOverrides':
            featureOverrides?.toJson(valueToJson: (v) => v.toJson()),
      if (resourceStates != null)
        'resourceStates':
            resourceStates?.toJson(valueToJson: (v) => v.toJson()),
      if (classEntries != null)
        'classEntries': classEntries?.toJson(valueToJson: (v) => v.toJson()),
      if (choices != null)
        'choices': choices?.toJson(valueToJson: (v) => v.toJson()),
      if (skillSelections != null)
        'skillSelections':
            skillSelections?.toJson(valueToJson: (v) => v.toJson()),
      if (spellSelections != null)
        'spellSelections':
            spellSelections?.toJson(valueToJson: (v) => v.toJson()),
      if (startingEquipmentSelections != null)
        'startingEquipmentSelections':
            startingEquipmentSelections?.toJson(valueToJson: (v) => v.toJson()),
      if (derived != null) 'derived': derived?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (eyes != null) 'eyes': eyes,
      if (skin != null) 'skin': skin,
      if (hair != null) 'hair': hair,
      if (appearance != null) 'appearance': appearance,
      if (backstory != null) 'backstory': backstory,
      if (goals != null) 'goals': goals,
      if (alliesOrganizations != null)
        'alliesOrganizations': alliesOrganizations,
      if (personalityTraits != null) 'personalityTraits': personalityTraits,
      if (ideals != null) 'ideals': ideals,
      if (bonds != null) 'bonds': bonds,
      if (flaws != null) 'flaws': flaws,
      if (version != null) 'version': version,
      if (portraitVersion != null) 'portraitVersion': portraitVersion,
      if (syncTargetRevisions != null)
        'syncTargetRevisions': syncTargetRevisions?.toJson(),
      if (syncBarrierTokens != null)
        'syncBarrierTokens': syncBarrierTokens?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (experience != null) 'experience': experience,
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (race != null) 'race': race?.toJsonForProtocol(),
      if (subrace != null) 'subrace': subrace?.toJsonForProtocol(),
      if (background != null) 'background': background?.toJsonForProtocol(),
      if (baseAbilityScores != null)
        'baseAbilityScores': baseAbilityScores?.toJson(),
      if (customAbilityBonuses != null)
        'customAbilityBonuses': customAbilityBonuses?.toJson(),
      if (useFlexibleAbilityBonuses != null)
        'useFlexibleAbilityBonuses': useFlexibleAbilityBonuses,
      if (temporaryHp != null) 'temporaryHp': temporaryHp,
      if (currentHp != null) 'currentHp': currentHp,
      if (deathSaveSuccesses != null) 'deathSaveSuccesses': deathSaveSuccesses,
      if (deathSaveFailures != null) 'deathSaveFailures': deathSaveFailures,
      if (hpPerLevelBonus != null) 'hpPerLevelBonus': hpPerLevelBonus,
      if (hpFlatBonus != null) 'hpFlatBonus': hpFlatBonus,
      if (currentHitDice != null) 'currentHitDice': currentHitDice?.toJson(),
      if (hitDiceMaxOverrides != null)
        'hitDiceMaxOverrides': hitDiceMaxOverrides?.toJson(),
      if (currentSpellSlots != null)
        'currentSpellSlots': currentSpellSlots?.toJson(),
      if (activeConcentrationSpellName != null)
        'activeConcentrationSpellName': activeConcentrationSpellName,
      if (customInitiativeBonus != null)
        'customInitiativeBonus': customInitiativeBonus,
      if (customArmorClassBonus != null)
        'customArmorClassBonus': customArmorClassBonus,
      if (walkingSpeed != null) 'walkingSpeed': walkingSpeed,
      if (swimmingSpeed != null) 'swimmingSpeed': swimmingSpeed,
      if (climbingSpeed != null) 'climbingSpeed': climbingSpeed,
      if (flyingSpeed != null) 'flyingSpeed': flyingSpeed,
      if (displayedSpeedKind != null)
        'displayedSpeedKind': displayedSpeedKind?.toJson(),
      if (customSpellSaveDcBonus != null)
        'customSpellSaveDcBonus': customSpellSaveDcBonus,
      if (customSpellAttackBonus != null)
        'customSpellAttackBonus': customSpellAttackBonus,
      if (preparedSpellKeys != null)
        'preparedSpellKeys': preparedSpellKeys?.toJson(),
      if (activeConditions != null)
        'activeConditions':
            activeConditions?.toJson(valueToJson: (v) => v.toJson()),
      if (exhaustionLevel != null) 'exhaustionLevel': exhaustionLevel,
      if (inspiration != null) 'inspiration': inspiration,
      if (equipment != null)
        'equipment':
            equipment?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (equippedArmor != null)
        'equippedArmor': equippedArmor?.toJsonForProtocol(),
      if (equippedShield != null)
        'equippedShield': equippedShield?.toJsonForProtocol(),
      if (manualSkillProficiencies != null)
        'manualSkillProficiencies': manualSkillProficiencies?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (manualSavingThrowProficiencies != null)
        'manualSavingThrowProficiencies': manualSavingThrowProficiencies
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSkillProficiencyOverrides != null)
        'manualSkillProficiencyOverrides': manualSkillProficiencyOverrides
            ?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (manualSavingThrowProficiencyOverrides != null)
        'manualSavingThrowProficiencyOverrides':
            manualSavingThrowProficiencyOverrides?.toJson(
                valueToJson: (v) => v.toJsonForProtocol()),
      if (manualLanguageOverrides != null)
        'manualLanguageOverrides': manualLanguageOverrides?.toJsonForProtocol(),
      if (manualToolProficiencyOverrides != null)
        'manualToolProficiencyOverrides':
            manualToolProficiencyOverrides?.toJsonForProtocol(),
      if (manualWeaponProficiencyOverrides != null)
        'manualWeaponProficiencyOverrides':
            manualWeaponProficiencyOverrides?.toJsonForProtocol(),
      if (manualArmorTrainingOverrides != null)
        'manualArmorTrainingOverrides':
            manualArmorTrainingOverrides?.toJsonForProtocol(),
      if (notes != null)
        'notes': notes?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (attacks != null)
        'attacks': attacks?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (featureOverrides != null)
        'featureOverrides':
            featureOverrides?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (resourceStates != null)
        'resourceStates':
            resourceStates?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (classEntries != null)
        'classEntries':
            classEntries?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (choices != null)
        'choices': choices?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (skillSelections != null)
        'skillSelections':
            skillSelections?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (spellSelections != null)
        'spellSelections':
            spellSelections?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (startingEquipmentSelections != null)
        'startingEquipmentSelections': startingEquipmentSelections?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (derived != null) 'derived': derived?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterDataImpl extends CharacterData {
  _CharacterDataImpl({
    int? id,
    String? name,
    String? age,
    String? height,
    String? weight,
    String? eyes,
    String? skin,
    String? hair,
    String? appearance,
    String? backstory,
    String? goals,
    String? alliesOrganizations,
    String? personalityTraits,
    String? ideals,
    String? bonds,
    String? flaws,
    int? version,
    int? portraitVersion,
    Map<String, int>? syncTargetRevisions,
    Map<String, String>? syncBarrierTokens,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? experience,
    _i2.CharacterAlignment? alignmentValue,
    _i3.RaceData? race,
    _i4.SubraceData? subrace,
    _i5.BackgroundData? background,
    Map<String, int>? baseAbilityScores,
    Map<String, int>? customAbilityBonuses,
    bool? useFlexibleAbilityBonuses,
    int? temporaryHp,
    int? currentHp,
    int? deathSaveSuccesses,
    int? deathSaveFailures,
    int? hpPerLevelBonus,
    int? hpFlatBonus,
    Map<String, int>? currentHitDice,
    Map<String, int>? hitDiceMaxOverrides,
    Map<int, int>? currentSpellSlots,
    String? activeConcentrationSpellName,
    int? customInitiativeBonus,
    int? customArmorClassBonus,
    int? walkingSpeed,
    int? swimmingSpeed,
    int? climbingSpeed,
    int? flyingSpeed,
    _i6.CharacterSpeedKind? displayedSpeedKind,
    int? customSpellSaveDcBonus,
    int? customSpellAttackBonus,
    List<String>? preparedSpellKeys,
    List<_i7.ConditionType>? activeConditions,
    int? exhaustionLevel,
    bool? inspiration,
    List<_i8.CharacterInventoryItemData>? equipment,
    _i9.CharacterEquipmentSelectionData? equippedArmor,
    _i9.CharacterEquipmentSelectionData? equippedShield,
    List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_i11.Ability>? manualSavingThrowProficiencies,
    List<_i10.CharacterSkillProficiencyState>? manualSkillProficiencyOverrides,
    List<_i12.CharacterSavingThrowProficiencyOverrideData>?
        manualSavingThrowProficiencyOverrides,
    _i13.CharacterLanguageOverridesData? manualLanguageOverrides,
    _i14.CharacterToolProficiencyOverridesData? manualToolProficiencyOverrides,
    _i15.CharacterWeaponProficiencyOverridesData?
        manualWeaponProficiencyOverrides,
    _i16.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides,
    List<_i17.CharacterNoteData>? notes,
    List<_i18.CharacterAttackData>? attacks,
    List<_i19.CharacterFeatureOverrideData>? featureOverrides,
    List<_i20.CharacterResourceStateData>? resourceStates,
    List<_i21.CharacterClassEntryData>? classEntries,
    List<_i22.CharacterChoiceData>? choices,
    List<_i23.CharacterSkillSelectionData>? skillSelections,
    List<_i24.CharacterSpellSelectionData>? spellSelections,
    List<_i25.CharacterStartingEquipmentSelectionData>?
        startingEquipmentSelections,
    _i26.CharacterDerivedData? derived,
  }) : super._(
          id: id,
          name: name,
          age: age,
          height: height,
          weight: weight,
          eyes: eyes,
          skin: skin,
          hair: hair,
          appearance: appearance,
          backstory: backstory,
          goals: goals,
          alliesOrganizations: alliesOrganizations,
          personalityTraits: personalityTraits,
          ideals: ideals,
          bonds: bonds,
          flaws: flaws,
          version: version,
          portraitVersion: portraitVersion,
          syncTargetRevisions: syncTargetRevisions,
          syncBarrierTokens: syncBarrierTokens,
          createdAt: createdAt,
          updatedAt: updatedAt,
          experience: experience,
          alignmentValue: alignmentValue,
          race: race,
          subrace: subrace,
          background: background,
          baseAbilityScores: baseAbilityScores,
          customAbilityBonuses: customAbilityBonuses,
          useFlexibleAbilityBonuses: useFlexibleAbilityBonuses,
          temporaryHp: temporaryHp,
          currentHp: currentHp,
          deathSaveSuccesses: deathSaveSuccesses,
          deathSaveFailures: deathSaveFailures,
          hpPerLevelBonus: hpPerLevelBonus,
          hpFlatBonus: hpFlatBonus,
          currentHitDice: currentHitDice,
          hitDiceMaxOverrides: hitDiceMaxOverrides,
          currentSpellSlots: currentSpellSlots,
          activeConcentrationSpellName: activeConcentrationSpellName,
          customInitiativeBonus: customInitiativeBonus,
          customArmorClassBonus: customArmorClassBonus,
          walkingSpeed: walkingSpeed,
          swimmingSpeed: swimmingSpeed,
          climbingSpeed: climbingSpeed,
          flyingSpeed: flyingSpeed,
          displayedSpeedKind: displayedSpeedKind,
          customSpellSaveDcBonus: customSpellSaveDcBonus,
          customSpellAttackBonus: customSpellAttackBonus,
          preparedSpellKeys: preparedSpellKeys,
          activeConditions: activeConditions,
          exhaustionLevel: exhaustionLevel,
          inspiration: inspiration,
          equipment: equipment,
          equippedArmor: equippedArmor,
          equippedShield: equippedShield,
          manualSkillProficiencies: manualSkillProficiencies,
          manualSavingThrowProficiencies: manualSavingThrowProficiencies,
          manualSkillProficiencyOverrides: manualSkillProficiencyOverrides,
          manualSavingThrowProficiencyOverrides:
              manualSavingThrowProficiencyOverrides,
          manualLanguageOverrides: manualLanguageOverrides,
          manualToolProficiencyOverrides: manualToolProficiencyOverrides,
          manualWeaponProficiencyOverrides: manualWeaponProficiencyOverrides,
          manualArmorTrainingOverrides: manualArmorTrainingOverrides,
          notes: notes,
          attacks: attacks,
          featureOverrides: featureOverrides,
          resourceStates: resourceStates,
          classEntries: classEntries,
          choices: choices,
          skillSelections: skillSelections,
          spellSelections: spellSelections,
          startingEquipmentSelections: startingEquipmentSelections,
          derived: derived,
        );

  /// Returns a shallow copy of this [CharacterData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterData copyWith({
    Object? id = _Undefined,
    Object? name = _Undefined,
    Object? age = _Undefined,
    Object? height = _Undefined,
    Object? weight = _Undefined,
    Object? eyes = _Undefined,
    Object? skin = _Undefined,
    Object? hair = _Undefined,
    Object? appearance = _Undefined,
    Object? backstory = _Undefined,
    Object? goals = _Undefined,
    Object? alliesOrganizations = _Undefined,
    Object? personalityTraits = _Undefined,
    Object? ideals = _Undefined,
    Object? bonds = _Undefined,
    Object? flaws = _Undefined,
    Object? version = _Undefined,
    Object? portraitVersion = _Undefined,
    Object? syncTargetRevisions = _Undefined,
    Object? syncBarrierTokens = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
    Object? experience = _Undefined,
    Object? alignmentValue = _Undefined,
    Object? race = _Undefined,
    Object? subrace = _Undefined,
    Object? background = _Undefined,
    Object? baseAbilityScores = _Undefined,
    Object? customAbilityBonuses = _Undefined,
    Object? useFlexibleAbilityBonuses = _Undefined,
    Object? temporaryHp = _Undefined,
    Object? currentHp = _Undefined,
    Object? deathSaveSuccesses = _Undefined,
    Object? deathSaveFailures = _Undefined,
    Object? hpPerLevelBonus = _Undefined,
    Object? hpFlatBonus = _Undefined,
    Object? currentHitDice = _Undefined,
    Object? hitDiceMaxOverrides = _Undefined,
    Object? currentSpellSlots = _Undefined,
    Object? activeConcentrationSpellName = _Undefined,
    Object? customInitiativeBonus = _Undefined,
    Object? customArmorClassBonus = _Undefined,
    Object? walkingSpeed = _Undefined,
    Object? swimmingSpeed = _Undefined,
    Object? climbingSpeed = _Undefined,
    Object? flyingSpeed = _Undefined,
    Object? displayedSpeedKind = _Undefined,
    Object? customSpellSaveDcBonus = _Undefined,
    Object? customSpellAttackBonus = _Undefined,
    Object? preparedSpellKeys = _Undefined,
    Object? activeConditions = _Undefined,
    Object? exhaustionLevel = _Undefined,
    Object? inspiration = _Undefined,
    Object? equipment = _Undefined,
    Object? equippedArmor = _Undefined,
    Object? equippedShield = _Undefined,
    Object? manualSkillProficiencies = _Undefined,
    Object? manualSavingThrowProficiencies = _Undefined,
    Object? manualSkillProficiencyOverrides = _Undefined,
    Object? manualSavingThrowProficiencyOverrides = _Undefined,
    Object? manualLanguageOverrides = _Undefined,
    Object? manualToolProficiencyOverrides = _Undefined,
    Object? manualWeaponProficiencyOverrides = _Undefined,
    Object? manualArmorTrainingOverrides = _Undefined,
    Object? notes = _Undefined,
    Object? attacks = _Undefined,
    Object? featureOverrides = _Undefined,
    Object? resourceStates = _Undefined,
    Object? classEntries = _Undefined,
    Object? choices = _Undefined,
    Object? skillSelections = _Undefined,
    Object? spellSelections = _Undefined,
    Object? startingEquipmentSelections = _Undefined,
    Object? derived = _Undefined,
  }) {
    return CharacterData(
      id: id is int? ? id : this.id,
      name: name is String? ? name : this.name,
      age: age is String? ? age : this.age,
      height: height is String? ? height : this.height,
      weight: weight is String? ? weight : this.weight,
      eyes: eyes is String? ? eyes : this.eyes,
      skin: skin is String? ? skin : this.skin,
      hair: hair is String? ? hair : this.hair,
      appearance: appearance is String? ? appearance : this.appearance,
      backstory: backstory is String? ? backstory : this.backstory,
      goals: goals is String? ? goals : this.goals,
      alliesOrganizations: alliesOrganizations is String?
          ? alliesOrganizations
          : this.alliesOrganizations,
      personalityTraits: personalityTraits is String?
          ? personalityTraits
          : this.personalityTraits,
      ideals: ideals is String? ? ideals : this.ideals,
      bonds: bonds is String? ? bonds : this.bonds,
      flaws: flaws is String? ? flaws : this.flaws,
      version: version is int? ? version : this.version,
      portraitVersion:
          portraitVersion is int? ? portraitVersion : this.portraitVersion,
      syncTargetRevisions: syncTargetRevisions is Map<String, int>?
          ? syncTargetRevisions
          : this.syncTargetRevisions?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      syncBarrierTokens: syncBarrierTokens is Map<String, String>?
          ? syncBarrierTokens
          : this.syncBarrierTokens?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      experience: experience is int? ? experience : this.experience,
      alignmentValue: alignmentValue is _i2.CharacterAlignment?
          ? alignmentValue
          : this.alignmentValue,
      race: race is _i3.RaceData? ? race : this.race?.copyWith(),
      subrace: subrace is _i4.SubraceData? ? subrace : this.subrace?.copyWith(),
      background: background is _i5.BackgroundData?
          ? background
          : this.background?.copyWith(),
      baseAbilityScores: baseAbilityScores is Map<String, int>?
          ? baseAbilityScores
          : this.baseAbilityScores?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      customAbilityBonuses: customAbilityBonuses is Map<String, int>?
          ? customAbilityBonuses
          : this.customAbilityBonuses?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      useFlexibleAbilityBonuses: useFlexibleAbilityBonuses is bool?
          ? useFlexibleAbilityBonuses
          : this.useFlexibleAbilityBonuses,
      temporaryHp: temporaryHp is int? ? temporaryHp : this.temporaryHp,
      currentHp: currentHp is int? ? currentHp : this.currentHp,
      deathSaveSuccesses: deathSaveSuccesses is int?
          ? deathSaveSuccesses
          : this.deathSaveSuccesses,
      deathSaveFailures: deathSaveFailures is int?
          ? deathSaveFailures
          : this.deathSaveFailures,
      hpPerLevelBonus:
          hpPerLevelBonus is int? ? hpPerLevelBonus : this.hpPerLevelBonus,
      hpFlatBonus: hpFlatBonus is int? ? hpFlatBonus : this.hpFlatBonus,
      currentHitDice: currentHitDice is Map<String, int>?
          ? currentHitDice
          : this.currentHitDice?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      hitDiceMaxOverrides: hitDiceMaxOverrides is Map<String, int>?
          ? hitDiceMaxOverrides
          : this.hitDiceMaxOverrides?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      currentSpellSlots: currentSpellSlots is Map<int, int>?
          ? currentSpellSlots
          : this.currentSpellSlots?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      activeConcentrationSpellName: activeConcentrationSpellName is String?
          ? activeConcentrationSpellName
          : this.activeConcentrationSpellName,
      customInitiativeBonus: customInitiativeBonus is int?
          ? customInitiativeBonus
          : this.customInitiativeBonus,
      customArmorClassBonus: customArmorClassBonus is int?
          ? customArmorClassBonus
          : this.customArmorClassBonus,
      walkingSpeed: walkingSpeed is int? ? walkingSpeed : this.walkingSpeed,
      swimmingSpeed: swimmingSpeed is int? ? swimmingSpeed : this.swimmingSpeed,
      climbingSpeed: climbingSpeed is int? ? climbingSpeed : this.climbingSpeed,
      flyingSpeed: flyingSpeed is int? ? flyingSpeed : this.flyingSpeed,
      displayedSpeedKind: displayedSpeedKind is _i6.CharacterSpeedKind?
          ? displayedSpeedKind
          : this.displayedSpeedKind,
      customSpellSaveDcBonus: customSpellSaveDcBonus is int?
          ? customSpellSaveDcBonus
          : this.customSpellSaveDcBonus,
      customSpellAttackBonus: customSpellAttackBonus is int?
          ? customSpellAttackBonus
          : this.customSpellAttackBonus,
      preparedSpellKeys: preparedSpellKeys is List<String>?
          ? preparedSpellKeys
          : this.preparedSpellKeys?.map((e0) => e0).toList(),
      activeConditions: activeConditions is List<_i7.ConditionType>?
          ? activeConditions
          : this.activeConditions?.map((e0) => e0).toList(),
      exhaustionLevel:
          exhaustionLevel is int? ? exhaustionLevel : this.exhaustionLevel,
      inspiration: inspiration is bool? ? inspiration : this.inspiration,
      equipment: equipment is List<_i8.CharacterInventoryItemData>?
          ? equipment
          : this.equipment?.map((e0) => e0.copyWith()).toList(),
      equippedArmor: equippedArmor is _i9.CharacterEquipmentSelectionData?
          ? equippedArmor
          : this.equippedArmor?.copyWith(),
      equippedShield: equippedShield is _i9.CharacterEquipmentSelectionData?
          ? equippedShield
          : this.equippedShield?.copyWith(),
      manualSkillProficiencies: manualSkillProficiencies
              is List<_i10.CharacterSkillProficiencyState>?
          ? manualSkillProficiencies
          : this.manualSkillProficiencies?.map((e0) => e0.copyWith()).toList(),
      manualSavingThrowProficiencies:
          manualSavingThrowProficiencies is List<_i11.Ability>?
              ? manualSavingThrowProficiencies
              : this.manualSavingThrowProficiencies?.map((e0) => e0).toList(),
      manualSkillProficiencyOverrides: manualSkillProficiencyOverrides
              is List<_i10.CharacterSkillProficiencyState>?
          ? manualSkillProficiencyOverrides
          : this
              .manualSkillProficiencyOverrides
              ?.map((e0) => e0.copyWith())
              .toList(),
      manualSavingThrowProficiencyOverrides:
          manualSavingThrowProficiencyOverrides
                  is List<_i12.CharacterSavingThrowProficiencyOverrideData>?
              ? manualSavingThrowProficiencyOverrides
              : this
                  .manualSavingThrowProficiencyOverrides
                  ?.map((e0) => e0.copyWith())
                  .toList(),
      manualLanguageOverrides:
          manualLanguageOverrides is _i13.CharacterLanguageOverridesData?
              ? manualLanguageOverrides
              : this.manualLanguageOverrides?.copyWith(),
      manualToolProficiencyOverrides: manualToolProficiencyOverrides
              is _i14.CharacterToolProficiencyOverridesData?
          ? manualToolProficiencyOverrides
          : this.manualToolProficiencyOverrides?.copyWith(),
      manualWeaponProficiencyOverrides: manualWeaponProficiencyOverrides
              is _i15.CharacterWeaponProficiencyOverridesData?
          ? manualWeaponProficiencyOverrides
          : this.manualWeaponProficiencyOverrides?.copyWith(),
      manualArmorTrainingOverrides: manualArmorTrainingOverrides
              is _i16.CharacterArmorTrainingOverridesData?
          ? manualArmorTrainingOverrides
          : this.manualArmorTrainingOverrides?.copyWith(),
      notes: notes is List<_i17.CharacterNoteData>?
          ? notes
          : this.notes?.map((e0) => e0.copyWith()).toList(),
      attacks: attacks is List<_i18.CharacterAttackData>?
          ? attacks
          : this.attacks?.map((e0) => e0.copyWith()).toList(),
      featureOverrides:
          featureOverrides is List<_i19.CharacterFeatureOverrideData>?
              ? featureOverrides
              : this.featureOverrides?.map((e0) => e0.copyWith()).toList(),
      resourceStates: resourceStates is List<_i20.CharacterResourceStateData>?
          ? resourceStates
          : this.resourceStates?.map((e0) => e0.copyWith()).toList(),
      classEntries: classEntries is List<_i21.CharacterClassEntryData>?
          ? classEntries
          : this.classEntries?.map((e0) => e0.copyWith()).toList(),
      choices: choices is List<_i22.CharacterChoiceData>?
          ? choices
          : this.choices?.map((e0) => e0.copyWith()).toList(),
      skillSelections:
          skillSelections is List<_i23.CharacterSkillSelectionData>?
              ? skillSelections
              : this.skillSelections?.map((e0) => e0.copyWith()).toList(),
      spellSelections:
          spellSelections is List<_i24.CharacterSpellSelectionData>?
              ? spellSelections
              : this.spellSelections?.map((e0) => e0.copyWith()).toList(),
      startingEquipmentSelections: startingEquipmentSelections
              is List<_i25.CharacterStartingEquipmentSelectionData>?
          ? startingEquipmentSelections
          : this
              .startingEquipmentSelections
              ?.map((e0) => e0.copyWith())
              .toList(),
      derived: derived is _i26.CharacterDerivedData?
          ? derived
          : this.derived?.copyWith(),
    );
  }
}
