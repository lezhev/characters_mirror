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
import '../../../enums/skill.dart' as _i2;
import '../../../enums/character_skill_proficiency_level.dart' as _i3;

abstract class CharacterSkillProficiencyState implements _i1.SerializableModel {
  CharacterSkillProficiencyState._({
    required this.skill,
    required this.level,
  });

  factory CharacterSkillProficiencyState({
    required _i2.Skill skill,
    required _i3.CharacterSkillProficiencyLevel level,
  }) = _CharacterSkillProficiencyStateImpl;

  factory CharacterSkillProficiencyState.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSkillProficiencyState(
      skill: _i2.Skill.fromJson((jsonSerialization['skill'] as String)),
      level: _i3.CharacterSkillProficiencyLevel.fromJson(
          (jsonSerialization['level'] as String)),
    );
  }

  _i2.Skill skill;

  _i3.CharacterSkillProficiencyLevel level;

  /// Returns a shallow copy of this [CharacterSkillProficiencyState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSkillProficiencyState copyWith({
    _i2.Skill? skill,
    _i3.CharacterSkillProficiencyLevel? level,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'skill': skill.toJson(),
      'level': level.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CharacterSkillProficiencyStateImpl
    extends CharacterSkillProficiencyState {
  _CharacterSkillProficiencyStateImpl({
    required _i2.Skill skill,
    required _i3.CharacterSkillProficiencyLevel level,
  }) : super._(
          skill: skill,
          level: level,
        );

  /// Returns a shallow copy of this [CharacterSkillProficiencyState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSkillProficiencyState copyWith({
    _i2.Skill? skill,
    _i3.CharacterSkillProficiencyLevel? level,
  }) {
    return CharacterSkillProficiencyState(
      skill: skill ?? this.skill,
      level: level ?? this.level,
    );
  }
}
