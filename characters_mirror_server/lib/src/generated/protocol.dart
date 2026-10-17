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
import 'package:characters_mirror_server/src/generated/data/background_data.dart'
    as _ini8luu6;
import 'package:characters_mirror_server/src/generated/data/class_spell_grant_data.dart'
    as _iwivgnzd;
import 'package:characters_mirror_server/src/generated/data/feat_data.dart'
    as _i77nrd14;
import 'package:characters_mirror_server/src/generated/data/general/character/character_data.dart'
    as _i7kkgt8y;
import 'package:characters_mirror_server/src/generated/data/general/choice_group_data.dart'
    as _ioxj5inc;
import 'package:characters_mirror_server/src/generated/data/general/choice_option_data.dart'
    as _iosenkkh;
import 'package:characters_mirror_server/src/generated/data/general/class/class_data.dart'
    as _iemrti6x;
import 'package:characters_mirror_server/src/generated/data/general/class/class_feature_data.dart'
    as _i77hkaes;
import 'package:characters_mirror_server/src/generated/data/general/class/class_level_data.dart'
    as _ivbho7q1;
import 'package:characters_mirror_server/src/generated/data/general/class/spell_slot_progression_data.dart'
    as _ig2i76sa;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_data.dart'
    as _ing7r6e2;
import 'package:characters_mirror_server/src/generated/data/general/class/subclass_feature_data.dart'
    as _ix0ni9v9;
import 'package:characters_mirror_server/src/generated/data/general/feature_relation_data.dart'
    as _iwsgy0dv;
import 'package:characters_mirror_server/src/generated/data/general/race/race_data.dart'
    as _iueyhinu;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_data.dart'
    as _ikrrnfpk;
import 'package:characters_mirror_server/src/generated/data/general/race/race_feature_spell_grant_data.dart'
    as _iwbrjjtm;
import 'package:characters_mirror_server/src/generated/data/general/race/subrace_data.dart'
    as _iasgt0sa;
import 'package:characters_mirror_server/src/generated/data/general/tool_data.dart'
    as _imen179o;
import 'package:characters_mirror_server/src/generated/data/items/armor_data.dart'
    as _if6xo2mf;
import 'package:characters_mirror_server/src/generated/data/items/item_data.dart'
    as _ilfoaqak;
import 'package:characters_mirror_server/src/generated/data/items/magic_item_data.dart'
    as _ihxnsrg8;
import 'package:characters_mirror_server/src/generated/data/items/weapon_data.dart'
    as _ixvqnkv0;
import 'package:characters_mirror_server/src/generated/data/spell_data.dart'
    as _iphj40lo;
import 'package:characters_mirror_server/src/generated/dungeon_master/dm_creature_summary.dart'
    as _ijv7obuo;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i1n3uhu0;
import 'auth/auth_action_result.dart' as _iydli74w;
import 'data/background_data.dart' as _i3katqli;
import 'data/class_spell_grant_data.dart' as _i68we1de;
import 'data/damage_part_data.dart' as _iqilpl6d;
import 'data/feat_data.dart' as _i1l5wul2;
import 'data/general/character/character_applied_change_record.dart'
    as _iaskjtek;
import 'data/general/character/character_armor_training_overrides_data.dart'
    as _ijpj2a9u;
import 'data/general/character/character_attack_data.dart' as _iykib7lv;
import 'data/general/character/character_change_data.dart' as _ibkyvw07;
import 'data/general/character/character_choice_data.dart' as _iwf32wta;
import 'data/general/character/character_choice_record.dart' as _i1l3jk2d;
import 'data/general/character/character_class_entry_data.dart' as _iqjjxby6;
import 'data/general/character/character_class_entry_record.dart' as _i1goyn5n;
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
import 'data/general/character/character_record.dart' as _is140f48;
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
import 'data/general/character/character_skill_selection_record.dart'
    as _ic0tmv5d;
import 'data/general/character/character_spell_selection_data.dart'
    as _iesndgzw;
import 'data/general/character/character_spell_selection_record.dart'
    as _icqki103;
import 'data/general/character/character_starting_equipment_resolution_data.dart'
    as _ieudcx2k;
import 'data/general/character/character_starting_equipment_resolution_record.dart'
    as _ipbr5hem;
import 'data/general/character/character_starting_equipment_selection_data.dart'
    as _ixmjb4z5;
import 'data/general/character/character_starting_equipment_selection_record.dart'
    as _ikk28htr;
