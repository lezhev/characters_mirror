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
import 'data/general/race/race_data.dart' as _i2;
import 'data/background_data.dart' as _i3;
import 'data/feat_data.dart' as _i4;
import 'data/general/character/character_attack_data.dart' as _i5;
import 'data/general/character/character_choice_data.dart' as _i6;
import 'data/general/character/character_class_entry_data.dart' as _i7;
import 'data/general/character/character_data.dart' as _i8;
import 'data/general/character/character_derived_data.dart' as _i9;
import 'data/general/character/character_feature_override_data.dart' as _i10;
import 'data/general/character/character_feature_view_data.dart' as _i11;
import 'data/general/character/character_starting_equipment_resolution_data.dart'
    as _i12;
import 'data/general/character/character_starting_equipment_selection_data.dart'
    as _i13;
import 'data/general/class/class_choice_group_data.dart' as _i14;
import 'data/general/class/class_choice_option_data.dart' as _i15;
import 'data/general/class/class_data.dart' as _i16;
import 'data/general/class/class_feature_data.dart' as _i17;
import 'data/general/class/class_level_data.dart' as _i18;
import 'data/general/class/starting_equipment_block_data.dart' as _i19;
import 'data/general/class/starting_equipment_line_data.dart' as _i20;
import 'data/general/class/starting_equipment_option_data.dart' as _i21;
import 'data/general/class/subclass_data.dart' as _i22;
import 'data/general/class/subclass_feature_data.dart' as _i23;
import 'data/general/race/race_choice_option_data.dart' as _i24;
import 'data/general/race/race_choice_set_data.dart' as _i25;
import 'auth/auth_action_result.dart' as _i26;
import 'data/general/race/race_feature_data.dart' as _i27;
import 'data/general/race/race_feature_spell_grant_data.dart' as _i28;
import 'data/general/race/subrace_data.dart' as _i29;
import 'data/items/armor_data.dart' as _i30;
import 'data/items/item_data.dart' as _i31;
import 'data/items/magic_item_data.dart' as _i32;
import 'data/items/weapon_data.dart' as _i33;
import 'data/spell_class_availability_data.dart' as _i34;
import 'data/spell_data.dart' as _i35;
import 'data/spell_scaling_data.dart' as _i36;
import 'enums/ability.dart' as _i37;
import 'enums/armor_category.dart' as _i38;
import 'enums/character_alignment.dart' as _i39;
import 'enums/character_feature_source_type.dart' as _i40;
import 'enums/choice_source_type.dart' as _i41;
import 'enums/class_choice_type.dart' as _i42;
import 'enums/creature_size.dart' as _i43;
import 'enums/damage_type.dart' as _i44;
import 'enums/equipment_catalog_type.dart' as _i45;
import 'enums/feature_tag.dart' as _i46;
import 'enums/hit_point_mode.dart' as _i47;
import 'views/starting_equipment_option_view.dart' as _i48;
import 'enums/race_choice_kind.dart' as _i49;
import 'enums/rest_type.dart' as _i50;
import 'enums/sense_type.dart' as _i51;
import 'enums/skill.dart' as _i52;
import 'enums/spell/area_of_effect_type.dart' as _i53;
import 'enums/spell/condition_type.dart' as _i54;
import 'enums/spell/spell_attack_type.dart' as _i55;
import 'enums/spell/spell_duration_type.dart' as _i56;
import 'enums/spell/spell_scaling_mode.dart' as _i57;
import 'enums/spell/spell_school.dart' as _i58;
import 'enums/spell/spell_target_type.dart' as _i59;
import 'enums/spellcasting_progression.dart' as _i60;
import 'enums/starting_equipment_block_kind.dart' as _i61;
import 'enums/starting_equipment_line_kind.dart' as _i62;
import 'enums/weapon_category.dart' as _i63;
import 'views/background_step_view.dart' as _i64;
import 'views/character_equipment_entry_view.dart' as _i65;
import 'views/class_choice_group_view.dart' as _i66;
import 'views/class_step_subclass_choice_view.dart' as _i67;
import 'views/class_step_view.dart' as _i68;
import 'views/proficiency_bundle_view.dart' as _i69;
import 'views/race_step_view.dart' as _i70;
import 'views/starting_equipment_block_view.dart' as _i71;
import 'enums/language.dart' as _i72;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i73;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i74;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i75;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i76;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i77;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i78;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _i79;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i80;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_group_data.dart'
    as _i81;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_option_data.dart'
    as _i82;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i83;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i84;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i85;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i86;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_choice_set_data.dart'
    as _i87;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_choice_option_data.dart'
    as _i88;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i89;
