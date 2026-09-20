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
import '../../../enums/ability.dart' as _i2;
import '../../../enums/character_saving_throw_proficiency_override.dart' as _i3;

abstract class CharacterSavingThrowProficiencyOverrideData
    implements _i1.SerializableModel {
  CharacterSavingThrowProficiencyOverrideData._({
    required this.ability,
    required this.state,
  });

  factory CharacterSavingThrowProficiencyOverrideData({
    required _i2.Ability ability,
    required _i3.CharacterSavingThrowProficiencyOverride state,
  }) = _CharacterSavingThrowProficiencyOverrideDataImpl;

  factory CharacterSavingThrowProficiencyOverrideData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSavingThrowProficiencyOverrideData(
      ability: _i2.Ability.fromJson((jsonSerialization['ability'] as String)),
      state: _i3.CharacterSavingThrowProficiencyOverride.fromJson(
          (jsonSerialization['state'] as String)),
    );
  }

  _i2.Ability ability;

  _i3.CharacterSavingThrowProficiencyOverride state;

  /// Returns a shallow copy of this [CharacterSavingThrowProficiencyOverrideData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSavingThrowProficiencyOverrideData copyWith({
    _i2.Ability? ability,
    _i3.CharacterSavingThrowProficiencyOverride? state,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'ability': ability.toJson(),
      'state': state.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _CharacterSavingThrowProficiencyOverrideDataImpl
    extends CharacterSavingThrowProficiencyOverrideData {
  _CharacterSavingThrowProficiencyOverrideDataImpl({
    required _i2.Ability ability,
    required _i3.CharacterSavingThrowProficiencyOverride state,
  }) : super._(
          ability: ability,
          state: state,
        );

  /// Returns a shallow copy of this [CharacterSavingThrowProficiencyOverrideData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSavingThrowProficiencyOverrideData copyWith({
    _i2.Ability? ability,
    _i3.CharacterSavingThrowProficiencyOverride? state,
  }) {
    return CharacterSavingThrowProficiencyOverrideData(
      ability: ability ?? this.ability,
      state: state ?? this.state,
    );
  }
}
