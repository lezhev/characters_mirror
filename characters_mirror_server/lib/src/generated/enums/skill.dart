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

enum Skill implements _i1.SerializableModel {
  acrobatics,
  animalHandling,
  arcana,
  athletics,
  deception,
  history,
  insight,
  intimidation,
  investigation,
  medicine,
  nature,
  perception,
  performance,
  persuasion,
  religion,
  sleightOfHand,
  stealth,
  survival;

  static Skill fromJson(int index) {
    switch (index) {
      case 0:
        return Skill.acrobatics;
      case 1:
        return Skill.animalHandling;
      case 2:
        return Skill.arcana;
      case 3:
        return Skill.athletics;
      case 4:
        return Skill.deception;
      case 5:
        return Skill.history;
      case 6:
        return Skill.insight;
      case 7:
        return Skill.intimidation;
      case 8:
        return Skill.investigation;
      case 9:
        return Skill.medicine;
      case 10:
        return Skill.nature;
      case 11:
        return Skill.perception;
      case 12:
        return Skill.performance;
      case 13:
        return Skill.persuasion;
      case 14:
        return Skill.religion;
      case 15:
        return Skill.sleightOfHand;
      case 16:
        return Skill.stealth;
      case 17:
        return Skill.survival;
      default:
        throw ArgumentError('Value "$index" cannot be converted to "Skill"');
    }
  }

  @override
  int toJson() => index;

  @override
  String toString() => name;
}
