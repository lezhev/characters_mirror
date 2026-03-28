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

enum Language implements _i1.SerializableModel {
  common,
  dwarvish,
  elvish,
  giant,
  gnomish,
  goblin,
  halfling,
  orc,
  abyssal,
  celestial,
  draconic,
  deepSpeech,
  infernal,
  primordial,
  sylvan,
  undercommon;

  static Language fromJson(int index) {
    switch (index) {
      case 0:
        return Language.common;
      case 1:
        return Language.dwarvish;
      case 2:
        return Language.elvish;
      case 3:
        return Language.giant;
      case 4:
        return Language.gnomish;
      case 5:
        return Language.goblin;
      case 6:
        return Language.halfling;
      case 7:
        return Language.orc;
      case 8:
        return Language.abyssal;
      case 9:
        return Language.celestial;
      case 10:
        return Language.draconic;
      case 11:
        return Language.deepSpeech;
      case 12:
        return Language.infernal;
      case 13:
        return Language.primordial;
      case 14:
        return Language.sylvan;
      case 15:
        return Language.undercommon;
      default:
        throw ArgumentError('Value "$index" cannot be converted to "Language"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
