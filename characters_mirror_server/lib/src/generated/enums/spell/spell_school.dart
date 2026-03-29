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

enum SpellSchool implements _i1.SerializableModel {
  abjuration,
  conjuration,
  divination,
  enchantment,
  evocation,
  illusion,
  necromancy,
  transmutation;

  static SpellSchool fromJson(int index) {
    switch (index) {
      case 0:
        return SpellSchool.abjuration;
      case 1:
        return SpellSchool.conjuration;
      case 2:
        return SpellSchool.divination;
      case 3:
        return SpellSchool.enchantment;
      case 4:
        return SpellSchool.evocation;
      case 5:
        return SpellSchool.illusion;
      case 6:
        return SpellSchool.necromancy;
      case 7:
        return SpellSchool.transmutation;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "SpellSchool"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
