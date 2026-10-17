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
import '../../../data/general/character/character_armor_training_overrides_data.dart'
    as _icsd58ny;
import '../../../data/general/character/character_attack_data.dart'
    as _i9jwtlvb;
import '../../../data/general/character/character_choice_data.dart'
    as _iyugnuy3;
import '../../../data/general/character/character_class_entry_data.dart'
    as _inzx0vvj;
import '../../../data/general/character/character_data.dart' as _isbrf1qr;
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
import '../../../data/general/character/character_semantic_action_data.dart'
    as _iqrvfadd;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _ipq2j7wi;
import '../../../data/general/character/character_skill_selection_data.dart'
    as _itrgrf6y;
import '../../../data/general/character/character_spell_selection_data.dart'
    as _iosl4wyz;
import '../../../data/general/character/character_starting_equipment_resolution_data.dart'
    as _iqru9q08;
import '../../../data/general/character/character_starting_equipment_selection_data.dart'
    as _iv0bao6v;
import '../../../data/general/character/character_tool_proficiency_overrides_data.dart'
    as _i6hm0w7y;
import '../../../data/general/character/character_weapon_proficiency_overrides_data.dart'
    as _i6snm8iz;
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/character_alignment.dart' as _iwwn584b;
import '../../../enums/character_speed_kind.dart' as _il8xya9v;
import '../../../enums/condition_type.dart' as _i1didlhi;
import '../../../enums/feature_tag.dart' as _ixkx8coo;

