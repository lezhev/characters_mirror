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

enum RaceChoiceKind implements _i1.SerializableModel {
  abilityBonusChoice,
  skillProficiencyChoice,
  languageChoice,
  toolProficiencyChoice,
  cantripChoice;

  static RaceChoiceKind fromJson(String name) {
    switch (name) {
      case 'abilityBonusChoice':
        return RaceChoiceKind.abilityBonusChoice;
      case 'skillProficiencyChoice':
        return RaceChoiceKind.skillProficiencyChoice;
      case 'languageChoice':
        return RaceChoiceKind.languageChoice;
      case 'toolProficiencyChoice':
        return RaceChoiceKind.toolProficiencyChoice;
      case 'cantripChoice':
        return RaceChoiceKind.cantripChoice;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "RaceChoiceKind"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
