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

enum SpellSchool implements _i1.SerializableModel {
  abjuration,
  conjuration,
  divination,
  enchantment,
  evocation,
  illusion,
  necromancy,
  transmutation;

  static SpellSchool fromJson(String name) {
    switch (name) {
      case 'abjuration':
        return SpellSchool.abjuration;
      case 'conjuration':
        return SpellSchool.conjuration;
      case 'divination':
        return SpellSchool.divination;
      case 'enchantment':
        return SpellSchool.enchantment;
      case 'evocation':
        return SpellSchool.evocation;
      case 'illusion':
        return SpellSchool.illusion;
      case 'necromancy':
        return SpellSchool.necromancy;
      case 'transmutation':
        return SpellSchool.transmutation;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "SpellSchool"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