abstract class CharacterSyncValueData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CharacterSyncValueData._({
    this.stringValue,
    this.intValue,
    this.boolValue,
    this.dateTimeValue,
    this.alignmentValue,
    this.speedKindValue,
    this.conditionListValue,
    this.conditionValue,
    this.stringListValue,
    this.abilityListValue,
    this.featureTagValue,
    this.stringIntMapValue,
    this.intIntMapValue,
    this.skillProficiencyListValue,
    this.skillProficiencyValue,
    this.savingThrowProficiencyOverrideValue,
    this.languageOverridesValue,
    this.toolProficiencyOverridesValue,
    this.weaponProficiencyOverridesValue,
    this.armorTrainingOverridesValue,
    this.semanticActionValue,
    this.characterValue,
    this.noteValue,
    this.equipmentValue,
    this.equipmentSelectionValue,
    this.attackValue,
    this.featureOverrideValue,
    this.resourceStateValue,
    this.classEntryValue,
    this.choiceValue,
    this.skillSelectionValue,
    this.spellSelectionValue,
    this.startingEquipmentSelectionValue,
    this.startingEquipmentResolutionValue,
  });

  factory CharacterSyncValueData({
    String? stringValue,
    int? intValue,
    bool? boolValue,
    DateTime? dateTimeValue,
    _iwwn584b.CharacterAlignment? alignmentValue,
    _il8xya9v.CharacterSpeedKind? speedKindValue,
    List<_i1didlhi.ConditionType>? conditionListValue,
    _i1didlhi.ConditionType? conditionValue,
    List<String>? stringListValue,
    List<_iw3bk51e.Ability>? abilityListValue,
    _ixkx8coo.FeatureTag? featureTagValue,
    Map<String, int>? stringIntMapValue,
    Map<int, int>? intIntMapValue,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyListValue,
    _ipq2j7wi.CharacterSkillProficiencyState? skillProficiencyValue,
    _iax3ptkk.CharacterSavingThrowProficiencyOverrideData?
    savingThrowProficiencyOverrideValue,
    _iy48gvsl.CharacterLanguageOverridesData? languageOverridesValue,
    _i6hm0w7y.CharacterToolProficiencyOverridesData?
    toolProficiencyOverridesValue,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData?
    weaponProficiencyOverridesValue,
    _icsd58ny.CharacterArmorTrainingOverridesData? armorTrainingOverridesValue,
    _iqrvfadd.CharacterSemanticActionData? semanticActionValue,
    _isbrf1qr.CharacterData? characterValue,
    _ioruio1c.CharacterNoteData? noteValue,
    _iekoe72x.CharacterInventoryItemData? equipmentValue,
    _ihorlaio.CharacterEquipmentSelectionData? equipmentSelectionValue,
    _i9jwtlvb.CharacterAttackData? attackValue,
    _iq39grm2.CharacterFeatureOverrideData? featureOverrideValue,
    _ikl23b4y.CharacterResourceStateData? resourceStateValue,
    _inzx0vvj.CharacterClassEntryData? classEntryValue,
    _iyugnuy3.CharacterChoiceData? choiceValue,
    _itrgrf6y.CharacterSkillSelectionData? skillSelectionValue,
    _iosl4wyz.CharacterSpellSelectionData? spellSelectionValue,
    _iv0bao6v.CharacterStartingEquipmentSelectionData?
    startingEquipmentSelectionValue,
    _iqru9q08.CharacterStartingEquipmentResolutionData?
    startingEquipmentResolutionValue,
  }) = _CharacterSyncValueDataImpl;

  factory CharacterSyncValueData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSyncValueData(
      stringValue: jsonSerialization['stringValue'] as String?,
      intValue: jsonSerialization['intValue'] as int?,
      boolValue: jsonSerialization['boolValue'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['boolValue']),
      dateTimeValue: jsonSerialization['dateTimeValue'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateTimeValue'],
            ),
      alignmentValue: jsonSerialization['alignmentValue'] == null
          ? null
          : _iwwn584b.CharacterAlignment.fromJson(
              (jsonSerialization['alignmentValue'] as String),
            ),
      speedKindValue: jsonSerialization['speedKindValue'] == null
          ? null
          : _il8xya9v.CharacterSpeedKind.fromJson(
              (jsonSerialization['speedKindValue'] as int),
            ),
      conditionListValue: jsonSerialization['conditionListValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_i1didlhi.ConditionType>>(
              jsonSerialization['conditionListValue'],
            ),
      conditionValue: jsonSerialization['conditionValue'] == null
          ? null
          : _i1didlhi.ConditionType.fromJson(
              (jsonSerialization['conditionValue'] as String),
            ),
      stringListValue: jsonSerialization['stringListValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<String>>(
              jsonSerialization['stringListValue'],
            ),
      abilityListValue: jsonSerialization['abilityListValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_iw3bk51e.Ability>>(
              jsonSerialization['abilityListValue'],
            ),
      featureTagValue: jsonSerialization['featureTagValue'] == null
          ? null
          : _ixkx8coo.FeatureTag.fromJson(
              (jsonSerialization['featureTagValue'] as String),
            ),
      stringIntMapValue: jsonSerialization['stringIntMapValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<String, int>>(
              jsonSerialization['stringIntMapValue'],
            ),
      intIntMapValue: jsonSerialization['intIntMapValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['intIntMapValue'],
            ),
      skillProficiencyListValue:
          jsonSerialization['skillProficiencyListValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ipq2j7wi.CharacterSkillProficiencyState>>(
                  jsonSerialization['skillProficiencyListValue'],
                ),
      skillProficiencyValue: jsonSerialization['skillProficiencyValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_ipq2j7wi.CharacterSkillProficiencyState>(
                  jsonSerialization['skillProficiencyValue'],
                ),
      savingThrowProficiencyOverrideValue:
          jsonSerialization['savingThrowProficiencyOverrideValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              _iax3ptkk.CharacterSavingThrowProficiencyOverrideData
            >(jsonSerialization['savingThrowProficiencyOverrideValue']),
      languageOverridesValue:
          jsonSerialization['languageOverridesValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iy48gvsl.CharacterLanguageOverridesData>(
                  jsonSerialization['languageOverridesValue'],
                ),
      toolProficiencyOverridesValue:
          jsonSerialization['toolProficiencyOverridesValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i6hm0w7y.CharacterToolProficiencyOverridesData>(
                  jsonSerialization['toolProficiencyOverridesValue'],
                ),
      weaponProficiencyOverridesValue:
          jsonSerialization['weaponProficiencyOverridesValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_i6snm8iz.CharacterWeaponProficiencyOverridesData>(
                  jsonSerialization['weaponProficiencyOverridesValue'],
                ),
      armorTrainingOverridesValue:
          jsonSerialization['armorTrainingOverridesValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_icsd58ny.CharacterArmorTrainingOverridesData>(
                  jsonSerialization['armorTrainingOverridesValue'],
                ),
      semanticActionValue: jsonSerialization['semanticActionValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iqrvfadd.CharacterSemanticActionData>(
                  jsonSerialization['semanticActionValue'],
                ),
      characterValue: jsonSerialization['characterValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_isbrf1qr.CharacterData>(
              jsonSerialization['characterValue'],
            ),
      noteValue: jsonSerialization['noteValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_ioruio1c.CharacterNoteData>(
              jsonSerialization['noteValue'],
            ),
      equipmentValue: jsonSerialization['equipmentValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iekoe72x.CharacterInventoryItemData>(
                  jsonSerialization['equipmentValue'],
                ),
      equipmentSelectionValue:
          jsonSerialization['equipmentSelectionValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_ihorlaio.CharacterEquipmentSelectionData>(
                  jsonSerialization['equipmentSelectionValue'],
                ),
      attackValue: jsonSerialization['attackValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_i9jwtlvb.CharacterAttackData>(
              jsonSerialization['attackValue'],
            ),
      featureOverrideValue: jsonSerialization['featureOverrideValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iq39grm2.CharacterFeatureOverrideData>(
                  jsonSerialization['featureOverrideValue'],
                ),
      resourceStateValue: jsonSerialization['resourceStateValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_ikl23b4y.CharacterResourceStateData>(
                  jsonSerialization['resourceStateValue'],
                ),
      classEntryValue: jsonSerialization['classEntryValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_inzx0vvj.CharacterClassEntryData>(
              jsonSerialization['classEntryValue'],
            ),
      choiceValue: jsonSerialization['choiceValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_iyugnuy3.CharacterChoiceData>(
              jsonSerialization['choiceValue'],
            ),
      skillSelectionValue: jsonSerialization['skillSelectionValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_itrgrf6y.CharacterSkillSelectionData>(
                  jsonSerialization['skillSelectionValue'],
                ),
      spellSelectionValue: jsonSerialization['spellSelectionValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iosl4wyz.CharacterSpellSelectionData>(
                  jsonSerialization['spellSelectionValue'],
                ),
      startingEquipmentSelectionValue:
          jsonSerialization['startingEquipmentSelectionValue'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<_iv0bao6v.CharacterStartingEquipmentSelectionData>(
                  jsonSerialization['startingEquipmentSelectionValue'],
                ),
      startingEquipmentResolutionValue:
          jsonSerialization['startingEquipmentResolutionValue'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<
              _iqru9q08.CharacterStartingEquipmentResolutionData
            >(jsonSerialization['startingEquipmentResolutionValue']),
    );
  }

  String? stringValue;

  int? intValue;

  bool? boolValue;

  DateTime? dateTimeValue;

  _iwwn584b.CharacterAlignment? alignmentValue;

  _il8xya9v.CharacterSpeedKind? speedKindValue;

  List<_i1didlhi.ConditionType>? conditionListValue;

  _i1didlhi.ConditionType? conditionValue;

  List<String>? stringListValue;

  List<_iw3bk51e.Ability>? abilityListValue;

  _ixkx8coo.FeatureTag? featureTagValue;

  Map<String, int>? stringIntMapValue;

  Map<int, int>? intIntMapValue;

  List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyListValue;

  _ipq2j7wi.CharacterSkillProficiencyState? skillProficiencyValue;

  _iax3ptkk.CharacterSavingThrowProficiencyOverrideData?
  savingThrowProficiencyOverrideValue;

  _iy48gvsl.CharacterLanguageOverridesData? languageOverridesValue;

  _i6hm0w7y.CharacterToolProficiencyOverridesData?
  toolProficiencyOverridesValue;

  _i6snm8iz.CharacterWeaponProficiencyOverridesData?
  weaponProficiencyOverridesValue;

  _icsd58ny.CharacterArmorTrainingOverridesData? armorTrainingOverridesValue;

  _iqrvfadd.CharacterSemanticActionData? semanticActionValue;

  _isbrf1qr.CharacterData? characterValue;

  _ioruio1c.CharacterNoteData? noteValue;

  _iekoe72x.CharacterInventoryItemData? equipmentValue;

  _ihorlaio.CharacterEquipmentSelectionData? equipmentSelectionValue;

  _i9jwtlvb.CharacterAttackData? attackValue;

  _iq39grm2.CharacterFeatureOverrideData? featureOverrideValue;

  _ikl23b4y.CharacterResourceStateData? resourceStateValue;

  _inzx0vvj.CharacterClassEntryData? classEntryValue;

  _iyugnuy3.CharacterChoiceData? choiceValue;

  _itrgrf6y.CharacterSkillSelectionData? skillSelectionValue;

  _iosl4wyz.CharacterSpellSelectionData? spellSelectionValue;

  _iv0bao6v.CharacterStartingEquipmentSelectionData?
  startingEquipmentSelectionValue;

  _iqru9q08.CharacterStartingEquipmentResolutionData?
  startingEquipmentResolutionValue;

  /// Returns a shallow copy of this [CharacterSyncValueData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSyncValueData copyWith({
    String? stringValue,
    int? intValue,
    bool? boolValue,
    DateTime? dateTimeValue,
    _iwwn584b.CharacterAlignment? alignmentValue,
    _il8xya9v.CharacterSpeedKind? speedKindValue,
    List<_i1didlhi.ConditionType>? conditionListValue,
    _i1didlhi.ConditionType? conditionValue,
    List<String>? stringListValue,
    List<_iw3bk51e.Ability>? abilityListValue,
    _ixkx8coo.FeatureTag? featureTagValue,
    Map<String, int>? stringIntMapValue,
    Map<int, int>? intIntMapValue,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyListValue,
    _ipq2j7wi.CharacterSkillProficiencyState? skillProficiencyValue,
    _iax3ptkk.CharacterSavingThrowProficiencyOverrideData?
    savingThrowProficiencyOverrideValue,
    _iy48gvsl.CharacterLanguageOverridesData? languageOverridesValue,
    _i6hm0w7y.CharacterToolProficiencyOverridesData?
    toolProficiencyOverridesValue,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData?
    weaponProficiencyOverridesValue,
    _icsd58ny.CharacterArmorTrainingOverridesData? armorTrainingOverridesValue,
    _iqrvfadd.CharacterSemanticActionData? semanticActionValue,
    _isbrf1qr.CharacterData? characterValue,
    _ioruio1c.CharacterNoteData? noteValue,
    _iekoe72x.CharacterInventoryItemData? equipmentValue,
    _ihorlaio.CharacterEquipmentSelectionData? equipmentSelectionValue,
    _i9jwtlvb.CharacterAttackData? attackValue,
    _iq39grm2.CharacterFeatureOverrideData? featureOverrideValue,
    _ikl23b4y.CharacterResourceStateData? resourceStateValue,
    _inzx0vvj.CharacterClassEntryData? classEntryValue,
    _iyugnuy3.CharacterChoiceData? choiceValue,
    _itrgrf6y.CharacterSkillSelectionData? skillSelectionValue,
    _iosl4wyz.CharacterSpellSelectionData? spellSelectionValue,
    _iv0bao6v.CharacterStartingEquipmentSelectionData?
    startingEquipmentSelectionValue,
    _iqru9q08.CharacterStartingEquipmentResolutionData?
    startingEquipmentResolutionValue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSyncValueData',
      if (stringValue != null) 'stringValue': stringValue,
      if (intValue != null) 'intValue': intValue,
      if (boolValue != null) 'boolValue': boolValue,
      if (dateTimeValue != null) 'dateTimeValue': dateTimeValue?.toJson(),
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (speedKindValue != null) 'speedKindValue': speedKindValue?.toJson(),
      if (conditionListValue != null)
        'conditionListValue': conditionListValue?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (conditionValue != null) 'conditionValue': conditionValue?.toJson(),
      if (stringListValue != null) 'stringListValue': stringListValue?.toJson(),
      if (abilityListValue != null)
        'abilityListValue': abilityListValue?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (featureTagValue != null) 'featureTagValue': featureTagValue?.toJson(),
      if (stringIntMapValue != null)
        'stringIntMapValue': stringIntMapValue?.toJson(),
      if (intIntMapValue != null) 'intIntMapValue': intIntMapValue?.toJson(),
      if (skillProficiencyListValue != null)
        'skillProficiencyListValue': skillProficiencyListValue?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (skillProficiencyValue != null)
        'skillProficiencyValue': skillProficiencyValue?.toJson(),
      if (savingThrowProficiencyOverrideValue != null)
        'savingThrowProficiencyOverrideValue':
            savingThrowProficiencyOverrideValue?.toJson(),
      if (languageOverridesValue != null)
        'languageOverridesValue': languageOverridesValue?.toJson(),
      if (toolProficiencyOverridesValue != null)
        'toolProficiencyOverridesValue': toolProficiencyOverridesValue
            ?.toJson(),
      if (weaponProficiencyOverridesValue != null)
        'weaponProficiencyOverridesValue': weaponProficiencyOverridesValue
            ?.toJson(),
      if (armorTrainingOverridesValue != null)
        'armorTrainingOverridesValue': armorTrainingOverridesValue?.toJson(),
      if (semanticActionValue != null)
        'semanticActionValue': semanticActionValue?.toJson(),
      if (characterValue != null) 'characterValue': characterValue?.toJson(),
      if (noteValue != null) 'noteValue': noteValue?.toJson(),
      if (equipmentValue != null) 'equipmentValue': equipmentValue?.toJson(),
      if (equipmentSelectionValue != null)
        'equipmentSelectionValue': equipmentSelectionValue?.toJson(),
      if (attackValue != null) 'attackValue': attackValue?.toJson(),
      if (featureOverrideValue != null)
        'featureOverrideValue': featureOverrideValue?.toJson(),
      if (resourceStateValue != null)
        'resourceStateValue': resourceStateValue?.toJson(),
      if (classEntryValue != null) 'classEntryValue': classEntryValue?.toJson(),
      if (choiceValue != null) 'choiceValue': choiceValue?.toJson(),
      if (skillSelectionValue != null)
        'skillSelectionValue': skillSelectionValue?.toJson(),
      if (spellSelectionValue != null)
        'spellSelectionValue': spellSelectionValue?.toJson(),
      if (startingEquipmentSelectionValue != null)
        'startingEquipmentSelectionValue': startingEquipmentSelectionValue
            ?.toJson(),
      if (startingEquipmentResolutionValue != null)
        'startingEquipmentResolutionValue': startingEquipmentResolutionValue
            ?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSyncValueData',
      if (stringValue != null) 'stringValue': stringValue,
      if (intValue != null) 'intValue': intValue,
      if (boolValue != null) 'boolValue': boolValue,
      if (dateTimeValue != null) 'dateTimeValue': dateTimeValue?.toJson(),
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (speedKindValue != null) 'speedKindValue': speedKindValue?.toJson(),
      if (conditionListValue != null)
        'conditionListValue': conditionListValue?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (conditionValue != null) 'conditionValue': conditionValue?.toJson(),
      if (stringListValue != null) 'stringListValue': stringListValue?.toJson(),
      if (abilityListValue != null)
        'abilityListValue': abilityListValue?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (featureTagValue != null) 'featureTagValue': featureTagValue?.toJson(),
      if (stringIntMapValue != null)
        'stringIntMapValue': stringIntMapValue?.toJson(),
      if (intIntMapValue != null) 'intIntMapValue': intIntMapValue?.toJson(),
      if (skillProficiencyListValue != null)
        'skillProficiencyListValue': skillProficiencyListValue?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (skillProficiencyValue != null)
        'skillProficiencyValue': skillProficiencyValue?.toJsonForProtocol(),
      if (savingThrowProficiencyOverrideValue != null)
        'savingThrowProficiencyOverrideValue':
            savingThrowProficiencyOverrideValue?.toJsonForProtocol(),
      if (languageOverridesValue != null)
        'languageOverridesValue': languageOverridesValue?.toJsonForProtocol(),
      if (toolProficiencyOverridesValue != null)
        'toolProficiencyOverridesValue': toolProficiencyOverridesValue
            ?.toJsonForProtocol(),
      if (weaponProficiencyOverridesValue != null)
        'weaponProficiencyOverridesValue': weaponProficiencyOverridesValue
            ?.toJsonForProtocol(),
      if (armorTrainingOverridesValue != null)
        'armorTrainingOverridesValue': armorTrainingOverridesValue
            ?.toJsonForProtocol(),
      if (semanticActionValue != null)
        'semanticActionValue': semanticActionValue?.toJsonForProtocol(),
      if (characterValue != null)
        'characterValue': characterValue?.toJsonForProtocol(),
      if (noteValue != null) 'noteValue': noteValue?.toJsonForProtocol(),
      if (equipmentValue != null)
        'equipmentValue': equipmentValue?.toJsonForProtocol(),
      if (equipmentSelectionValue != null)
        'equipmentSelectionValue': equipmentSelectionValue?.toJsonForProtocol(),
      if (attackValue != null) 'attackValue': attackValue?.toJsonForProtocol(),
      if (featureOverrideValue != null)
        'featureOverrideValue': featureOverrideValue?.toJsonForProtocol(),
      if (resourceStateValue != null)
        'resourceStateValue': resourceStateValue?.toJsonForProtocol(),
      if (classEntryValue != null)
        'classEntryValue': classEntryValue?.toJsonForProtocol(),
      if (choiceValue != null) 'choiceValue': choiceValue?.toJsonForProtocol(),
      if (skillSelectionValue != null)
        'skillSelectionValue': skillSelectionValue?.toJsonForProtocol(),
      if (spellSelectionValue != null)
        'spellSelectionValue': spellSelectionValue?.toJsonForProtocol(),
      if (startingEquipmentSelectionValue != null)
        'startingEquipmentSelectionValue': startingEquipmentSelectionValue
            ?.toJsonForProtocol(),
      if (startingEquipmentResolutionValue != null)
        'startingEquipmentResolutionValue': startingEquipmentResolutionValue
            ?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncValueDataImpl extends CharacterSyncValueData {
  _CharacterSyncValueDataImpl({
    String? stringValue,
    int? intValue,
    bool? boolValue,
    DateTime? dateTimeValue,
    _iwwn584b.CharacterAlignment? alignmentValue,
    _il8xya9v.CharacterSpeedKind? speedKindValue,
    List<_i1didlhi.ConditionType>? conditionListValue,
    _i1didlhi.ConditionType? conditionValue,
    List<String>? stringListValue,
    List<_iw3bk51e.Ability>? abilityListValue,
    _ixkx8coo.FeatureTag? featureTagValue,
    Map<String, int>? stringIntMapValue,
    Map<int, int>? intIntMapValue,
    List<_ipq2j7wi.CharacterSkillProficiencyState>? skillProficiencyListValue,
    _ipq2j7wi.CharacterSkillProficiencyState? skillProficiencyValue,
    _iax3ptkk.CharacterSavingThrowProficiencyOverrideData?
    savingThrowProficiencyOverrideValue,
    _iy48gvsl.CharacterLanguageOverridesData? languageOverridesValue,
    _i6hm0w7y.CharacterToolProficiencyOverridesData?
    toolProficiencyOverridesValue,
    _i6snm8iz.CharacterWeaponProficiencyOverridesData?
    weaponProficiencyOverridesValue,
    _icsd58ny.CharacterArmorTrainingOverridesData? armorTrainingOverridesValue,
    _iqrvfadd.CharacterSemanticActionData? semanticActionValue,
    _isbrf1qr.CharacterData? characterValue,
    _ioruio1c.CharacterNoteData? noteValue,
    _iekoe72x.CharacterInventoryItemData? equipmentValue,
    _ihorlaio.CharacterEquipmentSelectionData? equipmentSelectionValue,
    _i9jwtlvb.CharacterAttackData? attackValue,
    _iq39grm2.CharacterFeatureOverrideData? featureOverrideValue,
    _ikl23b4y.CharacterResourceStateData? resourceStateValue,
    _inzx0vvj.CharacterClassEntryData? classEntryValue,
    _iyugnuy3.CharacterChoiceData? choiceValue,
    _itrgrf6y.CharacterSkillSelectionData? skillSelectionValue,
    _iosl4wyz.CharacterSpellSelectionData? spellSelectionValue,
    _iv0bao6v.CharacterStartingEquipmentSelectionData?
    startingEquipmentSelectionValue,
    _iqru9q08.CharacterStartingEquipmentResolutionData?
    startingEquipmentResolutionValue,
  }) : super._(
         stringValue: stringValue,
         intValue: intValue,
         boolValue: boolValue,
         dateTimeValue: dateTimeValue,
         alignmentValue: alignmentValue,
         speedKindValue: speedKindValue,
         conditionListValue: conditionListValue,
         conditionValue: conditionValue,
         stringListValue: stringListValue,
         abilityListValue: abilityListValue,
         featureTagValue: featureTagValue,
         stringIntMapValue: stringIntMapValue,
         intIntMapValue: intIntMapValue,
         skillProficiencyListValue: skillProficiencyListValue,
         skillProficiencyValue: skillProficiencyValue,
         savingThrowProficiencyOverrideValue:
             savingThrowProficiencyOverrideValue,
         languageOverridesValue: languageOverridesValue,
         toolProficiencyOverridesValue: toolProficiencyOverridesValue,
         weaponProficiencyOverridesValue: weaponProficiencyOverridesValue,
         armorTrainingOverridesValue: armorTrainingOverridesValue,
         semanticActionValue: semanticActionValue,
         characterValue: characterValue,
         noteValue: noteValue,
         equipmentValue: equipmentValue,
         equipmentSelectionValue: equipmentSelectionValue,
         attackValue: attackValue,
         featureOverrideValue: featureOverrideValue,
         resourceStateValue: resourceStateValue,
         classEntryValue: classEntryValue,
         choiceValue: choiceValue,
         skillSelectionValue: skillSelectionValue,
         spellSelectionValue: spellSelectionValue,
         startingEquipmentSelectionValue: startingEquipmentSelectionValue,
         startingEquipmentResolutionValue: startingEquipmentResolutionValue,
       );

  /// Returns a shallow copy of this [CharacterSyncValueData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterSyncValueData copyWith({
    Object? stringValue = _Undefined,
    Object? intValue = _Undefined,
    Object? boolValue = _Undefined,
    Object? dateTimeValue = _Undefined,
    Object? alignmentValue = _Undefined,
    Object? speedKindValue = _Undefined,
    Object? conditionListValue = _Undefined,
    Object? conditionValue = _Undefined,
    Object? stringListValue = _Undefined,
    Object? abilityListValue = _Undefined,
    Object? featureTagValue = _Undefined,
    Object? stringIntMapValue = _Undefined,
    Object? intIntMapValue = _Undefined,
    Object? skillProficiencyListValue = _Undefined,
    Object? skillProficiencyValue = _Undefined,
    Object? savingThrowProficiencyOverrideValue = _Undefined,
    Object? languageOverridesValue = _Undefined,
    Object? toolProficiencyOverridesValue = _Undefined,
    Object? weaponProficiencyOverridesValue = _Undefined,
    Object? armorTrainingOverridesValue = _Undefined,
    Object? semanticActionValue = _Undefined,
    Object? characterValue = _Undefined,
    Object? noteValue = _Undefined,
    Object? equipmentValue = _Undefined,
    Object? equipmentSelectionValue = _Undefined,
    Object? attackValue = _Undefined,
    Object? featureOverrideValue = _Undefined,
    Object? resourceStateValue = _Undefined,
    Object? classEntryValue = _Undefined,
    Object? choiceValue = _Undefined,
    Object? skillSelectionValue = _Undefined,
    Object? spellSelectionValue = _Undefined,
    Object? startingEquipmentSelectionValue = _Undefined,
    Object? startingEquipmentResolutionValue = _Undefined,
  }) {
    return CharacterSyncValueData(
      stringValue: stringValue is String? ? stringValue : this.stringValue,
      intValue: intValue is int? ? intValue : this.intValue,
      boolValue: boolValue is bool? ? boolValue : this.boolValue,
      dateTimeValue: dateTimeValue is DateTime?
          ? dateTimeValue
          : this.dateTimeValue,
      alignmentValue: alignmentValue is _iwwn584b.CharacterAlignment?
          ? alignmentValue
          : this.alignmentValue,
      speedKindValue: speedKindValue is _il8xya9v.CharacterSpeedKind?
          ? speedKindValue
          : this.speedKindValue,
      conditionListValue: conditionListValue is List<_i1didlhi.ConditionType>?
          ? conditionListValue
          : this.conditionListValue?.map((e0) => e0).toList(),
      conditionValue: conditionValue is _i1didlhi.ConditionType?
          ? conditionValue
          : this.conditionValue,
      stringListValue: stringListValue is List<String>?
          ? stringListValue
          : this.stringListValue?.map((e0) => e0).toList(),
      abilityListValue: abilityListValue is List<_iw3bk51e.Ability>?
          ? abilityListValue
          : this.abilityListValue?.map((e0) => e0).toList(),
      featureTagValue: featureTagValue is _ixkx8coo.FeatureTag?
          ? featureTagValue
          : this.featureTagValue,
      stringIntMapValue: stringIntMapValue is Map<String, int>?
          ? stringIntMapValue
          : this.stringIntMapValue?.map(
              (key0, value0) => MapEntry(key0, value0),
            ),
      intIntMapValue: intIntMapValue is Map<int, int>?
          ? intIntMapValue
          : this.intIntMapValue?.map((key0, value0) => MapEntry(key0, value0)),
      skillProficiencyListValue:
          skillProficiencyListValue
              is List<_ipq2j7wi.CharacterSkillProficiencyState>?
          ? skillProficiencyListValue
          : this.skillProficiencyListValue?.map((e0) => e0.copyWith()).toList(),
      skillProficiencyValue:
          skillProficiencyValue is _ipq2j7wi.CharacterSkillProficiencyState?
          ? skillProficiencyValue
          : this.skillProficiencyValue?.copyWith(),
      savingThrowProficiencyOverrideValue:
          savingThrowProficiencyOverrideValue
              is _iax3ptkk.CharacterSavingThrowProficiencyOverrideData?
          ? savingThrowProficiencyOverrideValue
          : this.savingThrowProficiencyOverrideValue?.copyWith(),
      languageOverridesValue:
          languageOverridesValue is _iy48gvsl.CharacterLanguageOverridesData?
          ? languageOverridesValue
          : this.languageOverridesValue?.copyWith(),
      toolProficiencyOverridesValue:
          toolProficiencyOverridesValue
              is _i6hm0w7y.CharacterToolProficiencyOverridesData?
          ? toolProficiencyOverridesValue
          : this.toolProficiencyOverridesValue?.copyWith(),
      weaponProficiencyOverridesValue:
          weaponProficiencyOverridesValue
              is _i6snm8iz.CharacterWeaponProficiencyOverridesData?
          ? weaponProficiencyOverridesValue
          : this.weaponProficiencyOverridesValue?.copyWith(),
      armorTrainingOverridesValue:
          armorTrainingOverridesValue
              is _icsd58ny.CharacterArmorTrainingOverridesData?
          ? armorTrainingOverridesValue
          : this.armorTrainingOverridesValue?.copyWith(),
      semanticActionValue:
          semanticActionValue is _iqrvfadd.CharacterSemanticActionData?
          ? semanticActionValue
          : this.semanticActionValue?.copyWith(),
      characterValue: characterValue is _isbrf1qr.CharacterData?
          ? characterValue
          : this.characterValue?.copyWith(),
      noteValue: noteValue is _ioruio1c.CharacterNoteData?
          ? noteValue
          : this.noteValue?.copyWith(),
      equipmentValue: equipmentValue is _iekoe72x.CharacterInventoryItemData?
          ? equipmentValue
          : this.equipmentValue?.copyWith(),
      equipmentSelectionValue:
          equipmentSelectionValue is _ihorlaio.CharacterEquipmentSelectionData?
          ? equipmentSelectionValue
          : this.equipmentSelectionValue?.copyWith(),
      attackValue: attackValue is _i9jwtlvb.CharacterAttackData?
          ? attackValue
          : this.attackValue?.copyWith(),
      featureOverrideValue:
          featureOverrideValue is _iq39grm2.CharacterFeatureOverrideData?
          ? featureOverrideValue
          : this.featureOverrideValue?.copyWith(),
      resourceStateValue:
          resourceStateValue is _ikl23b4y.CharacterResourceStateData?
          ? resourceStateValue
          : this.resourceStateValue?.copyWith(),
      classEntryValue: classEntryValue is _inzx0vvj.CharacterClassEntryData?
          ? classEntryValue
          : this.classEntryValue?.copyWith(),
      choiceValue: choiceValue is _iyugnuy3.CharacterChoiceData?
          ? choiceValue
          : this.choiceValue?.copyWith(),
      skillSelectionValue:
          skillSelectionValue is _itrgrf6y.CharacterSkillSelectionData?
          ? skillSelectionValue
          : this.skillSelectionValue?.copyWith(),
      spellSelectionValue:
          spellSelectionValue is _iosl4wyz.CharacterSpellSelectionData?
          ? spellSelectionValue
          : this.spellSelectionValue?.copyWith(),
      startingEquipmentSelectionValue:
          startingEquipmentSelectionValue
              is _iv0bao6v.CharacterStartingEquipmentSelectionData?
          ? startingEquipmentSelectionValue
          : this.startingEquipmentSelectionValue?.copyWith(),
      startingEquipmentResolutionValue:
          startingEquipmentResolutionValue
              is _iqru9q08.CharacterStartingEquipmentResolutionData?
          ? startingEquipmentResolutionValue
          : this.startingEquipmentResolutionValue?.copyWith(),
    );
  }
}
