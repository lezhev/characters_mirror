/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import '../../../enums/character_skill_proficiency_level.dart' as _i9zo7fwz;
import '../../../enums/skill.dart' as _iqrhamom;

abstract class CharacterSkillProficiencyState
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CharacterSkillProficiencyState._({required this.skill, required this.level});

  factory CharacterSkillProficiencyState({
    required _iqrhamom.Skill skill,
    required _i9zo7fwz.CharacterSkillProficiencyLevel level,
  }) = _CharacterSkillProficiencyStateImpl;

  factory CharacterSkillProficiencyState.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSkillProficiencyState(
      skill: _iqrhamom.Skill.fromJson((jsonSerialization['skill'] as String)),
      level: _i9zo7fwz.CharacterSkillProficiencyLevel.fromJson(
        (jsonSerialization['level'] as String),
      ),
    );
  }

  _iqrhamom.Skill skill;

  _i9zo7fwz.CharacterSkillProficiencyLevel level;

  /// Returns a shallow copy of this [CharacterSkillProficiencyState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSkillProficiencyState copyWith({
    _iqrhamom.Skill? skill,
    _i9zo7fwz.CharacterSkillProficiencyLevel? level,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSkillProficiencyState',
      'skill': skill.toJson(),
      'level': level.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSkillProficiencyState',
      'skill': skill.toJson(),
      'level': level.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CharacterSkillProficiencyStateImpl
    extends CharacterSkillProficiencyState {
  _CharacterSkillProficiencyStateImpl({
    required _iqrhamom.Skill skill,
    required _i9zo7fwz.CharacterSkillProficiencyLevel level,
  }) : super._(skill: skill, level: level);

  /// Returns a shallow copy of this [CharacterSkillProficiencyState]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterSkillProficiencyState copyWith({
    _iqrhamom.Skill? skill,
    _i9zo7fwz.CharacterSkillProficiencyLevel? level,
  }) {
    return CharacterSkillProficiencyState(
      skill: skill ?? this.skill,
      level: level ?? this.level,
    );
  }
}