import 'data/general/character/character_sync_event_record.dart' as _i2rqx8lk;
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

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'armor_data',
      dartName: 'ArmorData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'categoryValue',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ArmorCategory?',
        ),
        _isp.ColumnDefinition(
          name: 'baseAC',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'bonusAC',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'dexBonus',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'dexBonusMax',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'strengthRequirement',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'stealthDisadvantage',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'weight',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'cost',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'armor_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'background_data',
      dartName: 'BackgroundData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'availableSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'skillCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'toolProficiencyKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'languageCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'items',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'coins',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'feature',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'suggestedPersonality',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'suggestedIdeal',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'suggestedBond',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'suggestedFlaw',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_applied_changes',
      dartName: 'CharacterAppliedChangeRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'changeId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'revision',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'character_applied_changes_user_change_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'character_choice_data',
      dartName: 'CharacterChoiceRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'replacementHistory',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ChoiceReplacementHistoryData>?',
        ),
        _isp.ColumnDefinition(
          name: 'syncId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'classEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'groupKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'optionKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'character_choice_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_choice_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_class_relation',
      dartName: 'CharacterClassEntryRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'syncId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'classDataId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'subclassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'isStartingClass',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'classOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'hpMode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:HitPointMode?',
        ),
        _isp.ColumnDefinition(
          name: 'hpRolledValues',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_1',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_class_relation_fk_2',
          columns: ['subclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_skill_selection_data',
      dartName: 'CharacterSkillSelectionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'syncId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'classEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'classDataId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'backgroundDataId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'skill',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Skill?',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterSkillSelectionKind?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_2',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_skill_selection_data_fk_3',
          columns: ['backgroundDataId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_spell_selection_data',
      dartName: 'CharacterSpellSelectionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'syncId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'classEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'classDataId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'spellId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'spellKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterSpellSelectionKind?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionFilter',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellSelectionFilterData?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionRuleLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionUnrestricted',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'spellReplacementHistory',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:SpellSelectionReplacementHistoryData>?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_1',
          columns: ['classEntryId'],
          referenceTable: 'character_class_relation',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_2',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_spell_selection_data_fk_3',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_starting_equipment_resolution_data',
      dartName: 'CharacterStartingEquipmentResolutionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'syncId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'sourceLineEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'catalogType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:EquipmentCatalogType?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_resolution_data_fk_0',
          columns: ['selectionId'],
          referenceTable: 'character_starting_equipment_selection_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_resolution_data_fk_1',
          columns: ['sourceLineEntryId'],
          referenceTable: 'starting_equipment_entry_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_starting_equipment_selection_data',
      dartName: 'CharacterStartingEquipmentSelectionRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'syncId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'sourceType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ChoiceSourceType?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'choiceOptionEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'isSelected',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_selection_data_fk_0',
          columns: ['characterId'],
          referenceTable: 'characters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_selection_data_fk_1',
          columns: ['sourceEntryId'],
          referenceTable: 'starting_equipment_entry_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'character_starting_equipment_selection_data_fk_2',
          columns: ['choiceOptionEntryId'],
          referenceTable: 'starting_equipment_entry_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'character_sync_events',
      dartName: 'CharacterSyncEventRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'characterId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'characterVersion',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'eventType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'changeId',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'character_sync_events_user_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'character_sync_events_character_id_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'characters',
      dartName: 'CharacterRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'spellActivationUses',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'age',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'height',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'weight',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'eyes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'skin',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'hair',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'appearance',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'backstory',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'goals',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'alliesOrganizations',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'personalityTraits',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'ideals',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'bonds',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'flaws',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'portraitVersion',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'syncTargetRevisions',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'syncBarrierTokens',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'experience',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'alignmentValue',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterAlignment?',
        ),
        _isp.ColumnDefinition(
          name: 'raceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subraceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'backgroundId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'baseAbilityScores',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'customAbilityBonuses',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'useFlexibleAbilityBonuses',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'temporaryHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'currentHp',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'deathSaveSuccesses',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'deathSaveFailures',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'hpPerLevelBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'hpFlatBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'currentHitDice',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'hitDiceMaxOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'currentSpellSlots',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'currentPactSlots',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'activeConcentrationSpellName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'customInitiativeBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'customArmorClassBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'walkingSpeed',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'swimmingSpeed',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'climbingSpeed',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'flyingSpeed',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'displayedSpeedKind',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:CharacterSpeedKind?',
        ),
        _isp.ColumnDefinition(
          name: 'customSpellSaveDcBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'customSpellAttackBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'preparedSpellKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'activeConditions',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ConditionType>?',
        ),
        _isp.ColumnDefinition(
          name: 'exhaustionLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'inspiration',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'equipment',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterInventoryItemData>?',
        ),
        _isp.ColumnDefinition(
          name: 'equippedArmor',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterEquipmentSelectionData?',
        ),
        _isp.ColumnDefinition(
          name: 'equippedShield',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterEquipmentSelectionData?',
        ),
        _isp.ColumnDefinition(
          name: 'manualSkillProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterSkillProficiencyState>?',
        ),
        _isp.ColumnDefinition(
          name: 'manualSavingThrowProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _isp.ColumnDefinition(
          name: 'manualSkillProficiencyOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterSkillProficiencyState>?',
        ),
        _isp.ColumnDefinition(
          name: 'manualSavingThrowProficiencyOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType:
              'List<protocol:CharacterSavingThrowProficiencyOverrideData>?',
        ),
        _isp.ColumnDefinition(
          name: 'manualLanguageOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterLanguageOverridesData?',
        ),
        _isp.ColumnDefinition(
          name: 'manualToolProficiencyOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterToolProficiencyOverridesData?',
        ),
        _isp.ColumnDefinition(
          name: 'manualWeaponProficiencyOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterWeaponProficiencyOverridesData?',
        ),
        _isp.ColumnDefinition(
          name: 'manualArmorTrainingOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:CharacterArmorTrainingOverridesData?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterNoteData>?',
        ),
        _isp.ColumnDefinition(
          name: 'attacks',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterAttackData>?',
        ),
        _isp.ColumnDefinition(
          name: 'featureOverrides',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterFeatureOverrideData>?',
        ),
        _isp.ColumnDefinition(
          name: 'resourceStates',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:CharacterResourceStateData>?',
        ),
        _isp.ColumnDefinition(
          name: 'spellRecoveryTriggers',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,protocol:SpellSlotRecoveryTriggerData>?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'characters_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'characters_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'characters_fk_2',
          columns: ['backgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'choice_group_data',
      dartName: 'ChoiceGroupData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'progressionKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'replacementsAllowed',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'replacementProgressionKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceSubclassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceSubclassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceRaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceSubraceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceRaceFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceBackgroundId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ChoiceType?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'minimumSelectionCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'requirements',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ChoiceRequirementData>?',
        ),
        _isp.ColumnDefinition(
          name: 'autoSelectSingleEligible',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'appliesAtCharacterLevel',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'exclusiveKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'allowDuplicates',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_0',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_1',
          columns: ['sourceSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_2',
          columns: ['sourceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_3',
          columns: ['sourceSubclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_4',
          columns: ['sourceRaceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_5',
          columns: ['sourceSubraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_6',
          columns: ['sourceRaceFeatureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_group_data_fk_7',
          columns: ['sourceBackgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'choice_group_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'choice_option_data',
      dartName: 'ChoiceOptionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'choiceGroupId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'optionKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'shortDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'automaticSelection',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedAbilityBonuses',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedExpertiseSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedExpertiseToolKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'requiredExistingSkill',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Skill?',
        ),
        _isp.ColumnDefinition(
          name: 'requiredExistingToolKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'requirements',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ChoiceRequirementData>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedFeatureTags',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _isp.ColumnDefinition(
          name: 'damageType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _isp.ColumnDefinition(
          name: 'areaOfEffectType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AreaOfEffectType?',
        ),
        _isp.ColumnDefinition(
          name: 'areaText',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'damageByLevel',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'choice_option_data_fk_0',
          columns: ['choiceGroupId'],
          referenceTable: 'choice_group_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'choice_option_group_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'choiceGroupId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'class_data',
      dartName: 'ClassData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'spellSelectionFilter',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellSelectionFilterData?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'hitDieValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'primaryAbilities',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _isp.ColumnDefinition(
          name: 'savingThrowProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Ability>?',
        ),
        _isp.ColumnDefinition(
          name: 'armorTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'weaponTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'toolTrainingKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'availableSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'skillCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subclassChoiceLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subclassChoiceFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'spellcastingProgression',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellcastingProgression?',
        ),
        _isp.ColumnDefinition(
          name: 'spellSelectionMode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ClassSpellSelectionMode?',
        ),
        _isp.ColumnDefinition(
          name: 'spellcastingAbilityValue',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _isp.ColumnDefinition(
          name: 'multiclassPrerequisites',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'multiclassArmorTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'multiclassWeaponTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'multiclassToolTrainingKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'imageURL',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'class_data_fk_0',
          columns: ['subclassChoiceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'class_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'class_feature_data',
      dartName: 'ClassFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'parentClassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'shortDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'tags',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _isp.ColumnDefinition(
          name: 'choiceGroupKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedExpertiseSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedExpertiseToolKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'unarmoredDefenseRule',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:UnarmoredDefenseRule?',
        ),
        _isp.ColumnDefinition(
          name: 'relatedTable',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'class_feature_data_fk_0',
          columns: ['parentClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'class_feature_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'class_level_data',
      dartName: 'ClassLevelData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'classDataId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'subclassDataId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'knownCantrips',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'knownSpells',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'spellbookSpells',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'knownSpellReplacements',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'preparedSpellRule',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:PreparedSpellRuleData?',
        ),
        _isp.ColumnDefinition(
          name: 'preparedSpellFormula',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'resourceSummary',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'class_level_data_fk_0',
          columns: ['classDataId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'class_level_data_fk_1',
          columns: ['subclassDataId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'class_spell_grant_data',
      dartName: 'ClassSpellGrantData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'spellId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceSubclassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceSubclassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedAtLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'activation',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellActivationData?',
        ),
        _isp.ColumnDefinition(
          name: 'castingAbility',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _isp.ColumnDefinition(
          name: 'alwaysPrepared',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'choiceOptionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_0',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_1',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_2',
          columns: ['sourceSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_3',
          columns: ['sourceFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_4',
          columns: ['sourceSubclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'class_spell_grant_data_fk_5',
          columns: ['choiceOptionId'],
          referenceTable: 'choice_option_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dm_creatures',
      dartName: 'DmCreatureRecord',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sourceType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sourceVersion',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'challengeRating',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'rawJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'normalizedJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'importHash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'schemaVersion',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dm_creatures_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'dm_creatures_user_hash_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'importHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feat_data',
      dartName: 'FeatData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'abilityBonuses',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'traits',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'tags',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _isp.ColumnDefinition(
          name: 'specialAbilities',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'proficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'prerequisites',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feature_display_property_data',
      dartName: 'FeatureDisplayPropertyData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'sourceClassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceSubclassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'key',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'label',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'valueKind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureDisplayPropertyValueKind',
        ),
        _isp.ColumnDefinition(
          name: 'staticValue',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'progression',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'formula',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sortOrder',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_display_property_data_fk_0',
          columns: ['sourceClassFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_display_property_data_fk_1',
          columns: ['sourceSubclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'feature_display_property_class_feature_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceClassFeatureId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'feature_display_property_subclass_feature_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceSubclassFeatureId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'feature_modifier_data',
      dartName: 'FeatureModifierData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'classFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subclassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'target',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:FeatureModifierTarget',
        ),
        _isp.ColumnDefinition(
          name: 'operation',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'protocol:FeatureModifierOperation',
        ),
        _isp.ColumnDefinition(
          name: 'value',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'protocol:FeatureModifierValueData',
        ),
        _isp.ColumnDefinition(
          name: 'conditions',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureModifierConditionData>?',
        ),
        _isp.ColumnDefinition(
          name: 'spellKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'minimumCastLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_modifier_data_fk_0',
          columns: ['classFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_modifier_data_fk_1',
          columns: ['subclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'feature_modifier_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'feature_modifier_class_feature_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'classFeatureId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'feature_modifier_subclass_feature_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'subclassFeatureId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feature_relation_data',
      dartName: 'FeatureRelationData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'sourceType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CharacterFeatureSourceType',
        ),
        _isp.ColumnDefinition(
          name: 'sourceReferenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CharacterFeatureSourceType',
        ),
        _isp.ColumnDefinition(
          name: 'targetReferenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'relationType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureRelationType',
        ),
        _isp.ColumnDefinition(
          name: 'propertyMappings',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,String>?',
        ),
        _isp.ColumnDefinition(
          name: 'priority',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'mergeDisplay',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'feature_relation_source_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceReferenceKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'feature_relation_target_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetReferenceKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'feature_relation_pair_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceReferenceKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetType',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'targetReferenceKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'relationType',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feature_resource_definition_data',
      dartName: 'FeatureResourceDefinitionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'classFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subclassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'raceFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'key',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'choiceOptionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureResourceKind',
        ),
        _isp.ColumnDefinition(
          name: 'maxRule',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureResourceMaxRule',
        ),
        _isp.ColumnDefinition(
          name: 'maxValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'maxAbility',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _isp.ColumnDefinition(
          name: 'resetOn',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _isp.ColumnDefinition(
          name: 'activationTrigger',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceTrigger?',
        ),
        _isp.ColumnDefinition(
          name: 'usageResetOn',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _isp.ColumnDefinition(
          name: 'progressionKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceProgressionKey?',
        ),
        _isp.ColumnDefinition(
          name: 'becomesUnlimitedAtLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_0',
          columns: ['classFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_1',
          columns: ['subclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_2',
          columns: ['raceFeatureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_definition_data_fk_3',
          columns: ['choiceOptionId'],
          referenceTable: 'choice_option_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feature_resource_effect_data',
      dartName: 'FeatureResourceEffectData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'classFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subclassFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'raceFeatureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:FeatureResourceEffectType',
        ),
        _isp.ColumnDefinition(
          name: 'choiceOptionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceTargetType?',
        ),
        _isp.ColumnDefinition(
          name: 'targetResourceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'targetSourceType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:CharacterFeatureSourceType?',
        ),
        _isp.ColumnDefinition(
          name: 'targetSourceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'amountRule',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceMaxRule?',
        ),
        _isp.ColumnDefinition(
          name: 'amountValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'amountAbility',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _isp.ColumnDefinition(
          name: 'activationTrigger',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceTrigger?',
        ),
        _isp.ColumnDefinition(
          name: 'usageResetOn',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _isp.ColumnDefinition(
          name: 'recoveryPolicy',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellSlotRecoveryPolicyData?',
        ),
        _isp.ColumnDefinition(
          name: 'setResetOn',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _isp.ColumnDefinition(
          name: 'setMaxRule',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:FeatureResourceMaxRule?',
        ),
        _isp.ColumnDefinition(
          name: 'setMaxValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'setMaxAbility',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _isp.ColumnDefinition(
          name: 'addMaxValue',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'setUnlimited',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'becomesUnlimitedAtLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_0',
          columns: ['classFeatureId'],
          referenceTable: 'class_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_1',
          columns: ['subclassFeatureId'],
          referenceTable: 'subclass_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_2',
          columns: ['raceFeatureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_effect_data_fk_3',
          columns: ['choiceOptionId'],
          referenceTable: 'choice_option_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'feature_resource_progression_value_data',
      dartName: 'FeatureResourceProgressionValueData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'resourceDefinitionId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'value',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'feature_resource_progression_value_data_fk_0',
          columns: ['resourceDefinitionId'],
          referenceTable: 'feature_resource_definition_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'item_data',
      dartName: 'ItemData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'weight',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'cost',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'effects',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'item_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'magic_item_data',
      dartName: 'MagicItemData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'rarity',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresAttunement',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'attunementCondition',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'bonus',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<String,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'charges',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'rechargeCondition',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'effects',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'magic_item_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'race_data',
      dartName: 'RaceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'speed',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'size',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:CreatureSize?',
        ),
        _isp.ColumnDefinition(
          name: 'strengthBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'dexterityBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'constitutionBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'intelligenceBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'wisdomBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'charismaBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'traits',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'languages',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _isp.ColumnDefinition(
          name: 'visionType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SenseType?',
        ),
        _isp.ColumnDefinition(
          name: 'visionRange',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'resistances',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamageType>?',
        ),
        _isp.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'armorProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'weaponProficiencyKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'toolProficiencyKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'imageURL',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'race_feature_data',
      dartName: 'RaceFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'raceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'subraceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'shortDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'usesPerRest',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _isp.ColumnDefinition(
          name: 'usesFormula',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'tags',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'race_feature_data_fk_0',
          columns: ['raceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'race_feature_data_fk_1',
          columns: ['subraceId'],
          referenceTable: 'subrace_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'race_feature_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'race_feature_spell_grant_data',
      dartName: 'RaceFeatureSpellGrantData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'featureId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'spellId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'grantedAtLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'activation',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellActivationData?',
        ),
        _isp.ColumnDefinition(
          name: 'castingAbility',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
        _isp.ColumnDefinition(
          name: 'freeCastsPerRest',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:RestType?',
        ),
        _isp.ColumnDefinition(
          name: 'freeCastsFormula',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'castAtSpellLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'canAlsoCastWithSpellSlots',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'notes',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_0',
          columns: ['featureId'],
          referenceTable: 'race_feature_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'race_feature_spell_grant_data_fk_1',
          columns: ['spellId'],
          referenceTable: 'spell_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'spell_data',
      dartName: 'SpellData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'shortDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'schoolValue',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellSchool?',
        ),
        _isp.ColumnDefinition(
          name: 'castingTime',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'range',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'duration',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'concentration',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'ritual',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'higherLevel',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'savingThrowAbility',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresSavingThrow',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'attackType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellAttackType?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresAttackRoll',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'damageType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _isp.ColumnDefinition(
          name: 'damageDice',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'damageScaling',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellScalingData?',
        ),
        _isp.ColumnDefinition(
          name: 'damageParts',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamagePartData>?',
        ),
        _isp.ColumnDefinition(
          name: 'conditions',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ConditionType>?',
        ),
        _isp.ColumnDefinition(
          name: 'targetType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellTargetType?',
        ),
        _isp.ColumnDefinition(
          name: 'areaOfEffectType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AreaOfEffectType?',
        ),
        _isp.ColumnDefinition(
          name: 'areaOfEffectSize',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'areaOfEffectSizeKind',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:AreaSizeMeasurement?',
        ),
        _isp.ColumnDefinition(
          name: 'areaOfEffectSecondarySize',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'areaOfEffectHeight',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'materialDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'materialCost',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'materialConsumed',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'durationType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellDurationType?',
        ),
        _isp.ColumnDefinition(
          name: 'isHealing',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'healingDice',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'healingScaling',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellScalingData?',
        ),
        _isp.ColumnDefinition(
          name: 'healingAddsCastingModifier',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresLineOfSight',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresVerbal',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresSomatic',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'requiresMaterial',
          columnType: _isp.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _isp.ColumnDefinition(
          name: 'availableForClassIds',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
        _isp.ColumnDefinition(
          name: 'availableForSubclassIds',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'spell_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'spell_slot_progression_data',
      dartName: 'SpellSlotProgressionData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'tableKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'spellSlots',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'Map<int,int>?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'spell_slot_progression_table_level_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tableKey',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
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
    _isp.TableDefinition(
      name: 'starting_equipment_entry_data',
      dartName: 'StartingEquipmentEntryData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'sourceClassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'sourceBackgroundId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'parentEntryId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:StartingEquipmentEntryKind?',
        ),
        _isp.ColumnDefinition(
          name: 'orderIndex',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'selectionCount',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'lineKind',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:StartingEquipmentLineKind?',
        ),
        _isp.ColumnDefinition(
          name: 'quantity',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'catalogType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:EquipmentCatalogType?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'allowedWeaponCategories',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'allowedItemCategories',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'starting_equipment_entry_data_fk_0',
          columns: ['sourceClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'starting_equipment_entry_data_fk_1',
          columns: ['sourceBackgroundId'],
          referenceTable: 'background_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'starting_equipment_entry_class_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceClassId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'starting_equipment_entry_background_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'sourceBackgroundId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'starting_equipment_entry_parent_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'parentEntryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'subclass_data',
      dartName: 'SubclassData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'spellSelectionFilter',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'protocol:SpellSelectionFilterData?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'shortDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'subclassName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'parentClassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'levelRequired',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'spellcastingStartLevel',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'spellcastingProgression',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:SpellcastingProgression?',
        ),
        _isp.ColumnDefinition(
          name: 'spellSelectionMode',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ClassSpellSelectionMode?',
        ),
        _isp.ColumnDefinition(
          name: 'spellcastingAbilityValue',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:Ability?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'subclass_data_fk_0',
          columns: ['parentClassId'],
          referenceTable: 'class_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'subclass_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'subclass_feature_data',
      dartName: 'SubclassFeatureData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'parentSubclassId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'shortDescription',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'tags',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:FeatureTag>?',
        ),
        _isp.ColumnDefinition(
          name: 'choiceGroupKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedExpertiseSkills',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedLanguages',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Language>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedArmorTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedWeaponTraining',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedToolKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedExpertiseToolKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'grantedSpellKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'relatedTable',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'subclass_feature_data_fk_0',
          columns: ['parentSubclassId'],
          referenceTable: 'subclass_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'subclass_feature_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'subrace_data',
      dartName: 'SubraceData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'parentRaceId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'strengthBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'dexterityBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'constitutionBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'intelligenceBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'wisdomBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'charismaBonus',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'traits',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'speedOverride',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'visionRangeOverride',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'skillProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:Skill>?',
        ),
        _isp.ColumnDefinition(
          name: 'resistances',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:DamageType>?',
        ),
        _isp.ColumnDefinition(
          name: 'armorProficiencies',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:ArmorCategory>?',
        ),
        _isp.ColumnDefinition(
          name: 'weaponProficiencyKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
        _isp.ColumnDefinition(
          name: 'toolProficiencyKeys',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'subrace_data_fk_0',
          columns: ['parentRaceId'],
          referenceTable: 'race_data',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'tool_data',
      dartName: 'ToolData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'protocol:ToolCategory?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'tool_data_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'weapon_data',
      dartName: 'WeaponData',
      schema: 'public',
      module: 'characters_mirror',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'referenceKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'version',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'updatedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'category',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:WeaponCategory?',
        ),
        _isp.ColumnDefinition(
          name: 'damage',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'damageType',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:DamageType?',
        ),
        _isp.ColumnDefinition(
          name: 'properties',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<protocol:WeaponProperty>?',
        ),
        _isp.ColumnDefinition(
          name: 'weight',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'cost',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _isp.ColumnDefinition(
          name: 'rangeNormal',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'rangeMax',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'weapon_reference_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'referenceKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i1n3uhu0.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _iaskjtek.CharacterAppliedChangeRecord) {
      return _iaskjtek.CharacterAppliedChangeRecord.fromJson(data) as T;
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
    if (t == _i1l3jk2d.CharacterChoiceRecord) {
      return _i1l3jk2d.CharacterChoiceRecord.fromJson(data) as T;
    }
    if (t == _iqjjxby6.CharacterClassEntryData) {
      return _iqjjxby6.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i1goyn5n.CharacterClassEntryRecord) {
      return _i1goyn5n.CharacterClassEntryRecord.fromJson(data) as T;
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
    if (t == _is140f48.CharacterRecord) {
      return _is140f48.CharacterRecord.fromJson(data) as T;
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
    if (t == _ic0tmv5d.CharacterSkillSelectionRecord) {
      return _ic0tmv5d.CharacterSkillSelectionRecord.fromJson(data) as T;
    }
    if (t == _iesndgzw.CharacterSpellSelectionData) {
      return _iesndgzw.CharacterSpellSelectionData.fromJson(data) as T;
    }
    if (t == _icqki103.CharacterSpellSelectionRecord) {
      return _icqki103.CharacterSpellSelectionRecord.fromJson(data) as T;
    }
    if (t == _ieudcx2k.CharacterStartingEquipmentResolutionData) {
      return _ieudcx2k.CharacterStartingEquipmentResolutionData.fromJson(data)
          as T;
    }
    if (t == _ipbr5hem.CharacterStartingEquipmentResolutionRecord) {
      return _ipbr5hem.CharacterStartingEquipmentResolutionRecord.fromJson(data)
          as T;
    }
    if (t == _ixmjb4z5.CharacterStartingEquipmentSelectionData) {
      return _ixmjb4z5.CharacterStartingEquipmentSelectionData.fromJson(data)
          as T;
    }
    if (t == _ikk28htr.CharacterStartingEquipmentSelectionRecord) {
      return _ikk28htr.CharacterStartingEquipmentSelectionRecord.fromJson(data)
          as T;
    }
    if (t == _i2rqx8lk.CharacterSyncEventRecord) {
      return _i2rqx8lk.CharacterSyncEventRecord.fromJson(data) as T;
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
    if (t == _is.getType<_iydli74w.AuthActionResult?>()) {
      return (data != null ? _iydli74w.AuthActionResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i3katqli.BackgroundData?>()) {
      return (data != null ? _i3katqli.BackgroundData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i68we1de.ClassSpellGrantData?>()) {
      return (data != null
              ? _i68we1de.ClassSpellGrantData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqilpl6d.DamagePartData?>()) {
      return (data != null ? _iqilpl6d.DamagePartData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1l5wul2.FeatData?>()) {
      return (data != null ? _i1l5wul2.FeatData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iaskjtek.CharacterAppliedChangeRecord?>()) {
      return (data != null
              ? _iaskjtek.CharacterAppliedChangeRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ijpj2a9u.CharacterArmorTrainingOverridesData?>()) {
      return (data != null
              ? _ijpj2a9u.CharacterArmorTrainingOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iykib7lv.CharacterAttackData?>()) {
      return (data != null
              ? _iykib7lv.CharacterAttackData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibkyvw07.CharacterChangeData?>()) {
      return (data != null
              ? _ibkyvw07.CharacterChangeData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwf32wta.CharacterChoiceData?>()) {
      return (data != null
              ? _iwf32wta.CharacterChoiceData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1l3jk2d.CharacterChoiceRecord?>()) {
      return (data != null
              ? _i1l3jk2d.CharacterChoiceRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqjjxby6.CharacterClassEntryData?>()) {
      return (data != null
              ? _iqjjxby6.CharacterClassEntryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1goyn5n.CharacterClassEntryRecord?>()) {
      return (data != null
              ? _i1goyn5n.CharacterClassEntryRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_im2o0tmj.CharacterData?>()) {
      return (data != null ? _im2o0tmj.CharacterData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir4negfy.CharacterDerivedData?>()) {
      return (data != null
              ? _ir4negfy.CharacterDerivedData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i7jkadr4.CharacterEquipmentSelectionData?>()) {
      return (data != null
              ? _i7jkadr4.CharacterEquipmentSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iggvk3az.CharacterFeatureOverrideData?>()) {
      return (data != null
              ? _iggvk3az.CharacterFeatureOverrideData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_imlxp0ix.CharacterFeatureViewData?>()) {
      return (data != null
              ? _imlxp0ix.CharacterFeatureViewData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_id5dgxdg.CharacterInventoryItemData?>()) {
      return (data != null
              ? _id5dgxdg.CharacterInventoryItemData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibvj7xz5.CharacterLanguageOverridesData?>()) {
      return (data != null
              ? _ibvj7xz5.CharacterLanguageOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqjbme11.CharacterNoteData?>()) {
      return (data != null ? _iqjbme11.CharacterNoteData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_is140f48.CharacterRecord?>()) {
      return (data != null ? _is140f48.CharacterRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ig0fia1r.CharacterRejectedChangeData?>()) {
      return (data != null
              ? _ig0fia1r.CharacterRejectedChangeData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iu6zjs5s.CharacterResourceStateData?>()) {
      return (data != null
              ? _iu6zjs5s.CharacterResourceStateData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_io9jihae.CharacterResourceViewData?>()) {
      return (data != null
              ? _io9jihae.CharacterResourceViewData.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _is.getType<_i3yrtkjn.CharacterSavingThrowProficiencyOverrideData?>()) {
      return (data != null
              ? _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _is.getType<_ivfw6q0y.CharacterSemanticActionData?>()) {
      return (data != null
              ? _ivfw6q0y.CharacterSemanticActionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_isl5krdt.CharacterSkillProficiencyState?>()) {
      return (data != null
              ? _isl5krdt.CharacterSkillProficiencyState.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_itkzfry3.CharacterSkillSelectionData?>()) {
      return (data != null
              ? _itkzfry3.CharacterSkillSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ic0tmv5d.CharacterSkillSelectionRecord?>()) {
      return (data != null
              ? _ic0tmv5d.CharacterSkillSelectionRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iesndgzw.CharacterSpellSelectionData?>()) {
      return (data != null
              ? _iesndgzw.CharacterSpellSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_icqki103.CharacterSpellSelectionRecord?>()) {
      return (data != null
              ? _icqki103.CharacterSpellSelectionRecord.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _is.getType<_ieudcx2k.CharacterStartingEquipmentResolutionData?>()) {
      return (data != null
              ? _ieudcx2k.CharacterStartingEquipmentResolutionData.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t ==
        _is.getType<_ipbr5hem.CharacterStartingEquipmentResolutionRecord?>()) {
      return (data != null
              ? _ipbr5hem.CharacterStartingEquipmentResolutionRecord.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t ==
        _is.getType<_ixmjb4z5.CharacterStartingEquipmentSelectionData?>()) {
      return (data != null
              ? _ixmjb4z5.CharacterStartingEquipmentSelectionData.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _is.getType<_ikk28htr.CharacterStartingEquipmentSelectionRecord?>()) {
      return (data != null
              ? _ikk28htr.CharacterStartingEquipmentSelectionRecord.fromJson(
                  data,
                )
              : null)
          as T;
    }
    if (t == _is.getType<_i2rqx8lk.CharacterSyncEventRecord?>()) {
      return (data != null
              ? _i2rqx8lk.CharacterSyncEventRecord.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_is9ng6da.CharacterSyncOperationData?>()) {
      return (data != null
              ? _is9ng6da.CharacterSyncOperationData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_icxp0ddy.CharacterSyncRequest?>()) {
      return (data != null
              ? _icxp0ddy.CharacterSyncRequest.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i29bgu3e.CharacterSyncResponse?>()) {
      return (data != null
              ? _i29bgu3e.CharacterSyncResponse.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ix5qhw9w.CharacterSyncResult?>()) {
      return (data != null
              ? _ix5qhw9w.CharacterSyncResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixfhi6l8.CharacterSyncStatus?>()) {
      return (data != null
              ? _ixfhi6l8.CharacterSyncStatus.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iz49jt9b.CharacterSyncValueData?>()) {
      return (data != null
              ? _iz49jt9b.CharacterSyncValueData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_idvpwngn.CharacterToolProficiencyOverridesData?>()) {
      return (data != null
              ? _idvpwngn.CharacterToolProficiencyOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _is.getType<_i5e0copu.CharacterWeaponProficiencyOverridesData?>()) {
      return (data != null
              ? _i5e0copu.CharacterWeaponProficiencyOverridesData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i2mamrrk.ChoiceReplacementHistoryData?>()) {
      return (data != null
              ? _i2mamrrk.ChoiceReplacementHistoryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iij0mpeo.LevelUpChoiceReplacementData?>()) {
      return (data != null
              ? _iij0mpeo.LevelUpChoiceReplacementData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipxtly6g.LevelUpRequest?>()) {
      return (data != null ? _ipxtly6g.LevelUpRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4b5l3un.LevelUpSpellChoice?>()) {
      return (data != null ? _i4b5l3un.LevelUpSpellChoice.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0tavl9b.RelatedFeatureViewData?>()) {
      return (data != null
              ? _i0tavl9b.RelatedFeatureViewData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_it45kp8q.SpellSelectionReplacementHistoryData?>()) {
      return (data != null
              ? _it45kp8q.SpellSelectionReplacementHistoryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i9cfge83.SpellSlotRecoveryTriggerData?>()) {
      return (data != null
              ? _i9cfge83.SpellSlotRecoveryTriggerData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3zkka4q.ChoiceGroupData?>()) {
      return (data != null ? _i3zkka4q.ChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iprx2upt.ChoiceOptionData?>()) {
      return (data != null ? _iprx2upt.ChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iax2s634.ChoiceRequirementData?>()) {
      return (data != null
              ? _iax2s634.ChoiceRequirementData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i4e8ker2.ClassData?>()) {
      return (data != null ? _i4e8ker2.ClassData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijvqpc4v.ClassFeatureData?>()) {
      return (data != null ? _ijvqpc4v.ClassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isxi9i4e.ClassLevelData?>()) {
      return (data != null ? _isxi9i4e.ClassLevelData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ihr52fes.PreparedSpellRuleData?>()) {
      return (data != null
              ? _ihr52fes.PreparedSpellRuleData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ig6b5pj2.SpellSlotProgressionData?>()) {
      return (data != null
              ? _ig6b5pj2.SpellSlotProgressionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_igasg47n.StartingEquipmentBlockData?>()) {
      return (data != null
              ? _igasg47n.StartingEquipmentBlockData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_impna1yi.StartingEquipmentEntryData?>()) {
      return (data != null
              ? _impna1yi.StartingEquipmentEntryData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iozcdomq.StartingEquipmentLineData?>()) {
      return (data != null
              ? _iozcdomq.StartingEquipmentLineData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyz352zl.StartingEquipmentOptionData?>()) {
      return (data != null
              ? _iyz352zl.StartingEquipmentOptionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ijic8hve.SubclassData?>()) {
      return (data != null ? _ijic8hve.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iel0dp9q.SubclassFeatureData?>()) {
      return (data != null
              ? _iel0dp9q.SubclassFeatureData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i0aiwhe6.FeatureDisplayPropertyData?>()) {
      return (data != null
              ? _i0aiwhe6.FeatureDisplayPropertyData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iwfr4tm0.FeatureModifierConditionData?>()) {
      return (data != null
              ? _iwfr4tm0.FeatureModifierConditionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ilhpjxpt.FeatureModifierData?>()) {
      return (data != null
              ? _ilhpjxpt.FeatureModifierData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ircf4zmd.FeatureModifierValueData?>()) {
      return (data != null
              ? _ircf4zmd.FeatureModifierValueData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_isecmqna.FeatureRelationData?>()) {
      return (data != null
              ? _isecmqna.FeatureRelationData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iflv344v.FeatureResourceDefinitionData?>()) {
      return (data != null
              ? _iflv344v.FeatureResourceDefinitionData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i86imp4g.FeatureResourceEffectData?>()) {
      return (data != null
              ? _i86imp4g.FeatureResourceEffectData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iafoerth.FeatureResourceProgressionValueData?>()) {
      return (data != null
              ? _iafoerth.FeatureResourceProgressionValueData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_irh2914h.RaceData?>()) {
      return (data != null ? _irh2914h.RaceData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_imnymvhh.RaceFeatureData?>()) {
      return (data != null ? _imnymvhh.RaceFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ilhjydvh.RaceFeatureSpellGrantData?>()) {
      return (data != null
              ? _ilhjydvh.RaceFeatureSpellGrantData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iqoglfsm.SubraceData?>()) {
      return (data != null ? _iqoglfsm.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_idolx2sf.SpellActivationData?>()) {
      return (data != null
              ? _idolx2sf.SpellActivationData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i9erq8kp.SpellResourceUpcastPolicyData?>()) {
      return (data != null
              ? _i9erq8kp.SpellResourceUpcastPolicyData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_in2nv22i.SpellSelectionFilterData?>()) {
      return (data != null
              ? _in2nv22i.SpellSelectionFilterData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipwf59gx.SpellSlotRecoveryPolicyData?>()) {
      return (data != null
              ? _ipwf59gx.SpellSlotRecoveryPolicyData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ivjna1ls.ToolData?>()) {
      return (data != null ? _ivjna1ls.ToolData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iv545qv3.ArmorData?>()) {
      return (data != null ? _iv545qv3.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibuwh0hc.ItemData?>()) {
      return (data != null ? _ibuwh0hc.ItemData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i41tgptx.MagicItemData?>()) {
      return (data != null ? _i41tgptx.MagicItemData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_inpmmgks.WeaponData?>()) {
      return (data != null ? _inpmmgks.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itvh88br.SpellData?>()) {
      return (data != null ? _itvh88br.SpellData.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iq5q0wh8.SpellScalingData?>()) {
      return (data != null ? _iq5q0wh8.SpellScalingData.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ivey3rvd.DmCreatureException?>()) {
      return (data != null
              ? _ivey3rvd.DmCreatureException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i11aekbu.DmCreatureImportResult?>()) {
      return (data != null
              ? _i11aekbu.DmCreatureImportResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipuprlj7.DmCreatureRecord?>()) {
      return (data != null ? _ipuprlj7.DmCreatureRecord.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idf6hpk3.DmCreatureSummary?>()) {
      return (data != null ? _idf6hpk3.DmCreatureSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i5rga0su.Ability?>()) {
      return (data != null ? _i5rga0su.Ability.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ix11b24x.ArmorCategory?>()) {
      return (data != null ? _ix11b24x.ArmorCategory.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik1o33an.CharacterAlignment?>()) {
      return (data != null ? _ik1o33an.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_idqm1edw.CharacterChangeType?>()) {
      return (data != null
              ? _idqm1edw.CharacterChangeType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_icxxpsvd.CharacterEntityType?>()) {
      return (data != null
              ? _icxxpsvd.CharacterEntityType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i1fix3of.CharacterFeatureSourceType?>()) {
      return (data != null
              ? _i1fix3of.CharacterFeatureSourceType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ik9iz51c.CharacterInventoryItemType?>()) {
      return (data != null
              ? _ik9iz51c.CharacterInventoryItemType.fromJson(data)
              : null)
          as T;
    }
    if (t ==
        _is.getType<_ixbcln74.CharacterSavingThrowProficiencyOverride?>()) {
      return (data != null
              ? _ixbcln74.CharacterSavingThrowProficiencyOverride.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixj33h5c.CharacterSkillProficiencyLevel?>()) {
      return (data != null
              ? _ixj33h5c.CharacterSkillProficiencyLevel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3ppfbzb.CharacterSkillSelectionKind?>()) {
      return (data != null
              ? _i3ppfbzb.CharacterSkillSelectionKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ikyxycuo.CharacterSpeedKind?>()) {
      return (data != null ? _ikyxycuo.CharacterSpeedKind.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ie0q5aqi.CharacterSpellSelectionKind?>()) {
      return (data != null
              ? _ie0q5aqi.CharacterSpellSelectionKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6jbrxie.CharacterSyncOperationType?>()) {
      return (data != null
              ? _i6jbrxie.CharacterSyncOperationType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ia4qs68v.CharacterSyncTargetType?>()) {
      return (data != null
              ? _ia4qs68v.CharacterSyncTargetType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ia6aulam.ChoiceRequirementType?>()) {
      return (data != null
              ? _ia6aulam.ChoiceRequirementType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iam6xy91.ChoiceSourceType?>()) {
      return (data != null ? _iam6xy91.ChoiceSourceType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iotu8r29.ChoiceType?>()) {
      return (data != null ? _iotu8r29.ChoiceType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijyz5fbs.ClassSpellSelectionMode?>()) {
      return (data != null
              ? _ijyz5fbs.ClassSpellSelectionMode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ikb1pesi.ConditionType?>()) {
      return (data != null ? _ikb1pesi.ConditionType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6cngs6w.CreatureSize?>()) {
      return (data != null ? _i6cngs6w.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i6q2t5mj.DamageType?>()) {
      return (data != null ? _i6q2t5mj.DamageType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ia851nk8.EquipmentCatalogType?>()) {
      return (data != null
              ? _ia851nk8.EquipmentCatalogType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i9idws3v.FeatureDisplayPropertyValueKind?>()) {
      return (data != null
              ? _i9idws3v.FeatureDisplayPropertyValueKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ilgpxa54.FeatureModifierConditionType?>()) {
      return (data != null
              ? _ilgpxa54.FeatureModifierConditionType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i56op7oq.FeatureModifierOperation?>()) {
      return (data != null
              ? _i56op7oq.FeatureModifierOperation.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6asfa9j.FeatureModifierRounding?>()) {
      return (data != null
              ? _i6asfa9j.FeatureModifierRounding.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_izn79nb9.FeatureModifierTarget?>()) {
      return (data != null
              ? _izn79nb9.FeatureModifierTarget.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_il8rk55k.FeatureModifierValueKind?>()) {
      return (data != null
              ? _il8rk55k.FeatureModifierValueKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ih812opj.FeatureRelationType?>()) {
      return (data != null
              ? _ih812opj.FeatureRelationType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ijb3cn5v.FeatureResourceEffectType?>()) {
      return (data != null
              ? _ijb3cn5v.FeatureResourceEffectType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ia1vmwiq.FeatureResourceKind?>()) {
      return (data != null
              ? _ia1vmwiq.FeatureResourceKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ib4g5i7q.FeatureResourceMaxRule?>()) {
      return (data != null
              ? _ib4g5i7q.FeatureResourceMaxRule.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_if07r66f.FeatureResourceProgressionKey?>()) {
      return (data != null
              ? _if07r66f.FeatureResourceProgressionKey.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iyk5jgys.FeatureResourceTargetType?>()) {
      return (data != null
              ? _iyk5jgys.FeatureResourceTargetType.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ir3q1cdf.FeatureResourceTrigger?>()) {
      return (data != null
              ? _ir3q1cdf.FeatureResourceTrigger.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i2l7bpu3.FeatureTag?>()) {
      return (data != null ? _i2l7bpu3.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_izodp5lk.HitPointMode?>()) {
      return (data != null ? _izodp5lk.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iftbsk4q.Language?>()) {
      return (data != null ? _iftbsk4q.Language.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieum0m7f.PreparedSpellRounding?>()) {
      return (data != null
              ? _ieum0m7f.PreparedSpellRounding.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ibgbgp52.RestType?>()) {
      return (data != null ? _ibgbgp52.RestType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iy62ln0z.SenseType?>()) {
      return (data != null ? _iy62ln0z.SenseType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iabgjh08.Skill?>()) {
      return (data != null ? _iabgjh08.Skill.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ieavm63l.AreaOfEffectType?>()) {
      return (data != null ? _ieavm63l.AreaOfEffectType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iatx40hq.AreaSizeMeasurement?>()) {
      return (data != null
              ? _iatx40hq.AreaSizeMeasurement.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_inf83u33.SpellAttackType?>()) {
      return (data != null ? _inf83u33.SpellAttackType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9u2urpu.SpellDurationType?>()) {
      return (data != null ? _i9u2urpu.SpellDurationType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iw7hp9dc.SpellScalingMode?>()) {
      return (data != null ? _iw7hp9dc.SpellScalingMode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ioahu9w9.SpellSchool?>()) {
      return (data != null ? _ioahu9w9.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iupu1e0e.SpellTargetType?>()) {
      return (data != null ? _iupu1e0e.SpellTargetType.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ik43ztmo.SpellSlotRecoveryMode?>()) {
      return (data != null
              ? _ik43ztmo.SpellSlotRecoveryMode.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ilfh4rku.SpellcastingProgression?>()) {
      return (data != null
              ? _ilfh4rku.SpellcastingProgression.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iag2d6aj.StartingEquipmentBlockKind?>()) {
      return (data != null
              ? _iag2d6aj.StartingEquipmentBlockKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipm8xyg1.StartingEquipmentEntryKind?>()) {
      return (data != null
              ? _ipm8xyg1.StartingEquipmentEntryKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iniqanjc.StartingEquipmentLineKind?>()) {
      return (data != null
              ? _iniqanjc.StartingEquipmentLineKind.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ic2cpv54.ToolCategory?>()) {
      return (data != null ? _ic2cpv54.ToolCategory.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i4vk4r4o.UnarmoredDefenseRule?>()) {
      return (data != null
              ? _i4vk4r4o.UnarmoredDefenseRule.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iiyileog.WeaponCategory?>()) {
      return (data != null ? _iiyileog.WeaponCategory.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iur813s4.WeaponProperty?>()) {
      return (data != null ? _iur813s4.WeaponProperty.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1l5m7qw.LevelDownChoiceRepair?>()) {
      return (data != null
              ? _i1l5m7qw.LevelDownChoiceRepair.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_irktv0ea.LevelDownRequest?>()) {
      return (data != null ? _irktv0ea.LevelDownRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqeghuxo.BackgroundStepView?>()) {
      return (data != null ? _iqeghuxo.BackgroundStepView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_isbrs5qf.CharacterEquipmentEntryView?>()) {
      return (data != null
              ? _isbrs5qf.CharacterEquipmentEntryView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i6xbclit.ChoiceGroupView?>()) {
      return (data != null ? _i6xbclit.ChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iil6pw38.ChoiceOptionEligibilityView?>()) {
      return (data != null
              ? _iil6pw38.ChoiceOptionEligibilityView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iob9tmlr.ChoiceRequirementFailureView?>()) {
      return (data != null
              ? _iob9tmlr.ChoiceRequirementFailureView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ik4ex2us.ClassSpellDeltaView?>()) {
      return (data != null
              ? _ik4ex2us.ClassSpellDeltaView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ixvig4n8.ClassSpellSelectionGroupView?>()) {
      return (data != null
              ? _ixvig4n8.ClassSpellSelectionGroupView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ih120cff.ClassStepFeatureView?>()) {
      return (data != null
              ? _ih120cff.ClassStepFeatureView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3cyal5j.ClassStepSubclassChoiceView?>()) {
      return (data != null
              ? _i3cyal5j.ClassStepSubclassChoiceView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ib3duw15.ClassStepView?>()) {
      return (data != null ? _ib3duw15.ClassStepView.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i9kpkyz2.FeatureDisplayPropertyView?>()) {
      return (data != null
              ? _i9kpkyz2.FeatureDisplayPropertyView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iu8i64vu.LevelDownInvalidChoiceView?>()) {
      return (data != null
              ? _iu8i64vu.LevelDownInvalidChoiceView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ipbxh79i.LevelDownPreview?>()) {
      return (data != null ? _ipbxh79i.LevelDownPreview.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ipqjgw5e.LevelUpPreview?>()) {
      return (data != null ? _ipqjgw5e.LevelUpPreview.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ifavv51o.ProficiencyBundleView?>()) {
      return (data != null
              ? _ifavv51o.ProficiencyBundleView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_id360bq3.RaceStepView?>()) {
      return (data != null ? _id360bq3.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i8p2oglu.ResolvedCharacterSpellData?>()) {
      return (data != null
              ? _i8p2oglu.ResolvedCharacterSpellData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_im19jsv2.SelectedFeatureChoiceView?>()) {
      return (data != null
              ? _im19jsv2.SelectedFeatureChoiceView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ihn36a1g.SkillSelectionGroupView?>()) {
      return (data != null
              ? _ihn36a1g.SkillSelectionGroupView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iam7pkuu.SpellSourceContextData?>()) {
      return (data != null
              ? _iam7pkuu.SpellSourceContextData.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_izjjz5hc.StartingEquipmentBlockView?>()) {
      return (data != null
              ? _izjjz5hc.StartingEquipmentBlockView.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_i3vgjwh2.StartingEquipmentOptionView?>()) {
      return (data != null
              ? _i3vgjwh2.StartingEquipmentOptionView.fromJson(data)
              : null)
          as T;
    }
    if (t == List<_iabgjh08.Skill>) {
      return (data as List).map((e) => deserialize<_iabgjh08.Skill>(e)).toList()
          as T;
    }
    if (t == _is.getType<List<_iabgjh08.Skill>?>()) {
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
    if (t == _is.getType<List<String>?>()) {
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
    if (t == _is.getType<Map<String, int>?>()) {
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
    if (t == _is.getType<List<_i2l7bpu3.FeatureTag>?>()) {
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
    if (t == _is.getType<List<_ix11b24x.ArmorCategory>?>()) {
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
    if (t == _is.getType<List<_iqilpl6d.DamagePartData>?>()) {
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
    if (t == _is.getType<List<_i2mamrrk.ChoiceReplacementHistoryData>?>()) {
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
    if (t == _is.getType<List<int>?>()) {
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
    if (t == _is.getType<Map<String, String>?>()) {
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
    if (t == _is.getType<Map<int, int>?>()) {
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
    if (t == _is.getType<List<_ikb1pesi.ConditionType>?>()) {
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
    if (t == _is.getType<List<_id5dgxdg.CharacterInventoryItemData>?>()) {
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
    if (t == _is.getType<List<_isl5krdt.CharacterSkillProficiencyState>?>()) {
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
    if (t == _is.getType<List<_i5rga0su.Ability>?>()) {
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
        _is
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
    if (t == _is.getType<List<_iqjbme11.CharacterNoteData>?>()) {
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
    if (t == _is.getType<List<_iykib7lv.CharacterAttackData>?>()) {
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
    if (t == _is.getType<List<_iggvk3az.CharacterFeatureOverrideData>?>()) {
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
    if (t == _is.getType<List<_iu6zjs5s.CharacterResourceStateData>?>()) {
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
        _is.getType<Map<String, _i9cfge83.SpellSlotRecoveryTriggerData>?>()) {
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
    if (t == _is.getType<List<_iqjjxby6.CharacterClassEntryData>?>()) {
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
    if (t == _is.getType<List<_iwf32wta.CharacterChoiceData>?>()) {
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
    if (t == _is.getType<List<_itkzfry3.CharacterSkillSelectionData>?>()) {
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
    if (t == _is.getType<List<_iesndgzw.CharacterSpellSelectionData>?>()) {
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
        _is
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
    if (t == _is.getType<Map<_i5rga0su.Ability, int>?>()) {
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
    if (t == _is.getType<List<_imlxp0ix.CharacterFeatureViewData>?>()) {
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
    if (t == _is.getType<List<_ilhpjxpt.FeatureModifierData>?>()) {
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
    if (t == _is.getType<Map<_iabgjh08.Skill, int>?>()) {
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
    if (t == _is.getType<List<_iftbsk4q.Language>?>()) {
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
    if (t == _is.getType<List<_iiyileog.WeaponCategory>?>()) {
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
    if (t == _is.getType<List<_i8p2oglu.ResolvedCharacterSpellData>?>()) {
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
    if (t == _is.getType<List<_isbrs5qf.CharacterEquipmentEntryView>?>()) {
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
    if (t == _is.getType<List<_i6q2t5mj.DamageType>?>()) {
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
    if (t == _is.getType<List<_io9jihae.CharacterResourceViewData>?>()) {
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
    if (t == _is.getType<List<_i9kpkyz2.FeatureDisplayPropertyView>?>()) {
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
    if (t == _is.getType<List<_i0tavl9b.RelatedFeatureViewData>?>()) {
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
    if (t == _is.getType<List<_im19jsv2.SelectedFeatureChoiceView>?>()) {
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
    if (t == _is.getType<List<_i86imp4g.FeatureResourceEffectData>?>()) {
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
        _is.getType<List<_it45kp8q.SpellSelectionReplacementHistoryData>?>()) {
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
        _is
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
    if (t == _is.getType<List<_ibkyvw07.CharacterChangeData>?>()) {
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
    if (t == _is.getType<List<_is9ng6da.CharacterSyncOperationData>?>()) {
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
    if (t == _is.getType<List<_ig0fia1r.CharacterRejectedChangeData>?>()) {
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
    if (t == _is.getType<List<_im2o0tmj.CharacterData>?>()) {
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
    if (t == _is.getType<Map<String, _im2o0tmj.CharacterData>?>()) {
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
    if (t == _is.getType<List<_iij0mpeo.LevelUpChoiceReplacementData>?>()) {
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
    if (t == _is.getType<Map<String, List<String>>?>()) {
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
    if (t == _is.getType<List<_i4b5l3un.LevelUpSpellChoice>?>()) {
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
    if (t == _is.getType<List<_iax2s634.ChoiceRequirementData>?>()) {
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
    if (t == _is.getType<List<_iflv344v.FeatureResourceDefinitionData>?>()) {
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
    if (t == _is.getType<List<_i68we1de.ClassSpellGrantData>?>()) {
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
    if (t == _is.getType<List<_iozcdomq.StartingEquipmentLineData>?>()) {
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
    if (t == _is.getType<List<_iyz352zl.StartingEquipmentOptionData>?>()) {
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
    if (t == _is.getType<Map<int, String>?>()) {
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
    if (t == _is.getType<List<_iwfr4tm0.FeatureModifierConditionData>?>()) {
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
        _is.getType<List<_iafoerth.FeatureResourceProgressionValueData>?>()) {
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
    if (t == _is.getType<List<_imnymvhh.RaceFeatureData>?>()) {
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
    if (t == _is.getType<List<_ilhjydvh.RaceFeatureSpellGrantData>?>()) {
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
    if (t == _is.getType<List<_ioahu9w9.SpellSchool>?>()) {
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
    if (t == _is.getType<List<_ie0q5aqi.CharacterSpellSelectionKind>?>()) {
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
    if (t == _is.getType<List<_iur813s4.WeaponProperty>?>()) {
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
    if (t == _is.getType<List<_i1l5m7qw.LevelDownChoiceRepair>?>()) {
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
    if (t == _is.getType<List<_i6xbclit.ChoiceGroupView>?>()) {
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
    if (t == _is.getType<List<_ihn36a1g.SkillSelectionGroupView>?>()) {
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
    if (t == _is.getType<List<_izjjz5hc.StartingEquipmentBlockView>?>()) {
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
    if (t == _is.getType<List<_iprx2upt.ChoiceOptionData>?>()) {
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
    if (t == _is.getType<List<_iil6pw38.ChoiceOptionEligibilityView>?>()) {
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
    if (t == _is.getType<List<_iob9tmlr.ChoiceRequirementFailureView>?>()) {
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
    if (t == _is.getType<List<_itvh88br.SpellData>?>()) {
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
    if (t == _is.getType<List<_ijic8hve.SubclassData>?>()) {
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
    if (t == _is.getType<List<_ijvqpc4v.ClassFeatureData>?>()) {
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
    if (t == _is.getType<List<_iel0dp9q.SubclassFeatureData>?>()) {
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
    if (t == _is.getType<List<_ih120cff.ClassStepFeatureView>?>()) {
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
    if (t == _is.getType<List<_ixvig4n8.ClassSpellSelectionGroupView>?>()) {
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
    if (t == _is.getType<List<_isxi9i4e.ClassLevelData>?>()) {
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
    if (t == _is.getType<List<_iqoglfsm.SubraceData>?>()) {
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
    if (t == _is.getType<List<_i3vgjwh2.StartingEquipmentOptionView>?>()) {
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
    if (t == List<_i1n3uhu0.UserInfo>) {
      return (data as List)
              .map((e) => deserialize<_i1n3uhu0.UserInfo>(e))
              .toList()
          as T;
    }
    if (t == List<_ijv7obuo.DmCreatureSummary>) {
      return (data as List)
              .map((e) => deserialize<_ijv7obuo.DmCreatureSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ini8luu6.BackgroundData>) {
      return (data as List)
              .map((e) => deserialize<_ini8luu6.BackgroundData>(e))
              .toList()
          as T;
    }
    if (t == List<_i77nrd14.FeatData>) {
      return (data as List)
              .map((e) => deserialize<_i77nrd14.FeatData>(e))
              .toList()
          as T;
    }
    if (t == List<_i7kkgt8y.CharacterData>) {
      return (data as List)
              .map((e) => deserialize<_i7kkgt8y.CharacterData>(e))
              .toList()
          as T;
    }
    if (t == List<_ioxj5inc.ChoiceGroupData>) {
      return (data as List)
              .map((e) => deserialize<_ioxj5inc.ChoiceGroupData>(e))
              .toList()
          as T;
    }
    if (t == List<_iosenkkh.ChoiceOptionData>) {
      return (data as List)
              .map((e) => deserialize<_iosenkkh.ChoiceOptionData>(e))
              .toList()
          as T;
    }
    if (t == List<_iemrti6x.ClassData>) {
      return (data as List)
              .map((e) => deserialize<_iemrti6x.ClassData>(e))
              .toList()
          as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == _is.getType<Map<String, int>?>()) {
      return (data != null
              ? (data as Map).map(
                  (k, v) =>
                      MapEntry(deserialize<String>(k), deserialize<int>(v)),
                )
              : null)
          as T;
    }
    if (t == List<_i77hkaes.ClassFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_i77hkaes.ClassFeatureData>(e))
              .toList()
          as T;
    }
    if (t == List<_iwivgnzd.ClassSpellGrantData>) {
      return (data as List)
              .map((e) => deserialize<_iwivgnzd.ClassSpellGrantData>(e))
              .toList()
          as T;
    }
    if (t == List<_ivbho7q1.ClassLevelData>) {
      return (data as List)
              .map((e) => deserialize<_ivbho7q1.ClassLevelData>(e))
              .toList()
          as T;
    }
    if (t == List<_ig2i76sa.SpellSlotProgressionData>) {
      return (data as List)
              .map((e) => deserialize<_ig2i76sa.SpellSlotProgressionData>(e))
              .toList()
          as T;
    }
    if (t == List<_ing7r6e2.SubclassData>) {
      return (data as List)
              .map((e) => deserialize<_ing7r6e2.SubclassData>(e))
              .toList()
          as T;
    }
    if (t == List<_ix0ni9v9.SubclassFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_ix0ni9v9.SubclassFeatureData>(e))
              .toList()
          as T;
    }
    if (t == List<_iwsgy0dv.FeatureRelationData>) {
      return (data as List)
              .map((e) => deserialize<_iwsgy0dv.FeatureRelationData>(e))
              .toList()
          as T;
    }
    if (t == List<_iueyhinu.RaceData>) {
      return (data as List)
              .map((e) => deserialize<_iueyhinu.RaceData>(e))
              .toList()
          as T;
    }
    if (t == List<_ikrrnfpk.RaceFeatureData>) {
      return (data as List)
              .map((e) => deserialize<_ikrrnfpk.RaceFeatureData>(e))
              .toList()
          as T;
    }
    if (t == List<_iasgt0sa.SubraceData>) {
      return (data as List)
              .map((e) => deserialize<_iasgt0sa.SubraceData>(e))
              .toList()
          as T;
    }
    if (t == List<_iwbrjjtm.RaceFeatureSpellGrantData>) {
      return (data as List)
              .map((e) => deserialize<_iwbrjjtm.RaceFeatureSpellGrantData>(e))
              .toList()
          as T;
    }
    if (t == List<_imen179o.ToolData>) {
      return (data as List)
              .map((e) => deserialize<_imen179o.ToolData>(e))
              .toList()
          as T;
    }
    if (t == List<_if6xo2mf.ArmorData>) {
      return (data as List)
              .map((e) => deserialize<_if6xo2mf.ArmorData>(e))
              .toList()
          as T;
    }
    if (t == List<_ilfoaqak.ItemData>) {
      return (data as List)
              .map((e) => deserialize<_ilfoaqak.ItemData>(e))
              .toList()
          as T;
    }
    if (t == List<_ihxnsrg8.MagicItemData>) {
      return (data as List)
              .map((e) => deserialize<_ihxnsrg8.MagicItemData>(e))
              .toList()
          as T;
    }
    if (t == List<_ixvqnkv0.WeaponData>) {
      return (data as List)
              .map((e) => deserialize<_ixvqnkv0.WeaponData>(e))
              .toList()
          as T;
    }
    if (t == List<_iphj40lo.SpellData>) {
      return (data as List)
              .map((e) => deserialize<_iphj40lo.SpellData>(e))
              .toList()
          as T;
    }
    try {
      return _i1n3uhu0.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iydli74w.AuthActionResult => 'AuthActionResult',
      _i3katqli.BackgroundData => 'BackgroundData',
      _i68we1de.ClassSpellGrantData => 'ClassSpellGrantData',
      _iqilpl6d.DamagePartData => 'DamagePartData',
      _i1l5wul2.FeatData => 'FeatData',
      _iaskjtek.CharacterAppliedChangeRecord => 'CharacterAppliedChangeRecord',
      _ijpj2a9u.CharacterArmorTrainingOverridesData =>
        'CharacterArmorTrainingOverridesData',
      _iykib7lv.CharacterAttackData => 'CharacterAttackData',
      _ibkyvw07.CharacterChangeData => 'CharacterChangeData',
      _iwf32wta.CharacterChoiceData => 'CharacterChoiceData',
      _i1l3jk2d.CharacterChoiceRecord => 'CharacterChoiceRecord',
      _iqjjxby6.CharacterClassEntryData => 'CharacterClassEntryData',
      _i1goyn5n.CharacterClassEntryRecord => 'CharacterClassEntryRecord',
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
      _is140f48.CharacterRecord => 'CharacterRecord',
      _ig0fia1r.CharacterRejectedChangeData => 'CharacterRejectedChangeData',
      _iu6zjs5s.CharacterResourceStateData => 'CharacterResourceStateData',
      _io9jihae.CharacterResourceViewData => 'CharacterResourceViewData',
      _i3yrtkjn.CharacterSavingThrowProficiencyOverrideData =>
        'CharacterSavingThrowProficiencyOverrideData',
      _ivfw6q0y.CharacterSemanticActionData => 'CharacterSemanticActionData',
      _isl5krdt.CharacterSkillProficiencyState =>
        'CharacterSkillProficiencyState',
      _itkzfry3.CharacterSkillSelectionData => 'CharacterSkillSelectionData',
      _ic0tmv5d.CharacterSkillSelectionRecord =>
        'CharacterSkillSelectionRecord',
      _iesndgzw.CharacterSpellSelectionData => 'CharacterSpellSelectionData',
      _icqki103.CharacterSpellSelectionRecord =>
        'CharacterSpellSelectionRecord',
      _ieudcx2k.CharacterStartingEquipmentResolutionData =>
        'CharacterStartingEquipmentResolutionData',
      _ipbr5hem.CharacterStartingEquipmentResolutionRecord =>
        'CharacterStartingEquipmentResolutionRecord',
      _ixmjb4z5.CharacterStartingEquipmentSelectionData =>
        'CharacterStartingEquipmentSelectionData',
      _ikk28htr.CharacterStartingEquipmentSelectionRecord =>
        'CharacterStartingEquipmentSelectionRecord',
      _i2rqx8lk.CharacterSyncEventRecord => 'CharacterSyncEventRecord',
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
      case _iaskjtek.CharacterAppliedChangeRecord():
        return 'CharacterAppliedChangeRecord';
      case _ijpj2a9u.CharacterArmorTrainingOverridesData():
        return 'CharacterArmorTrainingOverridesData';
      case _iykib7lv.CharacterAttackData():
        return 'CharacterAttackData';
      case _ibkyvw07.CharacterChangeData():
        return 'CharacterChangeData';
      case _iwf32wta.CharacterChoiceData():
        return 'CharacterChoiceData';
      case _i1l3jk2d.CharacterChoiceRecord():
        return 'CharacterChoiceRecord';
      case _iqjjxby6.CharacterClassEntryData():
        return 'CharacterClassEntryData';
      case _i1goyn5n.CharacterClassEntryRecord():
        return 'CharacterClassEntryRecord';
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
      case _is140f48.CharacterRecord():
        return 'CharacterRecord';
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
      case _ic0tmv5d.CharacterSkillSelectionRecord():
        return 'CharacterSkillSelectionRecord';
      case _iesndgzw.CharacterSpellSelectionData():
        return 'CharacterSpellSelectionData';
      case _icqki103.CharacterSpellSelectionRecord():
        return 'CharacterSpellSelectionRecord';
      case _ieudcx2k.CharacterStartingEquipmentResolutionData():
        return 'CharacterStartingEquipmentResolutionData';
      case _ipbr5hem.CharacterStartingEquipmentResolutionRecord():
        return 'CharacterStartingEquipmentResolutionRecord';
      case _ixmjb4z5.CharacterStartingEquipmentSelectionData():
        return 'CharacterStartingEquipmentSelectionData';
      case _ikk28htr.CharacterStartingEquipmentSelectionRecord():
        return 'CharacterStartingEquipmentSelectionRecord';
      case _i2rqx8lk.CharacterSyncEventRecord():
        return 'CharacterSyncEventRecord';
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
    className = _i1n3uhu0.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod_auth.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
    if (dataClassName == 'CharacterAppliedChangeRecord') {
      return deserialize<_iaskjtek.CharacterAppliedChangeRecord>(data['data']);
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
    if (dataClassName == 'CharacterChoiceRecord') {
      return deserialize<_i1l3jk2d.CharacterChoiceRecord>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_iqjjxby6.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryRecord') {
      return deserialize<_i1goyn5n.CharacterClassEntryRecord>(data['data']);
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
    if (dataClassName == 'CharacterRecord') {
      return deserialize<_is140f48.CharacterRecord>(data['data']);
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
    if (dataClassName == 'CharacterSkillSelectionRecord') {
      return deserialize<_ic0tmv5d.CharacterSkillSelectionRecord>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionData') {
      return deserialize<_iesndgzw.CharacterSpellSelectionData>(data['data']);
    }
    if (dataClassName == 'CharacterSpellSelectionRecord') {
      return deserialize<_icqki103.CharacterSpellSelectionRecord>(data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionData') {
      return deserialize<_ieudcx2k.CharacterStartingEquipmentResolutionData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionRecord') {
      return deserialize<_ipbr5hem.CharacterStartingEquipmentResolutionRecord>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionData') {
      return deserialize<_ixmjb4z5.CharacterStartingEquipmentSelectionData>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionRecord') {
      return deserialize<_ikk28htr.CharacterStartingEquipmentSelectionRecord>(
        data['data'],
      );
    }
    if (dataClassName == 'CharacterSyncEventRecord') {
      return deserialize<_i2rqx8lk.CharacterSyncEventRecord>(data['data']);
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
      return _i1n3uhu0.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _i1n3uhu0.Protocol().registerHostProtocol('characters_mirror', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _i1n3uhu0.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i3katqli.BackgroundData:
        return _i3katqli.BackgroundData.t;
      case _i68we1de.ClassSpellGrantData:
        return _i68we1de.ClassSpellGrantData.t;
      case _i1l5wul2.FeatData:
        return _i1l5wul2.FeatData.t;
      case _iaskjtek.CharacterAppliedChangeRecord:
        return _iaskjtek.CharacterAppliedChangeRecord.t;
      case _i1l3jk2d.CharacterChoiceRecord:
        return _i1l3jk2d.CharacterChoiceRecord.t;
      case _i1goyn5n.CharacterClassEntryRecord:
        return _i1goyn5n.CharacterClassEntryRecord.t;
      case _is140f48.CharacterRecord:
        return _is140f48.CharacterRecord.t;
      case _ic0tmv5d.CharacterSkillSelectionRecord:
        return _ic0tmv5d.CharacterSkillSelectionRecord.t;
      case _icqki103.CharacterSpellSelectionRecord:
        return _icqki103.CharacterSpellSelectionRecord.t;
      case _ipbr5hem.CharacterStartingEquipmentResolutionRecord:
        return _ipbr5hem.CharacterStartingEquipmentResolutionRecord.t;
      case _ikk28htr.CharacterStartingEquipmentSelectionRecord:
        return _ikk28htr.CharacterStartingEquipmentSelectionRecord.t;
      case _i2rqx8lk.CharacterSyncEventRecord:
        return _i2rqx8lk.CharacterSyncEventRecord.t;
      case _i3zkka4q.ChoiceGroupData:
        return _i3zkka4q.ChoiceGroupData.t;
      case _iprx2upt.ChoiceOptionData:
        return _iprx2upt.ChoiceOptionData.t;
      case _i4e8ker2.ClassData:
        return _i4e8ker2.ClassData.t;
      case _ijvqpc4v.ClassFeatureData:
        return _ijvqpc4v.ClassFeatureData.t;
      case _isxi9i4e.ClassLevelData:
        return _isxi9i4e.ClassLevelData.t;
      case _ig6b5pj2.SpellSlotProgressionData:
        return _ig6b5pj2.SpellSlotProgressionData.t;
      case _impna1yi.StartingEquipmentEntryData:
        return _impna1yi.StartingEquipmentEntryData.t;
      case _ijic8hve.SubclassData:
        return _ijic8hve.SubclassData.t;
      case _iel0dp9q.SubclassFeatureData:
        return _iel0dp9q.SubclassFeatureData.t;
      case _i0aiwhe6.FeatureDisplayPropertyData:
        return _i0aiwhe6.FeatureDisplayPropertyData.t;
      case _ilhpjxpt.FeatureModifierData:
        return _ilhpjxpt.FeatureModifierData.t;
      case _isecmqna.FeatureRelationData:
        return _isecmqna.FeatureRelationData.t;
      case _iflv344v.FeatureResourceDefinitionData:
        return _iflv344v.FeatureResourceDefinitionData.t;
      case _i86imp4g.FeatureResourceEffectData:
        return _i86imp4g.FeatureResourceEffectData.t;
      case _iafoerth.FeatureResourceProgressionValueData:
        return _iafoerth.FeatureResourceProgressionValueData.t;
      case _irh2914h.RaceData:
        return _irh2914h.RaceData.t;
      case _imnymvhh.RaceFeatureData:
        return _imnymvhh.RaceFeatureData.t;
      case _ilhjydvh.RaceFeatureSpellGrantData:
        return _ilhjydvh.RaceFeatureSpellGrantData.t;
      case _iqoglfsm.SubraceData:
        return _iqoglfsm.SubraceData.t;
      case _ivjna1ls.ToolData:
        return _ivjna1ls.ToolData.t;
      case _iv545qv3.ArmorData:
        return _iv545qv3.ArmorData.t;
      case _ibuwh0hc.ItemData:
        return _ibuwh0hc.ItemData.t;
      case _i41tgptx.MagicItemData:
        return _i41tgptx.MagicItemData.t;
      case _inpmmgks.WeaponData:
        return _inpmmgks.WeaponData.t;
      case _itvh88br.SpellData:
        return _itvh88br.SpellData.t;
      case _ipuprlj7.DmCreatureRecord:
        return _ipuprlj7.DmCreatureRecord.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
      return _i1n3uhu0.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
