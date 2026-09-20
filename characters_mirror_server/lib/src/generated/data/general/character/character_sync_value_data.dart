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
import '../../../enums/character_speed_kind.dart' as _i3;
import '../../../enums/condition_type.dart' as _i4;
import '../../../enums/ability.dart' as _i5;
import '../../../enums/feature_tag.dart' as _i6;
import '../../../data/general/character/character_skill_proficiency_state.dart'
    as _i7;
import '../../../data/general/character/character_saving_throw_proficiency_override_data.dart'
    as _i8;
import '../../../data/general/character/character_semantic_action_data.dart'
    as _i9;
import '../../../data/general/character/character_data.dart' as _i10;
import '../../../data/general/character/character_note_data.dart' as _i11;
import '../../../data/general/character/character_inventory_item_data.dart'
    as _i12;
import '../../../data/general/character/character_attack_data.dart' as _i13;
import '../../../data/general/character/character_feature_override_data.dart'
    as _i14;
import '../../../data/general/character/character_resource_state_data.dart'
    as _i15;
import '../../../data/general/character/character_class_entry_data.dart'
    as _i16;
import '../../../data/general/character/character_choice_data.dart' as _i17;
import '../../../data/general/character/character_skill_selection_data.dart'
    as _i18;
import '../../../data/general/character/character_spell_selection_data.dart'
    as _i19;
import '../../../data/general/character/character_starting_equipment_selection_data.dart'
    as _i20;
import '../../../data/general/character/character_starting_equipment_resolution_data.dart'
    as _i21;

