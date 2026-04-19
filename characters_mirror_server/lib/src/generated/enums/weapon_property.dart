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

enum WeaponProperty implements _i1.SerializableModel {
  ammunition,
  finesse,
  heavy,
  light,
  loading,
  range,
  reach,
  special,
  thrown,
  twoHanded,
  versatile;

  static WeaponProperty fromJson(String name) {
    switch (name) {
      case 'ammunition':
        return WeaponProperty.ammunition;
      case 'finesse':
        return WeaponProperty.finesse;
      case 'heavy':
        return WeaponProperty.heavy;
      case 'light':
        return WeaponProperty.light;
      case 'loading':
        return WeaponProperty.loading;
      case 'range':
        return WeaponProperty.range;
      case 'reach':
        return WeaponProperty.reach;
      case 'special':
        return WeaponProperty.special;
      case 'thrown':
        return WeaponProperty.thrown;
      case 'twoHanded':
        return WeaponProperty.twoHanded;
      case 'versatile':
        return WeaponProperty.versatile;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "WeaponProperty"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
