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
import 'data/feat_data.dart' as _i3;
import 'data/general/character/character_choice_data.dart' as _i4;
import 'data/general/character/character_class_entry_data.dart' as _i5;
import 'data/general/character/character_data.dart' as _i6;
import 'data/general/character/character_sheet_snapshot_data.dart' as _i7;
import 'data/general/class/class_choice_group_data.dart' as _i8;
import 'data/general/class/class_choice_option_data.dart' as _i9;
import 'data/general/class/class_data.dart' as _i10;
import 'data/general/class/class_feature_data.dart' as _i11;
import 'data/general/class/class_level_data.dart' as _i12;
import 'data/general/class/subclass_data.dart' as _i13;
import 'data/general/class/subclass_feature_data.dart' as _i14;
import 'data/general/race/dragonborn_ancestry_data.dart' as _i15;
import 'data/background_data.dart' as _i16;
import 'data/general/race/race_feature_data.dart' as _i17;
import 'data/general/race/subrace_data.dart' as _i18;
import 'data/items/armor_data.dart' as _i19;
import 'data/items/item_data.dart' as _i20;
import 'data/items/magic_item_data.dart' as _i21;
import 'data/items/weapon_data.dart' as _i22;
import 'data/spell_data.dart' as _i23;
import 'enums/ability.dart' as _i24;
import 'enums/armor_category.dart' as _i25;
import 'enums/character_alignment.dart' as _i26;
import 'enums/choice_source_type.dart' as _i27;
import 'enums/class_choice_type.dart' as _i28;
import 'enums/creature_size.dart' as _i29;
import 'views/proficiency_bundle_view.dart' as _i30;
import 'enums/feature_tag.dart' as _i31;
import 'enums/hit_point_mode.dart' as _i32;
import 'enums/language.dart' as _i33;
import 'enums/rest_type.dart' as _i34;
import 'enums/skill.dart' as _i35;
import 'enums/spell_school.dart' as _i36;
import 'enums/spellcasting_progression.dart' as _i37;
import 'enums/weapon_category.dart' as _i38;
import 'views/character_build_data.dart' as _i39;
import 'views/character_sheet_view.dart' as _i40;
import 'views/class_choice_group_view.dart' as _i41;
import 'views/class_step_subclass_choice_view.dart' as _i42;
import 'views/class_step_view.dart' as _i43;
import 'enums/damage_type.dart' as _i44;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i45;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i46;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i47;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i48;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i49;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i50;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_level_data.dart'
    as _i51;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i52;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_group_data.dart'
    as _i53;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_choice_option_data.dart'
    as _i54;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i55;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i56;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i57;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i58;
