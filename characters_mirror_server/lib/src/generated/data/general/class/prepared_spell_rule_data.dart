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
import '../../../enums/ability.dart' as _i2;
import '../../../enums/prepared_spell_rounding.dart' as _i3;

abstract class PreparedSpellRuleData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  PreparedSpellRuleData._({
    required this.ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    required this.rounding,
    int? flatBonus,
    int? minimum,
  })  : classLevelNumerator = classLevelNumerator ?? 1,
        classLevelDenominator = classLevelDenominator ?? 1,
        flatBonus = flatBonus ?? 0,
        minimum = minimum ?? 1;

  factory PreparedSpellRuleData({
    required _i2.Ability ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    required _i3.PreparedSpellRounding rounding,
    int? flatBonus,
    int? minimum,
  }) = _PreparedSpellRuleDataImpl;

  factory PreparedSpellRuleData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return PreparedSpellRuleData(
      ability: _i2.Ability.fromJson((jsonSerialization['ability'] as String)),
      classLevelNumerator: jsonSerialization['classLevelNumerator'] as int,
      classLevelDenominator: jsonSerialization['classLevelDenominator'] as int,
      rounding: _i3.PreparedSpellRounding.fromJson(
          (jsonSerialization['rounding'] as String)),
      flatBonus: jsonSerialization['flatBonus'] as int,
      minimum: jsonSerialization['minimum'] as int,
    );
  }

  _i2.Ability ability;

  int classLevelNumerator;

  int classLevelDenominator;

  _i3.PreparedSpellRounding rounding;

  int flatBonus;

  int minimum;

  /// Returns a shallow copy of this [PreparedSpellRuleData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PreparedSpellRuleData copyWith({
    _i2.Ability? ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    _i3.PreparedSpellRounding? rounding,
    int? flatBonus,
    int? minimum,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'ability': ability.toJson(),
      'classLevelNumerator': classLevelNumerator,
      'classLevelDenominator': classLevelDenominator,
      'rounding': rounding.toJson(),
      'flatBonus': flatBonus,
      'minimum': minimum,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'ability': ability.toJson(),
      'classLevelNumerator': classLevelNumerator,
      'classLevelDenominator': classLevelDenominator,
      'rounding': rounding.toJson(),
      'flatBonus': flatBonus,
      'minimum': minimum,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _PreparedSpellRuleDataImpl extends PreparedSpellRuleData {
  _PreparedSpellRuleDataImpl({
    required _i2.Ability ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    required _i3.PreparedSpellRounding rounding,
    int? flatBonus,
    int? minimum,
  }) : super._(
          ability: ability,
          classLevelNumerator: classLevelNumerator,
          classLevelDenominator: classLevelDenominator,
          rounding: rounding,
          flatBonus: flatBonus,
          minimum: minimum,
        );

  /// Returns a shallow copy of this [PreparedSpellRuleData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PreparedSpellRuleData copyWith({
    _i2.Ability? ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    _i3.PreparedSpellRounding? rounding,
    int? flatBonus,
    int? minimum,
  }) {
    return PreparedSpellRuleData(
      ability: ability ?? this.ability,
      classLevelNumerator: classLevelNumerator ?? this.classLevelNumerator,
      classLevelDenominator:
          classLevelDenominator ?? this.classLevelDenominator,
      rounding: rounding ?? this.rounding,
      flatBonus: flatBonus ?? this.flatBonus,
      minimum: minimum ?? this.minimum,
    );
  }
}
