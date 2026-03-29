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

  static Skill fromJson(String name) {
    switch (name) {
      case 'acrobatics':
        return Skill.acrobatics;
      case 'animalHandling':
        return Skill.animalHandling;
      case 'arcana':
        return Skill.arcana;
      case 'athletics':
        return Skill.athletics;
      case 'deception':
        return Skill.deception;
      case 'history':
        return Skill.history;
      case 'insight':
        return Skill.insight;
      case 'intimidation':
        return Skill.intimidation;
      case 'investigation':
        return Skill.investigation;
      case 'medicine':
        return Skill.medicine;
      case 'nature':
        return Skill.nature;
      case 'perception':
        return Skill.perception;
      case 'performance':
        return Skill.performance;
      case 'persuasion':
        return Skill.persuasion;
      case 'religion':
        return Skill.religion;
      case 'sleightOfHand':
        return Skill.sleightOfHand;
      case 'stealth':
        return Skill.stealth;
      case 'survival':
        return Skill.survival;
      default:
        throw ArgumentError('Value "$name" cannot be converted to "Skill"');
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
