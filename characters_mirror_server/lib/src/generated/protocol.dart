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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i3;
import 'data/general/class/class_feature_data.dart' as _i4;
import 'data/background_data.dart' as _i5;
import 'data/class_spell_grant_data.dart' as _i6;
import 'data/damage_part_data.dart' as _i7;
import 'data/feat_data.dart' as _i8;
import 'data/general/character/character_applied_change_record.dart' as _i9;
import 'data/general/character/character_armor_training_overrides_data.dart'
    as _i10;
import 'data/general/character/character_attack_data.dart' as _i11;
import 'data/general/character/character_change_data.dart' as _i12;
import 'data/general/character/character_choice_data.dart' as _i13;
import 'data/general/character/character_choice_record.dart' as _i14;
import 'data/general/character/character_class_entry_data.dart' as _i15;
import 'data/general/character/character_class_entry_record.dart' as _i16;
import 'data/general/character/character_data.dart' as _i17;
import 'data/general/character/character_derived_data.dart' as _i18;
import 'data/general/character/character_equipment_selection_data.dart' as _i19;
import 'data/general/character/character_feature_override_data.dart' as _i20;
import 'data/general/character/character_feature_view_data.dart' as _i21;
import 'data/general/character/character_inventory_item_data.dart' as _i22;
import 'data/general/character/character_language_overrides_data.dart' as _i23;
import 'data/general/character/character_note_data.dart' as _i24;
import 'data/general/character/character_record.dart' as _i25;
import 'data/general/character/character_rejected_change_data.dart' as _i26;
import 'data/general/character/character_resource_state_data.dart' as _i27;
import 'data/general/character/character_resource_view_data.dart' as _i28;
import 'data/general/character/character_saving_throw_proficiency_override_data.dart'
    as _i29;
import 'data/general/character/character_semantic_action_data.dart' as _i30;
import 'data/general/character/character_skill_proficiency_state.dart' as _i31;
import 'data/general/character/character_skill_selection_data.dart' as _i32;
import 'data/general/character/character_skill_selection_record.dart' as _i33;
import 'data/general/character/character_spell_selection_data.dart' as _i34;
import 'data/general/character/character_spell_selection_record.dart' as _i35;
import 'data/general/character/character_starting_equipment_resolution_data.dart'
    as _i36;
import 'data/general/character/character_starting_equipment_resolution_record.dart'
    as _i37;
import 'data/general/character/character_starting_equipment_selection_data.dart'
    as _i38;
import 'data/general/character/character_starting_equipment_selection_record.dart'
    as _i39;
import 'data/general/character/character_sync_event_record.dart' as _i40;
import 'data/general/character/character_sync_operation_data.dart' as _i41;
import 'data/general/character/character_sync_request.dart' as _i42;
import 'data/general/character/character_sync_response.dart' as _i43;
import 'data/general/character/character_sync_result.dart' as _i44;
import 'data/general/character/character_sync_status.dart' as _i45;
import 'data/general/character/character_sync_value_data.dart' as _i46;
import 'data/general/character/character_tool_proficiency_overrides_data.dart'
    as _i47;
import 'data/general/character/character_weapon_proficiency_overrides_data.dart'
    as _i48;
import 'data/general/character/level_up_request.dart' as _i49;
import 'data/general/character/level_up_spell_choice.dart' as _i50;
import 'data/general/choice_group_data.dart' as _i51;
import 'data/general/choice_option_data.dart' as _i52;
import 'data/general/choice_requirement_data.dart' as _i53;
import 'data/general/class/class_data.dart' as _i54;
import 'auth/auth_action_result.dart' as _i55;
import 'data/general/class/class_level_data.dart' as _i56;
import 'data/general/class/prepared_spell_rule_data.dart' as _i57;
import 'data/general/class/spell_slot_progression_data.dart' as _i58;
import 'data/general/class/starting_equipment_block_data.dart' as _i59;
import 'data/general/class/starting_equipment_entry_data.dart' as _i60;
import 'data/general/class/starting_equipment_line_data.dart' as _i61;
import 'data/general/class/starting_equipment_option_data.dart' as _i62;
import 'data/general/class/subclass_data.dart' as _i63;
import 'data/general/class/subclass_feature_data.dart' as _i64;
import 'data/general/feature_display_property_data.dart' as _i65;
import 'data/general/feature_modifier_condition_data.dart' as _i66;
import 'data/general/feature_modifier_data.dart' as _i67;
import 'data/general/feature_modifier_value_data.dart' as _i68;
import 'data/general/feature_resource_definition_data.dart' as _i69;
import 'data/general/feature_resource_effect_data.dart' as _i70;
import 'data/general/feature_resource_progression_value_data.dart' as _i71;
import 'data/general/race/race_data.dart' as _i72;
import 'data/general/race/race_feature_data.dart' as _i73;
import 'data/general/race/race_feature_spell_grant_data.dart' as _i74;
import 'data/general/race/subrace_data.dart' as _i75;
import 'data/general/tool_data.dart' as _i76;
import 'data/items/armor_data.dart' as _i77;
import 'data/items/item_data.dart' as _i78;
import 'data/items/magic_item_data.dart' as _i79;
import 'data/items/weapon_data.dart' as _i80;
import 'data/spell_data.dart' as _i81;
import 'data/spell_scaling_data.dart' as _i82;
import 'enums/ability.dart' as _i83;
import 'enums/armor_category.dart' as _i84;
import 'enums/character_alignment.dart' as _i85;
import 'enums/character_change_type.dart' as _i86;
import 'enums/character_entity_type.dart' as _i87;
import 'enums/character_feature_source_type.dart' as _i88;
import 'enums/character_inventory_item_type.dart' as _i89;
import 'enums/character_saving_throw_proficiency_override.dart' as _i90;
import 'enums/character_skill_proficiency_level.dart' as _i91;
import 'enums/character_skill_selection_kind.dart' as _i92;
import 'enums/character_speed_kind.dart' as _i93;
import 'enums/character_spell_selection_kind.dart' as _i94;
import 'enums/character_sync_operation_type.dart' as _i95;
import 'enums/character_sync_target_type.dart' as _i96;
import 'enums/choice_requirement_type.dart' as _i97;
import 'enums/choice_source_type.dart' as _i98;
import 'enums/choice_type.dart' as _i99;
import 'enums/class_spell_selection_mode.dart' as _i100;
import 'enums/condition_type.dart' as _i101;
import 'enums/creature_size.dart' as _i102;
import 'enums/damage_type.dart' as _i103;
import 'enums/equipment_catalog_type.dart' as _i104;
import 'enums/feature_display_property_value_kind.dart' as _i105;
import 'enums/feature_modifier_condition_type.dart' as _i106;
import 'views/starting_equipment_option_view.dart' as _i107;
import 'enums/feature_modifier_rounding.dart' as _i108;
import 'enums/feature_modifier_target.dart' as _i109;
import 'enums/feature_modifier_value_kind.dart' as _i110;
import 'enums/feature_resource_effect_type.dart' as _i111;
import 'enums/feature_resource_kind.dart' as _i112;
import 'enums/feature_resource_max_rule.dart' as _i113;
import 'enums/feature_resource_progression_key.dart' as _i114;
import 'enums/feature_resource_target_type.dart' as _i115;
import 'enums/feature_resource_trigger.dart' as _i116;
import 'enums/feature_tag.dart' as _i117;
import 'enums/hit_point_mode.dart' as _i118;
import 'enums/language.dart' as _i119;
import 'enums/prepared_spell_rounding.dart' as _i120;
import 'enums/rest_type.dart' as _i121;
import 'enums/sense_type.dart' as _i122;
import 'enums/skill.dart' as _i123;
import 'enums/spell/area_of_effect_type.dart' as _i124;
import 'enums/spell/spell_attack_type.dart' as _i125;
import 'enums/spell/spell_duration_type.dart' as _i126;
import 'enums/spell/spell_scaling_mode.dart' as _i127;
import 'enums/spell/spell_school.dart' as _i128;
import 'enums/spell/spell_target_type.dart' as _i129;
import 'enums/spellcasting_progression.dart' as _i130;
import 'enums/starting_equipment_block_kind.dart' as _i131;
import 'enums/starting_equipment_entry_kind.dart' as _i132;
import 'enums/starting_equipment_line_kind.dart' as _i133;
import 'enums/tool_category.dart' as _i134;
import 'enums/unarmored_defense_rule.dart' as _i135;
import 'enums/weapon_category.dart' as _i136;
import 'enums/weapon_property.dart' as _i137;
import 'requests/level_down_choice_repair.dart' as _i138;
import 'requests/level_down_request.dart' as _i139;
import 'views/background_step_view.dart' as _i140;
import 'views/character_equipment_entry_view.dart' as _i141;
import 'views/choice_group_view.dart' as _i142;
import 'views/choice_option_eligibility_view.dart' as _i143;
import 'views/choice_requirement_failure_view.dart' as _i144;
import 'views/class_spell_delta_view.dart' as _i145;
import 'views/class_spell_selection_group_view.dart' as _i146;
import 'views/class_step_feature_view.dart' as _i147;
import 'views/class_step_subclass_choice_view.dart' as _i148;
import 'views/class_step_view.dart' as _i149;
import 'views/feature_display_property_view.dart' as _i150;
import 'views/level_down_invalid_choice_view.dart' as _i151;
import 'views/level_down_preview.dart' as _i152;
import 'views/level_up_preview.dart' as _i153;
import 'views/proficiency_bundle_view.dart' as _i154;
import 'views/race_step_view.dart' as _i155;
import 'views/selected_feature_choice_view.dart' as _i156;
import 'views/skill_selection_group_view.dart' as _i157;
import 'views/starting_equipment_block_view.dart' as _i158;
import 'enums/feature_modifier_operation.dart' as _i159;
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _i160;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i161;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i162;
import 'package:characters_mirror_server/src/generated/data/general/choice_group_data.dart'
    as _i163;
import 'package:characters_mirror_server/src/generated/data/general/choice_option_data.dart'
    as _i164;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _i165;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i166;
import 'package:characters_mirror_server/src/generated/data/class_spell_grant_data.dart'
    as _i167;
import 'package:characters_mirror_server/src/generated/data/general/class/class_level_data.dart'
    as _i168;
import 'package:characters_mirror_server/src/generated/data/general/class/spell_slot_progression_data.dart'
    as _i169;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _i170;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _i171;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _i172;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _i173;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _i174;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_spell_grant_data.dart'
    as _i175;
import 'package:characters_mirror_server/src/generated/data/general/tool_data.dart'
    as _i176;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _i177;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _i178;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _i179;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _i180;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _i181;
