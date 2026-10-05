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

enum ClassSpellSelectionMode implements _i1.SerializableModel {
  none,
  known,
  prepared,
  spellbook;

  static ClassSpellSelectionMode fromJson(String name) {
    switch (name) {
      case 'none':
        return ClassSpellSelectionMode.none;
      case 'known':
        return ClassSpellSelectionMode.known;
      case 'prepared':
        return ClassSpellSelectionMode.prepared;
      case 'spellbook':
        return ClassSpellSelectionMode.spellbook;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ClassSpellSelectionMode"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
