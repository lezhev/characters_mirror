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

  static Language fromJson(String name) {
    switch (name) {
      case 'common':
        return Language.common;
      case 'dwarvish':
        return Language.dwarvish;
      case 'elvish':
        return Language.elvish;
      case 'giant':
        return Language.giant;
      case 'gnomish':
        return Language.gnomish;
      case 'goblin':
        return Language.goblin;
      case 'halfling':
        return Language.halfling;
      case 'orc':
        return Language.orc;
      case 'abyssal':
        return Language.abyssal;
      case 'celestial':
        return Language.celestial;
      case 'draconic':
        return Language.draconic;
      case 'deepSpeech':
        return Language.deepSpeech;
      case 'infernal':
        return Language.infernal;
      case 'primordial':
        return Language.primordial;
      case 'sylvan':
        return Language.sylvan;
      case 'undercommon':
        return Language.undercommon;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Language"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
