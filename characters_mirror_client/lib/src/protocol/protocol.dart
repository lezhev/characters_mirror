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
import 'data/general/class/subclass_data.dart' as _i2;
import 'data/background_data.dart' as _i3;
import 'data/class_spell_grant_data.dart' as _i4;
import 'data/damage_part_data.dart' as _i5;
import 'data/feat_data.dart' as _i6;
import 'data/general/character/character_armor_training_overrides_data.dart'
    as _i7;
import 'data/general/character/character_attack_data.dart' as _i8;
import 'data/general/character/character_change_data.dart' as _i9;
import 'data/general/character/character_choice_data.dart' as _i10;
import 'data/general/character/character_class_entry_data.dart' as _i11;
import 'data/general/character/character_data.dart' as _i12;
import 'data/general/character/character_derived_data.dart' as _i13;
import 'data/general/character/character_equipment_selection_data.dart' as _i14;
import 'data/general/character/character_feature_override_data.dart' as _i15;
import 'data/general/character/character_feature_view_data.dart' as _i16;
import 'data/general/character/character_inventory_item_data.dart' as _i17;
import 'data/general/character/character_language_overrides_data.dart' as _i18;
import 'data/general/character/character_note_data.dart' as _i19;
import 'data/general/character/character_rejected_change_data.dart' as _i20;
import 'data/general/character/character_resource_state_data.dart' as _i21;
import 'data/general/character/character_resource_view_data.dart' as _i22;
import 'data/general/character/character_saving_throw_proficiency_override_data.dart'
    as _i23;
import 'data/general/character/character_semantic_action_data.dart' as _i24;
import 'data/general/character/character_skill_proficiency_state.dart' as _i25;
import 'data/general/character/character_skill_selection_data.dart' as _i26;
import 'data/general/character/character_spell_selection_data.dart' as _i27;
import 'data/general/character/character_starting_equipment_resolution_data.dart'
    as _i28;
import 'data/general/character/character_starting_equipment_selection_data.dart'
    as _i29;
import 'data/general/character/character_sync_operation_data.dart' as _i30;
import 'data/general/character/character_sync_request.dart' as _i31;
import 'data/general/character/character_sync_response.dart' as _i32;
import 'data/general/character/character_sync_result.dart' as _i33;
import 'data/general/character/character_sync_status.dart' as _i34;
import 'data/general/character/character_sync_value_data.dart' as _i35;
import 'data/general/character/character_tool_proficiency_overrides_data.dart'
    as _i36;
import 'data/general/character/character_weapon_proficiency_overrides_data.dart'
    as _i37;
import 'data/general/character/choice_replacement_history_data.dart' as _i38;
import 'data/general/character/level_up_choice_replacement_data.dart' as _i39;
import 'data/general/character/level_up_request.dart' as _i40;
import 'data/general/character/level_up_spell_choice.dart' as _i41;
import 'data/general/character/related_feature_view_data.dart' as _i42;
import 'data/general/character/spell_selection_replacement_history_data.dart'
    as _i43;
import 'data/general/character/spell_slot_recovery_trigger_data.dart' as _i44;
import 'data/general/choice_group_data.dart' as _i45;
import 'data/general/choice_option_data.dart' as _i46;
import 'data/general/choice_requirement_data.dart' as _i47;
import 'data/general/class/class_data.dart' as _i48;
import 'data/general/class/class_feature_data.dart' as _i49;
import 'data/general/class/class_level_data.dart' as _i50;
import 'data/general/class/prepared_spell_rule_data.dart' as _i51;
import 'data/general/class/spell_slot_progression_data.dart' as _i52;
import 'data/general/class/starting_equipment_block_data.dart' as _i53;
import 'data/general/class/starting_equipment_entry_data.dart' as _i54;
import 'data/general/class/starting_equipment_line_data.dart' as _i55;
import 'data/general/class/starting_equipment_option_data.dart' as _i56;
import 'auth/auth_action_result.dart' as _i57;
import 'data/general/class/subclass_feature_data.dart' as _i58;
import 'data/general/feature_display_property_data.dart' as _i59;
import 'data/general/feature_modifier_condition_data.dart' as _i60;
import 'data/general/feature_modifier_data.dart' as _i61;
import 'data/general/feature_modifier_value_data.dart' as _i62;
import 'data/general/feature_relation_data.dart' as _i63;
import 'data/general/feature_resource_definition_data.dart' as _i64;
import 'data/general/feature_resource_effect_data.dart' as _i65;
import 'data/general/feature_resource_progression_value_data.dart' as _i66;
import 'data/general/race/race_data.dart' as _i67;
import 'data/general/race/race_feature_data.dart' as _i68;
import 'data/general/race/race_feature_spell_grant_data.dart' as _i69;
import 'data/general/race/subrace_data.dart' as _i70;
import 'data/general/spell_activation_data.dart' as _i71;
import 'data/general/spell_resource_upcast_policy_data.dart' as _i72;
import 'data/general/spell_selection_filter_data.dart' as _i73;
import 'data/general/spell_slot_recovery_policy_data.dart' as _i74;
import 'data/general/tool_data.dart' as _i75;
import 'data/items/armor_data.dart' as _i76;
import 'data/items/item_data.dart' as _i77;
import 'data/items/magic_item_data.dart' as _i78;
import 'data/items/weapon_data.dart' as _i79;
import 'data/spell_data.dart' as _i80;
import 'data/spell_scaling_data.dart' as _i81;
import 'dungeon_master/dm_creature_exception.dart' as _i82;
import 'dungeon_master/dm_creature_import_result.dart' as _i83;
import 'dungeon_master/dm_creature_record.dart' as _i84;
import 'dungeon_master/dm_creature_summary.dart' as _i85;
import 'enums/ability.dart' as _i86;
import 'enums/armor_category.dart' as _i87;
import 'enums/character_alignment.dart' as _i88;
import 'enums/character_change_type.dart' as _i89;
import 'enums/character_entity_type.dart' as _i90;
import 'enums/character_feature_source_type.dart' as _i91;
import 'enums/character_inventory_item_type.dart' as _i92;
import 'enums/character_saving_throw_proficiency_override.dart' as _i93;
import 'enums/character_skill_proficiency_level.dart' as _i94;
import 'enums/character_skill_selection_kind.dart' as _i95;
import 'enums/character_speed_kind.dart' as _i96;
import 'enums/character_spell_selection_kind.dart' as _i97;
import 'enums/character_sync_operation_type.dart' as _i98;
import 'enums/character_sync_target_type.dart' as _i99;
import 'enums/choice_requirement_type.dart' as _i100;
import 'enums/choice_source_type.dart' as _i101;
import 'enums/choice_type.dart' as _i102;
import 'enums/class_spell_selection_mode.dart' as _i103;
import 'enums/condition_type.dart' as _i104;
import 'enums/creature_size.dart' as _i105;
import 'enums/damage_type.dart' as _i106;
import 'enums/equipment_catalog_type.dart' as _i107;
import 'enums/feature_display_property_value_kind.dart' as _i108;
import 'enums/feature_modifier_condition_type.dart' as _i109;
import 'enums/feature_modifier_operation.dart' as _i110;
import 'views/starting_equipment_option_view.dart' as _i111;
import 'enums/feature_modifier_target.dart' as _i112;
import 'enums/feature_modifier_value_kind.dart' as _i113;
import 'enums/feature_relation_type.dart' as _i114;
import 'enums/feature_resource_effect_type.dart' as _i115;
import 'enums/feature_resource_kind.dart' as _i116;
import 'enums/feature_resource_max_rule.dart' as _i117;
import 'enums/feature_resource_progression_key.dart' as _i118;
import 'enums/feature_resource_target_type.dart' as _i119;
import 'enums/feature_resource_trigger.dart' as _i120;
import 'enums/feature_tag.dart' as _i121;
import 'enums/hit_point_mode.dart' as _i122;
import 'enums/language.dart' as _i123;
import 'enums/prepared_spell_rounding.dart' as _i124;
import 'enums/rest_type.dart' as _i125;
import 'enums/sense_type.dart' as _i126;
import 'enums/skill.dart' as _i127;
import 'enums/spell/area_of_effect_type.dart' as _i128;
import 'enums/spell/area_size_measurement.dart' as _i129;
import 'enums/spell/spell_attack_type.dart' as _i130;
import 'enums/spell/spell_duration_type.dart' as _i131;
import 'enums/spell/spell_scaling_mode.dart' as _i132;
import 'enums/spell/spell_school.dart' as _i133;
import 'enums/spell/spell_target_type.dart' as _i134;
import 'enums/spell_slot_recovery_mode.dart' as _i135;
import 'enums/spellcasting_progression.dart' as _i136;
import 'enums/starting_equipment_block_kind.dart' as _i137;
import 'enums/starting_equipment_entry_kind.dart' as _i138;
import 'enums/starting_equipment_line_kind.dart' as _i139;
import 'enums/tool_category.dart' as _i140;
import 'enums/unarmored_defense_rule.dart' as _i141;
import 'enums/weapon_category.dart' as _i142;
import 'enums/weapon_property.dart' as _i143;
import 'requests/level_down_choice_repair.dart' as _i144;
import 'requests/level_down_request.dart' as _i145;
import 'views/background_step_view.dart' as _i146;
import 'views/character_equipment_entry_view.dart' as _i147;
import 'views/choice_group_view.dart' as _i148;
import 'views/choice_option_eligibility_view.dart' as _i149;
import 'views/choice_requirement_failure_view.dart' as _i150;
import 'views/class_spell_delta_view.dart' as _i151;
import 'views/class_spell_selection_group_view.dart' as _i152;
import 'views/class_step_feature_view.dart' as _i153;
import 'views/class_step_subclass_choice_view.dart' as _i154;
import 'views/class_step_view.dart' as _i155;
import 'views/feature_display_property_view.dart' as _i156;
import 'views/level_down_invalid_choice_view.dart' as _i157;
import 'views/level_down_preview.dart' as _i158;
import 'views/level_up_preview.dart' as _i159;
import 'views/proficiency_bundle_view.dart' as _i160;
import 'views/race_step_view.dart' as _i161;
import 'views/resolved_character_spell_data.dart' as _i162;
import 'views/selected_feature_choice_view.dart' as _i163;
import 'views/skill_selection_group_view.dart' as _i164;
import 'views/spell_source_context_data.dart' as _i165;
import 'views/starting_equipment_block_view.dart' as _i166;
import 'enums/feature_modifier_rounding.dart' as _i167;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i168;
import 'package:characters_mirror_client/src/protocol/dungeon_master/dm_creature_summary.dart'
    as _i169;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i170;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i171;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i172;
import 'package:characters_mirror_client/src/protocol/data/general/choice_group_data.dart'
    as _i173;
import 'package:characters_mirror_client/src/protocol/data/general/choice_option_data.dart'
    as _i174;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i175;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i176;
import 'package:characters_mirror_client/src/protocol/data/class_spell_grant_data.dart'
    as _i177;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _i178;
import 'package:characters_mirror_client/src/protocol/data/general/class/spell_slot_progression_data.dart'
    as _i179;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i180;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i181;
import 'package:characters_mirror_client/src/protocol/data/general/feature_relation_data.dart'
    as _i182;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i183;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i184;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i185;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i186;
import 'package:characters_mirror_client/src/protocol/data/general/tool_data.dart'
    as _i187;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i188;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i189;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i190;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i191;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i192;
