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

enum ConditionType implements _i1.SerializableModel {
  blinded,
  charmed,
  deafened,
  frightened,
  grappled,
  incapacitated,
  invisible,
  paralyzed,
  petrified,
  poisoned,
  prone,
  restrained,
  stunned,
  unconscious,
  exhaustion;

  static ConditionType fromJson(int index) {
    switch (index) {
      case 0:
        return ConditionType.blinded;
      case 1:
        return ConditionType.charmed;
      case 2:
        return ConditionType.deafened;
      case 3:
        return ConditionType.frightened;
      case 4:
        return ConditionType.grappled;
      case 5:
        return ConditionType.incapacitated;
      case 6:
        return ConditionType.invisible;
      case 7:
        return ConditionType.paralyzed;
      case 8:
        return ConditionType.petrified;
      case 9:
        return ConditionType.poisoned;
      case 10:
        return ConditionType.prone;
      case 11:
        return ConditionType.restrained;
      case 12:
        return ConditionType.stunned;
      case 13:
        return ConditionType.unconscious;
      case 14:
        return ConditionType.exhaustion;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "ConditionType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
