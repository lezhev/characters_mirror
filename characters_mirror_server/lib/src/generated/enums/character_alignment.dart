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

enum CharacterAlignment implements _i1.SerializableModel {
  lawfulGood,
  neutralGood,
  chaoticGood,
  lawfulNeutral,
  trueNeutral,
  chaoticNeutral,
  lawfulEvil,
  neutralEvil,
  chaoticEvil,
  unaligned;

  static CharacterAlignment fromJson(String name) {
    switch (name) {
      case 'lawfulGood':
        return CharacterAlignment.lawfulGood;
      case 'neutralGood':
        return CharacterAlignment.neutralGood;
      case 'chaoticGood':
        return CharacterAlignment.chaoticGood;
      case 'lawfulNeutral':
        return CharacterAlignment.lawfulNeutral;
      case 'trueNeutral':
        return CharacterAlignment.trueNeutral;
      case 'chaoticNeutral':
        return CharacterAlignment.chaoticNeutral;
      case 'lawfulEvil':
        return CharacterAlignment.lawfulEvil;
      case 'neutralEvil':
        return CharacterAlignment.neutralEvil;
      case 'chaoticEvil':
        return CharacterAlignment.chaoticEvil;
      case 'unaligned':
        return CharacterAlignment.unaligned;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "CharacterAlignment"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