export 'auth/auth_action_result.dart';
export 'data/background_data.dart';
export 'data/class_spell_grant_data.dart';
export 'data/damage_part_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_armor_training_overrides_data.dart';
export 'data/general/character/character_attack_data.dart';
export 'data/general/character/character_change_data.dart';
export 'data/general/character/character_choice_data.dart';
export 'data/general/character/character_class_entry_data.dart';
export 'data/general/character/character_data.dart';
export 'data/general/character/character_derived_data.dart';
export 'data/general/character/character_equipment_selection_data.dart';
export 'data/general/character/character_feature_override_data.dart';
export 'data/general/character/character_feature_view_data.dart';
export 'data/general/character/character_inventory_item_data.dart';
export 'data/general/character/character_language_overrides_data.dart';
export 'data/general/character/character_note_data.dart';
export 'data/general/character/character_rejected_change_data.dart';
export 'data/general/character/character_resource_state_data.dart';
export 'data/general/character/character_resource_view_data.dart';
export 'data/general/character/character_saving_throw_proficiency_override_data.dart';
export 'data/general/character/character_semantic_action_data.dart';
export 'data/general/character/character_skill_proficiency_state.dart';
export 'data/general/character/character_skill_selection_data.dart';
export 'data/general/character/character_spell_selection_data.dart';
export 'data/general/character/character_starting_equipment_resolution_data.dart';
export 'data/general/character/character_starting_equipment_selection_data.dart';
export 'data/general/character/character_sync_operation_data.dart';
export 'data/general/character/character_sync_request.dart';
export 'data/general/character/character_sync_response.dart';
export 'data/general/character/character_sync_result.dart';
export 'data/general/character/character_sync_status.dart';
export 'data/general/character/character_sync_value_data.dart';
export 'data/general/character/character_tool_proficiency_overrides_data.dart';
export 'data/general/character/character_weapon_proficiency_overrides_data.dart';
export 'data/general/character/choice_replacement_history_data.dart';
export 'data/general/character/level_up_choice_replacement_data.dart';
export 'data/general/character/level_up_request.dart';
export 'data/general/character/level_up_spell_choice.dart';
export 'data/general/character/related_feature_view_data.dart';
export 'data/general/character/spell_selection_replacement_history_data.dart';
export 'data/general/character/spell_slot_recovery_trigger_data.dart';
export 'data/general/choice_group_data.dart';
export 'data/general/choice_option_data.dart';
export 'data/general/choice_requirement_data.dart';
export 'data/general/class/class_data.dart';
export 'data/general/class/class_feature_data.dart';
export 'data/general/class/class_level_data.dart';
export 'data/general/class/prepared_spell_rule_data.dart';
export 'data/general/class/spell_slot_progression_data.dart';
export 'data/general/class/starting_equipment_block_data.dart';
export 'data/general/class/starting_equipment_entry_data.dart';
export 'data/general/class/starting_equipment_line_data.dart';
export 'data/general/class/starting_equipment_option_data.dart';
export 'data/general/class/subclass_data.dart';
export 'data/general/class/subclass_feature_data.dart';
export 'data/general/feature_display_property_data.dart';
export 'data/general/feature_modifier_condition_data.dart';
export 'data/general/feature_modifier_data.dart';
export 'data/general/feature_modifier_value_data.dart';
export 'data/general/feature_relation_data.dart';
export 'data/general/feature_resource_definition_data.dart';
export 'data/general/feature_resource_effect_data.dart';
export 'data/general/feature_resource_progression_value_data.dart';
export 'data/general/race/race_data.dart';
export 'data/general/race/race_feature_data.dart';
export 'data/general/race/race_feature_spell_grant_data.dart';
export 'data/general/race/subrace_data.dart';
export 'data/general/spell_activation_data.dart';
export 'data/general/spell_resource_upcast_policy_data.dart';
export 'data/general/spell_selection_filter_data.dart';
export 'data/general/spell_slot_recovery_policy_data.dart';
export 'data/general/tool_data.dart';
export 'data/items/armor_data.dart';
export 'data/items/item_data.dart';
export 'data/items/magic_item_data.dart';
export 'data/items/weapon_data.dart';
export 'data/spell_data.dart';
export 'data/spell_scaling_data.dart';
export 'dungeon_master/dm_creature_exception.dart';
export 'dungeon_master/dm_creature_import_result.dart';
export 'dungeon_master/dm_creature_record.dart';
export 'dungeon_master/dm_creature_summary.dart';
export 'enums/ability.dart';
export 'enums/armor_category.dart';
export 'enums/character_alignment.dart';
export 'enums/character_change_type.dart';
export 'enums/character_entity_type.dart';
export 'enums/character_feature_source_type.dart';
export 'enums/character_inventory_item_type.dart';
export 'enums/character_saving_throw_proficiency_override.dart';
export 'enums/character_skill_proficiency_level.dart';
export 'enums/character_skill_selection_kind.dart';
export 'enums/character_speed_kind.dart';
export 'enums/character_spell_selection_kind.dart';
export 'enums/character_sync_operation_type.dart';
export 'enums/character_sync_target_type.dart';
export 'enums/choice_requirement_type.dart';
export 'enums/choice_source_type.dart';
export 'enums/choice_type.dart';
export 'enums/class_spell_selection_mode.dart';
export 'enums/condition_type.dart';
export 'enums/creature_size.dart';
export 'enums/damage_type.dart';
export 'enums/equipment_catalog_type.dart';
export 'enums/feature_display_property_value_kind.dart';
export 'enums/feature_modifier_condition_type.dart';
export 'enums/feature_modifier_operation.dart';
export 'enums/feature_modifier_rounding.dart';
export 'enums/feature_modifier_target.dart';
export 'enums/feature_modifier_value_kind.dart';
export 'enums/feature_relation_type.dart';
export 'enums/feature_resource_effect_type.dart';
export 'enums/feature_resource_kind.dart';
export 'enums/feature_resource_max_rule.dart';
export 'enums/feature_resource_progression_key.dart';
export 'enums/feature_resource_target_type.dart';
export 'enums/feature_resource_trigger.dart';
export 'enums/feature_tag.dart';
export 'enums/hit_point_mode.dart';
export 'enums/language.dart';
export 'enums/prepared_spell_rounding.dart';
export 'enums/rest_type.dart';
export 'enums/sense_type.dart';
export 'enums/skill.dart';
export 'enums/spell/area_of_effect_type.dart';
export 'enums/spell/area_size_measurement.dart';
export 'enums/spell/spell_attack_type.dart';
export 'enums/spell/spell_duration_type.dart';
export 'enums/spell/spell_scaling_mode.dart';
export 'enums/spell/spell_school.dart';
export 'enums/spell/spell_target_type.dart';
export 'enums/spell_slot_recovery_mode.dart';
export 'enums/spellcasting_progression.dart';
export 'enums/starting_equipment_block_kind.dart';
export 'enums/starting_equipment_entry_kind.dart';
export 'enums/starting_equipment_line_kind.dart';
export 'enums/tool_category.dart';
export 'enums/unarmored_defense_rule.dart';
export 'enums/weapon_category.dart';
export 'enums/weapon_property.dart';
export 'requests/level_down_choice_repair.dart';
export 'requests/level_down_request.dart';
export 'views/background_step_view.dart';
export 'views/character_equipment_entry_view.dart';
export 'views/choice_group_view.dart';
export 'views/choice_option_eligibility_view.dart';
export 'views/choice_requirement_failure_view.dart';
export 'views/class_spell_delta_view.dart';
export 'views/class_spell_selection_group_view.dart';
export 'views/class_step_feature_view.dart';
export 'views/class_step_subclass_choice_view.dart';
export 'views/class_step_view.dart';
export 'views/feature_display_property_view.dart';
export 'views/level_down_invalid_choice_view.dart';
export 'views/level_down_preview.dart';
export 'views/level_up_preview.dart';
export 'views/proficiency_bundle_view.dart';
export 'views/race_step_view.dart';
export 'views/resolved_character_spell_data.dart';
export 'views/selected_feature_choice_view.dart';
export 'views/skill_selection_group_view.dart';
export 'views/spell_source_context_data.dart';
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
    if (t == _i2.SubclassData) {
      return _i2.SubclassData.fromJson(data) as T;
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
    if (t == _i7.CharacterArmorTrainingOverridesData) {
      return _i7.CharacterArmorTrainingOverridesData.fromJson(data) as T;
    }
    if (t == _i8.CharacterAttackData) {
      return _i8.CharacterAttackData.fromJson(data) as T;
    }
    if (t == _i9.CharacterChangeData) {
      return _i9.CharacterChangeData.fromJson(data) as T;
    }
    if (t == _i10.CharacterChoiceData) {
      return _i10.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i11.CharacterClassEntryData) {
      return _i11.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i12.CharacterData) {
      return _i12.CharacterData.fromJson(data) as T;
    }
    if (t == _i13.CharacterDerivedData) {
      return _i13.CharacterDerivedData.fromJson(data) as T;
    }
    if (t == _i14.CharacterEquipmentSelectionData) {
      return _i14.CharacterEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _i15.CharacterFeatureOverrideData) {
      return _i15.CharacterFeatureOverrideData.fromJson(data) as T;
    }
    if (t == _i16.CharacterFeatureViewData) {
      return _i16.CharacterFeatureViewData.fromJson(data) as T;
    }
    if (t == _i17.CharacterInventoryItemData) {
      return _i17.CharacterInventoryItemData.fromJson(data) as T;
    }
    if (t == _i18.CharacterLanguageOverridesData) {
      return _i18.CharacterLanguageOverridesData.fromJson(data) as T;
    }
    if (t == _i19.CharacterNoteData) {
      return _i19.CharacterNoteData.fromJson(data) as T;
    }
    if (t == _i20.CharacterRejectedChangeData) {
      return _i20.CharacterRejectedChangeData.fromJson(data) as T;
    }
    if (t == _i21.CharacterResourceStateData) {
      return _i21.CharacterResourceStateData.fromJson(data) as T;
    }
    if (t == _i22.CharacterResourceViewData) {
      return _i22.CharacterResourceViewData.fromJson(data) as T;
    }
    if (t == _i23.CharacterSavingThrowProficiencyOverrideData) {
      return _i23.CharacterSavingThrowProficiencyOverrideData.fromJson(data)
          as T;
    }
    if (t == _i24.CharacterSemanticActionData) {
      return _i24.CharacterSemanticActionData.fromJson(data) as T;
    }
    if (t == _i25.CharacterSkillProficiencyState) {
      return _i25.CharacterSkillProficiencyState.fromJson(data) as T;
    }
    if (t == _i26.CharacterSkillSelectionData) {
      return _i26.CharacterSkillSelectionData.fromJson(data) as T;
    }
    if (t == _i27.CharacterSpellSelectionData) {
      return _i27.CharacterSpellSelectionData.fromJson(data) as T;
    }
    if (t == _i28.CharacterStartingEquipmentResolutionData) {
      return _i28.CharacterStartingEquipmentResolutionData.fromJson(data) as T;
    }
    if (t == _i29.CharacterStartingEquipmentSelectionData) {
      return _i29.CharacterStartingEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _i30.CharacterSyncOperationData) {
      return _i30.CharacterSyncOperationData.fromJson(data) as T;
    }
    if (t == _i31.CharacterSyncRequest) {
      return _i31.CharacterSyncRequest.fromJson(data) as T;
    }
    if (t == _i32.CharacterSyncResponse) {
      return _i32.CharacterSyncResponse.fromJson(data) as T;
    }
    if (t == _i33.CharacterSyncResult) {
      return _i33.CharacterSyncResult.fromJson(data) as T;
    }
    if (t == _i34.CharacterSyncStatus) {
      return _i34.CharacterSyncStatus.fromJson(data) as T;
    }
    if (t == _i35.CharacterSyncValueData) {
      return _i35.CharacterSyncValueData.fromJson(data) as T;
    }
    if (t == _i36.CharacterToolProficiencyOverridesData) {
      return _i36.CharacterToolProficiencyOverridesData.fromJson(data) as T;
    }
    if (t == _i37.CharacterWeaponProficiencyOverridesData) {
      return _i37.CharacterWeaponProficiencyOverridesData.fromJson(data) as T;
    }
    if (t == _i38.ChoiceReplacementHistoryData) {
      return _i38.ChoiceReplacementHistoryData.fromJson(data) as T;
    }
    if (t == _i39.LevelUpChoiceReplacementData) {
      return _i39.LevelUpChoiceReplacementData.fromJson(data) as T;
    }
    if (t == _i40.LevelUpRequest) {
      return _i40.LevelUpRequest.fromJson(data) as T;
    }
    if (t == _i41.LevelUpSpellChoice) {
      return _i41.LevelUpSpellChoice.fromJson(data) as T;
    }
    if (t == _i42.RelatedFeatureViewData) {
      return _i42.RelatedFeatureViewData.fromJson(data) as T;
    }
    if (t == _i43.SpellSelectionReplacementHistoryData) {
      return _i43.SpellSelectionReplacementHistoryData.fromJson(data) as T;
    }
    if (t == _i44.SpellSlotRecoveryTriggerData) {
      return _i44.SpellSlotRecoveryTriggerData.fromJson(data) as T;
    }
    if (t == _i45.ChoiceGroupData) {
      return _i45.ChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i46.ChoiceOptionData) {
      return _i46.ChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i47.ChoiceRequirementData) {
      return _i47.ChoiceRequirementData.fromJson(data) as T;
    }
    if (t == _i48.ClassData) {
      return _i48.ClassData.fromJson(data) as T;
    }
    if (t == _i49.ClassFeatureData) {
      return _i49.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i50.ClassLevelData) {
      return _i50.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i51.PreparedSpellRuleData) {
      return _i51.PreparedSpellRuleData.fromJson(data) as T;
    }
    if (t == _i52.SpellSlotProgressionData) {
      return _i52.SpellSlotProgressionData.fromJson(data) as T;
    }
    if (t == _i53.StartingEquipmentBlockData) {
      return _i53.StartingEquipmentBlockData.fromJson(data) as T;
    }
    if (t == _i54.StartingEquipmentEntryData) {
      return _i54.StartingEquipmentEntryData.fromJson(data) as T;
    }
    if (t == _i55.StartingEquipmentLineData) {
      return _i55.StartingEquipmentLineData.fromJson(data) as T;
    }
    if (t == _i56.StartingEquipmentOptionData) {
      return _i56.StartingEquipmentOptionData.fromJson(data) as T;
    }
    if (t == _i57.AuthActionResult) {
      return _i57.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i58.SubclassFeatureData) {
      return _i58.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i59.FeatureDisplayPropertyData) {
      return _i59.FeatureDisplayPropertyData.fromJson(data) as T;
    }
    if (t == _i60.FeatureModifierConditionData) {
      return _i60.FeatureModifierConditionData.fromJson(data) as T;
    }
    if (t == _i61.FeatureModifierData) {
      return _i61.FeatureModifierData.fromJson(data) as T;
    }
    if (t == _i62.FeatureModifierValueData) {
      return _i62.FeatureModifierValueData.fromJson(data) as T;
    }
    if (t == _i63.FeatureRelationData) {
      return _i63.FeatureRelationData.fromJson(data) as T;
    }
    if (t == _i64.FeatureResourceDefinitionData) {
      return _i64.FeatureResourceDefinitionData.fromJson(data) as T;
    }
    if (t == _i65.FeatureResourceEffectData) {
      return _i65.FeatureResourceEffectData.fromJson(data) as T;
    }
    if (t == _i66.FeatureResourceProgressionValueData) {
      return _i66.FeatureResourceProgressionValueData.fromJson(data) as T;
    }
    if (t == _i67.RaceData) {
      return _i67.RaceData.fromJson(data) as T;
    }
    if (t == _i68.RaceFeatureData) {
      return _i68.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i69.RaceFeatureSpellGrantData) {
      return _i69.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _i70.SubraceData) {
      return _i70.SubraceData.fromJson(data) as T;
    }
    if (t == _i71.SpellActivationData) {
      return _i71.SpellActivationData.fromJson(data) as T;
    }
    if (t == _i72.SpellResourceUpcastPolicyData) {
      return _i72.SpellResourceUpcastPolicyData.fromJson(data) as T;
    }
    if (t == _i73.SpellSelectionFilterData) {
      return _i73.SpellSelectionFilterData.fromJson(data) as T;
    }
    if (t == _i74.SpellSlotRecoveryPolicyData) {
      return _i74.SpellSlotRecoveryPolicyData.fromJson(data) as T;
    }
    if (t == _i75.ToolData) {
      return _i75.ToolData.fromJson(data) as T;
    }
    if (t == _i76.ArmorData) {
      return _i76.ArmorData.fromJson(data) as T;
    }
    if (t == _i77.ItemData) {
      return _i77.ItemData.fromJson(data) as T;
    }
    if (t == _i78.MagicItemData) {
      return _i78.MagicItemData.fromJson(data) as T;
    }
    if (t == _i79.WeaponData) {
      return _i79.WeaponData.fromJson(data) as T;
    }
    if (t == _i80.SpellData) {
      return _i80.SpellData.fromJson(data) as T;
    }
    if (t == _i81.SpellScalingData) {
      return _i81.SpellScalingData.fromJson(data) as T;
    }
    if (t == _i82.DmCreatureException) {
      return _i82.DmCreatureException.fromJson(data) as T;
    }
    if (t == _i83.DmCreatureImportResult) {
      return _i83.DmCreatureImportResult.fromJson(data) as T;
    }
    if (t == _i84.DmCreatureRecord) {
      return _i84.DmCreatureRecord.fromJson(data) as T;
    }
    if (t == _i85.DmCreatureSummary) {
      return _i85.DmCreatureSummary.fromJson(data) as T;
    }
    if (t == _i86.Ability) {
      return _i86.Ability.fromJson(data) as T;
    }
    if (t == _i87.ArmorCategory) {
      return _i87.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i88.CharacterAlignment) {
      return _i88.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i89.CharacterChangeType) {
      return _i89.CharacterChangeType.fromJson(data) as T;
    }
    if (t == _i90.CharacterEntityType) {
      return _i90.CharacterEntityType.fromJson(data) as T;
    }
    if (t == _i91.CharacterFeatureSourceType) {
      return _i91.CharacterFeatureSourceType.fromJson(data) as T;
    }
    if (t == _i92.CharacterInventoryItemType) {
      return _i92.CharacterInventoryItemType.fromJson(data) as T;
    }
    if (t == _i93.CharacterSavingThrowProficiencyOverride) {
      return _i93.CharacterSavingThrowProficiencyOverride.fromJson(data) as T;
    }
    if (t == _i94.CharacterSkillProficiencyLevel) {
      return _i94.CharacterSkillProficiencyLevel.fromJson(data) as T;
    }
    if (t == _i95.CharacterSkillSelectionKind) {
      return _i95.CharacterSkillSelectionKind.fromJson(data) as T;
    }
    if (t == _i96.CharacterSpeedKind) {
      return _i96.CharacterSpeedKind.fromJson(data) as T;
    }
    if (t == _i97.CharacterSpellSelectionKind) {
      return _i97.CharacterSpellSelectionKind.fromJson(data) as T;
    }
    if (t == _i98.CharacterSyncOperationType) {
      return _i98.CharacterSyncOperationType.fromJson(data) as T;
    }
    if (t == _i99.CharacterSyncTargetType) {
      return _i99.CharacterSyncTargetType.fromJson(data) as T;
    }
    if (t == _i100.ChoiceRequirementType) {
      return _i100.ChoiceRequirementType.fromJson(data) as T;
    }
    if (t == _i101.ChoiceSourceType) {
      return _i101.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i102.ChoiceType) {
      return _i102.ChoiceType.fromJson(data) as T;
    }
    if (t == _i103.ClassSpellSelectionMode) {
      return _i103.ClassSpellSelectionMode.fromJson(data) as T;
    }
    if (t == _i104.ConditionType) {
      return _i104.ConditionType.fromJson(data) as T;
    }
    if (t == _i105.CreatureSize) {
      return _i105.CreatureSize.fromJson(data) as T;
    }
    if (t == _i106.DamageType) {
      return _i106.DamageType.fromJson(data) as T;
    }
    if (t == _i107.EquipmentCatalogType) {
      return _i107.EquipmentCatalogType.fromJson(data) as T;
    }
    if (t == _i108.FeatureDisplayPropertyValueKind) {
      return _i108.FeatureDisplayPropertyValueKind.fromJson(data) as T;
    }
    if (t == _i109.FeatureModifierConditionType) {
      return _i109.FeatureModifierConditionType.fromJson(data) as T;
    }
    if (t == _i110.FeatureModifierOperation) {
      return _i110.FeatureModifierOperation.fromJson(data) as T;
    }
    if (t == _i111.StartingEquipmentOptionView) {
      return _i111.StartingEquipmentOptionView.fromJson(data) as T;
    }
    if (t == _i112.FeatureModifierTarget) {
      return _i112.FeatureModifierTarget.fromJson(data) as T;
    }
    if (t == _i113.FeatureModifierValueKind) {
      return _i113.FeatureModifierValueKind.fromJson(data) as T;
    }
    if (t == _i114.FeatureRelationType) {
      return _i114.FeatureRelationType.fromJson(data) as T;
    }
    if (t == _i115.FeatureResourceEffectType) {
      return _i115.FeatureResourceEffectType.fromJson(data) as T;
    }
    if (t == _i116.FeatureResourceKind) {
      return _i116.FeatureResourceKind.fromJson(data) as T;
    }
    if (t == _i117.FeatureResourceMaxRule) {
      return _i117.FeatureResourceMaxRule.fromJson(data) as T;
    }
    if (t == _i118.FeatureResourceProgressionKey) {
      return _i118.FeatureResourceProgressionKey.fromJson(data) as T;
    }
    if (t == _i119.FeatureResourceTargetType) {
      return _i119.FeatureResourceTargetType.fromJson(data) as T;
    }
    if (t == _i120.FeatureResourceTrigger) {
      return _i120.FeatureResourceTrigger.fromJson(data) as T;
    }
    if (t == _i121.FeatureTag) {
      return _i121.FeatureTag.fromJson(data) as T;
    }
    if (t == _i122.HitPointMode) {
      return _i122.HitPointMode.fromJson(data) as T;
    }
    if (t == _i123.Language) {
      return _i123.Language.fromJson(data) as T;
    }
    if (t == _i124.PreparedSpellRounding) {
      return _i124.PreparedSpellRounding.fromJson(data) as T;
    }
    if (t == _i125.RestType) {
      return _i125.RestType.fromJson(data) as T;
    }
    if (t == _i126.SenseType) {
      return _i126.SenseType.fromJson(data) as T;
    }
    if (t == _i127.Skill) {
      return _i127.Skill.fromJson(data) as T;
    }
    if (t == _i128.AreaOfEffectType) {
      return _i128.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _i129.AreaSizeMeasurement) {
      return _i129.AreaSizeMeasurement.fromJson(data) as T;
    }
    if (t == _i130.SpellAttackType) {
      return _i130.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i131.SpellDurationType) {
      return _i131.SpellDurationType.fromJson(data) as T;
    }
    if (t == _i132.SpellScalingMode) {
      return _i132.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _i133.SpellSchool) {
      return _i133.SpellSchool.fromJson(data) as T;
    }
    if (t == _i134.SpellTargetType) {
      return _i134.SpellTargetType.fromJson(data) as T;
    }
    if (t == _i135.SpellSlotRecoveryMode) {
      return _i135.SpellSlotRecoveryMode.fromJson(data) as T;
    }
    if (t == _i136.SpellcastingProgression) {
      return _i136.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i137.StartingEquipmentBlockKind) {
      return _i137.StartingEquipmentBlockKind.fromJson(data) as T;
    }
    if (t == _i138.StartingEquipmentEntryKind) {
      return _i138.StartingEquipmentEntryKind.fromJson(data) as T;
    }
    if (t == _i139.StartingEquipmentLineKind) {
      return _i139.StartingEquipmentLineKind.fromJson(data) as T;
    }
    if (t == _i140.ToolCategory) {
      return _i140.ToolCategory.fromJson(data) as T;
    }
    if (t == _i141.UnarmoredDefenseRule) {
      return _i141.UnarmoredDefenseRule.fromJson(data) as T;
    }
    if (t == _i142.WeaponCategory) {
      return _i142.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i143.WeaponProperty) {
      return _i143.WeaponProperty.fromJson(data) as T;
    }
    if (t == _i144.LevelDownChoiceRepair) {
      return _i144.LevelDownChoiceRepair.fromJson(data) as T;
    }
    if (t == _i145.LevelDownRequest) {
      return _i145.LevelDownRequest.fromJson(data) as T;
    }
    if (t == _i146.BackgroundStepView) {
      return _i146.BackgroundStepView.fromJson(data) as T;
    }
    if (t == _i147.CharacterEquipmentEntryView) {
      return _i147.CharacterEquipmentEntryView.fromJson(data) as T;
    }
    if (t == _i148.ChoiceGroupView) {
      return _i148.ChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i149.ChoiceOptionEligibilityView) {
      return _i149.ChoiceOptionEligibilityView.fromJson(data) as T;
    }
    if (t == _i150.ChoiceRequirementFailureView) {
      return _i150.ChoiceRequirementFailureView.fromJson(data) as T;
    }
    if (t == _i151.ClassSpellDeltaView) {
      return _i151.ClassSpellDeltaView.fromJson(data) as T;
    }
    if (t == _i152.ClassSpellSelectionGroupView) {
      return _i152.ClassSpellSelectionGroupView.fromJson(data) as T;
    }
    if (t == _i153.ClassStepFeatureView) {
      return _i153.ClassStepFeatureView.fromJson(data) as T;
    }
    if (t == _i154.ClassStepSubclassChoiceView) {
      return _i154.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i155.ClassStepView) {
      return _i155.ClassStepView.fromJson(data) as T;
    }
    if (t == _i156.FeatureDisplayPropertyView) {
      return _i156.FeatureDisplayPropertyView.fromJson(data) as T;
    }
    if (t == _i157.LevelDownInvalidChoiceView) {
      return _i157.LevelDownInvalidChoiceView.fromJson(data) as T;
    }
    if (t == _i158.LevelDownPreview) {
      return _i158.LevelDownPreview.fromJson(data) as T;
    }
    if (t == _i159.LevelUpPreview) {
      return _i159.LevelUpPreview.fromJson(data) as T;
    }
    if (t == _i160.ProficiencyBundleView) {
      return _i160.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i161.RaceStepView) {
      return _i161.RaceStepView.fromJson(data) as T;
    }
    if (t == _i162.ResolvedCharacterSpellData) {
      return _i162.ResolvedCharacterSpellData.fromJson(data) as T;
    }
    if (t == _i163.SelectedFeatureChoiceView) {
      return _i163.SelectedFeatureChoiceView.fromJson(data) as T;
    }
    if (t == _i164.SkillSelectionGroupView) {
      return _i164.SkillSelectionGroupView.fromJson(data) as T;
    }
    if (t == _i165.SpellSourceContextData) {
      return _i165.SpellSourceContextData.fromJson(data) as T;
    }
    if (t == _i166.StartingEquipmentBlockView) {
      return _i166.StartingEquipmentBlockView.fromJson(data) as T;
    }
    if (t == _i167.FeatureModifierRounding) {
      return _i167.FeatureModifierRounding.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.SubclassData?>()) {
      return (data != null ? _i2.SubclassData.fromJson(data) : null) as T;
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
    if (t == _i1.getType<_i7.CharacterArmorTrainingOverridesData?>()) {
      return (data != null
          ? _i7.CharacterArmorTrainingOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i8.CharacterAttackData?>()) {
      return (data != null ? _i8.CharacterAttackData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.CharacterChangeData?>()) {
      return (data != null ? _i9.CharacterChangeData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.CharacterChoiceData?>()) {
      return (data != null ? _i10.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.CharacterClassEntryData?>()) {
      return (data != null ? _i11.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.CharacterData?>()) {
      return (data != null ? _i12.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CharacterDerivedData?>()) {
      return (data != null ? _i13.CharacterDerivedData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.CharacterEquipmentSelectionData?>()) {
      return (data != null
          ? _i14.CharacterEquipmentSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i15.CharacterFeatureOverrideData?>()) {
      return (data != null
          ? _i15.CharacterFeatureOverrideData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i16.CharacterFeatureViewData?>()) {
      return (data != null
          ? _i16.CharacterFeatureViewData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i17.CharacterInventoryItemData?>()) {
      return (data != null
          ? _i17.CharacterInventoryItemData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i18.CharacterLanguageOverridesData?>()) {
      return (data != null
          ? _i18.CharacterLanguageOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i19.CharacterNoteData?>()) {
      return (data != null ? _i19.CharacterNoteData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.CharacterRejectedChangeData?>()) {
      return (data != null
          ? _i20.CharacterRejectedChangeData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i21.CharacterResourceStateData?>()) {
      return (data != null
          ? _i21.CharacterResourceStateData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i22.CharacterResourceViewData?>()) {
      return (data != null
          ? _i22.CharacterResourceViewData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i23.CharacterSavingThrowProficiencyOverrideData?>()) {
      return (data != null
          ? _i23.CharacterSavingThrowProficiencyOverrideData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i24.CharacterSemanticActionData?>()) {
      return (data != null
          ? _i24.CharacterSemanticActionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i25.CharacterSkillProficiencyState?>()) {
      return (data != null
          ? _i25.CharacterSkillProficiencyState.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i26.CharacterSkillSelectionData?>()) {
      return (data != null
          ? _i26.CharacterSkillSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i27.CharacterSpellSelectionData?>()) {
      return (data != null
          ? _i27.CharacterSpellSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i28.CharacterStartingEquipmentResolutionData?>()) {
      return (data != null
          ? _i28.CharacterStartingEquipmentResolutionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i29.CharacterStartingEquipmentSelectionData?>()) {
      return (data != null
          ? _i29.CharacterStartingEquipmentSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i30.CharacterSyncOperationData?>()) {
      return (data != null
          ? _i30.CharacterSyncOperationData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i31.CharacterSyncRequest?>()) {
      return (data != null ? _i31.CharacterSyncRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.CharacterSyncResponse?>()) {
      return (data != null ? _i32.CharacterSyncResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.CharacterSyncResult?>()) {
      return (data != null ? _i33.CharacterSyncResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.CharacterSyncStatus?>()) {
      return (data != null ? _i34.CharacterSyncStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.CharacterSyncValueData?>()) {
      return (data != null ? _i35.CharacterSyncValueData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.CharacterToolProficiencyOverridesData?>()) {
      return (data != null
          ? _i36.CharacterToolProficiencyOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i37.CharacterWeaponProficiencyOverridesData?>()) {
      return (data != null
          ? _i37.CharacterWeaponProficiencyOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i38.ChoiceReplacementHistoryData?>()) {
      return (data != null
          ? _i38.ChoiceReplacementHistoryData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i39.LevelUpChoiceReplacementData?>()) {
      return (data != null
          ? _i39.LevelUpChoiceReplacementData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i40.LevelUpRequest?>()) {
      return (data != null ? _i40.LevelUpRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.LevelUpSpellChoice?>()) {
      return (data != null ? _i41.LevelUpSpellChoice.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.RelatedFeatureViewData?>()) {
      return (data != null ? _i42.RelatedFeatureViewData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.SpellSelectionReplacementHistoryData?>()) {
      return (data != null
          ? _i43.SpellSelectionReplacementHistoryData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i44.SpellSlotRecoveryTriggerData?>()) {
      return (data != null
          ? _i44.SpellSlotRecoveryTriggerData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i45.ChoiceGroupData?>()) {
      return (data != null ? _i45.ChoiceGroupData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.ChoiceOptionData?>()) {
      return (data != null ? _i46.ChoiceOptionData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.ChoiceRequirementData?>()) {
      return (data != null ? _i47.ChoiceRequirementData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i48.ClassData?>()) {
      return (data != null ? _i48.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.ClassFeatureData?>()) {
      return (data != null ? _i49.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.ClassLevelData?>()) {
      return (data != null ? _i50.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.PreparedSpellRuleData?>()) {
      return (data != null ? _i51.PreparedSpellRuleData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i52.SpellSlotProgressionData?>()) {
      return (data != null
          ? _i52.SpellSlotProgressionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i53.StartingEquipmentBlockData?>()) {
      return (data != null
          ? _i53.StartingEquipmentBlockData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i54.StartingEquipmentEntryData?>()) {
      return (data != null
          ? _i54.StartingEquipmentEntryData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i55.StartingEquipmentLineData?>()) {
      return (data != null
          ? _i55.StartingEquipmentLineData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i56.StartingEquipmentOptionData?>()) {
      return (data != null
          ? _i56.StartingEquipmentOptionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i57.AuthActionResult?>()) {
      return (data != null ? _i57.AuthActionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.SubclassFeatureData?>()) {
      return (data != null ? _i58.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i59.FeatureDisplayPropertyData?>()) {
      return (data != null
          ? _i59.FeatureDisplayPropertyData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i60.FeatureModifierConditionData?>()) {
      return (data != null
          ? _i60.FeatureModifierConditionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i61.FeatureModifierData?>()) {
      return (data != null ? _i61.FeatureModifierData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i62.FeatureModifierValueData?>()) {
      return (data != null
          ? _i62.FeatureModifierValueData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i63.FeatureRelationData?>()) {
      return (data != null ? _i63.FeatureRelationData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i64.FeatureResourceDefinitionData?>()) {
      return (data != null
          ? _i64.FeatureResourceDefinitionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i65.FeatureResourceEffectData?>()) {
      return (data != null
          ? _i65.FeatureResourceEffectData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i66.FeatureResourceProgressionValueData?>()) {
      return (data != null
          ? _i66.FeatureResourceProgressionValueData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i67.RaceData?>()) {
      return (data != null ? _i67.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.RaceFeatureData?>()) {
      return (data != null ? _i68.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.RaceFeatureSpellGrantData?>()) {
      return (data != null
          ? _i69.RaceFeatureSpellGrantData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i70.SubraceData?>()) {
      return (data != null ? _i70.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.SpellActivationData?>()) {
      return (data != null ? _i71.SpellActivationData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i72.SpellResourceUpcastPolicyData?>()) {
      return (data != null
          ? _i72.SpellResourceUpcastPolicyData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i73.SpellSelectionFilterData?>()) {
      return (data != null
          ? _i73.SpellSelectionFilterData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i74.SpellSlotRecoveryPolicyData?>()) {
      return (data != null
          ? _i74.SpellSlotRecoveryPolicyData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i75.ToolData?>()) {
      return (data != null ? _i75.ToolData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.ArmorData?>()) {
      return (data != null ? _i76.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.ItemData?>()) {
      return (data != null ? _i77.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.MagicItemData?>()) {
      return (data != null ? _i78.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.WeaponData?>()) {
      return (data != null ? _i79.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.SpellData?>()) {
      return (data != null ? _i80.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.SpellScalingData?>()) {
      return (data != null ? _i81.SpellScalingData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.DmCreatureException?>()) {
      return (data != null ? _i82.DmCreatureException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i83.DmCreatureImportResult?>()) {
      return (data != null ? _i83.DmCreatureImportResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i84.DmCreatureRecord?>()) {
      return (data != null ? _i84.DmCreatureRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.DmCreatureSummary?>()) {
      return (data != null ? _i85.DmCreatureSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i86.Ability?>()) {
      return (data != null ? _i86.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i87.ArmorCategory?>()) {
      return (data != null ? _i87.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i88.CharacterAlignment?>()) {
      return (data != null ? _i88.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i89.CharacterChangeType?>()) {
      return (data != null ? _i89.CharacterChangeType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i90.CharacterEntityType?>()) {
      return (data != null ? _i90.CharacterEntityType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i91.CharacterFeatureSourceType?>()) {
      return (data != null
          ? _i91.CharacterFeatureSourceType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i92.CharacterInventoryItemType?>()) {
      return (data != null
          ? _i92.CharacterInventoryItemType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i93.CharacterSavingThrowProficiencyOverride?>()) {
      return (data != null
          ? _i93.CharacterSavingThrowProficiencyOverride.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i94.CharacterSkillProficiencyLevel?>()) {
      return (data != null
          ? _i94.CharacterSkillProficiencyLevel.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i95.CharacterSkillSelectionKind?>()) {
      return (data != null
          ? _i95.CharacterSkillSelectionKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i96.CharacterSpeedKind?>()) {
      return (data != null ? _i96.CharacterSpeedKind.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i97.CharacterSpellSelectionKind?>()) {
      return (data != null
          ? _i97.CharacterSpellSelectionKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i98.CharacterSyncOperationType?>()) {
      return (data != null
          ? _i98.CharacterSyncOperationType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i99.CharacterSyncTargetType?>()) {
      return (data != null ? _i99.CharacterSyncTargetType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i100.ChoiceRequirementType?>()) {
      return (data != null ? _i100.ChoiceRequirementType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i101.ChoiceSourceType?>()) {
      return (data != null ? _i101.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.ChoiceType?>()) {
      return (data != null ? _i102.ChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.ClassSpellSelectionMode?>()) {
      return (data != null
          ? _i103.ClassSpellSelectionMode.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i104.ConditionType?>()) {
      return (data != null ? _i104.ConditionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i105.CreatureSize?>()) {
      return (data != null ? _i105.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i106.DamageType?>()) {
      return (data != null ? _i106.DamageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i107.EquipmentCatalogType?>()) {
      return (data != null ? _i107.EquipmentCatalogType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i108.FeatureDisplayPropertyValueKind?>()) {
      return (data != null
          ? _i108.FeatureDisplayPropertyValueKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i109.FeatureModifierConditionType?>()) {
      return (data != null
          ? _i109.FeatureModifierConditionType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i110.FeatureModifierOperation?>()) {
      return (data != null
          ? _i110.FeatureModifierOperation.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i111.StartingEquipmentOptionView?>()) {
      return (data != null
          ? _i111.StartingEquipmentOptionView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i112.FeatureModifierTarget?>()) {
      return (data != null ? _i112.FeatureModifierTarget.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i113.FeatureModifierValueKind?>()) {
      return (data != null
          ? _i113.FeatureModifierValueKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i114.FeatureRelationType?>()) {
      return (data != null ? _i114.FeatureRelationType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i115.FeatureResourceEffectType?>()) {
      return (data != null
          ? _i115.FeatureResourceEffectType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i116.FeatureResourceKind?>()) {
      return (data != null ? _i116.FeatureResourceKind.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i117.FeatureResourceMaxRule?>()) {
      return (data != null ? _i117.FeatureResourceMaxRule.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i118.FeatureResourceProgressionKey?>()) {
      return (data != null
          ? _i118.FeatureResourceProgressionKey.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i119.FeatureResourceTargetType?>()) {
      return (data != null
          ? _i119.FeatureResourceTargetType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i120.FeatureResourceTrigger?>()) {
      return (data != null ? _i120.FeatureResourceTrigger.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i121.FeatureTag?>()) {
      return (data != null ? _i121.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.HitPointMode?>()) {
      return (data != null ? _i122.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i123.Language?>()) {
      return (data != null ? _i123.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i124.PreparedSpellRounding?>()) {
      return (data != null ? _i124.PreparedSpellRounding.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i125.RestType?>()) {
      return (data != null ? _i125.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i126.SenseType?>()) {
      return (data != null ? _i126.SenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i127.Skill?>()) {
      return (data != null ? _i127.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i128.AreaOfEffectType?>()) {
      return (data != null ? _i128.AreaOfEffectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i129.AreaSizeMeasurement?>()) {
      return (data != null ? _i129.AreaSizeMeasurement.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i130.SpellAttackType?>()) {
      return (data != null ? _i130.SpellAttackType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i131.SpellDurationType?>()) {
      return (data != null ? _i131.SpellDurationType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i132.SpellScalingMode?>()) {
      return (data != null ? _i132.SpellScalingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i133.SpellSchool?>()) {
      return (data != null ? _i133.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i134.SpellTargetType?>()) {
      return (data != null ? _i134.SpellTargetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i135.SpellSlotRecoveryMode?>()) {
      return (data != null ? _i135.SpellSlotRecoveryMode.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i136.SpellcastingProgression?>()) {
      return (data != null
          ? _i136.SpellcastingProgression.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i137.StartingEquipmentBlockKind?>()) {
      return (data != null
          ? _i137.StartingEquipmentBlockKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i138.StartingEquipmentEntryKind?>()) {
      return (data != null
          ? _i138.StartingEquipmentEntryKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i139.StartingEquipmentLineKind?>()) {
      return (data != null
          ? _i139.StartingEquipmentLineKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i140.ToolCategory?>()) {
      return (data != null ? _i140.ToolCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i141.UnarmoredDefenseRule?>()) {
      return (data != null ? _i141.UnarmoredDefenseRule.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i142.WeaponCategory?>()) {
      return (data != null ? _i142.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i143.WeaponProperty?>()) {
      return (data != null ? _i143.WeaponProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i144.LevelDownChoiceRepair?>()) {
      return (data != null ? _i144.LevelDownChoiceRepair.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i145.LevelDownRequest?>()) {
      return (data != null ? _i145.LevelDownRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i146.BackgroundStepView?>()) {
      return (data != null ? _i146.BackgroundStepView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i147.CharacterEquipmentEntryView?>()) {
      return (data != null
          ? _i147.CharacterEquipmentEntryView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i148.ChoiceGroupView?>()) {
      return (data != null ? _i148.ChoiceGroupView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i149.ChoiceOptionEligibilityView?>()) {
      return (data != null
          ? _i149.ChoiceOptionEligibilityView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i150.ChoiceRequirementFailureView?>()) {
      return (data != null
          ? _i150.ChoiceRequirementFailureView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i151.ClassSpellDeltaView?>()) {
      return (data != null ? _i151.ClassSpellDeltaView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i152.ClassSpellSelectionGroupView?>()) {
      return (data != null
          ? _i152.ClassSpellSelectionGroupView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i153.ClassStepFeatureView?>()) {
      return (data != null ? _i153.ClassStepFeatureView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i154.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i154.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i155.ClassStepView?>()) {
      return (data != null ? _i155.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i156.FeatureDisplayPropertyView?>()) {
      return (data != null
          ? _i156.FeatureDisplayPropertyView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i157.LevelDownInvalidChoiceView?>()) {
      return (data != null
          ? _i157.LevelDownInvalidChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i158.LevelDownPreview?>()) {
      return (data != null ? _i158.LevelDownPreview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i159.LevelUpPreview?>()) {
      return (data != null ? _i159.LevelUpPreview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i160.ProficiencyBundleView?>()) {
      return (data != null ? _i160.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i161.RaceStepView?>()) {
      return (data != null ? _i161.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i162.ResolvedCharacterSpellData?>()) {
      return (data != null
          ? _i162.ResolvedCharacterSpellData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i163.SelectedFeatureChoiceView?>()) {
      return (data != null
          ? _i163.SelectedFeatureChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i164.SkillSelectionGroupView?>()) {
      return (data != null
          ? _i164.SkillSelectionGroupView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i165.SpellSourceContextData?>()) {
      return (data != null ? _i165.SpellSourceContextData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i166.StartingEquipmentBlockView?>()) {
      return (data != null
          ? _i166.StartingEquipmentBlockView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i167.FeatureModifierRounding?>()) {
      return (data != null
          ? _i167.FeatureModifierRounding.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
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
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
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
    if (t == _i1.getType<List<_i38.ChoiceReplacementHistoryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.ChoiceReplacementHistoryData>(e))
              .toList()
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
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
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
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i104.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i104.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CharacterInventoryItemData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CharacterInventoryItemData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<
            List<_i23.CharacterSavingThrowProficiencyOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i23.CharacterSavingThrowProficiencyOverrideData>(
                      e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.CharacterNoteData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.CharacterNoteData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.CharacterAttackData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.CharacterAttackData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CharacterFeatureOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CharacterFeatureOverrideData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.CharacterResourceStateData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.CharacterResourceStateData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, _i44.SpellSlotRecoveryTriggerData>?>()) {
      return (data != null
          ? (data as Map).map((k, v) => MapEntry(deserialize<String>(k),
              deserialize<_i44.SpellSlotRecoveryTriggerData>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.CharacterSkillSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i26.CharacterSkillSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.CharacterSpellSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.CharacterSpellSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i29.CharacterStartingEquipmentSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i29.CharacterStartingEquipmentSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<_i86.Ability, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i86.Ability>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<_i86.Ability, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i86.Ability>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.CharacterFeatureViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.CharacterFeatureViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<_i86.Ability, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i86.Ability>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<_i127.Skill, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i127.Skill>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
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
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
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
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i162.ResolvedCharacterSpellData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i162.ResolvedCharacterSpellData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i147.CharacterEquipmentEntryView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i147.CharacterEquipmentEntryView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i106.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i106.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.CharacterResourceViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.CharacterResourceViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i156.FeatureDisplayPropertyView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i156.FeatureDisplayPropertyView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.RelatedFeatureViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i42.RelatedFeatureViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i163.SelectedFeatureChoiceView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i163.SelectedFeatureChoiceView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i65.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i43.SpellSelectionReplacementHistoryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i43.SpellSelectionReplacementHistoryData>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i28.CharacterStartingEquipmentResolutionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i28.CharacterStartingEquipmentResolutionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.CharacterChangeData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.CharacterChangeData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.CharacterSyncOperationData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.CharacterSyncOperationData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.CharacterRejectedChangeData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.CharacterRejectedChangeData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.CharacterData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.CharacterData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, _i12.CharacterData>?>()) {
      return (data != null
          ? (data as Map).map((k, v) => MapEntry(
              deserialize<String>(k), deserialize<_i12.CharacterData>(v)))
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
    if (t == _i1.getType<List<_i104.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i104.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
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
    if (t == _i1.getType<List<_i25.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.CharacterSkillProficiencyState>(e))
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i39.LevelUpChoiceReplacementData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i39.LevelUpChoiceReplacementData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, List<String>>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<List<String>>(v)))
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i41.LevelUpSpellChoice>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i41.LevelUpSpellChoice>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i156.FeatureDisplayPropertyView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i156.FeatureDisplayPropertyView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.CharacterResourceViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.CharacterResourceViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i65.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.FeatureResourceEffectData>(e))
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
    if (t == _i1.getType<List<_i47.ChoiceRequirementData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i47.ChoiceRequirementData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i47.ChoiceRequirementData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i47.ChoiceRequirementData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.FeatureResourceDefinitionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.FeatureResourceDefinitionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i65.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.ClassSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.ClassSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i55.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.StartingEquipmentOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.StartingEquipmentOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i55.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.FeatureResourceDefinitionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.FeatureResourceDefinitionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i65.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.ClassSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.ClassSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, String>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<String>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i60.FeatureModifierConditionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i60.FeatureModifierConditionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i66.FeatureResourceProgressionValueData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i66.FeatureResourceProgressionValueData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i106.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i106.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i68.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i68.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.FeatureResourceDefinitionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.FeatureResourceDefinitionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i65.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i121.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i121.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i69.RaceFeatureSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i69.RaceFeatureSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i106.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i106.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i68.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i68.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == Map<int, int>) {
      return Map.fromEntries((data as List).map((e) =>
          MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v'])))) as T;
    }
    if (t == _i1.getType<List<_i133.SpellSchool>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i133.SpellSchool>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i97.CharacterSpellSelectionKind>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i97.CharacterSpellSelectionKind>(e))
              .toList()
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
    if (t == _i1.getType<List<_i143.WeaponProperty>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i143.WeaponProperty>(e))
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
    if (t == _i1.getType<List<_i104.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i104.ConditionType>(e))
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
    if (t == _i1.getType<List<_i55.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i55.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i144.LevelDownChoiceRepair>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i144.LevelDownChoiceRepair>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i148.ChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i148.ChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i164.SkillSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i164.SkillSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i166.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i166.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.ChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i46.ChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i149.ChoiceOptionEligibilityView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i149.ChoiceOptionEligibilityView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i150.ChoiceRequirementFailureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i150.ChoiceRequirementFailureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i80.SpellData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i80.SpellData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i156.FeatureDisplayPropertyView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i156.FeatureDisplayPropertyView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.CharacterResourceViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.CharacterResourceViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i2.SubclassData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i2.SubclassData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i49.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i49.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i49.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i49.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i58.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i58.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i58.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i153.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i153.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i153.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i153.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i153.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i153.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i153.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i153.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i148.ChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i148.ChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i164.SkillSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i164.SkillSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i152.ClassSpellSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i152.ClassSpellSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i166.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i166.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i50.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i50.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i49.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i49.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i58.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i58.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i45.ChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i45.ChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i10.CharacterChoiceData>) {
      return (data as List)
          .map((e) => deserialize<_i10.CharacterChoiceData>(e))
          .toList() as T;
    }
    if (t == List<_i157.LevelDownInvalidChoiceView>) {
      return (data as List)
          .map((e) => deserialize<_i157.LevelDownInvalidChoiceView>(e))
          .toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    if (t == List<_i148.ChoiceGroupView>) {
      return (data as List)
          .map((e) => deserialize<_i148.ChoiceGroupView>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i86.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i86.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i87.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i87.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i123.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i70.SubraceData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i70.SubraceData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i68.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i68.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i148.ChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i148.ChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i165.SpellSourceContextData>) {
      return (data as List)
          .map((e) => deserialize<_i165.SpellSourceContextData>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i127.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i127.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i55.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i55.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i111.StartingEquipmentOptionView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i111.StartingEquipmentOptionView>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i168.UserInfo>) {
      return (data as List).map((e) => deserialize<_i168.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i169.DmCreatureSummary>) {
      return (data as List)
          .map((e) => deserialize<_i169.DmCreatureSummary>(e))
          .toList() as T;
    }
    if (t == List<_i170.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i170.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i171.FeatData>) {
      return (data as List).map((e) => deserialize<_i171.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i172.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i172.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i173.ChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i173.ChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i174.ChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i174.ChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i175.ClassData>) {
      return (data as List).map((e) => deserialize<_i175.ClassData>(e)).toList()
          as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    if (t == List<_i176.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i176.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i177.ClassSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i177.ClassSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i178.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i178.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i179.SpellSlotProgressionData>) {
      return (data as List)
          .map((e) => deserialize<_i179.SpellSlotProgressionData>(e))
          .toList() as T;
    }
    if (t == List<_i180.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i180.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i181.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i181.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i182.FeatureRelationData>) {
      return (data as List)
          .map((e) => deserialize<_i182.FeatureRelationData>(e))
          .toList() as T;
    }
    if (t == List<_i183.RaceData>) {
      return (data as List).map((e) => deserialize<_i183.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i184.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i184.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i185.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i185.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i186.RaceFeatureSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i186.RaceFeatureSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i187.ToolData>) {
      return (data as List).map((e) => deserialize<_i187.ToolData>(e)).toList()
          as T;
    }
    if (t == List<_i188.ArmorData>) {
      return (data as List).map((e) => deserialize<_i188.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i189.ItemData>) {
      return (data as List).map((e) => deserialize<_i189.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i190.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i190.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i191.WeaponData>) {
      return (data as List)
          .map((e) => deserialize<_i191.WeaponData>(e))
          .toList() as T;
    }
    if (t == List<_i192.SpellData>) {
      return (data as List).map((e) => deserialize<_i192.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i168.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.SubclassData) {
      return 'SubclassData';
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
    if (data is _i7.CharacterArmorTrainingOverridesData) {
      return 'CharacterArmorTrainingOverridesData';
    }
    if (data is _i8.CharacterAttackData) {
      return 'CharacterAttackData';
    }
    if (data is _i9.CharacterChangeData) {
      return 'CharacterChangeData';
    }
    if (data is _i10.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i11.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i12.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i13.CharacterDerivedData) {
      return 'CharacterDerivedData';
    }
    if (data is _i14.CharacterEquipmentSelectionData) {
      return 'CharacterEquipmentSelectionData';
    }
    if (data is _i15.CharacterFeatureOverrideData) {
      return 'CharacterFeatureOverrideData';
    }
    if (data is _i16.CharacterFeatureViewData) {
      return 'CharacterFeatureViewData';
    }
    if (data is _i17.CharacterInventoryItemData) {
      return 'CharacterInventoryItemData';
    }
    if (data is _i18.CharacterLanguageOverridesData) {
      return 'CharacterLanguageOverridesData';
    }
    if (data is _i19.CharacterNoteData) {
      return 'CharacterNoteData';
    }
    if (data is _i20.CharacterRejectedChangeData) {
      return 'CharacterRejectedChangeData';
    }
    if (data is _i21.CharacterResourceStateData) {
      return 'CharacterResourceStateData';
    }
    if (data is _i22.CharacterResourceViewData) {
      return 'CharacterResourceViewData';
    }
    if (data is _i23.CharacterSavingThrowProficiencyOverrideData) {
      return 'CharacterSavingThrowProficiencyOverrideData';
    }
    if (data is _i24.CharacterSemanticActionData) {
      return 'CharacterSemanticActionData';
    }
    if (data is _i25.CharacterSkillProficiencyState) {
      return 'CharacterSkillProficiencyState';
    }
    if (data is _i26.CharacterSkillSelectionData) {
      return 'CharacterSkillSelectionData';
    }
    if (data is _i27.CharacterSpellSelectionData) {
      return 'CharacterSpellSelectionData';
    }
    if (data is _i28.CharacterStartingEquipmentResolutionData) {
      return 'CharacterStartingEquipmentResolutionData';
    }
    if (data is _i29.CharacterStartingEquipmentSelectionData) {
      return 'CharacterStartingEquipmentSelectionData';
    }
    if (data is _i30.CharacterSyncOperationData) {
      return 'CharacterSyncOperationData';
    }
    if (data is _i31.CharacterSyncRequest) {
      return 'CharacterSyncRequest';
    }
    if (data is _i32.CharacterSyncResponse) {
      return 'CharacterSyncResponse';
    }
    if (data is _i33.CharacterSyncResult) {
      return 'CharacterSyncResult';
    }
    if (data is _i34.CharacterSyncStatus) {
      return 'CharacterSyncStatus';
    }
    if (data is _i35.CharacterSyncValueData) {
      return 'CharacterSyncValueData';
    }
    if (data is _i36.CharacterToolProficiencyOverridesData) {
      return 'CharacterToolProficiencyOverridesData';
    }
    if (data is _i37.CharacterWeaponProficiencyOverridesData) {
      return 'CharacterWeaponProficiencyOverridesData';
    }
    if (data is _i38.ChoiceReplacementHistoryData) {
      return 'ChoiceReplacementHistoryData';
    }
    if (data is _i39.LevelUpChoiceReplacementData) {
      return 'LevelUpChoiceReplacementData';
    }
    if (data is _i40.LevelUpRequest) {
      return 'LevelUpRequest';
    }
    if (data is _i41.LevelUpSpellChoice) {
      return 'LevelUpSpellChoice';
    }
    if (data is _i42.RelatedFeatureViewData) {
      return 'RelatedFeatureViewData';
    }
    if (data is _i43.SpellSelectionReplacementHistoryData) {
      return 'SpellSelectionReplacementHistoryData';
    }
    if (data is _i44.SpellSlotRecoveryTriggerData) {
      return 'SpellSlotRecoveryTriggerData';
    }
    if (data is _i45.ChoiceGroupData) {
      return 'ChoiceGroupData';
    }
    if (data is _i46.ChoiceOptionData) {
      return 'ChoiceOptionData';
    }
    if (data is _i47.ChoiceRequirementData) {
      return 'ChoiceRequirementData';
    }
    if (data is _i48.ClassData) {
      return 'ClassData';
    }
    if (data is _i49.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i50.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i51.PreparedSpellRuleData) {
      return 'PreparedSpellRuleData';
    }
    if (data is _i52.SpellSlotProgressionData) {
      return 'SpellSlotProgressionData';
    }
    if (data is _i53.StartingEquipmentBlockData) {
      return 'StartingEquipmentBlockData';
    }
    if (data is _i54.StartingEquipmentEntryData) {
      return 'StartingEquipmentEntryData';
    }
    if (data is _i55.StartingEquipmentLineData) {
      return 'StartingEquipmentLineData';
    }
    if (data is _i56.StartingEquipmentOptionData) {
      return 'StartingEquipmentOptionData';
    }
    if (data is _i57.AuthActionResult) {
      return 'AuthActionResult';
    }
    if (data is _i58.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i59.FeatureDisplayPropertyData) {
      return 'FeatureDisplayPropertyData';
    }
    if (data is _i60.FeatureModifierConditionData) {
      return 'FeatureModifierConditionData';
    }
    if (data is _i61.FeatureModifierData) {
      return 'FeatureModifierData';
    }
    if (data is _i62.FeatureModifierValueData) {
      return 'FeatureModifierValueData';
    }
    if (data is _i63.FeatureRelationData) {
      return 'FeatureRelationData';
    }
    if (data is _i64.FeatureResourceDefinitionData) {
      return 'FeatureResourceDefinitionData';
    }
    if (data is _i65.FeatureResourceEffectData) {
      return 'FeatureResourceEffectData';
    }
    if (data is _i66.FeatureResourceProgressionValueData) {
      return 'FeatureResourceProgressionValueData';
    }
    if (data is _i67.RaceData) {
      return 'RaceData';
    }
    if (data is _i68.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i69.RaceFeatureSpellGrantData) {
      return 'RaceFeatureSpellGrantData';
    }
    if (data is _i70.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i71.SpellActivationData) {
      return 'SpellActivationData';
    }
    if (data is _i72.SpellResourceUpcastPolicyData) {
      return 'SpellResourceUpcastPolicyData';
    }
    if (data is _i73.SpellSelectionFilterData) {
      return 'SpellSelectionFilterData';
    }
    if (data is _i74.SpellSlotRecoveryPolicyData) {
      return 'SpellSlotRecoveryPolicyData';
    }
    if (data is _i75.ToolData) {
      return 'ToolData';
    }
    if (data is _i76.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i77.ItemData) {
      return 'ItemData';
    }
    if (data is _i78.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i79.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i80.SpellData) {
      return 'SpellData';
    }
    if (data is _i81.SpellScalingData) {
      return 'SpellScalingData';
    }
    if (data is _i82.DmCreatureException) {
      return 'DmCreatureException';
    }
    if (data is _i83.DmCreatureImportResult) {
      return 'DmCreatureImportResult';
    }
    if (data is _i84.DmCreatureRecord) {
      return 'DmCreatureRecord';
    }
    if (data is _i85.DmCreatureSummary) {
      return 'DmCreatureSummary';
    }
    if (data is _i86.Ability) {
      return 'Ability';
    }
    if (data is _i87.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i88.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i89.CharacterChangeType) {
      return 'CharacterChangeType';
    }
    if (data is _i90.CharacterEntityType) {
      return 'CharacterEntityType';
    }
    if (data is _i91.CharacterFeatureSourceType) {
      return 'CharacterFeatureSourceType';
    }
    if (data is _i92.CharacterInventoryItemType) {
      return 'CharacterInventoryItemType';
    }
    if (data is _i93.CharacterSavingThrowProficiencyOverride) {
      return 'CharacterSavingThrowProficiencyOverride';
    }
    if (data is _i94.CharacterSkillProficiencyLevel) {
      return 'CharacterSkillProficiencyLevel';
    }
    if (data is _i95.CharacterSkillSelectionKind) {
      return 'CharacterSkillSelectionKind';
    }
    if (data is _i96.CharacterSpeedKind) {
      return 'CharacterSpeedKind';
    }
    if (data is _i97.CharacterSpellSelectionKind) {
      return 'CharacterSpellSelectionKind';
    }
    if (data is _i98.CharacterSyncOperationType) {
      return 'CharacterSyncOperationType';
    }
    if (data is _i99.CharacterSyncTargetType) {
      return 'CharacterSyncTargetType';
    }
    if (data is _i100.ChoiceRequirementType) {
      return 'ChoiceRequirementType';
    }
    if (data is _i101.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i102.ChoiceType) {
      return 'ChoiceType';
    }
    if (data is _i103.ClassSpellSelectionMode) {
      return 'ClassSpellSelectionMode';
    }
    if (data is _i104.ConditionType) {
      return 'ConditionType';
    }
    if (data is _i105.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i106.DamageType) {
      return 'DamageType';
    }
    if (data is _i107.EquipmentCatalogType) {
      return 'EquipmentCatalogType';
    }
    if (data is _i108.FeatureDisplayPropertyValueKind) {
      return 'FeatureDisplayPropertyValueKind';
    }
    if (data is _i109.FeatureModifierConditionType) {
      return 'FeatureModifierConditionType';
    }
    if (data is _i110.FeatureModifierOperation) {
      return 'FeatureModifierOperation';
    }
    if (data is _i111.StartingEquipmentOptionView) {
      return 'StartingEquipmentOptionView';
    }
    if (data is _i112.FeatureModifierTarget) {
      return 'FeatureModifierTarget';
    }
    if (data is _i113.FeatureModifierValueKind) {
      return 'FeatureModifierValueKind';
    }
    if (data is _i114.FeatureRelationType) {
      return 'FeatureRelationType';
    }
    if (data is _i115.FeatureResourceEffectType) {
      return 'FeatureResourceEffectType';
    }
    if (data is _i116.FeatureResourceKind) {
      return 'FeatureResourceKind';
    }
    if (data is _i117.FeatureResourceMaxRule) {
      return 'FeatureResourceMaxRule';
    }
    if (data is _i118.FeatureResourceProgressionKey) {
      return 'FeatureResourceProgressionKey';
    }
    if (data is _i119.FeatureResourceTargetType) {
      return 'FeatureResourceTargetType';
    }
    if (data is _i120.FeatureResourceTrigger) {
      return 'FeatureResourceTrigger';
    }
    if (data is _i121.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i122.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i123.Language) {
      return 'Language';
    }
    if (data is _i124.PreparedSpellRounding) {
      return 'PreparedSpellRounding';
    }
    if (data is _i125.RestType) {
      return 'RestType';
    }
    if (data is _i126.SenseType) {
      return 'SenseType';
    }
    if (data is _i127.Skill) {
      return 'Skill';
    }
    if (data is _i128.AreaOfEffectType) {
      return 'AreaOfEffectType';
    }
    if (data is _i129.AreaSizeMeasurement) {
      return 'AreaSizeMeasurement';
    }
    if (data is _i130.SpellAttackType) {
      return 'SpellAttackType';
    }
    if (data is _i131.SpellDurationType) {
      return 'SpellDurationType';
    }
    if (data is _i132.SpellScalingMode) {
      return 'SpellScalingMode';
    }
    if (data is _i133.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i134.SpellTargetType) {
      return 'SpellTargetType';
    }
    if (data is _i135.SpellSlotRecoveryMode) {
      return 'SpellSlotRecoveryMode';
    }
    if (data is _i136.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i137.StartingEquipmentBlockKind) {
      return 'StartingEquipmentBlockKind';
    }
    if (data is _i138.StartingEquipmentEntryKind) {
      return 'StartingEquipmentEntryKind';
    }
    if (data is _i139.StartingEquipmentLineKind) {
      return 'StartingEquipmentLineKind';
    }
    if (data is _i140.ToolCategory) {
      return 'ToolCategory';
    }
    if (data is _i141.UnarmoredDefenseRule) {
      return 'UnarmoredDefenseRule';
    }
    if (data is _i142.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i143.WeaponProperty) {
      return 'WeaponProperty';
    }
    if (data is _i144.LevelDownChoiceRepair) {
      return 'LevelDownChoiceRepair';
    }
    if (data is _i145.LevelDownRequest) {
      return 'LevelDownRequest';
    }
    if (data is _i146.BackgroundStepView) {
      return 'BackgroundStepView';
    }
    if (data is _i147.CharacterEquipmentEntryView) {
      return 'CharacterEquipmentEntryView';
    }
    if (data is _i148.ChoiceGroupView) {
      return 'ChoiceGroupView';
    }
    if (data is _i149.ChoiceOptionEligibilityView) {
      return 'ChoiceOptionEligibilityView';
    }
    if (data is _i150.ChoiceRequirementFailureView) {
      return 'ChoiceRequirementFailureView';
    }
    if (data is _i151.ClassSpellDeltaView) {
      return 'ClassSpellDeltaView';
    }
    if (data is _i152.ClassSpellSelectionGroupView) {
      return 'ClassSpellSelectionGroupView';
    }
    if (data is _i153.ClassStepFeatureView) {
      return 'ClassStepFeatureView';
    }
    if (data is _i154.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i155.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i156.FeatureDisplayPropertyView) {
      return 'FeatureDisplayPropertyView';
    }
    if (data is _i157.LevelDownInvalidChoiceView) {
      return 'LevelDownInvalidChoiceView';
    }
    if (data is _i158.LevelDownPreview) {
      return 'LevelDownPreview';
    }
    if (data is _i159.LevelUpPreview) {
      return 'LevelUpPreview';
    }
    if (data is _i160.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i161.RaceStepView) {
      return 'RaceStepView';
    }
    if (data is _i162.ResolvedCharacterSpellData) {
      return 'ResolvedCharacterSpellData';
    }
    if (data is _i163.SelectedFeatureChoiceView) {
      return 'SelectedFeatureChoiceView';
    }
    if (data is _i164.SkillSelectionGroupView) {
      return 'SkillSelectionGroupView';
    }
    if (data is _i165.SpellSourceContextData) {
      return 'SpellSourceContextData';
    }
    if (data is _i166.StartingEquipmentBlockView) {
      return 'StartingEquipmentBlockView';
    }
    if (data is _i167.FeatureModifierRounding) {
      return 'FeatureModifierRounding';
    }
    className = _i168.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'SubclassData') {
      return deserialize<_i2.SubclassData>(data['data']);
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
    if (dataClassName == 'CharacterArmorTrainingOverridesData') {
      return deserialize<_i7.CharacterArmorTrainingOverridesData>(data['data']);
    }
    if (dataClassName == 'CharacterAttackData') {
      return deserialize<_i8.CharacterAttackData>(data['data']);
    }
    if (dataClassName == 'CharacterChangeData') {
      return deserialize<_i9.CharacterChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i10.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i11.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i12.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterDerivedData') {
      return deserialize<_i13.CharacterDerivedData>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentSelectionData') {
      return deserialize<_i14.CharacterEquipmentSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureOverrideData') {
      return deserialize<_i15.CharacterFeatureOverrideData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureViewData') {
      return deserialize<_i16.CharacterFeatureViewData>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemData') {
      return deserialize<_i17.CharacterInventoryItemData>(data['data']);
    }
    if (dataClassName == 'CharacterLanguageOverridesData') {
      return deserialize<_i18.CharacterLanguageOverridesData>(data['data']);
    }
    if (dataClassName == 'CharacterNoteData') {
      return deserialize<_i19.CharacterNoteData>(data['data']);
    }
    if (dataClassName == 'CharacterRejectedChangeData') {
      return deserialize<_i20.CharacterRejectedChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterResourceStateData') {
      return deserialize<_i21.CharacterResourceStateData>(data['data']);
    }
    if (dataClassName == 'CharacterResourceViewData') {
      return deserialize<_i22.CharacterResourceViewData>(data['data']);
    }
    if (dataClassName == 'CharacterSavingThrowProficiencyOverrideData') {
      return deserialize<_i23.CharacterSavingThrowProficiencyOverrideData>(
          data['data']);
    }
    if (dataClassName == 'CharacterSemanticActionData') {
      return deserialize<_i24.CharacterSemanticActionData>(data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyState') {
      return deserialize<_i25.CharacterSkillProficiencyState>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionData') {
      return deserialize<_i26.CharacterSkillSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionData') {
      return deserialize<_i27.CharacterSpellSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionData') {
      return deserialize<_i28.CharacterStartingEquipmentResolutionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionData') {
      return deserialize<_i29.CharacterStartingEquipmentSelectionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterSyncOperationData') {
      return deserialize<_i30.CharacterSyncOperationData>(data['data']);
    }
    if (dataClassName == 'CharacterSyncRequest') {
      return deserialize<_i31.CharacterSyncRequest>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResponse') {
      return deserialize<_i32.CharacterSyncResponse>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResult') {
      return deserialize<_i33.CharacterSyncResult>(data['data']);
    }
    if (dataClassName == 'CharacterSyncStatus') {
      return deserialize<_i34.CharacterSyncStatus>(data['data']);
    }
    if (dataClassName == 'CharacterSyncValueData') {
      return deserialize<_i35.CharacterSyncValueData>(data['data']);
    }
    if (dataClassName == 'CharacterToolProficiencyOverridesData') {
      return deserialize<_i36.CharacterToolProficiencyOverridesData>(
          data['data']);
    }
    if (dataClassName == 'CharacterWeaponProficiencyOverridesData') {
      return deserialize<_i37.CharacterWeaponProficiencyOverridesData>(
          data['data']);
    }
    if (dataClassName == 'ChoiceReplacementHistoryData') {
      return deserialize<_i38.ChoiceReplacementHistoryData>(data['data']);
    }
    if (dataClassName == 'LevelUpChoiceReplacementData') {
      return deserialize<_i39.LevelUpChoiceReplacementData>(data['data']);
    }
    if (dataClassName == 'LevelUpRequest') {
      return deserialize<_i40.LevelUpRequest>(data['data']);
    }
    if (dataClassName == 'LevelUpSpellChoice') {
      return deserialize<_i41.LevelUpSpellChoice>(data['data']);
    }
    if (dataClassName == 'RelatedFeatureViewData') {
      return deserialize<_i42.RelatedFeatureViewData>(data['data']);
    }
    if (dataClassName == 'SpellSelectionReplacementHistoryData') {
      return deserialize<_i43.SpellSelectionReplacementHistoryData>(
          data['data']);
    }
    if (dataClassName == 'SpellSlotRecoveryTriggerData') {
      return deserialize<_i44.SpellSlotRecoveryTriggerData>(data['data']);
    }
    if (dataClassName == 'ChoiceGroupData') {
      return deserialize<_i45.ChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ChoiceOptionData') {
      return deserialize<_i46.ChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementData') {
      return deserialize<_i47.ChoiceRequirementData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i48.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i49.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i50.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'PreparedSpellRuleData') {
      return deserialize<_i51.PreparedSpellRuleData>(data['data']);
    }
    if (dataClassName == 'SpellSlotProgressionData') {
      return deserialize<_i52.SpellSlotProgressionData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockData') {
      return deserialize<_i53.StartingEquipmentBlockData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryData') {
      return deserialize<_i54.StartingEquipmentEntryData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineData') {
      return deserialize<_i55.StartingEquipmentLineData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionData') {
      return deserialize<_i56.StartingEquipmentOptionData>(data['data']);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_i57.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i58.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyData') {
      return deserialize<_i59.FeatureDisplayPropertyData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierConditionData') {
      return deserialize<_i60.FeatureModifierConditionData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierData') {
      return deserialize<_i61.FeatureModifierData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierValueData') {
      return deserialize<_i62.FeatureModifierValueData>(data['data']);
    }
    if (dataClassName == 'FeatureRelationData') {
      return deserialize<_i63.FeatureRelationData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceDefinitionData') {
      return deserialize<_i64.FeatureResourceDefinitionData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceEffectData') {
      return deserialize<_i65.FeatureResourceEffectData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceProgressionValueData') {
      return deserialize<_i66.FeatureResourceProgressionValueData>(
          data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i67.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i68.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_i69.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i70.SubraceData>(data['data']);
    }
    if (dataClassName == 'SpellActivationData') {
      return deserialize<_i71.SpellActivationData>(data['data']);
    }
    if (dataClassName == 'SpellResourceUpcastPolicyData') {
      return deserialize<_i72.SpellResourceUpcastPolicyData>(data['data']);
    }
    if (dataClassName == 'SpellSelectionFilterData') {
      return deserialize<_i73.SpellSelectionFilterData>(data['data']);
    }
    if (dataClassName == 'SpellSlotRecoveryPolicyData') {
      return deserialize<_i74.SpellSlotRecoveryPolicyData>(data['data']);
    }
    if (dataClassName == 'ToolData') {
      return deserialize<_i75.ToolData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i76.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i77.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i78.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i79.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i80.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_i81.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'DmCreatureException') {
      return deserialize<_i82.DmCreatureException>(data['data']);
    }
    if (dataClassName == 'DmCreatureImportResult') {
      return deserialize<_i83.DmCreatureImportResult>(data['data']);
    }
    if (dataClassName == 'DmCreatureRecord') {
      return deserialize<_i84.DmCreatureRecord>(data['data']);
    }
    if (dataClassName == 'DmCreatureSummary') {
      return deserialize<_i85.DmCreatureSummary>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i86.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i87.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i88.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'CharacterChangeType') {
      return deserialize<_i89.CharacterChangeType>(data['data']);
    }
    if (dataClassName == 'CharacterEntityType') {
      return deserialize<_i90.CharacterEntityType>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureSourceType') {
      return deserialize<_i91.CharacterFeatureSourceType>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemType') {
      return deserialize<_i92.CharacterInventoryItemType>(data['data']);
    }
    if (dataClassName == 'CharacterSavingThrowProficiencyOverride') {
      return deserialize<_i93.CharacterSavingThrowProficiencyOverride>(
          data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyLevel') {
      return deserialize<_i94.CharacterSkillProficiencyLevel>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionKind') {
      return deserialize<_i95.CharacterSkillSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpeedKind') {
      return deserialize<_i96.CharacterSpeedKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionKind') {
      return deserialize<_i97.CharacterSpellSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSyncOperationType') {
      return deserialize<_i98.CharacterSyncOperationType>(data['data']);
    }
    if (dataClassName == 'CharacterSyncTargetType') {
      return deserialize<_i99.CharacterSyncTargetType>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementType') {
      return deserialize<_i100.ChoiceRequirementType>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i101.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ChoiceType') {
      return deserialize<_i102.ChoiceType>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionMode') {
      return deserialize<_i103.ClassSpellSelectionMode>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_i104.ConditionType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i105.CreatureSize>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i106.DamageType>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalogType') {
      return deserialize<_i107.EquipmentCatalogType>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyValueKind') {
      return deserialize<_i108.FeatureDisplayPropertyValueKind>(data['data']);
    }
    if (dataClassName == 'FeatureModifierConditionType') {
      return deserialize<_i109.FeatureModifierConditionType>(data['data']);
    }
    if (dataClassName == 'FeatureModifierOperation') {
      return deserialize<_i110.FeatureModifierOperation>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionView') {
      return deserialize<_i111.StartingEquipmentOptionView>(data['data']);
    }
    if (dataClassName == 'FeatureModifierTarget') {
      return deserialize<_i112.FeatureModifierTarget>(data['data']);
    }
    if (dataClassName == 'FeatureModifierValueKind') {
      return deserialize<_i113.FeatureModifierValueKind>(data['data']);
    }
    if (dataClassName == 'FeatureRelationType') {
      return deserialize<_i114.FeatureRelationType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceEffectType') {
      return deserialize<_i115.FeatureResourceEffectType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceKind') {
      return deserialize<_i116.FeatureResourceKind>(data['data']);
    }
    if (dataClassName == 'FeatureResourceMaxRule') {
      return deserialize<_i117.FeatureResourceMaxRule>(data['data']);
    }
    if (dataClassName == 'FeatureResourceProgressionKey') {
      return deserialize<_i118.FeatureResourceProgressionKey>(data['data']);
    }
    if (dataClassName == 'FeatureResourceTargetType') {
      return deserialize<_i119.FeatureResourceTargetType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceTrigger') {
      return deserialize<_i120.FeatureResourceTrigger>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i121.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i122.HitPointMode>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i123.Language>(data['data']);
    }
    if (dataClassName == 'PreparedSpellRounding') {
      return deserialize<_i124.PreparedSpellRounding>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i125.RestType>(data['data']);
    }
    if (dataClassName == 'SenseType') {
      return deserialize<_i126.SenseType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i127.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_i128.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'AreaSizeMeasurement') {
      return deserialize<_i129.AreaSizeMeasurement>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_i130.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i131.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_i132.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i133.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_i134.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellSlotRecoveryMode') {
      return deserialize<_i135.SpellSlotRecoveryMode>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i136.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockKind') {
      return deserialize<_i137.StartingEquipmentBlockKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryKind') {
      return deserialize<_i138.StartingEquipmentEntryKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineKind') {
      return deserialize<_i139.StartingEquipmentLineKind>(data['data']);
    }
    if (dataClassName == 'ToolCategory') {
      return deserialize<_i140.ToolCategory>(data['data']);
    }
    if (dataClassName == 'UnarmoredDefenseRule') {
      return deserialize<_i141.UnarmoredDefenseRule>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i142.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'WeaponProperty') {
      return deserialize<_i143.WeaponProperty>(data['data']);
    }
    if (dataClassName == 'LevelDownChoiceRepair') {
      return deserialize<_i144.LevelDownChoiceRepair>(data['data']);
    }
    if (dataClassName == 'LevelDownRequest') {
      return deserialize<_i145.LevelDownRequest>(data['data']);
    }
    if (dataClassName == 'BackgroundStepView') {
      return deserialize<_i146.BackgroundStepView>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentEntryView') {
      return deserialize<_i147.CharacterEquipmentEntryView>(data['data']);
    }
    if (dataClassName == 'ChoiceGroupView') {
      return deserialize<_i148.ChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ChoiceOptionEligibilityView') {
      return deserialize<_i149.ChoiceOptionEligibilityView>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementFailureView') {
      return deserialize<_i150.ChoiceRequirementFailureView>(data['data']);
    }
    if (dataClassName == 'ClassSpellDeltaView') {
      return deserialize<_i151.ClassSpellDeltaView>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionGroupView') {
      return deserialize<_i152.ClassSpellSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepFeatureView') {
      return deserialize<_i153.ClassStepFeatureView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i154.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i155.ClassStepView>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyView') {
      return deserialize<_i156.FeatureDisplayPropertyView>(data['data']);
    }
    if (dataClassName == 'LevelDownInvalidChoiceView') {
      return deserialize<_i157.LevelDownInvalidChoiceView>(data['data']);
    }
    if (dataClassName == 'LevelDownPreview') {
      return deserialize<_i158.LevelDownPreview>(data['data']);
    }
    if (dataClassName == 'LevelUpPreview') {
      return deserialize<_i159.LevelUpPreview>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i160.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceStepView') {
      return deserialize<_i161.RaceStepView>(data['data']);
    }
    if (dataClassName == 'ResolvedCharacterSpellData') {
      return deserialize<_i162.ResolvedCharacterSpellData>(data['data']);
    }
    if (dataClassName == 'SelectedFeatureChoiceView') {
      return deserialize<_i163.SelectedFeatureChoiceView>(data['data']);
    }
    if (dataClassName == 'SkillSelectionGroupView') {
      return deserialize<_i164.SkillSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'SpellSourceContextData') {
      return deserialize<_i165.SpellSourceContextData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockView') {
      return deserialize<_i166.StartingEquipmentBlockView>(data['data']);
    }
    if (dataClassName == 'FeatureModifierRounding') {
      return deserialize<_i167.FeatureModifierRounding>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i168.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
