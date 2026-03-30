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
import 'data/general/race/subrace_data.dart' as _i2;
import 'data/background_data.dart' as _i3;
import 'data/feat_data.dart' as _i4;
import 'data/general/character/character_choice_data.dart' as _i5;
import 'data/general/character/character_class_entry_data.dart' as _i6;
import 'data/general/character/character_data.dart' as _i7;
import 'data/general/character/character_sheet_snapshot_data.dart' as _i8;
import 'data/general/class/class_choice_group_data.dart' as _i9;
import 'data/general/class/class_choice_option_data.dart' as _i10;
import 'data/general/class/class_data.dart' as _i11;
import 'data/general/class/class_feature_data.dart' as _i12;
import 'data/general/class/class_level_data.dart' as _i13;
import 'data/general/class/subclass_data.dart' as _i14;
import 'data/general/class/subclass_feature_data.dart' as _i15;
import 'data/general/race/race_choice_option_data.dart' as _i16;
import 'data/general/race/race_choice_set_data.dart' as _i17;
import 'data/general/race/race_data.dart' as _i18;
import 'data/general/race/race_feature_data.dart' as _i19;
import 'data/general/race/race_feature_spell_grant_data.dart' as _i20;
import 'auth/auth_action_result.dart' as _i21;
import 'data/items/armor_data.dart' as _i22;
import 'data/items/item_data.dart' as _i23;
import 'data/items/magic_item_data.dart' as _i24;
import 'data/items/weapon_data.dart' as _i25;
import 'data/spell_class_availability_data.dart' as _i26;
import 'data/spell_data.dart' as _i27;
import 'data/spell_scaling_data.dart' as _i28;
import 'enums/ability.dart' as _i29;
import 'enums/armor_category.dart' as _i30;
import 'enums/character_alignment.dart' as _i31;
import 'enums/choice_source_type.dart' as _i32;
import 'enums/class_choice_type.dart' as _i33;
import 'enums/creature_size.dart' as _i34;
import 'enums/damage_type.dart' as _i35;
import 'enums/feature_tag.dart' as _i36;
import 'enums/hit_point_mode.dart' as _i37;
import 'enums/language.dart' as _i38;
import 'views/race_step_view.dart' as _i39;
import 'enums/rest_type.dart' as _i40;
import 'enums/sense_type.dart' as _i41;
import 'enums/skill.dart' as _i42;
import 'enums/spell/area_of_effect_type.dart' as _i43;
import 'enums/spell/condition_type.dart' as _i44;
import 'enums/spell/spell_attack_type.dart' as _i45;
import 'enums/spell/spell_duration_type.dart' as _i46;
import 'enums/spell/spell_scaling_mode.dart' as _i47;
import 'enums/spell/spell_school.dart' as _i48;
import 'enums/spell/spell_target_type.dart' as _i49;
import 'enums/spellcasting_progression.dart' as _i50;
import 'enums/weapon_category.dart' as _i51;
import 'views/character_build_data.dart' as _i52;
import 'views/character_sheet_view.dart' as _i53;
import 'views/class_choice_group_view.dart' as _i54;
import 'views/class_step_subclass_choice_view.dart' as _i55;
import 'views/class_step_view.dart' as _i56;
import 'views/proficiency_bundle_view.dart' as _i57;
import 'enums/race_choice_kind.dart' as _i58;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i59;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i60;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i61;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i62;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i63;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i64;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _i65;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i66;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_group_data.dart'
    as _i67;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_option_data.dart'
    as _i68;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i69;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i70;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i71;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i72;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_choice_set_data.dart'
    as _i73;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_choice_option_data.dart'
    as _i74;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_spell_grant_data.dart'
    as _i75;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i76;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i77;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i78;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i79;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i80;
