/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _ir4mnztf;
import 'package:characters_mirror_client/src/protocol/data/class_spell_grant_data.dart'
    as _ibq4gqkd;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _ipq9e85u;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i82zmloj;
import 'package:characters_mirror_client/src/protocol/data/general/choice_group_data.dart'
    as _i44xjl6j;
import 'package:characters_mirror_client/src/protocol/data/general/choice_option_data.dart'
    as _iqcr63pm;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i3mngh91;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _iozr72e1;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _izzx945w;
import 'package:characters_mirror_client/src/protocol/data/general/class/spell_slot_progression_data.dart'
    as _i8v86dtn;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _iuhgku0a;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _is2mx8yv;
import 'package:characters_mirror_client/src/protocol/data/general/feature_relation_data.dart'
    as _ifrx84um;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _ilc3ntdx;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _imf9k3ru;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i9vzxbi6;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i5ca8sk9;
import 'package:characters_mirror_client/src/protocol/data/general/tool_data.dart'
    as _izep6fcb;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i4pe33cv;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _iqylf6yx;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _ig7tbc7e;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i5q8wx5t;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _ic7268ss;
import 'package:characters_mirror_client/src/protocol/dungeon_master/dm_creature_summary.dart'
    as _iuiuigdt;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i312scxx;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'auth/auth_action_result.dart' as _iydli74w;
import 'data/background_data.dart' as _i3katqli;
import 'data/class_spell_grant_data.dart' as _i68we1de;
import 'data/damage_part_data.dart' as _iqilpl6d;
import 'data/feat_data.dart' as _i1l5wul2;
import 'data/general/character/character_armor_training_overrides_data.dart'
    as _ijpj2a9u;
import 'data/general/character/character_attack_data.dart' as _iykib7lv;
import 'data/general/character/character_change_data.dart' as _ibkyvw07;
import 'data/general/character/character_choice_data.dart' as _iwf32wta;
import 'data/general/character/character_class_entry_data.dart' as _iqjjxby6;
import 'data/general/character/character_data.dart' as _im2o0tmj;
import 'data/general/character/character_derived_data.dart' as _ir4negfy;
import 'data/general/character/character_equipment_selection_data.dart'
    as _i7jkadr4;
import 'data/general/character/character_feature_override_data.dart'
    as _iggvk3az;
import 'data/general/character/character_feature_view_data.dart' as _imlxp0ix;
import 'data/general/character/character_inventory_item_data.dart' as _id5dgxdg;
import 'data/general/character/character_language_overrides_data.dart'
    as _ibvj7xz5;
import 'data/general/character/character_note_data.dart' as _iqjbme11;
import 'data/general/character/character_rejected_change_data.dart'
    as _ig0fia1r;
import 'data/general/character/character_resource_state_data.dart' as _iu6zjs5s;
import 'data/general/character/character_resource_view_data.dart' as _io9jihae;
import 'data/general/character/character_saving_throw_proficiency_override_data.dart'
    as _i3yrtkjn;
import 'data/general/character/character_semantic_action_data.dart'
    as _ivfw6q0y;
import 'data/general/character/character_skill_proficiency_state.dart'
    as _isl5krdt;
import 'data/general/character/character_skill_selection_data.dart'
    as _itkzfry3;
import 'data/general/character/character_spell_selection_data.dart'
    as _iesndgzw;
import 'data/general/character/character_starting_equipment_resolution_data.dart'
    as _ieudcx2k;
import 'data/general/character/character_starting_equipment_selection_data.dart'
    as _ixmjb4z5;
import 'data/general/character/character_sync_operation_data.dart' as _is9ng6da;
import 'data/general/character/character_sync_request.dart' as _icxp0ddy;
import 'data/general/character/character_sync_response.dart' as _i29bgu3e;
import 'data/general/character/character_sync_result.dart' as _ix5qhw9w;
import 'data/general/character/character_sync_status.dart' as _ixfhi6l8;
import 'data/general/character/character_sync_value_data.dart' as _iz49jt9b;
import 'data/general/character/character_tool_proficiency_overrides_data.dart'
    as _idvpwngn;
import 'data/general/character/character_weapon_proficiency_overrides_data.dart'
    as _i5e0copu;
import 'data/general/character/choice_replacement_history_data.dart'
    as _i2mamrrk;
import 'data/general/character/level_up_choice_replacement_data.dart'
    as _iij0mpeo;
import 'data/general/character/level_up_request.dart' as _ipxtly6g;
import 'data/general/character/level_up_spell_choice.dart' as _i4b5l3un;
import 'data/general/character/related_feature_view_data.dart' as _i0tavl9b;
import 'data/general/character/spell_selection_replacement_history_data.dart'
    as _it45kp8q;
import 'data/general/character/spell_slot_recovery_trigger_data.dart'
    as _i9cfge83;
