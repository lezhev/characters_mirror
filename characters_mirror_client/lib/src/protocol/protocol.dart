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
import 'data/general/character_data.dart' as _i4;
import 'data/general/class_data.dart' as _i5;
import 'data/general/class_feature_data.dart' as _i6;
import 'data/general/race_data.dart' as _i7;
import 'data/general/subclass_data.dart' as _i8;
import 'data/general/subrace_data.dart' as _i9;
import 'data/items/armor_data.dart' as _i10;
import 'data/items/item_data.dart' as _i11;
import 'data/items/magic_item_data.dart' as _i12;
import 'data/items/weapon_data.dart' as _i13;
import 'data/spell_data.dart' as _i14;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i15;
import 'package:characters_mirror_client/src/protocol/data/background_data.dart'
    as _i16;
import 'package:characters_mirror_client/src/protocol/data/general/character_data.dart'
    as _i17;
import 'package:characters_mirror_client/src/protocol/data/general/class_data.dart'
    as _i18;
import 'package:characters_mirror_client/src/protocol/data/general/race_data.dart'
    as _i19;
import 'package:characters_mirror_client/src/protocol/data/general/subclass_data.dart'
    as _i20;
import 'package:characters_mirror_client/src/protocol/data/general/subrace_data.dart'
    as _i21;
import 'package:characters_mirror_client/src/protocol/data/items/item_data.dart'
    as _i22;
import 'package:characters_mirror_client/src/protocol/data/items/magic_item_data.dart'
    as _i23;
import 'package:characters_mirror_client/src/protocol/data/spell_data.dart'
    as _i24;
export 'data/background_data.dart';
export 'data/feat_data.dart';
export 'data/general/character_data.dart';
export 'data/general/class_data.dart';
export 'data/general/class_feature_data.dart';
export 'data/general/race_data.dart';
export 'data/general/subclass_data.dart';
export 'data/general/subrace_data.dart';
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
    if (t == _i4.CharacterData) {
      return _i4.CharacterData.fromJson(data) as T;
    }
    if (t == _i5.ClassData) {
      return _i5.ClassData.fromJson(data) as T;
    }
    if (t == _i6.ClassFeatureData) {
      return _i6.ClassFeatureData.fromJson(data) as T;
    }
    if (t == _i7.RaceData) {
      return _i7.RaceData.fromJson(data) as T;
    }
    if (t == _i8.SubclassData) {
      return _i8.SubclassData.fromJson(data) as T;
    }
    if (t == _i9.SubraceData) {
      return _i9.SubraceData.fromJson(data) as T;
    }
    if (t == _i10.ArmorData) {
      return _i10.ArmorData.fromJson(data) as T;
    }
    if (t == _i11.ItemData) {
      return _i11.ItemData.fromJson(data) as T;
    }
    if (t == _i12.MagicItemData) {
      return _i12.MagicItemData.fromJson(data) as T;
    }
    if (t == _i13.WeaponData) {
      return _i13.WeaponData.fromJson(data) as T;
    }
    if (t == _i14.SpellData) {
      return _i14.SpellData.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.BackgroundData?>()) {
      return (data != null ? _i2.BackgroundData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.FeatData?>()) {
      return (data != null ? _i3.FeatData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.CharacterData?>()) {
      return (data != null ? _i4.CharacterData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ClassData?>()) {
      return (data != null ? _i5.ClassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ClassFeatureData?>()) {
      return (data != null ? _i6.ClassFeatureData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.RaceData?>()) {
      return (data != null ? _i7.RaceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.SubclassData?>()) {
      return (data != null ? _i8.SubclassData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.SubraceData?>()) {
      return (data != null ? _i9.SubraceData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ArmorData?>()) {
      return (data != null ? _i10.ArmorData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ItemData?>()) {
      return (data != null ? _i11.ItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.MagicItemData?>()) {
      return (data != null ? _i12.MagicItemData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.WeaponData?>()) {
      return (data != null ? _i13.WeaponData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.SpellData?>()) {
      return (data != null ? _i14.SpellData.fromJson(data) : null) as T;
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
    if (t == _i1.getType<List<_i5.ClassData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i5.ClassData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i8.SubclassData>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<_i8.SubclassData>(e)).toList()
          : null) as T;
    }
    if (t == _i1.getType<List<_i6.ClassFeatureData>?>()) {
      return (data != null
          ? (data as List)
              .map((e) => deserialize<_i6.ClassFeatureData>(e))
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
    if (t == List<_i15.UserInfo>) {
      return (data as List).map((e) => deserialize<_i15.UserInfo>(e)).toList()
          as T;
    }
    if (t == List<_i16.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i16.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i17.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i17.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i18.ClassData>) {
      return (data as List).map((e) => deserialize<_i18.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i19.RaceData>) {
      return (data as List).map((e) => deserialize<_i19.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i20.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i20.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i21.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i21.SubraceData>(e))
          .toList() as T;
    }
    if (t == List<_i22.ItemData>) {
      return (data as List).map((e) => deserialize<_i22.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i23.MagicItemData>) {
      return (data as List)
          .map((e) => deserialize<_i23.MagicItemData>(e))
          .toList() as T;
    }
    if (t == List<_i24.SpellData>) {
      return (data as List).map((e) => deserialize<_i24.SpellData>(e)).toList()
          as T;
    }
    try {
      return _i15.Protocol().deserialize<T>(data, t);
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
    if (data is _i4.CharacterData) {
      return 'CharacterData';
    }
    if (data is _i5.ClassData) {
      return 'ClassData';
    }
    if (data is _i6.ClassFeatureData) {
      return 'ClassFeatureData';
    }
    if (data is _i7.RaceData) {
      return 'RaceData';
    }
    if (data is _i8.SubclassData) {
      return 'SubclassData';
    }
    if (data is _i9.SubraceData) {
      return 'SubraceData';
    }
    if (data is _i10.ArmorData) {
      return 'ArmorData';
    }
    if (data is _i11.ItemData) {
      return 'ItemData';
    }
    if (data is _i12.MagicItemData) {
      return 'MagicItemData';
    }
    if (data is _i13.WeaponData) {
      return 'WeaponData';
    }
    if (data is _i14.SpellData) {
      return 'SpellData';
    }
    className = _i15.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'CharacterData') {
      return deserialize<_i4.CharacterData>(data['data']);
    }
    if (dataClassName == 'ClassData') {
      return deserialize<_i5.ClassData>(data['data']);
    }
    if (dataClassName == 'ClassFeatureData') {
      return deserialize<_i6.ClassFeatureData>(data['data']);
    }
    if (dataClassName == 'RaceData') {
      return deserialize<_i7.RaceData>(data['data']);
    }
    if (dataClassName == 'SubclassData') {
      return deserialize<_i8.SubclassData>(data['data']);
    }
    if (dataClassName == 'SubraceData') {
      return deserialize<_i9.SubraceData>(data['data']);
    }
    if (dataClassName == 'ArmorData') {
      return deserialize<_i10.ArmorData>(data['data']);
    }
    if (dataClassName == 'ItemData') {
      return deserialize<_i11.ItemData>(data['data']);
    }
    if (dataClassName == 'MagicItemData') {
      return deserialize<_i12.MagicItemData>(data['data']);
    }
    if (dataClassName == 'WeaponData') {
      return deserialize<_i13.WeaponData>(data['data']);
    }
    if (dataClassName == 'SpellData') {
      return deserialize<_i14.SpellData>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i15.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
