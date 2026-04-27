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

enum ClassChoiceType implements _i1.SerializableModel {
  skill,
  tool,
  language,
  fightingStyle,
  expertise,
  subclassFeature,
  featureOption,
  invocation,
  abilityIncrease,
  feat,
  custom;

  static ClassChoiceType fromJson(String name) {
    switch (name) {
      case 'skill':
        return ClassChoiceType.skill;
      case 'tool':
        return ClassChoiceType.tool;
      case 'language':
        return ClassChoiceType.language;
      case 'fightingStyle':
        return ClassChoiceType.fightingStyle;
      case 'expertise':
        return ClassChoiceType.expertise;
      case 'subclassFeature':
        return ClassChoiceType.subclassFeature;
      case 'featureOption':
        return ClassChoiceType.featureOption;
      case 'invocation':
        return ClassChoiceType.invocation;
      case 'abilityIncrease':
        return ClassChoiceType.abilityIncrease;
      case 'feat':
        return ClassChoiceType.feat;
      case 'custom':
        return ClassChoiceType.custom;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ClassChoiceType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