import 'package:characters_mirror_client/src/protocol/data/general/class/starting_equipment_block_data.dart'
    as _i90;
import 'package:characters_mirror_client/src/protocol/data/general/class/starting_equipment_option_data.dart'
    as _i91;
import 'package:characters_mirror_client/src/protocol/data/general/class/starting_equipment_line_data.dart'
    as _i92;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i93;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i94;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i95;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i96;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i97;
export 'auth/auth_action_result.dart';
export 'data/background_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_attack_data.dart';
export 'data/general/character/character_choice_data.dart';
export 'data/general/character/character_class_entry_data.dart';
export 'data/general/character/character_data.dart';
export 'data/general/character/character_derived_data.dart';
export 'data/general/character/character_feature_override_data.dart';
export 'data/general/character/character_feature_view_data.dart';
export 'data/general/character/character_starting_equipment_resolution_data.dart';
export 'data/general/character/character_starting_equipment_selection_data.dart';
export 'data/general/class/class_choice_group_data.dart';
export 'data/general/class/class_choice_option_data.dart';
export 'data/general/class/class_data.dart';
export 'data/general/class/class_feature_data.dart';
export 'data/general/class/class_level_data.dart';
export 'data/general/class/starting_equipment_block_data.dart';
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
export 'enums/character_feature_source_type.dart';
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
export 'enums/starting_equipment_line_kind.dart';
export 'enums/weapon_category.dart';
export 'views/background_step_view.dart';
export 'views/character_equipment_entry_view.dart';
export 'views/class_choice_group_view.dart';
export 'views/class_step_subclass_choice_view.dart';
export 'views/class_step_view.dart';
export 'views/proficiency_bundle_view.dart';
export 'views/race_step_view.dart';
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
    if (t == _i2.RaceData) {
      return _i2.RaceData.fromJson(data) as T;
    }
    if (t == _i3.BackgroundData) {
      return _i3.BackgroundData.fromJson(data) as T;
    }
    if (t == _i4.FeatData) {
      return _i4.FeatData.fromJson(data) as T;
    }
    if (t == _i5.CharacterAttackData) {
      return _i5.CharacterAttackData.fromJson(data) as T;
    }
    if (t == _i6.CharacterChoiceData) {
      return _i6.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i7.CharacterClassEntryData) {
      return _i7.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i8.CharacterData) {
      return _i8.CharacterData.fromJson(data) as T;
    }
    if (t == _i9.CharacterDerivedData) {
      return _i9.CharacterDerivedData.fromJson(data) as T;
    }
    if (t == _i10.CharacterFeatureOverrideData) {
      return _i10.CharacterFeatureOverrideData.fromJson(data) as T;
    }
    if (t == _i11.CharacterFeatureViewData) {
      return _i11.CharacterFeatureViewData.fromJson(data) as T;
    }
    if (t == _i12.CharacterStartingEquipmentResolutionData) {
      return _i12.CharacterStartingEquipmentResolutionData.fromJson(data) as T;
    }
    if (t == _i13.CharacterStartingEquipmentSelectionData) {
      return _i13.CharacterStartingEquipmentSelectionData.fromJson(data) as T;
    }
    if (t == _i14.ClassChoiceGroupData) {
      return _i14.ClassChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i15.ClassChoiceOptionData) {
      return _i15.ClassChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i16.ClassData) {
      return _i16.ClassData.fromJson(data) as T;
    }
    if (t == _i17.ClassFeatureData) {
      return _i17.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i18.ClassLevelData) {
      return _i18.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i19.StartingEquipmentBlockData) {
      return _i19.StartingEquipmentBlockData.fromJson(data) as T;
    }
    if (t == _i20.StartingEquipmentLineData) {
      return _i20.StartingEquipmentLineData.fromJson(data) as T;
    }
    if (t == _i21.StartingEquipmentOptionData) {
      return _i21.StartingEquipmentOptionData.fromJson(data) as T;
    }
    if (t == _i22.SubclassData) {
      return _i22.SubclassData.fromJson(data) as T;
    }
    if (t == _i23.SubclassFeatureData) {
      return _i23.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i24.RaceChoiceOptionData) {
      return _i24.RaceChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i25.RaceChoiceSetData) {
      return _i25.RaceChoiceSetData.fromJson(data) as T;
    }
    if (t == _i26.AuthActionResult) {
      return _i26.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i27.RaceFeatureData) {
      return _i27.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i28.RaceFeatureSpellGrantData) {
      return _i28.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _i29.SubraceData) {
      return _i29.SubraceData.fromJson(data) as T;
    }
    if (t == _i30.ArmorData) {
      return _i30.ArmorData.fromJson(data) as T;
    }
    if (t == _i31.ItemData) {
      return _i31.ItemData.fromJson(data) as T;
    }
    if (t == _i32.MagicItemData) {
      return _i32.MagicItemData.fromJson(data) as T;
    }
    if (t == _i33.WeaponData) {
      return _i33.WeaponData.fromJson(data) as T;
    }
    if (t == _i34.SpellClassAvailabilityData) {
      return _i34.SpellClassAvailabilityData.fromJson(data) as T;
    }
    if (t == _i35.SpellData) {
      return _i35.SpellData.fromJson(data) as T;
    }
    if (t == _i36.SpellScalingData) {
      return _i36.SpellScalingData.fromJson(data) as T;
    }
    if (t == _i37.Ability) {
      return _i37.Ability.fromJson(data) as T;
    }
    if (t == _i38.ArmorCategory) {
      return _i38.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i39.CharacterAlignment) {
      return _i39.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i40.CharacterFeatureSourceType) {
      return _i40.CharacterFeatureSourceType.fromJson(data) as T;
    }
    if (t == _i41.ChoiceSourceType) {
      return _i41.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i42.ClassChoiceType) {
      return _i42.ClassChoiceType.fromJson(data) as T;
    }
    if (t == _i43.CreatureSize) {
      return _i43.CreatureSize.fromJson(data) as T;
    }
    if (t == _i44.DamageType) {
      return _i44.DamageType.fromJson(data) as T;
    }
    if (t == _i45.EquipmentCatalogType) {
      return _i45.EquipmentCatalogType.fromJson(data) as T;
    }
    if (t == _i46.FeatureTag) {
      return _i46.FeatureTag.fromJson(data) as T;
    }
    if (t == _i47.HitPointMode) {
      return _i47.HitPointMode.fromJson(data) as T;
    }
    if (t == _i48.StartingEquipmentOptionView) {
      return _i48.StartingEquipmentOptionView.fromJson(data) as T;
    }
    if (t == _i49.RaceChoiceKind) {
      return _i49.RaceChoiceKind.fromJson(data) as T;
    }
    if (t == _i50.RestType) {
      return _i50.RestType.fromJson(data) as T;
    }
    if (t == _i51.SenseType) {
      return _i51.SenseType.fromJson(data) as T;
    }
    if (t == _i52.Skill) {
      return _i52.Skill.fromJson(data) as T;
    }
    if (t == _i53.AreaOfEffectType) {
      return _i53.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _i54.ConditionType) {
      return _i54.ConditionType.fromJson(data) as T;
    }
    if (t == _i55.SpellAttackType) {
      return _i55.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i56.SpellDurationType) {
      return _i56.SpellDurationType.fromJson(data) as T;
    }
    if (t == _i57.SpellScalingMode) {
      return _i57.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _i58.SpellSchool) {
      return _i58.SpellSchool.fromJson(data) as T;
    }
    if (t == _i59.SpellTargetType) {
      return _i59.SpellTargetType.fromJson(data) as T;
    }
    if (t == _i60.SpellcastingProgression) {
      return _i60.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i61.StartingEquipmentBlockKind) {
      return _i61.StartingEquipmentBlockKind.fromJson(data) as T;
    }
    if (t == _i62.StartingEquipmentLineKind) {
      return _i62.StartingEquipmentLineKind.fromJson(data) as T;
    }
    if (t == _i63.WeaponCategory) {
      return _i63.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i64.BackgroundStepView) {
      return _i64.BackgroundStepView.fromJson(data) as T;
    }
    if (t == _i65.CharacterEquipmentEntryView) {
      return _i65.CharacterEquipmentEntryView.fromJson(data) as T;
    }
    if (t == _i66.ClassChoiceGroupView) {
      return _i66.ClassChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i67.ClassStepSubclassChoiceView) {
      return _i67.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i68.ClassStepView) {
      return _i68.ClassStepView.fromJson(data) as T;
    }
    if (t == _i69.ProficiencyBundleView) {
      return _i69.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i70.RaceStepView) {
      return _i70.RaceStepView.fromJson(data) as T;
    }
    if (t == _i71.StartingEquipmentBlockView) {
      return _i71.StartingEquipmentBlockView.fromJson(data) as T;
    }
    if (t == _i72.Language) {
      return _i72.Language.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.RaceData?>()) {
      return (data != null ? _i2.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BackgroundData?>()) {
      return (data != null ? _i3.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.FeatData?>()) {
      return (data != null ? _i4.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CharacterAttackData?>()) {
      return (data != null ? _i5.CharacterAttackData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.CharacterChoiceData?>()) {
      return (data != null ? _i6.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.CharacterClassEntryData?>()) {
      return (data != null ? _i7.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.CharacterData?>()) {
      return (data != null ? _i8.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.CharacterDerivedData?>()) {
      return (data != null ? _i9.CharacterDerivedData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.CharacterFeatureOverrideData?>()) {
      return (data != null
          ? _i10.CharacterFeatureOverrideData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i11.CharacterFeatureViewData?>()) {
      return (data != null
          ? _i11.CharacterFeatureViewData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i12.CharacterStartingEquipmentResolutionData?>()) {
      return (data != null
          ? _i12.CharacterStartingEquipmentResolutionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i13.CharacterStartingEquipmentSelectionData?>()) {
      return (data != null
          ? _i13.CharacterStartingEquipmentSelectionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i14.ClassChoiceGroupData?>()) {
      return (data != null ? _i14.ClassChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.ClassChoiceOptionData?>()) {
      return (data != null ? _i15.ClassChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.ClassData?>()) {
      return (data != null ? _i16.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.ClassFeatureData?>()) {
      return (data != null ? _i17.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ClassLevelData?>()) {
      return (data != null ? _i18.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.StartingEquipmentBlockData?>()) {
      return (data != null
          ? _i19.StartingEquipmentBlockData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i20.StartingEquipmentLineData?>()) {
      return (data != null
          ? _i20.StartingEquipmentLineData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i21.StartingEquipmentOptionData?>()) {
      return (data != null
          ? _i21.StartingEquipmentOptionData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i22.SubclassData?>()) {
      return (data != null ? _i22.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SubclassFeatureData?>()) {
      return (data != null ? _i23.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.RaceChoiceOptionData?>()) {
      return (data != null ? _i24.RaceChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.RaceChoiceSetData?>()) {
      return (data != null ? _i25.RaceChoiceSetData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.AuthActionResult?>()) {
      return (data != null ? _i26.AuthActionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.RaceFeatureData?>()) {
      return (data != null ? _i27.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.RaceFeatureSpellGrantData?>()) {
      return (data != null
          ? _i28.RaceFeatureSpellGrantData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i29.SubraceData?>()) {
      return (data != null ? _i29.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ArmorData?>()) {
      return (data != null ? _i30.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.ItemData?>()) {
      return (data != null ? _i31.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.MagicItemData?>()) {
      return (data != null ? _i32.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.WeaponData?>()) {
      return (data != null ? _i33.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.SpellClassAvailabilityData?>()) {
      return (data != null
          ? _i34.SpellClassAvailabilityData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i35.SpellData?>()) {
      return (data != null ? _i35.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SpellScalingData?>()) {
      return (data != null ? _i36.SpellScalingData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.Ability?>()) {
      return (data != null ? _i37.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.ArmorCategory?>()) {
      return (data != null ? _i38.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.CharacterAlignment?>()) {
      return (data != null ? _i39.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.CharacterFeatureSourceType?>()) {
      return (data != null
          ? _i40.CharacterFeatureSourceType.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i41.ChoiceSourceType?>()) {
      return (data != null ? _i41.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.ClassChoiceType?>()) {
      return (data != null ? _i42.ClassChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.CreatureSize?>()) {
      return (data != null ? _i43.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.DamageType?>()) {
      return (data != null ? _i44.DamageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.EquipmentCatalogType?>()) {
      return (data != null ? _i45.EquipmentCatalogType.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i46.FeatureTag?>()) {
      return (data != null ? _i46.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.HitPointMode?>()) {
      return (data != null ? _i47.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.StartingEquipmentOptionView?>()) {
      return (data != null
          ? _i48.StartingEquipmentOptionView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i49.RaceChoiceKind?>()) {
      return (data != null ? _i49.RaceChoiceKind.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.RestType?>()) {
      return (data != null ? _i50.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.SenseType?>()) {
      return (data != null ? _i51.SenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.Skill?>()) {
      return (data != null ? _i52.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.AreaOfEffectType?>()) {
      return (data != null ? _i53.AreaOfEffectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.ConditionType?>()) {
      return (data != null ? _i54.ConditionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i55.SpellAttackType?>()) {
      return (data != null ? _i55.SpellAttackType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.SpellDurationType?>()) {
      return (data != null ? _i56.SpellDurationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.SpellScalingMode?>()) {
      return (data != null ? _i57.SpellScalingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.SpellSchool?>()) {
      return (data != null ? _i58.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.SpellTargetType?>()) {
      return (data != null ? _i59.SpellTargetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.SpellcastingProgression?>()) {
      return (data != null ? _i60.SpellcastingProgression.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.StartingEquipmentBlockKind?>()) {
      return (data != null
          ? _i61.StartingEquipmentBlockKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i62.StartingEquipmentLineKind?>()) {
      return (data != null
          ? _i62.StartingEquipmentLineKind.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i63.WeaponCategory?>()) {
      return (data != null ? _i63.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.BackgroundStepView?>()) {
      return (data != null ? _i64.BackgroundStepView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i65.CharacterEquipmentEntryView?>()) {
      return (data != null
          ? _i65.CharacterEquipmentEntryView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i66.ClassChoiceGroupView?>()) {
      return (data != null ? _i66.ClassChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i67.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i67.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i68.ClassStepView?>()) {
      return (data != null ? _i68.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.ProficiencyBundleView?>()) {
      return (data != null ? _i69.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i70.RaceStepView?>()) {
      return (data != null ? _i70.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i71.StartingEquipmentBlockView?>()) {
      return (data != null
          ? _i71.StartingEquipmentBlockView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i72.Language?>()) {
      return (data != null ? _i72.Language.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i44.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i44.DamageType>(e)).toList()
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
    if (t == _i1.getType<List<_i27.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.RaceFeatureData>(e))
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
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i5.CharacterAttackData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.CharacterAttackData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.CharacterFeatureOverrideData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.CharacterFeatureOverrideData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i6.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i13.CharacterStartingEquipmentSelectionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i13.CharacterStartingEquipmentSelectionData>(e))
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
    if (t == _i1.getType<List<_i11.CharacterFeatureViewData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.CharacterFeatureViewData>(e))
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
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i65.CharacterEquipmentEntryView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i65.CharacterEquipmentEntryView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i44.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i44.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t ==
        _i1.getType<List<_i12.CharacterStartingEquipmentResolutionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) =>
                  deserialize<_i12.CharacterStartingEquipmentResolutionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i72.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i72.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i63.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i63.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i37.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i37.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i63.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i63.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i63.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i63.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i63.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i63.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.RaceChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i24.RaceChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i46.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i46.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i28.RaceFeatureSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i28.RaceFeatureSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.RaceChoiceSetData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.RaceChoiceSetData>(e))
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
    if (t == _i1.getType<List<_i44.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i44.DamageType>(e)).toList()
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
    if (t == _i1.getType<List<_i27.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.RaceFeatureData>(e))
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
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i54.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i54.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i34.SpellClassAvailabilityData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i34.SpellClassAvailabilityData>(e))
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
    if (t == _i1.getType<List<_i20.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i66.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i66.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i71.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i71.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i15.ClassChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i15.ClassChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i22.SubclassData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i22.SubclassData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i23.SubclassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i23.SubclassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i66.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i66.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i71.StartingEquipmentBlockView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i71.StartingEquipmentBlockView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i37.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i37.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i52.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i52.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i63.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i63.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i72.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i72.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.SubraceData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i29.SubraceData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i27.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i27.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.StartingEquipmentLineData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.StartingEquipmentLineData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i48.StartingEquipmentOptionView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i48.StartingEquipmentOptionView>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i73.UserInfo>) {
      return (data as List).map((e) => deserialize<_i73.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i74.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i74.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i75.FeatData>) {
      return (data as List).map((e) => deserialize<_i75.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i76.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i76.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i77.ClassData>) {
      return (data as List).map((e) => deserialize<_i77.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i78.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i78.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i79.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i79.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i80.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i80.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i81.ClassChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i81.ClassChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i82.ClassChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i82.ClassChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i83.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i83.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i84.RaceData>) {
      return (data as List).map((e) => deserialize<_i84.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i85.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i85.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i86.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i86.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i87.RaceChoiceSetData>) {
      return (data as List)
          .map((e) => deserialize<_i87.RaceChoiceSetData>(e))
          .toList() as T;
    }
    if (t == List<_i88.RaceChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i88.RaceChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i89.RaceFeatureSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i89.RaceFeatureSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i90.StartingEquipmentBlockData>) {
      return (data as List)
          .map((e) => deserialize<_i90.StartingEquipmentBlockData>(e))
          .toList() as T;
    }
    if (t == List<_i91.StartingEquipmentOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i91.StartingEquipmentOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i92.StartingEquipmentLineData>) {
      return (data as List)
          .map((e) => deserialize<_i92.StartingEquipmentLineData>(e))
          .toList() as T;
    }
    if (t == List<_i93.ArmorData>) {
      return (data as List).map((e) => deserialize<_i93.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i94.ItemData>) {
      return (data as List).map((e) => deserialize<_i94.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i95.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i95.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i96.WeaponData>) {
      return (data as List).map((e) => deserialize<_i96.WeaponData>(e)).toList()
          as T;
    }
    if (t == List<_i97.SpellData>) {
      return (data as List).map((e) => deserialize<_i97.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i73.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.RaceData) {
      return 'RaceData';
    }
    if (data is _i3.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i4.FeatData) {
      return 'FeatData';
    }
    if (data is _i5.CharacterAttackData) {
      return 'CharacterAttackData';
    }
    if (data is _i6.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i7.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i8.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i9.CharacterDerivedData) {
      return 'CharacterDerivedData';
    }
    if (data is _i10.CharacterFeatureOverrideData) {
      return 'CharacterFeatureOverrideData';
    }
    if (data is _i11.CharacterFeatureViewData) {
      return 'CharacterFeatureViewData';
    }
    if (data is _i12.CharacterStartingEquipmentResolutionData) {
      return 'CharacterStartingEquipmentResolutionData';
    }
    if (data is _i13.CharacterStartingEquipmentSelectionData) {
      return 'CharacterStartingEquipmentSelectionData';
    }
    if (data is _i14.ClassChoiceGroupData) {
      return 'ClassChoiceGroupData';
    }
    if (data is _i15.ClassChoiceOptionData) {
      return 'ClassChoiceOptionData';
    }
    if (data is _i16.ClassData) {
      return 'ClassData';
    }
    if (data is _i17.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i18.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i19.StartingEquipmentBlockData) {
      return 'StartingEquipmentBlockData';
    }
    if (data is _i20.StartingEquipmentLineData) {
      return 'StartingEquipmentLineData';
    }
    if (data is _i21.StartingEquipmentOptionData) {
      return 'StartingEquipmentOptionData';
    }
    if (data is _i22.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i23.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i24.RaceChoiceOptionData) {
      return 'RaceChoiceOptionData';
    }
    if (data is _i25.RaceChoiceSetData) {
      return 'RaceChoiceSetData';
    }
    if (data is _i26.AuthActionResult) {
      return 'AuthActionResult';
    }
    if (data is _i27.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i28.RaceFeatureSpellGrantData) {
      return 'RaceFeatureSpellGrantData';
    }
    if (data is _i29.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i30.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i31.ItemData) {
      return 'ItemData';
    }
    if (data is _i32.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i33.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i34.SpellClassAvailabilityData) {
      return 'SpellClassAvailabilityData';
    }
    if (data is _i35.SpellData) {
      return 'SpellData';
    }
    if (data is _i36.SpellScalingData) {
      return 'SpellScalingData';
    }
    if (data is _i37.Ability) {
      return 'Ability';
    }
    if (data is _i38.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i39.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i40.CharacterFeatureSourceType) {
      return 'CharacterFeatureSourceType';
    }
    if (data is _i41.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i42.ClassChoiceType) {
      return 'ClassChoiceType';
    }
    if (data is _i43.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i44.DamageType) {
      return 'DamageType';
    }
    if (data is _i45.EquipmentCatalogType) {
      return 'EquipmentCatalogType';
    }
    if (data is _i46.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i47.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i48.StartingEquipmentOptionView) {
      return 'StartingEquipmentOptionView';
    }
    if (data is _i49.RaceChoiceKind) {
      return 'RaceChoiceKind';
    }
    if (data is _i50.RestType) {
      return 'RestType';
    }
    if (data is _i51.SenseType) {
      return 'SenseType';
    }
    if (data is _i52.Skill) {
      return 'Skill';
    }
    if (data is _i53.AreaOfEffectType) {
      return 'AreaOfEffectType';
    }
    if (data is _i54.ConditionType) {
      return 'ConditionType';
    }
    if (data is _i55.SpellAttackType) {
      return 'SpellAttackType';
    }
    if (data is _i56.SpellDurationType) {
      return 'SpellDurationType';
    }
    if (data is _i57.SpellScalingMode) {
      return 'SpellScalingMode';
    }
    if (data is _i58.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i59.SpellTargetType) {
      return 'SpellTargetType';
    }
    if (data is _i60.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i61.StartingEquipmentBlockKind) {
      return 'StartingEquipmentBlockKind';
    }
    if (data is _i62.StartingEquipmentLineKind) {
      return 'StartingEquipmentLineKind';
    }
    if (data is _i63.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i64.BackgroundStepView) {
      return 'BackgroundStepView';
    }
    if (data is _i65.CharacterEquipmentEntryView) {
      return 'CharacterEquipmentEntryView';
    }
    if (data is _i66.ClassChoiceGroupView) {
      return 'ClassChoiceGroupView';
    }
    if (data is _i67.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i68.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i69.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i70.RaceStepView) {
      return 'RaceStepView';
    }
    if (data is _i71.StartingEquipmentBlockView) {
      return 'StartingEquipmentBlockView';
    }
    if (data is _i72.Language) {
      return 'Language';
    }
    className = _i73.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'RaceData') {
      return deserialize<_i2.RaceData>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i3.BackgroundData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i4.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterAttackData') {
      return deserialize<_i5.CharacterAttackData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i6.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i7.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i8.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterDerivedData') {
      return deserialize<_i9.CharacterDerivedData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureOverrideData') {
      return deserialize<_i10.CharacterFeatureOverrideData>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureViewData') {
      return deserialize<_i11.CharacterFeatureViewData>(data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentResolutionData') {
      return deserialize<_i12.CharacterStartingEquipmentResolutionData>(
          data['data']);
    }
    if (dataClassName == 'CharacterStartingEquipmentSelectionData') {
      return deserialize<_i13.CharacterStartingEquipmentSelectionData>(
          data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupData') {
      return deserialize<_i14.ClassChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceOptionData') {
      return deserialize<_i15.ClassChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i16.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i17.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i18.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockData') {
      return deserialize<_i19.StartingEquipmentBlockData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineData') {
      return deserialize<_i20.StartingEquipmentLineData>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionData') {
      return deserialize<_i21.StartingEquipmentOptionData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i22.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i23.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceOptionData') {
      return deserialize<_i24.RaceChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceSetData') {
      return deserialize<_i25.RaceChoiceSetData>(data['data']);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_i26.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i27.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_i28.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i29.SubraceData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i30.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i31.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i32.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i33.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellClassAvailabilityData') {
      return deserialize<_i34.SpellClassAvailabilityData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i35.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_i36.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i37.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i38.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i39.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'CharacterFeatureSourceType') {
      return deserialize<_i40.CharacterFeatureSourceType>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i41.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ClassChoiceType') {
      return deserialize<_i42.ClassChoiceType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i43.CreatureSize>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i44.DamageType>(data['data']);
    }
    if (dataClassName == 'EquipmentCatalogType') {
      return deserialize<_i45.EquipmentCatalogType>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i46.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i47.HitPointMode>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentOptionView') {
      return deserialize<_i48.StartingEquipmentOptionView>(data['data']);
    }
    if (dataClassName == 'RaceChoiceKind') {
      return deserialize<_i49.RaceChoiceKind>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i50.RestType>(data['data']);
    }
    if (dataClassName == 'SenseType') {
      return deserialize<_i51.SenseType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i52.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_i53.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_i54.ConditionType>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_i55.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i56.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_i57.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i58.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_i59.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i60.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockKind') {
      return deserialize<_i61.StartingEquipmentBlockKind>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentLineKind') {
      return deserialize<_i62.StartingEquipmentLineKind>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i63.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'BackgroundStepView') {
      return deserialize<_i64.BackgroundStepView>(data['data']);
    }
    if (dataClassName == 'CharacterEquipmentEntryView') {
      return deserialize<_i65.CharacterEquipmentEntryView>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupView') {
      return deserialize<_i66.ClassChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i67.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i68.ClassStepView>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i69.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceStepView') {
      return deserialize<_i70.RaceStepView>(data['data']);
    }
    if (dataClassName == 'StartingEquipmentBlockView') {
      return deserialize<_i71.StartingEquipmentBlockView>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i72.Language>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i73.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
