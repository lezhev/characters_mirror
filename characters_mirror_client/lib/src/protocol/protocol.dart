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
import 'background_data.dart' as _i2;
import 'feat_data.dart' as _i3;
import 'general/character_data.dart' as _i4;
import 'general/class_data.dart' as _i5;
import 'general/class_feature_data.dart' as _i6;
import 'general/race_data.dart' as _i7;
import 'general/subclass_data.dart' as _i8;
import 'general/subrace_data.dart' as _i9;
import 'items/armor_data.dart' as _i10;
import 'items/item_data.dart' as _i11;
import 'items/magic_item_data.dart' as _i12;
import 'items/weapon_data.dart' as _i13;
import 'spell_data.dart' as _i14;
import 'package:characters_mirror_client/src/protocol/background_data.dart'
    as _i15;
import 'package:characters_mirror_client/src/protocol/general/character_data.dart'
    as _i16;
import 'package:characters_mirror_client/src/protocol/general/class_data.dart'
    as _i17;
import 'package:characters_mirror_client/src/protocol/items/item_data.dart'
    as _i18;
import 'package:characters_mirror_client/src/protocol/general/race_data.dart'
    as _i19;
import 'package:characters_mirror_client/src/protocol/spell_data.dart' as _i20;
import 'package:characters_mirror_client/src/protocol/general/subclass_data.dart'
    as _i21;
import 'package:characters_mirror_client/src/protocol/general/subrace_data.dart'
    as _i22;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i23;
export 'background_data.dart';
export 'feat_data.dart';
export 'general/character_data.dart';
export 'general/class_data.dart';
export 'general/class_feature_data.dart';
export 'general/race_data.dart';
export 'general/subclass_data.dart';
export 'general/subrace_data.dart';
export 'items/armor_data.dart';
export 'items/item_data.dart';
export 'items/magic_item_data.dart';
export 'items/weapon_data.dart';
export 'spell_data.dart';
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
    if (t == List<_i15.BackgroundData>) {
      return (data as List)
          .map((e) => deserialize<_i15.BackgroundData>(e))
          .toList() as T;
    }
    if (t == List<_i16.CharacterData>) {
      return (data as List)
          .map((e) => deserialize<_i16.CharacterData>(e))
          .toList() as T;
    }
    if (t == List<_i17.ClassData>) {
      return (data as List).map((e) => deserialize<_i17.ClassData>(e)).toList()
          as T;
    }
    if (t == List<_i18.ItemData>) {
      return (data as List).map((e) => deserialize<_i18.ItemData>(e)).toList()
          as T;
    }
    if (t == List<_i19.RaceData>) {
      return (data as List).map((e) => deserialize<_i19.RaceData>(e)).toList()
          as T;
    }
    if (t == List<_i20.SpellData>) {
      return (data as List).map((e) => deserialize<_i20.SpellData>(e)).toList()
          as T;
    }
    if (t == List<_i21.SubclassData>) {
      return (data as List)
          .map((e) => deserialize<_i21.SubclassData>(e))
          .toList() as T;
    }
    if (t == List<_i22.SubraceData>) {
      return (data as List)
          .map((e) => deserialize<_i22.SubraceData>(e))
          .toList() as T;
    }
    try {
      return _i23.Protocol().deserialize<T>(data, t);
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
    className = _i23.Protocol().getClassNameForObject(data);
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
      return _i23.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
