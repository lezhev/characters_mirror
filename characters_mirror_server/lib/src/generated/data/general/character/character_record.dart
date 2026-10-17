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
import '../../../data/background_data.dart' as _i1utzyju;
import '../../../data/general/character/character_armor_training_overrides_data.dart'
    as _icsd58ny;
import '../../../data/general/character/character_attack_data.dart'
    as _i9jwtlvb;
import '../../../data/general/character/character_equipment_selection_data.dart'
    as _ihorlaio;
import '../../../data/general/character/character_feature_override_data.dart'
    as _iq39grm2;
import '../../../data/general/character/character_inventory_item_data.dart'
    as _iekoe72x;
import '../../../data/general/character/character_language_overrides_data.dart'
    as _iy48gvsl;
import '../../../data/general/character/character_note_data.dart' as _ioruio1c;
import '../../../data/general/character/character_resource_state_data.dart'
    as _ikl23b4y;
import '../../../data/general/character/character_saving_throw_proficiency_override_data.dart'
    as _iax3ptkk;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _ipq2j7wi;
import '../../../data/general/character/character_tool_proficiency_overrides_data.dart'
    as _i6hm0w7y;
import '../../../data/general/character/character_weapon_proficiency_overrides_data.dart'
    as _i6snm8iz;
import '../../../data/general/character/spell_slot_recovery_trigger_data.dart'
    as _i7xdtn5i;
import '../../../data/general/race/race_data.dart' as _ittxuxz1;
import '../../../data/general/race/subrace_data.dart' as _i2k66n75;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/character_alignment.dart' as _iwwn584b;
import '../../../enums/character_speed_kind.dart' as _il8xya9v;
import '../../../enums/condition_type.dart' as _i1didlhi;