export 'auth/auth_action_result.dart';
export 'data/background_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_choice_data.dart';
export 'data/general/character/character_class_entry_data.dart';
export 'data/general/character/character_data.dart';
export 'data/general/character/character_sheet_snapshot_data.dart';
export 'data/general/class/class_choice_group_data.dart';
export 'data/general/class/class_choice_option_data.dart';
export 'data/general/class/class_data.dart';
export 'data/general/class/class_feature_data.dart';
export 'data/general/class/class_level_data.dart';
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
export 'enums/choice_source_type.dart';
export 'enums/class_choice_type.dart';
export 'enums/creature_size.dart';
export 'enums/damage_type.dart';
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
export 'enums/weapon_category.dart';
export 'views/character_build_data.dart';
export 'views/character_sheet_view.dart';
export 'views/class_choice_group_view.dart';
export 'views/class_step_subclass_choice_view.dart';
export 'views/class_step_view.dart';
export 'views/proficiency_bundle_view.dart';
export 'views/race_step_view.dart';
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
    if (t == _i2.SubraceData) {
      return _i2.SubraceData.fromJson(data) as T;
    }
    if (t == _i3.BackgroundData) {
      return _i3.BackgroundData.fromJson(data) as T;
    }
    if (t == _i4.FeatData) {
      return _i4.FeatData.fromJson(data) as T;
    }
    if (t == _i5.CharacterChoiceData) {
      return _i5.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i6.CharacterClassEntryData) {
      return _i6.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i7.CharacterData) {
      return _i7.CharacterData.fromJson(data) as T;
    }
    if (t == _i8.CharacterSheetSnapshotData) {
      return _i8.CharacterSheetSnapshotData.fromJson(data) as T;
    }
    if (t == _i9.ClassChoiceGroupData) {
      return _i9.ClassChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i10.ClassChoiceOptionData) {
      return _i10.ClassChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i11.ClassData) {
      return _i11.ClassData.fromJson(data) as T;
    }
    if (t == _i12.ClassFeatureData) {
      return _i12.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i13.ClassLevelData) {
      return _i13.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i14.SubclassData) {
      return _i14.SubclassData.fromJson(data) as T;
    }
    if (t == _i15.SubclassFeatureData) {
      return _i15.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i16.RaceChoiceOptionData) {
      return _i16.RaceChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i17.RaceChoiceSetData) {
      return _i17.RaceChoiceSetData.fromJson(data) as T;
    }
    if (t == _i18.RaceData) {
      return _i18.RaceData.fromJson(data) as T;
    }
    if (t == _i19.RaceFeatureData) {
      return _i19.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i20.RaceFeatureSpellGrantData) {
      return _i20.RaceFeatureSpellGrantData.fromJson(data) as T;
    }
    if (t == _i21.AuthActionResult) {
      return _i21.AuthActionResult.fromJson(data) as T;
    }
    if (t == _i22.ArmorData) {
      return _i22.ArmorData.fromJson(data) as T;
    }
    if (t == _i23.ItemData) {
      return _i23.ItemData.fromJson(data) as T;
    }
    if (t == _i24.MagicItemData) {
      return _i24.MagicItemData.fromJson(data) as T;
    }
    if (t == _i25.WeaponData) {
      return _i25.WeaponData.fromJson(data) as T;
    }
    if (t == _i26.SpellClassAvailabilityData) {
      return _i26.SpellClassAvailabilityData.fromJson(data) as T;
    }
    if (t == _i27.SpellData) {
      return _i27.SpellData.fromJson(data) as T;
    }
    if (t == _i28.SpellScalingData) {
      return _i28.SpellScalingData.fromJson(data) as T;
    }
    if (t == _i29.Ability) {
      return _i29.Ability.fromJson(data) as T;
    }
    if (t == _i30.ArmorCategory) {
      return _i30.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i31.CharacterAlignment) {
      return _i31.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i32.ChoiceSourceType) {
      return _i32.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i33.ClassChoiceType) {
      return _i33.ClassChoiceType.fromJson(data) as T;
    }
    if (t == _i34.CreatureSize) {
      return _i34.CreatureSize.fromJson(data) as T;
    }
    if (t == _i35.DamageType) {
      return _i35.DamageType.fromJson(data) as T;
    }
    if (t == _i36.FeatureTag) {
      return _i36.FeatureTag.fromJson(data) as T;
    }
    if (t == _i37.HitPointMode) {
      return _i37.HitPointMode.fromJson(data) as T;
    }
    if (t == _i38.Language) {
      return _i38.Language.fromJson(data) as T;
    }
    if (t == _i39.RaceStepView) {
      return _i39.RaceStepView.fromJson(data) as T;
    }
    if (t == _i40.RestType) {
      return _i40.RestType.fromJson(data) as T;
    }
    if (t == _i41.SenseType) {
      return _i41.SenseType.fromJson(data) as T;
    }
    if (t == _i42.Skill) {
      return _i42.Skill.fromJson(data) as T;
    }
    if (t == _i43.AreaOfEffectType) {
      return _i43.AreaOfEffectType.fromJson(data) as T;
    }
    if (t == _i44.ConditionType) {
      return _i44.ConditionType.fromJson(data) as T;
    }
    if (t == _i45.SpellAttackType) {
      return _i45.SpellAttackType.fromJson(data) as T;
    }
    if (t == _i46.SpellDurationType) {
      return _i46.SpellDurationType.fromJson(data) as T;
    }
    if (t == _i47.SpellScalingMode) {
      return _i47.SpellScalingMode.fromJson(data) as T;
    }
    if (t == _i48.SpellSchool) {
      return _i48.SpellSchool.fromJson(data) as T;
    }
    if (t == _i49.SpellTargetType) {
      return _i49.SpellTargetType.fromJson(data) as T;
    }
    if (t == _i50.SpellcastingProgression) {
      return _i50.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i51.WeaponCategory) {
      return _i51.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i52.CharacterBuildData) {
      return _i52.CharacterBuildData.fromJson(data) as T;
    }
    if (t == _i53.CharacterSheetView) {
      return _i53.CharacterSheetView.fromJson(data) as T;
    }
    if (t == _i54.ClassChoiceGroupView) {
      return _i54.ClassChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i55.ClassStepSubclassChoiceView) {
      return _i55.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i56.ClassStepView) {
      return _i56.ClassStepView.fromJson(data) as T;
    }
    if (t == _i57.ProficiencyBundleView) {
      return _i57.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i58.RaceChoiceKind) {
      return _i58.RaceChoiceKind.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.SubraceData?>()) {
      return (data != null ? _i2.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.BackgroundData?>()) {
      return (data != null ? _i3.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.FeatData?>()) {
      return (data != null ? _i4.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.CharacterChoiceData?>()) {
      return (data != null ? _i5.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.CharacterClassEntryData?>()) {
      return (data != null ? _i6.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.CharacterData?>()) {
      return (data != null ? _i7.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.CharacterSheetSnapshotData?>()) {
      return (data != null
          ? _i8.CharacterSheetSnapshotData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i9.ClassChoiceGroupData?>()) {
      return (data != null ? _i9.ClassChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ClassChoiceOptionData?>()) {
      return (data != null ? _i10.ClassChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.ClassData?>()) {
      return (data != null ? _i11.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ClassFeatureData?>()) {
      return (data != null ? _i12.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ClassLevelData?>()) {
      return (data != null ? _i13.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SubclassData?>()) {
      return (data != null ? _i14.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SubclassFeatureData?>()) {
      return (data != null ? _i15.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.RaceChoiceOptionData?>()) {
      return (data != null ? _i16.RaceChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.RaceChoiceSetData?>()) {
      return (data != null ? _i17.RaceChoiceSetData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.RaceData?>()) {
      return (data != null ? _i18.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.RaceFeatureData?>()) {
      return (data != null ? _i19.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.RaceFeatureSpellGrantData?>()) {
      return (data != null
          ? _i20.RaceFeatureSpellGrantData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i21.AuthActionResult?>()) {
      return (data != null ? _i21.AuthActionResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.ArmorData?>()) {
      return (data != null ? _i22.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.ItemData?>()) {
      return (data != null ? _i23.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.MagicItemData?>()) {
      return (data != null ? _i24.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.WeaponData?>()) {
      return (data != null ? _i25.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SpellClassAvailabilityData?>()) {
      return (data != null
          ? _i26.SpellClassAvailabilityData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i27.SpellData?>()) {
      return (data != null ? _i27.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.SpellScalingData?>()) {
      return (data != null ? _i28.SpellScalingData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.Ability?>()) {
      return (data != null ? _i29.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ArmorCategory?>()) {
      return (data != null ? _i30.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CharacterAlignment?>()) {
      return (data != null ? _i31.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.ChoiceSourceType?>()) {
      return (data != null ? _i32.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.ClassChoiceType?>()) {
      return (data != null ? _i33.ClassChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.CreatureSize?>()) {
      return (data != null ? _i34.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.DamageType?>()) {
      return (data != null ? _i35.DamageType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.FeatureTag?>()) {
      return (data != null ? _i36.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.HitPointMode?>()) {
      return (data != null ? _i37.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.Language?>()) {
      return (data != null ? _i38.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.RaceStepView?>()) {
      return (data != null ? _i39.RaceStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.RestType?>()) {
      return (data != null ? _i40.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.SenseType?>()) {
      return (data != null ? _i41.SenseType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.Skill?>()) {
      return (data != null ? _i42.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.AreaOfEffectType?>()) {
      return (data != null ? _i43.AreaOfEffectType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.ConditionType?>()) {
      return (data != null ? _i44.ConditionType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.SpellAttackType?>()) {
      return (data != null ? _i45.SpellAttackType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.SpellDurationType?>()) {
      return (data != null ? _i46.SpellDurationType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.SpellScalingMode?>()) {
      return (data != null ? _i47.SpellScalingMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.SpellSchool?>()) {
      return (data != null ? _i48.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.SpellTargetType?>()) {
      return (data != null ? _i49.SpellTargetType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.SpellcastingProgression?>()) {
      return (data != null ? _i50.SpellcastingProgression.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.WeaponCategory?>()) {
      return (data != null ? _i51.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.CharacterBuildData?>()) {
      return (data != null ? _i52.CharacterBuildData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i53.CharacterSheetView?>()) {
      return (data != null ? _i53.CharacterSheetView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.ClassChoiceGroupView?>()) {
      return (data != null ? _i54.ClassChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i55.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i56.ClassStepView?>()) {
      return (data != null ? _i56.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.ProficiencyBundleView?>()) {
      return (data != null ? _i57.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i58.RaceChoiceKind?>()) {
      return (data != null ? _i58.RaceChoiceKind.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i35.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.DamageType>(e)).toList()
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
    if (t == _i1.getType<List<_i19.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.RaceFeatureData>(e))
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
    if (t == _i1.getType<List<_i36.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i36.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i35.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i42.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i36.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i36.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i29.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i29.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i42.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i36.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i36.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i36.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.RaceChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i16.RaceChoiceOptionData>(e))
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
    if (t == _i1.getType<List<_i35.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.DamageType>(e)).toList()
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
    if (t == _i1.getType<List<_i19.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i36.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i36.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.RaceFeatureSpellGrantData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i20.RaceFeatureSpellGrantData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.RaceChoiceSetData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i17.RaceChoiceSetData>(e))
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
    if (t == _i1.getType<List<_i44.ConditionType>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i44.ConditionType>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i26.SpellClassAvailabilityData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i26.SpellClassAvailabilityData>(e))
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
    if (t == _i1.getType<List<_i2.SubraceData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i2.SubraceData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.RaceFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i19.RaceFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i6.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i6.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i10.ClassChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i10.ClassChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i14.SubclassData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.SubclassData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i54.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i54.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i29.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i29.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i42.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i42.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i30.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i30.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i51.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i51.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i38.Language>(e)).toList()
          : null) as T;
    }
    if (t == List<_i59.UserInfo>) {
      return (data as List).map((e) => deserialize<_i59.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i60.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i60.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i61.FeatData>) {
      return (data as List).map((e) => deserialize<_i61.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i62.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i62.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i63.ClassData>) {
      return (data as List).map((e) => deserialize<_i63.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i64.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i64.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i65.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i65.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i66.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i66.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i67.ClassChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i67.ClassChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i68.ClassChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i68.ClassChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i69.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i69.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i70.RaceData>) {
      return (data as List).map((e) => deserialize<_i70.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i71.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i71.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i72.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i72.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i73.RaceChoiceSetData>) {
      return (data as List)
          .map((e) => deserialize<_i73.RaceChoiceSetData>(e))
          .toList() as T;
    }
    if (t == List<_i74.RaceChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i74.RaceChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i75.RaceFeatureSpellGrantData>) {
      return (data as List)
          .map((e) => deserialize<_i75.RaceFeatureSpellGrantData>(e))
          .toList() as T;
    }
    if (t == List<_i76.ArmorData>) {
      return (data as List).map((e) => deserialize<_i76.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i77.ItemData>) {
      return (data as List).map((e) => deserialize<_i77.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i78.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i78.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i79.WeaponData>) {
      return (data as List).map((e) => deserialize<_i79.WeaponData>(e)).toList()
          as T;
    }
    if (t == List<_i80.SpellData>) {
      return (data as List).map((e) => deserialize<_i80.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i59.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i3.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i4.FeatData) {
      return 'FeatData';
    }
    if (data is _i5.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i6.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i7.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i8.CharacterSheetSnapshotData) {
      return 'CharacterSheetSnapshotData';
    }
    if (data is _i9.ClassChoiceGroupData) {
      return 'ClassChoiceGroupData';
    }
    if (data is _i10.ClassChoiceOptionData) {
      return 'ClassChoiceOptionData';
    }
    if (data is _i11.ClassData) {
      return 'ClassData';
    }
    if (data is _i12.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i13.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i14.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i15.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i16.RaceChoiceOptionData) {
      return 'RaceChoiceOptionData';
    }
    if (data is _i17.RaceChoiceSetData) {
      return 'RaceChoiceSetData';
    }
    if (data is _i18.RaceData) {
      return 'RaceData';
    }
    if (data is _i19.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i20.RaceFeatureSpellGrantData) {
      return 'RaceFeatureSpellGrantData';
    }
    if (data is _i21.AuthActionResult) {
      return 'AuthActionResult';
    }
    if (data is _i22.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i23.ItemData) {
      return 'ItemData';
    }
    if (data is _i24.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i25.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i26.SpellClassAvailabilityData) {
      return 'SpellClassAvailabilityData';
    }
    if (data is _i27.SpellData) {
      return 'SpellData';
    }
    if (data is _i28.SpellScalingData) {
      return 'SpellScalingData';
    }
    if (data is _i29.Ability) {
      return 'Ability';
    }
    if (data is _i30.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i31.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i32.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i33.ClassChoiceType) {
      return 'ClassChoiceType';
    }
    if (data is _i34.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i35.DamageType) {
      return 'DamageType';
    }
    if (data is _i36.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i37.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i38.Language) {
      return 'Language';
    }
    if (data is _i39.RaceStepView) {
      return 'RaceStepView';
    }
    if (data is _i40.RestType) {
      return 'RestType';
    }
    if (data is _i41.SenseType) {
      return 'SenseType';
    }
    if (data is _i42.Skill) {
      return 'Skill';
    }
    if (data is _i43.AreaOfEffectType) {
      return 'AreaOfEffectType';
    }
    if (data is _i44.ConditionType) {
      return 'ConditionType';
    }
    if (data is _i45.SpellAttackType) {
      return 'SpellAttackType';
    }
    if (data is _i46.SpellDurationType) {
      return 'SpellDurationType';
    }
    if (data is _i47.SpellScalingMode) {
      return 'SpellScalingMode';
    }
    if (data is _i48.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i49.SpellTargetType) {
      return 'SpellTargetType';
    }
    if (data is _i50.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i51.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i52.CharacterBuildData) {
      return 'CharacterBuildData';
    }
    if (data is _i53.CharacterSheetView) {
      return 'CharacterSheetView';
    }
    if (data is _i54.ClassChoiceGroupView) {
      return 'ClassChoiceGroupView';
    }
    if (data is _i55.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i56.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i57.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i58.RaceChoiceKind) {
      return 'RaceChoiceKind';
    }
    className = _i59.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'SubraceData') {
      return deserialize<_i2.SubraceData>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i3.BackgroundData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i4.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i5.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i6.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i7.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterSheetSnapshotData') {
      return deserialize<_i8.CharacterSheetSnapshotData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupData') {
      return deserialize<_i9.ClassChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceOptionData') {
      return deserialize<_i10.ClassChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i11.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i12.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i13.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i14.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i15.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceOptionData') {
      return deserialize<_i16.RaceChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'RaceChoiceSetData') {
      return deserialize<_i17.RaceChoiceSetData>(data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i18.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i19.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureSpellGrantData') {
      return deserialize<_i20.RaceFeatureSpellGrantData>(data['data']);
    }
    if (dataClassName == 'AuthActionResult') {
      return deserialize<_i21.AuthActionResult>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i22.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i23.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i24.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i25.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellClassAvailabilityData') {
      return deserialize<_i26.SpellClassAvailabilityData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i27.SpellData>(data['data']);
    }
    if (dataClassName == 'SpellScalingData') {
      return deserialize<_i28.SpellScalingData>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i29.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i30.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i31.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i32.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ClassChoiceType') {
      return deserialize<_i33.ClassChoiceType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i34.CreatureSize>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i35.DamageType>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i36.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i37.HitPointMode>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i38.Language>(data['data']);
    }
    if (dataClassName == 'RaceStepView') {
      return deserialize<_i39.RaceStepView>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i40.RestType>(data['data']);
    }
    if (dataClassName == 'SenseType') {
      return deserialize<_i41.SenseType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i42.Skill>(data['data']);
    }
    if (dataClassName == 'AreaOfEffectType') {
      return deserialize<_i43.AreaOfEffectType>(data['data']);
    }
    if (dataClassName == 'ConditionType') {
      return deserialize<_i44.ConditionType>(data['data']);
    }
    if (dataClassName == 'SpellAttackType') {
      return deserialize<_i45.SpellAttackType>(data['data']);
    }
    if (dataClassName == 'SpellDurationType') {
      return deserialize<_i46.SpellDurationType>(data['data']);
    }
    if (dataClassName == 'SpellScalingMode') {
      return deserialize<_i47.SpellScalingMode>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i48.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellTargetType') {
      return deserialize<_i49.SpellTargetType>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i50.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i51.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'CharacterBuildData') {
      return deserialize<_i52.CharacterBuildData>(data['data']);
    }
    if (dataClassName == 'CharacterSheetView') {
      return deserialize<_i53.CharacterSheetView>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupView') {
      return deserialize<_i54.ClassChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i55.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i56.ClassStepView>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i57.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'RaceChoiceKind') {
      return deserialize<_i58.RaceChoiceKind>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i59.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
