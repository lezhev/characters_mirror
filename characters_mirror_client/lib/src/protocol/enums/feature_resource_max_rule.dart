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

enum FeatureResourceMaxRule implements _i1.SerializableModel {
  fixed,
  proficiencyBonus,
  abilityModifier,
  abilityModifierMinOne,
  sourceClassLevel,
  sourceClassLevelTimesValue,
  totalLevel,
  totalLevelTimesValue,
  sourceClassLevelTable;

  static FeatureResourceMaxRule fromJson(String name) {
    switch (name) {
      case 'fixed':
        return FeatureResourceMaxRule.fixed;
      case 'proficiencyBonus':
        return FeatureResourceMaxRule.proficiencyBonus;
      case 'abilityModifier':
        return FeatureResourceMaxRule.abilityModifier;
      case 'abilityModifierMinOne':
        return FeatureResourceMaxRule.abilityModifierMinOne;
      case 'sourceClassLevel':
        return FeatureResourceMaxRule.sourceClassLevel;
      case 'sourceClassLevelTimesValue':
        return FeatureResourceMaxRule.sourceClassLevelTimesValue;
      case 'totalLevel':
        return FeatureResourceMaxRule.totalLevel;
      case 'totalLevelTimesValue':
        return FeatureResourceMaxRule.totalLevelTimesValue;
      case 'sourceClassLevelTable':
        return FeatureResourceMaxRule.sourceClassLevelTable;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "FeatureResourceMaxRule"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
