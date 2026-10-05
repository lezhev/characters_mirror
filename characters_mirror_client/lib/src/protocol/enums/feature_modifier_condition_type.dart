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

enum FeatureModifierConditionType implements _i1.SerializableModel {
  unarmored,
  noShield,
  abilityCheckIsNotProficient,
  armored,
  rangedWeaponAttack,
  selectedChoiceOption;

  static FeatureModifierConditionType fromJson(int index) {
    switch (index) {
      case 0:
        return FeatureModifierConditionType.unarmored;
      case 1:
        return FeatureModifierConditionType.noShield;
      case 2:
        return FeatureModifierConditionType.abilityCheckIsNotProficient;
      case 3:
        return FeatureModifierConditionType.armored;
      case 4:
        return FeatureModifierConditionType.rangedWeaponAttack;
      case 5:
        return FeatureModifierConditionType.selectedChoiceOption;
      default:
        throw ArgumentError(
            'Value "$index" cannot be converted to "FeatureModifierConditionType"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
