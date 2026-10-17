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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../enums/ability.dart' as _if5gaqs5;
import '../../enums/feature_modifier_rounding.dart' as _ijlxkxqt;
import '../../enums/feature_modifier_value_kind.dart' as _irkf8rfu;

abstract class FeatureModifierValueData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  FeatureModifierValueData._({
    required this.kind,
    this.staticValue,
    this.progression,
    this.numerator,
    this.denominator,
    this.rounding,
    this.abilityModifiers,
  });

  factory FeatureModifierValueData({
    required _irkf8rfu.FeatureModifierValueKind kind,
    int? staticValue,
    Map<int, int>? progression,
    int? numerator,
    int? denominator,
    _ijlxkxqt.FeatureModifierRounding? rounding,
    List<_if5gaqs5.Ability>? abilityModifiers,
  }) = _FeatureModifierValueDataImpl;

  factory FeatureModifierValueData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return FeatureModifierValueData(
      kind: _irkf8rfu.FeatureModifierValueKind.fromJson(
        (jsonSerialization['kind'] as int),
      ),
      staticValue: jsonSerialization['staticValue'] as int?,
      progression: jsonSerialization['progression'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['progression'],
            ),
      numerator: jsonSerialization['numerator'] as int?,
      denominator: jsonSerialization['denominator'] as int?,
      rounding: jsonSerialization['rounding'] == null
          ? null
          : _ijlxkxqt.FeatureModifierRounding.fromJson(
              (jsonSerialization['rounding'] as int),
            ),
      abilityModifiers: jsonSerialization['abilityModifiers'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<List<_if5gaqs5.Ability>>(
              jsonSerialization['abilityModifiers'],
            ),
    );
  }

  _irkf8rfu.FeatureModifierValueKind kind;

  int? staticValue;

  Map<int, int>? progression;

  int? numerator;

  int? denominator;

  _ijlxkxqt.FeatureModifierRounding? rounding;

  List<_if5gaqs5.Ability>? abilityModifiers;

  /// Returns a shallow copy of this [FeatureModifierValueData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeatureModifierValueData copyWith({
    _irkf8rfu.FeatureModifierValueKind? kind,
    int? staticValue,
    Map<int, int>? progression,
    int? numerator,
    int? denominator,
    _ijlxkxqt.FeatureModifierRounding? rounding,
    List<_if5gaqs5.Ability>? abilityModifiers,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeatureModifierValueData',
      'kind': kind.toJson(),
      if (staticValue != null) 'staticValue': staticValue,
      if (progression != null) 'progression': progression?.toJson(),
      if (numerator != null) 'numerator': numerator,
      if (denominator != null) 'denominator': denominator,
      if (rounding != null) 'rounding': rounding?.toJson(),
      if (abilityModifiers != null)
        'abilityModifiers': abilityModifiers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeatureModifierValueData',
      'kind': kind.toJson(),
      if (staticValue != null) 'staticValue': staticValue,
      if (progression != null) 'progression': progression?.toJson(),
      if (numerator != null) 'numerator': numerator,
      if (denominator != null) 'denominator': denominator,
      if (rounding != null) 'rounding': rounding?.toJson(),
      if (abilityModifiers != null)
        'abilityModifiers': abilityModifiers?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierValueDataImpl extends FeatureModifierValueData {
  _FeatureModifierValueDataImpl({
    required _irkf8rfu.FeatureModifierValueKind kind,
    int? staticValue,
    Map<int, int>? progression,
    int? numerator,
    int? denominator,
    _ijlxkxqt.FeatureModifierRounding? rounding,
    List<_if5gaqs5.Ability>? abilityModifiers,
  }) : super._(
         kind: kind,
         staticValue: staticValue,
         progression: progression,
         numerator: numerator,
         denominator: denominator,
         rounding: rounding,
         abilityModifiers: abilityModifiers,
       );

  /// Returns a shallow copy of this [FeatureModifierValueData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeatureModifierValueData copyWith({
    _irkf8rfu.FeatureModifierValueKind? kind,
    Object? staticValue = _Undefined,
    Object? progression = _Undefined,
    Object? numerator = _Undefined,
    Object? denominator = _Undefined,
    Object? rounding = _Undefined,
    Object? abilityModifiers = _Undefined,
  }) {
    return FeatureModifierValueData(
      kind: kind ?? this.kind,
      staticValue: staticValue is int? ? staticValue : this.staticValue,
      progression: progression is Map<int, int>?
          ? progression
          : this.progression?.map((key0, value0) => MapEntry(key0, value0)),
      numerator: numerator is int? ? numerator : this.numerator,
      denominator: denominator is int? ? denominator : this.denominator,
      rounding: rounding is _ijlxkxqt.FeatureModifierRounding?
          ? rounding
          : this.rounding,
      abilityModifiers: abilityModifiers is List<_if5gaqs5.Ability>?
          ? abilityModifiers
          : this.abilityModifiers?.map((e0) => e0).toList(),
    );
  }
}
