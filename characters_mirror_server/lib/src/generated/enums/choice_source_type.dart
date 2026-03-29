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

enum ChoiceSourceType implements _i1.SerializableModel {
  race,
  subrace,
  background,
  classData,
  subclass,
  classFeature,
  subclassFeature;

  static ChoiceSourceType fromJson(String name) {
    switch (name) {
      case 'race':
        return ChoiceSourceType.race;
      case 'subrace':
        return ChoiceSourceType.subrace;
      case 'background':
        return ChoiceSourceType.background;
      case 'classData':
        return ChoiceSourceType.classData;
      case 'subclass':
        return ChoiceSourceType.subclass;
      case 'classFeature':
        return ChoiceSourceType.classFeature;
      case 'subclassFeature':
        return ChoiceSourceType.subclassFeature;
      default:
        throw ArgumentError(
            'Value "$name" cannot be converted to "ChoiceSourceType"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
