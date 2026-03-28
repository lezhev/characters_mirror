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

  static CharacterAlignment fromJson(int index) {
    switch (index) {
      case 0:
        return CharacterAlignment.lawfulGood;
      case 1:
        return CharacterAlignment.neutralGood;
      case 2:
        return CharacterAlignment.chaoticGood;
      case 3:
        return CharacterAlignment.lawfulNeutral;
      case 4:
        return CharacterAlignment.trueNeutral;
      case 5:
        return CharacterAlignment.chaoticNeutral;
      case 6:
        return CharacterAlignment.lawfulEvil;
      case 7:
        return CharacterAlignment.neutralEvil;
      case 8:
        return CharacterAlignment.chaoticEvil;
      case 9:
        return CharacterAlignment.unaligned;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "CharacterAlignment"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