import 'package:characters_mirror_client/src/protocol/data/general/race/dragonborn_ancestry_data.dart'
    as _i59;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i60;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i61;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i62;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i63;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i64;
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
export 'data/general/race/dragonborn_ancestry_data.dart';
export 'data/general/race/race_data.dart';
export 'data/general/race/race_feature_data.dart';
export 'data/general/race/subrace_data.dart';
export 'data/items/armor_data.dart';
export 'data/items/item_data.dart';
export 'data/items/magic_item_data.dart';
export 'data/items/weapon_data.dart';
export 'data/spell_data.dart';
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
export 'enums/rest_type.dart';
export 'enums/skill.dart';
export 'enums/spell_school.dart';
export 'enums/spellcasting_progression.dart';
export 'enums/weapon_category.dart';
export 'views/character_build_data.dart';
export 'views/character_sheet_view.dart';
export 'views/class_choice_group_view.dart';
export 'views/class_step_subclass_choice_view.dart';
export 'views/class_step_view.dart';
export 'views/proficiency_bundle_view.dart';
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
    if (t == _i3.FeatData) {
      return _i3.FeatData.fromJson(data) as T;
    }
    if (t == _i4.CharacterChoiceData) {
      return _i4.CharacterChoiceData.fromJson(data) as T;
    }
    if (t == _i5.CharacterClassEntryData) {
      return _i5.CharacterClassEntryData.fromJson(data) as T;
    }
    if (t == _i6.CharacterData) {
      return _i6.CharacterData.fromJson(data) as T;
    }
    if (t == _i7.CharacterSheetSnapshotData) {
      return _i7.CharacterSheetSnapshotData.fromJson(data) as T;
    }
    if (t == _i8.ClassChoiceGroupData) {
      return _i8.ClassChoiceGroupData.fromJson(data) as T;
    }
    if (t == _i9.ClassChoiceOptionData) {
      return _i9.ClassChoiceOptionData.fromJson(data) as T;
    }
    if (t == _i10.ClassData) {
      return _i10.ClassData.fromJson(data) as T;
    }
    if (t == _i11.ClassFeatureData) {
      return _i11.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i12.ClassLevelData) {
      return _i12.ClassLevelData.fromJson(data) as T;
    }
    if (t == _i13.SubclassData) {
      return _i13.SubclassData.fromJson(data) as T;
    }
    if (t == _i14.SubclassFeatureData) {
      return _i14.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i15.DragonbornAncestryData) {
      return _i15.DragonbornAncestryData.fromJson(data) as T;
    }
    if (t == _i16.BackgroundData) {
      return _i16.BackgroundData.fromJson(data) as T;
    }
    if (t == _i17.RaceFeatureData) {
      return _i17.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i18.SubraceData) {
      return _i18.SubraceData.fromJson(data) as T;
    }
    if (t == _i19.ArmorData) {
      return _i19.ArmorData.fromJson(data) as T;
    }
    if (t == _i20.ItemData) {
      return _i20.ItemData.fromJson(data) as T;
    }
    if (t == _i21.MagicItemData) {
      return _i21.MagicItemData.fromJson(data) as T;
    }
    if (t == _i22.WeaponData) {
      return _i22.WeaponData.fromJson(data) as T;
    }
    if (t == _i23.SpellData) {
      return _i23.SpellData.fromJson(data) as T;
    }
    if (t == _i24.Ability) {
      return _i24.Ability.fromJson(data) as T;
    }
    if (t == _i25.ArmorCategory) {
      return _i25.ArmorCategory.fromJson(data) as T;
    }
    if (t == _i26.CharacterAlignment) {
      return _i26.CharacterAlignment.fromJson(data) as T;
    }
    if (t == _i27.ChoiceSourceType) {
      return _i27.ChoiceSourceType.fromJson(data) as T;
    }
    if (t == _i28.ClassChoiceType) {
      return _i28.ClassChoiceType.fromJson(data) as T;
    }
    if (t == _i29.CreatureSize) {
      return _i29.CreatureSize.fromJson(data) as T;
    }
    if (t == _i30.ProficiencyBundleView) {
      return _i30.ProficiencyBundleView.fromJson(data) as T;
    }
    if (t == _i31.FeatureTag) {
      return _i31.FeatureTag.fromJson(data) as T;
    }
    if (t == _i32.HitPointMode) {
      return _i32.HitPointMode.fromJson(data) as T;
    }
    if (t == _i33.Language) {
      return _i33.Language.fromJson(data) as T;
    }
    if (t == _i34.RestType) {
      return _i34.RestType.fromJson(data) as T;
    }
    if (t == _i35.Skill) {
      return _i35.Skill.fromJson(data) as T;
    }
    if (t == _i36.SpellSchool) {
      return _i36.SpellSchool.fromJson(data) as T;
    }
    if (t == _i37.SpellcastingProgression) {
      return _i37.SpellcastingProgression.fromJson(data) as T;
    }
    if (t == _i38.WeaponCategory) {
      return _i38.WeaponCategory.fromJson(data) as T;
    }
    if (t == _i39.CharacterBuildData) {
      return _i39.CharacterBuildData.fromJson(data) as T;
    }
    if (t == _i40.CharacterSheetView) {
      return _i40.CharacterSheetView.fromJson(data) as T;
    }
    if (t == _i41.ClassChoiceGroupView) {
      return _i41.ClassChoiceGroupView.fromJson(data) as T;
    }
    if (t == _i42.ClassStepSubclassChoiceView) {
      return _i42.ClassStepSubclassChoiceView.fromJson(data) as T;
    }
    if (t == _i43.ClassStepView) {
      return _i43.ClassStepView.fromJson(data) as T;
    }
    if (t == _i44.DamageType) {
      return _i44.DamageType.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.RaceData?>()) {
      return (data != null ? _i2.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FeatData?>()) {
      return (data != null ? _i3.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CharacterChoiceData?>()) {
      return (data != null ? _i4.CharacterChoiceData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.CharacterClassEntryData?>()) {
      return (data != null ? _i5.CharacterClassEntryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i6.CharacterData?>()) {
      return (data != null ? _i6.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CharacterSheetSnapshotData?>()) {
      return (data != null
          ? _i7.CharacterSheetSnapshotData.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i8.ClassChoiceGroupData?>()) {
      return (data != null ? _i8.ClassChoiceGroupData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.ClassChoiceOptionData?>()) {
      return (data != null ? _i9.ClassChoiceOptionData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.ClassData?>()) {
      return (data != null ? _i10.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ClassFeatureData?>()) {
      return (data != null ? _i11.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ClassLevelData?>()) {
      return (data != null ? _i12.ClassLevelData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.SubclassData?>()) {
      return (data != null ? _i13.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SubclassFeatureData?>()) {
      return (data != null ? _i14.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.DragonbornAncestryData?>()) {
      return (data != null ? _i15.DragonbornAncestryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.BackgroundData?>()) {
      return (data != null ? _i16.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.RaceFeatureData?>()) {
      return (data != null ? _i17.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SubraceData?>()) {
      return (data != null ? _i18.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ArmorData?>()) {
      return (data != null ? _i19.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ItemData?>()) {
      return (data != null ? _i20.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.MagicItemData?>()) {
      return (data != null ? _i21.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.WeaponData?>()) {
      return (data != null ? _i22.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SpellData?>()) {
      return (data != null ? _i23.SpellData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Ability?>()) {
      return (data != null ? _i24.Ability.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.ArmorCategory?>()) {
      return (data != null ? _i25.ArmorCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.CharacterAlignment?>()) {
      return (data != null ? _i26.CharacterAlignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.ChoiceSourceType?>()) {
      return (data != null ? _i27.ChoiceSourceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.ClassChoiceType?>()) {
      return (data != null ? _i28.ClassChoiceType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CreatureSize?>()) {
      return (data != null ? _i29.CreatureSize.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.ProficiencyBundleView?>()) {
      return (data != null ? _i30.ProficiencyBundleView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.FeatureTag?>()) {
      return (data != null ? _i31.FeatureTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.HitPointMode?>()) {
      return (data != null ? _i32.HitPointMode.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Language?>()) {
      return (data != null ? _i33.Language.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.RestType?>()) {
      return (data != null ? _i34.RestType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.Skill?>()) {
      return (data != null ? _i35.Skill.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.SpellSchool?>()) {
      return (data != null ? _i36.SpellSchool.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.SpellcastingProgression?>()) {
      return (data != null ? _i37.SpellcastingProgression.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i38.WeaponCategory?>()) {
      return (data != null ? _i38.WeaponCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.CharacterBuildData?>()) {
      return (data != null ? _i39.CharacterBuildData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.CharacterSheetView?>()) {
      return (data != null ? _i40.CharacterSheetView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.ClassChoiceGroupView?>()) {
      return (data != null ? _i41.ClassChoiceGroupView.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i42.ClassStepSubclassChoiceView?>()) {
      return (data != null
          ? _i42.ClassStepSubclassChoiceView.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i43.ClassStepView?>()) {
      return (data != null ? _i43.ClassStepView.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.DamageType?>()) {
      return (data != null ? _i44.DamageType.fromJson(data) : null) as T;
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
    if (t == _i1.getType<Map<String, _i23.SpellData>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<_i23.SpellData>(v)))
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
    if (t == _i1.getType<List<_i31.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i44.DamageType>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i44.DamageType>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i33.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.WeaponCategory>(e))
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
    if (t == _i1.getType<List<_i31.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, int>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)))
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i31.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<_i31.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.FeatureTag>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<Map<String, String>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<String>(v)))
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
    if (t == _i1.getType<List<_i31.FeatureTag>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i31.FeatureTag>(e)).toList()
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
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<int>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i24.Ability>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i24.Ability>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i35.Skill>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i35.Skill>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i25.ArmorCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i25.ArmorCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i38.WeaponCategory>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i38.WeaponCategory>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i33.Language>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i33.Language>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i5.CharacterClassEntryData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i5.CharacterClassEntryData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i4.CharacterChoiceData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i4.CharacterChoiceData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i9.ClassChoiceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i9.ClassChoiceOptionData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i13.SubclassData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i13.SubclassData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i11.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i11.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i41.ClassChoiceGroupView>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i41.ClassChoiceGroupView>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i12.ClassLevelData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i12.ClassLevelData>(e))
              .toList()
          : null) as T;
    }
    if (t == List<_i45.UserInfo>) {
      return (data as List).map((e) => deserialize<_i45.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i46.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i46.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i47.FeatData>) {
      return (data as List).map((e) => deserialize<_i47.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i48.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i48.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i49.ClassData>) {
      return (data as List).map((e) => deserialize<_i49.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i50.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i50.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i51.ClassLevelData>) {
      return (data as List)
          .map((e) => deserialize<_i51.ClassLevelData>(e))
          .toList() as T;
    }
    if (t == List<_i52.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i52.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i53.ClassChoiceGroupData>) {
      return (data as List)
          .map((e) => deserialize<_i53.ClassChoiceGroupData>(e))
          .toList() as T;
    }
    if (t == List<_i54.ClassChoiceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i54.ClassChoiceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i55.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i55.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i56.RaceData>) {
      return (data as List).map((e) => deserialize<_i56.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i57.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i57.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i58.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i58.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i59.DragonbornAncestryData>) {
      return (data as List)
          .map((e) => deserialize<_i59.DragonbornAncestryData>(e))
          .toList() as T;
    }
    if (t == List<_i60.ArmorData>) {
      return (data as List).map((e) => deserialize<_i60.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i61.ItemData>) {
      return (data as List).map((e) => deserialize<_i61.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i62.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i62.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i63.WeaponData>) {
      return (data as List).map((e) => deserialize<_i63.WeaponData>(e)).toList()
          as T;
    }
    if (t == List<_i64.SpellData>) {
      return (data as List).map((e) => deserialize<_i64.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i45.Protocol().deserialize<T>(data, t);
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
    if (data is _i3.FeatData) {
      return 'FeatData';
    }
    if (data is _i4.CharacterChoiceData) {
      return 'CharacterChoiceData';
    }
    if (data is _i5.CharacterClassEntryData) {
      return 'CharacterClassEntryData';
    }
    if (data is _i6.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i7.CharacterSheetSnapshotData) {
      return 'CharacterSheetSnapshotData';
    }
    if (data is _i8.ClassChoiceGroupData) {
      return 'ClassChoiceGroupData';
    }
    if (data is _i9.ClassChoiceOptionData) {
      return 'ClassChoiceOptionData';
    }
    if (data is _i10.ClassData) {
      return 'ClassData';
    }
    if (data is _i11.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i12.ClassLevelData) {
      return 'ClassLevelData';
    }
    if (data is _i13.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i14.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i15.DragonbornAncestryData) {
      return 'DragonbornAncestryData';
    }
    if (data is _i16.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i17.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i18.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i19.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i20.ItemData) {
      return 'ItemData';
    }
    if (data is _i21.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i22.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i23.SpellData) {
      return 'SpellData';
    }
    if (data is _i24.Ability) {
      return 'Ability';
    }
    if (data is _i25.ArmorCategory) {
      return 'ArmorCategory';
    }
    if (data is _i26.CharacterAlignment) {
      return 'CharacterAlignment';
    }
    if (data is _i27.ChoiceSourceType) {
      return 'ChoiceSourceType';
    }
    if (data is _i28.ClassChoiceType) {
      return 'ClassChoiceType';
    }
    if (data is _i29.CreatureSize) {
      return 'CreatureSize';
    }
    if (data is _i30.ProficiencyBundleView) {
      return 'ProficiencyBundleView';
    }
    if (data is _i31.FeatureTag) {
      return 'FeatureTag';
    }
    if (data is _i32.HitPointMode) {
      return 'HitPointMode';
    }
    if (data is _i33.Language) {
      return 'Language';
    }
    if (data is _i34.RestType) {
      return 'RestType';
    }
    if (data is _i35.Skill) {
      return 'Skill';
    }
    if (data is _i36.SpellSchool) {
      return 'SpellSchool';
    }
    if (data is _i37.SpellcastingProgression) {
      return 'SpellcastingProgression';
    }
    if (data is _i38.WeaponCategory) {
      return 'WeaponCategory';
    }
    if (data is _i39.CharacterBuildData) {
      return 'CharacterBuildData';
    }
    if (data is _i40.CharacterSheetView) {
      return 'CharacterSheetView';
    }
    if (data is _i41.ClassChoiceGroupView) {
      return 'ClassChoiceGroupView';
    }
    if (data is _i42.ClassStepSubclassChoiceView) {
      return 'ClassStepSubclassChoiceView';
    }
    if (data is _i43.ClassStepView) {
      return 'ClassStepView';
    }
    if (data is _i44.DamageType) {
      return 'DamageType';
    }
    className = _i45.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'FeatData') {
      return deserialize<_i3.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterChoiceData') {
      return deserialize<_i4.CharacterChoiceData>(data['data']);
    }
    if (dataClassName == 'CharacterClassEntryData') {
      return deserialize<_i5.CharacterClassEntryData>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i6.CharacterData>(data['data']);
    }
    if (dataClassName == 'CharacterSheetSnapshotData') {
      return deserialize<_i7.CharacterSheetSnapshotData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupData') {
      return deserialize<_i8.ClassChoiceGroupData>(data['data']);
    }
    if (dataClassName == 'ClassChoiceOptionData') {
      return deserialize<_i9.ClassChoiceOptionData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i10.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i11.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassLevelData') {
      return deserialize<_i12.ClassLevelData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i13.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i14.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'DragonbornAncestryData') {
      return deserialize<_i15.DragonbornAncestryData>(data['data']);
    }
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i16.BackgroundData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i17.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i18.SubraceData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i19.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i20.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i21.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i22.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i23.SpellData>(data['data']);
    }
    if (dataClassName == 'Ability') {
      return deserialize<_i24.Ability>(data['data']);
    }
    if (dataClassName == 'ArmorCategory') {
      return deserialize<_i25.ArmorCategory>(data['data']);
    }
    if (dataClassName == 'CharacterAlignment') {
      return deserialize<_i26.CharacterAlignment>(data['data']);
    }
    if (dataClassName == 'ChoiceSourceType') {
      return deserialize<_i27.ChoiceSourceType>(data['data']);
    }
    if (dataClassName == 'ClassChoiceType') {
      return deserialize<_i28.ClassChoiceType>(data['data']);
    }
    if (dataClassName == 'CreatureSize') {
      return deserialize<_i29.CreatureSize>(data['data']);
    }
    if (dataClassName == 'ProficiencyBundleView') {
      return deserialize<_i30.ProficiencyBundleView>(data['data']);
    }
    if (dataClassName == 'FeatureTag') {
      return deserialize<_i31.FeatureTag>(data['data']);
    }
    if (dataClassName == 'HitPointMode') {
      return deserialize<_i32.HitPointMode>(data['data']);
    }
    if (dataClassName == 'Language') {
      return deserialize<_i33.Language>(data['data']);
    }
    if (dataClassName == 'RestType') {
      return deserialize<_i34.RestType>(data['data']);
    }
    if (dataClassName == 'Skill') {
      return deserialize<_i35.Skill>(data['data']);
    }
    if (dataClassName == 'SpellSchool') {
      return deserialize<_i36.SpellSchool>(data['data']);
    }
    if (dataClassName == 'SpellcastingProgression') {
      return deserialize<_i37.SpellcastingProgression>(data['data']);
    }
    if (dataClassName == 'WeaponCategory') {
      return deserialize<_i38.WeaponCategory>(data['data']);
    }
    if (dataClassName == 'CharacterBuildData') {
      return deserialize<_i39.CharacterBuildData>(data['data']);
    }
    if (dataClassName == 'CharacterSheetView') {
      return deserialize<_i40.CharacterSheetView>(data['data']);
    }
    if (dataClassName == 'ClassChoiceGroupView') {
      return deserialize<_i41.ClassChoiceGroupView>(data['data']);
    }
    if (dataClassName == 'ClassStepSubclassChoiceView') {
      return deserialize<_i42.ClassStepSubclassChoiceView>(data['data']);
    }
    if (dataClassName == 'ClassStepView') {
      return deserialize<_i43.ClassStepView>(data['data']);
    }
    if (dataClassName == 'DamageType') {
      return deserialize<_i44.DamageType>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i45.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
