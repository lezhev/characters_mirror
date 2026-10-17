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
import '../../../enums/ability.dart' as _iw3bk51e;
import '../../../enums/character_saving_throw_proficiency_override.dart'
    as _iy696g8m;

abstract class CharacterSavingThrowProficiencyOverrideData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CharacterSavingThrowProficiencyOverrideData._({
    required this.ability,
    required this.state,
  });

  factory CharacterSavingThrowProficiencyOverrideData({
    required _iw3bk51e.Ability ability,
    required _iy696g8m.CharacterSavingThrowProficiencyOverride state,
  }) = _CharacterSavingThrowProficiencyOverrideDataImpl;

  factory CharacterSavingThrowProficiencyOverrideData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSavingThrowProficiencyOverrideData(
      ability: _iw3bk51e.Ability.fromJson(
        (jsonSerialization['ability'] as String),
      ),
      state: _iy696g8m.CharacterSavingThrowProficiencyOverride.fromJson(
        (jsonSerialization['state'] as String),
      ),
    );
  }

  _iw3bk51e.Ability ability;

  _iy696g8m.CharacterSavingThrowProficiencyOverride state;

  /// Returns a shallow copy of this [CharacterSavingThrowProficiencyOverrideData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterSavingThrowProficiencyOverrideData copyWith({
    _iw3bk51e.Ability? ability,
    _iy696g8m.CharacterSavingThrowProficiencyOverride? state,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSavingThrowProficiencyOverrideData',
      'ability': ability.toJson(),
      'state': state.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSavingThrowProficiencyOverrideData',
      'ability': ability.toJson(),
      'state': state.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CharacterSavingThrowProficiencyOverrideDataImpl
    extends CharacterSavingThrowProficiencyOverrideData {
  _CharacterSavingThrowProficiencyOverrideDataImpl({
    required _iw3bk51e.Ability ability,
    required _iy696g8m.CharacterSavingThrowProficiencyOverride state,
  }) : super._(ability: ability, state: state);

  /// Returns a shallow copy of this [CharacterSavingThrowProficiencyOverrideData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterSavingThrowProficiencyOverrideData copyWith({
    _iw3bk51e.Ability? ability,
    _iy696g8m.CharacterSavingThrowProficiencyOverride? state,
  }) {
    return CharacterSavingThrowProficiencyOverrideData(
      ability: ability ?? this.ability,
      state: state ?? this.state,
    );
  }
}