export 'auth/auth_action_result.dart';
export 'data/background_data.dart';
export 'data/class_spell_grant_data.dart';
export 'data/damage_part_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_applied_change_record.dart';
export 'data/general/character/character_armor_training_overrides_data.dart';
export 'data/general/character/character_attack_data.dart';
export 'data/general/character/character_change_data.dart';
export 'data/general/character/character_choice_data.dart';
export 'data/general/character/character_choice_record.dart';
export 'data/general/character/character_class_entry_data.dart';
export 'data/general/character/character_class_entry_record.dart';
export 'data/general/character/character_data.dart';
export 'data/general/character/character_derived_data.dart';
export 'data/general/character/character_equipment_selection_data.dart';
export 'data/general/character/character_feature_override_data.dart';
export 'data/general/character/character_feature_view_data.dart';
export 'data/general/character/character_inventory_item_data.dart';
export 'data/general/character/character_language_overrides_data.dart';
export 'data/general/character/character_note_data.dart';
export 'data/general/character/character_record.dart';
export 'data/general/character/character_rejected_change_data.dart';
export 'data/general/character/character_resource_state_data.dart';
export 'data/general/character/character_resource_view_data.dart';
export 'data/general/character/character_saving_throw_proficiency_override_data.dart';
export 'data/general/character/character_semantic_action_data.dart';
export 'data/general/character/character_skill_proficiency_state.dart';
export 'data/general/character/character_skill_selection_data.dart';
export 'data/general/character/character_skill_selection_record.dart';
export 'data/general/character/character_spell_selection_data.dart';
export 'data/general/character/character_spell_selection_record.dart';
export 'data/general/character/character_starting_equipment_resolution_data.dart';
export 'data/general/character/character_starting_equipment_resolution_record.dart';
export 'data/general/character/character_starting_equipment_selection_data.dart';
export 'data/general/character/character_starting_equipment_selection_record.dart';
export 'data/general/character/character_sync_event_record.dart';
export 'data/general/character/character_sync_operation_data.dart';
export 'data/general/character/character_sync_request.dart';
export 'data/general/character/character_sync_response.dart';
export 'data/general/character/character_sync_result.dart';
export 'data/general/character/character_sync_status.dart';
export 'data/general/character/character_sync_value_data.dart';
export 'data/general/character/character_tool_proficiency_overrides_data.dart';
export 'data/general/character/character_weapon_proficiency_overrides_data.dart';
export 'data/general/character/level_up_request.dart';
export 'data/general/character/level_up_spell_choice.dart';
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
export 'data/general/feature_resource_definition_data.dart';
export 'data/general/feature_resource_effect_data.dart';
export 'data/general/feature_resource_progression_value_data.dart';
export 'data/general/race/race_data.dart';
export 'data/general/race/race_feature_data.dart';
export 'data/general/race/race_feature_spell_grant_data.dart';
export 'data/general/race/subrace_data.dart';
export 'data/general/tool_data.dart';
export 'data/items/armor_data.dart';
export 'data/items/item_data.dart';
export 'data/items/magic_item_data.dart';
export 'data/items/weapon_data.dart';
export 'data/spell_data.dart';
export 'data/spell_scaling_data.dart';
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
export 'enums/spell/spell_attack_type.dart';
export 'enums/spell/spell_duration_type.dart';
export 'enums/spell/spell_scaling_mode.dart';
export 'enums/spell/spell_school.dart';
export 'enums/spell/spell_target_type.dart';
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
export 'views/selected_feature_choice_view.dart';
export 'views/skill_selection_group_view.dart';
export 'views/starting_equipment_block_view.dart';
export 'views/starting_equipment_option_view.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'armor_data',
      dartName: 'ArmorData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'armor_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'categoryValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ArmorCategory?',
        ),
        _i2.ColumnDefinition(
          name: 'baseAC',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'bonusAC',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dexBonus',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'dexBonusMax',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'strengthRequirement',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'stealthDisadvantage',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'armor_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'armor_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'background_data',
      dartName: 'BackgroundData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'background_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'availableSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'skillCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'toolProficiencyKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'languageCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'items',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'coins',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'feature',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedPersonality',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedIdeal',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedBond',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'suggestedFlaw',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'background_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_applied_changes',
      dartName: 'CharacterAppliedChangeRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_applied_changes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'changeId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'revision',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_applied_changes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'character_applied_changes_user_change_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'changeId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_choice_data',
      dartName: 'CharacterChoiceRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'character_choice_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'syncId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'groupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'optionKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_choice_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_choice_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_choice_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_class_relation',
      dartName: 'CharacterClassEntryRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_class_relation_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'syncId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'subclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isStartingClass',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'classOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'hpMode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:HitPointMode?',
        ),
        _i2.ColumnDefinition(
          name: 'hpRolledValues',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_1',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_2',
          columns: ['subclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_class_relation_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_skill_selection_data',
      dartName: 'CharacterSkillSelectionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_skill_selection_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'syncId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'backgroundDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'skill',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Skill?',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterSkillSelectionKind?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_2',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_3',
          columns: ['backgroundDataId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_skill_selection_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_spell_selection_data',
      dartName: 'CharacterSpellSelectionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_spell_selection_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'syncId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'classEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterSpellSelectionKind?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_2',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_3',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_spell_selection_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_starting_equipment_resolution_data',
      dartName: 'CharacterStartingEquipmentResolutionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_starting_equipment_resolution_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'syncId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceLineEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'catalogType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:EquipmentCatalogType?',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_resolution_data_fk_0',
          columns: ['selectionId'],
          referenceTable: 'character_starting_equipment_selection_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_resolution_data_fk_1',
          columns: ['sourceLineEntryId'],
          referenceTable: 'starting_equipment_entry_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_starting_equipment_resolution_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_starting_equipment_selection_data',
      dartName: 'CharacterStartingEquipmentSelectionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'character_starting_equipment_selection_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'syncId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'sourceType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ChoiceSourceType?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'choiceOptionEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isSelected',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_selection_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_selection_data_fk_1',
          columns: ['sourceEntryId'],
          referenceTable: 'starting_equipment_entry_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_selection_data_fk_2',
          columns: ['choiceOptionEntryId'],
          referenceTable: 'starting_equipment_entry_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_starting_equipment_selection_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'character_sync_events',
      dartName: 'CharacterSyncEventRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'character_sync_events_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'characterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'characterVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'eventType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'changeId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'character_sync_events_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'character_sync_events_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'character_sync_events_character_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'characterId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'characters',
      dartName: 'CharacterRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'characters_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'age',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'height',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'eyes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'skin',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'hair',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'appearance',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'backstory',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'goals',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'alliesOrganizations',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'personalityTraits',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'ideals',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'bonds',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'flaws',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'portraitVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'syncTargetRevisions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'syncBarrierTokens',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'experience',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'alignmentValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterAlignment?',
        ),
        _i2.ColumnDefinition(
          name: 'raceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'backgroundId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'baseAbilityScores',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'customAbilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'useFlexibleAbilityBonuses',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'temporaryHp',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'currentHp',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'deathSaveSuccesses',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'deathSaveFailures',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'hpPerLevelBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'hpFlatBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'currentHitDice',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'hitDiceMaxOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'currentSpellSlots',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'activeConcentrationSpellName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'customInitiativeBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'customArmorClassBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'walkingSpeed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'swimmingSpeed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'climbingSpeed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'flyingSpeed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'displayedSpeedKind',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:CharacterSpeedKind?',
        ),
        _i2.ColumnDefinition(
          name: 'customSpellSaveDcBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'customSpellAttackBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'preparedSpellKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'activeConditions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ConditionType>?',
        ),
        _i2.ColumnDefinition(
          name: 'exhaustionLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'inspiration',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'equipment',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterInventoryItemData>?',
        ),
        _i2.ColumnDefinition(
          name: 'equippedArmor',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterEquipmentSelectionData?',
        ),
        _i2.ColumnDefinition(
          name: 'equippedShield',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterEquipmentSelectionData?',
        ),
        _i2.ColumnDefinition(
          name: 'manualSkillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterSkillProficiencyState>?',
        ),
        _i2.ColumnDefinition(
          name: 'manualSavingThrowProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _i2.ColumnDefinition(
          name: 'manualSkillProficiencyOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterSkillProficiencyState>?',
        ),
        _i2.ColumnDefinition(
          name: 'manualSavingThrowProficiencyOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType:
              'List<protocol:CharacterSavingThrowProficiencyOverrideData>?',
        ),
        _i2.ColumnDefinition(
          name: 'manualLanguageOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterLanguageOverridesData?',
        ),
        _i2.ColumnDefinition(
          name: 'manualToolProficiencyOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterToolProficiencyOverridesData?',
        ),
        _i2.ColumnDefinition(
          name: 'manualWeaponProficiencyOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterWeaponProficiencyOverridesData?',
        ),
        _i2.ColumnDefinition(
          name: 'manualArmorTrainingOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterArmorTrainingOverridesData?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterNoteData>?',
        ),
        _i2.ColumnDefinition(
          name: 'attacks',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterAttackData>?',
        ),
        _i2.ColumnDefinition(
          name: 'featureOverrides',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterFeatureOverrideData>?',
        ),
        _i2.ColumnDefinition(
          name: 'resourceStates',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterResourceStateData>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'characters_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'characters_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'characters_fk_2',
          columns: ['backgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'characters_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'choice_group_data',
      dartName: 'ChoiceGroupData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'choice_group_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubclassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceRaceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceRaceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceBackgroundId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ChoiceType?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'minimumSelectionCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'appliesAtCharacterLevel',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'exclusiveKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'allowDuplicates',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_0',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_1',
          columns: ['sourceSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_2',
          columns: ['sourceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_3',
          columns: ['sourceSubclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_4',
          columns: ['sourceRaceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_5',
          columns: ['sourceSubraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_6',
          columns: ['sourceRaceFeatureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_7',
          columns: ['sourceBackgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'choice_group_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'choice_group_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'choice_option_data',
      dartName: 'ChoiceOptionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'choice_option_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'choiceGroupId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'optionKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shortDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedAbilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedExpertiseSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedExpertiseToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'requiredExistingSkill',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Skill?',
        ),
        _i2.ColumnDefinition(
          name: 'requiredExistingToolKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'requirements',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ChoiceRequirementData>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedFeatureTags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'damageType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AreaOfEffectType?',
        ),
        _i2.ColumnDefinition(
          name: 'areaText',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'damageByLevel',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'choice_option_data_fk_0',
          columns: ['choiceGroupId'],
          referenceTable: 'choice_group_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'choice_option_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'choice_option_group_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'choiceGroupId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'optionKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_data',
      dartName: 'ClassData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'hitDieValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'primaryAbilities',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _i2.ColumnDefinition(
          name: 'savingThrowProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _i2.ColumnDefinition(
          name: 'armorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'weaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolTrainingKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'availableSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'skillCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassChoiceLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassChoiceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingProgression',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellcastingProgression?',
        ),
        _i2.ColumnDefinition(
          name: 'spellSelectionMode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ClassSpellSelectionMode?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingAbilityValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassPrerequisites',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassArmorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassWeaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'multiclassToolTrainingKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'imageURL',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_data_fk_0',
          columns: ['subclassChoiceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'class_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_feature_data',
      dartName: 'ClassFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_feature_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'parentClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shortDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'choiceGroupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedExpertiseSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedExpertiseToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'unarmoredDefenseRule',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:UnarmoredDefenseRule?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedTable',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_feature_data_fk_0',
          columns: ['parentClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_feature_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'class_feature_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_level_data',
      dartName: 'ClassLevelData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_level_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'classDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'subclassDataId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'knownCantrips',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'knownSpells',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellbookSpells',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'knownSpellReplacements',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'preparedSpellRule',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:PreparedSpellRuleData?',
        ),
        _i2.ColumnDefinition(
          name: 'preparedSpellFormula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'resourceSummary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_level_data_fk_0',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_level_data_fk_1',
          columns: ['subclassDataId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_level_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'class_spell_grant_data',
      dartName: 'ClassSpellGrantData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'class_spell_grant_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'spellId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubclassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedAtLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'alwaysPrepared',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'choiceOptionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_0',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_1',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_2',
          columns: ['sourceSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_3',
          columns: ['sourceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_4',
          columns: ['sourceSubclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_5',
          columns: ['choiceOptionId'],
          referenceTable: 'choice_option_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'class_spell_grant_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feat_data',
      dartName: 'FeatData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'feat_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'abilityBonuses',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'traits',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'specialAbilities',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'proficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'prerequisites',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feat_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_display_property_data',
      dartName: 'FeatureDisplayPropertyData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'feature_display_property_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sourceClassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceSubclassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'label',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'valueKind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureDisplayPropertyValueKind',
        ),
        _i2.ColumnDefinition(
          name: 'staticValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'progression',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,String>?',
        ),
        _i2.ColumnDefinition(
          name: 'formula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'sortOrder',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_display_property_data_fk_0',
          columns: ['sourceClassFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_display_property_data_fk_1',
          columns: ['sourceSubclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_display_property_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_display_property_class_feature_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sourceClassFeatureId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_display_property_subclass_feature_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sourceSubclassFeatureId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_modifier_data',
      dartName: 'FeatureModifierData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'feature_modifier_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'classFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'target',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:FeatureModifierTarget',
        ),
        _i2.ColumnDefinition(
          name: 'operation',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:FeatureModifierOperation',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeatureModifierValueData',
        ),
        _i2.ColumnDefinition(
          name: 'conditions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureModifierConditionData>?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_modifier_data_fk_0',
          columns: ['classFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_modifier_data_fk_1',
          columns: ['subclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_modifier_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_modifier_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_modifier_class_feature_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'classFeatureId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'feature_modifier_subclass_feature_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'subclassFeatureId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_resource_definition_data',
      dartName: 'FeatureResourceDefinitionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'feature_resource_definition_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'classFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'raceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'choiceOptionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureResourceKind',
        ),
        _i2.ColumnDefinition(
          name: 'maxRule',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureResourceMaxRule',
        ),
        _i2.ColumnDefinition(
          name: 'maxValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'maxAbility',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'resetOn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'activationTrigger',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceTrigger?',
        ),
        _i2.ColumnDefinition(
          name: 'usageResetOn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'progressionKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceProgressionKey?',
        ),
        _i2.ColumnDefinition(
          name: 'becomesUnlimitedAtLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_0',
          columns: ['classFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_1',
          columns: ['subclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_2',
          columns: ['raceFeatureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_3',
          columns: ['choiceOptionId'],
          referenceTable: 'choice_option_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_resource_definition_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_resource_effect_data',
      dartName: 'FeatureResourceEffectData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'feature_resource_effect_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'classFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'raceFeatureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureResourceEffectType',
        ),
        _i2.ColumnDefinition(
          name: 'choiceOptionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceTargetType?',
        ),
        _i2.ColumnDefinition(
          name: 'targetResourceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'targetSourceType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterFeatureSourceType?',
        ),
        _i2.ColumnDefinition(
          name: 'targetSourceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'amountRule',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceMaxRule?',
        ),
        _i2.ColumnDefinition(
          name: 'amountValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'amountAbility',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'activationTrigger',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceTrigger?',
        ),
        _i2.ColumnDefinition(
          name: 'usageResetOn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'setResetOn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'setMaxRule',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceMaxRule?',
        ),
        _i2.ColumnDefinition(
          name: 'setMaxValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'setMaxAbility',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'addMaxValue',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'setUnlimited',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'becomesUnlimitedAtLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_0',
          columns: ['classFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_1',
          columns: ['subclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_2',
          columns: ['raceFeatureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_3',
          columns: ['choiceOptionId'],
          referenceTable: 'choice_option_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_resource_effect_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'feature_resource_progression_value_data',
      dartName: 'FeatureResourceProgressionValueData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'feature_resource_progression_value_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'resourceDefinitionId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'feature_resource_progression_value_data_fk_0',
          columns: ['resourceDefinitionId'],
          referenceTable: 'feature_resource_definition_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'feature_resource_progression_value_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'item_data',
      dartName: 'ItemData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'item_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'effects',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'item_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'item_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'magic_item_data',
      dartName: 'MagicItemData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'magic_item_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'rarity',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresAttunement',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'attunementCondition',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'bonus',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'charges',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'rechargeCondition',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'effects',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'magic_item_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'magic_item_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_data',
      dartName: 'RaceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'race_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'speed',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'size',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:CreatureSize?',
        ),
        _i2.ColumnDefinition(
          name: 'strengthBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dexterityBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'constitutionBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'intelligenceBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'wisdomBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'charismaBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'traits',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'languages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _i2.ColumnDefinition(
          name: 'visionType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SenseType?',
        ),
        _i2.ColumnDefinition(
          name: 'visionRange',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'resistances',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamageType>?',
        ),
        _i2.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'armorProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'weaponProficiencyKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolProficiencyKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'imageURL',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_feature_data',
      dartName: 'RaceFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'race_feature_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'raceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'subraceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shortDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'usesPerRest',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'usesFormula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_data_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_data_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_feature_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'race_feature_spell_grant_data',
      dartName: 'RaceFeatureSpellGrantData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'race_feature_spell_grant_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'featureId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'spellId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'grantedAtLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'castingAbility',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _i2.ColumnDefinition(
          name: 'freeCastsPerRest',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _i2.ColumnDefinition(
          name: 'freeCastsFormula',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'castAtSpellLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'canAlsoCastWithSpellSlots',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_0',
          columns: ['featureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_1',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'race_feature_spell_grant_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'spell_data',
      dartName: 'SpellData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'spell_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shortDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'schoolValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellSchool?',
        ),
        _i2.ColumnDefinition(
          name: 'castingTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'range',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'duration',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'concentration',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'ritual',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'higherLevel',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'savingThrowAbility',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresSavingThrow',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'attackType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellAttackType?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresAttackRoll',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'damageType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _i2.ColumnDefinition(
          name: 'damageDice',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'damageScaling',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellScalingData?',
        ),
        _i2.ColumnDefinition(
          name: 'damageParts',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamagePartData>?',
        ),
        _i2.ColumnDefinition(
          name: 'conditions',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ConditionType>?',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellTargetType?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AreaOfEffectType?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectSize',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectSecondarySize',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'areaOfEffectHeight',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'materialDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'materialCost',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'materialConsumed',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'durationType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellDurationType?',
        ),
        _i2.ColumnDefinition(
          name: 'isHealing',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'healingDice',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresLineOfSight',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresVerbal',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresSomatic',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'requiresMaterial',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'availableForClassIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _i2.ColumnDefinition(
          name: 'availableForSubclassIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'spell_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'spell_slot_progression_data',
      dartName: 'SpellSlotProgressionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'spell_slot_progression_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'tableKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'spellSlots',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'spell_slot_progression_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'spell_slot_progression_table_level_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'tableKey',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'level',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'starting_equipment_entry_data',
      dartName: 'StartingEquipmentEntryData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'starting_equipment_entry_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'sourceBackgroundId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'parentEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'kind',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:StartingEquipmentEntryKind?',
        ),
        _i2.ColumnDefinition(
          name: 'orderIndex',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'selectionCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'lineKind',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:StartingEquipmentLineKind?',
        ),
        _i2.ColumnDefinition(
          name: 'quantity',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'catalogType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:EquipmentCatalogType?',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'allowedWeaponCategories',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'allowedItemCategories',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'starting_equipment_entry_data_fk_0',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'starting_equipment_entry_data_fk_1',
          columns: ['sourceBackgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'starting_equipment_entry_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'starting_equipment_entry_class_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sourceClassId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'starting_equipment_entry_background_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sourceBackgroundId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'starting_equipment_entry_parent_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'parentEntryId',
            )
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subclass_data',
      dartName: 'SubclassData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subclass_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shortDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'subclassName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'parentClassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'levelRequired',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingStartLevel',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingProgression',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellcastingProgression?',
        ),
        _i2.ColumnDefinition(
          name: 'spellSelectionMode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ClassSpellSelectionMode?',
        ),
        _i2.ColumnDefinition(
          name: 'spellcastingAbilityValue',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subclass_data_fk_0',
          columns: ['parentClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subclass_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'subclass_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subclass_feature_data',
      dartName: 'SubclassFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subclass_feature_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'parentSubclassId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'shortDescription',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'level',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'tags',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _i2.ColumnDefinition(
          name: 'choiceGroupKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedExpertiseSkills',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedExpertiseToolKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'relatedTable',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subclass_feature_data_fk_0',
          columns: ['parentSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subclass_feature_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'subclass_feature_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'subrace_data',
      dartName: 'SubraceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'subrace_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'parentRaceId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'strengthBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'dexterityBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'constitutionBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'intelligenceBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'wisdomBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'charismaBonus',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'traits',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'speedOverride',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'visionRangeOverride',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _i2.ColumnDefinition(
          name: 'resistances',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamageType>?',
        ),
        _i2.ColumnDefinition(
          name: 'armorProficiencies',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _i2.ColumnDefinition(
          name: 'weaponProficiencyKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _i2.ColumnDefinition(
          name: 'toolProficiencyKeys',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'subrace_data_fk_0',
          columns: ['parentRaceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.noAction,
          matchType: null,
        )
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'subrace_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        )
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tool_data',
      dartName: 'ToolData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'tool_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ToolCategory?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tool_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'tool_data_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'weapon_data',
      dartName: 'WeaponData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'weapon_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'referenceKey',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:WeaponCategory?',
        ),
        _i2.ColumnDefinition(
          name: 'damage',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'damageType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _i2.ColumnDefinition(
          name: 'properties',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponProperty>?',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'cost',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'rangeNormal',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'rangeMax',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'weapon_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'weapon_reference_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            )
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i4.ClassFeatureData) {
      return _i4.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i5.BackgroundData) {
      return _i5.BackgroundData.fromJson(data) as T;
    }
    if (t == _i6.ClassSpellGrantData) {
      return _i6.ClassSpellGrantData.fromJson(data) as T;
    }
    if (t == _i7.DamagePartData) {
      return _i7.DamagePartData.fromJson(data) as T;
    }
    if (t == _i8.FeatData) {
      return _i8.FeatData.fromJson(data) as T;
    }
    if (t == _i9.CharacterAppliedChangeRecord) {
      return _i9.CharacterAppliedChangeRecord.fromJson(data) as T;
    }
    if (t == _i10.CharacterArmorTrainingOverridesData) {
      return _i10.CharacterArmorTrainingOverridesData.fromJson(data) as T;
    }
    if (t == _i11.CharacterAttackData) {
      return _i11.CharacterAttackData.fromJson(data) as T;
    }
    if (t == _i12.CharacterChangeData) {
      return _i12.CharacterChangeData.fromJson(data) as T;
    }
    if (t == _i13.CharacterChoiceData) {
      return _i13.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i14.CharacterChoiceRecord) {
      return _i14.CharacterChoiceRecord.fromJson(data) as T;
    }
    if (t == _i15.CharacterClassEntryData) {
      return _i15.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i16.CharacterClassEntryRecord) {
      return _i16.CharacterClassEntryRecord.fromJson(data) as T;
    }
    if (t == _i17.CharacterData) {
      return _i17.CharacterData.fromJson(data) as T;
    }
    if (t == _i18.CharacterDerivedData) {
      return _i18.CharacterDerivedData.fromJson(data) as T;
    }
    if (t == _i19.CharacterEquipmentSelectionData) {
      return _i19.CharacterEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _i20.CharacterFeatureOverrideData) {
      return _i20.CharacterFeatureOverrideData.fromJson(data) as T;
    }
    if (t == _i21.CharacterFeatureViewData) {
      return _i21.CharacterFeatureViewData.fromJson(data) as T;
    }
    if (t == _i22.CharacterInventoryItemData) {
      return _i22.CharacterInventoryItemData.fromJson(data) as T;
    }
    if (t == _i23.CharacterLanguageOverridesData) {
      return _i23.CharacterLanguageOverridesData.fromJson(data) as T;
    }
    if (t == _i24.CharacterNoteData) {
      return _i24.CharacterNoteData.fromJson(data) as T;
    }
    if (t == _i25.CharacterRecord) {
      return _i25.CharacterRecord.fromJson(data) as T;
    }
    if (t == _i26.CharacterRejectedChangeData) {
      return _i26.CharacterRejectedChangeData.fromJson(data) as T;
    }
    if (t == _i27.CharacterResourceStateData) {
      return _i27.CharacterResourceStateData.fromJson(data) as T;
    }
    if (t == _i28.CharacterResourceViewData) {
      return _i28.CharacterResourceViewData.fromJson(data) as T;
    }
    if (t == _i29.CharacterSavingThrowProficiencyOverrideData) {
      return _i29.CharacterSavingThrowProficiencyOverrideData.fromJson(data)
          as T;
    }
    if (t == _i30.CharacterSemanticActionData) {
      return _i30.CharacterSemanticActionData.fromJson(data) as T;
    }
    if (t == _i31.CharacterSkillProficiencyState) {
      return _i31.CharacterSkillProficiencyState.fromJson(data) as T;
    }
    if (t == _i32.CharacterSkillSelectionData) {
      return _i32.CharacterSkillSelectionData.fromJson(data) as T;
    }
    if (t == _i33.CharacterSkillSelectionRecord) {
      return _i33.CharacterSkillSelectionRecord.fromJson(data) as T;
    }
    if (t == _i34.CharacterSpellSelectionData) {
      return _i34.CharacterSpellSelectionData.fromJson(data) as T;
    }
    if (t == _i35.CharacterSpellSelectionRecord) {
      return _i35.CharacterSpellSelectionRecord.fromJson(data) as T;
    }
    if (t == _i36.CharacterStartingEquipmentResolutionData) {
      return _i36.CharacterStartingEquipmentResolutionData.fromJson(data) as T;
    }
    if (t == _i37.CharacterStartingEquipmentResolutionRecord) {
      return _i37.CharacterStartingEquipmentResolutionRecord.fromJson(data)
          as T;
    }
    if (t == _i38.CharacterStartingEquipmentSelectionData) {
      return _i38.CharacterStartingEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _i39.CharacterStartingEquipmentSelectionRecord) {
      return _i39.CharacterStartingEquipmentSelectionRecord.fromJson(data) as T;
    }
    if (t == _i40.CharacterSyncEventRecord) {
      return _i40.CharacterSyncEventRecord.fromJson(data) as T;
    }
    if (t == _i41.CharacterSyncOperationData) {
      return _i41.CharacterSyncOperationData.fromJson(data) as T;
    }
    if (t == _i42.CharacterSyncRequest) {
      return _i42.CharacterSyncRequest.fromJson(data) as T;
    }
    if (t == _i43.CharacterSyncResponse) {
      return _i43.CharacterSyncResponse.fromJson(data) as T;
    }
    if (t == _i44.CharacterSyncResult) {
      return _i44.CharacterSyncResult.fromJson(data) as T;
    }
    if (t == _i45.CharacterSyncStatus) {
      return _i45.CharacterSyncStatus.fromJson(data) as T;
    }
    if (t == _i46.CharacterSyncValueData) {
      return _i46.CharacterSyncValueData.fromJson(data) as T;
    }
    if (t == _i47.CharacterToolProficiencyOverridesData) {
      return _i47.CharacterToolProficiencyOverridesData.fromJson(data) as T;
    }
    if (t == _i48.CharacterWeaponProficiencyOverridesData) {
      return _i48.CharacterWeaponProficiencyOverridesData.fromJson(data) as T;
    }
    if (t == _i49.LevelUpRequest) {
      return _i49.LevelUpRequest.fromJson(data) as T;
    }
    if (t == _i50.LevelUpSpellChoice) {
      return _i50.LevelUpSpellChoice.fromJson(data) as T;
    }
    if (t == _i51.ChoiceGroupData) {
      return _i51.ChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i52.ChoiceOptionData) {
      return _i52.ChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i53.ChoiceRequirementData) {
      return _i53.ChoiceRequirementData.fromJson(data) as T;
    }
    if (t == _i54.ClassData) {
      return _i54.ClassData.fromJson(data) as T;
    }
    if (t == _i55.AuthActionResult) {
      return _i55.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i56.ClassLevelData) {
      return _i56.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i57.PreparedSpellRuleData) {
      return _i57.PreparedSpellRuleData.fromJson(data) as T;
    }
    if (t == _i58.SpellSlotProgressionData) {
      return _i58.SpellSlotProgressionData.fromJson(data) as T;
    }
    if (t == _i59.StartingEquipmentBlockData) {
      return _i59.StartingEquipmentBlockData.fromJson(data) as T;
    }
    if (t == _i60.StartingEquipmentEntryData) {
      return _i60.StartingEquipmentEntryData.fromJson(data) as T;
    }
    if (t == _i61.StartingEquipmentLineData) {
      return _i61.StartingEquipmentLineData.fromJson(data) as T;
    }
    if (t == _i62.StartingEquipmentOptionData) {
      return _i62.StartingEquipmentOptionData.fromJson(data) as T;
    }
    if (t == _i63.SubclassData) {
      return _i63.SubclassData.fromJson(data) as T;
    }
    if (t == _i64.SubclassFeatureData) {
      return _i64.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i65.FeatureDisplayPropertyData) {
      return _i65.FeatureDisplayPropertyData.fromJson(data) as T;
    }
    if (t == _i66.FeatureModifierConditionData) {
      return _i66.FeatureModifierConditionData.fromJson(data) as T;
    }
    if (t == _i67.FeatureModifierData) {
      return _i67.FeatureModifierData.fromJson(data) as T;
    }
    if (t == _i68.FeatureModifierValueData) {
      return _i68.FeatureModifierValueData.fromJson(data) as T;
    }
    if (t == _i69.FeatureResourceDefinitionData) {
      return _i69.FeatureResourceDefinitionData.fromJson(data) as T;
    }
    if (t == _i70.FeatureResourceEffectData) {
      return _i70.FeatureResourceEffectData.fromJson(data) as T;
    }
    if (t == _i71.FeatureResourceProgressionValueData) {
      return _i71.FeatureResourceProgressionValueData.fromJson(data) as T;
    }
    if (t == _i72.RaceData) {
      return _i72.RaceData.fromJson(data) as T;
    }
    if (t == _i73.RaceFeatureData) {
      return _i73.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i74.RaceFeatureSpellGrantData) {
      return _i74.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _i75.SubraceData) {
      return _i75.SubraceData.fromJson(data) as T;
    }
    if (t == _i76.ToolData) {
      return _i76.ToolData.fromJson(data) as T;
    }
    if (t == _i77.ArmorData) {
      return _i77.ArmorData.fromJson(data) as T;
    }
    if (t == _i78.ItemData) {
      return _i78.ItemData.fromJson(data) as T;
    }
    if (t == _i79.MagicItemData) {
      return _i79.MagicItemData.fromJson(data) as T;
    }
    if (t == _i80.WeaponData) {
      return _i80.WeaponData.fromJson(data) as T;
    }
    if (t == _i81.SpellData) {
      return _i81.SpellData.fromJson(data) as T;
    }
    if (t == _i82.SpellScalingData) {
      return _i82.SpellScalingData.fromJson(data) as T;
    }
    if (t == _i83.Ability) {
      return _i83.Ability.fromJson(data) as T;
    }
    if (t == _i84.ArmorCategory) {
      return _i84.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i85.CharacterAlignment) {
      return _i85.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i86.CharacterChangeType) {
      return _i86.CharacterChangeType.fromJson(data) as T;
    }
    if (t == _i87.CharacterEntityType) {
      return _i87.CharacterEntityType.fromJson(data) as T;
    }
    if (t == _i88.CharacterFeatureSourceType) {
      return _i88.CharacterFeatureSourceType.fromJson(data) as T;
    }
    if (t == _i89.CharacterInventoryItemType) {
      return _i89.CharacterInventoryItemType.fromJson(data) as T;
    }
    if (t == _i90.CharacterSavingThrowProficiencyOverride) {
      return _i90.CharacterSavingThrowProficiencyOverride.fromJson(data) as T;
    }
    if (t == _i91.CharacterSkillProficiencyLevel) {
      return _i91.CharacterSkillProficiencyLevel.fromJson(data) as T;
    }
    if (t == _i92.CharacterSkillSelectionKind) {
      return _i92.CharacterSkillSelectionKind.fromJson(data) as T;
    }
    if (t == _i93.CharacterSpeedKind) {
      return _i93.CharacterSpeedKind.fromJson(data) as T;
    }
    if (t == _i94.CharacterSpellSelectionKind) {
      return _i94.CharacterSpellSelectionKind.fromJson(data) as T;
    }
    if (t == _i95.CharacterSyncOperationType) {
      return _i95.CharacterSyncOperationType.fromJson(data) as T;
    }
    if (t == _i96.CharacterSyncTargetType) {
      return _i96.CharacterSyncTargetType.fromJson(data) as T;
    }
    if (t == _i97.ChoiceRequirementType) {
      return _i97.ChoiceRequirementType.fromJson(data) as T;
    }
    if (t == _i98.ChoiceSourceType) {
      return _i98.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i99.ChoiceType) {
      return _i99.ChoiceType.fromJson(data) as T;
    }
    if (t == _i100.ClassSpellSelectionMode) {
      return _i100.ClassSpellSelectionMode.fromJson(data) as T;
    }
    if (t == _i101.ConditionType) {
      return _i101.ConditionType.fromJson(data) as T;
    }
    if (t == _i102.CreatureSize) {
      return _i102.CreatureSize.fromJson(data) as T;
    }
    if (t == _i103.DamageType) {
      return _i103.DamageType.fromJson(data) as T;
    }
    if (t == _i104.EquipmentCatalogType) {
      return _i104.EquipmentCatalogType.fromJson(data) as T;
    }
    if (t == _i105.FeatureDisplayPropertyValueKind) {
      return _i105.FeatureDisplayPropertyValueKind.fromJson(data) as T;
    }
    if (t == _i106.FeatureModifierConditionType) {
      return _i106.FeatureModifierConditionType.fromJson(data) as T;
    }
    if (t == _i107.StartingEquipmentOptionView) {
      return _i107.StartingEquipmentOptionView.fromJson(data) as T;
    }
    if (t == _i108.FeatureModifierRounding) {
      return _i108.FeatureModifierRounding.fromJson(data) as T;
    }
    if (t == _i109.FeatureModifierTarget) {
      return _i109.FeatureModifierTarget.fromJson(data) as T;
    }
    if (t == _i110.FeatureModifierValueKind) {
      return _i110.FeatureModifierValueKind.fromJson(data) as T;
    }
    if (t == _i111.FeatureResourceEffectType) {
      return _i111.FeatureResourceEffectType.fromJson(data) as T;
    }
    if (t == _i112.FeatureResourceKind) {
      return _i112.FeatureResourceKind.fromJson(data) as T;
    }
    if (t == _i113.FeatureResourceMaxRule) {
      return _i113.FeatureResourceMaxRule.fromJson(data) as T;
    }
    if (t == _i114.FeatureResourceProgressionKey) {
      return _i114.FeatureResourceProgressionKey.fromJson(data) as T;
    }
    if (t == _i115.FeatureResourceTargetType) {
      return _i115.FeatureResourceTargetType.fromJson(data) as T;
    }
    if (t == _i116.FeatureResourceTrigger) {
      return _i116.FeatureResourceTrigger.fromJson(data) as T;
    }
    if (t == _i117.FeatureTag) {
      return _i117.FeatureTag.fromJson(data) as T;
    }
    if (t == _i118.HitPointMode) {
      return _i118.HitPointMode.fromJson(data) as T;
    }
    if (t == _i119.Language) {
      return _i119.Language.fromJson(data) as T;
    }
    if (t == _i120.PreparedSpellRounding) {
      return _i120.PreparedSpellRounding.fromJson(data) as T;
    }
    if (t == _i121.RestType) {
      return _i121.RestType.fromJson(data) as T;
    }
    if (t == _i122.SenseType) {
      return _i122.SenseType.fromJson(data) as T;
    }
    if (t == _i123.Skill) {
      return _i123.Skill.fromJson(data) as T;
    }
    if (t == _i124.AreaOfEffectType) {
      return _i124.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _i125.SpellAttackType) {
      return _i125.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i126.SpellDurationType) {
      return _i126.SpellDurationType.fromJson(data) as T;
    }
    if (t == _i127.SpellScalingMode) {
      return _i127.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _i128.SpellSchool) {
      return _i128.SpellSchool.fromJson(data) as T;
    }
    if (t == _i129.SpellTargetType) {
      return _i129.SpellTargetType.fromJson(data) as T;
    }
    if (t == _i130.SpellcastingProgression) {
      return _i130.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i131.StartingEquipmentBlockKind) {
      return _i131.StartingEquipmentBlockKind.fromJson(data) as T;
    }
    if (t == _i132.StartingEquipmentEntryKind) {
      return _i132.StartingEquipmentEntryKind.fromJson(data) as T;
    }
    if (t == _i133.StartingEquipmentLineKind) {
      return _i133.StartingEquipmentLineKind.fromJson(data) as T;
    }
    if (t == _i134.ToolCategory) {
      return _i134.ToolCategory.fromJson(data) as T;
    }
    if (t == _i135.UnarmoredDefenseRule) {
      return _i135.UnarmoredDefenseRule.fromJson(data) as T;
    }
    if (t == _i136.WeaponCategory) {
      return _i136.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i137.WeaponProperty) {
      return _i137.WeaponProperty.fromJson(data) as T;
    }
    if (t == _i138.LevelDownChoiceRepair) {
      return _i138.LevelDownChoiceRepair.fromJson(data) as T;
    }
    if (t == _i139.LevelDownRequest) {
      return _i139.LevelDownRequest.fromJson(data) as T;
    }
    if (t == _i140.BackgroundStepView) {
      return _i140.BackgroundStepView.fromJson(data) as T;
    }
    if (t == _i141.CharacterEquipmentEntryView) {
      return _i141.CharacterEquipmentEntryView.fromJson(data) as T;
    }
    if (t == _i142.ChoiceGroupView) {
      return _i142.ChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i143.ChoiceOptionEligibilityView) {
      return _i143.ChoiceOptionEligibilityView.fromJson(data) as T;
    }
    if (t == _i144.ChoiceRequirementFailureView) {
      return _i144.ChoiceRequirementFailureView.fromJson(data) as T;
    }
    if (t == _i145.ClassSpellDeltaView) {
      return _i145.ClassSpellDeltaView.fromJson(data) as T;
    }
    if (t == _i146.ClassSpellSelectionGroupView) {
      return _i146.ClassSpellSelectionGroupView.fromJson(data) as T;
    }
    if (t == _i147.ClassStepFeatureView) {
      return _i147.ClassStepFeatureView.fromJson(data) as T;
    }
    if (t == _i148.ClassStepSubclassChoiceView) {
      return _i148.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i149.ClassStepView) {
      return _i149.ClassStepView.fromJson(data) as T;
    }
    if (t == _i150.FeatureDisplayPropertyView) {
      return _i150.FeatureDisplayPropertyView.fromJson(data) as T;
    }
    if (t == _i151.LevelDownInvalidChoiceView) {
      return _i151.LevelDownInvalidChoiceView.fromJson(data) as T;
    }
    if (t == _i152.LevelDownPreview) {
      return _i152.LevelDownPreview.fromJson(data) as T;
    }
    if (t == _i153.LevelUpPreview) {
      return _i153.LevelUpPreview.fromJson(data) as T;
    }
    if (t == _i154.ProficiencyBundleView) {
      return _i154.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i155.RaceStepView) {
      return _i155.RaceStepView.fromJson(data) as T;
    }
    if (t == _i156.SelectedFeatureChoiceView) {
      return _i156.SelectedFeatureChoiceView.fromJson(data) as T;
    }
    if (t == _i157.SkillSelectionGroupView) {
      return _i157.SkillSelectionGroupView.fromJson(data) as T;
    }
    if (t == _i158.StartingEquipmentBlockView) {
      return _i158.StartingEquipmentBlockView.fromJson(data) as T;
    }
    if (t == _i159.FeatureModifierOperation) {
      return _i159.FeatureModifierOperation.fromJson(data) as T;
    }
    if (t == _i1.getType<_i4.ClassFeatureData?>()) {
      return (data != null ? _i4.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BackgroundData?>()) {
      return (data != null ? _i5.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ClassSpellGrantData?>()) {
      return (data != null ? _i6.ClassSpellGrantData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.DamagePartData?>()) {
      return (data != null ? _i7.DamagePartData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.FeatData?>()) {
      return (data != null ? _i8.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CharacterAppliedChangeRecord?>()) {
      return (data != null
          ? _i9.CharacterAppliedChangeRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i10.CharacterArmorTrainingOverridesData?>()) {
      return (data != null
          ? _i10.CharacterArmorTrainingOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i11.CharacterAttackData?>()) {
      return (data != null ? _i11.CharacterAttackData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.CharacterChangeData?>()) {
      return (data != null ? _i12.CharacterChangeData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.CharacterChoiceData?>()) {
      return (data != null ? _i13.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.CharacterChoiceRecord?>()) {
      return (data != null ? _i14.CharacterChoiceRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.CharacterClassEntryData?>()) {
      return (data != null ? _i15.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.CharacterClassEntryRecord?>()) {
      return (data != null
          ? _i16.CharacterClassEntryRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i17.CharacterData?>()) {
      return (data != null ? _i17.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.CharacterDerivedData?>()) {
      return (data != null ? _i18.CharacterDerivedData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.CharacterEquipmentSelectionData?>()) {
      return (data != null
          ? _i19.CharacterEquipmentSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i20.CharacterFeatureOverrideData?>()) {
      return (data != null
          ? _i20.CharacterFeatureOverrideData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i21.CharacterFeatureViewData?>()) {
      return (data != null
          ? _i21.CharacterFeatureViewData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i22.CharacterInventoryItemData?>()) {
      return (data != null
          ? _i22.CharacterInventoryItemData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i23.CharacterLanguageOverridesData?>()) {
      return (data != null
          ? _i23.CharacterLanguageOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i24.CharacterNoteData?>()) {
      return (data != null ? _i24.CharacterNoteData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.CharacterRecord?>()) {
      return (data != null ? _i25.CharacterRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.CharacterRejectedChangeData?>()) {
      return (data != null
          ? _i26.CharacterRejectedChangeData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i27.CharacterResourceStateData?>()) {
      return (data != null
          ? _i27.CharacterResourceStateData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i28.CharacterResourceViewData?>()) {
      return (data != null
          ? _i28.CharacterResourceViewData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i29.CharacterSavingThrowProficiencyOverrideData?>()) {
      return (data != null
          ? _i29.CharacterSavingThrowProficiencyOverrideData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i30.CharacterSemanticActionData?>()) {
      return (data != null
          ? _i30.CharacterSemanticActionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i31.CharacterSkillProficiencyState?>()) {
      return (data != null
          ? _i31.CharacterSkillProficiencyState.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i32.CharacterSkillSelectionData?>()) {
      return (data != null
          ? _i32.CharacterSkillSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i33.CharacterSkillSelectionRecord?>()) {
      return (data != null
          ? _i33.CharacterSkillSelectionRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i34.CharacterSpellSelectionData?>()) {
      return (data != null
          ? _i34.CharacterSpellSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i35.CharacterSpellSelectionRecord?>()) {
      return (data != null
          ? _i35.CharacterSpellSelectionRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i36.CharacterStartingEquipmentResolutionData?>()) {
      return (data != null
          ? _i36.CharacterStartingEquipmentResolutionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i37.CharacterStartingEquipmentResolutionRecord?>()) {
      return (data != null
          ? _i37.CharacterStartingEquipmentResolutionRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i38.CharacterStartingEquipmentSelectionData?>()) {
      return (data != null
          ? _i38.CharacterStartingEquipmentSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i39.CharacterStartingEquipmentSelectionRecord?>()) {
      return (data != null
          ? _i39.CharacterStartingEquipmentSelectionRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i40.CharacterSyncEventRecord?>()) {
      return (data != null
          ? _i40.CharacterSyncEventRecord.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i41.CharacterSyncOperationData?>()) {
      return (data != null
          ? _i41.CharacterSyncOperationData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i42.CharacterSyncRequest?>()) {
      return (data != null ? _i42.CharacterSyncRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.CharacterSyncResponse?>()) {
      return (data != null ? _i43.CharacterSyncResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i44.CharacterSyncResult?>()) {
      return (data != null ? _i44.CharacterSyncResult.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.CharacterSyncStatus?>()) {
      return (data != null ? _i45.CharacterSyncStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.CharacterSyncValueData?>()) {
      return (data != null ? _i46.CharacterSyncValueData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i47.CharacterToolProficiencyOverridesData?>()) {
      return (data != null
          ? _i47.CharacterToolProficiencyOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i48.CharacterWeaponProficiencyOverridesData?>()) {
      return (data != null
          ? _i48.CharacterWeaponProficiencyOverridesData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i49.LevelUpRequest?>()) {
      return (data != null ? _i49.LevelUpRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.LevelUpSpellChoice?>()) {
      return (data != null ? _i50.LevelUpSpellChoice.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.ChoiceGroupData?>()) {
      return (data != null ? _i51.ChoiceGroupData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.ChoiceOptionData?>()) {
      return (data != null ? _i52.ChoiceOptionData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.ChoiceRequirementData?>()) {
      return (data != null ? _i53.ChoiceRequirementData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.ClassData?>()) {
      return (data != null ? _i54.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.AuthActionResult?>()) {
      return (data != null ? _i55.AuthActionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.ClassLevelData?>()) {
      return (data != null ? _i56.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.PreparedSpellRuleData?>()) {
      return (data != null ? _i57.PreparedSpellRuleData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.SpellSlotProgressionData?>()) {
      return (data != null
          ? _i58.SpellSlotProgressionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i59.StartingEquipmentBlockData?>()) {
      return (data != null
          ? _i59.StartingEquipmentBlockData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i60.StartingEquipmentEntryData?>()) {
      return (data != null
          ? _i60.StartingEquipmentEntryData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i61.StartingEquipmentLineData?>()) {
      return (data != null
          ? _i61.StartingEquipmentLineData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i62.StartingEquipmentOptionData?>()) {
      return (data != null
          ? _i62.StartingEquipmentOptionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i63.SubclassData?>()) {
      return (data != null ? _i63.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.SubclassFeatureData?>()) {
      return (data != null ? _i64.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.FeatureDisplayPropertyData?>()) {
      return (data != null
          ? _i65.FeatureDisplayPropertyData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i66.FeatureModifierConditionData?>()) {
      return (data != null
          ? _i66.FeatureModifierConditionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i67.FeatureModifierData?>()) {
      return (data != null ? _i67.FeatureModifierData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i68.FeatureModifierValueData?>()) {
      return (data != null
          ? _i68.FeatureModifierValueData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i69.FeatureResourceDefinitionData?>()) {
      return (data != null
          ? _i69.FeatureResourceDefinitionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i70.FeatureResourceEffectData?>()) {
      return (data != null
          ? _i70.FeatureResourceEffectData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i71.FeatureResourceProgressionValueData?>()) {
      return (data != null
          ? _i71.FeatureResourceProgressionValueData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i72.RaceData?>()) {
      return (data != null ? _i72.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i73.RaceFeatureData?>()) {
      return (data != null ? _i73.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i74.RaceFeatureSpellGrantData?>()) {
      return (data != null
          ? _i74.RaceFeatureSpellGrantData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i75.SubraceData?>()) {
      return (data != null ? _i75.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i76.ToolData?>()) {
      return (data != null ? _i76.ToolData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i77.ArmorData?>()) {
      return (data != null ? _i77.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i78.ItemData?>()) {
      return (data != null ? _i78.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i79.MagicItemData?>()) {
      return (data != null ? _i79.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i80.WeaponData?>()) {
      return (data != null ? _i80.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i81.SpellData?>()) {
      return (data != null ? _i81.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i82.SpellScalingData?>()) {
      return (data != null ? _i82.SpellScalingData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i83.Ability?>()) {
      return (data != null ? _i83.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i84.ArmorCategory?>()) {
      return (data != null ? _i84.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i85.CharacterAlignment?>()) {
      return (data != null ? _i85.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i86.CharacterChangeType?>()) {
      return (data != null ? _i86.CharacterChangeType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i87.CharacterEntityType?>()) {
      return (data != null ? _i87.CharacterEntityType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i88.CharacterFeatureSourceType?>()) {
      return (data != null
          ? _i88.CharacterFeatureSourceType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i89.CharacterInventoryItemType?>()) {
      return (data != null
          ? _i89.CharacterInventoryItemType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i90.CharacterSavingThrowProficiencyOverride?>()) {
      return (data != null
          ? _i90.CharacterSavingThrowProficiencyOverride.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i91.CharacterSkillProficiencyLevel?>()) {
      return (data != null
          ? _i91.CharacterSkillProficiencyLevel.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i92.CharacterSkillSelectionKind?>()) {
      return (data != null
          ? _i92.CharacterSkillSelectionKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i93.CharacterSpeedKind?>()) {
      return (data != null ? _i93.CharacterSpeedKind.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i94.CharacterSpellSelectionKind?>()) {
      return (data != null
          ? _i94.CharacterSpellSelectionKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i95.CharacterSyncOperationType?>()) {
      return (data != null
          ? _i95.CharacterSyncOperationType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i96.CharacterSyncTargetType?>()) {
      return (data != null ? _i96.CharacterSyncTargetType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i97.ChoiceRequirementType?>()) {
      return (data != null ? _i97.ChoiceRequirementType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i98.ChoiceSourceType?>()) {
      return (data != null ? _i98.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i99.ChoiceType?>()) {
      return (data != null ? _i99.ChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i100.ClassSpellSelectionMode?>()) {
      return (data != null
          ? _i100.ClassSpellSelectionMode.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i101.ConditionType?>()) {
      return (data != null ? _i101.ConditionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i102.CreatureSize?>()) {
      return (data != null ? _i102.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i103.DamageType?>()) {
      return (data != null ? _i103.DamageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i104.EquipmentCatalogType?>()) {
      return (data != null ? _i104.EquipmentCatalogType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i105.FeatureDisplayPropertyValueKind?>()) {
      return (data != null
          ? _i105.FeatureDisplayPropertyValueKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i106.FeatureModifierConditionType?>()) {
      return (data != null
          ? _i106.FeatureModifierConditionType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i107.StartingEquipmentOptionView?>()) {
      return (data != null
          ? _i107.StartingEquipmentOptionView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i108.FeatureModifierRounding?>()) {
      return (data != null
          ? _i108.FeatureModifierRounding.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i109.FeatureModifierTarget?>()) {
      return (data != null ? _i109.FeatureModifierTarget.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i110.FeatureModifierValueKind?>()) {
      return (data != null
          ? _i110.FeatureModifierValueKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i111.FeatureResourceEffectType?>()) {
      return (data != null
          ? _i111.FeatureResourceEffectType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i112.FeatureResourceKind?>()) {
      return (data != null ? _i112.FeatureResourceKind.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i113.FeatureResourceMaxRule?>()) {
      return (data != null ? _i113.FeatureResourceMaxRule.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i114.FeatureResourceProgressionKey?>()) {
      return (data != null
          ? _i114.FeatureResourceProgressionKey.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i115.FeatureResourceTargetType?>()) {
      return (data != null
          ? _i115.FeatureResourceTargetType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i116.FeatureResourceTrigger?>()) {
      return (data != null ? _i116.FeatureResourceTrigger.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i117.FeatureTag?>()) {
      return (data != null ? _i117.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i118.HitPointMode?>()) {
      return (data != null ? _i118.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i119.Language?>()) {
      return (data != null ? _i119.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i120.PreparedSpellRounding?>()) {
      return (data != null ? _i120.PreparedSpellRounding.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i121.RestType?>()) {
      return (data != null ? _i121.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i122.SenseType?>()) {
      return (data != null ? _i122.SenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i123.Skill?>()) {
      return (data != null ? _i123.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i124.AreaOfEffectType?>()) {
      return (data != null ? _i124.AreaOfEffectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i125.SpellAttackType?>()) {
      return (data != null ? _i125.SpellAttackType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i126.SpellDurationType?>()) {
      return (data != null ? _i126.SpellDurationType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i127.SpellScalingMode?>()) {
      return (data != null ? _i127.SpellScalingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i128.SpellSchool?>()) {
      return (data != null ? _i128.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i129.SpellTargetType?>()) {
      return (data != null ? _i129.SpellTargetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i130.SpellcastingProgression?>()) {
      return (data != null
          ? _i130.SpellcastingProgression.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i131.StartingEquipmentBlockKind?>()) {
      return (data != null
          ? _i131.StartingEquipmentBlockKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i132.StartingEquipmentEntryKind?>()) {
      return (data != null
          ? _i132.StartingEquipmentEntryKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i133.StartingEquipmentLineKind?>()) {
      return (data != null
          ? _i133.StartingEquipmentLineKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i134.ToolCategory?>()) {
      return (data != null ? _i134.ToolCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i135.UnarmoredDefenseRule?>()) {
      return (data != null ? _i135.UnarmoredDefenseRule.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i136.WeaponCategory?>()) {
      return (data != null ? _i136.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i137.WeaponProperty?>()) {
      return (data != null ? _i137.WeaponProperty.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i138.LevelDownChoiceRepair?>()) {
      return (data != null ? _i138.LevelDownChoiceRepair.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i139.LevelDownRequest?>()) {
      return (data != null ? _i139.LevelDownRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i140.BackgroundStepView?>()) {
      return (data != null ? _i140.BackgroundStepView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i141.CharacterEquipmentEntryView?>()) {
      return (data != null
          ? _i141.CharacterEquipmentEntryView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i142.ChoiceGroupView?>()) {
      return (data != null ? _i142.ChoiceGroupView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i143.ChoiceOptionEligibilityView?>()) {
      return (data != null
          ? _i143.ChoiceOptionEligibilityView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i144.ChoiceRequirementFailureView?>()) {
      return (data != null
          ? _i144.ChoiceRequirementFailureView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i145.ClassSpellDeltaView?>()) {
      return (data != null ? _i145.ClassSpellDeltaView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i146.ClassSpellSelectionGroupView?>()) {
      return (data != null
          ? _i146.ClassSpellSelectionGroupView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i147.ClassStepFeatureView?>()) {
      return (data != null ? _i147.ClassStepFeatureView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i148.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i148.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i149.ClassStepView?>()) {
      return (data != null ? _i149.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i150.FeatureDisplayPropertyView?>()) {
      return (data != null
          ? _i150.FeatureDisplayPropertyView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i151.LevelDownInvalidChoiceView?>()) {
      return (data != null
          ? _i151.LevelDownInvalidChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i152.LevelDownPreview?>()) {
      return (data != null ? _i152.LevelDownPreview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i153.LevelUpPreview?>()) {
      return (data != null ? _i153.LevelUpPreview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i154.ProficiencyBundleView?>()) {
      return (data != null ? _i154.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i155.RaceStepView?>()) {
      return (data != null ? _i155.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i156.SelectedFeatureChoiceView?>()) {
      return (data != null
          ? _i156.SelectedFeatureChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i157.SkillSelectionGroupView?>()) {
      return (data != null
          ? _i157.SkillSelectionGroupView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i158.StartingEquipmentBlockView?>()) {
      return (data != null
          ? _i158.StartingEquipmentBlockView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i159.FeatureModifierOperation?>()) {
      return (data != null
          ? _i159.FeatureModifierOperation.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i69.FeatureResourceDefinitionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i69.FeatureResourceDefinitionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i70.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i70.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.ClassSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i6.ClassSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i67.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
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
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.DamagePartData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.DamagePartData>(e))
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i101.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i101.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.CharacterInventoryItemData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.CharacterInventoryItemData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<
            List<_i29.CharacterSavingThrowProficiencyOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i29.CharacterSavingThrowProficiencyOverrideData>(
                      e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.CharacterNoteData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i24.CharacterNoteData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.CharacterAttackData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.CharacterAttackData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.CharacterFeatureOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.CharacterFeatureOverrideData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.CharacterResourceStateData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.CharacterResourceStateData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i32.CharacterSkillSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i32.CharacterSkillSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i34.CharacterSpellSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i34.CharacterSpellSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i38.CharacterStartingEquipmentSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i38.CharacterStartingEquipmentSelectionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<_i83.Ability, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i83.Ability>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<_i83.Ability, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i83.Ability>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i21.CharacterFeatureViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i21.CharacterFeatureViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i67.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<_i83.Ability, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i83.Ability>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<Map<_i123.Skill, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) => MapEntry(
              deserialize<_i123.Skill>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
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
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
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
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i141.CharacterEquipmentEntryView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i141.CharacterEquipmentEntryView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i103.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i103.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.CharacterResourceViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.CharacterResourceViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i150.FeatureDisplayPropertyView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i150.FeatureDisplayPropertyView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i156.SelectedFeatureChoiceView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i156.SelectedFeatureChoiceView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i101.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i101.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.CharacterInventoryItemData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.CharacterInventoryItemData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.CharacterSkillProficiencyState>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<
            List<_i29.CharacterSavingThrowProficiencyOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i29.CharacterSavingThrowProficiencyOverrideData>(
                      e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.CharacterNoteData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i24.CharacterNoteData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.CharacterAttackData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.CharacterAttackData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.CharacterFeatureOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.CharacterFeatureOverrideData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.CharacterResourceStateData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.CharacterResourceStateData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i36.CharacterStartingEquipmentResolutionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i36.CharacterStartingEquipmentResolutionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.CharacterChangeData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.CharacterChangeData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.CharacterSyncOperationData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i41.CharacterSyncOperationData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.CharacterRejectedChangeData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i26.CharacterRejectedChangeData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.CharacterData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.CharacterData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, _i17.CharacterData>?>()) {
      return (data != null
          ? (data as Map).map((k, v) => MapEntry(
              deserialize<String>(k), deserialize<_i17.CharacterData>(v)))
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
    if (t == _i1.getType<List<_i101.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i101.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
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
    if (t == _i1.getType<List<_i31.CharacterSkillProficiencyState>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i31.CharacterSkillProficiencyState>(e))
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
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
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
    if (t == _i1.getType<Map<String, List<String>>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<List<String>>(v)))
          : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<_i50.LevelUpSpellChoice>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i50.LevelUpSpellChoice>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i53.ChoiceRequirementData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i53.ChoiceRequirementData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
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
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i62.StartingEquipmentOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i62.StartingEquipmentOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i69.FeatureResourceDefinitionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i69.FeatureResourceDefinitionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i70.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i70.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.ClassSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i6.ClassSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i67.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, String>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<String>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i66.FeatureModifierConditionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i66.FeatureModifierConditionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
          : null) as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i71.FeatureResourceProgressionValueData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i71.FeatureResourceProgressionValueData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i103.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i103.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i73.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i73.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i69.FeatureResourceDefinitionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i69.FeatureResourceDefinitionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i70.FeatureResourceEffectData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i70.FeatureResourceEffectData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i117.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i117.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i74.RaceFeatureSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i74.RaceFeatureSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i103.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i103.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
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
    if (t == _i1.getType<List<_i73.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i73.RaceFeatureData>(e))
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
    if (t == _i1.getType<List<_i137.WeaponProperty>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i137.WeaponProperty>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.DamagePartData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.DamagePartData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i101.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i101.ConditionType>(e))
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
    if (t == _i1.getType<List<_i61.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i138.LevelDownChoiceRepair>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i138.LevelDownChoiceRepair>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.ChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.ChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i157.SkillSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i157.SkillSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i158.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i158.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.ChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i52.ChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i143.ChoiceOptionEligibilityView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i143.ChoiceOptionEligibilityView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i144.ChoiceRequirementFailureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i144.ChoiceRequirementFailureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i81.SpellData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i81.SpellData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i150.FeatureDisplayPropertyView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i150.FeatureDisplayPropertyView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.CharacterResourceViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.CharacterResourceViewData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i63.SubclassData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i63.SubclassData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i64.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i64.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i147.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i147.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i147.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i147.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i147.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i147.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i147.ClassStepFeatureView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i147.ClassStepFeatureView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.ChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.ChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i157.SkillSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i157.SkillSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i146.ClassSpellSelectionGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i146.ClassSpellSelectionGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i158.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i158.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i56.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i56.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i67.FeatureModifierData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i67.FeatureModifierData>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i4.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i4.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i64.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i64.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i51.ChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i51.ChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i13.CharacterChoiceData>) {
      return (data as List)
          .map((e) => deserialize<_i13.CharacterChoiceData>(e))
          .toList() as T;
    }
    if (t == List<_i151.LevelDownInvalidChoiceView>) {
      return (data as List)
          .map((e) => deserialize<_i151.LevelDownInvalidChoiceView>(e))
          .toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    if (t == Map<int, int>) {
      return Map.fromEntries((data as List).map((e) =>
          MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v'])))) as T;
    }
    if (t == List<_i142.ChoiceGroupView>) {
      return (data as List)
          .map((e) => deserialize<_i142.ChoiceGroupView>(e))
          .toList() as T;
    }
    if (t == _i1.getType<List<_i83.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i83.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i84.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i84.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i136.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i136.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i119.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i119.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i75.SubraceData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i75.SubraceData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i73.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i73.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i142.ChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i142.ChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i123.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i123.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i61.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i61.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i107.StartingEquipmentOptionView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i107.StartingEquipmentOptionView>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i3.UserInfo>) {
      return (data as List).map((e) => deserialize<_i3.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i160.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i160.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i161.FeatData>) {
      return (data as List).map((e) => deserialize<_i161.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i162.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i162.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i163.ChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i163.ChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i164.ChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i164.ChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i165.ClassData>) {
      return (data as List).map((e) => deserialize<_i165.ClassData>(e)).toList()
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
    if (t == List<_i166.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i166.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i167.ClassSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i167.ClassSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i168.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i168.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i169.SpellSlotProgressionData>) {
      return (data as List)
          .map((e) => deserialize<_i169.SpellSlotProgressionData>(e))
          .toList() as T;
    }
    if (t == List<_i170.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i170.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i171.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i171.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i172.RaceData>) {
      return (data as List).map((e) => deserialize<_i172.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i173.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i173.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i174.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i174.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i175.RaceFeatureSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i175.RaceFeatureSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i176.ToolData>) {
      return (data as List).map((e) => deserialize<_i176.ToolData>(e)).toList()
          as T;
    }
    if (t == List<_i177.ArmorData>) {
      return (data as List).map((e) => deserialize<_i177.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i178.ItemData>) {
      return (data as List).map((e) => deserialize<_i178.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i179.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i179.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i180.WeaponData>) {
      return (data as List)
          .map((e) => deserialize<_i180.WeaponData>(e))
          .toList() as T;
    }
    if (t == List<_i181.SpellData>) {
      return (data as List).map((e) => deserialize<_i181.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i4.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i5.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i6.ClassSpellGrantData) {
      return 'ClassSpellGrantData';
    }
    if (data is _i7.DamagePartData) {
      return 'DamagePartData';
    }
    if (data is _i8.FeatData) {
      return 'FeatData';
    }
    if (data is _i9.CharacterAppliedChangeRecord) {
      return 'CharacterAppliedChangeRecord';
    }
    if (data is _i10.CharacterArmorTrainingOverridesData) {
      return 'CharacterArmorTrainingOverridesData';
    }
    if (data is _i11.CharacterAttackData) {
      return 'CharacterAttackData';
    }
    if (data is _i12.CharacterChangeData) {
      return 'CharacterChangeData';
    }
    if (data is _i13.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i14.CharacterChoiceRecord) {
      return 'CharacterChoiceRecord';
    }
    if (data is _i15.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i16.CharacterClassEntryRecord) {
      return 'CharacterClassEntryRecord';
    }
    if (data is _i17.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i18.CharacterDerivedData) {
      return 'CharacterDerivedData';
    }
    if (data is _i19.CharacterEquipmentSelectionData) {
      return 'CharacterEquipmentSelectionData';
    }
    if (data is _i20.CharacterFeatureOverrideData) {
      return 'CharacterFeatureOverrideData';
    }
    if (data is _i21.CharacterFeatureViewData) {
      return 'CharacterFeatureViewData';
    }
    if (data is _i22.CharacterInventoryItemData) {
      return 'CharacterInventoryItemData';
    }
    if (data is _i23.CharacterLanguageOverridesData) {
      return 'CharacterLanguageOverridesData';
    }
    if (data is _i24.CharacterNoteData) {
      return 'CharacterNoteData';
    }
    if (data is _i25.CharacterRecord) {
      return 'CharacterRecord';
    }
    if (data is _i26.CharacterRejectedChangeData) {
      return 'CharacterRejectedChangeData';
    }
    if (data is _i27.CharacterResourceStateData) {
      return 'CharacterResourceStateData';
    }
    if (data is _i28.CharacterResourceViewData) {
      return 'CharacterResourceViewData';
    }
    if (data is _i29.CharacterSavingThrowProficiencyOverrideData) {
      return 'CharacterSavingThrowProficiencyOverrideData';
    }
    if (data is _i30.CharacterSemanticActionData) {
      return 'CharacterSemanticActionData';
    }
    if (data is _i31.CharacterSkillProficiencyState) {
      return 'CharacterSkillProficiencyState';
    }
    if (data is _i32.CharacterSkillSelectionData) {
      return 'CharacterSkillSelectionData';
    }
    if (data is _i33.CharacterSkillSelectionRecord) {
      return 'CharacterSkillSelectionRecord';
    }
    if (data is _i34.CharacterSpellSelectionData) {
      return 'CharacterSpellSelectionData';
    }
    if (data is _i35.CharacterSpellSelectionRecord) {
      return 'CharacterSpellSelectionRecord';
    }
    if (data is _i36.CharacterStartingEquipmentResolutionData) {
      return 'CharacterStartingEquipmentResolutionData';
    }
    if (data is _i37.CharacterStartingEquipmentResolutionRecord) {
      return 'CharacterStartingEquipmentResolutionRecord';
    }
    if (data is _i38.CharacterStartingEquipmentSelectionData) {
      return 'CharacterStartingEquipmentSelectionData';
    }
    if (data is _i39.CharacterStartingEquipmentSelectionRecord) {
      return 'CharacterStartingEquipmentSelectionRecord';
    }
    if (data is _i40.CharacterSyncEventRecord) {
      return 'CharacterSyncEventRecord';
    }
    if (data is _i41.CharacterSyncOperationData) {
      return 'CharacterSyncOperationData';
    }
    if (data is _i42.CharacterSyncRequest) {
      return 'CharacterSyncRequest';
    }
    if (data is _i43.CharacterSyncResponse) {
      return 'CharacterSyncResponse';
    }
    if (data is _i44.CharacterSyncResult) {
      return 'CharacterSyncResult';
    }
    if (data is _i45.CharacterSyncStatus) {
      return 'CharacterSyncStatus';
    }
    if (data is _i46.CharacterSyncValueData) {
      return 'CharacterSyncValueData';
    }
    if (data is _i47.CharacterToolProficiencyOverridesData) {
      return 'CharacterToolProficiencyOverridesData';
    }
    if (data is _i48.CharacterWeaponProficiencyOverridesData) {
      return 'CharacterWeaponProficiencyOverridesData';
    }
    if (data is _i49.LevelUpRequest) {
      return 'LevelUpRequest';
    }
    if (data is _i50.LevelUpSpellChoice) {
      return 'LevelUpSpellChoice';
    }
    if (data is _i51.ChoiceGroupData) {
      return 'ChoiceGroupData';
    }
    if (data is _i52.ChoiceOptionData) {
      return 'ChoiceOptionData';
    }
    if (data is _i53.ChoiceRequirementData) {
      return 'ChoiceRequirementData';
    }
    if (data is _i54.ClassData) {
      return 'ClassData';
    }
    if (data is _i55.AuthActionResult) {
      return 'AuthActionResult';
    }
    if (data is _i56.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i57.PreparedSpellRuleData) {
      return 'PreparedSpellRuleData';
    }
    if (data is _i58.SpellSlotProgressionData) {
      return 'SpellSlotProgressionData';
    }
    if (data is _i59.StartingEquipmentBlockData) {
      return 'StartingEquipmentBlockData';
    }
    if (data is _i60.StartingEquipmentEntryData) {
      return 'StartingEquipmentEntryData';
    }
    if (data is _i61.StartingEquipmentLineData) {
      return 'StartingEquipmentLineData';
    }
    if (data is _i62.StartingEquipmentOptionData) {
      return 'StartingEquipmentOptionData';
    }
    if (data is _i63.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i64.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i65.FeatureDisplayPropertyData) {
      return 'FeatureDisplayPropertyData';
    }
    if (data is _i66.FeatureModifierConditionData) {
      return 'FeatureModifierConditionData';
    }
    if (data is _i67.FeatureModifierData) {
      return 'FeatureModifierData';
    }
    if (data is _i68.FeatureModifierValueData) {
      return 'FeatureModifierValueData';
    }
    if (data is _i69.FeatureResourceDefinitionData) {
      return 'FeatureResourceDefinitionData';
    }
    if (data is _i70.FeatureResourceEffectData) {
      return 'FeatureResourceEffectData';
    }
    if (data is _i71.FeatureResourceProgressionValueData) {
      return 'FeatureResourceProgressionValueData';
    }
    if (data is _i72.RaceData) {
      return 'RaceData';
    }
    if (data is _i73.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i74.RaceFeatureSpellGrantData) {
      return 'RaceFeatureSpellGrantData';
    }
    if (data is _i75.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i76.ToolData) {
      return 'ToolData';
    }
    if (data is _i77.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i78.ItemData) {
      return 'ItemData';
    }
    if (data is _i79.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i80.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i81.SpellData) {
      return 'SpellData';
    }
    if (data is _i82.SpellScalingData) {
      return 'SpellScalingData';
    }
    if (data is _i83.Ability) {
      return 'Ability';
    }
    if (data is _i84.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i85.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i86.CharacterChangeType) {
      return 'CharacterChangeType';
    }
    if (data is _i87.CharacterEntityType) {
      return 'CharacterEntityType';
    }
    if (data is _i88.CharacterFeatureSourceType) {
      return 'CharacterFeatureSourceType';
    }
    if (data is _i89.CharacterInventoryItemType) {
      return 'CharacterInventoryItemType';
    }
    if (data is _i90.CharacterSavingThrowProficiencyOverride) {
      return 'CharacterSavingThrowProficiencyOverride';
    }
    if (data is _i91.CharacterSkillProficiencyLevel) {
      return 'CharacterSkillProficiencyLevel';
    }
    if (data is _i92.CharacterSkillSelectionKind) {
      return 'CharacterSkillSelectionKind';
    }
    if (data is _i93.CharacterSpeedKind) {
      return 'CharacterSpeedKind';
    }
    if (data is _i94.CharacterSpellSelectionKind) {
      return 'CharacterSpellSelectionKind';
    }
    if (data is _i95.CharacterSyncOperationType) {
      return 'CharacterSyncOperationType';
    }
    if (data is _i96.CharacterSyncTargetType) {
      return 'CharacterSyncTargetType';
    }
    if (data is _i97.ChoiceRequirementType) {
      return 'ChoiceRequirementType';
    }
    if (data is _i98.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i99.ChoiceType) {
      return 'ChoiceType';
    }
    if (data is _i100.ClassSpellSelectionMode) {
      return 'ClassSpellSelectionMode';
    }
    if (data is _i101.ConditionType) {
      return 'ConditionType';
    }
    if (data is _i102.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i103.DamageType) {
      return 'DamageType';
    }
    if (data is _i104.EquipmentCatalogType) {
      return 'EquipmentCatalogType';
    }
    if (data is _i105.FeatureDisplayPropertyValueKind) {
      return 'FeatureDisplayPropertyValueKind';
    }
    if (data is _i106.FeatureModifierConditionType) {
      return 'FeatureModifierConditionType';
    }
    if (data is _i107.StartingEquipmentOptionView) {
      return 'StartingEquipmentOptionView';
    }
    if (data is _i108.FeatureModifierRounding) {
      return 'FeatureModifierRounding';
    }
    if (data is _i109.FeatureModifierTarget) {
      return 'FeatureModifierTarget';
    }
    if (data is _i110.FeatureModifierValueKind) {
      return 'FeatureModifierValueKind';
    }
    if (data is _i111.FeatureResourceEffectType) {
      return 'FeatureResourceEffectType';
    }
    if (data is _i112.FeatureResourceKind) {
      return 'FeatureResourceKind';
    }
    if (data is _i113.FeatureResourceMaxRule) {
      return 'FeatureResourceMaxRule';
    }
    if (data is _i114.FeatureResourceProgressionKey) {
      return 'FeatureResourceProgressionKey';
    }
    if (data is _i115.FeatureResourceTargetType) {
      return 'FeatureResourceTargetType';
    }
    if (data is _i116.FeatureResourceTrigger) {
      return 'FeatureResourceTrigger';
    }
    if (data is _i117.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i118.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i119.Language) {
      return 'Language';
    }
    if (data is _i120.PreparedSpellRounding) {
      return 'PreparedSpellRounding';
    }
    if (data is _i121.RestType) {
      return 'RestType';
    }
    if (data is _i122.SenseType) {
      return 'SenseType';
    }
    if (data is _i123.Skill) {
      return 'Skill';
    }
    if (data is _i124.AreaOfEffectType) {
      return 'AreaOfEffectType';
    }
    if (data is _i125.SpellAttackType) {
      return 'SpellAttackType';
    }
    if (data is _i126.SpellDurationType) {
      return 'SpellDurationType';
    }
    if (data is _i127.SpellScalingMode) {
      return 'SpellScalingMode';
    }
    if (data is _i128.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i129.SpellTargetType) {
      return 'SpellTargetType';
    }
    if (data is _i130.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i131.StartingEquipmentBlockKind) {
      return 'StartingEquipmentBlockKind';
    }
    if (data is _i132.StartingEquipmentEntryKind) {
      return 'StartingEquipmentEntryKind';
    }
    if (data is _i133.StartingEquipmentLineKind) {
      return 'StartingEquipmentLineKind';
    }
    if (data is _i134.ToolCategory) {
      return 'ToolCategory';
    }
    if (data is _i135.UnarmoredDefenseRule) {
      return 'UnarmoredDefenseRule';
    }
    if (data is _i136.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i137.WeaponProperty) {
      return 'WeaponProperty';
    }
    if (data is _i138.LevelDownChoiceRepair) {
      return 'LevelDownChoiceRepair';
    }
    if (data is _i139.LevelDownRequest) {
      return 'LevelDownRequest';
    }
    if (data is _i140.BackgroundStepView) {
      return 'BackgroundStepView';
    }
    if (data is _i141.CharacterEquipmentEntryView) {
      return 'CharacterEquipmentEntryView';
    }
    if (data is _i142.ChoiceGroupView) {
      return 'ChoiceGroupView';
    }
    if (data is _i143.ChoiceOptionEligibilityView) {
      return 'ChoiceOptionEligibilityView';
    }
    if (data is _i144.ChoiceRequirementFailureView) {
      return 'ChoiceRequirementFailureView';
    }
    if (data is _i145.ClassSpellDeltaView) {
      return 'ClassSpellDeltaView';
    }
    if (data is _i146.ClassSpellSelectionGroupView) {
      return 'ClassSpellSelectionGroupView';
    }
    if (data is _i147.ClassStepFeatureView) {
      return 'ClassStepFeatureView';
    }
    if (data is _i148.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i149.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i150.FeatureDisplayPropertyView) {
      return 'FeatureDisplayPropertyView';
    }
    if (data is _i151.LevelDownInvalidChoiceView) {
      return 'LevelDownInvalidChoiceView';
    }
    if (data is _i152.LevelDownPreview) {
      return 'LevelDownPreview';
    }
    if (data is _i153.LevelUpPreview) {
      return 'LevelUpPreview';
    }
    if (data is _i154.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i155.RaceStepView) {
      return 'RaceStepView';
    }
    if (data is _i156.SelectedFeatureChoiceView) {
      return 'SelectedFeatureChoiceView';
    }
    if (data is _i157.SkillSelectionGroupView) {
      return 'SkillSelectionGroupView';
    }
    if (data is _i158.StartingEquipmentBlockView) {
      return 'StartingEquipmentBlockView';
    }
    if (data is _i159.FeatureModifierOperation) {
      return 'FeatureModifierOperation';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i4.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i5.BackgroundData>(data['data']);
    }
    if (dataClassName == 'ClassSpellGrantData') {
      return deserialize<_i6.ClassSpellGrantData>(data['data']);
    }
    if (dataClassName == 'DamagePartData') {
      return deserialize<_i7.DamagePartData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i8.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterAppliedChangeRecord') {
      return deserialize<_i9.CharacterAppliedChangeRecord>(data['data']);
    }
    if (dataClassName == 'CharacterArmorTrainingOverridesData') {
      return deserialize<_i10.CharacterArmorTrainingOverridesData>(
          data['data']);
    }
    if (dataClassName == 'CharacterAttackData') {
      return deserialize<_i11.CharacterAttackData>(data['data']);
    }
    if (dataClassName == 'CharacterChangeData') {
      return deserialize<_i12.CharacterChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i13.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceRecord') {
      return deserialize<_i14.CharacterChoiceRecord>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i15.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryRecord') {
      return deserialize<_i16.CharacterClassEntryRecord>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i17.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterDerivedData') {
      return deserialize<_i18.CharacterDerivedData>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentSelectionData') {
      return deserialize<_i19.CharacterEquipmentSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureOverrideData') {
      return deserialize<_i20.CharacterFeatureOverrideData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureViewData') {
      return deserialize<_i21.CharacterFeatureViewData>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemData') {
      return deserialize<_i22.CharacterInventoryItemData>(data['data']);
    }
    if (dataClassName == 'CharacterLanguageOverridesData') {
      return deserialize<_i23.CharacterLanguageOverridesData>(data['data']);
    }
    if (dataClassName == 'CharacterNoteData') {
      return deserialize<_i24.CharacterNoteData>(data['data']);
    }
    if (dataClassName == 'CharacterRecord') {
      return deserialize<_i25.CharacterRecord>(data['data']);
    }
    if (dataClassName == 'CharacterRejectedChangeData') {
      return deserialize<_i26.CharacterRejectedChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterResourceStateData') {
      return deserialize<_i27.CharacterResourceStateData>(data['data']);
    }
    if (dataClassName == 'CharacterResourceViewData') {
      return deserialize<_i28.CharacterResourceViewData>(data['data']);
    }
    if (dataClassName == 'CharacterSavingThrowProficiencyOverrideData') {
      return deserialize<_i29.CharacterSavingThrowProficiencyOverrideData>(
          data['data']);
    }
    if (dataClassName == 'CharacterSemanticActionData') {
      return deserialize<_i30.CharacterSemanticActionData>(data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyState') {
      return deserialize<_i31.CharacterSkillProficiencyState>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionData') {
      return deserialize<_i32.CharacterSkillSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionRecord') {
      return deserialize<_i33.CharacterSkillSelectionRecord>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionData') {
      return deserialize<_i34.CharacterSpellSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionRecord') {
      return deserialize<_i35.CharacterSpellSelectionRecord>(data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionData') {
      return deserialize<_i36.CharacterStartingEquipmentResolutionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionRecord') {
      return deserialize<_i37.CharacterStartingEquipmentResolutionRecord>(
          data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionData') {
      return deserialize<_i38.CharacterStartingEquipmentSelectionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionRecord') {
      return deserialize<_i39.CharacterStartingEquipmentSelectionRecord>(
          data['data']);
    }
    if (dataClassName == 'CharacterSyncEventRecord') {
      return deserialize<_i40.CharacterSyncEventRecord>(data['data']);
    }
    if (dataClassName == 'CharacterSyncOperationData') {
      return deserialize<_i41.CharacterSyncOperationData>(data['data']);
    }
    if (dataClassName == 'CharacterSyncRequest') {
      return deserialize<_i42.CharacterSyncRequest>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResponse') {
      return deserialize<_i43.CharacterSyncResponse>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResult') {
      return deserialize<_i44.CharacterSyncResult>(data['data']);
    }
    if (dataClassName == 'CharacterSyncStatus') {
      return deserialize<_i45.CharacterSyncStatus>(data['data']);
    }
    if (dataClassName == 'CharacterSyncValueData') {
      return deserialize<_i46.CharacterSyncValueData>(data['data']);
    }
    if (dataClassName == 'CharacterToolProficiencyOverridesData') {
      return deserialize<_i47.CharacterToolProficiencyOverridesData>(
          data['data']);
    }
    if (dataClassName == 'CharacterWeaponProficiencyOverridesData') {
      return deserialize<_i48.CharacterWeaponProficiencyOverridesData>(
          data['data']);
    }
    if (dataClassName == 'LevelUpRequest') {
      return deserialize<_i49.LevelUpRequest>(data['data']);
    }
    if (dataClassName == 'LevelUpSpellChoice') {
      return deserialize<_i50.LevelUpSpellChoice>(data['data']);
    }
    if (dataClassName == 'ChoiceGroupData') {
      return deserialize<_i51.ChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ChoiceOptionData') {
      return deserialize<_i52.ChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementData') {
      return deserialize<_i53.ChoiceRequirementData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i54.ClassData>(data['data']);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_i55.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i56.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'PreparedSpellRuleData') {
      return deserialize<_i57.PreparedSpellRuleData>(data['data']);
    }
    if (dataClassName == 'SpellSlotProgressionData') {
      return deserialize<_i58.SpellSlotProgressionData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockData') {
      return deserialize<_i59.StartingEquipmentBlockData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryData') {
      return deserialize<_i60.StartingEquipmentEntryData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineData') {
      return deserialize<_i61.StartingEquipmentLineData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionData') {
      return deserialize<_i62.StartingEquipmentOptionData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i63.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i64.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyData') {
      return deserialize<_i65.FeatureDisplayPropertyData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierConditionData') {
      return deserialize<_i66.FeatureModifierConditionData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierData') {
      return deserialize<_i67.FeatureModifierData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierValueData') {
      return deserialize<_i68.FeatureModifierValueData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceDefinitionData') {
      return deserialize<_i69.FeatureResourceDefinitionData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceEffectData') {
      return deserialize<_i70.FeatureResourceEffectData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceProgressionValueData') {
      return deserialize<_i71.FeatureResourceProgressionValueData>(
          data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i72.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i73.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_i74.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i75.SubraceData>(data['data']);
    }
    if (dataClassName == 'ToolData') {
      return deserialize<_i76.ToolData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i77.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i78.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i79.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i80.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i81.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_i82.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i83.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i84.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i85.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'CharacterChangeType') {
      return deserialize<_i86.CharacterChangeType>(data['data']);
    }
    if (dataClassName == 'CharacterEntityType') {
      return deserialize<_i87.CharacterEntityType>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureSourceType') {
      return deserialize<_i88.CharacterFeatureSourceType>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemType') {
      return deserialize<_i89.CharacterInventoryItemType>(data['data']);
    }
    if (dataClassName == 'CharacterSavingThrowProficiencyOverride') {
      return deserialize<_i90.CharacterSavingThrowProficiencyOverride>(
          data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyLevel') {
      return deserialize<_i91.CharacterSkillProficiencyLevel>(data['data']);
    }
    if (dataClassName == 'CharacterSkillSelectionKind') {
      return deserialize<_i92.CharacterSkillSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpeedKind') {
      return deserialize<_i93.CharacterSpeedKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionKind') {
      return deserialize<_i94.CharacterSpellSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSyncOperationType') {
      return deserialize<_i95.CharacterSyncOperationType>(data['data']);
    }
    if (dataClassName == 'CharacterSyncTargetType') {
      return deserialize<_i96.CharacterSyncTargetType>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementType') {
      return deserialize<_i97.ChoiceRequirementType>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i98.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ChoiceType') {
      return deserialize<_i99.ChoiceType>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionMode') {
      return deserialize<_i100.ClassSpellSelectionMode>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_i101.ConditionType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i102.CreatureSize>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i103.DamageType>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalogType') {
      return deserialize<_i104.EquipmentCatalogType>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyValueKind') {
      return deserialize<_i105.FeatureDisplayPropertyValueKind>(data['data']);
    }
    if (dataClassName == 'FeatureModifierConditionType') {
      return deserialize<_i106.FeatureModifierConditionType>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionView') {
      return deserialize<_i107.StartingEquipmentOptionView>(data['data']);
    }
    if (dataClassName == 'FeatureModifierRounding') {
      return deserialize<_i108.FeatureModifierRounding>(data['data']);
    }
    if (dataClassName == 'FeatureModifierTarget') {
      return deserialize<_i109.FeatureModifierTarget>(data['data']);
    }
    if (dataClassName == 'FeatureModifierValueKind') {
      return deserialize<_i110.FeatureModifierValueKind>(data['data']);
    }
    if (dataClassName == 'FeatureResourceEffectType') {
      return deserialize<_i111.FeatureResourceEffectType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceKind') {
      return deserialize<_i112.FeatureResourceKind>(data['data']);
    }
    if (dataClassName == 'FeatureResourceMaxRule') {
      return deserialize<_i113.FeatureResourceMaxRule>(data['data']);
    }
    if (dataClassName == 'FeatureResourceProgressionKey') {
      return deserialize<_i114.FeatureResourceProgressionKey>(data['data']);
    }
    if (dataClassName == 'FeatureResourceTargetType') {
      return deserialize<_i115.FeatureResourceTargetType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceTrigger') {
      return deserialize<_i116.FeatureResourceTrigger>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i117.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i118.HitPointMode>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i119.Language>(data['data']);
    }
    if (dataClassName == 'PreparedSpellRounding') {
      return deserialize<_i120.PreparedSpellRounding>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i121.RestType>(data['data']);
    }
    if (dataClassName == 'SenseType') {
      return deserialize<_i122.SenseType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i123.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_i124.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_i125.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i126.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_i127.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i128.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_i129.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i130.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockKind') {
      return deserialize<_i131.StartingEquipmentBlockKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryKind') {
      return deserialize<_i132.StartingEquipmentEntryKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineKind') {
      return deserialize<_i133.StartingEquipmentLineKind>(data['data']);
    }
    if (dataClassName == 'ToolCategory') {
      return deserialize<_i134.ToolCategory>(data['data']);
    }
    if (dataClassName == 'UnarmoredDefenseRule') {
      return deserialize<_i135.UnarmoredDefenseRule>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i136.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'WeaponProperty') {
      return deserialize<_i137.WeaponProperty>(data['data']);
    }
    if (dataClassName == 'LevelDownChoiceRepair') {
      return deserialize<_i138.LevelDownChoiceRepair>(data['data']);
    }
    if (dataClassName == 'LevelDownRequest') {
      return deserialize<_i139.LevelDownRequest>(data['data']);
    }
    if (dataClassName == 'BackgroundStepView') {
      return deserialize<_i140.BackgroundStepView>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentEntryView') {
      return deserialize<_i141.CharacterEquipmentEntryView>(data['data']);
    }
    if (dataClassName == 'ChoiceGroupView') {
      return deserialize<_i142.ChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ChoiceOptionEligibilityView') {
      return deserialize<_i143.ChoiceOptionEligibilityView>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementFailureView') {
      return deserialize<_i144.ChoiceRequirementFailureView>(data['data']);
    }
    if (dataClassName == 'ClassSpellDeltaView') {
      return deserialize<_i145.ClassSpellDeltaView>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionGroupView') {
      return deserialize<_i146.ClassSpellSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepFeatureView') {
      return deserialize<_i147.ClassStepFeatureView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i148.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i149.ClassStepView>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyView') {
      return deserialize<_i150.FeatureDisplayPropertyView>(data['data']);
    }
    if (dataClassName == 'LevelDownInvalidChoiceView') {
      return deserialize<_i151.LevelDownInvalidChoiceView>(data['data']);
    }
    if (dataClassName == 'LevelDownPreview') {
      return deserialize<_i152.LevelDownPreview>(data['data']);
    }
    if (dataClassName == 'LevelUpPreview') {
      return deserialize<_i153.LevelUpPreview>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i154.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceStepView') {
      return deserialize<_i155.RaceStepView>(data['data']);
    }
    if (dataClassName == 'SelectedFeatureChoiceView') {
      return deserialize<_i156.SelectedFeatureChoiceView>(data['data']);
    }
    if (dataClassName == 'SkillSelectionGroupView') {
      return deserialize<_i157.SkillSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockView') {
      return deserialize<_i158.StartingEquipmentBlockView>(data['data']);
    }
    if (dataClassName == 'FeatureModifierOperation') {
      return deserialize<_i159.FeatureModifierOperation>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i3.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.BackgroundData:
        return _i5.BackgroundData.t;
      case _i6.ClassSpellGrantData:
        return _i6.ClassSpellGrantData.t;
      case _i8.FeatData:
        return _i8.FeatData.t;
      case _i9.CharacterAppliedChangeRecord:
        return _i9.CharacterAppliedChangeRecord.t;
      case _i14.CharacterChoiceRecord:
        return _i14.CharacterChoiceRecord.t;
      case _i16.CharacterClassEntryRecord:
        return _i16.CharacterClassEntryRecord.t;
      case _i25.CharacterRecord:
        return _i25.CharacterRecord.t;
      case _i33.CharacterSkillSelectionRecord:
        return _i33.CharacterSkillSelectionRecord.t;
      case _i35.CharacterSpellSelectionRecord:
        return _i35.CharacterSpellSelectionRecord.t;
      case _i37.CharacterStartingEquipmentResolutionRecord:
        return _i37.CharacterStartingEquipmentResolutionRecord.t;
      case _i39.CharacterStartingEquipmentSelectionRecord:
        return _i39.CharacterStartingEquipmentSelectionRecord.t;
      case _i40.CharacterSyncEventRecord:
        return _i40.CharacterSyncEventRecord.t;
      case _i51.ChoiceGroupData:
        return _i51.ChoiceGroupData.t;
      case _i52.ChoiceOptionData:
        return _i52.ChoiceOptionData.t;
      case _i54.ClassData:
        return _i54.ClassData.t;
      case _i4.ClassFeatureData:
        return _i4.ClassFeatureData.t;
      case _i56.ClassLevelData:
        return _i56.ClassLevelData.t;
      case _i58.SpellSlotProgressionData:
        return _i58.SpellSlotProgressionData.t;
      case _i60.StartingEquipmentEntryData:
        return _i60.StartingEquipmentEntryData.t;
      case _i63.SubclassData:
        return _i63.SubclassData.t;
      case _i64.SubclassFeatureData:
        return _i64.SubclassFeatureData.t;
      case _i65.FeatureDisplayPropertyData:
        return _i65.FeatureDisplayPropertyData.t;
      case _i67.FeatureModifierData:
        return _i67.FeatureModifierData.t;
      case _i69.FeatureResourceDefinitionData:
        return _i69.FeatureResourceDefinitionData.t;
      case _i70.FeatureResourceEffectData:
        return _i70.FeatureResourceEffectData.t;
      case _i71.FeatureResourceProgressionValueData:
        return _i71.FeatureResourceProgressionValueData.t;
      case _i72.RaceData:
        return _i72.RaceData.t;
      case _i73.RaceFeatureData:
        return _i73.RaceFeatureData.t;
      case _i74.RaceFeatureSpellGrantData:
        return _i74.RaceFeatureSpellGrantData.t;
      case _i75.SubraceData:
        return _i75.SubraceData.t;
      case _i76.ToolData:
        return _i76.ToolData.t;
      case _i77.ArmorData:
        return _i77.ArmorData.t;
      case _i78.ItemData:
        return _i78.ItemData.t;
      case _i79.MagicItemData:
        return _i79.MagicItemData.t;
      case _i80.WeaponData:
        return _i80.WeaponData.t;
      case _i81.SpellData:
        return _i81.SpellData.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'characters_mirror';
}