abstract class CharacterSyncValueData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    this.semanticActionValue,
    this.characterValue,
    this.noteValue,
    this.equipmentValue,
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
    _i2.CharacterAlignment? alignmentValue,
    _i3.CharacterSpeedKind? speedKindValue,
    List<_i4.ConditionType>? conditionListValue,
    _i4.ConditionType? conditionValue,
    List<String>? stringListValue,
    List<_i5.Ability>? abilityListValue,
    _i6.FeatureTag? featureTagValue,
    Map<String, int>? stringIntMapValue,
    Map<int, int>? intIntMapValue,
    List<_i7.CharacterSkillProficiencyState>? skillProficiencyListValue,
    _i7.CharacterSkillProficiencyState? skillProficiencyValue,
    _i8.CharacterSavingThrowProficiencyOverrideData?
        savingThrowProficiencyOverrideValue,
    _i9.CharacterSemanticActionData? semanticActionValue,
    _i10.CharacterData? characterValue,
    _i11.CharacterNoteData? noteValue,
    _i12.CharacterInventoryItemData? equipmentValue,
    _i13.CharacterAttackData? attackValue,
    _i14.CharacterFeatureOverrideData? featureOverrideValue,
    _i15.CharacterResourceStateData? resourceStateValue,
    _i16.CharacterClassEntryData? classEntryValue,
    _i17.CharacterChoiceData? choiceValue,
    _i18.CharacterSkillSelectionData? skillSelectionValue,
    _i19.CharacterSpellSelectionData? spellSelectionValue,
    _i20.CharacterStartingEquipmentSelectionData?
        startingEquipmentSelectionValue,
    _i21.CharacterStartingEquipmentResolutionData?
        startingEquipmentResolutionValue,
  }) = _CharacterSyncValueDataImpl;

  factory CharacterSyncValueData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSyncValueData(
      stringValue: jsonSerialization['stringValue'] as String?,
      intValue: jsonSerialization['intValue'] as int?,
      boolValue: jsonSerialization['boolValue'] as bool?,
      dateTimeValue: jsonSerialization['dateTimeValue'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateTimeValue']),
      alignmentValue: jsonSerialization['alignmentValue'] == null
          ? null
          : _i2.CharacterAlignment.fromJson(
              (jsonSerialization['alignmentValue'] as String)),
      speedKindValue: jsonSerialization['speedKindValue'] == null
          ? null
          : _i3.CharacterSpeedKind.fromJson(
              (jsonSerialization['speedKindValue'] as int)),
      conditionListValue: (jsonSerialization['conditionListValue'] as List?)
          ?.map((e) => _i4.ConditionType.fromJson((e as String)))
          .toList(),
      conditionValue: jsonSerialization['conditionValue'] == null
          ? null
          : _i4.ConditionType.fromJson(
              (jsonSerialization['conditionValue'] as String)),
      stringListValue: (jsonSerialization['stringListValue'] as List?)
          ?.map((e) => e as String)
          .toList(),
      abilityListValue: (jsonSerialization['abilityListValue'] as List?)
          ?.map((e) => _i5.Ability.fromJson((e as String)))
          .toList(),
      featureTagValue: jsonSerialization['featureTagValue'] == null
          ? null
          : _i6.FeatureTag.fromJson(
              (jsonSerialization['featureTagValue'] as String)),
      stringIntMapValue: (jsonSerialization['stringIntMapValue'] as Map?)
          ?.map((k, v) => MapEntry(
                k as String,
                v as int,
              )),
      intIntMapValue: (jsonSerialization['intIntMapValue'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      skillProficiencyListValue:
          (jsonSerialization['skillProficiencyListValue'] as List?)
              ?.map((e) => _i7.CharacterSkillProficiencyState.fromJson(
                  (e as Map<String, dynamic>)))
              .toList(),
      skillProficiencyValue: jsonSerialization['skillProficiencyValue'] == null
          ? null
          : _i7.CharacterSkillProficiencyState.fromJson(
              (jsonSerialization['skillProficiencyValue']
                  as Map<String, dynamic>)),
      savingThrowProficiencyOverrideValue:
          jsonSerialization['savingThrowProficiencyOverrideValue'] == null
              ? null
              : _i8.CharacterSavingThrowProficiencyOverrideData.fromJson(
                  (jsonSerialization['savingThrowProficiencyOverrideValue']
                      as Map<String, dynamic>)),
      semanticActionValue: jsonSerialization['semanticActionValue'] == null
          ? null
          : _i9.CharacterSemanticActionData.fromJson(
              (jsonSerialization['semanticActionValue']
                  as Map<String, dynamic>)),
      characterValue: jsonSerialization['characterValue'] == null
          ? null
          : _i10.CharacterData.fromJson(
              (jsonSerialization['characterValue'] as Map<String, dynamic>)),
      noteValue: jsonSerialization['noteValue'] == null
          ? null
          : _i11.CharacterNoteData.fromJson(
              (jsonSerialization['noteValue'] as Map<String, dynamic>)),
      equipmentValue: jsonSerialization['equipmentValue'] == null
          ? null
          : _i12.CharacterInventoryItemData.fromJson(
              (jsonSerialization['equipmentValue'] as Map<String, dynamic>)),
      attackValue: jsonSerialization['attackValue'] == null
          ? null
          : _i13.CharacterAttackData.fromJson(
              (jsonSerialization['attackValue'] as Map<String, dynamic>)),
      featureOverrideValue: jsonSerialization['featureOverrideValue'] == null
          ? null
          : _i14.CharacterFeatureOverrideData.fromJson(
              (jsonSerialization['featureOverrideValue']
                  as Map<String, dynamic>)),
      resourceStateValue: jsonSerialization['resourceStateValue'] == null
          ? null
          : _i15.CharacterResourceStateData.fromJson(
              (jsonSerialization['resourceStateValue']
                  as Map<String, dynamic>)),
      classEntryValue: jsonSerialization['classEntryValue'] == null
          ? null
          : _i16.CharacterClassEntryData.fromJson(
              (jsonSerialization['classEntryValue'] as Map<String, dynamic>)),
      choiceValue: jsonSerialization['choiceValue'] == null
          ? null
          : _i17.CharacterChoiceData.fromJson(
              (jsonSerialization['choiceValue'] as Map<String, dynamic>)),
      skillSelectionValue: jsonSerialization['skillSelectionValue'] == null
          ? null
          : _i18.CharacterSkillSelectionData.fromJson(
              (jsonSerialization['skillSelectionValue']
                  as Map<String, dynamic>)),
      spellSelectionValue: jsonSerialization['spellSelectionValue'] == null
          ? null
          : _i19.CharacterSpellSelectionData.fromJson(
              (jsonSerialization['spellSelectionValue']
                  as Map<String, dynamic>)),
      startingEquipmentSelectionValue:
          jsonSerialization['startingEquipmentSelectionValue'] == null
              ? null
              : _i20.CharacterStartingEquipmentSelectionData.fromJson(
                  (jsonSerialization['startingEquipmentSelectionValue']
                      as Map<String, dynamic>)),
      startingEquipmentResolutionValue:
          jsonSerialization['startingEquipmentResolutionValue'] == null
              ? null
              : _i21.CharacterStartingEquipmentResolutionData.fromJson(
                  (jsonSerialization['startingEquipmentResolutionValue']
                      as Map<String, dynamic>)),
    );
  }

  String? stringValue;

  int? intValue;

  bool? boolValue;

  DateTime? dateTimeValue;

  _i2.CharacterAlignment? alignmentValue;

  _i3.CharacterSpeedKind? speedKindValue;

  List<_i4.ConditionType>? conditionListValue;

  _i4.ConditionType? conditionValue;

  List<String>? stringListValue;

  List<_i5.Ability>? abilityListValue;

  _i6.FeatureTag? featureTagValue;

  Map<String, int>? stringIntMapValue;

  Map<int, int>? intIntMapValue;

  List<_i7.CharacterSkillProficiencyState>? skillProficiencyListValue;

  _i7.CharacterSkillProficiencyState? skillProficiencyValue;

  _i8.CharacterSavingThrowProficiencyOverrideData?
      savingThrowProficiencyOverrideValue;

  _i9.CharacterSemanticActionData? semanticActionValue;

  _i10.CharacterData? characterValue;

  _i11.CharacterNoteData? noteValue;

  _i12.CharacterInventoryItemData? equipmentValue;

  _i13.CharacterAttackData? attackValue;

  _i14.CharacterFeatureOverrideData? featureOverrideValue;

  _i15.CharacterResourceStateData? resourceStateValue;

  _i16.CharacterClassEntryData? classEntryValue;

  _i17.CharacterChoiceData? choiceValue;

  _i18.CharacterSkillSelectionData? skillSelectionValue;

  _i19.CharacterSpellSelectionData? spellSelectionValue;

  _i20.CharacterStartingEquipmentSelectionData? startingEquipmentSelectionValue;

  _i21.CharacterStartingEquipmentResolutionData?
      startingEquipmentResolutionValue;

  /// Returns a shallow copy of this [CharacterSyncValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSyncValueData copyWith({
    String? stringValue,
    int? intValue,
    bool? boolValue,
    DateTime? dateTimeValue,
    _i2.CharacterAlignment? alignmentValue,
    _i3.CharacterSpeedKind? speedKindValue,
    List<_i4.ConditionType>? conditionListValue,
    _i4.ConditionType? conditionValue,
    List<String>? stringListValue,
    List<_i5.Ability>? abilityListValue,
    _i6.FeatureTag? featureTagValue,
    Map<String, int>? stringIntMapValue,
    Map<int, int>? intIntMapValue,
    List<_i7.CharacterSkillProficiencyState>? skillProficiencyListValue,
    _i7.CharacterSkillProficiencyState? skillProficiencyValue,
    _i8.CharacterSavingThrowProficiencyOverrideData?
        savingThrowProficiencyOverrideValue,
    _i9.CharacterSemanticActionData? semanticActionValue,
    _i10.CharacterData? characterValue,
    _i11.CharacterNoteData? noteValue,
    _i12.CharacterInventoryItemData? equipmentValue,
    _i13.CharacterAttackData? attackValue,
    _i14.CharacterFeatureOverrideData? featureOverrideValue,
    _i15.CharacterResourceStateData? resourceStateValue,
    _i16.CharacterClassEntryData? classEntryValue,
    _i17.CharacterChoiceData? choiceValue,
    _i18.CharacterSkillSelectionData? skillSelectionValue,
    _i19.CharacterSpellSelectionData? spellSelectionValue,
    _i20.CharacterStartingEquipmentSelectionData?
        startingEquipmentSelectionValue,
    _i21.CharacterStartingEquipmentResolutionData?
        startingEquipmentResolutionValue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (stringValue != null) 'stringValue': stringValue,
      if (intValue != null) 'intValue': intValue,
      if (boolValue != null) 'boolValue': boolValue,
      if (dateTimeValue != null) 'dateTimeValue': dateTimeValue?.toJson(),
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (speedKindValue != null) 'speedKindValue': speedKindValue?.toJson(),
      if (conditionListValue != null)
        'conditionListValue':
            conditionListValue?.toJson(valueToJson: (v) => v.toJson()),
      if (conditionValue != null) 'conditionValue': conditionValue?.toJson(),
      if (stringListValue != null) 'stringListValue': stringListValue?.toJson(),
      if (abilityListValue != null)
        'abilityListValue':
            abilityListValue?.toJson(valueToJson: (v) => v.toJson()),
      if (featureTagValue != null) 'featureTagValue': featureTagValue?.toJson(),
      if (stringIntMapValue != null)
        'stringIntMapValue': stringIntMapValue?.toJson(),
      if (intIntMapValue != null) 'intIntMapValue': intIntMapValue?.toJson(),
      if (skillProficiencyListValue != null)
        'skillProficiencyListValue':
            skillProficiencyListValue?.toJson(valueToJson: (v) => v.toJson()),
      if (skillProficiencyValue != null)
        'skillProficiencyValue': skillProficiencyValue?.toJson(),
      if (savingThrowProficiencyOverrideValue != null)
        'savingThrowProficiencyOverrideValue':
            savingThrowProficiencyOverrideValue?.toJson(),
      if (semanticActionValue != null)
        'semanticActionValue': semanticActionValue?.toJson(),
      if (characterValue != null) 'characterValue': characterValue?.toJson(),
      if (noteValue != null) 'noteValue': noteValue?.toJson(),
      if (equipmentValue != null) 'equipmentValue': equipmentValue?.toJson(),
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
        'startingEquipmentSelectionValue':
            startingEquipmentSelectionValue?.toJson(),
      if (startingEquipmentResolutionValue != null)
        'startingEquipmentResolutionValue':
            startingEquipmentResolutionValue?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (stringValue != null) 'stringValue': stringValue,
      if (intValue != null) 'intValue': intValue,
      if (boolValue != null) 'boolValue': boolValue,
      if (dateTimeValue != null) 'dateTimeValue': dateTimeValue?.toJson(),
      if (alignmentValue != null) 'alignmentValue': alignmentValue?.toJson(),
      if (speedKindValue != null) 'speedKindValue': speedKindValue?.toJson(),
      if (conditionListValue != null)
        'conditionListValue':
            conditionListValue?.toJson(valueToJson: (v) => v.toJson()),
      if (conditionValue != null) 'conditionValue': conditionValue?.toJson(),
      if (stringListValue != null) 'stringListValue': stringListValue?.toJson(),
      if (abilityListValue != null)
        'abilityListValue':
            abilityListValue?.toJson(valueToJson: (v) => v.toJson()),
      if (featureTagValue != null) 'featureTagValue': featureTagValue?.toJson(),
      if (stringIntMapValue != null)
        'stringIntMapValue': stringIntMapValue?.toJson(),
      if (intIntMapValue != null) 'intIntMapValue': intIntMapValue?.toJson(),
      if (skillProficiencyListValue != null)
        'skillProficiencyListValue': skillProficiencyListValue?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
      if (skillProficiencyValue != null)
        'skillProficiencyValue': skillProficiencyValue?.toJsonForProtocol(),
      if (savingThrowProficiencyOverrideValue != null)
        'savingThrowProficiencyOverrideValue':
            savingThrowProficiencyOverrideValue?.toJsonForProtocol(),
      if (semanticActionValue != null)
        'semanticActionValue': semanticActionValue?.toJsonForProtocol(),
      if (characterValue != null)
        'characterValue': characterValue?.toJsonForProtocol(),
      if (noteValue != null) 'noteValue': noteValue?.toJsonForProtocol(),
      if (equipmentValue != null)
        'equipmentValue': equipmentValue?.toJsonForProtocol(),
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
        'startingEquipmentSelectionValue':
            startingEquipmentSelectionValue?.toJsonForProtocol(),
      if (startingEquipmentResolutionValue != null)
        'startingEquipmentResolutionValue':
            startingEquipmentResolutionValue?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncValueDataImpl extends CharacterSyncValueData {
  _CharacterSyncValueDataImpl({
    String? stringValue,
    int? intValue,
    bool? boolValue,
    DateTime? dateTimeValue,
    _i2.CharacterAlignment? alignmentValue,
    _i3.CharacterSpeedKind? speedKindValue,
    List<_i4.ConditionType>? conditionListValue,
    _i4.ConditionType? conditionValue,
    List<String>? stringListValue,
    List<_i5.Ability>? abilityListValue,
    _i6.FeatureTag? featureTagValue,
    Map<String, int>? stringIntMapValue,
    Map<int, int>? intIntMapValue,
    List<_i7.CharacterSkillProficiencyState>? skillProficiencyListValue,
    _i7.CharacterSkillProficiencyState? skillProficiencyValue,
    _i8.CharacterSavingThrowProficiencyOverrideData?
        savingThrowProficiencyOverrideValue,
    _i9.CharacterSemanticActionData? semanticActionValue,
    _i10.CharacterData? characterValue,
    _i11.CharacterNoteData? noteValue,
    _i12.CharacterInventoryItemData? equipmentValue,
    _i13.CharacterAttackData? attackValue,
    _i14.CharacterFeatureOverrideData? featureOverrideValue,
    _i15.CharacterResourceStateData? resourceStateValue,
    _i16.CharacterClassEntryData? classEntryValue,
    _i17.CharacterChoiceData? choiceValue,
    _i18.CharacterSkillSelectionData? skillSelectionValue,
    _i19.CharacterSpellSelectionData? spellSelectionValue,
    _i20.CharacterStartingEquipmentSelectionData?
        startingEquipmentSelectionValue,
    _i21.CharacterStartingEquipmentResolutionData?
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
          semanticActionValue: semanticActionValue,
          characterValue: characterValue,
          noteValue: noteValue,
          equipmentValue: equipmentValue,
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
  @_i1.useResult
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
    Object? semanticActionValue = _Undefined,
    Object? characterValue = _Undefined,
    Object? noteValue = _Undefined,
    Object? equipmentValue = _Undefined,
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
      dateTimeValue:
          dateTimeValue is DateTime? ? dateTimeValue : this.dateTimeValue,
      alignmentValue: alignmentValue is _i2.CharacterAlignment?
          ? alignmentValue
          : this.alignmentValue,
      speedKindValue: speedKindValue is _i3.CharacterSpeedKind?
          ? speedKindValue
          : this.speedKindValue,
      conditionListValue: conditionListValue is List<_i4.ConditionType>?
          ? conditionListValue
          : this.conditionListValue?.map((e0) => e0).toList(),
      conditionValue: conditionValue is _i4.ConditionType?
          ? conditionValue
          : this.conditionValue,
      stringListValue: stringListValue is List<String>?
          ? stringListValue
          : this.stringListValue?.map((e0) => e0).toList(),
      abilityListValue: abilityListValue is List<_i5.Ability>?
          ? abilityListValue
          : this.abilityListValue?.map((e0) => e0).toList(),
      featureTagValue: featureTagValue is _i6.FeatureTag?
          ? featureTagValue
          : this.featureTagValue,
      stringIntMapValue: stringIntMapValue is Map<String, int>?
          ? stringIntMapValue
          : this.stringIntMapValue?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      intIntMapValue: intIntMapValue is Map<int, int>?
          ? intIntMapValue
          : this.intIntMapValue?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      skillProficiencyListValue: skillProficiencyListValue
              is List<_i7.CharacterSkillProficiencyState>?
          ? skillProficiencyListValue
          : this.skillProficiencyListValue?.map((e0) => e0.copyWith()).toList(),
      skillProficiencyValue:
          skillProficiencyValue is _i7.CharacterSkillProficiencyState?
              ? skillProficiencyValue
              : this.skillProficiencyValue?.copyWith(),
      savingThrowProficiencyOverrideValue: savingThrowProficiencyOverrideValue
              is _i8.CharacterSavingThrowProficiencyOverrideData?
          ? savingThrowProficiencyOverrideValue
          : this.savingThrowProficiencyOverrideValue?.copyWith(),
      semanticActionValue:
          semanticActionValue is _i9.CharacterSemanticActionData?
              ? semanticActionValue
              : this.semanticActionValue?.copyWith(),
      characterValue: characterValue is _i10.CharacterData?
          ? characterValue
          : this.characterValue?.copyWith(),
      noteValue: noteValue is _i11.CharacterNoteData?
          ? noteValue
          : this.noteValue?.copyWith(),
      equipmentValue: equipmentValue is _i12.CharacterInventoryItemData?
          ? equipmentValue
          : this.equipmentValue?.copyWith(),
      attackValue: attackValue is _i13.CharacterAttackData?
          ? attackValue
          : this.attackValue?.copyWith(),
      featureOverrideValue:
          featureOverrideValue is _i14.CharacterFeatureOverrideData?
              ? featureOverrideValue
              : this.featureOverrideValue?.copyWith(),
      resourceStateValue: resourceStateValue is _i15.CharacterResourceStateData?
          ? resourceStateValue
          : this.resourceStateValue?.copyWith(),
      classEntryValue: classEntryValue is _i16.CharacterClassEntryData?
          ? classEntryValue
          : this.classEntryValue?.copyWith(),
      choiceValue: choiceValue is _i17.CharacterChoiceData?
          ? choiceValue
          : this.choiceValue?.copyWith(),
      skillSelectionValue:
          skillSelectionValue is _i18.CharacterSkillSelectionData?
              ? skillSelectionValue
              : this.skillSelectionValue?.copyWith(),
      spellSelectionValue:
          spellSelectionValue is _i19.CharacterSpellSelectionData?
              ? spellSelectionValue
              : this.spellSelectionValue?.copyWith(),
      startingEquipmentSelectionValue: startingEquipmentSelectionValue
              is _i20.CharacterStartingEquipmentSelectionData?
          ? startingEquipmentSelectionValue
          : this.startingEquipmentSelectionValue?.copyWith(),
      startingEquipmentResolutionValue: startingEquipmentResolutionValue
              is _i21.CharacterStartingEquipmentResolutionData?
          ? startingEquipmentResolutionValue
          : this.startingEquipmentResolutionValue?.copyWith(),
    );
  }
}