import 'data/general/choice_group_data.dart' as _i3zkka4q;
import 'data/general/choice_option_data.dart' as _iprx2upt;
import 'data/general/choice_requirement_data.dart' as _iax2s634;
import 'data/general/class/class_data.dart' as _i4e8ker2;
import 'data/general/class/class_feature_data.dart' as _ijvqpc4v;
import 'data/general/class/class_level_data.dart' as _isxi9i4e;
import 'data/general/class/prepared_spell_rule_data.dart' as _ihr52fes;
import 'data/general/class/spell_slot_progression_data.dart' as _ig6b5pj2;
import 'data/general/class/starting_equipment_block_data.dart' as _igasg47n;
import 'data/general/class/starting_equipment_entry_data.dart' as _impna1yi;
import 'data/general/class/starting_equipment_line_data.dart' as _iozcdomq;
import 'data/general/class/starting_equipment_option_data.dart' as _iyz352zl;
import 'data/general/class/subclass_data.dart' as _ijic8hve;
import 'data/general/class/subclass_feature_data.dart' as _iel0dp9q;
import 'data/general/feature_display_property_data.dart' as _i0aiwhe6;
import 'data/general/feature_modifier_condition_data.dart' as _iwfr4tm0;
import 'data/general/feature_modifier_data.dart' as _ilhpjxpt;
import 'data/general/feature_modifier_value_data.dart' as _ircf4zmd;
import 'data/general/feature_relation_data.dart' as _isecmqna;
import 'data/general/feature_resource_definition_data.dart' as _iflv344v;
import 'data/general/feature_resource_effect_data.dart' as _i86imp4g;
import 'data/general/feature_resource_progression_value_data.dart' as _iafoerth;
import 'data/general/race/race_data.dart' as _irh2914h;
import 'data/general/race/race_feature_data.dart' as _imnymvhh;
import 'data/general/race/race_feature_spell_grant_data.dart' as _ilhjydvh;
import 'data/general/race/subrace_data.dart' as _iqoglfsm;
import 'data/general/spell_activation_data.dart' as _idolx2sf;
import 'data/general/spell_resource_upcast_policy_data.dart' as _i9erq8kp;
import 'data/general/spell_selection_filter_data.dart' as _in2nv22i;
import 'data/general/spell_slot_recovery_policy_data.dart' as _ipwf59gx;
import 'data/general/tool_data.dart' as _ivjna1ls;
import 'data/items/armor_data.dart' as _iv545qv3;
import 'data/items/item_data.dart' as _ibuwh0hc;
import 'data/items/magic_item_data.dart' as _i41tgptx;
import 'data/items/weapon_data.dart' as _inpmmgks;
import 'data/spell_data.dart' as _itvh88br;
import 'data/spell_scaling_data.dart' as _iq5q0wh8;
import 'dungeon_master/dm_creature_exception.dart' as _ivey3rvd;
import 'dungeon_master/dm_creature_import_result.dart' as _i11aekbu;
import 'dungeon_master/dm_creature_record.dart' as _ipuprlj7;
import 'dungeon_master/dm_creature_summary.dart' as _idf6hpk3;
import 'enums/ability.dart' as _i5rga0su;
import 'enums/armor_category.dart' as _ix11b24x;
import 'enums/character_alignment.dart' as _ik1o33an;
import 'enums/character_change_type.dart' as _idqm1edw;
import 'enums/character_entity_type.dart' as _icxxpsvd;
import 'enums/character_feature_source_type.dart' as _i1fix3of;
import 'enums/character_inventory_item_type.dart' as _ik9iz51c;
import 'enums/character_saving_throw_proficiency_override.dart' as _ixbcln74;
import 'enums/character_skill_proficiency_level.dart' as _ixj33h5c;
import 'enums/character_skill_selection_kind.dart' as _i3ppfbzb;
import 'enums/character_speed_kind.dart' as _ikyxycuo;
import 'enums/character_spell_selection_kind.dart' as _ie0q5aqi;
import 'enums/character_sync_operation_type.dart' as _i6jbrxie;
import 'enums/character_sync_target_type.dart' as _ia4qs68v;
import 'enums/choice_requirement_type.dart' as _ia6aulam;
import 'enums/choice_source_type.dart' as _iam6xy91;
import 'enums/choice_type.dart' as _iotu8r29;
import 'enums/class_spell_selection_mode.dart' as _ijyz5fbs;
import 'enums/condition_type.dart' as _ikb1pesi;
import 'enums/creature_size.dart' as _i6cngs6w;
import 'enums/damage_type.dart' as _i6q2t5mj;
import 'enums/equipment_catalog_type.dart' as _ia851nk8;
import 'enums/feature_display_property_value_kind.dart' as _i9idws3v;
import 'enums/feature_modifier_condition_type.dart' as _ilgpxa54;
import 'enums/feature_modifier_operation.dart' as _i56op7oq;
import 'enums/feature_modifier_rounding.dart' as _i6asfa9j;
import 'enums/feature_modifier_target.dart' as _izn79nb9;
import 'enums/feature_modifier_value_kind.dart' as _il8rk55k;
import 'enums/feature_relation_type.dart' as _ih812opj;
import 'enums/feature_resource_effect_type.dart' as _ijb3cn5v;
import 'enums/feature_resource_kind.dart' as _ia1vmwiq;
import 'enums/feature_resource_max_rule.dart' as _ib4g5i7q;
import 'enums/feature_resource_progression_key.dart' as _if07r66f;
import 'enums/feature_resource_target_type.dart' as _iyk5jgys;
import 'enums/feature_resource_trigger.dart' as _ir3q1cdf;
import 'enums/feature_tag.dart' as _i2l7bpu3;
import 'enums/hit_point_mode.dart' as _izodp5lk;
import 'enums/language.dart' as _iftbsk4q;
import 'enums/prepared_spell_rounding.dart' as _ieum0m7f;
import 'enums/rest_type.dart' as _ibgbgp52;
import 'enums/sense_type.dart' as _iy62ln0z;
import 'enums/skill.dart' as _iabgjh08;
import 'enums/spell/area_of_effect_type.dart' as _ieavm63l;
import 'enums/spell/area_size_measurement.dart' as _iatx40hq;
import 'enums/spell/spell_attack_type.dart' as _inf83u33;
import 'enums/spell/spell_duration_type.dart' as _i9u2urpu;
import 'enums/spell/spell_scaling_mode.dart' as _iw7hp9dc;
import 'enums/spell/spell_school.dart' as _ioahu9w9;
import 'enums/spell/spell_target_type.dart' as _iupu1e0e;
import 'enums/spell_slot_recovery_mode.dart' as _ik43ztmo;
import 'enums/spellcasting_progression.dart' as _ilfh4rku;
import 'enums/starting_equipment_block_kind.dart' as _iag2d6aj;
import 'enums/starting_equipment_entry_kind.dart' as _ipm8xyg1;
import 'enums/starting_equipment_line_kind.dart' as _iniqanjc;
import 'enums/tool_category.dart' as _ic2cpv54;
import 'enums/unarmored_defense_rule.dart' as _i4vk4r4o;
import 'enums/weapon_category.dart' as _iiyileog;
import 'enums/weapon_property.dart' as _iur813s4;
import 'requests/level_down_choice_repair.dart' as _i1l5m7qw;
import 'requests/level_down_request.dart' as _irktv0ea;
import 'views/background_step_view.dart' as _iqeghuxo;
import 'views/character_equipment_entry_view.dart' as _isbrs5qf;
import 'views/choice_group_view.dart' as _i6xbclit;
import 'views/choice_option_eligibility_view.dart' as _iil6pw38;
import 'views/choice_requirement_failure_view.dart' as _iob9tmlr;
import 'views/class_spell_delta_view.dart' as _ik4ex2us;
import 'views/class_spell_selection_group_view.dart' as _ixvig4n8;
import 'views/class_step_feature_view.dart' as _ih120cff;
import 'views/class_step_subclass_choice_view.dart' as _i3cyal5j;
import 'views/class_step_view.dart' as _ib3duw15;
import 'views/feature_display_property_view.dart' as _i9kpkyz2;
import 'views/level_down_invalid_choice_view.dart' as _iu8i64vu;
import 'views/level_down_preview.dart' as _ipbxh79i;
import 'views/level_up_preview.dart' as _ipqjgw5e;
import 'views/proficiency_bundle_view.dart' as _ifavv51o;
import 'views/race_step_view.dart' as _id360bq3;
import 'views/resolved_character_spell_data.dart' as _i8p2oglu;
import 'views/selected_feature_choice_view.dart' as _im19jsv2;
import 'views/skill_selection_group_view.dart' as _ihn36a1g;
import 'views/spell_source_context_data.dart' as _iam7pkuu;
import 'views/starting_equipment_block_view.dart' as _izjjz5hc;
import 'views/starting_equipment_option_view.dart' as _i3vgjwh2;
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

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(dynamic data, [Type? t]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iydli74w.AuthActionResult) {
      return _iydli74w.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i3katqli.BackgroundData) {
      return _i3katqli.BackgroundData.fromJson(data) as T;
    }
    if (t == _i68we1de.ClassSpellGrantData) {
      return _i68we1de.ClassSpellGrantData.fromJson(data) as T;
    }
    if (t == _iqilpl6d.DamagePartData) {
      return _iqilpl6d.DamagePartData.fromJson(data) as T;
    }
    if (t == _i1l5wul2.FeatData) {
      return _i1l5wul2.FeatData.fromJson(data) as T;
    }
    if (t == _ijpj2a9u.CharacterArmorTrainingOverridesData) {
      return _ijpj2a9u.CharacterArmorTrainingOverridesData.fromJson(data) as T;
    }
    if (t == _iykib7lv.CharacterAttackData) {
      return _iykib7lv.CharacterAttackData.fromJson(data) as T;
    }
    if (t == _ibkyvw07.CharacterChangeData) {
      return _ibkyvw07.CharacterChangeData.fromJson(data) as T;
    }
    if (t == _iwf32wta.CharacterChoiceData) {
      return _iwf32wta.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _iqjjxby6.CharacterClassEntryData) {
      return _iqjjxby6.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _im2o0tmj.CharacterData) {
      return _im2o0tmj.CharacterData.fromJson(data) as T;
    }
    if (t == _ir4negfy.CharacterDerivedData) {
      return _ir4negfy.CharacterDerivedData.fromJson(data) as T;
    }
    if (t == _i7jkadr4.CharacterEquipmentSelectionData) {
      return _i7jkadr4.CharacterEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _iggvk3az.CharacterFeatureOverrideData) {
      return _iggvk3az.CharacterFeatureOverrideData.fromJson(data) as T;
    }
    if (t == _imlxp0ix.CharacterFeatureViewData) {
      return _imlxp0ix.CharacterFeatureViewData.fromJson(data) as T;
    }
    if (t == _id5dgxdg.CharacterInventoryItemData) {
      return _id5dgxdg.CharacterInventoryItemData.fromJson(data) as T;
    }
    if (t == _ibvj7xz5.CharacterLanguageOverridesData) {
      return _ibvj7xz5.CharacterLanguageOverridesData.fromJson(data) as T;
    }
    if (t == _iqjbme11.CharacterNoteData) {
      return _iqjbme11.CharacterNoteData.fromJson(data) as T;
    }
    if (t == _ig0fia1r.CharacterRejectedChangeData) {
      return _ig0fia1r.CharacterRejectedChangeData.fromJson(data) as T;
    }
    if (t == _iu6zjs5s.CharacterResourceStateData) {
      return _iu6zjs5s.CharacterResourceStateData.fromJson(data) as T;
    }
    if (t == _io9jihae.CharacterResourceViewData) {
      return _io9jihae.CharacterResourceViewData.fromJson(data) as T;
    }
    if (t == _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData) {
      return _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData.fromJson(
            data,
          )
          as T;
    }
    if (t == _ivfw6q0y.CharacterSemanticActionData) {
      return _ivfw6q0y.CharacterSemanticActionData.fromJson(data) as T;
    }
    if (t == _isl5krdt.CharacterSkillProficiencyState) {
      return _isl5krdt.CharacterSkillProficiencyState.fromJson(data) as T;
    }
    if (t == _itkzfry3.CharacterSkillSelectionData) {
      return _itkzfry3.CharacterSkillSelectionData.fromJson(data) as T;
    }
    if (t == _iesndgzw.CharacterSpellSelectionData) {
      return _iesndgzw.CharacterSpellSelectionData.fromJson(data) as T;
    }
    if (t == _ieudcx2k.CharacterStartingEquipmentResolutionData) {
      return _ieudcx2k.CharacterStartingEquipmentResolutionData.fromJson(data)
          as T;
    }
    if (t == _ixmjb4z5.CharacterStartingEquipmentSelectionData) {
      return _ixmjb4z5.CharacterStartingEquipmentSelectionData.fromJson(data)
          as T;
    }
    if (t == _is9ng6da.CharacterSyncOperationData) {
      return _is9ng6da.CharacterSyncOperationData.fromJson(data) as T;
    }
    if (t == _icxp0ddy.CharacterSyncRequest) {
      return _icxp0ddy.CharacterSyncRequest.fromJson(data) as T;
    }
    if (t == _i29bgu3e.CharacterSyncResponse) {
      return _i29bgu3e.CharacterSyncResponse.fromJson(data) as T;
    }
    if (t == _ix5qhw9w.CharacterSyncResult) {
      return _ix5qhw9w.CharacterSyncResult.fromJson(data) as T;
    }
    if (t == _ixfhi6l8.CharacterSyncStatus) {
      return _ixfhi6l8.CharacterSyncStatus.fromJson(data) as T;
    }
    if (t == _iz49jt9b.CharacterSyncValueData) {
      return _iz49jt9b.CharacterSyncValueData.fromJson(data) as T;
    }
    if (t == _idvpwngn.CharacterToolProficiencyOverridesData) {
      return _idvpwngn.CharacterToolProficiencyOverridesData.fromJson(data)
          as T;
    }
    if (t == _i5e0copu.CharacterWeaponProficiencyOverridesData) {
      return _i5e0copu.CharacterWeaponProficiencyOverridesData.fromJson(data)
          as T;
    }
    if (t == _i2mamrrk.ChoiceReplacementHistoryData) {
      return _i2mamrrk.ChoiceReplacementHistoryData.fromJson(data) as T;
    }
    if (t == _iij0mpeo.LevelUpChoiceReplacementData) {
      return _iij0mpeo.LevelUpChoiceReplacementData.fromJson(data) as T;
    }
    if (t == _ipxtly6g.LevelUpRequest) {
      return _ipxtly6g.LevelUpRequest.fromJson(data) as T;
    }
    if (t == _i4b5l3un.LevelUpSpellChoice) {
      return _i4b5l3un.LevelUpSpellChoice.fromJson(data) as T;
    }
    if (t == _i0tavl9b.RelatedFeatureViewData) {
      return _i0tavl9b.RelatedFeatureViewData.fromJson(data) as T;
    }
    if (t == _it45kp8q.SpellSelectionReplacementHistoryData) {
      return _it45kp8q.SpellSelectionReplacementHistoryData.fromJson(data) as T;
    }
    if (t == _i9cfge83.SpellSlotRecoveryTriggerData) {
      return _i9cfge83.SpellSlotRecoveryTriggerData.fromJson(data) as T;
    }
    if (t == _i3zkka4q.ChoiceGroupData) {
      return _i3zkka4q.ChoiceGroupData.fromJson(data) as T;
    }
    if (t == _iprx2upt.ChoiceOptionData) {
      return _iprx2upt.ChoiceOptionData.fromJson(data) as T;
    }
    if (t == _iax2s634.ChoiceRequirementData) {
      return _iax2s634.ChoiceRequirementData.fromJson(data) as T;
    }
    if (t == _i4e8ker2.ClassData) {
      return _i4e8ker2.ClassData.fromJson(data) as T;
    }
    if (t == _ijvqpc4v.ClassFeatureData) {
      return _ijvqpc4v.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _isxi9i4e.ClassLevelData) {
      return _isxi9i4e.ClassLevelData.fromJson(data) as T;
    }
    if (t == _ihr52fes.PreparedSpellRuleData) {
      return _ihr52fes.PreparedSpellRuleData.fromJson(data) as T;
    }
    if (t == _ig6b5pj2.SpellSlotProgressionData) {
      return _ig6b5pj2.SpellSlotProgressionData.fromJson(data) as T;
    }
    if (t == _igasg47n.StartingEquipmentBlockData) {
      return _igasg47n.StartingEquipmentBlockData.fromJson(data) as T;
    }
    if (t == _impna1yi.StartingEquipmentEntryData) {
      return _impna1yi.StartingEquipmentEntryData.fromJson(data) as T;
    }
    if (t == _iozcdomq.StartingEquipmentLineData) {
      return _iozcdomq.StartingEquipmentLineData.fromJson(data) as T;
    }
    if (t == _iyz352zl.StartingEquipmentOptionData) {
      return _iyz352zl.StartingEquipmentOptionData.fromJson(data) as T;
    }
    if (t == _ijic8hve.SubclassData) {
      return _ijic8hve.SubclassData.fromJson(data) as T;
    }
    if (t == _iel0dp9q.SubclassFeatureData) {
      return _iel0dp9q.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i0aiwhe6.FeatureDisplayPropertyData) {
      return _i0aiwhe6.FeatureDisplayPropertyData.fromJson(data) as T;
    }
    if (t == _iwfr4tm0.FeatureModifierConditionData) {
      return _iwfr4tm0.FeatureModifierConditionData.fromJson(data) as T;
    }
    if (t == _ilhpjxpt.FeatureModifierData) {
      return _ilhpjxpt.FeatureModifierData.fromJson(data) as T;
    }
    if (t == _ircf4zmd.FeatureModifierValueData) {
      return _ircf4zmd.FeatureModifierValueData.fromJson(data) as T;
    }
    if (t == _isecmqna.FeatureRelationData) {
      return _isecmqna.FeatureRelationData.fromJson(data) as T;
    }
    if (t == _iflv344v.FeatureResourceDefinitionData) {
      return _iflv344v.FeatureResourceDefinitionData.fromJson(data) as T;
    }
    if (t == _i86imp4g.FeatureResourceEffectData) {
      return _i86imp4g.FeatureResourceEffectData.fromJson(data) as T;
    }
    if (t == _iafoerth.FeatureResourceProgressionValueData) {
      return _iafoerth.FeatureResourceProgressionValueData.fromJson(data) as T;
    }
    if (t == _irh2914h.RaceData) {
      return _irh2914h.RaceData.fromJson(data) as T;
    }
    if (t == _imnymvhh.RaceFeatureData) {
      return _imnymvhh.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _ilhjydvh.RaceFeatureSpellGrantData) {
      return _ilhjydvh.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _iqoglfsm.SubraceData) {
      return _iqoglfsm.SubraceData.fromJson(data) as T;
    }
    if (t == _idolx2sf.SpellActivationData) {
      return _idolx2sf.SpellActivationData.fromJson(data) as T;
    }
    if (t == _i9erq8kp.SpellResourceUpcastPolicyData) {
      return _i9erq8kp.SpellResourceUpcastPolicyData.fromJson(data) as T;
    }
    if (t == _in2nv22i.SpellSelectionFilterData) {
      return _in2nv22i.SpellSelectionFilterData.fromJson(data) as T;
    }
    if (t == _ipwf59gx.SpellSlotRecoveryPolicyData) {
      return _ipwf59gx.SpellSlotRecoveryPolicyData.fromJson(data) as T;
    }
    if (t == _ivjna1ls.ToolData) {
      return _ivjna1ls.ToolData.fromJson(data) as T;
    }
    if (t == _iv545qv3.ArmorData) {
      return _iv545qv3.ArmorData.fromJson(data) as T;
    }
    if (t == _ibuwh0hc.ItemData) {
      return _ibuwh0hc.ItemData.fromJson(data) as T;
    }
    if (t == _i41tgptx.MagicItemData) {
      return _i41tgptx.MagicItemData.fromJson(data) as T;
    }
    if (t == _inpmmgks.WeaponData) {
      return _inpmmgks.WeaponData.fromJson(data) as T;
    }
    if (t == _itvh88br.SpellData) {
      return _itvh88br.SpellData.fromJson(data) as T;
    }
    if (t == _iq5q0wh8.SpellScalingData) {
      return _iq5q0wh8.SpellScalingData.fromJson(data) as T;
    }
    if (t == _ivey3rvd.DmCreatureException) {
      return _ivey3rvd.DmCreatureException.fromJson(data) as T;
    }
    if (t == _i11aekbu.DmCreatureImportResult) {
      return _i11aekbu.DmCreatureImportResult.fromJson(data) as T;
    }
    if (t == _ipuprlj7.DmCreatureRecord) {
      return _ipuprlj7.DmCreatureRecord.fromJson(data) as T;
    }
    if (t == _idf6hpk3.DmCreatureSummary) {
      return _idf6hpk3.DmCreatureSummary.fromJson(data) as T;
    }
    if (t == _i5rga0su.Ability) {
      return _i5rga0su.Ability.fromJson(data) as T;
    }
    if (t == _ix11b24x.ArmorCategory) {
      return _ix11b24x.ArmorCategory.fromJson(data) as T;
    }
    if (t == _ik1o33an.CharacterAlignment) {
      return _ik1o33an.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _idqm1edw.CharacterChangeType) {
      return _idqm1edw.CharacterChangeType.fromJson(data) as T;
    }
    if (t == _icxxpsvd.CharacterEntityType) {
      return _icxxpsvd.CharacterEntityType.fromJson(data) as T;
    }
    if (t == _i1fix3of.CharacterFeatureSourceType) {
      return _i1fix3of.CharacterFeatureSourceType.fromJson(data) as T;
    }
    if (t == _ik9iz51c.CharacterInventoryItemType) {
      return _ik9iz51c.CharacterInventoryItemType.fromJson(data) as T;
    }
    if (t == _ixbcln74.CharacterSavingThrowProficiencyOverride) {
      return _ixbcln74.CharacterSavingThrowProficiencyOverride.fromJson(data)
          as T;
    }
    if (t == _ixj33h5c.CharacterSkillProficiencyLevel) {
      return _ixj33h5c.CharacterSkillProficiencyLevel.fromJson(data) as T;
    }
    if (t == _i3ppfbzb.CharacterSkillSelectionKind) {
      return _i3ppfbzb.CharacterSkillSelectionKind.fromJson(data) as T;
    }
    if (t == _ikyxycuo.CharacterSpeedKind) {
      return _ikyxycuo.CharacterSpeedKind.fromJson(data) as T;
    }
    if (t == _ie0q5aqi.CharacterSpellSelectionKind) {
      return _ie0q5aqi.CharacterSpellSelectionKind.fromJson(data) as T;
    }
    if (t == _i6jbrxie.CharacterSyncOperationType) {
      return _i6jbrxie.CharacterSyncOperationType.fromJson(data) as T;
    }
    if (t == _ia4qs68v.CharacterSyncTargetType) {
      return _ia4qs68v.CharacterSyncTargetType.fromJson(data) as T;
    }
    if (t == _ia6aulam.ChoiceRequirementType) {
      return _ia6aulam.ChoiceRequirementType.fromJson(data) as T;
    }
    if (t == _iam6xy91.ChoiceSourceType) {
      return _iam6xy91.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _iotu8r29.ChoiceType) {
      return _iotu8r29.ChoiceType.fromJson(data) as T;
    }
    if (t == _ijyz5fbs.ClassSpellSelectionMode) {
      return _ijyz5fbs.ClassSpellSelectionMode.fromJson(data) as T;
    }
    if (t == _ikb1pesi.ConditionType) {
      return _ikb1pesi.ConditionType.fromJson(data) as T;
    }
    if (t == _i6cngs6w.CreatureSize) {
      return _i6cngs6w.CreatureSize.fromJson(data) as T;
    }
    if (t == _i6q2t5mj.DamageType) {
      return _i6q2t5mj.DamageType.fromJson(data) as T;
    }
    if (t == _ia851nk8.EquipmentCatalogType) {
      return _ia851nk8.EquipmentCatalogType.fromJson(data) as T;
    }
    if (t == _i9idws3v.FeatureDisplayPropertyValueKind) {
      return _i9idws3v.FeatureDisplayPropertyValueKind.fromJson(data) as T;
    }
    if (t == _ilgpxa54.FeatureModifierConditionType) {
      return _ilgpxa54.FeatureModifierConditionType.fromJson(data) as T;
    }
    if (t == _i56op7oq.FeatureModifierOperation) {
      return _i56op7oq.FeatureModifierOperation.fromJson(data) as T;
    }
    if (t == _i6asfa9j.FeatureModifierRounding) {
      return _i6asfa9j.FeatureModifierRounding.fromJson(data) as T;
    }
    if (t == _izn79nb9.FeatureModifierTarget) {
      return _izn79nb9.FeatureModifierTarget.fromJson(data) as T;
    }
    if (t == _il8rk55k.FeatureModifierValueKind) {
      return _il8rk55k.FeatureModifierValueKind.fromJson(data) as T;
    }
    if (t == _ih812opj.FeatureRelationType) {
      return _ih812opj.FeatureRelationType.fromJson(data) as T;
    }
    if (t == _ijb3cn5v.FeatureResourceEffectType) {
      return _ijb3cn5v.FeatureResourceEffectType.fromJson(data) as T;
    }
    if (t == _ia1vmwiq.FeatureResourceKind) {
      return _ia1vmwiq.FeatureResourceKind.fromJson(data) as T;
    }
    if (t == _ib4g5i7q.FeatureResourceMaxRule) {
      return _ib4g5i7q.FeatureResourceMaxRule.fromJson(data) as T;
    }
    if (t == _if07r66f.FeatureResourceProgressionKey) {
      return _if07r66f.FeatureResourceProgressionKey.fromJson(data) as T;
    }
    if (t == _iyk5jgys.FeatureResourceTargetType) {
      return _iyk5jgys.FeatureResourceTargetType.fromJson(data) as T;
    }
    if (t == _ir3q1cdf.FeatureResourceTrigger) {
      return _ir3q1cdf.FeatureResourceTrigger.fromJson(data) as T;
    }
    if (t == _i2l7bpu3.FeatureTag) {
      return _i2l7bpu3.FeatureTag.fromJson(data) as T;
    }
    if (t == _izodp5lk.HitPointMode) {
      return _izodp5lk.HitPointMode.fromJson(data) as T;
    }
    if (t == _iftbsk4q.Language) {
      return _iftbsk4q.Language.fromJson(data) as T;
    }
    if (t == _ieum0m7f.PreparedSpellRounding) {
      return _ieum0m7f.PreparedSpellRounding.fromJson(data) as T;
    }
    if (t == _ibgbgp52.RestType) {
      return _ibgbgp52.RestType.fromJson(data) as T;
    }
    if (t == _iy62ln0z.SenseType) {
      return _iy62ln0z.SenseType.fromJson(data) as T;
    }
    if (t == _iabgjh08.Skill) {
      return _iabgjh08.Skill.fromJson(data) as T;
    }
    if (t == _ieavm63l.AreaOfEffectType) {
      return _ieavm63l.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _iatx40hq.AreaSizeMeasurement) {
      return _iatx40hq.AreaSizeMeasurement.fromJson(data) as T;
    }
    if (t == _inf83u33.SpellAttackType) {
      return _inf83u33.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i9u2urpu.SpellDurationType) {
      return _i9u2urpu.SpellDurationType.fromJson(data) as T;
    }
    if (t == _iw7hp9dc.SpellScalingMode) {
      return _iw7hp9dc.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _ioahu9w9.SpellSchool) {
      return _ioahu9w9.SpellSchool.fromJson(data) as T;
    }
    if (t == _iupu1e0e.SpellTargetType) {
      return _iupu1e0e.SpellTargetType.fromJson(data) as T;
    }
    if (t == _ik43ztmo.SpellSlotRecoveryMode) {
      return _ik43ztmo.SpellSlotRecoveryMode.fromJson(data) as T;
    }
    if (t == _ilfh4rku.SpellcastingProgression) {
      return _ilfh4rku.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _iag2d6aj.StartingEquipmentBlockKind) {
      return _iag2d6aj.StartingEquipmentBlockKind.fromJson(data) as T;
    }
    if (t == _ipm8xyg1.StartingEquipmentEntryKind) {
      return _ipm8xyg1.StartingEquipmentEntryKind.fromJson(data) as T;
    }
    if (t == _iniqanjc.StartingEquipmentLineKind) {
      return _iniqanjc.StartingEquipmentLineKind.fromJson(data) as T;
    }
    if (t == _ic2cpv54.ToolCategory) {
      return _ic2cpv54.ToolCategory.fromJson(data) as T;
    }
    if (t == _i4vk4r4o.UnarmoredDefenseRule) {
      return _i4vk4r4o.UnarmoredDefenseRule.fromJson(data) as T;
    }
    if (t == _iiyileog.WeaponCategory) {
      return _iiyileog.WeaponCategory.fromJson(data) as T;
    }
    if (t == _iur813s4.WeaponProperty) {
      return _iur813s4.WeaponProperty.fromJson(data) as T;
    }
    if (t == _i1l5m7qw.LevelDownChoiceRepair) {
      return _i1l5m7qw.LevelDownChoiceRepair.fromJson(data) as T;
    }
    if (t == _irktv0ea.LevelDownRequest) {
      return _irktv0ea.LevelDownRequest.fromJson(data) as T;
    }
    if (t == _iqeghuxo.BackgroundStepView) {
      return _iqeghuxo.BackgroundStepView.fromJson(data) as T;
    }
    if (t == _isbrs5qf.CharacterEquipmentEntryView) {
      return _isbrs5qf.CharacterEquipmentEntryView.fromJson(data) as T;
    }
    if (t == _i6xbclit.ChoiceGroupView) {
      return _i6xbclit.ChoiceGroupView.fromJson(data) as T;
    }
    if (t == _iil6pw38.ChoiceOptionEligibilityView) {
      return _iil6pw38.ChoiceOptionEligibilityView.fromJson(data) as T;
    }
    if (t == _iob9tmlr.ChoiceRequirementFailureView) {
      return _iob9tmlr.ChoiceRequirementFailureView.fromJson(data) as T;
    }
    if (t == _ik4ex2us.ClassSpellDeltaView) {
      return _ik4ex2us.ClassSpellDeltaView.fromJson(data) as T;
    }
    if (t == _ixvig4n8.ClassSpellSelectionGroupView) {
      return _ixvig4n8.ClassSpellSelectionGroupView.fromJson(data) as T;
    }
    if (t == _ih120cff.ClassStepFeatureView) {
      return _ih120cff.ClassStepFeatureView.fromJson(data) as T;
    }
    if (t == _i3cyal5j.ClassStepSubclassChoiceView) {
      return _i3cyal5j.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _ib3duw15.ClassStepView) {
      return _ib3duw15.ClassStepView.fromJson(data) as T;
    }
    if (t == _i9kpkyz2.FeatureDisplayPropertyView) {
      return _i9kpkyz2.FeatureDisplayPropertyView.fromJson(data) as T;
    }
    if (t == _iu8i64vu.LevelDownInvalidChoiceView) {
      return _iu8i64vu.LevelDownInvalidChoiceView.fromJson(data) as T;
    }
    if (t == _ipbxh79i.LevelDownPreview) {
      return _ipbxh79i.LevelDownPreview.fromJson(data) as T;
    }
    if (t == _ipqjgw5e.LevelUpPreview) {
      return _ipqjgw5e.LevelUpPreview.fromJson(data) as T;
    }
    if (t == _ifavv51o.ProficiencyBundleView) {
      return _ifavv51o.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _id360bq3.RaceStepView) {
      return _id360bq3.RaceStepView.fromJson(data) as T;
    }
    if (t == _i8p2oglu.ResolvedCharacterSpellData) {
      return _i8p2oglu.ResolvedCharacterSpellData.fromJson(data) as T;
    }
    if (t == _im19jsv2.SelectedFeatureChoiceView) {
      return _im19jsv2.SelectedFeatureChoiceView.fromJson(data) as T;
    }
    if (t == _ihn36a1g.SkillSelectionGroupView) {
      return _ihn36a1g.SkillSelectionGroupView.fromJson(data) as T;
    }
    if (t == _iam7pkuu.SpellSourceContextData) {
      return _iam7pkuu.SpellSourceContextData.fromJson(data) as T;
    }
    if (t == _izjjz5hc.StartingEquipmentBlockView) {
      return _izjjz5hc.StartingEquipmentBlockView.fromJson(data) as T;
    }
    if (t == _i3vgjwh2.StartingEquipmentOptionView) {
      return _i3vgjwh2.StartingEquipmentOptionView.fromJson(data) as T;
    }
    if (t == _isc.getType<_iydli74w.AuthActionResult?>()) {
      return (data != null ? _iydli74w.AuthActionResult.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i3katqli.BackgroundData?>()) {
      return (data != null ? _i3katqli.BackgroundData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i68we1de.ClassSpellGrantData?>()) {
      return (data != null
              ? _i68we1de.ClassSpellGrantData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iqilpl6d.DamagePartData?>()) {
      return (data != null ? _iqilpl6d.DamagePartData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1l5wul2.FeatData?>()) {
      return (data != null ? _i1l5wul2.FeatData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijpj2a9u.CharacterArmorTrainingOverridesData?>()) {
      return (data != null
              ? _ijpj2a9u.CharacterArmorTrainingOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iykib7lv.CharacterAttackData?>()) {
      return (data != null
              ? _iykib7lv.CharacterAttackData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibkyvw07.CharacterChangeData?>()) {
      return (data != null
              ? _ibkyvw07.CharacterChangeData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iwf32wta.CharacterChoiceData?>()) {
      return (data != null
              ? _iwf32wta.CharacterChoiceData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iqjjxby6.CharacterClassEntryData?>()) {
      return (data != null
              ? _iqjjxby6.CharacterClassEntryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_im2o0tmj.CharacterData?>()) {
      return (data != null ? _im2o0tmj.CharacterData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir4negfy.CharacterDerivedData?>()) {
      return (data != null
              ? _ir4negfy.CharacterDerivedData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i7jkadr4.CharacterEquipmentSelectionData?>()) {
      return (data != null
              ? _i7jkadr4.CharacterEquipmentSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iggvk3az.CharacterFeatureOverrideData?>()) {
      return (data != null
              ? _iggvk3az.CharacterFeatureOverrideData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_imlxp0ix.CharacterFeatureViewData?>()) {
      return (data != null
              ? _imlxp0ix.CharacterFeatureViewData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_id5dgxdg.CharacterInventoryItemData?>()) {
      return (data != null
              ? _id5dgxdg.CharacterInventoryItemData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibvj7xz5.CharacterLanguageOverridesData?>()) {
      return (data != null
              ? _ibvj7xz5.CharacterLanguageOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iqjbme11.CharacterNoteData?>()) {
      return (data != null ? _iqjbme11.CharacterNoteData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ig0fia1r.CharacterRejectedChangeData?>()) {
      return (data != null
              ? _ig0fia1r.CharacterRejectedChangeData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iu6zjs5s.CharacterResourceStateData?>()) {
      return (data != null
              ? _iu6zjs5s.CharacterResourceStateData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_io9jihae.CharacterResourceViewData?>()) {
      return (data != null
              ? _io9jihae.CharacterResourceViewData.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _isc
            .getType<
              _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData?
            >()) {
      return (data != null
              ? _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _isc.getType<_ivfw6q0y.CharacterSemanticActionData?>()) {
      return (data != null
              ? _ivfw6q0y.CharacterSemanticActionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_isl5krdt.CharacterSkillProficiencyState?>()) {
      return (data != null
              ? _isl5krdt.CharacterSkillProficiencyState.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_itkzfry3.CharacterSkillSelectionData?>()) {
      return (data != null
              ? _itkzfry3.CharacterSkillSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iesndgzw.CharacterSpellSelectionData?>()) {
      return (data != null
              ? _iesndgzw.CharacterSpellSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _isc.getType<_ieudcx2k.CharacterStartingEquipmentResolutionData?>()) {
      return (data != null
              ? _ieudcx2k.CharacterStartingEquipmentResolutionData.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t ==
        _isc.getType<_ixmjb4z5.CharacterStartingEquipmentSelectionData?>()) {
      return (data != null
              ? _ixmjb4z5.CharacterStartingEquipmentSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_is9ng6da.CharacterSyncOperationData?>()) {
      return (data != null
              ? _is9ng6da.CharacterSyncOperationData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_icxp0ddy.CharacterSyncRequest?>()) {
      return (data != null
              ? _icxp0ddy.CharacterSyncRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i29bgu3e.CharacterSyncResponse?>()) {
      return (data != null
              ? _i29bgu3e.CharacterSyncResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ix5qhw9w.CharacterSyncResult?>()) {
      return (data != null
              ? _ix5qhw9w.CharacterSyncResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixfhi6l8.CharacterSyncStatus?>()) {
      return (data != null
              ? _ixfhi6l8.CharacterSyncStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iz49jt9b.CharacterSyncValueData?>()) {
      return (data != null
              ? _iz49jt9b.CharacterSyncValueData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_idvpwngn.CharacterToolProficiencyOverridesData?>()) {
      return (data != null
              ? _idvpwngn.CharacterToolProficiencyOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _isc.getType<_i5e0copu.CharacterWeaponProficiencyOverridesData?>()) {
      return (data != null
              ? _i5e0copu.CharacterWeaponProficiencyOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i2mamrrk.ChoiceReplacementHistoryData?>()) {
      return (data != null
              ? _i2mamrrk.ChoiceReplacementHistoryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iij0mpeo.LevelUpChoiceReplacementData?>()) {
      return (data != null
              ? _iij0mpeo.LevelUpChoiceReplacementData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipxtly6g.LevelUpRequest?>()) {
      return (data != null ? _ipxtly6g.LevelUpRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4b5l3un.LevelUpSpellChoice?>()) {
      return (data != null ? _i4b5l3un.LevelUpSpellChoice.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i0tavl9b.RelatedFeatureViewData?>()) {
      return (data != null
              ? _i0tavl9b.RelatedFeatureViewData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_it45kp8q.SpellSelectionReplacementHistoryData?>()) {
      return (data != null
              ? _it45kp8q.SpellSelectionReplacementHistoryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i9cfge83.SpellSlotRecoveryTriggerData?>()) {
      return (data != null
              ? _i9cfge83.SpellSlotRecoveryTriggerData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i3zkka4q.ChoiceGroupData?>()) {
      return (data != null ? _i3zkka4q.ChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iprx2upt.ChoiceOptionData?>()) {
      return (data != null ? _iprx2upt.ChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iax2s634.ChoiceRequirementData?>()) {
      return (data != null
              ? _iax2s634.ChoiceRequirementData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i4e8ker2.ClassData?>()) {
      return (data != null ? _i4e8ker2.ClassData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijvqpc4v.ClassFeatureData?>()) {
      return (data != null ? _ijvqpc4v.ClassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isxi9i4e.ClassLevelData?>()) {
      return (data != null ? _isxi9i4e.ClassLevelData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ihr52fes.PreparedSpellRuleData?>()) {
      return (data != null
              ? _ihr52fes.PreparedSpellRuleData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ig6b5pj2.SpellSlotProgressionData?>()) {
      return (data != null
              ? _ig6b5pj2.SpellSlotProgressionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_igasg47n.StartingEquipmentBlockData?>()) {
      return (data != null
              ? _igasg47n.StartingEquipmentBlockData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_impna1yi.StartingEquipmentEntryData?>()) {
      return (data != null
              ? _impna1yi.StartingEquipmentEntryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iozcdomq.StartingEquipmentLineData?>()) {
      return (data != null
              ? _iozcdomq.StartingEquipmentLineData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iyz352zl.StartingEquipmentOptionData?>()) {
      return (data != null
              ? _iyz352zl.StartingEquipmentOptionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ijic8hve.SubclassData?>()) {
      return (data != null ? _ijic8hve.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iel0dp9q.SubclassFeatureData?>()) {
      return (data != null
              ? _iel0dp9q.SubclassFeatureData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i0aiwhe6.FeatureDisplayPropertyData?>()) {
      return (data != null
              ? _i0aiwhe6.FeatureDisplayPropertyData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iwfr4tm0.FeatureModifierConditionData?>()) {
      return (data != null
              ? _iwfr4tm0.FeatureModifierConditionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ilhpjxpt.FeatureModifierData?>()) {
      return (data != null
              ? _ilhpjxpt.FeatureModifierData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ircf4zmd.FeatureModifierValueData?>()) {
      return (data != null
              ? _ircf4zmd.FeatureModifierValueData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_isecmqna.FeatureRelationData?>()) {
      return (data != null
              ? _isecmqna.FeatureRelationData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iflv344v.FeatureResourceDefinitionData?>()) {
      return (data != null
              ? _iflv344v.FeatureResourceDefinitionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i86imp4g.FeatureResourceEffectData?>()) {
      return (data != null
              ? _i86imp4g.FeatureResourceEffectData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iafoerth.FeatureResourceProgressionValueData?>()) {
      return (data != null
              ? _iafoerth.FeatureResourceProgressionValueData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_irh2914h.RaceData?>()) {
      return (data != null ? _irh2914h.RaceData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_imnymvhh.RaceFeatureData?>()) {
      return (data != null ? _imnymvhh.RaceFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ilhjydvh.RaceFeatureSpellGrantData?>()) {
      return (data != null
              ? _ilhjydvh.RaceFeatureSpellGrantData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iqoglfsm.SubraceData?>()) {
      return (data != null ? _iqoglfsm.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_idolx2sf.SpellActivationData?>()) {
      return (data != null
              ? _idolx2sf.SpellActivationData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i9erq8kp.SpellResourceUpcastPolicyData?>()) {
      return (data != null
              ? _i9erq8kp.SpellResourceUpcastPolicyData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_in2nv22i.SpellSelectionFilterData?>()) {
      return (data != null
              ? _in2nv22i.SpellSelectionFilterData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipwf59gx.SpellSlotRecoveryPolicyData?>()) {
      return (data != null
              ? _ipwf59gx.SpellSlotRecoveryPolicyData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ivjna1ls.ToolData?>()) {
      return (data != null ? _ivjna1ls.ToolData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iv545qv3.ArmorData?>()) {
      return (data != null ? _iv545qv3.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ibuwh0hc.ItemData?>()) {
      return (data != null ? _ibuwh0hc.ItemData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i41tgptx.MagicItemData?>()) {
      return (data != null ? _i41tgptx.MagicItemData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_inpmmgks.WeaponData?>()) {
      return (data != null ? _inpmmgks.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itvh88br.SpellData?>()) {
      return (data != null ? _itvh88br.SpellData.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iq5q0wh8.SpellScalingData?>()) {
      return (data != null ? _iq5q0wh8.SpellScalingData.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ivey3rvd.DmCreatureException?>()) {
      return (data != null
              ? _ivey3rvd.DmCreatureException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i11aekbu.DmCreatureImportResult?>()) {
      return (data != null
              ? _i11aekbu.DmCreatureImportResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipuprlj7.DmCreatureRecord?>()) {
      return (data != null ? _ipuprlj7.DmCreatureRecord.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idf6hpk3.DmCreatureSummary?>()) {
      return (data != null ? _idf6hpk3.DmCreatureSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i5rga0su.Ability?>()) {
      return (data != null ? _i5rga0su.Ability.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ix11b24x.ArmorCategory?>()) {
      return (data != null ? _ix11b24x.ArmorCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik1o33an.CharacterAlignment?>()) {
      return (data != null ? _ik1o33an.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_idqm1edw.CharacterChangeType?>()) {
      return (data != null
              ? _idqm1edw.CharacterChangeType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_icxxpsvd.CharacterEntityType?>()) {
      return (data != null
              ? _icxxpsvd.CharacterEntityType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i1fix3of.CharacterFeatureSourceType?>()) {
      return (data != null
              ? _i1fix3of.CharacterFeatureSourceType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ik9iz51c.CharacterInventoryItemType?>()) {
      return (data != null
              ? _ik9iz51c.CharacterInventoryItemType.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _isc.getType<_ixbcln74.CharacterSavingThrowProficiencyOverride?>()) {
      return (data != null
              ? _ixbcln74.CharacterSavingThrowProficiencyOverride.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixj33h5c.CharacterSkillProficiencyLevel?>()) {
      return (data != null
              ? _ixj33h5c.CharacterSkillProficiencyLevel.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i3ppfbzb.CharacterSkillSelectionKind?>()) {
      return (data != null
              ? _i3ppfbzb.CharacterSkillSelectionKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ikyxycuo.CharacterSpeedKind?>()) {
      return (data != null ? _ikyxycuo.CharacterSpeedKind.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ie0q5aqi.CharacterSpellSelectionKind?>()) {
      return (data != null
              ? _ie0q5aqi.CharacterSpellSelectionKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i6jbrxie.CharacterSyncOperationType?>()) {
      return (data != null
              ? _i6jbrxie.CharacterSyncOperationType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ia4qs68v.CharacterSyncTargetType?>()) {
      return (data != null
              ? _ia4qs68v.CharacterSyncTargetType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ia6aulam.ChoiceRequirementType?>()) {
      return (data != null
              ? _ia6aulam.ChoiceRequirementType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iam6xy91.ChoiceSourceType?>()) {
      return (data != null ? _iam6xy91.ChoiceSourceType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iotu8r29.ChoiceType?>()) {
      return (data != null ? _iotu8r29.ChoiceType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ijyz5fbs.ClassSpellSelectionMode?>()) {
      return (data != null
              ? _ijyz5fbs.ClassSpellSelectionMode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ikb1pesi.ConditionType?>()) {
      return (data != null ? _ikb1pesi.ConditionType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6cngs6w.CreatureSize?>()) {
      return (data != null ? _i6cngs6w.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i6q2t5mj.DamageType?>()) {
      return (data != null ? _i6q2t5mj.DamageType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ia851nk8.EquipmentCatalogType?>()) {
      return (data != null
              ? _ia851nk8.EquipmentCatalogType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i9idws3v.FeatureDisplayPropertyValueKind?>()) {
      return (data != null
              ? _i9idws3v.FeatureDisplayPropertyValueKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ilgpxa54.FeatureModifierConditionType?>()) {
      return (data != null
              ? _ilgpxa54.FeatureModifierConditionType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i56op7oq.FeatureModifierOperation?>()) {
      return (data != null
              ? _i56op7oq.FeatureModifierOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i6asfa9j.FeatureModifierRounding?>()) {
      return (data != null
              ? _i6asfa9j.FeatureModifierRounding.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_izn79nb9.FeatureModifierTarget?>()) {
      return (data != null
              ? _izn79nb9.FeatureModifierTarget.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_il8rk55k.FeatureModifierValueKind?>()) {
      return (data != null
              ? _il8rk55k.FeatureModifierValueKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ih812opj.FeatureRelationType?>()) {
      return (data != null
              ? _ih812opj.FeatureRelationType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ijb3cn5v.FeatureResourceEffectType?>()) {
      return (data != null
              ? _ijb3cn5v.FeatureResourceEffectType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ia1vmwiq.FeatureResourceKind?>()) {
      return (data != null
              ? _ia1vmwiq.FeatureResourceKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ib4g5i7q.FeatureResourceMaxRule?>()) {
      return (data != null
              ? _ib4g5i7q.FeatureResourceMaxRule.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_if07r66f.FeatureResourceProgressionKey?>()) {
      return (data != null
              ? _if07r66f.FeatureResourceProgressionKey.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iyk5jgys.FeatureResourceTargetType?>()) {
      return (data != null
              ? _iyk5jgys.FeatureResourceTargetType.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ir3q1cdf.FeatureResourceTrigger?>()) {
      return (data != null
              ? _ir3q1cdf.FeatureResourceTrigger.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i2l7bpu3.FeatureTag?>()) {
      return (data != null ? _i2l7bpu3.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_izodp5lk.HitPointMode?>()) {
      return (data != null ? _izodp5lk.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iftbsk4q.Language?>()) {
      return (data != null ? _iftbsk4q.Language.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieum0m7f.PreparedSpellRounding?>()) {
      return (data != null
              ? _ieum0m7f.PreparedSpellRounding.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ibgbgp52.RestType?>()) {
      return (data != null ? _ibgbgp52.RestType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iy62ln0z.SenseType?>()) {
      return (data != null ? _iy62ln0z.SenseType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iabgjh08.Skill?>()) {
      return (data != null ? _iabgjh08.Skill.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ieavm63l.AreaOfEffectType?>()) {
      return (data != null ? _ieavm63l.AreaOfEffectType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iatx40hq.AreaSizeMeasurement?>()) {
      return (data != null
              ? _iatx40hq.AreaSizeMeasurement.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_inf83u33.SpellAttackType?>()) {
      return (data != null ? _inf83u33.SpellAttackType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9u2urpu.SpellDurationType?>()) {
      return (data != null ? _i9u2urpu.SpellDurationType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iw7hp9dc.SpellScalingMode?>()) {
      return (data != null ? _iw7hp9dc.SpellScalingMode.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ioahu9w9.SpellSchool?>()) {
      return (data != null ? _ioahu9w9.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iupu1e0e.SpellTargetType?>()) {
      return (data != null ? _iupu1e0e.SpellTargetType.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ik43ztmo.SpellSlotRecoveryMode?>()) {
      return (data != null
              ? _ik43ztmo.SpellSlotRecoveryMode.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ilfh4rku.SpellcastingProgression?>()) {
      return (data != null
              ? _ilfh4rku.SpellcastingProgression.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iag2d6aj.StartingEquipmentBlockKind?>()) {
      return (data != null
              ? _iag2d6aj.StartingEquipmentBlockKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipm8xyg1.StartingEquipmentEntryKind?>()) {
      return (data != null
              ? _ipm8xyg1.StartingEquipmentEntryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iniqanjc.StartingEquipmentLineKind?>()) {
      return (data != null
              ? _iniqanjc.StartingEquipmentLineKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ic2cpv54.ToolCategory?>()) {
      return (data != null ? _ic2cpv54.ToolCategory.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i4vk4r4o.UnarmoredDefenseRule?>()) {
      return (data != null
              ? _i4vk4r4o.UnarmoredDefenseRule.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iiyileog.WeaponCategory?>()) {
      return (data != null ? _iiyileog.WeaponCategory.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iur813s4.WeaponProperty?>()) {
      return (data != null ? _iur813s4.WeaponProperty.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1l5m7qw.LevelDownChoiceRepair?>()) {
      return (data != null
              ? _i1l5m7qw.LevelDownChoiceRepair.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_irktv0ea.LevelDownRequest?>()) {
      return (data != null ? _irktv0ea.LevelDownRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iqeghuxo.BackgroundStepView?>()) {
      return (data != null ? _iqeghuxo.BackgroundStepView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_isbrs5qf.CharacterEquipmentEntryView?>()) {
      return (data != null
              ? _isbrs5qf.CharacterEquipmentEntryView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i6xbclit.ChoiceGroupView?>()) {
      return (data != null ? _i6xbclit.ChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iil6pw38.ChoiceOptionEligibilityView?>()) {
      return (data != null
              ? _iil6pw38.ChoiceOptionEligibilityView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iob9tmlr.ChoiceRequirementFailureView?>()) {
      return (data != null
              ? _iob9tmlr.ChoiceRequirementFailureView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ik4ex2us.ClassSpellDeltaView?>()) {
      return (data != null
              ? _ik4ex2us.ClassSpellDeltaView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ixvig4n8.ClassSpellSelectionGroupView?>()) {
      return (data != null
              ? _ixvig4n8.ClassSpellSelectionGroupView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ih120cff.ClassStepFeatureView?>()) {
      return (data != null
              ? _ih120cff.ClassStepFeatureView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i3cyal5j.ClassStepSubclassChoiceView?>()) {
      return (data != null
              ? _i3cyal5j.ClassStepSubclassChoiceView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ib3duw15.ClassStepView?>()) {
      return (data != null ? _ib3duw15.ClassStepView.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i9kpkyz2.FeatureDisplayPropertyView?>()) {
      return (data != null
              ? _i9kpkyz2.FeatureDisplayPropertyView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iu8i64vu.LevelDownInvalidChoiceView?>()) {
      return (data != null
              ? _iu8i64vu.LevelDownInvalidChoiceView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ipbxh79i.LevelDownPreview?>()) {
      return (data != null ? _ipbxh79i.LevelDownPreview.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ipqjgw5e.LevelUpPreview?>()) {
      return (data != null ? _ipqjgw5e.LevelUpPreview.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ifavv51o.ProficiencyBundleView?>()) {
      return (data != null
              ? _ifavv51o.ProficiencyBundleView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_id360bq3.RaceStepView?>()) {
      return (data != null ? _id360bq3.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i8p2oglu.ResolvedCharacterSpellData?>()) {
      return (data != null
              ? _i8p2oglu.ResolvedCharacterSpellData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_im19jsv2.SelectedFeatureChoiceView?>()) {
      return (data != null
              ? _im19jsv2.SelectedFeatureChoiceView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ihn36a1g.SkillSelectionGroupView?>()) {
      return (data != null
              ? _ihn36a1g.SkillSelectionGroupView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_iam7pkuu.SpellSourceContextData?>()) {
      return (data != null
              ? _iam7pkuu.SpellSourceContextData.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_izjjz5hc.StartingEquipmentBlockView?>()) {
      return (data != null
              ? _izjjz5hc.StartingEquipmentBlockView.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_i3vgjwh2.StartingEquipmentOptionView?>()) {
      return (data != null
              ? _i3vgjwh2.StartingEquipmentOptionView.fromJson(data)
              : null)
          as T;
    }
    if (t == List<_iabgjh08.Skill>) {
      return (data as List).map((e) => deserialize<_iabgjh08.Skill>(e)).toList()
          as T;
    }
    if (t == _isc.getType<List<_iabgjh08.Skill>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iabgjh08.Skill>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _isc.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, int>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<int>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i2l7bpu3.FeatureTag>) {
      return (data as List)
              .map((e) => deserialize<_i2l7bpu3.FeatureTag>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i2l7bpu3.FeatureTag>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i2l7bpu3.FeatureTag>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ix11b24x.ArmorCategory>) {
      return (data as List)
              .map((e) => deserialize<_ix11b24x.ArmorCategory>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ix11b24x.ArmorCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ix11b24x.ArmorCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iqilpl6d.DamagePartData>) {
      return (data as List)
              .map((e) => deserialize<_iqilpl6d.DamagePartData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iqilpl6d.DamagePartData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iqilpl6d.DamagePartData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i2mamrrk.ChoiceReplacementHistoryData>) {
      return (data as List)
              .map(
                (e) => deserialize<_i2mamrrk.ChoiceReplacementHistoryData>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i2mamrrk.ChoiceReplacementHistoryData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_i2mamrrk.ChoiceReplacementHistoryData>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _isc.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, String>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<String>(v)),
                )
              : null)
          as T;
    }
    if (t == Map<int, int>) {
      return Map.fromEntries(
            (data as List).map(
              (e) =>
                  MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v'])),
            ),
          )
          as T;
    }
    if (t == _isc.getType<Map<int, int>?>()) {
      return (data != null
              ? Map.fromEntries(
                  (data as List).map(
                    (e) => MapEntry(
                      deserialize<int>(e['k']),
                      deserialize<int>(e['v']),
                    ),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_ikb1pesi.ConditionType>) {
      return (data as List)
              .map((e) => deserialize<_ikb1pesi.ConditionType>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ikb1pesi.ConditionType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ikb1pesi.ConditionType>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_id5dgxdg.CharacterInventoryItemData>) {
      return (data as List)
              .map((e) => deserialize<_id5dgxdg.CharacterInventoryItemData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_id5dgxdg.CharacterInventoryItemData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_id5dgxdg.CharacterInventoryItemData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_isl5krdt.CharacterSkillProficiencyState>) {
      return (data as List)
              .map(
                (e) => deserialize<_isl5krdt.CharacterSkillProficiencyState>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_isl5krdt.CharacterSkillProficiencyState>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_isl5krdt.CharacterSkillProficiencyState>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i5rga0su.Ability>) {
      return (data as List)
              .map((e) => deserialize<_i5rga0su.Ability>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i5rga0su.Ability>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i5rga0su.Ability>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i3yrtkjn.CharacterSavingThrowProficiencyOverrideData>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<
                      _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData
                    >(e),
              )
              .toList()
          as T;
    }
    if (t ==
        _isc
            .getType<
              List<_i3yrtkjn.CharacterSavingThrowProficiencyOverrideData>?
            >()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<
                            _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData
                          >(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iqjbme11.CharacterNoteData>) {
      return (data as List)
              .map((e) => deserialize<_iqjbme11.CharacterNoteData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iqjbme11.CharacterNoteData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iqjbme11.CharacterNoteData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iykib7lv.CharacterAttackData>) {
      return (data as List)
              .map((e) => deserialize<_iykib7lv.CharacterAttackData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iykib7lv.CharacterAttackData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iykib7lv.CharacterAttackData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iggvk3az.CharacterFeatureOverrideData>) {
      return (data as List)
              .map(
                (e) => deserialize<_iggvk3az.CharacterFeatureOverrideData>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iggvk3az.CharacterFeatureOverrideData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iggvk3az.CharacterFeatureOverrideData>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iu6zjs5s.CharacterResourceStateData>) {
      return (data as List)
              .map((e) => deserialize<_iu6zjs5s.CharacterResourceStateData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iu6zjs5s.CharacterResourceStateData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iu6zjs5s.CharacterResourceStateData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == Map<String, _i9cfge83.SpellSlotRecoveryTriggerData>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<_i9cfge83.SpellSlotRecoveryTriggerData>(v),
            ),
          )
          as T;
    }
    if (t ==
        _isc.getType<Map<String, _i9cfge83.SpellSlotRecoveryTriggerData>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) => MapEntry(
                    deserialize<String>(k),
                    deserialize<_i9cfge83.SpellSlotRecoveryTriggerData>(v),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_iqjjxby6.CharacterClassEntryData>) {
      return (data as List)
              .map((e) => deserialize<_iqjjxby6.CharacterClassEntryData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iqjjxby6.CharacterClassEntryData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) => deserialize<_iqjjxby6.CharacterClassEntryData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iwf32wta.CharacterChoiceData>) {
      return (data as List)
              .map((e) => deserialize<_iwf32wta.CharacterChoiceData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iwf32wta.CharacterChoiceData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iwf32wta.CharacterChoiceData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_itkzfry3.CharacterSkillSelectionData>) {
      return (data as List)
              .map((e) => deserialize<_itkzfry3.CharacterSkillSelectionData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_itkzfry3.CharacterSkillSelectionData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_itkzfry3.CharacterSkillSelectionData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iesndgzw.CharacterSpellSelectionData>) {
      return (data as List)
              .map((e) => deserialize<_iesndgzw.CharacterSpellSelectionData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iesndgzw.CharacterSpellSelectionData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iesndgzw.CharacterSpellSelectionData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ixmjb4z5.CharacterStartingEquipmentSelectionData>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<
                      _ixmjb4z5.CharacterStartingEquipmentSelectionData
                    >(e),
              )
              .toList()
          as T;
    }
    if (t ==
        _isc
            .getType<
              List<_ixmjb4z5.CharacterStartingEquipmentSelectionData>?
            >()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<
                            _ixmjb4z5.CharacterStartingEquipmentSelectionData
                          >(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == Map<_i5rga0su.Ability, int>) {
      return Map.fromEntries(
            (data as List).map(
              (e) => MapEntry(
                deserialize<_i5rga0su.Ability>(e['k']),
                deserialize<int>(e['v']),
              ),
            ),
          )
          as T;
    }
    if (t == _isc.getType<Map<_i5rga0su.Ability, int>?>()) {
      return (data != null
              ? Map.fromEntries(
                  (data as List).map(
                    (e) => MapEntry(
                      deserialize<_i5rga0su.Ability>(e['k']),
                      deserialize<int>(e['v']),
                    ),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_imlxp0ix.CharacterFeatureViewData>) {
      return (data as List)
              .map((e) => deserialize<_imlxp0ix.CharacterFeatureViewData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_imlxp0ix.CharacterFeatureViewData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) => deserialize<_imlxp0ix.CharacterFeatureViewData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ilhpjxpt.FeatureModifierData>) {
      return (data as List)
              .map((e) => deserialize<_ilhpjxpt.FeatureModifierData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ilhpjxpt.FeatureModifierData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ilhpjxpt.FeatureModifierData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == Map<_iabgjh08.Skill, int>) {
      return Map.fromEntries(
            (data as List).map(
              (e) => MapEntry(
                deserialize<_iabgjh08.Skill>(e['k']),
                deserialize<int>(e['v']),
              ),
            ),
          )
          as T;
    }
    if (t == _isc.getType<Map<_iabgjh08.Skill, int>?>()) {
      return (data != null
              ? Map.fromEntries(
                  (data as List).map(
                    (e) => MapEntry(
                      deserialize<_iabgjh08.Skill>(e['k']),
                      deserialize<int>(e['v']),
                    ),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_iftbsk4q.Language>) {
      return (data as List)
              .map((e) => deserialize<_iftbsk4q.Language>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iftbsk4q.Language>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iftbsk4q.Language>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iiyileog.WeaponCategory>) {
      return (data as List)
              .map((e) => deserialize<_iiyileog.WeaponCategory>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iiyileog.WeaponCategory>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iiyileog.WeaponCategory>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i8p2oglu.ResolvedCharacterSpellData>) {
      return (data as List)
              .map((e) => deserialize<_i8p2oglu.ResolvedCharacterSpellData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i8p2oglu.ResolvedCharacterSpellData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_i8p2oglu.ResolvedCharacterSpellData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_isbrs5qf.CharacterEquipmentEntryView>) {
      return (data as List)
              .map((e) => deserialize<_isbrs5qf.CharacterEquipmentEntryView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_isbrs5qf.CharacterEquipmentEntryView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_isbrs5qf.CharacterEquipmentEntryView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i6q2t5mj.DamageType>) {
      return (data as List)
              .map((e) => deserialize<_i6q2t5mj.DamageType>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i6q2t5mj.DamageType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i6q2t5mj.DamageType>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_io9jihae.CharacterResourceViewData>) {
      return (data as List)
              .map((e) => deserialize<_io9jihae.CharacterResourceViewData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_io9jihae.CharacterResourceViewData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_io9jihae.CharacterResourceViewData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i9kpkyz2.FeatureDisplayPropertyView>) {
      return (data as List)
              .map((e) => deserialize<_i9kpkyz2.FeatureDisplayPropertyView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i9kpkyz2.FeatureDisplayPropertyView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_i9kpkyz2.FeatureDisplayPropertyView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i0tavl9b.RelatedFeatureViewData>) {
      return (data as List)
              .map((e) => deserialize<_i0tavl9b.RelatedFeatureViewData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i0tavl9b.RelatedFeatureViewData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) => deserialize<_i0tavl9b.RelatedFeatureViewData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_im19jsv2.SelectedFeatureChoiceView>) {
      return (data as List)
              .map((e) => deserialize<_im19jsv2.SelectedFeatureChoiceView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_im19jsv2.SelectedFeatureChoiceView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_im19jsv2.SelectedFeatureChoiceView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i86imp4g.FeatureResourceEffectData>) {
      return (data as List)
              .map((e) => deserialize<_i86imp4g.FeatureResourceEffectData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i86imp4g.FeatureResourceEffectData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_i86imp4g.FeatureResourceEffectData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_it45kp8q.SpellSelectionReplacementHistoryData>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_it45kp8q.SpellSelectionReplacementHistoryData>(
                      e,
                    ),
              )
              .toList()
          as T;
    }
    if (t ==
        _isc.getType<List<_it45kp8q.SpellSelectionReplacementHistoryData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<
                            _it45kp8q.SpellSelectionReplacementHistoryData
                          >(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ieudcx2k.CharacterStartingEquipmentResolutionData>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<
                      _ieudcx2k.CharacterStartingEquipmentResolutionData
                    >(e),
              )
              .toList()
          as T;
    }
    if (t ==
        _isc
            .getType<
              List<_ieudcx2k.CharacterStartingEquipmentResolutionData>?
            >()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<
                            _ieudcx2k.CharacterStartingEquipmentResolutionData
                          >(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ibkyvw07.CharacterChangeData>) {
      return (data as List)
              .map((e) => deserialize<_ibkyvw07.CharacterChangeData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ibkyvw07.CharacterChangeData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ibkyvw07.CharacterChangeData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_is9ng6da.CharacterSyncOperationData>) {
      return (data as List)
              .map((e) => deserialize<_is9ng6da.CharacterSyncOperationData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_is9ng6da.CharacterSyncOperationData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_is9ng6da.CharacterSyncOperationData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ig0fia1r.CharacterRejectedChangeData>) {
      return (data as List)
              .map((e) => deserialize<_ig0fia1r.CharacterRejectedChangeData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ig0fia1r.CharacterRejectedChangeData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_ig0fia1r.CharacterRejectedChangeData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_im2o0tmj.CharacterData>) {
      return (data as List)
              .map((e) => deserialize<_im2o0tmj.CharacterData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_im2o0tmj.CharacterData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_im2o0tmj.CharacterData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == Map<String, _im2o0tmj.CharacterData>) {
      return (data as Map).map(
            (k, v) => MapEntry(
              deserialize<String>(k),
              deserialize<_im2o0tmj.CharacterData>(v),
            ),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, _im2o0tmj.CharacterData>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) => MapEntry(
                    deserialize<String>(k),
                    deserialize<_im2o0tmj.CharacterData>(v),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_iij0mpeo.LevelUpChoiceReplacementData>) {
      return (data as List)
              .map(
                (e) => deserialize<_iij0mpeo.LevelUpChoiceReplacementData>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iij0mpeo.LevelUpChoiceReplacementData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iij0mpeo.LevelUpChoiceReplacementData>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == Map<String, List<String>>) {
      return (data as Map).map(
            (k, v) =>
                MapEntry(deserialize<String>(k), deserialize<List<String>>(v)),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, List<String>>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) => MapEntry(
                    deserialize<String>(k),
                    deserialize<List<String>>(v),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_i4b5l3un.LevelUpSpellChoice>) {
      return (data as List)
              .map((e) => deserialize<_i4b5l3un.LevelUpSpellChoice>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i4b5l3un.LevelUpSpellChoice>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i4b5l3un.LevelUpSpellChoice>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iax2s634.ChoiceRequirementData>) {
      return (data as List)
              .map((e) => deserialize<_iax2s634.ChoiceRequirementData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iax2s634.ChoiceRequirementData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iax2s634.ChoiceRequirementData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iflv344v.FeatureResourceDefinitionData>) {
      return (data as List)
              .map(
                (e) => deserialize<_iflv344v.FeatureResourceDefinitionData>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iflv344v.FeatureResourceDefinitionData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iflv344v.FeatureResourceDefinitionData>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i68we1de.ClassSpellGrantData>) {
      return (data as List)
              .map((e) => deserialize<_i68we1de.ClassSpellGrantData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i68we1de.ClassSpellGrantData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i68we1de.ClassSpellGrantData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iozcdomq.StartingEquipmentLineData>) {
      return (data as List)
              .map((e) => deserialize<_iozcdomq.StartingEquipmentLineData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iozcdomq.StartingEquipmentLineData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iozcdomq.StartingEquipmentLineData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iyz352zl.StartingEquipmentOptionData>) {
      return (data as List)
              .map((e) => deserialize<_iyz352zl.StartingEquipmentOptionData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iyz352zl.StartingEquipmentOptionData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iyz352zl.StartingEquipmentOptionData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == Map<int, String>) {
      return Map.fromEntries(
            (data as List).map(
              (e) => MapEntry(
                deserialize<int>(e['k']),
                deserialize<String>(e['v']),
              ),
            ),
          )
          as T;
    }
    if (t == _isc.getType<Map<int, String>?>()) {
      return (data != null
              ? Map.fromEntries(
                  (data as List).map(
                    (e) => MapEntry(
                      deserialize<int>(e['k']),
                      deserialize<String>(e['v']),
                    ),
                  ),
                )
              : null)
          as T;
    }
    if (t == List<_iwfr4tm0.FeatureModifierConditionData>) {
      return (data as List)
              .map(
                (e) => deserialize<_iwfr4tm0.FeatureModifierConditionData>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iwfr4tm0.FeatureModifierConditionData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iwfr4tm0.FeatureModifierConditionData>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iafoerth.FeatureResourceProgressionValueData>) {
      return (data as List)
              .map(
                (e) =>
                    deserialize<_iafoerth.FeatureResourceProgressionValueData>(
                      e,
                    ),
              )
              .toList()
          as T;
    }
    if (t ==
        _isc.getType<List<_iafoerth.FeatureResourceProgressionValueData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<
                            _iafoerth.FeatureResourceProgressionValueData
                          >(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_imnymvhh.RaceFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_imnymvhh.RaceFeatureData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_imnymvhh.RaceFeatureData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_imnymvhh.RaceFeatureData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ilhjydvh.RaceFeatureSpellGrantData>) {
      return (data as List)
              .map((e) => deserialize<_ilhjydvh.RaceFeatureSpellGrantData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ilhjydvh.RaceFeatureSpellGrantData>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_ilhjydvh.RaceFeatureSpellGrantData>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ioahu9w9.SpellSchool>) {
      return (data as List)
              .map((e) => deserialize<_ioahu9w9.SpellSchool>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ioahu9w9.SpellSchool>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ioahu9w9.SpellSchool>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ie0q5aqi.CharacterSpellSelectionKind>) {
      return (data as List)
              .map((e) => deserialize<_ie0q5aqi.CharacterSpellSelectionKind>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ie0q5aqi.CharacterSpellSelectionKind>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_ie0q5aqi.CharacterSpellSelectionKind>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iur813s4.WeaponProperty>) {
      return (data as List)
              .map((e) => deserialize<_iur813s4.WeaponProperty>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iur813s4.WeaponProperty>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iur813s4.WeaponProperty>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i1l5m7qw.LevelDownChoiceRepair>) {
      return (data as List)
              .map((e) => deserialize<_i1l5m7qw.LevelDownChoiceRepair>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i1l5m7qw.LevelDownChoiceRepair>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i1l5m7qw.LevelDownChoiceRepair>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i6xbclit.ChoiceGroupView>) {
      return (data as List)
              .map((e) => deserialize<_i6xbclit.ChoiceGroupView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i6xbclit.ChoiceGroupView>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i6xbclit.ChoiceGroupView>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ihn36a1g.SkillSelectionGroupView>) {
      return (data as List)
              .map((e) => deserialize<_ihn36a1g.SkillSelectionGroupView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ihn36a1g.SkillSelectionGroupView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) => deserialize<_ihn36a1g.SkillSelectionGroupView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_izjjz5hc.StartingEquipmentBlockView>) {
      return (data as List)
              .map((e) => deserialize<_izjjz5hc.StartingEquipmentBlockView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_izjjz5hc.StartingEquipmentBlockView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_izjjz5hc.StartingEquipmentBlockView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iprx2upt.ChoiceOptionData>) {
      return (data as List)
              .map((e) => deserialize<_iprx2upt.ChoiceOptionData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iprx2upt.ChoiceOptionData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iprx2upt.ChoiceOptionData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iil6pw38.ChoiceOptionEligibilityView>) {
      return (data as List)
              .map((e) => deserialize<_iil6pw38.ChoiceOptionEligibilityView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iil6pw38.ChoiceOptionEligibilityView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iil6pw38.ChoiceOptionEligibilityView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iob9tmlr.ChoiceRequirementFailureView>) {
      return (data as List)
              .map(
                (e) => deserialize<_iob9tmlr.ChoiceRequirementFailureView>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iob9tmlr.ChoiceRequirementFailureView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_iob9tmlr.ChoiceRequirementFailureView>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_itvh88br.SpellData>) {
      return (data as List)
              .map((e) => deserialize<_itvh88br.SpellData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_itvh88br.SpellData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_itvh88br.SpellData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ijic8hve.SubclassData>) {
      return (data as List)
              .map((e) => deserialize<_ijic8hve.SubclassData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ijic8hve.SubclassData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ijic8hve.SubclassData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ijvqpc4v.ClassFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_ijvqpc4v.ClassFeatureData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ijvqpc4v.ClassFeatureData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ijvqpc4v.ClassFeatureData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iel0dp9q.SubclassFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_iel0dp9q.SubclassFeatureData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iel0dp9q.SubclassFeatureData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iel0dp9q.SubclassFeatureData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ih120cff.ClassStepFeatureView>) {
      return (data as List)
              .map((e) => deserialize<_ih120cff.ClassStepFeatureView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ih120cff.ClassStepFeatureView>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_ih120cff.ClassStepFeatureView>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_ixvig4n8.ClassSpellSelectionGroupView>) {
      return (data as List)
              .map(
                (e) => deserialize<_ixvig4n8.ClassSpellSelectionGroupView>(e),
              )
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_ixvig4n8.ClassSpellSelectionGroupView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_ixvig4n8.ClassSpellSelectionGroupView>(
                            e,
                          ),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_isxi9i4e.ClassLevelData>) {
      return (data as List)
              .map((e) => deserialize<_isxi9i4e.ClassLevelData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_isxi9i4e.ClassLevelData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_isxi9i4e.ClassLevelData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i3zkka4q.ChoiceGroupData>) {
      return (data as List)
              .map((e) => deserialize<_i3zkka4q.ChoiceGroupData>(e))
              .toList()
          as T;
    }
    if (t == List<_iu8i64vu.LevelDownInvalidChoiceView>) {
      return (data as List)
              .map((e) => deserialize<_iu8i64vu.LevelDownInvalidChoiceView>(e))
              .toList()
          as T;
    }
    if (t == List<_iqoglfsm.SubraceData>) {
      return (data as List)
              .map((e) => deserialize<_iqoglfsm.SubraceData>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_iqoglfsm.SubraceData>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_iqoglfsm.SubraceData>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_iam7pkuu.SpellSourceContextData>) {
      return (data as List)
              .map((e) => deserialize<_iam7pkuu.SpellSourceContextData>(e))
              .toList()
          as T;
    }
    if (t == List<_i3vgjwh2.StartingEquipmentOptionView>) {
      return (data as List)
              .map((e) => deserialize<_i3vgjwh2.StartingEquipmentOptionView>(e))
              .toList()
          as T;
    }
    if (t == _isc.getType<List<_i3vgjwh2.StartingEquipmentOptionView>?>()) {
      return (data != null
              ? (data as List)
                    .map(
                      (e) =>
                          deserialize<_i3vgjwh2.StartingEquipmentOptionView>(e),
                    )
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i312scxx.UserInfo>) {
      return (data as List)
              .map((e) => deserialize<_i312scxx.UserInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_iuiuigdt.DmCreatureSummary>) {
      return (data as List)
              .map((e) => deserialize<_iuiuigdt.DmCreatureSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ir4mnztf.BackgroundData>) {
      return (data as List)
              .map((e) => deserialize<_ir4mnztf.BackgroundData>(e))
              .toList()
          as T;
    }
    if (t == List<_ipq9e85u.FeatData>) {
      return (data as List)
              .map((e) => deserialize<_ipq9e85u.FeatData>(e))
              .toList()
          as T;
    }
    if (t == List<_i82zmloj.CharacterData>) {
      return (data as List)
              .map((e) => deserialize<_i82zmloj.CharacterData>(e))
              .toList()
          as T;
    }
    if (t == List<_i44xjl6j.ChoiceGroupData>) {
      return (data as List)
              .map((e) => deserialize<_i44xjl6j.ChoiceGroupData>(e))
              .toList()
          as T;
    }
    if (t == List<_iqcr63pm.ChoiceOptionData>) {
      return (data as List)
              .map((e) => deserialize<_iqcr63pm.ChoiceOptionData>(e))
              .toList()
          as T;
    }
    if (t == List<_i3mngh91.ClassData>) {
      return (data as List)
              .map((e) => deserialize<_i3mngh91.ClassData>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == _isc.getType<Map<String, int>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<int>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_iozr72e1.ClassFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_iozr72e1.ClassFeatureData>(e))
              .toList()
          as T;
    }
    if (t == List<_ibq4gqkd.ClassSpellGrantData>) {
      return (data as List)
              .map((e) => deserialize<_ibq4gqkd.ClassSpellGrantData>(e))
              .toList()
          as T;
    }
    if (t == List<_izzx945w.ClassLevelData>) {
      return (data as List)
              .map((e) => deserialize<_izzx945w.ClassLevelData>(e))
              .toList()
          as T;
    }
    if (t == List<_i8v86dtn.SpellSlotProgressionData>) {
      return (data as List)
              .map((e) => deserialize<_i8v86dtn.SpellSlotProgressionData>(e))
              .toList()
          as T;
    }
    if (t == List<_iuhgku0a.SubclassData>) {
      return (data as List)
              .map((e) => deserialize<_iuhgku0a.SubclassData>(e))
              .toList()
          as T;
    }
    if (t == List<_is2mx8yv.SubclassFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_is2mx8yv.SubclassFeatureData>(e))
              .toList()
          as T;
    }
    if (t == List<_ifrx84um.FeatureRelationData>) {
      return (data as List)
              .map((e) => deserialize<_ifrx84um.FeatureRelationData>(e))
              .toList()
          as T;
    }
    if (t == List<_ilc3ntdx.RaceData>) {
      return (data as List)
              .map((e) => deserialize<_ilc3ntdx.RaceData>(e))
              .toList()
          as T;
    }
    if (t == List<_imf9k3ru.RaceFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_imf9k3ru.RaceFeatureData>(e))
              .toList()
          as T;
    }
    if (t == List<_i5ca8sk9.SubraceData>) {
      return (data as List)
              .map((e) => deserialize<_i5ca8sk9.SubraceData>(e))
              .toList()
          as T;
    }
    if (t == List<_i9vzxbi6.RaceFeatureSpellGrantData>) {
      return (data as List)
              .map((e) => deserialize<_i9vzxbi6.RaceFeatureSpellGrantData>(e))
              .toList()
          as T;
    }
    if (t == List<_izep6fcb.ToolData>) {
      return (data as List)
              .map((e) => deserialize<_izep6fcb.ToolData>(e))
              .toList()
          as T;
    }
    if (t == List<_i4pe33cv.ArmorData>) {
      return (data as List)
              .map((e) => deserialize<_i4pe33cv.ArmorData>(e))
              .toList()
          as T;
    }
    if (t == List<_iqylf6yx.ItemData>) {
      return (data as List)
              .map((e) => deserialize<_iqylf6yx.ItemData>(e))
              .toList()
          as T;
    }
    if (t == List<_ig7tbc7e.MagicItemData>) {
      return (data as List)
              .map((e) => deserialize<_ig7tbc7e.MagicItemData>(e))
              .toList()
          as T;
    }
    if (t == List<_i5q8wx5t.WeaponData>) {
      return (data as List)
              .map((e) => deserialize<_i5q8wx5t.WeaponData>(e))
              .toList()
          as T;
    }
    if (t == List<_ic7268ss.SpellData>) {
      return (data as List)
              .map((e) => deserialize<_ic7268ss.SpellData>(e))
              .toList()
          as T;
    }
    try {
      return _i312scxx.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iydli74w.AuthActionResult => 'AuthActionResult',
      _i3katqli.BackgroundData => 'BackgroundData',
      _i68we1de.ClassSpellGrantData => 'ClassSpellGrantData',
      _iqilpl6d.DamagePartData => 'DamagePartData',
      _i1l5wul2.FeatData => 'FeatData',
      _ijpj2a9u.CharacterArmorTrainingOverridesData =>
        'CharacterArmorTrainingOverridesData',
      _iykib7lv.CharacterAttackData => 'CharacterAttackData',
      _ibkyvw07.CharacterChangeData => 'CharacterChangeData',
      _iwf32wta.CharacterChoiceData => 'CharacterChoiceData',
      _iqjjxby6.CharacterClassEntryData => 'CharacterClassEntryData',
      _im2o0tmj.CharacterData => 'CharacterData',
      _ir4negfy.CharacterDerivedData => 'CharacterDerivedData',
      _i7jkadr4.CharacterEquipmentSelectionData =>
        'CharacterEquipmentSelectionData',
      _iggvk3az.CharacterFeatureOverrideData => 'CharacterFeatureOverrideData',
      _imlxp0ix.CharacterFeatureViewData => 'CharacterFeatureViewData',
      _id5dgxdg.CharacterInventoryItemData => 'CharacterInventoryItemData',
      _ibvj7xz5.CharacterLanguageOverridesData =>
        'CharacterLanguageOverridesData',
      _iqjbme11.CharacterNoteData => 'CharacterNoteData',
      _ig0fia1r.CharacterRejectedChangeData => 'CharacterRejectedChangeData',
      _iu6zjs5s.CharacterResourceStateData => 'CharacterResourceStateData',
      _io9jihae.CharacterResourceViewData => 'CharacterResourceViewData',
      _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData =>
        'CharacterSavingThrowProficiencyOverrideData',
      _ivfw6q0y.CharacterSemanticActionData => 'CharacterSemanticActionData',
      _isl5krdt.CharacterSkillProficiencyState =>
        'CharacterSkillProficiencyState',
      _itkzfry3.CharacterSkillSelectionData => 'CharacterSkillSelectionData',
      _iesndgzw.CharacterSpellSelectionData => 'CharacterSpellSelectionData',
      _ieudcx2k.CharacterStartingEquipmentResolutionData =>
        'CharacterStartingEquipmentResolutionData',
      _ixmjb4z5.CharacterStartingEquipmentSelectionData =>
        'CharacterStartingEquipmentSelectionData',
      _is9ng6da.CharacterSyncOperationData => 'CharacterSyncOperationData',
      _icxp0ddy.CharacterSyncRequest => 'CharacterSyncRequest',
      _i29bgu3e.CharacterSyncResponse => 'CharacterSyncResponse',
      _ix5qhw9w.CharacterSyncResult => 'CharacterSyncResult',
      _ixfhi6l8.CharacterSyncStatus => 'CharacterSyncStatus',
      _iz49jt9b.CharacterSyncValueData => 'CharacterSyncValueData',
      _idvpwngn.CharacterToolProficiencyOverridesData =>
        'CharacterToolProficiencyOverridesData',
      _i5e0copu.CharacterWeaponProficiencyOverridesData =>
        'CharacterWeaponProficiencyOverridesData',
      _i2mamrrk.ChoiceReplacementHistoryData => 'ChoiceReplacementHistoryData',
      _iij0mpeo.LevelUpChoiceReplacementData => 'LevelUpChoiceReplacementData',
      _ipxtly6g.LevelUpRequest => 'LevelUpRequest',
      _i4b5l3un.LevelUpSpellChoice => 'LevelUpSpellChoice',
      _i0tavl9b.RelatedFeatureViewData => 'RelatedFeatureViewData',
      _it45kp8q.SpellSelectionReplacementHistoryData =>
        'SpellSelectionReplacementHistoryData',
      _i9cfge83.SpellSlotRecoveryTriggerData => 'SpellSlotRecoveryTriggerData',
      _i3zkka4q.ChoiceGroupData => 'ChoiceGroupData',
      _iprx2upt.ChoiceOptionData => 'ChoiceOptionData',
      _iax2s634.ChoiceRequirementData => 'ChoiceRequirementData',
      _i4e8ker2.ClassData => 'ClassData',
      _ijvqpc4v.ClassFeatureData => 'ClassFeatureData',
      _isxi9i4e.ClassLevelData => 'ClassLevelData',
      _ihr52fes.PreparedSpellRuleData => 'PreparedSpellRuleData',
      _ig6b5pj2.SpellSlotProgressionData => 'SpellSlotProgressionData',
      _igasg47n.StartingEquipmentBlockData => 'StartingEquipmentBlockData',
      _impna1yi.StartingEquipmentEntryData => 'StartingEquipmentEntryData',
      _iozcdomq.StartingEquipmentLineData => 'StartingEquipmentLineData',
      _iyz352zl.StartingEquipmentOptionData => 'StartingEquipmentOptionData',
      _ijic8hve.SubclassData => 'SubclassData',
      _iel0dp9q.SubclassFeatureData => 'SubclassFeatureData',
      _i0aiwhe6.FeatureDisplayPropertyData => 'FeatureDisplayPropertyData',
      _iwfr4tm0.FeatureModifierConditionData => 'FeatureModifierConditionData',
      _ilhpjxpt.FeatureModifierData => 'FeatureModifierData',
      _ircf4zmd.FeatureModifierValueData => 'FeatureModifierValueData',
      _isecmqna.FeatureRelationData => 'FeatureRelationData',
      _iflv344v.FeatureResourceDefinitionData =>
        'FeatureResourceDefinitionData',
      _i86imp4g.FeatureResourceEffectData => 'FeatureResourceEffectData',
      _iafoerth.FeatureResourceProgressionValueData =>
        'FeatureResourceProgressionValueData',
      _irh2914h.RaceData => 'RaceData',
      _imnymvhh.RaceFeatureData => 'RaceFeatureData',
      _ilhjydvh.RaceFeatureSpellGrantData => 'RaceFeatureSpellGrantData',
      _iqoglfsm.SubraceData => 'SubraceData',
      _idolx2sf.SpellActivationData => 'SpellActivationData',
      _i9erq8kp.SpellResourceUpcastPolicyData =>
        'SpellResourceUpcastPolicyData',
      _in2nv22i.SpellSelectionFilterData => 'SpellSelectionFilterData',
      _ipwf59gx.SpellSlotRecoveryPolicyData => 'SpellSlotRecoveryPolicyData',
      _ivjna1ls.ToolData => 'ToolData',
      _iv545qv3.ArmorData => 'ArmorData',
      _ibuwh0hc.ItemData => 'ItemData',
      _i41tgptx.MagicItemData => 'MagicItemData',
      _inpmmgks.WeaponData => 'WeaponData',
      _itvh88br.SpellData => 'SpellData',
      _iq5q0wh8.SpellScalingData => 'SpellScalingData',
      _ivey3rvd.DmCreatureException => 'DmCreatureException',
      _i11aekbu.DmCreatureImportResult => 'DmCreatureImportResult',
      _ipuprlj7.DmCreatureRecord => 'DmCreatureRecord',
      _idf6hpk3.DmCreatureSummary => 'DmCreatureSummary',
      _i5rga0su.Ability => 'Ability',
      _ix11b24x.ArmorCategory => 'ArmorCategory',
      _ik1o33an.CharacterAlignment => 'CharacterAlignment',
      _idqm1edw.CharacterChangeType => 'CharacterChangeType',
      _icxxpsvd.CharacterEntityType => 'CharacterEntityType',
      _i1fix3of.CharacterFeatureSourceType => 'CharacterFeatureSourceType',
      _ik9iz51c.CharacterInventoryItemType => 'CharacterInventoryItemType',
      _ixbcln74.CharacterSavingThrowProficiencyOverride =>
        'CharacterSavingThrowProficiencyOverride',
      _ixj33h5c.CharacterSkillProficiencyLevel =>
        'CharacterSkillProficiencyLevel',
      _i3ppfbzb.CharacterSkillSelectionKind => 'CharacterSkillSelectionKind',
      _ikyxycuo.CharacterSpeedKind => 'CharacterSpeedKind',
      _ie0q5aqi.CharacterSpellSelectionKind => 'CharacterSpellSelectionKind',
      _i6jbrxie.CharacterSyncOperationType => 'CharacterSyncOperationType',
      _ia4qs68v.CharacterSyncTargetType => 'CharacterSyncTargetType',
      _ia6aulam.ChoiceRequirementType => 'ChoiceRequirementType',
      _iam6xy91.ChoiceSourceType => 'ChoiceSourceType',
      _iotu8r29.ChoiceType => 'ChoiceType',
      _ijyz5fbs.ClassSpellSelectionMode => 'ClassSpellSelectionMode',
      _ikb1pesi.ConditionType => 'ConditionType',
      _i6cngs6w.CreatureSize => 'CreatureSize',
      _i6q2t5mj.DamageType => 'DamageType',
      _ia851nk8.EquipmentCatalogType => 'EquipmentCatalogType',
      _i9idws3v.FeatureDisplayPropertyValueKind =>
        'FeatureDisplayPropertyValueKind',
      _ilgpxa54.FeatureModifierConditionType => 'FeatureModifierConditionType',
      _i56op7oq.FeatureModifierOperation => 'FeatureModifierOperation',
      _i6asfa9j.FeatureModifierRounding => 'FeatureModifierRounding',
      _izn79nb9.FeatureModifierTarget => 'FeatureModifierTarget',
      _il8rk55k.FeatureModifierValueKind => 'FeatureModifierValueKind',
      _ih812opj.FeatureRelationType => 'FeatureRelationType',
      _ijb3cn5v.FeatureResourceEffectType => 'FeatureResourceEffectType',
      _ia1vmwiq.FeatureResourceKind => 'FeatureResourceKind',
      _ib4g5i7q.FeatureResourceMaxRule => 'FeatureResourceMaxRule',
      _if07r66f.FeatureResourceProgressionKey =>
        'FeatureResourceProgressionKey',
      _iyk5jgys.FeatureResourceTargetType => 'FeatureResourceTargetType',
      _ir3q1cdf.FeatureResourceTrigger => 'FeatureResourceTrigger',
      _i2l7bpu3.FeatureTag => 'FeatureTag',
      _izodp5lk.HitPointMode => 'HitPointMode',
      _iftbsk4q.Language => 'Language',
      _ieum0m7f.PreparedSpellRounding => 'PreparedSpellRounding',
      _ibgbgp52.RestType => 'RestType',
      _iy62ln0z.SenseType => 'SenseType',
      _iabgjh08.Skill => 'Skill',
      _ieavm63l.AreaOfEffectType => 'AreaOfEffectType',
      _iatx40hq.AreaSizeMeasurement => 'AreaSizeMeasurement',
      _inf83u33.SpellAttackType => 'SpellAttackType',
      _i9u2urpu.SpellDurationType => 'SpellDurationType',
      _iw7hp9dc.SpellScalingMode => 'SpellScalingMode',
      _ioahu9w9.SpellSchool => 'SpellSchool',
      _iupu1e0e.SpellTargetType => 'SpellTargetType',
      _ik43ztmo.SpellSlotRecoveryMode => 'SpellSlotRecoveryMode',
      _ilfh4rku.SpellcastingProgression => 'SpellcastingProgression',
      _iag2d6aj.StartingEquipmentBlockKind => 'StartingEquipmentBlockKind',
      _ipm8xyg1.StartingEquipmentEntryKind => 'StartingEquipmentEntryKind',
      _iniqanjc.StartingEquipmentLineKind => 'StartingEquipmentLineKind',
      _ic2cpv54.ToolCategory => 'ToolCategory',
      _i4vk4r4o.UnarmoredDefenseRule => 'UnarmoredDefenseRule',
      _iiyileog.WeaponCategory => 'WeaponCategory',
      _iur813s4.WeaponProperty => 'WeaponProperty',
      _i1l5m7qw.LevelDownChoiceRepair => 'LevelDownChoiceRepair',
      _irktv0ea.LevelDownRequest => 'LevelDownRequest',
      _iqeghuxo.BackgroundStepView => 'BackgroundStepView',
      _isbrs5qf.CharacterEquipmentEntryView => 'CharacterEquipmentEntryView',
      _i6xbclit.ChoiceGroupView => 'ChoiceGroupView',
      _iil6pw38.ChoiceOptionEligibilityView => 'ChoiceOptionEligibilityView',
      _iob9tmlr.ChoiceRequirementFailureView => 'ChoiceRequirementFailureView',
      _ik4ex2us.ClassSpellDeltaView => 'ClassSpellDeltaView',
      _ixvig4n8.ClassSpellSelectionGroupView => 'ClassSpellSelectionGroupView',
      _ih120cff.ClassStepFeatureView => 'ClassStepFeatureView',
      _i3cyal5j.ClassStepSubclassChoiceView => 'ClassStepSubclassChoiceView',
      _ib3duw15.ClassStepView => 'ClassStepView',
      _i9kpkyz2.FeatureDisplayPropertyView => 'FeatureDisplayPropertyView',
      _iu8i64vu.LevelDownInvalidChoiceView => 'LevelDownInvalidChoiceView',
      _ipbxh79i.LevelDownPreview => 'LevelDownPreview',
      _ipqjgw5e.LevelUpPreview => 'LevelUpPreview',
      _ifavv51o.ProficiencyBundleView => 'ProficiencyBundleView',
      _id360bq3.RaceStepView => 'RaceStepView',
      _i8p2oglu.ResolvedCharacterSpellData => 'ResolvedCharacterSpellData',
      _im19jsv2.SelectedFeatureChoiceView => 'SelectedFeatureChoiceView',
      _ihn36a1g.SkillSelectionGroupView => 'SkillSelectionGroupView',
      _iam7pkuu.SpellSourceContextData => 'SpellSourceContextData',
      _izjjz5hc.StartingEquipmentBlockView => 'StartingEquipmentBlockView',
      _i3vgjwh2.StartingEquipmentOptionView => 'StartingEquipmentOptionView',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'characters_mirror.',
        '',
      );
    }

    switch (data) {
      case _iydli74w.AuthActionResult():
        return 'AuthActionResult';
      case _i3katqli.BackgroundData():
        return 'BackgroundData';
      case _i68we1de.ClassSpellGrantData():
        return 'ClassSpellGrantData';
      case _iqilpl6d.DamagePartData():
        return 'DamagePartData';
      case _i1l5wul2.FeatData():
        return 'FeatData';
      case _ijpj2a9u.CharacterArmorTrainingOverridesData():
        return 'CharacterArmorTrainingOverridesData';
      case _iykib7lv.CharacterAttackData():
        return 'CharacterAttackData';
      case _ibkyvw07.CharacterChangeData():
        return 'CharacterChangeData';
      case _iwf32wta.CharacterChoiceData():
        return 'CharacterChoiceData';
      case _iqjjxby6.CharacterClassEntryData():
        return 'CharacterClassEntryData';
      case _im2o0tmj.CharacterData():
        return 'CharacterData';
      case _ir4negfy.CharacterDerivedData():
        return 'CharacterDerivedData';
      case _i7jkadr4.CharacterEquipmentSelectionData():
        return 'CharacterEquipmentSelectionData';
      case _iggvk3az.CharacterFeatureOverrideData():
        return 'CharacterFeatureOverrideData';
      case _imlxp0ix.CharacterFeatureViewData():
        return 'CharacterFeatureViewData';
      case _id5dgxdg.CharacterInventoryItemData():
        return 'CharacterInventoryItemData';
      case _ibvj7xz5.CharacterLanguageOverridesData():
        return 'CharacterLanguageOverridesData';
      case _iqjbme11.CharacterNoteData():
        return 'CharacterNoteData';
      case _ig0fia1r.CharacterRejectedChangeData():
        return 'CharacterRejectedChangeData';
      case _iu6zjs5s.CharacterResourceStateData():
        return 'CharacterResourceStateData';
      case _io9jihae.CharacterResourceViewData():
        return 'CharacterResourceViewData';
      case _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData():
        return 'CharacterSavingThrowProficiencyOverrideData';
      case _ivfw6q0y.CharacterSemanticActionData():
        return 'CharacterSemanticActionData';
      case _isl5krdt.CharacterSkillProficiencyState():
        return 'CharacterSkillProficiencyState';
      case _itkzfry3.CharacterSkillSelectionData():
        return 'CharacterSkillSelectionData';
      case _iesndgzw.CharacterSpellSelectionData():
        return 'CharacterSpellSelectionData';
      case _ieudcx2k.CharacterStartingEquipmentResolutionData():
        return 'CharacterStartingEquipmentResolutionData';
      case _ixmjb4z5.CharacterStartingEquipmentSelectionData():
        return 'CharacterStartingEquipmentSelectionData';
      case _is9ng6da.CharacterSyncOperationData():
        return 'CharacterSyncOperationData';
      case _icxp0ddy.CharacterSyncRequest():
        return 'CharacterSyncRequest';
      case _i29bgu3e.CharacterSyncResponse():
        return 'CharacterSyncResponse';
      case _ix5qhw9w.CharacterSyncResult():
        return 'CharacterSyncResult';
      case _ixfhi6l8.CharacterSyncStatus():
        return 'CharacterSyncStatus';
      case _iz49jt9b.CharacterSyncValueData():
        return 'CharacterSyncValueData';
      case _idvpwngn.CharacterToolProficiencyOverridesData():
        return 'CharacterToolProficiencyOverridesData';
      case _i5e0copu.CharacterWeaponProficiencyOverridesData():
        return 'CharacterWeaponProficiencyOverridesData';
      case _i2mamrrk.ChoiceReplacementHistoryData():
        return 'ChoiceReplacementHistoryData';
      case _iij0mpeo.LevelUpChoiceReplacementData():
        return 'LevelUpChoiceReplacementData';
      case _ipxtly6g.LevelUpRequest():
        return 'LevelUpRequest';
      case _i4b5l3un.LevelUpSpellChoice():
        return 'LevelUpSpellChoice';
      case _i0tavl9b.RelatedFeatureViewData():
        return 'RelatedFeatureViewData';
      case _it45kp8q.SpellSelectionReplacementHistoryData():
        return 'SpellSelectionReplacementHistoryData';
      case _i9cfge83.SpellSlotRecoveryTriggerData():
        return 'SpellSlotRecoveryTriggerData';
      case _i3zkka4q.ChoiceGroupData():
        return 'ChoiceGroupData';
      case _iprx2upt.ChoiceOptionData():
        return 'ChoiceOptionData';
      case _iax2s634.ChoiceRequirementData():
        return 'ChoiceRequirementData';
      case _i4e8ker2.ClassData():
        return 'ClassData';
      case _ijvqpc4v.ClassFeatureData():
        return 'ClassFeatureData';
      case _isxi9i4e.ClassLevelData():
        return 'ClassLevelData';
      case _ihr52fes.PreparedSpellRuleData():
        return 'PreparedSpellRuleData';
      case _ig6b5pj2.SpellSlotProgressionData():
        return 'SpellSlotProgressionData';
      case _igasg47n.StartingEquipmentBlockData():
        return 'StartingEquipmentBlockData';
      case _impna1yi.StartingEquipmentEntryData():
        return 'StartingEquipmentEntryData';
      case _iozcdomq.StartingEquipmentLineData():
        return 'StartingEquipmentLineData';
      case _iyz352zl.StartingEquipmentOptionData():
        return 'StartingEquipmentOptionData';
      case _ijic8hve.SubclassData():
        return 'SubclassData';
      case _iel0dp9q.SubclassFeatureData():
        return 'SubclassFeatureData';
      case _i0aiwhe6.FeatureDisplayPropertyData():
        return 'FeatureDisplayPropertyData';
      case _iwfr4tm0.FeatureModifierConditionData():
        return 'FeatureModifierConditionData';
      case _ilhpjxpt.FeatureModifierData():
        return 'FeatureModifierData';
      case _ircf4zmd.FeatureModifierValueData():
        return 'FeatureModifierValueData';
      case _isecmqna.FeatureRelationData():
        return 'FeatureRelationData';
      case _iflv344v.FeatureResourceDefinitionData():
        return 'FeatureResourceDefinitionData';
      case _i86imp4g.FeatureResourceEffectData():
        return 'FeatureResourceEffectData';
      case _iafoerth.FeatureResourceProgressionValueData():
        return 'FeatureResourceProgressionValueData';
      case _irh2914h.RaceData():
        return 'RaceData';
      case _imnymvhh.RaceFeatureData():
        return 'RaceFeatureData';
      case _ilhjydvh.RaceFeatureSpellGrantData():
        return 'RaceFeatureSpellGrantData';
      case _iqoglfsm.SubraceData():
        return 'SubraceData';
      case _idolx2sf.SpellActivationData():
        return 'SpellActivationData';
      case _i9erq8kp.SpellResourceUpcastPolicyData():
        return 'SpellResourceUpcastPolicyData';
      case _in2nv22i.SpellSelectionFilterData():
        return 'SpellSelectionFilterData';
      case _ipwf59gx.SpellSlotRecoveryPolicyData():
        return 'SpellSlotRecoveryPolicyData';
      case _ivjna1ls.ToolData():
        return 'ToolData';
      case _iv545qv3.ArmorData():
        return 'ArmorData';
      case _ibuwh0hc.ItemData():
        return 'ItemData';
      case _i41tgptx.MagicItemData():
        return 'MagicItemData';
      case _inpmmgks.WeaponData():
        return 'WeaponData';
      case _itvh88br.SpellData():
        return 'SpellData';
      case _iq5q0wh8.SpellScalingData():
        return 'SpellScalingData';
      case _ivey3rvd.DmCreatureException():
        return 'DmCreatureException';
      case _i11aekbu.DmCreatureImportResult():
        return 'DmCreatureImportResult';
      case _ipuprlj7.DmCreatureRecord():
        return 'DmCreatureRecord';
      case _idf6hpk3.DmCreatureSummary():
        return 'DmCreatureSummary';
      case _i5rga0su.Ability():
        return 'Ability';
      case _ix11b24x.ArmorCategory():
        return 'ArmorCategory';
      case _ik1o33an.CharacterAlignment():
        return 'CharacterAlignment';
      case _idqm1edw.CharacterChangeType():
        return 'CharacterChangeType';
      case _icxxpsvd.CharacterEntityType():
        return 'CharacterEntityType';
      case _i1fix3of.CharacterFeatureSourceType():
        return 'CharacterFeatureSourceType';
      case _ik9iz51c.CharacterInventoryItemType():
        return 'CharacterInventoryItemType';
      case _ixbcln74.CharacterSavingThrowProficiencyOverride():
        return 'CharacterSavingThrowProficiencyOverride';
      case _ixj33h5c.CharacterSkillProficiencyLevel():
        return 'CharacterSkillProficiencyLevel';
      case _i3ppfbzb.CharacterSkillSelectionKind():
        return 'CharacterSkillSelectionKind';
      case _ikyxycuo.CharacterSpeedKind():
        return 'CharacterSpeedKind';
      case _ie0q5aqi.CharacterSpellSelectionKind():
        return 'CharacterSpellSelectionKind';
      case _i6jbrxie.CharacterSyncOperationType():
        return 'CharacterSyncOperationType';
      case _ia4qs68v.CharacterSyncTargetType():
        return 'CharacterSyncTargetType';
      case _ia6aulam.ChoiceRequirementType():
        return 'ChoiceRequirementType';
      case _iam6xy91.ChoiceSourceType():
        return 'ChoiceSourceType';
      case _iotu8r29.ChoiceType():
        return 'ChoiceType';
      case _ijyz5fbs.ClassSpellSelectionMode():
        return 'ClassSpellSelectionMode';
      case _ikb1pesi.ConditionType():
        return 'ConditionType';
      case _i6cngs6w.CreatureSize():
        return 'CreatureSize';
      case _i6q2t5mj.DamageType():
        return 'DamageType';
      case _ia851nk8.EquipmentCatalogType():
        return 'EquipmentCatalogType';
      case _i9idws3v.FeatureDisplayPropertyValueKind():
        return 'FeatureDisplayPropertyValueKind';
      case _ilgpxa54.FeatureModifierConditionType():
        return 'FeatureModifierConditionType';
      case _i56op7oq.FeatureModifierOperation():
        return 'FeatureModifierOperation';
      case _i6asfa9j.FeatureModifierRounding():
        return 'FeatureModifierRounding';
      case _izn79nb9.FeatureModifierTarget():
        return 'FeatureModifierTarget';
      case _il8rk55k.FeatureModifierValueKind():
        return 'FeatureModifierValueKind';
      case _ih812opj.FeatureRelationType():
        return 'FeatureRelationType';
      case _ijb3cn5v.FeatureResourceEffectType():
        return 'FeatureResourceEffectType';
      case _ia1vmwiq.FeatureResourceKind():
        return 'FeatureResourceKind';
      case _ib4g5i7q.FeatureResourceMaxRule():
        return 'FeatureResourceMaxRule';
      case _if07r66f.FeatureResourceProgressionKey():
        return 'FeatureResourceProgressionKey';
      case _iyk5jgys.FeatureResourceTargetType():
        return 'FeatureResourceTargetType';
      case _ir3q1cdf.FeatureResourceTrigger():
        return 'FeatureResourceTrigger';
      case _i2l7bpu3.FeatureTag():
        return 'FeatureTag';
      case _izodp5lk.HitPointMode():
        return 'HitPointMode';
      case _iftbsk4q.Language():
        return 'Language';
      case _ieum0m7f.PreparedSpellRounding():
        return 'PreparedSpellRounding';
      case _ibgbgp52.RestType():
        return 'RestType';
      case _iy62ln0z.SenseType():
        return 'SenseType';
      case _iabgjh08.Skill():
        return 'Skill';
      case _ieavm63l.AreaOfEffectType():
        return 'AreaOfEffectType';
      case _iatx40hq.AreaSizeMeasurement():
        return 'AreaSizeMeasurement';
      case _inf83u33.SpellAttackType():
        return 'SpellAttackType';
      case _i9u2urpu.SpellDurationType():
        return 'SpellDurationType';
      case _iw7hp9dc.SpellScalingMode():
        return 'SpellScalingMode';
      case _ioahu9w9.SpellSchool():
        return 'SpellSchool';
      case _iupu1e0e.SpellTargetType():
        return 'SpellTargetType';
      case _ik43ztmo.SpellSlotRecoveryMode():
        return 'SpellSlotRecoveryMode';
      case _ilfh4rku.SpellcastingProgression():
        return 'SpellcastingProgression';
      case _iag2d6aj.StartingEquipmentBlockKind():
        return 'StartingEquipmentBlockKind';
      case _ipm8xyg1.StartingEquipmentEntryKind():
        return 'StartingEquipmentEntryKind';
      case _iniqanjc.StartingEquipmentLineKind():
        return 'StartingEquipmentLineKind';
      case _ic2cpv54.ToolCategory():
        return 'ToolCategory';
      case _i4vk4r4o.UnarmoredDefenseRule():
        return 'UnarmoredDefenseRule';
      case _iiyileog.WeaponCategory():
        return 'WeaponCategory';
      case _iur813s4.WeaponProperty():
        return 'WeaponProperty';
      case _i1l5m7qw.LevelDownChoiceRepair():
        return 'LevelDownChoiceRepair';
      case _irktv0ea.LevelDownRequest():
        return 'LevelDownRequest';
      case _iqeghuxo.BackgroundStepView():
        return 'BackgroundStepView';
      case _isbrs5qf.CharacterEquipmentEntryView():
        return 'CharacterEquipmentEntryView';
      case _i6xbclit.ChoiceGroupView():
        return 'ChoiceGroupView';
      case _iil6pw38.ChoiceOptionEligibilityView():
        return 'ChoiceOptionEligibilityView';
      case _iob9tmlr.ChoiceRequirementFailureView():
        return 'ChoiceRequirementFailureView';
      case _ik4ex2us.ClassSpellDeltaView():
        return 'ClassSpellDeltaView';
      case _ixvig4n8.ClassSpellSelectionGroupView():
        return 'ClassSpellSelectionGroupView';
      case _ih120cff.ClassStepFeatureView():
        return 'ClassStepFeatureView';
      case _i3cyal5j.ClassStepSubclassChoiceView():
        return 'ClassStepSubclassChoiceView';
      case _ib3duw15.ClassStepView():
        return 'ClassStepView';
      case _i9kpkyz2.FeatureDisplayPropertyView():
        return 'FeatureDisplayPropertyView';
      case _iu8i64vu.LevelDownInvalidChoiceView():
        return 'LevelDownInvalidChoiceView';
      case _ipbxh79i.LevelDownPreview():
        return 'LevelDownPreview';
      case _ipqjgw5e.LevelUpPreview():
        return 'LevelUpPreview';
      case _ifavv51o.ProficiencyBundleView():
        return 'ProficiencyBundleView';
      case _id360bq3.RaceStepView():
        return 'RaceStepView';
      case _i8p2oglu.ResolvedCharacterSpellData():
        return 'ResolvedCharacterSpellData';
      case _im19jsv2.SelectedFeatureChoiceView():
        return 'SelectedFeatureChoiceView';
      case _ihn36a1g.SkillSelectionGroupView():
        return 'SkillSelectionGroupView';
      case _iam7pkuu.SpellSourceContextData():
        return 'SpellSourceContextData';
      case _izjjz5hc.StartingEquipmentBlockView():
        return 'StartingEquipmentBlockView';
      case _i3vgjwh2.StartingEquipmentOptionView():
        return 'StartingEquipmentOptionView';
    }
    className = _i312scxx.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_iydli74w.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i3katqli.BackgroundData>(data['data']);
    }
    if (dataClassName == 'ClassSpellGrantData') {
      return deserialize<_i68we1de.ClassSpellGrantData>(data['data']);
    }
    if (dataClassName == 'DamagePartData') {
      return deserialize<_iqilpl6d.DamagePartData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i1l5wul2.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterArmorTrainingOverridesData') {
      return deserialize<_ijpj2a9u.CharacterArmorTrainingOverridesData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterAttackData') {
      return deserialize<_iykib7lv.CharacterAttackData>(data['data']);
    }
    if (dataClassName == 'CharacterChangeData') {
      return deserialize<_ibkyvw07.CharacterChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_iwf32wta.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_iqjjxby6.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_im2o0tmj.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterDerivedData') {
      return deserialize<_ir4negfy.CharacterDerivedData>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentSelectionData') {
      return deserialize<_i7jkadr4.CharacterEquipmentSelectionData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterFeatureOverrideData') {
      return deserialize<_iggvk3az.CharacterFeatureOverrideData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureViewData') {
      return deserialize<_imlxp0ix.CharacterFeatureViewData>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemData') {
      return deserialize<_id5dgxdg.CharacterInventoryItemData>(data['data']);
    }
    if (dataClassName == 'CharacterLanguageOverridesData') {
      return deserialize<_ibvj7xz5.CharacterLanguageOverridesData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterNoteData') {
      return deserialize<_iqjbme11.CharacterNoteData>(data['data']);
    }
    if (dataClassName == 'CharacterRejectedChangeData') {
      return deserialize<_ig0fia1r.CharacterRejectedChangeData>(data['data']);
    }
    if (dataClassName == 'CharacterResourceStateData') {
      return deserialize<_iu6zjs5s.CharacterResourceStateData>(data['data']);
    }
    if (dataClassName == 'CharacterResourceViewData') {
      return deserialize<_io9jihae.CharacterResourceViewData>(data['data']);
    }
    if (dataClassName == 'CharacterSavingThrowProficiencyOverrideData') {
      return deserialize<_i3yrtkjn.CharacterSavingThrowProficiencyOverrideData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterSemanticActionData') {
      return deserialize<_ivfw6q0y.CharacterSemanticActionData>(data['data']);
    }
    if (dataClassName == 'CharacterSkillProficiencyState') {
      return deserialize<_isl5krdt.CharacterSkillProficiencyState>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterSkillSelectionData') {
      return deserialize<_itkzfry3.CharacterSkillSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionData') {
      return deserialize<_iesndgzw.CharacterSpellSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionData') {
      return deserialize<_ieudcx2k.CharacterStartingEquipmentResolutionData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionData') {
      return deserialize<_ixmjb4z5.CharacterStartingEquipmentSelectionData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterSyncOperationData') {
      return deserialize<_is9ng6da.CharacterSyncOperationData>(data['data']);
    }
    if (dataClassName == 'CharacterSyncRequest') {
      return deserialize<_icxp0ddy.CharacterSyncRequest>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResponse') {
      return deserialize<_i29bgu3e.CharacterSyncResponse>(data['data']);
    }
    if (dataClassName == 'CharacterSyncResult') {
      return deserialize<_ix5qhw9w.CharacterSyncResult>(data['data']);
    }
    if (dataClassName == 'CharacterSyncStatus') {
      return deserialize<_ixfhi6l8.CharacterSyncStatus>(data['data']);
    }
    if (dataClassName == 'CharacterSyncValueData') {
      return deserialize<_iz49jt9b.CharacterSyncValueData>(data['data']);
    }
    if (dataClassName == 'CharacterToolProficiencyOverridesData') {
      return deserialize<_idvpwngn.CharacterToolProficiencyOverridesData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterWeaponProficiencyOverridesData') {
      return deserialize<_i5e0copu.CharacterWeaponProficiencyOverridesData>(
        data['data'],
      );
    }
    if (dataClassName == 'ChoiceReplacementHistoryData') {
      return deserialize<_i2mamrrk.ChoiceReplacementHistoryData>(data['data']);
    }
    if (dataClassName == 'LevelUpChoiceReplacementData') {
      return deserialize<_iij0mpeo.LevelUpChoiceReplacementData>(data['data']);
    }
    if (dataClassName == 'LevelUpRequest') {
      return deserialize<_ipxtly6g.LevelUpRequest>(data['data']);
    }
    if (dataClassName == 'LevelUpSpellChoice') {
      return deserialize<_i4b5l3un.LevelUpSpellChoice>(data['data']);
    }
    if (dataClassName == 'RelatedFeatureViewData') {
      return deserialize<_i0tavl9b.RelatedFeatureViewData>(data['data']);
    }
    if (dataClassName == 'SpellSelectionReplacementHistoryData') {
      return deserialize<_it45kp8q.SpellSelectionReplacementHistoryData>(
        data['data'],
      );
    }
    if (dataClassName == 'SpellSlotRecoveryTriggerData') {
      return deserialize<_i9cfge83.SpellSlotRecoveryTriggerData>(data['data']);
    }
    if (dataClassName == 'ChoiceGroupData') {
      return deserialize<_i3zkka4q.ChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ChoiceOptionData') {
      return deserialize<_iprx2upt.ChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementData') {
      return deserialize<_iax2s634.ChoiceRequirementData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i4e8ker2.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_ijvqpc4v.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_isxi9i4e.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'PreparedSpellRuleData') {
      return deserialize<_ihr52fes.PreparedSpellRuleData>(data['data']);
    }
    if (dataClassName == 'SpellSlotProgressionData') {
      return deserialize<_ig6b5pj2.SpellSlotProgressionData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockData') {
      return deserialize<_igasg47n.StartingEquipmentBlockData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryData') {
      return deserialize<_impna1yi.StartingEquipmentEntryData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineData') {
      return deserialize<_iozcdomq.StartingEquipmentLineData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionData') {
      return deserialize<_iyz352zl.StartingEquipmentOptionData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_ijic8hve.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_iel0dp9q.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyData') {
      return deserialize<_i0aiwhe6.FeatureDisplayPropertyData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierConditionData') {
      return deserialize<_iwfr4tm0.FeatureModifierConditionData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierData') {
      return deserialize<_ilhpjxpt.FeatureModifierData>(data['data']);
    }
    if (dataClassName == 'FeatureModifierValueData') {
      return deserialize<_ircf4zmd.FeatureModifierValueData>(data['data']);
    }
    if (dataClassName == 'FeatureRelationData') {
      return deserialize<_isecmqna.FeatureRelationData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceDefinitionData') {
      return deserialize<_iflv344v.FeatureResourceDefinitionData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceEffectData') {
      return deserialize<_i86imp4g.FeatureResourceEffectData>(data['data']);
    }
    if (dataClassName == 'FeatureResourceProgressionValueData') {
      return deserialize<_iafoerth.FeatureResourceProgressionValueData>(
        data['data'],
      );
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_irh2914h.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_imnymvhh.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_ilhjydvh.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_iqoglfsm.SubraceData>(data['data']);
    }
    if (dataClassName == 'SpellActivationData') {
      return deserialize<_idolx2sf.SpellActivationData>(data['data']);
    }
    if (dataClassName == 'SpellResourceUpcastPolicyData') {
      return deserialize<_i9erq8kp.SpellResourceUpcastPolicyData>(data['data']);
    }
    if (dataClassName == 'SpellSelectionFilterData') {
      return deserialize<_in2nv22i.SpellSelectionFilterData>(data['data']);
    }
    if (dataClassName == 'SpellSlotRecoveryPolicyData') {
      return deserialize<_ipwf59gx.SpellSlotRecoveryPolicyData>(data['data']);
    }
    if (dataClassName == 'ToolData') {
      return deserialize<_ivjna1ls.ToolData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_iv545qv3.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_ibuwh0hc.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i41tgptx.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_inpmmgks.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_itvh88br.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_iq5q0wh8.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'DmCreatureException') {
      return deserialize<_ivey3rvd.DmCreatureException>(data['data']);
    }
    if (dataClassName == 'DmCreatureImportResult') {
      return deserialize<_i11aekbu.DmCreatureImportResult>(data['data']);
    }
    if (dataClassName == 'DmCreatureRecord') {
      return deserialize<_ipuprlj7.DmCreatureRecord>(data['data']);
    }
    if (dataClassName == 'DmCreatureSummary') {
      return deserialize<_idf6hpk3.DmCreatureSummary>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i5rga0su.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_ix11b24x.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_ik1o33an.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'CharacterChangeType') {
      return deserialize<_idqm1edw.CharacterChangeType>(data['data']);
    }
    if (dataClassName == 'CharacterEntityType') {
      return deserialize<_icxxpsvd.CharacterEntityType>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureSourceType') {
      return deserialize<_i1fix3of.CharacterFeatureSourceType>(data['data']);
    }
    if (dataClassName == 'CharacterInventoryItemType') {
      return deserialize<_ik9iz51c.CharacterInventoryItemType>(data['data']);
    }
    if (dataClassName == 'CharacterSavingThrowProficiencyOverride') {
      return deserialize<_ixbcln74.CharacterSavingThrowProficiencyOverride>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterSkillProficiencyLevel') {
      return deserialize<_ixj33h5c.CharacterSkillProficiencyLevel>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterSkillSelectionKind') {
      return deserialize<_i3ppfbzb.CharacterSkillSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpeedKind') {
      return deserialize<_ikyxycuo.CharacterSpeedKind>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionKind') {
      return deserialize<_ie0q5aqi.CharacterSpellSelectionKind>(data['data']);
    }
    if (dataClassName == 'CharacterSyncOperationType') {
      return deserialize<_i6jbrxie.CharacterSyncOperationType>(data['data']);
    }
    if (dataClassName == 'CharacterSyncTargetType') {
      return deserialize<_ia4qs68v.CharacterSyncTargetType>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementType') {
      return deserialize<_ia6aulam.ChoiceRequirementType>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_iam6xy91.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ChoiceType') {
      return deserialize<_iotu8r29.ChoiceType>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionMode') {
      return deserialize<_ijyz5fbs.ClassSpellSelectionMode>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_ikb1pesi.ConditionType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i6cngs6w.CreatureSize>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i6q2t5mj.DamageType>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalogType') {
      return deserialize<_ia851nk8.EquipmentCatalogType>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyValueKind') {
      return deserialize<_i9idws3v.FeatureDisplayPropertyValueKind>(
        data['data'],
      );
    }
    if (dataClassName == 'FeatureModifierConditionType') {
      return deserialize<_ilgpxa54.FeatureModifierConditionType>(data['data']);
    }
    if (dataClassName == 'FeatureModifierOperation') {
      return deserialize<_i56op7oq.FeatureModifierOperation>(data['data']);
    }
    if (dataClassName == 'FeatureModifierRounding') {
      return deserialize<_i6asfa9j.FeatureModifierRounding>(data['data']);
    }
    if (dataClassName == 'FeatureModifierTarget') {
      return deserialize<_izn79nb9.FeatureModifierTarget>(data['data']);
    }
    if (dataClassName == 'FeatureModifierValueKind') {
      return deserialize<_il8rk55k.FeatureModifierValueKind>(data['data']);
    }
    if (dataClassName == 'FeatureRelationType') {
      return deserialize<_ih812opj.FeatureRelationType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceEffectType') {
      return deserialize<_ijb3cn5v.FeatureResourceEffectType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceKind') {
      return deserialize<_ia1vmwiq.FeatureResourceKind>(data['data']);
    }
    if (dataClassName == 'FeatureResourceMaxRule') {
      return deserialize<_ib4g5i7q.FeatureResourceMaxRule>(data['data']);
    }
    if (dataClassName == 'FeatureResourceProgressionKey') {
      return deserialize<_if07r66f.FeatureResourceProgressionKey>(data['data']);
    }
    if (dataClassName == 'FeatureResourceTargetType') {
      return deserialize<_iyk5jgys.FeatureResourceTargetType>(data['data']);
    }
    if (dataClassName == 'FeatureResourceTrigger') {
      return deserialize<_ir3q1cdf.FeatureResourceTrigger>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i2l7bpu3.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_izodp5lk.HitPointMode>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_iftbsk4q.Language>(data['data']);
    }
    if (dataClassName == 'PreparedSpellRounding') {
      return deserialize<_ieum0m7f.PreparedSpellRounding>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_ibgbgp52.RestType>(data['data']);
    }
    if (dataClassName == 'SenseType') {
      return deserialize<_iy62ln0z.SenseType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_iabgjh08.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_ieavm63l.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'AreaSizeMeasurement') {
      return deserialize<_iatx40hq.AreaSizeMeasurement>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_inf83u33.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i9u2urpu.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_iw7hp9dc.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_ioahu9w9.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_iupu1e0e.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellSlotRecoveryMode') {
      return deserialize<_ik43ztmo.SpellSlotRecoveryMode>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_ilfh4rku.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockKind') {
      return deserialize<_iag2d6aj.StartingEquipmentBlockKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentEntryKind') {
      return deserialize<_ipm8xyg1.StartingEquipmentEntryKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineKind') {
      return deserialize<_iniqanjc.StartingEquipmentLineKind>(data['data']);
    }
    if (dataClassName == 'ToolCategory') {
      return deserialize<_ic2cpv54.ToolCategory>(data['data']);
    }
    if (dataClassName == 'UnarmoredDefenseRule') {
      return deserialize<_i4vk4r4o.UnarmoredDefenseRule>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_iiyileog.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'WeaponProperty') {
      return deserialize<_iur813s4.WeaponProperty>(data['data']);
    }
    if (dataClassName == 'LevelDownChoiceRepair') {
      return deserialize<_i1l5m7qw.LevelDownChoiceRepair>(data['data']);
    }
    if (dataClassName == 'LevelDownRequest') {
      return deserialize<_irktv0ea.LevelDownRequest>(data['data']);
    }
    if (dataClassName == 'BackgroundStepView') {
      return deserialize<_iqeghuxo.BackgroundStepView>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentEntryView') {
      return deserialize<_isbrs5qf.CharacterEquipmentEntryView>(data['data']);
    }
    if (dataClassName == 'ChoiceGroupView') {
      return deserialize<_i6xbclit.ChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ChoiceOptionEligibilityView') {
      return deserialize<_iil6pw38.ChoiceOptionEligibilityView>(data['data']);
    }
    if (dataClassName == 'ChoiceRequirementFailureView') {
      return deserialize<_iob9tmlr.ChoiceRequirementFailureView>(data['data']);
    }
    if (dataClassName == 'ClassSpellDeltaView') {
      return deserialize<_ik4ex2us.ClassSpellDeltaView>(data['data']);
    }
    if (dataClassName == 'ClassSpellSelectionGroupView') {
      return deserialize<_ixvig4n8.ClassSpellSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepFeatureView') {
      return deserialize<_ih120cff.ClassStepFeatureView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i3cyal5j.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_ib3duw15.ClassStepView>(data['data']);
    }
    if (dataClassName == 'FeatureDisplayPropertyView') {
      return deserialize<_i9kpkyz2.FeatureDisplayPropertyView>(data['data']);
    }
    if (dataClassName == 'LevelDownInvalidChoiceView') {
      return deserialize<_iu8i64vu.LevelDownInvalidChoiceView>(data['data']);
    }
    if (dataClassName == 'LevelDownPreview') {
      return deserialize<_ipbxh79i.LevelDownPreview>(data['data']);
    }
    if (dataClassName == 'LevelUpPreview') {
      return deserialize<_ipqjgw5e.LevelUpPreview>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_ifavv51o.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceStepView') {
      return deserialize<_id360bq3.RaceStepView>(data['data']);
    }
    if (dataClassName == 'ResolvedCharacterSpellData') {
      return deserialize<_i8p2oglu.ResolvedCharacterSpellData>(data['data']);
    }
    if (dataClassName == 'SelectedFeatureChoiceView') {
      return deserialize<_im19jsv2.SelectedFeatureChoiceView>(data['data']);
    }
    if (dataClassName == 'SkillSelectionGroupView') {
      return deserialize<_ihn36a1g.SkillSelectionGroupView>(data['data']);
    }
    if (dataClassName == 'SpellSourceContextData') {
      return deserialize<_iam7pkuu.SpellSourceContextData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockView') {
      return deserialize<_izjjz5hc.StartingEquipmentBlockView>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionView') {
      return deserialize<_i3vgjwh2.StartingEquipmentOptionView>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i312scxx.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i312scxx.Protocol().registerHostProtocol('characters_mirror', this);
  }

  @override
  String getModuleName() => 'characters_mirror';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i312scxx.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
