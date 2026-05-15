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
import 'data/general/class/starting_equipment_block_data.dart' as _i2;
import 'data/background_data.dart' as _i3;
import 'data/class_spell_grant_data.dart' as _i4;
import 'data/damage_part_data.dart' as _i5;
import 'data/feat_data.dart' as _i6;
import 'data/general/character/character_attack_data.dart' as _i7;
import 'data/general/character/character_change_data.dart' as _i8;
import 'data/general/character/character_choice_data.dart' as _i9;
import 'data/general/character/character_class_entry_data.dart' as _i10;
import 'data/general/character/character_data.dart' as _i11;
import 'data/general/character/character_derived_data.dart' as _i12;
import 'data/general/character/character_feature_override_data.dart' as _i13;
import 'data/general/character/character_feature_view_data.dart' as _i14;
import 'data/general/character/character_inventory_item_data.dart' as _i15;
import 'data/general/character/character_note_data.dart' as _i16;
import 'data/general/character/character_rejected_change_data.dart' as _i17;
import 'data/general/character/character_skill_proficiency_state.dart' as _i18;
import 'data/general/character/character_skill_selection_data.dart' as _i19;
import 'data/general/character/character_spell_selection_data.dart' as _i20;
import 'data/general/character/character_starting_equipment_resolution_data.dart'
    as _i21;
import 'data/general/character/character_starting_equipment_selection_data.dart'
    as _i22;
import 'data/general/character/character_sync_request.dart' as _i23;
import 'data/general/character/character_sync_response.dart' as _i24;
import 'data/general/character/character_sync_result.dart' as _i25;
import 'data/general/character/character_sync_status.dart' as _i26;
import 'data/general/class/class_choice_group_data.dart' as _i27;
import 'data/general/class/class_choice_option_data.dart' as _i28;
import 'data/general/class/class_data.dart' as _i29;
import 'data/general/class/class_feature_data.dart' as _i30;
import 'data/general/class/class_level_data.dart' as _i31;
import 'data/general/class/spell_slot_progression_data.dart' as _i32;
import 'auth/auth_action_result.dart' as _i33;
import 'data/general/class/starting_equipment_entry_data.dart' as _i34;
import 'data/general/class/starting_equipment_line_data.dart' as _i35;
import 'data/general/class/starting_equipment_option_data.dart' as _i36;
import 'data/general/class/subclass_data.dart' as _i37;
import 'data/general/class/subclass_feature_data.dart' as _i38;
import 'data/general/race/race_choice_option_data.dart' as _i39;
import 'data/general/race/race_choice_set_data.dart' as _i40;
import 'data/general/race/race_data.dart' as _i41;
import 'data/general/race/race_feature_data.dart' as _i42;
import 'data/general/race/race_feature_spell_grant_data.dart' as _i43;
import 'data/general/race/subrace_data.dart' as _i44;
import 'data/items/armor_data.dart' as _i45;
import 'data/items/item_data.dart' as _i46;
import 'data/items/magic_item_data.dart' as _i47;
import 'data/items/weapon_data.dart' as _i48;
import 'data/spell_class_availability_data.dart' as _i49;
import 'data/spell_data.dart' as _i50;
import 'data/spell_scaling_data.dart' as _i51;
import 'enums/ability.dart' as _i52;
import 'enums/armor_category.dart' as _i53;
import 'enums/character_alignment.dart' as _i54;
import 'enums/character_change_type.dart' as _i55;
import 'enums/character_entity_type.dart' as _i56;
import 'enums/character_feature_source_type.dart' as _i57;
import 'enums/character_inventory_item_type.dart' as _i58;
import 'enums/character_skill_proficiency_level.dart' as _i59;
import 'enums/character_skill_selection_kind.dart' as _i60;
import 'enums/character_spell_selection_kind.dart' as _i61;
import 'enums/choice_source_type.dart' as _i62;
import 'enums/class_choice_type.dart' as _i63;
import 'enums/creature_size.dart' as _i64;
import 'views/starting_equipment_option_view.dart' as _i65;
import 'enums/equipment_catalog_type.dart' as _i66;
import 'enums/feature_tag.dart' as _i67;
import 'enums/hit_point_mode.dart' as _i68;
import 'enums/language.dart' as _i69;
import 'enums/race_choice_kind.dart' as _i70;
import 'enums/rest_type.dart' as _i71;
import 'enums/sense_type.dart' as _i72;
import 'enums/skill.dart' as _i73;
import 'enums/spell/area_of_effect_type.dart' as _i74;
import 'enums/spell/condition_type.dart' as _i75;
import 'enums/spell/spell_attack_type.dart' as _i76;
import 'enums/spell/spell_duration_type.dart' as _i77;
import 'enums/spell/spell_scaling_mode.dart' as _i78;
import 'enums/spell/spell_school.dart' as _i79;
import 'enums/spell/spell_target_type.dart' as _i80;
import 'enums/spellcasting_progression.dart' as _i81;
import 'enums/starting_equipment_block_kind.dart' as _i82;
import 'enums/starting_equipment_entry_kind.dart' as _i83;
import 'enums/starting_equipment_line_kind.dart' as _i84;
import 'enums/weapon_category.dart' as _i85;
import 'enums/weapon_property.dart' as _i86;
import 'views/background_step_view.dart' as _i87;
import 'views/character_equipment_entry_view.dart' as _i88;
import 'views/class_choice_group_view.dart' as _i89;
import 'views/class_spell_selection_group_view.dart' as _i90;
import 'views/class_step_subclass_choice_view.dart' as _i91;
import 'views/class_step_view.dart' as _i92;
import 'views/proficiency_bundle_view.dart' as _i93;
import 'views/race_step_view.dart' as _i94;
import 'views/skill_selection_group_view.dart' as _i95;
import 'views/starting_equipment_block_view.dart' as _i96;
import 'enums/damage_type.dart' as _i97;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i98;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i99;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i100;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i101;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i102;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i103;
import 'package:characters_mirror_client/src/protocol/data/class_spell_grant_data.dart'
    as _i104;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _i105;