abstract class CharacterRecord
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  CharacterRecord._({
    this.id,
    this.spellActivationUses,
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
    this.userId,
    this.experience,
    this.alignmentValue,
    this.raceId,
    this.race,
    this.subraceId,
    this.subrace,
    this.backgroundId,
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
    this.currentPactSlots,
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
    this.spellRecoveryTriggers,
  });

  factory CharacterRecord({
    int? id,
    Map<String, int>? spellActivationUses,
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
    int? userId,
    int? experience,
    _iwwn584b.CharacterAlignment? alignmentValue,
    int? raceId,
    _ittxuxz1.RaceData? race,
    int? subraceId,
    _i2k66n75.SubraceData? subrace,
    int? backgroundId,
    _i1utzyju.BackgroundData? background,
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
    Map<int, int>? currentPactSlots,
    String? activeConcentrationSpellName,
    int? customInitiativeBonus,
    int? customArmorClassBonus,
    int? walkingSpeed,
    int? swimmingSpeed,
    int? climbingSpeed,
    int? flyingSpeed,
    _il8xya9v.CharacterSpeedKind? displayedSpeedKind,
    int? customSpellSaveDcBonus,
    int? customSpellAttackBonus,
    List<String>? preparedSpellKeys,
    List<_i1didlhi.ConditionType>? activeConditions,
    int? exhaustionLevel,
    bool? inspiration,
    List<_iekoe72x.CharacterInventoryItemData>? equipment,
    _ihorlaio.CharacterEquipmentSelectionData? equippedArmor,
    _ihorlaio.CharacterEquipmentSelectionData? equippedShield,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_iw3bk51e.Ability>? manualSavingThrowProficiencies,
    List<_ipq2j7wi.CharacterSkillProficiencyState>?
    manualSkillProficiencyOverrides,
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>?
    manualSavingThrowProficiencyOverrides,
    _iy48gvsl.CharacterLanguageOverridesData? manualLanguageOverrides,
    _i6hm0w7y.CharacterToolProficiencyOverridesData?
    manualToolProficiencyOverrides,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData?
    manualWeaponProficiencyOverrides,
    _icsd58ny.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides,
    List<_ioruio1c.CharacterNoteData>? notes,
    List<_i9jwtlvb.CharacterAttackData>? attacks,
    List<_iq39grm2.CharacterFeatureOverrideData>? featureOverrides,
    List<_ikl23b4y.CharacterResourceStateData>? resourceStates,
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>? spellRecoveryTriggers,
  }) = _CharacterRecordImpl;

  factory CharacterRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterRecord(
      id: jsonSerialization['id'] as int?,
      spellActivationUses: jsonSerialization['spellActivationUses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['spellActivationUses'],
            ),
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
      syncTargetRevisions: jsonSerialization['syncTargetRevisions'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['syncTargetRevisions'],
            ),
      syncBarrierTokens: jsonSerialization['syncBarrierTokens'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, String>>(
              jsonSerialization['syncBarrierTokens'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      userId: jsonSerialization['userId'] as int?,
      experience: jsonSerialization['experience'] as int?,
      alignmentValue: jsonSerialization['alignmentValue'] == null
          ? null
          : _iwwn584b.CharacterAlignment.fromJson(
              (jsonSerialization['alignmentValue'] as String),
            ),
      raceId: jsonSerialization['raceId'] as int?,
      race: jsonSerialization['race'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ittxuxz1.RaceData>(
              jsonSerialization['race'],
            ),
      subraceId: jsonSerialization['subraceId'] as int?,
      subrace: jsonSerialization['subrace'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i2k66n75.SubraceData>(
              jsonSerialization['subrace'],
            ),
      backgroundId: jsonSerialization['backgroundId'] as int?,
      background: jsonSerialization['background'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i1utzyju.BackgroundData>(
              jsonSerialization['background'],
            ),
      baseAbilityScores: jsonSerialization['baseAbilityScores'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['baseAbilityScores'],
            ),
      customAbilityBonuses: jsonSerialization['customAbilityBonuses'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['customAbilityBonuses'],
            ),
      useFlexibleAbilityBonuses:
          jsonSerialization['useFlexibleAbilityBonuses'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(
              jsonSerialization['useFlexibleAbilityBonuses'],
            ),
      temporaryHp: jsonSerialization['temporaryHp'] as int?,
      currentHp: jsonSerialization['currentHp'] as int?,
      deathSaveSuccesses: jsonSerialization['deathSaveSuccesses'] as int?,
      deathSaveFailures: jsonSerialization['deathSaveFailures'] as int?,
      hpPerLevelBonus: jsonSerialization['hpPerLevelBonus'] as int?,
      hpFlatBonus: jsonSerialization['hpFlatBonus'] as int?,
      currentHitDice: jsonSerialization['currentHitDice'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['currentHitDice'],
            ),
      hitDiceMaxOverrides: jsonSerialization['hitDiceMaxOverrides'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['hitDiceMaxOverrides'],
            ),
      currentSpellSlots: jsonSerialization['currentSpellSlots'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['currentSpellSlots'],
            ),
      currentPactSlots: jsonSerialization['currentPactSlots'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['currentPactSlots'],
            ),
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
          : _il8xya9v.CharacterSpeedKind.fromJson(
              (jsonSerialization['displayedSpeedKind'] as int),
            ),
      customSpellSaveDcBonus:
          jsonSerialization['customSpellSaveDcBonus'] as int?,
      customSpellAttackBonus:
          jsonSerialization['customSpellAttackBonus'] as int?,
      preparedSpellKeys: jsonSerialization['preparedSpellKeys'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['preparedSpellKeys'],
            ),
      activeConditions: jsonSerialization['activeConditions'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i1didlhi.ConditionType>>(
              jsonSerialization['activeConditions'],
            ),
      exhaustionLevel: jsonSerialization['exhaustionLevel'] as int?,
      inspiration: jsonSerialization['inspiration'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['inspiration']),
      equipment: jsonSerialization['equipment'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iekoe72x.CharacterInventoryItemData>>(
                  jsonSerialization['equipment'],
                ),
      equippedArmor: jsonSerialization['equippedArmor'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_ihorlaio.CharacterEquipmentSelectionData>(
                  jsonSerialization['equippedArmor'],
                ),
      equippedShield: jsonSerialization['equippedShield'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_ihorlaio.CharacterEquipmentSelectionData>(
                  jsonSerialization['equippedShield'],
                ),
      manualSkillProficiencies:
          jsonSerialization['manualSkillProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ipq2j7wi.CharacterSkillProficiencyState>>(
                  jsonSerialization['manualSkillProficiencies'],
                ),
      manualSavingThrowProficiencies:
          jsonSerialization['manualSavingThrowProficiencies'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['manualSavingThrowProficiencies'],
            ),
      manualSkillProficiencyOverrides:
          jsonSerialization['manualSkillProficiencyOverrides'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ipq2j7wi.CharacterSkillProficiencyState>>(
                  jsonSerialization['manualSkillProficiencyOverrides'],
                ),
      manualSavingThrowProficiencyOverrides:
          jsonSerialization['manualSavingThrowProficiencyOverrides'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>
            >(jsonSerialization['manualSavingThrowProficiencyOverrides']),
      manualLanguageOverrides:
          jsonSerialization['manualLanguageOverrides'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iy48gvsl.CharacterLanguageOverridesData>(
                  jsonSerialization['manualLanguageOverrides'],
                ),
      manualToolProficiencyOverrides:
          jsonSerialization['manualToolProficiencyOverrides'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i6hm0w7y.CharacterToolProficiencyOverridesData>(
                  jsonSerialization['manualToolProficiencyOverrides'],
                ),
      manualWeaponProficiencyOverrides:
          jsonSerialization['manualWeaponProficiencyOverrides'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i6snm8iz.CharacterWeaponProficiencyOverridesData>(
                  jsonSerialization['manualWeaponProficiencyOverrides'],
                ),
      manualArmorTrainingOverrides:
          jsonSerialization['manualArmorTrainingOverrides'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_icsd58ny.CharacterArmorTrainingOverridesData>(
                  jsonSerialization['manualArmorTrainingOverrides'],
                ),
      notes: jsonSerialization['notes'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_ioruio1c.CharacterNoteData>>(
              jsonSerialization['notes'],
            ),
      attacks: jsonSerialization['attacks'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_i9jwtlvb.CharacterAttackData>>(
                  jsonSerialization['attacks'],
                ),
      featureOverrides: jsonSerialization['featureOverrides'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_iq39grm2.CharacterFeatureOverrideData>>(
                  jsonSerialization['featureOverrides'],
                ),
      resourceStates: jsonSerialization['resourceStates'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ikl23b4y.CharacterResourceStateData>>(
                  jsonSerialization['resourceStates'],
                ),
      spellRecoveryTriggers: jsonSerialization['spellRecoveryTriggers'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>
            >(jsonSerialization['spellRecoveryTriggers']),
    );
  }

  static final t = CharacterRecordTable();

  static const db = CharacterRecordRepository._();

  @override
  int? id;

  Map<String, int>? spellActivationUses;

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

  int? userId;

  int? experience;

  _iwwn584b.CharacterAlignment? alignmentValue;

  int? raceId;

  _ittxuxz1.RaceData? race;

  int? subraceId;

  _i2k66n75.SubraceData? subrace;

  int? backgroundId;

  _i1utzyju.BackgroundData? background;

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

  Map<int, int>? currentPactSlots;

  String? activeConcentrationSpellName;

  int? customInitiativeBonus;

  int? customArmorClassBonus;

  int? walkingSpeed;

  int? swimmingSpeed;

  int? climbingSpeed;

  int? flyingSpeed;

  _il8xya9v.CharacterSpeedKind? displayedSpeedKind;

  int? customSpellSaveDcBonus;

  int? customSpellAttackBonus;

  List<String>? preparedSpellKeys;

  List<_i1didlhi.ConditionType>? activeConditions;

  int? exhaustionLevel;

  bool? inspiration;

  List<_iekoe72x.CharacterInventoryItemData>? equipment;

  _ihorlaio.CharacterEquipmentSelectionData? equippedArmor;

  _ihorlaio.CharacterEquipmentSelectionData? equippedShield;

  List<_ipq2j7wi.CharacterSkillProficiencyState>? manualSkillProficiencies;

  List<_iw3bk51e.Ability>? manualSavingThrowProficiencies;

  List<_ipq2j7wi.CharacterSkillProficiencyState>?
  manualSkillProficiencyOverrides;

  List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>?
  manualSavingThrowProficiencyOverrides;

  _iy48gvsl.CharacterLanguageOverridesData? manualLanguageOverrides;

  _i6hm0w7y.CharacterToolProficiencyOverridesData?
  manualToolProficiencyOverrides;

  _i6snm8iz.CharacterWeaponProficiencyOverridesData?
  manualWeaponProficiencyOverrides;

  _icsd58ny.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides;

  List<_ioruio1c.CharacterNoteData>? notes;

  List<_i9jwtlvb.CharacterAttackData>? attacks;

  List<_iq39grm2.CharacterFeatureOverrideData>? featureOverrides;

  List<_ikl23b4y.CharacterResourceStateData>? resourceStates;

  Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>? spellRecoveryTriggers;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [CharacterRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterRecord copyWith({
    int? id,
    Map<String, int>? spellActivationUses,
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
    int? userId,
    int? experience,
    _iwwn584b.CharacterAlignment? alignmentValue,
    int? raceId,
    _ittxuxz1.RaceData? race,
    int? subraceId,
    _i2k66n75.SubraceData? subrace,
    int? backgroundId,
    _i1utzyju.BackgroundData? background,
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
    Map<int, int>? currentPactSlots,
    String? activeConcentrationSpellName,
    int? customInitiativeBonus,
    int? customArmorClassBonus,
    int? walkingSpeed,
    int? swimmingSpeed,
    int? climbingSpeed,
    int? flyingSpeed,
    _il8xya9v.CharacterSpeedKind? displayedSpeedKind,
    int? customSpellSaveDcBonus,
    int? customSpellAttackBonus,
    List<String>? preparedSpellKeys,
    List<_i1didlhi.ConditionType>? activeConditions,
    int? exhaustionLevel,
    bool? inspiration,
    List<_iekoe72x.CharacterInventoryItemData>? equipment,
    _ihorlaio.CharacterEquipmentSelectionData? equippedArmor,
    _ihorlaio.CharacterEquipmentSelectionData? equippedShield,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_iw3bk51e.Ability>? manualSavingThrowProficiencies,
    List<_ipq2j7wi.CharacterSkillProficiencyState>?
    manualSkillProficiencyOverrides,
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>?
    manualSavingThrowProficiencyOverrides,
    _iy48gvsl.CharacterLanguageOverridesData? manualLanguageOverrides,
    _i6hm0w7y.CharacterToolProficiencyOverridesData?
    manualToolProficiencyOverrides,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData?
    manualWeaponProficiencyOverrides,
    _icsd58ny.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides,
    List<_ioruio1c.CharacterNoteData>? notes,
    List<_i9jwtlvb.CharacterAttackData>? attacks,
    List<_iq39grm2.CharacterFeatureOverrideData>? featureOverrides,
    List<_ikl23b4y.CharacterResourceStateData>? resourceStates,
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>? spellRecoveryTriggers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterRecord',
      if (id != null) 'id': id,
      if (spellActivationUses != null)
        'spellActivationUses': spellActivationUses?.toJson(),
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
      if (userId != null) 'userId': userId,
      if (experience != null) 'experience': experience,
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (raceId != null) 'raceId': raceId,
      if (race != null) 'race': race?.toJson(),
      if (subraceId != null) 'subraceId': subraceId,
      if (subrace != null) 'subrace': subrace?.toJson(),
      if (backgroundId != null) 'backgroundId': backgroundId,
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
      if (currentPactSlots != null)
        'currentPactSlots': currentPactSlots?.toJson(),
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
        'activeConditions': activeConditions?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (exhaustionLevel != null) 'exhaustionLevel': exhaustionLevel,
      if (inspiration != null) 'inspiration': inspiration,
      if (equipment != null)
        'equipment': equipment?.toJson(valueToJson: (v) => v.toJson()),
      if (equippedArmor != null) 'equippedArmor': equippedArmor?.toJson(),
      if (equippedShield != null) 'equippedShield': equippedShield?.toJson(),
      if (manualSkillProficiencies != null)
        'manualSkillProficiencies': manualSkillProficiencies?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (manualSavingThrowProficiencies != null)
        'manualSavingThrowProficiencies': manualSavingThrowProficiencies
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSkillProficiencyOverrides != null)
        'manualSkillProficiencyOverrides': manualSkillProficiencyOverrides
            ?.toJson(valueToJson: (v) => v.toJson()),
      if (manualSavingThrowProficiencyOverrides != null)
        'manualSavingThrowProficiencyOverrides':
            manualSavingThrowProficiencyOverrides?.toJson(
              valueToJson: (v) => v.toJson(),
            ),
      if (manualLanguageOverrides != null)
        'manualLanguageOverrides': manualLanguageOverrides?.toJson(),
      if (manualToolProficiencyOverrides != null)
        'manualToolProficiencyOverrides': manualToolProficiencyOverrides
            ?.toJson(),
      if (manualWeaponProficiencyOverrides != null)
        'manualWeaponProficiencyOverrides': manualWeaponProficiencyOverrides
            ?.toJson(),
      if (manualArmorTrainingOverrides != null)
        'manualArmorTrainingOverrides': manualArmorTrainingOverrides?.toJson(),
      if (notes != null) 'notes': notes?.toJson(valueToJson: (v) => v.toJson()),
      if (attacks != null)
        'attacks': attacks?.toJson(valueToJson: (v) => v.toJson()),
      if (featureOverrides != null)
        'featureOverrides': featureOverrides?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (resourceStates != null)
        'resourceStates': resourceStates?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (spellRecoveryTriggers != null)
        'spellRecoveryTriggers': spellRecoveryTriggers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static CharacterRecordInclude include({
    _ittxuxz1.RaceDataInclude? race,
    _i2k66n75.SubraceDataInclude? subrace,
    _i1utzyju.BackgroundDataInclude? background,
  }) {
    return CharacterRecordInclude._(
      race: race,
      subrace: subrace,
      background: background,
    );
  }

  static CharacterRecordIncludeList includeList({
    _is.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterRecordTable>? orderByList,
    CharacterRecordInclude? include,
  }) {
    return CharacterRecordIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterRecordImpl extends CharacterRecord {
  _CharacterRecordImpl({
    int? id,
    Map<String, int>? spellActivationUses,
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
    int? userId,
    int? experience,
    _iwwn584b.CharacterAlignment? alignmentValue,
    int? raceId,
    _ittxuxz1.RaceData? race,
    int? subraceId,
    _i2k66n75.SubraceData? subrace,
    int? backgroundId,
    _i1utzyju.BackgroundData? background,
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
    Map<int, int>? currentPactSlots,
    String? activeConcentrationSpellName,
    int? customInitiativeBonus,
    int? customArmorClassBonus,
    int? walkingSpeed,
    int? swimmingSpeed,
    int? climbingSpeed,
    int? flyingSpeed,
    _il8xya9v.CharacterSpeedKind? displayedSpeedKind,
    int? customSpellSaveDcBonus,
    int? customSpellAttackBonus,
    List<String>? preparedSpellKeys,
    List<_i1didlhi.ConditionType>? activeConditions,
    int? exhaustionLevel,
    bool? inspiration,
    List<_iekoe72x.CharacterInventoryItemData>? equipment,
    _ihorlaio.CharacterEquipmentSelectionData? equippedArmor,
    _ihorlaio.CharacterEquipmentSelectionData? equippedShield,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? manualSkillProficiencies,
    List<_iw3bk51e.Ability>? manualSavingThrowProficiencies,
    List<_ipq2j7wi.CharacterSkillProficiencyState>?
    manualSkillProficiencyOverrides,
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>?
    manualSavingThrowProficiencyOverrides,
    _iy48gvsl.CharacterLanguageOverridesData? manualLanguageOverrides,
    _i6hm0w7y.CharacterToolProficiencyOverridesData?
    manualToolProficiencyOverrides,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData?
    manualWeaponProficiencyOverrides,
    _icsd58ny.CharacterArmorTrainingOverridesData? manualArmorTrainingOverrides,
    List<_ioruio1c.CharacterNoteData>? notes,
    List<_i9jwtlvb.CharacterAttackData>? attacks,
    List<_iq39grm2.CharacterFeatureOverrideData>? featureOverrides,
    List<_ikl23b4y.CharacterResourceStateData>? resourceStates,
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>? spellRecoveryTriggers,
  }) : super._(
         id: id,
         spellActivationUses: spellActivationUses,
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
         userId: userId,
         experience: experience,
         alignmentValue: alignmentValue,
         raceId: raceId,
         race: race,
         subraceId: subraceId,
         subrace: subrace,
         backgroundId: backgroundId,
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
         currentPactSlots: currentPactSlots,
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
         spellRecoveryTriggers: spellRecoveryTriggers,
       );

  /// Returns a shallow copy of this [CharacterRecord]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterRecord copyWith({
    Object? id = _Undefined,
    Object? spellActivationUses = _Undefined,
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
    Object? userId = _Undefined,
    Object? experience = _Undefined,
    Object? alignmentValue = _Undefined,
    Object? raceId = _Undefined,
    Object? race = _Undefined,
    Object? subraceId = _Undefined,
    Object? subrace = _Undefined,
    Object? backgroundId = _Undefined,
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
    Object? currentPactSlots = _Undefined,
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
    Object? spellRecoveryTriggers = _Undefined,
  }) {
    return CharacterRecord(
      id: id is int? ? id : this.id,
      spellActivationUses: spellActivationUses is Map<String, int>?
          ? spellActivationUses
          : this.spellActivationUses?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
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
      portraitVersion: portraitVersion is int?
          ? portraitVersion
          : this.portraitVersion,
      syncTargetRevisions: syncTargetRevisions is Map<String, int>?
          ? syncTargetRevisions
          : this.syncTargetRevisions?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      syncBarrierTokens: syncBarrierTokens is Map<String, String>?
          ? syncBarrierTokens
          : this.syncBarrierTokens?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      userId: userId is int? ? userId : this.userId,
      experience: experience is int? ? experience : this.experience,
      alignmentValue: alignmentValue is _iwwn584b.CharacterAlignment?
          ? alignmentValue
          : this.alignmentValue,
      raceId: raceId is int? ? raceId : this.raceId,
      race: race is _ittxuxz1.RaceData? ? race : this.race?.copyWith(),
      subraceId: subraceId is int? ? subraceId : this.subraceId,
      subrace: subrace is _i2k66n75.SubraceData?
          ? subrace
          : this.subrace?.copyWith(),
      backgroundId: backgroundId is int? ? backgroundId : this.backgroundId,
      background: background is _i1utzyju.BackgroundData?
          ? background
          : this.background?.copyWith(),
      baseAbilityScores: baseAbilityScores is Map<String, int>?
          ? baseAbilityScores
          : this.baseAbilityScores?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      customAbilityBonuses: customAbilityBonuses is Map<String, int>?
          ? customAbilityBonuses
          : this.customAbilityBonuses?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
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
      hpPerLevelBonus: hpPerLevelBonus is int?
          ? hpPerLevelBonus
          : this.hpPerLevelBonus,
      hpFlatBonus: hpFlatBonus is int? ? hpFlatBonus : this.hpFlatBonus,
      currentHitDice: currentHitDice is Map<String, int>?
          ? currentHitDice
          : this.currentHitDice?.map((key0, value0) => MapEntry(key0, value0)),
      hitDiceMaxOverrides: hitDiceMaxOverrides is Map<String, int>?
          ? hitDiceMaxOverrides
          : this.hitDiceMaxOverrides?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      currentSpellSlots: currentSpellSlots is Map<int, int>?
          ? currentSpellSlots
          : this.currentSpellSlots?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      currentPactSlots: currentPactSlots is Map<int, int>?
          ? currentPactSlots
          : this.currentPactSlots?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
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
      displayedSpeedKind: displayedSpeedKind is _il8xya9v.CharacterSpeedKind?
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
      activeConditions: activeConditions is List<_i1didlhi.ConditionType>?
          ? activeConditions
          : this.activeConditions?.map((e0) => e0).toList(),
      exhaustionLevel: exhaustionLevel is int?
          ? exhaustionLevel
          : this.exhaustionLevel,
      inspiration: inspiration is bool? ? inspiration : this.inspiration,
      equipment: equipment is List<_iekoe72x.CharacterInventoryItemData>?
          ? equipment
          : this.equipment?.map((e0) => e0.copyWith()).toList(),
      equippedArmor: equippedArmor is _ihorlaio.CharacterEquipmentSelectionData?
          ? equippedArmor
          : this.equippedArmor?.copyWith(),
      equippedShield:
          equippedShield is _ihorlaio.CharacterEquipmentSelectionData?
          ? equippedShield
          : this.equippedShield?.copyWith(),
      manualSkillProficiencies:
          manualSkillProficiencies
              is List<_ipq2j7wi.CharacterSkillProficiencyState>?
          ? manualSkillProficiencies
          : this.manualSkillProficiencies?.map((e0) => e0.copyWith()).toList(),
      manualSavingThrowProficiencies:
          manualSavingThrowProficiencies is List<_iw3bk51e.Ability>?
          ? manualSavingThrowProficiencies
          : this.manualSavingThrowProficiencies?.map((e0) => e0).toList(),
      manualSkillProficiencyOverrides:
          manualSkillProficiencyOverrides
              is List<_ipq2j7wi.CharacterSkillProficiencyState>?
          ? manualSkillProficiencyOverrides
          : this.manualSkillProficiencyOverrides
                ?.map((e0) => e0.copyWith())
                .toList(),
      manualSavingThrowProficiencyOverrides:
          manualSavingThrowProficiencyOverrides
              is List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>?
          ? manualSavingThrowProficiencyOverrides
          : this.manualSavingThrowProficiencyOverrides
                ?.map((e0) => e0.copyWith())
                .toList(),
      manualLanguageOverrides:
          manualLanguageOverrides is _iy48gvsl.CharacterLanguageOverridesData?
          ? manualLanguageOverrides
          : this.manualLanguageOverrides?.copyWith(),
      manualToolProficiencyOverrides:
          manualToolProficiencyOverrides
              is _i6hm0w7y.CharacterToolProficiencyOverridesData?
          ? manualToolProficiencyOverrides
          : this.manualToolProficiencyOverrides?.copyWith(),
      manualWeaponProficiencyOverrides:
          manualWeaponProficiencyOverrides
              is _i6snm8iz.CharacterWeaponProficiencyOverridesData?
          ? manualWeaponProficiencyOverrides
          : this.manualWeaponProficiencyOverrides?.copyWith(),
      manualArmorTrainingOverrides:
          manualArmorTrainingOverrides
              is _icsd58ny.CharacterArmorTrainingOverridesData?
          ? manualArmorTrainingOverrides
          : this.manualArmorTrainingOverrides?.copyWith(),
      notes: notes is List<_ioruio1c.CharacterNoteData>?
          ? notes
          : this.notes?.map((e0) => e0.copyWith()).toList(),
      attacks: attacks is List<_i9jwtlvb.CharacterAttackData>?
          ? attacks
          : this.attacks?.map((e0) => e0.copyWith()).toList(),
      featureOverrides:
          featureOverrides is List<_iq39grm2.CharacterFeatureOverrideData>?
          ? featureOverrides
          : this.featureOverrides?.map((e0) => e0.copyWith()).toList(),
      resourceStates:
          resourceStates is List<_ikl23b4y.CharacterResourceStateData>?
          ? resourceStates
          : this.resourceStates?.map((e0) => e0.copyWith()).toList(),
      spellRecoveryTriggers:
          spellRecoveryTriggers
              is Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>?
          ? spellRecoveryTriggers
          : this.spellRecoveryTriggers?.map(
              (key0, value0) => MapEntry(key0, value0.copyWith()),
            ),
    );
  }
}

class CharacterRecordUpdateTable extends _is.UpdateTable<CharacterRecordTable> {
  CharacterRecordUpdateTable(super.table);

  _is.ColumnValue<Map<String, int>, Map<String, int>> spellActivationUses(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.spellActivationUses, value);

  _is.ColumnValue<String, String> name(String? value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> age(String? value) =>
      _is.ColumnValue(table.age, value);

  _is.ColumnValue<String, String> height(String? value) =>
      _is.ColumnValue(table.height, value);

  _is.ColumnValue<String, String> weight(String? value) =>
      _is.ColumnValue(table.weight, value);

  _is.ColumnValue<String, String> eyes(String? value) =>
      _is.ColumnValue(table.eyes, value);

  _is.ColumnValue<String, String> skin(String? value) =>
      _is.ColumnValue(table.skin, value);

  _is.ColumnValue<String, String> hair(String? value) =>
      _is.ColumnValue(table.hair, value);

  _is.ColumnValue<String, String> appearance(String? value) =>
      _is.ColumnValue(table.appearance, value);

  _is.ColumnValue<String, String> backstory(String? value) =>
      _is.ColumnValue(table.backstory, value);

  _is.ColumnValue<String, String> goals(String? value) =>
      _is.ColumnValue(table.goals, value);

  _is.ColumnValue<String, String> alliesOrganizations(String? value) =>
      _is.ColumnValue(table.alliesOrganizations, value);

  _is.ColumnValue<String, String> personalityTraits(String? value) =>
      _is.ColumnValue(table.personalityTraits, value);

  _is.ColumnValue<String, String> ideals(String? value) =>
      _is.ColumnValue(table.ideals, value);

  _is.ColumnValue<String, String> bonds(String? value) =>
      _is.ColumnValue(table.bonds, value);

  _is.ColumnValue<String, String> flaws(String? value) =>
      _is.ColumnValue(table.flaws, value);

  _is.ColumnValue<int, int> version(int? value) =>
      _is.ColumnValue(table.version, value);

  _is.ColumnValue<int, int> portraitVersion(int? value) =>
      _is.ColumnValue(table.portraitVersion, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> syncTargetRevisions(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.syncTargetRevisions, value);

  _is.ColumnValue<Map<String, String>, Map<String, String>> syncBarrierTokens(
    Map<String, String>? value,
  ) => _is.ColumnValue(table.syncBarrierTokens, value);

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _is.ColumnValue(table.createdAt, value);

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _is.ColumnValue(table.updatedAt, value);

  _is.ColumnValue<int, int> userId(int? value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> experience(int? value) =>
      _is.ColumnValue(table.experience, value);

  _is.ColumnValue<_iwwn584b.CharacterAlignment, _iwwn584b.CharacterAlignment>
  alignmentValue(_iwwn584b.CharacterAlignment? value) =>
      _is.ColumnValue(table.alignmentValue, value);

  _is.ColumnValue<int, int> raceId(int? value) =>
      _is.ColumnValue(table.raceId, value);

  _is.ColumnValue<int, int> subraceId(int? value) =>
      _is.ColumnValue(table.subraceId, value);

  _is.ColumnValue<int, int> backgroundId(int? value) =>
      _is.ColumnValue(table.backgroundId, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> baseAbilityScores(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.baseAbilityScores, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> customAbilityBonuses(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.customAbilityBonuses, value);

  _is.ColumnValue<bool, bool> useFlexibleAbilityBonuses(bool? value) =>
      _is.ColumnValue(table.useFlexibleAbilityBonuses, value);

  _is.ColumnValue<int, int> temporaryHp(int? value) =>
      _is.ColumnValue(table.temporaryHp, value);

  _is.ColumnValue<int, int> currentHp(int? value) =>
      _is.ColumnValue(table.currentHp, value);

  _is.ColumnValue<int, int> deathSaveSuccesses(int? value) =>
      _is.ColumnValue(table.deathSaveSuccesses, value);

  _is.ColumnValue<int, int> deathSaveFailures(int? value) =>
      _is.ColumnValue(table.deathSaveFailures, value);

  _is.ColumnValue<int, int> hpPerLevelBonus(int? value) =>
      _is.ColumnValue(table.hpPerLevelBonus, value);

  _is.ColumnValue<int, int> hpFlatBonus(int? value) =>
      _is.ColumnValue(table.hpFlatBonus, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> currentHitDice(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.currentHitDice, value);

  _is.ColumnValue<Map<String, int>, Map<String, int>> hitDiceMaxOverrides(
    Map<String, int>? value,
  ) => _is.ColumnValue(table.hitDiceMaxOverrides, value);

  _is.ColumnValue<Map<int, int>, Map<int, int>> currentSpellSlots(
    Map<int, int>? value,
  ) => _is.ColumnValue(table.currentSpellSlots, value);

  _is.ColumnValue<Map<int, int>, Map<int, int>> currentPactSlots(
    Map<int, int>? value,
  ) => _is.ColumnValue(table.currentPactSlots, value);

  _is.ColumnValue<String, String> activeConcentrationSpellName(String? value) =>
      _is.ColumnValue(table.activeConcentrationSpellName, value);

  _is.ColumnValue<int, int> customInitiativeBonus(int? value) =>
      _is.ColumnValue(table.customInitiativeBonus, value);

  _is.ColumnValue<int, int> customArmorClassBonus(int? value) =>
      _is.ColumnValue(table.customArmorClassBonus, value);

  _is.ColumnValue<int, int> walkingSpeed(int? value) =>
      _is.ColumnValue(table.walkingSpeed, value);

  _is.ColumnValue<int, int> swimmingSpeed(int? value) =>
      _is.ColumnValue(table.swimmingSpeed, value);

  _is.ColumnValue<int, int> climbingSpeed(int? value) =>
      _is.ColumnValue(table.climbingSpeed, value);

  _is.ColumnValue<int, int> flyingSpeed(int? value) =>
      _is.ColumnValue(table.flyingSpeed, value);

  _is.ColumnValue<_il8xya9v.CharacterSpeedKind, _il8xya9v.CharacterSpeedKind>
  displayedSpeedKind(_il8xya9v.CharacterSpeedKind? value) =>
      _is.ColumnValue(table.displayedSpeedKind, value);

  _is.ColumnValue<int, int> customSpellSaveDcBonus(int? value) =>
      _is.ColumnValue(table.customSpellSaveDcBonus, value);

  _is.ColumnValue<int, int> customSpellAttackBonus(int? value) =>
      _is.ColumnValue(table.customSpellAttackBonus, value);

  _is.ColumnValue<List<String>, List<String>> preparedSpellKeys(
    List<String>? value,
  ) => _is.ColumnValue(table.preparedSpellKeys, value);

  _is.ColumnValue<List<_i1didlhi.ConditionType>, List<_i1didlhi.ConditionType>>
  activeConditions(List<_i1didlhi.ConditionType>? value) =>
      _is.ColumnValue(table.activeConditions, value);

  _is.ColumnValue<int, int> exhaustionLevel(int? value) =>
      _is.ColumnValue(table.exhaustionLevel, value);

  _is.ColumnValue<bool, bool> inspiration(bool? value) =>
      _is.ColumnValue(table.inspiration, value);

  _is.ColumnValue<
    List<_iekoe72x.CharacterInventoryItemData>,
    List<_iekoe72x.CharacterInventoryItemData>
  >
  equipment(List<_iekoe72x.CharacterInventoryItemData>? value) =>
      _is.ColumnValue(table.equipment, value);

  _is.ColumnValue<
    _ihorlaio.CharacterEquipmentSelectionData,
    _ihorlaio.CharacterEquipmentSelectionData
  >
  equippedArmor(_ihorlaio.CharacterEquipmentSelectionData? value) =>
      _is.ColumnValue(table.equippedArmor, value);

  _is.ColumnValue<
    _ihorlaio.CharacterEquipmentSelectionData,
    _ihorlaio.CharacterEquipmentSelectionData
  >
  equippedShield(_ihorlaio.CharacterEquipmentSelectionData? value) =>
      _is.ColumnValue(table.equippedShield, value);

  _is.ColumnValue<
    List<_ipq2j7wi.CharacterSkillProficiencyState>,
    List<_ipq2j7wi.CharacterSkillProficiencyState>
  >
  manualSkillProficiencies(
    List<_ipq2j7wi.CharacterSkillProficiencyState>? value,
  ) => _is.ColumnValue(table.manualSkillProficiencies, value);

  _is.ColumnValue<List<_iw3bk51e.Ability>, List<_iw3bk51e.Ability>>
  manualSavingThrowProficiencies(List<_iw3bk51e.Ability>? value) =>
      _is.ColumnValue(table.manualSavingThrowProficiencies, value);

  _is.ColumnValue<
    List<_ipq2j7wi.CharacterSkillProficiencyState>,
    List<_ipq2j7wi.CharacterSkillProficiencyState>
  >
  manualSkillProficiencyOverrides(
    List<_ipq2j7wi.CharacterSkillProficiencyState>? value,
  ) => _is.ColumnValue(table.manualSkillProficiencyOverrides, value);

  _is.ColumnValue<
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>,
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>
  >
  manualSavingThrowProficiencyOverrides(
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>? value,
  ) => _is.ColumnValue(table.manualSavingThrowProficiencyOverrides, value);

  _is.ColumnValue<
    _iy48gvsl.CharacterLanguageOverridesData,
    _iy48gvsl.CharacterLanguageOverridesData
  >
  manualLanguageOverrides(_iy48gvsl.CharacterLanguageOverridesData? value) =>
      _is.ColumnValue(table.manualLanguageOverrides, value);

  _is.ColumnValue<
    _i6hm0w7y.CharacterToolProficiencyOverridesData,
    _i6hm0w7y.CharacterToolProficiencyOverridesData
  >
  manualToolProficiencyOverrides(
    _i6hm0w7y.CharacterToolProficiencyOverridesData? value,
  ) => _is.ColumnValue(table.manualToolProficiencyOverrides, value);

  _is.ColumnValue<
    _i6snm8iz.CharacterWeaponProficiencyOverridesData,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData
  >
  manualWeaponProficiencyOverrides(
    _i6snm8iz.CharacterWeaponProficiencyOverridesData? value,
  ) => _is.ColumnValue(table.manualWeaponProficiencyOverrides, value);

  _is.ColumnValue<
    _icsd58ny.CharacterArmorTrainingOverridesData,
    _icsd58ny.CharacterArmorTrainingOverridesData
  >
  manualArmorTrainingOverrides(
    _icsd58ny.CharacterArmorTrainingOverridesData? value,
  ) => _is.ColumnValue(table.manualArmorTrainingOverrides, value);

  _is.ColumnValue<
    List<_ioruio1c.CharacterNoteData>,
    List<_ioruio1c.CharacterNoteData>
  >
  notes(List<_ioruio1c.CharacterNoteData>? value) =>
      _is.ColumnValue(table.notes, value);

  _is.ColumnValue<
    List<_i9jwtlvb.CharacterAttackData>,
    List<_i9jwtlvb.CharacterAttackData>
  >
  attacks(List<_i9jwtlvb.CharacterAttackData>? value) =>
      _is.ColumnValue(table.attacks, value);

  _is.ColumnValue<
    List<_iq39grm2.CharacterFeatureOverrideData>,
    List<_iq39grm2.CharacterFeatureOverrideData>
  >
  featureOverrides(List<_iq39grm2.CharacterFeatureOverrideData>? value) =>
      _is.ColumnValue(table.featureOverrides, value);

  _is.ColumnValue<
    List<_ikl23b4y.CharacterResourceStateData>,
    List<_ikl23b4y.CharacterResourceStateData>
  >
  resourceStates(List<_ikl23b4y.CharacterResourceStateData>? value) =>
      _is.ColumnValue(table.resourceStates, value);

  _is.ColumnValue<
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>,
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>
  >
  spellRecoveryTriggers(
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>? value,
  ) => _is.ColumnValue(table.spellRecoveryTriggers, value);
}

class CharacterRecordTable extends _is.Table<int?> {
  CharacterRecordTable({super.tableRelation}) : super(tableName: 'characters') {
    updateTable = CharacterRecordUpdateTable(this);
    spellActivationUses = _is.ColumnSerializable<Map<String, int>>(
      'spellActivationUses',
      this,
    );
    name = _is.ColumnString('name', this);
    age = _is.ColumnString('age', this);
    height = _is.ColumnString('height', this);
    weight = _is.ColumnString('weight', this);
    eyes = _is.ColumnString('eyes', this);
    skin = _is.ColumnString('skin', this);
    hair = _is.ColumnString('hair', this);
    appearance = _is.ColumnString('appearance', this);
    backstory = _is.ColumnString('backstory', this);
    goals = _is.ColumnString('goals', this);
    alliesOrganizations = _is.ColumnString('alliesOrganizations', this);
    personalityTraits = _is.ColumnString('personalityTraits', this);
    ideals = _is.ColumnString('ideals', this);
    bonds = _is.ColumnString('bonds', this);
    flaws = _is.ColumnString('flaws', this);
    version = _is.ColumnInt('version', this);
    portraitVersion = _is.ColumnInt('portraitVersion', this);
    syncTargetRevisions = _is.ColumnSerializable<Map<String, int>>(
      'syncTargetRevisions',
      this,
    );
    syncBarrierTokens = _is.ColumnSerializable<Map<String, String>>(
      'syncBarrierTokens',
      this,
    );
    createdAt = _is.ColumnDateTime('createdAt', this);
    updatedAt = _is.ColumnDateTime('updatedAt', this);
    userId = _is.ColumnInt('userId', this);
    experience = _is.ColumnInt('experience', this);
    alignmentValue = _is.ColumnEnum(
      'alignmentValue',
      this,
      _is.EnumSerialization.byName,
    );
    raceId = _is.ColumnInt('raceId', this);
    subraceId = _is.ColumnInt('subraceId', this);
    backgroundId = _is.ColumnInt('backgroundId', this);
    baseAbilityScores = _is.ColumnSerializable<Map<String, int>>(
      'baseAbilityScores',
      this,
    );
    customAbilityBonuses = _is.ColumnSerializable<Map<String, int>>(
      'customAbilityBonuses',
      this,
    );
    useFlexibleAbilityBonuses = _is.ColumnBool(
      'useFlexibleAbilityBonuses',
      this,
    );
    temporaryHp = _is.ColumnInt('temporaryHp', this);
    currentHp = _is.ColumnInt('currentHp', this);
    deathSaveSuccesses = _is.ColumnInt('deathSaveSuccesses', this);
    deathSaveFailures = _is.ColumnInt('deathSaveFailures', this);
    hpPerLevelBonus = _is.ColumnInt('hpPerLevelBonus', this);
    hpFlatBonus = _is.ColumnInt('hpFlatBonus', this);
    currentHitDice = _is.ColumnSerializable<Map<String, int>>(
      'currentHitDice',
      this,
    );
    hitDiceMaxOverrides = _is.ColumnSerializable<Map<String, int>>(
      'hitDiceMaxOverrides',
      this,
    );
    currentSpellSlots = _is.ColumnSerializable<Map<int, int>>(
      'currentSpellSlots',
      this,
    );
    currentPactSlots = _is.ColumnSerializable<Map<int, int>>(
      'currentPactSlots',
      this,
    );
    activeConcentrationSpellName = _is.ColumnString(
      'activeConcentrationSpellName',
      this,
    );
    customInitiativeBonus = _is.ColumnInt('customInitiativeBonus', this);
    customArmorClassBonus = _is.ColumnInt('customArmorClassBonus', this);
    walkingSpeed = _is.ColumnInt('walkingSpeed', this);
    swimmingSpeed = _is.ColumnInt('swimmingSpeed', this);
    climbingSpeed = _is.ColumnInt('climbingSpeed', this);
    flyingSpeed = _is.ColumnInt('flyingSpeed', this);
    displayedSpeedKind = _is.ColumnEnum(
      'displayedSpeedKind',
      this,
      _is.EnumSerialization.byIndex,
    );
    customSpellSaveDcBonus = _is.ColumnInt('customSpellSaveDcBonus', this);
    customSpellAttackBonus = _is.ColumnInt('customSpellAttackBonus', this);
    preparedSpellKeys = _is.ColumnSerializable<List<String>>(
      'preparedSpellKeys',
      this,
    );
    activeConditions = _is.ColumnSerializable<List<_i1didlhi.ConditionType>>(
      'activeConditions',
      this,
    );
    exhaustionLevel = _is.ColumnInt('exhaustionLevel', this);
    inspiration = _is.ColumnBool('inspiration', this);
    equipment =
        _is.ColumnSerializable<List<_iekoe72x.CharacterInventoryItemData>>(
          'equipment',
          this,
        );
    equippedArmor =
        _is.ColumnSerializable<_ihorlaio.CharacterEquipmentSelectionData>(
          'equippedArmor',
          this,
        );
    equippedShield =
        _is.ColumnSerializable<_ihorlaio.CharacterEquipmentSelectionData>(
          'equippedShield',
          this,
        );
    manualSkillProficiencies =
        _is.ColumnSerializable<List<_ipq2j7wi.CharacterSkillProficiencyState>>(
          'manualSkillProficiencies',
          this,
        );
    manualSavingThrowProficiencies =
        _is.ColumnSerializable<List<_iw3bk51e.Ability>>(
          'manualSavingThrowProficiencies',
          this,
        );
    manualSkillProficiencyOverrides =
        _is.ColumnSerializable<List<_ipq2j7wi.CharacterSkillProficiencyState>>(
          'manualSkillProficiencyOverrides',
          this,
        );
    manualSavingThrowProficiencyOverrides =
        _is.ColumnSerializable<
          List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>
        >('manualSavingThrowProficiencyOverrides', this);
    manualLanguageOverrides =
        _is.ColumnSerializable<_iy48gvsl.CharacterLanguageOverridesData>(
          'manualLanguageOverrides',
          this,
        );
    manualToolProficiencyOverrides =
        _is.ColumnSerializable<_i6hm0w7y.CharacterToolProficiencyOverridesData>(
          'manualToolProficiencyOverrides',
          this,
        );
    manualWeaponProficiencyOverrides =
        _is.ColumnSerializable<
          _i6snm8iz.CharacterWeaponProficiencyOverridesData
        >('manualWeaponProficiencyOverrides', this);
    manualArmorTrainingOverrides =
        _is.ColumnSerializable<_icsd58ny.CharacterArmorTrainingOverridesData>(
          'manualArmorTrainingOverrides',
          this,
        );
    notes = _is.ColumnSerializable<List<_ioruio1c.CharacterNoteData>>(
      'notes',
      this,
    );
    attacks = _is.ColumnSerializable<List<_i9jwtlvb.CharacterAttackData>>(
      'attacks',
      this,
    );
    featureOverrides =
        _is.ColumnSerializable<List<_iq39grm2.CharacterFeatureOverrideData>>(
          'featureOverrides',
          this,
        );
    resourceStates =
        _is.ColumnSerializable<List<_ikl23b4y.CharacterResourceStateData>>(
          'resourceStates',
          this,
        );
    spellRecoveryTriggers =
        _is.ColumnSerializable<
          Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>
        >('spellRecoveryTriggers', this);
  }

  late final CharacterRecordUpdateTable updateTable;

  late final _is.ColumnSerializable<Map<String, int>> spellActivationUses;

  late final _is.ColumnString name;

  late final _is.ColumnString age;

  late final _is.ColumnString height;

  late final _is.ColumnString weight;

  late final _is.ColumnString eyes;

  late final _is.ColumnString skin;

  late final _is.ColumnString hair;

  late final _is.ColumnString appearance;

  late final _is.ColumnString backstory;

  late final _is.ColumnString goals;

  late final _is.ColumnString alliesOrganizations;

  late final _is.ColumnString personalityTraits;

  late final _is.ColumnString ideals;

  late final _is.ColumnString bonds;

  late final _is.ColumnString flaws;

  late final _is.ColumnInt version;

  late final _is.ColumnInt portraitVersion;

  late final _is.ColumnSerializable<Map<String, int>> syncTargetRevisions;

  late final _is.ColumnSerializable<Map<String, String>> syncBarrierTokens;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt experience;

  late final _is.ColumnEnum<_iwwn584b.CharacterAlignment> alignmentValue;

  late final _is.ColumnInt raceId;

  _ittxuxz1.RaceDataTable? _race;

  late final _is.ColumnInt subraceId;

  _i2k66n75.SubraceDataTable? _subrace;

  late final _is.ColumnInt backgroundId;

  _i1utzyju.BackgroundDataTable? _background;

  late final _is.ColumnSerializable<Map<String, int>> baseAbilityScores;

  late final _is.ColumnSerializable<Map<String, int>> customAbilityBonuses;

  late final _is.ColumnBool useFlexibleAbilityBonuses;

  late final _is.ColumnInt temporaryHp;

  late final _is.ColumnInt currentHp;

  late final _is.ColumnInt deathSaveSuccesses;

  late final _is.ColumnInt deathSaveFailures;

  late final _is.ColumnInt hpPerLevelBonus;

  late final _is.ColumnInt hpFlatBonus;

  late final _is.ColumnSerializable<Map<String, int>> currentHitDice;

  late final _is.ColumnSerializable<Map<String, int>> hitDiceMaxOverrides;

  late final _is.ColumnSerializable<Map<int, int>> currentSpellSlots;

  late final _is.ColumnSerializable<Map<int, int>> currentPactSlots;

  late final _is.ColumnString activeConcentrationSpellName;

  late final _is.ColumnInt customInitiativeBonus;

  late final _is.ColumnInt customArmorClassBonus;

  late final _is.ColumnInt walkingSpeed;

  late final _is.ColumnInt swimmingSpeed;

  late final _is.ColumnInt climbingSpeed;

  late final _is.ColumnInt flyingSpeed;

  late final _is.ColumnEnum<_il8xya9v.CharacterSpeedKind> displayedSpeedKind;

  late final _is.ColumnInt customSpellSaveDcBonus;

  late final _is.ColumnInt customSpellAttackBonus;

  late final _is.ColumnSerializable<List<String>> preparedSpellKeys;

  late final _is.ColumnSerializable<List<_i1didlhi.ConditionType>>
  activeConditions;

  late final _is.ColumnInt exhaustionLevel;

  late final _is.ColumnBool inspiration;

  late final _is.ColumnSerializable<List<_iekoe72x.CharacterInventoryItemData>>
  equipment;

  late final _is.ColumnSerializable<_ihorlaio.CharacterEquipmentSelectionData>
  equippedArmor;

  late final _is.ColumnSerializable<_ihorlaio.CharacterEquipmentSelectionData>
  equippedShield;

  late final _is.ColumnSerializable<
    List<_ipq2j7wi.CharacterSkillProficiencyState>
  >
  manualSkillProficiencies;

  late final _is.ColumnSerializable<List<_iw3bk51e.Ability>>
  manualSavingThrowProficiencies;

  late final _is.ColumnSerializable<
    List<_ipq2j7wi.CharacterSkillProficiencyState>
  >
  manualSkillProficiencyOverrides;

  late final _is.ColumnSerializable<
    List<_iax3ptkk.CharacterSavingThrowProficiencyOverrideData>
  >
  manualSavingThrowProficiencyOverrides;

  late final _is.ColumnSerializable<_iy48gvsl.CharacterLanguageOverridesData>
  manualLanguageOverrides;

  late final _is.ColumnSerializable<
    _i6hm0w7y.CharacterToolProficiencyOverridesData
  >
  manualToolProficiencyOverrides;

  late final _is.ColumnSerializable<
    _i6snm8iz.CharacterWeaponProficiencyOverridesData
  >
  manualWeaponProficiencyOverrides;

  late final _is.ColumnSerializable<
    _icsd58ny.CharacterArmorTrainingOverridesData
  >
  manualArmorTrainingOverrides;

  late final _is.ColumnSerializable<List<_ioruio1c.CharacterNoteData>> notes;

  late final _is.ColumnSerializable<List<_i9jwtlvb.CharacterAttackData>>
  attacks;

  late final _is.ColumnSerializable<
    List<_iq39grm2.CharacterFeatureOverrideData>
  >
  featureOverrides;

  late final _is.ColumnSerializable<List<_ikl23b4y.CharacterResourceStateData>>
  resourceStates;

  late final _is.ColumnSerializable<
    Map<String, _i7xdtn5i.SpellSlotRecoveryTriggerData>
  >
  spellRecoveryTriggers;

  _ittxuxz1.RaceDataTable get race {
    if (_race != null) return _race!;
    _race = _is.createRelationTable(
      relationFieldName: 'race',
      field: CharacterRecord.t.raceId,
      foreignField: _ittxuxz1.RaceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _ittxuxz1.RaceDataTable(tableRelation: foreignTableRelation),
    );
    return _race!;
  }

  _i2k66n75.SubraceDataTable get subrace {
    if (_subrace != null) return _subrace!;
    _subrace = _is.createRelationTable(
      relationFieldName: 'subrace',
      field: CharacterRecord.t.subraceId,
      foreignField: _i2k66n75.SubraceData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2k66n75.SubraceDataTable(tableRelation: foreignTableRelation),
    );
    return _subrace!;
  }

  _i1utzyju.BackgroundDataTable get background {
    if (_background != null) return _background!;
    _background = _is.createRelationTable(
      relationFieldName: 'background',
      field: CharacterRecord.t.backgroundId,
      foreignField: _i1utzyju.BackgroundData.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i1utzyju.BackgroundDataTable(tableRelation: foreignTableRelation),
    );
    return _background!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    spellActivationUses,
    name,
    age,
    height,
    weight,
    eyes,
    skin,
    hair,
    appearance,
    backstory,
    goals,
    alliesOrganizations,
    personalityTraits,
    ideals,
    bonds,
    flaws,
    version,
    portraitVersion,
    syncTargetRevisions,
    syncBarrierTokens,
    createdAt,
    updatedAt,
    userId,
    experience,
    alignmentValue,
    raceId,
    subraceId,
    backgroundId,
    baseAbilityScores,
    customAbilityBonuses,
    useFlexibleAbilityBonuses,
    temporaryHp,
    currentHp,
    deathSaveSuccesses,
    deathSaveFailures,
    hpPerLevelBonus,
    hpFlatBonus,
    currentHitDice,
    hitDiceMaxOverrides,
    currentSpellSlots,
    currentPactSlots,
    activeConcentrationSpellName,
    customInitiativeBonus,
    customArmorClassBonus,
    walkingSpeed,
    swimmingSpeed,
    climbingSpeed,
    flyingSpeed,
    displayedSpeedKind,
    customSpellSaveDcBonus,
    customSpellAttackBonus,
    preparedSpellKeys,
    activeConditions,
    exhaustionLevel,
    inspiration,
    equipment,
    equippedArmor,
    equippedShield,
    manualSkillProficiencies,
    manualSavingThrowProficiencies,
    manualSkillProficiencyOverrides,
    manualSavingThrowProficiencyOverrides,
    manualLanguageOverrides,
    manualToolProficiencyOverrides,
    manualWeaponProficiencyOverrides,
    manualArmorTrainingOverrides,
    notes,
    attacks,
    featureOverrides,
    resourceStates,
    spellRecoveryTriggers,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'race') {
      return race;
    }
    if (relationField == 'subrace') {
      return subrace;
    }
    if (relationField == 'background') {
      return background;
    }
    return null;
  }
}

class CharacterRecordInclude extends _is.IncludeObject {
  CharacterRecordInclude._({
    _ittxuxz1.RaceDataInclude? race,
    _i2k66n75.SubraceDataInclude? subrace,
    _i1utzyju.BackgroundDataInclude? background,
  }) {
    _race = race;
    _subrace = subrace;
    _background = background;
  }

  _ittxuxz1.RaceDataInclude? _race;

  _i2k66n75.SubraceDataInclude? _subrace;

  _i1utzyju.BackgroundDataInclude? _background;

  @override
  Map<String, _is.Include?> get includes => {
    'race': _race,
    'subrace': _subrace,
    'background': _background,
  };

  @override
  _is.Table<int?> get table => CharacterRecord.t;
}

class CharacterRecordIncludeList extends _is.IncludeList {
  CharacterRecordIncludeList._({
    _is.WhereExpressionBuilder<CharacterRecordTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(CharacterRecord.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => CharacterRecord.t;
}

class CharacterRecordRepository {
  const CharacterRecordRepository._();

  final attachRow = const CharacterRecordAttachRowRepository._();

  final detachRow = const CharacterRecordDetachRowRepository._();

  /// Returns a list of [CharacterRecord]s matching the given query parameters.
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
  Future<List<CharacterRecord>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<CharacterRecord>(
      where: where?.call(CharacterRecord.t),
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [CharacterRecord] matching the given query parameters.
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
  Future<CharacterRecord?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? offset,
    _is.OrderByBuilder<CharacterRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _is.Transaction? transaction,
    CharacterRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<CharacterRecord>(
      where: where?.call(CharacterRecord.t),
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [CharacterRecord] by its [id] or null if no such row exists.
  Future<CharacterRecord?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    CharacterRecordInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<CharacterRecord>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [CharacterRecord]s in the list and returns the inserted rows.
  ///
  /// The returned [CharacterRecord]s will have their `id` fields set.
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
  Future<List<CharacterRecord>> insert(
    _is.DatabaseSession session,
    List<CharacterRecord> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<CharacterRecord>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [CharacterRecord] and returns the inserted row.
  ///
  /// The returned [CharacterRecord] will have its `id` field set.
  Future<CharacterRecord> insertRow(
    _is.DatabaseSession session,
    CharacterRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<CharacterRecord>(row, transaction: transaction);
  }

  /// Upserts all [CharacterRecord]s in the list and returns the resulting rows.
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
  /// The returned [CharacterRecord]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterRecord>> upsert(
    _is.DatabaseSession session,
    List<CharacterRecord> rows, {
    required _is.ColumnSelections<CharacterRecordTable> conflictColumns,
    _is.ColumnSelections<CharacterRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterRecordTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<CharacterRecord>(
      rows,
      conflictColumns: conflictColumns(CharacterRecord.t),
      updateColumns: updateColumns?.call(CharacterRecord.t),
      updateWhere: updateWhere?.call(CharacterRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [CharacterRecord] and returns the resulting row.
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
  /// The returned [CharacterRecord] will have its `id` field set.
  Future<CharacterRecord?> upsertRow(
    _is.DatabaseSession session,
    CharacterRecord row, {
    required _is.ColumnSelections<CharacterRecordTable> conflictColumns,
    _is.ColumnSelections<CharacterRecordTable>? updateColumns,
    _is.WhereExpressionBuilder<CharacterRecordTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<CharacterRecord>(
      row,
      conflictColumns: conflictColumns(CharacterRecord.t),
      updateColumns: updateColumns?.call(CharacterRecord.t),
      updateWhere: updateWhere?.call(CharacterRecord.t),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterRecord]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterRecord>> update(
    _is.DatabaseSession session,
    List<CharacterRecord> rows, {
    _is.ColumnSelections<CharacterRecordTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<CharacterRecord>(
      rows,
      columns: columns?.call(CharacterRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [CharacterRecord]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<CharacterRecord> updateRow(
    _is.DatabaseSession session,
    CharacterRecord row, {
    _is.ColumnSelections<CharacterRecordTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<CharacterRecord>(
      row,
      columns: columns?.call(CharacterRecord.t),
      transaction: transaction,
    );
  }

  /// Updates a single [CharacterRecord] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<CharacterRecord?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<CharacterRecordUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<CharacterRecord>(
      id,
      columnValues: columnValues(CharacterRecord.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [CharacterRecord]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterRecord>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<CharacterRecordUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<CharacterRecordTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<CharacterRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<CharacterRecord>(
      columnValues: columnValues(CharacterRecord.t.updateTable),
      where: where(CharacterRecord.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [CharacterRecord]s in the list and returns the deleted rows.
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
  Future<List<CharacterRecord>> delete(
    _is.DatabaseSession session,
    List<CharacterRecord> rows, {
    _is.OrderByBuilder<CharacterRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<CharacterRecord>(
      rows,
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [CharacterRecord].
  Future<CharacterRecord> deleteRow(
    _is.DatabaseSession session,
    CharacterRecord row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<CharacterRecord>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<CharacterRecord>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterRecordTable> where,
    _is.OrderByBuilder<CharacterRecordTable>? orderBy,
    _is.OrderByListBuilder<CharacterRecordTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<CharacterRecord>(
      where: where(CharacterRecord.t),
      orderBy: orderBy?.call(CharacterRecord.t),
      orderByList: orderByList?.call(CharacterRecord.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<CharacterRecordTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<CharacterRecord>(
      where: where?.call(CharacterRecord.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [CharacterRecord] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<CharacterRecordTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<CharacterRecord>(
      where: where(CharacterRecord.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class CharacterRecordAttachRowRepository {
  const CharacterRecordAttachRowRepository._();

  /// Creates a relation between the given [CharacterRecord] and [RaceData]
  /// by setting the [CharacterRecord]'s foreign key `raceId` to refer to the [RaceData].
  Future<void> race(
    _is.DatabaseSession session,
    CharacterRecord characterRecord,
    _ittxuxz1.RaceData race, {
    _is.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }
    if (race.id == null) {
      throw ArgumentError.notNull('race.id');
    }

    var $characterRecord = characterRecord.copyWith(raceId: race.id);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.raceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterRecord] and [SubraceData]
  /// by setting the [CharacterRecord]'s foreign key `subraceId` to refer to the [SubraceData].
  Future<void> subrace(
    _is.DatabaseSession session,
    CharacterRecord characterRecord,
    _i2k66n75.SubraceData subrace, {
    _is.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }
    if (subrace.id == null) {
      throw ArgumentError.notNull('subrace.id');
    }

    var $characterRecord = characterRecord.copyWith(subraceId: subrace.id);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.subraceId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [CharacterRecord] and [BackgroundData]
  /// by setting the [CharacterRecord]'s foreign key `backgroundId` to refer to the [BackgroundData].
  Future<void> background(
    _is.DatabaseSession session,
    CharacterRecord characterRecord,
    _i1utzyju.BackgroundData background, {
    _is.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }
    if (background.id == null) {
      throw ArgumentError.notNull('background.id');
    }

    var $characterRecord = characterRecord.copyWith(
      backgroundId: background.id,
    );
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.backgroundId],
      transaction: transaction,
    );
  }
}

class CharacterRecordDetachRowRepository {
  const CharacterRecordDetachRowRepository._();

  /// Detaches the relation between this [CharacterRecord] and the [RaceData] set in `race`
  /// by setting the [CharacterRecord]'s foreign key `raceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> race(
    _is.DatabaseSession session,
    CharacterRecord characterRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }

    var $characterRecord = characterRecord.copyWith(raceId: null);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.raceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterRecord] and the [SubraceData] set in `subrace`
  /// by setting the [CharacterRecord]'s foreign key `subraceId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> subrace(
    _is.DatabaseSession session,
    CharacterRecord characterRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }

    var $characterRecord = characterRecord.copyWith(subraceId: null);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.subraceId],
      transaction: transaction,
    );
  }

  /// Detaches the relation between this [CharacterRecord] and the [BackgroundData] set in `background`
  /// by setting the [CharacterRecord]'s foreign key `backgroundId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> background(
    _is.DatabaseSession session,
    CharacterRecord characterRecord, {
    _is.Transaction? transaction,
  }) async {
    if (characterRecord.id == null) {
      throw ArgumentError.notNull('characterRecord.id');
    }

    var $characterRecord = characterRecord.copyWith(backgroundId: null);
    await session.db.updateRow<CharacterRecord>(
      $characterRecord,
      columns: [CharacterRecord.t.backgroundId],
      transaction: transaction,
    );
  }
}
