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

enum ChoiceRequirementType implements _i1.SerializableModel {
  minimumClassLevel,
  minimumCharacterLevel,
  abilityScore,
  knownSpell,
  knownCantrip,
  feature,
  selectedChoiceOption;

  static ChoiceRequirementType fromJson(String name) {
    switch (name) {
      case 'minimumClassLevel':
        return ChoiceRequirementType.minimumClassLevel;
      case 'minimumCharacterLevel':
        return ChoiceRequirementType.minimumCharacterLevel;
      case 'abilityScore':
        return ChoiceRequirementType.abilityScore;
      case 'knownSpell':
        return ChoiceRequirementType.knownSpell;
      case 'knownCantrip':
        return ChoiceRequirementType.knownCantrip;
      case 'feature':
        return ChoiceRequirementType.feature;
      case 'selectedChoiceOption':
        return ChoiceRequirementType.selectedChoiceOption;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ChoiceRequirementType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