import 'package:characters_mirror_client/src/protocol/data/general/class/spell_slot_progression_data.dart'
    as _i106;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i107;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_group_data.dart'
    as _i108;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_option_data.dart'
    as _i109;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i110;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i111;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i112;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i113;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_choice_set_data.dart'
    as _i114;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_choice_option_data.dart'
    as _i115;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i116;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i117;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i118;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i119;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i120;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i121;
export 'auth/auth_action_result.dart';
export 'data/background_data.dart';
export 'data/class_spell_grant_data.dart';
export 'data/damage_part_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_attack_data.dart';
export 'data/general/character/character_change_data.dart';
export 'data/general/character/character_choice_data.dart';
export 'data/general/character/character_class_entry_data.dart';
export 'data/general/character/character_data.dart';
export 'data/general/character/character_derived_data.dart';
export 'data/general/character/character_feature_override_data.dart';
export 'data/general/character/character_feature_view_data.dart';
export 'data/general/character/character_inventory_item_data.dart';
export 'data/general/character/character_note_data.dart';
export 'data/general/character/character_rejected_change_data.dart';
export 'data/general/character/character_skill_proficiency_state.dart';
export 'data/general/character/character_skill_selection_data.dart';
export 'data/general/character/character_spell_selection_data.dart';
export 'data/general/character/character_starting_equipment_resolution_data.dart';
export 'data/general/character/character_starting_equipment_selection_data.dart';
export 'data/general/character/character_sync_request.dart';
export 'data/general/character/character_sync_response.dart';
export 'data/general/character/character_sync_result.dart';
export 'data/general/character/character_sync_status.dart';
export 'data/general/class/class_choice_group_data.dart';
export 'data/general/class/class_choice_option_data.dart';
export 'data/general/class/class_data.dart';
export 'data/general/class/class_feature_data.dart';
export 'data/general/class/class_level_data.dart';
export 'data/general/class/spell_slot_progression_data.dart';
export 'data/general/class/starting_equipment_block_data.dart';
export 'data/general/class/starting_equipment_entry_data.dart';
export 'data/general/class/starting_equipment_line_data.dart';
export 'data/general/class/starting_equipment_option_data.dart';
export 'data/general/class/subclass_data.dart';
export 'data/general/class/subclass_feature_data.dart';
export 'data/general/race/race_choice_option_data.dart';
export 'data/general/race/race_choice_set_data.dart';
export 'data/general/race/race_data.dart';
export 'data/general/race/race_feature_data.dart';
export 'data/general/race/race_feature_spell_grant_data.dart';
export 'data/general/race/subrace_data.dart';
export 'data/items/armor_data.dart';
export 'data/items/item_data.dart';
export 'data/items/magic_item_data.dart';
export 'data/items/weapon_data.dart';
export 'data/spell_class_availability_data.dart';
export 'data/spell_data.dart';
export 'data/spell_scaling_data.dart';
export 'enums/ability.dart';
export 'enums/armor_category.dart';
export 'enums/character_alignment.dart';
export 'enums/character_change_type.dart';
export 'enums/character_entity_type.dart';
export 'enums/character_feature_source_type.dart';
export 'enums/character_inventory_item_type.dart';
export 'enums/character_skill_proficiency_level.dart';
export 'enums/character_skill_selection_kind.dart';
export 'enums/character_spell_selection_kind.dart';
export 'enums/choice_source_type.dart';
export 'enums/class_choice_type.dart';
export 'enums/creature_size.dart';
export 'enums/damage_type.dart';
export 'enums/equipment_catalog_type.dart';
export 'enums/feature_tag.dart';
export 'enums/hit_point_mode.dart';
export 'enums/language.dart';
export 'enums/race_choice_kind.dart';
export 'enums/rest_type.dart';
export 'enums/sense_type.dart';
export 'enums/skill.dart';
export 'enums/spell/area_of_effect_type.dart';
export 'enums/spell/condition_type.dart';
export 'enums/spell/spell_attack_type.dart';
export 'enums/spell/spell_duration_type.dart';
export 'enums/spell/spell_scaling_mode.dart';
export 'enums/spell/spell_school.dart';
export 'enums/spell/spell_target_type.dart';
export 'enums/spellcasting_progression.dart';
export 'enums/starting_equipment_block_kind.dart';
export 'enums/starting_equipment_entry_kind.dart';
export 'enums/starting_equipment_line_kind.dart';
export 'enums/weapon_category.dart';
export 'enums/weapon_property.dart';
export 'views/background_step_view.dart';
export 'views/character_equipment_entry_view.dart';
export 'views/class_choice_group_view.dart';
export 'views/class_spell_selection_group_view.dart';
export 'views/class_step_subclass_choice_view.dart';
export 'views/class_step_view.dart';
export 'views/proficiency_bundle_view.dart';
export 'views/race_step_view.dart';
export 'views/skill_selection_group_view.dart';
export 'views/starting_equipment_block_view.dart';
export 'views/starting_equipment_option_view.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.StartingEquipmentBlockData) {
      return _i2.StartingEquipmentBlockData.fromJson(data) as T;
    }
    if (t == _i3.BackgroundData) {
      return _i3.BackgroundData.fromJson(data) as T;
    }
    if (t == _i4.ClassSpellGrantData) {
      return _i4.ClassSpellGrantData.fromJson(data) as T;
    }
    if (t == _i5.DamagePartData) {
      return _i5.DamagePartData.fromJson(data) as T;
    }
    if (t == _i6.FeatData) {
      return _i6.FeatData.fromJson(data) as T;
    }
    if (t == _i7.CharacterAttackData) {
      return _i7.CharacterAttackData.fromJson(data) as T;
    }
    if (t == _i8.CharacterChangeData) {
      return _i8.CharacterChangeData.fromJson(data) as T;
    }
    if (t == _i9.CharacterChoiceData) {
      return _i9.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i10.CharacterClassEntryData) {
      return _i10.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i11.CharacterData) {
      return _i11.CharacterData.fromJson(data) as T;
    }
    if (t == _i12.CharacterDerivedData) {
      return _i12.CharacterDerivedData.fromJson(data) as T;
    }
    if (t == _i13.CharacterFeatureOverrideData) {
      return _i13.CharacterFeatureOverrideData.fromJson(data) as T;
    }
    if (t == _i14.CharacterFeatureViewData) {
      return _i14.CharacterFeatureViewData.fromJson(data) as T;
    }
    if (t == _i15.CharacterInventoryItemData) {
      return _i15.CharacterInventoryItemData.fromJson(data) as T;
    }
    if (t == _i16.CharacterNoteData) {
      return _i16.CharacterNoteData.fromJson(data) as T;
    }
    if (t == _i17.CharacterRejectedChangeData) {
      return _i17.CharacterRejectedChangeData.fromJson(data) as T;
    }
    if (t == _i18.CharacterSkillProficiencyState) {
      return _i18.CharacterSkillProficiencyState.fromJson(data) as T;
    }
    if (t == _i19.CharacterSkillSelectionData) {
      return _i19.CharacterSkillSelectionData.fromJson(data) as T;
    }
    if (t == _i20.CharacterSpellSelectionData) {
      return _i20.CharacterSpellSelectionData.fromJson(data) as T;
    }
    if (t == _i21.CharacterStartingEquipmentResolutionData) {
      return _i21.CharacterStartingEquipmentResolutionData.fromJson(data) as T;
    }
    if (t == _i22.CharacterStartingEquipmentSelectionData) {
      return _i22.CharacterStartingEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _i23.CharacterSyncRequest) {
      return _i23.CharacterSyncRequest.fromJson(data) as T;
    }
    if (t == _i24.CharacterSyncResponse) {
      return _i24.CharacterSyncResponse.fromJson(data) as T;
    }
    if (t == _i25.CharacterSyncResult) {
      return _i25.CharacterSyncResult.fromJson(data) as T;
    }
    if (t == _i26.CharacterSyncStatus) {
      return _i26.CharacterSyncStatus.fromJson(data) as T;
    }
    if (t == _i27.ClassChoiceGroupData) {
      return _i27.ClassChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i28.ClassChoiceOptionData) {
      return _i28.ClassChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i29.ClassData) {
      return _i29.ClassData.fromJson(data) as T;
    }
    if (t == _i30.ClassFeatureData) {
      return _i30.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i31.ClassLevelData) {
      return _i31.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i32.SpellSlotProgressionData) {
      return _i32.SpellSlotProgressionData.fromJson(data) as T;
    }
    if (t == _i33.AuthActionResult) {
      return _i33.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i34.StartingEquipmentEntryData) {
      return _i34.StartingEquipmentEntryData.fromJson(data) as T;
    }
    if (t == _i35.StartingEquipmentLineData) {
      return _i35.StartingEquipmentLineData.fromJson(data) as T;
    }
    if (t == _i36.StartingEquipmentOptionData) {
      return _i36.StartingEquipmentOptionData.fromJson(data) as T;
    }
    if (t == _i37.SubclassData) {
      return _i37.SubclassData.fromJson(data) as T;
    }
    if (t == _i38.SubclassFeatureData) {
      return _i38.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i39.RaceChoiceOptionData) {
      return _i39.RaceChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i40.RaceChoiceSetData) {
      return _i40.RaceChoiceSetData.fromJson(data) as T;
    }
    if (t == _i41.RaceData) {
      return _i41.RaceData.fromJson(data) as T;
    }
    if (t == _i42.RaceFeatureData) {
      return _i42.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i43.RaceFeatureSpellGrantData) {
      return _i43.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _i44.SubraceData) {
      return _i44.SubraceData.fromJson(data) as T;
    }
    if (t == _i45.ArmorData) {
      return _i45.ArmorData.fromJson(data) as T;
    }
    if (t == _i46.ItemData) {
      return _i46.ItemData.fromJson(data) as T;
    }
    if (t == _i47.MagicItemData) {
      return _i47.MagicItemData.fromJson(data) as T;
    }
    if (t == _i48.WeaponData) {
      return _i48.WeaponData.fromJson(data) as T;
    }
    if (t == _i49.SpellClassAvailabilityData) {
      return _i49.SpellClassAvailabilityData.fromJson(data) as T;
    }
    if (t == _i50.SpellData) {
      return _i50.SpellData.fromJson(data) as T;
    }
    if (t == _i51.SpellScalingData) {
      return _i51.SpellScalingData.fromJson(data) as T;
    }
    if (t == _i52.Ability) {
      return _i52.Ability.fromJson(data) as T;
    }
    if (t == _i53.ArmorCategory) {
      return _i53.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i54.CharacterAlignment) {
      return _i54.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i55.CharacterChangeType) {
      return _i55.CharacterChangeType.fromJson(data) as T;
    }
    if (t == _i56.CharacterEntityType) {
      return _i56.CharacterEntityType.fromJson(data) as T;
    }
    if (t == _i57.CharacterFeatureSourceType) {
      return _i57.CharacterFeatureSourceType.fromJson(data) as T;
    }
    if (t == _i58.CharacterInventoryItemType) {
      return _i58.CharacterInventoryItemType.fromJson(data) as T;
    }
    if (t == _i59.CharacterSkillProficiencyLevel) {
      return _i59.CharacterSkillProficiencyLevel.fromJson(data) as T;
    }
    if (t == _i60.CharacterSkillSelectionKind) {
      return _i60.CharacterSkillSelectionKind.fromJson(data) as T;
    }
    if (t == _i61.CharacterSpellSelectionKind) {
      return _i61.CharacterSpellSelectionKind.fromJson(data) as T;
    }
    if (t == _i62.ChoiceSourceType) {
      return _i62.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i63.ClassChoiceType) {
      return _i63.ClassChoiceType.fromJson(data) as T;
    }
    if (t == _i64.CreatureSize) {
      return _i64.CreatureSize.fromJson(data) as T;
    }
    if (t == _i65.StartingEquipmentOptionView) {
      return _i65.StartingEquipmentOptionView.fromJson(data) as T;
    }
    if (t == _i66.EquipmentCatalogType) {
      return _i66.EquipmentCatalogType.fromJson(data) as T;
    }
    if (t == _i67.FeatureTag) {
      return _i67.FeatureTag.fromJson(data) as T;
    }
    if (t == _i68.HitPointMode) {
      return _i68.HitPointMode.fromJson(data) as T;
    }
    if (t == _i69.Language) {
      return _i69.Language.fromJson(data) as T;
    }
    if (t == _i70.RaceChoiceKind) {
      return _i70.RaceChoiceKind.fromJson(data) as T;
    }
    if (t == _i71.RestType) {
      return _i71.RestType.fromJson(data) as T;
    }
    if (t == _i72.SenseType) {
      return _i72.SenseType.fromJson(data) as T;
    }
    if (t == _i73.Skill) {
      return _i73.Skill.fromJson(data) as T;
    }
    if (t == _i74.AreaOfEffectType) {
      return _i74.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _i75.ConditionType) {
      return _i75.ConditionType.fromJson(data) as T;
    }
    if (t == _i76.SpellAttackType) {
      return _i76.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i77.SpellDurationType) {
      return _i77.SpellDurationType.fromJson(data) as T;
    }
    if (t == _i78.SpellScalingMode) {
      return _i78.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _i79.SpellSchool) {
      return _i79.SpellSchool.fromJson(data) as T;
    }
    if (t == _i80.SpellTargetType) {
      return _i80.SpellTargetType.fromJson(data) as T;
    }
    if (t == _i81.SpellcastingProgression) {
      return _i81.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i82.StartingEquipmentBlockKind) {
      return _i82.StartingEquipmentBlockKind.fromJson(data) as T;
    }
    if (t == _i83.StartingEquipmentEntryKind) {
      return _i83.StartingEquipmentEntryKind.fromJson(data) as T;
    }
    if (t == _i84.StartingEquipmentLineKind) {
      return _i84.StartingEquipmentLineKind.fromJson(data) as T;
    }
    if (t == _i85.WeaponCategory) {
      return _i85.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i86.WeaponProperty) {
      return _i86.WeaponProperty.fromJson(data) as T;
    }
    if (t == _i87.BackgroundStepView) {
      return _i87.BackgroundStepView.fromJson(data) as T;
    }
    if (t == _i88.CharacterEquipmentEntryView) {
      return _i88.CharacterEquipmentEntryView.fromJson(data) as T;
    }
    if (t == _i89.ClassChoiceGroupView) {
      return _i89.ClassChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i90.ClassSpellSelectionGroupView) {
      return _i90.ClassSpellSelectionGroupView.fromJson(data) as T;
    }
    if (t == _i91.ClassStepSubclassChoiceView) {
      return _i91.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i92.ClassStepView) {
      return _i92.ClassStepView.fromJson(data) as T;
    }
    if (t == _i93.ProficiencyBundleView) {
      return _i93.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i94.RaceStepView) {
      return _i94.RaceStepView.fromJson(data) as T;
    }
    if (t == _i95.SkillSelectionGroupView) {
      return _i95.SkillSelectionGroupView.fromJson(data) as T;
    }
    if (t == _i96.StartingEquipmentBlockView) {
      return _i96.StartingEquipmentBlockView.fromJson(data) as T;
    }
    if (t == _i97.DamageType) {
      return _i97.DamageType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.StartingEquipmentBlockData?>()) {
      return (data != null
          ? _i2.StartingEquipmentBlockData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i3.BackgroundData?>()) {
      return (data != null ? _i3.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ClassSpellGrantData?>()) {
      return (data != null ? _i4.ClassSpellGrantData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.DamagePartData?>()) {
      return (data != null ? _i5.DamagePartData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.FeatData?>()) {
      return (data != null ? _i6.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CharacterAttackData?>()) {
      return (data != null ? _i7.CharacterAttackData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.CharacterChangeData?>()) {
      return (data != null ? _i8.CharacterChangeData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.CharacterChoiceData?>()) {
      return (data != null ? _i9.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.CharacterClassEntryData?>()) {
      return (data != null ? _i10.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.CharacterData?>()) {
      return (data != null ? _i11.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CharacterDerivedData?>()) {
      return (data != null ? _i12.CharacterDerivedData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.CharacterFeatureOverrideData?>()) {
      return (data != null
          ? _i13.CharacterFeatureOverrideData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i14.CharacterFeatureViewData?>()) {
      return (data != null
          ? _i14.CharacterFeatureViewData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i15.CharacterInventoryItemData?>()) {
      return (data != null
          ? _i15.CharacterInventoryItemData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i16.CharacterNoteData?>()) {
      return (data != null ? _i16.CharacterNoteData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.CharacterRejectedChangeData?>()) {
      return (data != null
          ? _i17.CharacterRejectedChangeData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i18.CharacterSkillProficiencyState?>()) {
      return (data != null
          ? _i18.CharacterSkillProficiencyState.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i19.CharacterSkillSelectionData?>()) {
      return (data != null
          ? _i19.CharacterSkillSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i20.CharacterSpellSelectionData?>()) {
      return (data != null
          ? _i20.CharacterSpellSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i21.CharacterStartingEquipmentResolutionData?>()) {
      return (data != null
          ? _i21.CharacterStartingEquipmentResolutionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i22.CharacterStartingEquipmentSelectionData?>()) {
      return (data != null
          ? _i22.CharacterStartingEquipmentSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i23.CharacterSyncRequest?>()) {
      return (data != null ? _i23.CharacterSyncRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.CharacterSyncResponse?>()) {
      return (data != null ? _i24.CharacterSyncResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.CharacterSyncResult?>()) {
      return (data != null ? _i25.CharacterSyncResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.CharacterSyncStatus?>()) {
      return (data != null ? _i26.CharacterSyncStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.ClassChoiceGroupData?>()) {
      return (data != null ? _i27.ClassChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.ClassChoiceOptionData?>()) {
      return (data != null ? _i28.ClassChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.ClassData?>()) {
      return (data != null ? _i29.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ClassFeatureData?>()) {
      return (data != null ? _i30.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ClassLevelData?>()) {
      return (data != null ? _i31.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.SpellSlotProgressionData?>()) {
      return (data != null
          ? _i32.SpellSlotProgressionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i33.AuthActionResult?>()) {
      return (data != null ? _i33.AuthActionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.StartingEquipmentEntryData?>()) {
      return (data != null
          ? _i34.StartingEquipmentEntryData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i35.StartingEquipmentLineData?>()) {
      return (data != null
          ? _i35.StartingEquipmentLineData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i36.StartingEquipmentOptionData?>()) {
      return (data != null
          ? _i36.StartingEquipmentOptionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i37.SubclassData?>()) {
      return (data != null ? _i37.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.SubclassFeatureData?>()) {
      return (data != null ? _i38.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i39.RaceChoiceOptionData?>()) {
      return (data != null ? _i39.RaceChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.RaceChoiceSetData?>()) {
      return (data != null ? _i40.RaceChoiceSetData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.RaceData?>()) {
      return (data != null ? _i41.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.RaceFeatureData?>()) {
      return (data != null ? _i42.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.RaceFeatureSpellGrantData?>()) {
      return (data != null
          ? _i43.RaceFeatureSpellGrantData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i44.SubraceData?>()) {
      return (data != null ? _i44.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.ArmorData?>()) {
      return (data != null ? _i45.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.ItemData?>()) {
      return (data != null ? _i46.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.MagicItemData?>()) {
      return (data != null ? _i47.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.WeaponData?>()) {
      return (data != null ? _i48.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SpellClassAvailabilityData?>()) {
      return (data != null
          ? _i49.SpellClassAvailabilityData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i50.SpellData?>()) {
      return (data != null ? _i50.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SpellScalingData?>()) {
      return (data != null ? _i51.SpellScalingData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.Ability?>()) {
      return (data != null ? _i52.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.ArmorCategory?>()) {
      return (data != null ? _i53.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.CharacterAlignment?>()) {
      return (data != null ? _i54.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.CharacterChangeType?>()) {
      return (data != null ? _i55.CharacterChangeType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.CharacterEntityType?>()) {
      return (data != null ? _i56.CharacterEntityType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.CharacterFeatureSourceType?>()) {
      return (data != null
          ? _i57.CharacterFeatureSourceType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i58.CharacterInventoryItemType?>()) {
      return (data != null
          ? _i58.CharacterInventoryItemType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i59.CharacterSkillProficiencyLevel?>()) {
      return (data != null
          ? _i59.CharacterSkillProficiencyLevel.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i60.CharacterSkillSelectionKind?>()) {
      return (data != null
          ? _i60.CharacterSkillSelectionKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i61.CharacterSpellSelectionKind?>()) {
      return (data != null
          ? _i61.CharacterSpellSelectionKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i62.ChoiceSourceType?>()) {
      return (data != null ? _i62.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.ClassChoiceType?>()) {
      return (data != null ? _i63.ClassChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.CreatureSize?>()) {
      return (data != null ? _i64.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.StartingEquipmentOptionView?>()) {
      return (data != null
          ? _i65.StartingEquipmentOptionView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i66.EquipmentCatalogType?>()) {
      return (data != null ? _i66.EquipmentCatalogType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i67.FeatureTag?>()) {
      return (data != null ? _i67.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.HitPointMode?>()) {
      return (data != null ? _i68.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.Language?>()) {
      return (data != null ? _i69.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.RaceChoiceKind?>()) {
      return (data != null ? _i70.RaceChoiceKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.RestType?>()) {
      return (data != null ? _i71.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i72.SenseType?>()) {
      return (data != null ? _i72.SenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.Skill?>()) {
      return (data != null ? _i73.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.AreaOfEffectType?>()) {
      return (data != null ? _i74.AreaOfEffectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i75.ConditionType?>()) {
      return (data != null ? _i75.ConditionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.SpellAttackType?>()) {
      return (data != null ? _i76.SpellAttackType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.SpellDurationType?>()) {
      return (data != null ? _i77.SpellDurationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.SpellScalingMode?>()) {
      return (data != null ? _i78.SpellScalingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.SpellSchool?>()) {
      return (data != null ? _i79.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.SpellTargetType?>()) {
      return (data != null ? _i80.SpellTargetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.SpellcastingProgression?>()) {
      return (data != null ? _i81.SpellcastingProgression.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i82.StartingEquipmentBlockKind?>()) {
      return (data != null
          ? _i82.StartingEquipmentBlockKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i83.StartingEquipmentEntryKind?>()) {
      return (data != null
          ? _i83.StartingEquipmentEntryKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i84.StartingEquipmentLineKind?>()) {
      return (data != null
          ? _i84.StartingEquipmentLineKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i85.WeaponCategory?>()) {
      return (data != null ? _i85.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.WeaponProperty?>()) {
      return (data != null ? _i86.WeaponProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.BackgroundStepView?>()) {
      return (data != null ? _i87.BackgroundStepView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.CharacterEquipmentEntryView?>()) {
      return (data != null
          ? _i88.CharacterEquipmentEntryView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i89.ClassChoiceGroupView?>()) {
      return (data != null ? _i89.ClassChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i90.ClassSpellSelectionGroupView?>()) {
      return (data != null
          ? _i90.ClassSpellSelectionGroupView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i91.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i91.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i92.ClassStepView?>()) {
      return (data != null ? _i92.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i93.ProficiencyBundleView?>()) {
      return (data != null ? _i93.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i94.RaceStepView?>()) {
      return (data != null ? _i94.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i95.SkillSelectionGroupView?>()) {
      return (data != null ? _i95.SkillSelectionGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i96.StartingEquipmentBlockView?>()) {
      return (data != null
          ? _i96.StartingEquipmentBlockView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i97.DamageType?>()) {
      return (data != null ? _i97.DamageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<List<_i35.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.StartingEquipmentOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i36.StartingEquipmentOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.DamagePartData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.DamagePartData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CharacterInventoryItemData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CharacterInventoryItemData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CharacterNoteData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CharacterNoteData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.CharacterAttackData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.CharacterAttackData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CharacterFeatureOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CharacterFeatureOverrideData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CharacterSkillSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CharacterSkillSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.CharacterSpellSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.CharacterSpellSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i22.CharacterStartingEquipmentSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i22.CharacterStartingEquipmentSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.CharacterFeatureViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.CharacterFeatureViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i88.CharacterEquipmentEntryView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i88.CharacterEquipmentEntryView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i97.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i97.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i21.CharacterStartingEquipmentResolutionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i21.CharacterStartingEquipmentResolutionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.CharacterChangeData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.CharacterChangeData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CharacterRejectedChangeData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CharacterRejectedChangeData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.CharacterData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.CharacterData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i69.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i69.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i85.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i85.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i85.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.ClassSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.ClassSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i85.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i85.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.ClassSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.ClassSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i39.RaceChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i39.RaceChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i97.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i97.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i42.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i67.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.RaceFeatureSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i43.RaceFeatureSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i40.RaceChoiceSetData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i40.RaceChoiceSetData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i97.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i97.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i42.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.WeaponProperty>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i86.WeaponProperty>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.DamagePartData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.DamagePartData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i75.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i75.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i49.SpellClassAvailabilityData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i49.SpellClassAvailabilityData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, String>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<String>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, String>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<String>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i89.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i89.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i95.SkillSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i95.SkillSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i96.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i96.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.ClassChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.ClassChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i50.SpellData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i50.SpellData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.SubclassData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i37.SubclassData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i89.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i89.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i95.SkillSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i95.SkillSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i90.ClassSpellSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i90.ClassSpellSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i96.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i96.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i53.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i85.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i85.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i69.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i69.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i44.SubraceData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i44.SubraceData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i42.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i73.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i35.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i65.StartingEquipmentOptionView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.StartingEquipmentOptionView>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i98.UserInfo>) {
      return (data as List).map((e) => deserialize<_i98.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i99.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i99.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i100.FeatData>) {
      return (data as List).map((e) => deserialize<_i100.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i101.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i101.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i102.ClassData>) {
      return (data as List).map((e) => deserialize<_i102.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i103.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i103.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i104.ClassSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i104.ClassSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i105.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i105.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i106.SpellSlotProgressionData>) {
      return (data as List)
          .map((e) => deserialize<_i106.SpellSlotProgressionData>(e))
          .toList() as T;
    }
    if (t == List<_i107.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i107.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i108.ClassChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i108.ClassChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i109.ClassChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i109.ClassChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i110.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i110.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i111.RaceData>) {
      return (data as List).map((e) => deserialize<_i111.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i112.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i112.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i113.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i113.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i114.RaceChoiceSetData>) {
      return (data as List)
          .map((e) => deserialize<_i114.RaceChoiceSetData>(e))
          .toList() as T;
    }
    if (t == List<_i115.RaceChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i115.RaceChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i116.RaceFeatureSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i116.RaceFeatureSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i117.ArmorData>) {
      return (data as List).map((e) => deserialize<_i117.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i118.ItemData>) {
      return (data as List).map((e) => deserialize<_i118.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i119.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i119.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i120.WeaponData>) {
      return (data as List)
          .map((e) => deserialize<_i120.WeaponData>(e))
          .toList() as T;
    }
    if (t == List<_i121.SpellData>) {
      return (data as List).map((e) => deserialize<_i121.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i98.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.StartingEquipmentBlockData) {
      return 'StartingEquipmentBlockData';
    }
    if (data is _i3.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i4.ClassSpellGrantData) {
      return 'ClassSpellGrantData';
    }
    if (data is _i5.DamagePartData) {
      return 'DamagePartData';
    }
    if (data is _i6.FeatData) {
      return 'FeatData';
    }
    if (data is _i7.CharacterAttackData) {
      return 'CharacterAttackData';
    }
    if (data is _i8.CharacterChangeData) {
      return 'CharacterChangeData';
    }
    if (data is _i9.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i10.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i11.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i12.CharacterDerivedData) {
      return 'CharacterDerivedData';
    }
    if (data is _i13.CharacterFeatureOverrideData) {
      return 'CharacterFeatureOverrideData';
    }
    if (data is _i14.CharacterFeatureViewData) {
      return 'CharacterFeatureViewData';
    }
    if (data is _i15.CharacterInventoryItemData) {
      return 'CharacterInventoryItemData';
    }
    if (data is _i16.CharacterNoteData) {
      return 'CharacterNoteData';
    }
    if (data is _i17.CharacterRejectedChangeData) {
      return 'CharacterRejectedChangeData';
    }
    if (data is _i18.CharacterSkillProficiencyState) {
      return 'CharacterSkillProficiencyState';
    }
    if (data is _i19.CharacterSkillSelectionData) {
      return 'CharacterSkillSelectionData';
    }
    if (data is _i20.CharacterSpellSelectionData) {
      return 'CharacterSpellSelectionData';
    }
    if (data is _i21.CharacterStartingEquipmentResolutionData) {
      return 'CharacterStartingEquipmentResolutionData';
    }
    if (data is _i22.CharacterStartingEquipmentSelectionData) {
      return 'CharacterStartingEquipmentSelectionData';
    }
    if (data is _i23.CharacterSyncRequest) {
      return 'CharacterSyncRequest';
    }
    if (data is _i24.CharacterSyncResponse) {
      return 'CharacterSyncResponse';
    }
    if (data is _i25.CharacterSyncResult) {
      return 'CharacterSyncResult';
    }
    if (data is _i26.CharacterSyncStatus) {
      return 'CharacterSyncStatus';
    }
    if (data is _i27.ClassChoiceGroupData) {
      return 'ClassChoiceGroupData';
    }
    if (data is _i28.ClassChoiceOptionData) {
      return 'ClassChoiceOptionData';
    }
    if (data is _i29.ClassData) {
      return 'ClassData';
    }
    if (data is _i30.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i31.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i32.SpellSlotProgressionData) {
      return 'SpellSlotProgressionData';
    }
    if (data is _i33.AuthActionResult) {
      return 'AuthActionResult';
    }
    if (data is _i34.StartingEquipmentEntryData) {
      return 'StartingEquipmentEntryData';
    }
    if (data is _i35.StartingEquipmentLineData) {
      return 'StartingEquipmentLineData';
    }
    if (data is _i36.StartingEquipmentOptionData) {
      return 'StartingEquipmentOptionData';
    }
    if (data is _i37.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i38.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i39.RaceChoiceOptionData) {
      return 'RaceChoiceOptionData';
    }
    if (data is _i40.RaceChoiceSetData) {
      return 'RaceChoiceSetData';
    }
    if (data is _i41.RaceData) {
      return 'RaceData';
    }
    if (data is _i42.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i43.RaceFeatureSpellGrantData) {
      return 'RaceFeatureSpellGrantData';
    }
    if (data is _i44.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i45.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i46.ItemData) {
      return 'ItemData';
    }
    if (data is _i47.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i48.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i49.SpellClassAvailabilityData) {
      return 'SpellClassAvailabilityData';
    }
    if (data is _i50.SpellData) {
      return 'SpellData';
    }
    if (data is _i51.SpellScalingData) {
      return 'SpellScalingData';
    }
    if (data is _i52.Ability) {
      return 'Ability';
    }
    if (data is _i53.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i54.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i55.CharacterChangeType) {
      return 'CharacterChangeType';
    }
    if (data is _i56.CharacterEntityType) {
      return 'CharacterEntityType';
    }
    if (data is _i57.CharacterFeatureSourceType) {
      return 'CharacterFeatureSourceType';
    }
    if (data is _i58.CharacterInventoryItemType) {
      return 'CharacterInventoryItemType';
    }
    if (data is _i59.CharacterSkillProficiencyLevel) {
      return 'CharacterSkillProficiencyLevel';
    }
    if (data is _i60.CharacterSkillSelectionKind) {
      return 'CharacterSkillSelectionKind';
    }
    if (data is _i61.CharacterSpellSelectionKind) {
      return 'CharacterSpellSelectionKind';
    }
    if (data is _i62.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i63.ClassChoiceType) {
      return 'ClassChoiceType';
    }
    if (data is _i64.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i65.StartingEquipmentOptionView) {
      return 'StartingEquipmentOptionView';
    }
    if (data is _i66.EquipmentCatalogType) {
      return 'EquipmentCatalogType';
    }
    if (data is _i67.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i68.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i69.Language) {
      return 'Language';
    }
    if (data is _i70.RaceChoiceKind) {
      return 'RaceChoiceKind';
    }
    if (data is _i71.RestType) {
      return 'RestType';
    }
    if (data is _i72.SenseType) {
      return 'SenseType';
    }
    if (data is _i73.Skill) {
      return 'Skill';
    }
    if (data is _i74.AreaOfEffectType) {
      return 'AreaOfEffectType';
    }
    if (data is _i75.ConditionType) {
      return 'ConditionType';
    }
    if (data is _i76.SpellAttackType) {
      return 'SpellAttackType';
    }
    if (data is _i77.SpellDurationType) {
      return 'SpellDurationType';
    }
    if (data is _i78.SpellScalingMode) {
      return 'SpellScalingMode';
    }
    if (data is _i79.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i80.SpellTargetType) {
      return 'SpellTargetType';
    }
    if (data is _i81.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i82.StartingEquipmentBlockKind) {
      return 'StartingEquipmentBlockKind';
    }
    if (data is _i83.StartingEquipmentEntryKind) {
      return 'StartingEquipmentEntryKind';
    }
    if (data is _i84.StartingEquipmentLineKind) {
      return 'StartingEquipmentLineKind';
    }
    if (data is _i85.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i86.WeaponProperty) {
      return 'WeaponProperty';
    }
    if (data is _i87.BackgroundStepView) {
      return 'BackgroundStepView';
    }
    if (data is _i88.CharacterEquipmentEntryView) {
      return 'CharacterEquipmentEntryView';
    }
    if (data is _i89.ClassChoiceGroupView) {
      return 'ClassChoiceGroupView';
    }
    if (data is _i90.ClassSpellSelectionGroupView) {
      return 'ClassSpellSelectionGroupView';
    }
    if (data is _i91.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i92.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i93.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i94.RaceStepView) {
      return 'RaceStepView';
    }
    if (data is _i95.SkillSelectionGroupView) {
      return 'SkillSelectionGroupView';
    }
    if (data is _i96.StartingEquipmentBlockView) {
      return 'StartingEquipmentBlockView';
    }
    if (data is _i97.DamageType) {
      return 'DamageType';
    }
    className = _i98.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'StartingEquipmentBlockData') {
      return deserialize<_i2.StartingEquipmentBlockData>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i3.BackgroundData>(data['data']);
    }
    if (dataClassName == 'ClassSpellGrantData') {
      return deserialize<_i4.ClassSpellGrantData>(data['data']);
    }
    if (dataClassName == 'DamagePartData') {
      return deserialize<_i5.DamagePartData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i6.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterAttackData') {
      return deserialize<_i7.CharacterAttackData>(data['data']);
    }
    if (dataClassName == 'CharacterChangeData') {
      return deserialize<_i8.CharacterChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i9.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i10.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i11.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterDerivedData') {
      return deserialize<_i12.CharacterDerivedData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureOverrideData') {
      return deserialize<_i13.CharacterFeatureOverrideData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureViewData') {
      return deserialize<_i14.CharacterFeatureViewData>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemData') {
      return deserialize<_i15.CharacterInventoryItemData>(data['data']);
    }
    if (dataClassName == 'CharacterNoteData') {
      return deserialize<_i16.CharacterNoteData>(data['data']);
    }
    if (dataClassName == 'CharacterRejectedChangeData') {
      return deserialize<_i17.CharacterRejectedChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyState') {
      return deserialize<_i18.CharacterSkillProficiencyState>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionData') {
      return deserialize<_i19.CharacterSkillSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionData') {
      return deserialize<_i20.CharacterSpellSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionData') {
      return deserialize<_i21.CharacterStartingEquipmentResolutionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionData') {
      return deserialize<_i22.CharacterStartingEquipmentSelectionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterSyncRequest') {
      return deserialize<_i23.CharacterSyncRequest>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResponse') {
      return deserialize<_i24.CharacterSyncResponse>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResult') {
      return deserialize<_i25.CharacterSyncResult>(data['data']);
    }
    if (dataClassName == 'CharacterSyncStatus') {
      return deserialize<_i26.CharacterSyncStatus>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupData') {
      return deserialize<_i27.ClassChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceOptionData') {
      return deserialize<_i28.ClassChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i29.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i30.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i31.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'SpellSlotProgressionData') {
      return deserialize<_i32.SpellSlotProgressionData>(data['data']);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_i33.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryData') {
      return deserialize<_i34.StartingEquipmentEntryData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineData') {
      return deserialize<_i35.StartingEquipmentLineData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionData') {
      return deserialize<_i36.StartingEquipmentOptionData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i37.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i38.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceOptionData') {
      return deserialize<_i39.RaceChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceSetData') {
      return deserialize<_i40.RaceChoiceSetData>(data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i41.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i42.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_i43.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i44.SubraceData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i45.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i46.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i47.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i48.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellClassAvailabilityData') {
      return deserialize<_i49.SpellClassAvailabilityData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i50.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_i51.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i52.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i53.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i54.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'CharacterChangeType') {
      return deserialize<_i55.CharacterChangeType>(data['data']);
    }
    if (dataClassName == 'CharacterEntityType') {
      return deserialize<_i56.CharacterEntityType>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureSourceType') {
      return deserialize<_i57.CharacterFeatureSourceType>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemType') {
      return deserialize<_i58.CharacterInventoryItemType>(data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyLevel') {
      return deserialize<_i59.CharacterSkillProficiencyLevel>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionKind') {
      return deserialize<_i60.CharacterSkillSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionKind') {
      return deserialize<_i61.CharacterSpellSelectionKind>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i62.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ClassChoiceType') {
      return deserialize<_i63.ClassChoiceType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i64.CreatureSize>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionView') {
      return deserialize<_i65.StartingEquipmentOptionView>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalogType') {
      return deserialize<_i66.EquipmentCatalogType>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i67.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i68.HitPointMode>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i69.Language>(data['data']);
    }
    if (dataClassName == 'RaceChoiceKind') {
      return deserialize<_i70.RaceChoiceKind>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i71.RestType>(data['data']);
    }
    if (dataClassName == 'SenseType') {
      return deserialize<_i72.SenseType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i73.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_i74.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_i75.ConditionType>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_i76.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i77.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_i78.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i79.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_i80.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i81.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockKind') {
      return deserialize<_i82.StartingEquipmentBlockKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryKind') {
      return deserialize<_i83.StartingEquipmentEntryKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineKind') {
      return deserialize<_i84.StartingEquipmentLineKind>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i85.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'WeaponProperty') {
      return deserialize<_i86.WeaponProperty>(data['data']);
    }
    if (dataClassName == 'BackgroundStepView') {
      return deserialize<_i87.BackgroundStepView>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentEntryView') {
      return deserialize<_i88.CharacterEquipmentEntryView>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupView') {
      return deserialize<_i89.ClassChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionGroupView') {
      return deserialize<_i90.ClassSpellSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i91.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i92.ClassStepView>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i93.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceStepView') {
      return deserialize<_i94.RaceStepView>(data['data']);
    }
    if (dataClassName == 'SkillSelectionGroupView') {
      return deserialize<_i95.SkillSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockView') {
      return deserialize<_i96.StartingEquipmentBlockView>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i97.DamageType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i98.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
