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

enum CreatureSize implements _i1.SerializableModel {
  tiny,
  small,
  medium,
  large,
  huge,
  gargantuan;

  static CreatureSize fromJson(int index) {
    switch (index) {
      case 0:
        return CreatureSize.tiny;
      case 1:
        return CreatureSize.small;
      case 2:
        return CreatureSize.medium;
      case 3:
        return CreatureSize.large;
      case 4:
        return CreatureSize.huge;
      case 5:
        return CreatureSize.gargantuan;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "CreatureSize"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
