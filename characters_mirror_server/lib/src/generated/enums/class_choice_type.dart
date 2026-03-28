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
  spell,
  cantrip,
  equipment,
  subclassFeature,
  featureOption,
  invocation,
  abilityIncrease,
  feat,
  custom;

  static ClassChoiceType fromJson(int index) {
    switch (index) {
      case 0:
        return ClassChoiceType.skill;
      case 1:
        return ClassChoiceType.tool;
      case 2:
        return ClassChoiceType.language;
      case 3:
        return ClassChoiceType.fightingStyle;
      case 4:
        return ClassChoiceType.expertise;
      case 5:
        return ClassChoiceType.spell;
      case 6:
        return ClassChoiceType.cantrip;
      case 7:
        return ClassChoiceType.equipment;
      case 8:
        return ClassChoiceType.subclassFeature;
      case 9:
        return ClassChoiceType.featureOption;
      case 10:
        return ClassChoiceType.invocation;
      case 11:
        return ClassChoiceType.abilityIncrease;
      case 12:
        return ClassChoiceType.feat;
      case 13:
        return ClassChoiceType.custom;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "ClassChoiceType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
