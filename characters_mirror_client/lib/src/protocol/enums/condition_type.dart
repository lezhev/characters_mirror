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

  static ConditionType fromJson(String name) {
    switch (name) {
      case 'blinded':
        return ConditionType.blinded;
      case 'charmed':
        return ConditionType.charmed;
      case 'deafened':
        return ConditionType.deafened;
      case 'frightened':
        return ConditionType.frightened;
      case 'grappled':
        return ConditionType.grappled;
      case 'incapacitated':
        return ConditionType.incapacitated;
      case 'invisible':
        return ConditionType.invisible;
      case 'paralyzed':
        return ConditionType.paralyzed;
      case 'petrified':
        return ConditionType.petrified;
      case 'poisoned':
        return ConditionType.poisoned;
      case 'prone':
        return ConditionType.prone;
      case 'restrained':
        return ConditionType.restrained;
      case 'stunned':
        return ConditionType.stunned;
      case 'unconscious':
        return ConditionType.unconscious;
      case 'exhaustion':
        return ConditionType.exhaustion;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ConditionType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
