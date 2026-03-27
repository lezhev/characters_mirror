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
import 'data/background_data.dart' as _i2;
import 'data/feat_data.dart' as _i3;
import 'data/general/character/character_class_relation.dart' as _i4;
import 'data/general/character/character_data.dart' as _i5;
import 'data/general/class/class_data.dart' as _i6;
import 'data/general/class/class_feature_data.dart' as _i7;
import 'data/general/class/class_option_data.dart' as _i8;
import 'data/general/class/subclass_data.dart' as _i9;
import 'data/general/class/subclass_feature_data.dart' as _i10;
import 'data/general/race/dragonborn_ancestry_data.dart' as _i11;
import 'data/general/race/race_data.dart' as _i12;
import 'data/general/race/race_feature_data.dart' as _i13;
import 'data/general/race/race_option_data.dart' as _i14;
import 'data/general/race/subrace_data.dart' as _i15;
import 'data/items/armor_data.dart' as _i16;
import 'data/items/item_data.dart' as _i17;
import 'data/items/magic_item_data.dart' as _i18;
import 'data/items/weapon_data.dart' as _i19;
import 'data/spell_data.dart' as _i20;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i21;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i22;
import 'package:characters_mirror_client/src/protocol/data/feat_data.dart'
    as _i23;
import 'package:characters_mirror_client/src/protocol/data/general/character/character_data.dart'
    as _i24;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_data.dart'
    as _i25;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_feature_data.dart'
    as _i26;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_data.dart'
    as _i27;
import 'package:characters_mirror_client/src/protocol/data/general/class/class_option_data.dart'
    as _i28;
import 'package:characters_mirror_client/src/protocol/data/general/class/subclass_feature_data.dart'
    as _i29;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_data.dart'
    as _i30;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_feature_data.dart'
    as _i31;
import 'package:characters_mirror_client/src/protocol/data/general/race/subrace_data.dart'
    as _i32;
import 'package:characters_mirror_client/src/protocol/data/general/race/race_option_data.dart'
    as _i33;
import 'package:characters_mirror_client/src/protocol/data/general/race/dragonborn_ancestry_data.dart'
    as _i34;
import 'package:characters_mirror_client/src/protocol/data/items/armor_data.dart'
    as _i35;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i36;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i37;
import 'package:characters_mirror_client/src/protocol/data/items/weapon_data.dart'
    as _i38;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i39;
