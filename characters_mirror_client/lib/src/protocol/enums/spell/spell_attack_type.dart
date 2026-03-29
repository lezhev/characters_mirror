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

enum SpellAttackType implements _i1.SerializableModel {
  none,
  meleeSpell,
  rangedSpell;

  static SpellAttackType fromJson(String name) {
    switch (name) {
      case 'none':
        return SpellAttackType.none;
      case 'meleeSpell':
        return SpellAttackType.meleeSpell;
      case 'rangedSpell':
        return SpellAttackType.rangedSpell;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "SpellAttackType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
