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
import '../../../enums/prepared_spell_rounding.dart' as _ivj7epzb;

abstract class PreparedSpellRuleData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PreparedSpellRuleData._({
    required this.ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    required this.rounding,
    int? flatBonus,
    int? minimum,
  }) : classLevelNumerator = classLevelNumerator ?? 1,
       classLevelDenominator = classLevelDenominator ?? 1,
       flatBonus = flatBonus ?? 0,
       minimum = minimum ?? 1;

  factory PreparedSpellRuleData({
    required _iw3bk51e.Ability ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    required _ivj7epzb.PreparedSpellRounding rounding,
    int? flatBonus,
    int? minimum,
  }) = _PreparedSpellRuleDataImpl;

  factory PreparedSpellRuleData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return PreparedSpellRuleData(
      ability: _iw3bk51e.Ability.fromJson(
        (jsonSerialization['ability'] as String),
      ),
      classLevelNumerator: jsonSerialization['classLevelNumerator'] as int?,
      classLevelDenominator: jsonSerialization['classLevelDenominator'] as int?,
      rounding: _ivj7epzb.PreparedSpellRounding.fromJson(
        (jsonSerialization['rounding'] as String),
      ),
      flatBonus: jsonSerialization['flatBonus'] as int?,
      minimum: jsonSerialization['minimum'] as int?,
    );
  }

  _iw3bk51e.Ability ability;

  int classLevelNumerator;

  int classLevelDenominator;

  _ivj7epzb.PreparedSpellRounding rounding;

  int flatBonus;

  int minimum;

  /// Returns a shallow copy of this [PreparedSpellRuleData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PreparedSpellRuleData copyWith({
    _iw3bk51e.Ability? ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    _ivj7epzb.PreparedSpellRounding? rounding,
    int? flatBonus,
    int? minimum,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PreparedSpellRuleData',
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
      '__className__': 'PreparedSpellRuleData',
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
    return _is.SerializationManager.encode(this);
  }
}

class _PreparedSpellRuleDataImpl extends PreparedSpellRuleData {
  _PreparedSpellRuleDataImpl({
    required _iw3bk51e.Ability ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    required _ivj7epzb.PreparedSpellRounding rounding,
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
  @_is.useResult
  @override
  PreparedSpellRuleData copyWith({
    _iw3bk51e.Ability? ability,
    int? classLevelNumerator,
    int? classLevelDenominator,
    _ivj7epzb.PreparedSpellRounding? rounding,
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