export 'data/background_data.dart';
export 'data/feat_data.dart';
export 'data/general/character/character_class_relation.dart';
export 'data/general/character/character_data.dart';
export 'data/general/class/class_data.dart';
export 'data/general/class/class_feature_data.dart';
export 'data/general/class/class_option_data.dart';
export 'data/general/class/subclass_data.dart';
export 'data/general/class/subclass_feature_data.dart';
export 'data/general/race/dragonborn_ancestry_data.dart';
export 'data/general/race/race_data.dart';
export 'data/general/race/race_feature_data.dart';
export 'data/general/race/race_option_data.dart';
export 'data/general/race/subrace_data.dart';
export 'data/items/armor_data.dart';
export 'data/items/item_data.dart';
export 'data/items/magic_item_data.dart';
export 'data/items/weapon_data.dart';
export 'data/spell_data.dart';
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
    if (t == _i2.BackgroundData) {
      return _i2.BackgroundData.fromJson(data) as T;
    }
    if (t == _i3.FeatData) {
      return _i3.FeatData.fromJson(data) as T;
    }
    if (t == _i4.CharacterClassRelation) {
      return _i4.CharacterClassRelation.fromJson(data) as T;
    }
    if (t == _i5.CharacterData) {
      return _i5.CharacterData.fromJson(data) as T;
    }
    if (t == _i6.ClassData) {
      return _i6.ClassData.fromJson(data) as T;
    }
    if (t == _i7.ClassFeatureData) {
      return _i7.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i8.ClassOptionData) {
      return _i8.ClassOptionData.fromJson(data) as T;
    }
    if (t == _i9.SubclassData) {
      return _i9.SubclassData.fromJson(data) as T;
    }
    if (t == _i10.SubclassFeatureData) {
      return _i10.SubclassFeatureData.fromJson(data) as T;
    }
    if (t == _i11.DragonbornAncestryData) {
      return _i11.DragonbornAncestryData.fromJson(data) as T;
    }
    if (t == _i12.RaceData) {
      return _i12.RaceData.fromJson(data) as T;
    }
    if (t == _i13.RaceFeatureData) {
      return _i13.RaceFeatureData.fromJson(data) as T;
    }
    if (t == _i14.RaceOptionData) {
      return _i14.RaceOptionData.fromJson(data) as T;
    }
    if (t == _i15.SubraceData) {
      return _i15.SubraceData.fromJson(data) as T;
    }
    if (t == _i16.ArmorData) {
      return _i16.ArmorData.fromJson(data) as T;
    }
    if (t == _i17.ItemData) {
      return _i17.ItemData.fromJson(data) as T;
    }
    if (t == _i18.MagicItemData) {
      return _i18.MagicItemData.fromJson(data) as T;
    }
    if (t == _i19.WeaponData) {
      return _i19.WeaponData.fromJson(data) as T;
    }
    if (t == _i20.SpellData) {
      return _i20.SpellData.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BackgroundData?>()) {
      return (data != null ? _i2.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FeatData?>()) {
      return (data != null ? _i3.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CharacterClassRelation?>()) {
      return (data != null ? _i4.CharacterClassRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i5.CharacterData?>()) {
      return (data != null ? _i5.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ClassData?>()) {
      return (data != null ? _i6.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ClassFeatureData?>()) {
      return (data != null ? _i7.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ClassOptionData?>()) {
      return (data != null ? _i8.ClassOptionData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.SubclassData?>()) {
      return (data != null ? _i9.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.SubclassFeatureData?>()) {
      return (data != null ? _i10.SubclassFeatureData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.DragonbornAncestryData?>()) {
      return (data != null ? _i11.DragonbornAncestryData.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.RaceData?>()) {
      return (data != null ? _i12.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.RaceFeatureData?>()) {
      return (data != null ? _i13.RaceFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.RaceOptionData?>()) {
      return (data != null ? _i14.RaceOptionData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SubraceData?>()) {
      return (data != null ? _i15.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ArmorData?>()) {
      return (data != null ? _i16.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.ItemData?>()) {
      return (data != null ? _i17.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.MagicItemData?>()) {
      return (data != null ? _i18.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.WeaponData?>()) {
      return (data != null ? _i19.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.SpellData?>()) {
      return (data != null ? _i20.SpellData.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i6.ClassData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i6.ClassData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i7.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i7.ClassFeatureData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.ClassOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i8.ClassOptionData>(e))
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
    if (t == _i1.getType<List<_i20.SpellData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i20.SpellData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i20.SpellData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i20.SpellData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.ItemData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i17.ItemData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i18.MagicItemData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i18.MagicItemData>(e))
              .toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i16.ArmorData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i16.ArmorData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i19.WeaponData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i19.WeaponData>(e)).toList()
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
    if (t == _i1.getType<List<_i19.WeaponData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i19.WeaponData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.ItemData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i17.ItemData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i17.ItemData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i17.ItemData>(e)).toList()
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
    if (t == _i1.getType<Map<int, int>?>()) {
      return (data != null
          ? Map.fromEntries((data as List).map((e) =>
              MapEntry(deserialize<int>(e['k']), deserialize<int>(e['v']))))
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
    if (t == _i1.getType<Map<String, _i20.SpellData>?>()) {
      return (data != null
          ? (data as Map).map((k, v) =>
              MapEntry(deserialize<String>(k), deserialize<_i20.SpellData>(v)))
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
    if (t == _i1.getType<List<_i14.RaceOptionData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i14.RaceOptionData>(e))
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
    if (t == List<_i21.UserInfo>) {
      return (data as List).map((e) => deserialize<_i21.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i22.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i22.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i23.FeatData>) {
      return (data as List).map((e) => deserialize<_i23.FeatData>(e)).toList()
          as T;
    }
    if (t == List<_i24.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i24.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i25.ClassData>) {
      return (data as List).map((e) => deserialize<_i25.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i26.ClassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i26.ClassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i27.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i27.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i28.ClassOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i28.ClassOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i29.SubclassFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i29.SubclassFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i30.RaceData>) {
      return (data as List).map((e) => deserialize<_i30.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i31.RaceFeatureData>) {
      return (data as List)
          .map((e) => deserialize<_i31.RaceFeatureData>(e))
          .toList() as T;
    }
    if (t == List<_i32.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i32.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i33.RaceOptionData>) {
      return (data as List)
          .map((e) => deserialize<_i33.RaceOptionData>(e))
          .toList() as T;
    }
    if (t == List<_i34.DragonbornAncestryData>) {
      return (data as List)
          .map((e) => deserialize<_i34.DragonbornAncestryData>(e))
          .toList() as T;
    }
    if (t == List<_i35.ArmorData>) {
      return (data as List).map((e) => deserialize<_i35.ArmorData>(e)).toList()
          as T;
    }
    if (t == List<_i36.ItemData>) {
      return (data as List).map((e) => deserialize<_i36.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i37.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i37.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i38.WeaponData>) {
      return (data as List).map((e) => deserialize<_i38.WeaponData>(e)).toList()
          as T;
    }
    if (t == List<_i39.SpellData>) {
      return (data as List).map((e) => deserialize<_i39.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i21.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.BackgroundData) {
      return 'BackgroundData';
    }
    if (data is _i3.FeatData) {
      return 'FeatData';
    }
    if (data is _i4.CharacterClassRelation) {
      return 'CharacterClassRelation';
    }
    if (data is _i5.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i6.ClassData) {
      return 'ClassData';
    }
    if (data is _i7.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i8.ClassOptionData) {
      return 'ClassOptionData';
    }
    if (data is _i9.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i10.SubclassFeatureData) {
      return 'SubclassFeatureData';
    }
    if (data is _i11.DragonbornAncestryData) {
      return 'DragonbornAncestryData';
    }
    if (data is _i12.RaceData) {
      return 'RaceData';
    }
    if (data is _i13.RaceFeatureData) {
      return 'RaceFeatureData';
    }
    if (data is _i14.RaceOptionData) {
      return 'RaceOptionData';
    }
    if (data is _i15.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i16.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i17.ItemData) {
      return 'ItemData';
    }
    if (data is _i18.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i19.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i20.SpellData) {
      return 'SpellData';
    }
    className = _i21.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'BackgroundData') {
      return deserialize<_i2.BackgroundData>(data['data']);
    }
    if (dataClassName == 'FeatData') {
      return deserialize<_i3.FeatData>(data['data']);
    }
    if (dataClassName == 'CharacterClassRelation') {
      return deserialize<_i4.CharacterClassRelation>(data['data']);
    }
    if (dataClassName == 'CharacterData') {
      return deserialize<_i5.CharacterData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i6.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i7.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'ClassOptionData') {
      return deserialize<_i8.ClassOptionData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i9.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubclassFeatureData') {
      return deserialize<_i10.SubclassFeatureData>(data['data']);
    }
    if (dataClassName == 'DragonbornAncestryData') {
      return deserialize<_i11.DragonbornAncestryData>(data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i12.RaceData>(data['data']);
    }
    if (dataClassName == 'RaceFeatureData') {
      return deserialize<_i13.RaceFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceOptionData') {
      return deserialize<_i14.RaceOptionData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i15.SubraceData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i16.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i17.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i18.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i19.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i20.SpellData>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i21.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
