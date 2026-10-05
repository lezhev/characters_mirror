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
import '../../enums/feature_modifier_value_kind.dart' as _i2;
import '../../enums/feature_modifier_rounding.dart' as _i3;

abstract class FeatureModifierValueData implements _i1.SerializableModel {
  FeatureModifierValueData._({
    required this.kind,
    this.staticValue,
    this.progression,
    this.numerator,
    this.denominator,
    this.rounding,
  });

  factory FeatureModifierValueData({
    required _i2.FeatureModifierValueKind kind,
    int? staticValue,
    Map<int, int>? progression,
    int? numerator,
    int? denominator,
    _i3.FeatureModifierRounding? rounding,
  }) = _FeatureModifierValueDataImpl;

  factory FeatureModifierValueData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureModifierValueData(
      kind: _i2.FeatureModifierValueKind.fromJson(
          (jsonSerialization['kind'] as int)),
      staticValue: jsonSerialization['staticValue'] as int?,
      progression: (jsonSerialization['progression'] as List?)
          ?.fold<Map<int, int>>(
              {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
      numerator: jsonSerialization['numerator'] as int?,
      denominator: jsonSerialization['denominator'] as int?,
      rounding: jsonSerialization['rounding'] == null
          ? null
          : _i3.FeatureModifierRounding.fromJson(
              (jsonSerialization['rounding'] as int)),
    );
  }

  _i2.FeatureModifierValueKind kind;

  int? staticValue;

  Map<int, int>? progression;

  int? numerator;

  int? denominator;

  _i3.FeatureModifierRounding? rounding;

  /// Returns a shallow copy of this [FeatureModifierValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureModifierValueData copyWith({
    _i2.FeatureModifierValueKind? kind,
    int? staticValue,
    Map<int, int>? progression,
    int? numerator,
    int? denominator,
    _i3.FeatureModifierRounding? rounding,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'kind': kind.toJson(),
      if (staticValue != null) 'staticValue': staticValue,
      if (progression != null) 'progression': progression?.toJson(),
      if (numerator != null) 'numerator': numerator,
      if (denominator != null) 'denominator': denominator,
      if (rounding != null) 'rounding': rounding?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierValueDataImpl extends FeatureModifierValueData {
  _FeatureModifierValueDataImpl({
    required _i2.FeatureModifierValueKind kind,
    int? staticValue,
    Map<int, int>? progression,
    int? numerator,
    int? denominator,
    _i3.FeatureModifierRounding? rounding,
  }) : super._(
          kind: kind,
          staticValue: staticValue,
          progression: progression,
          numerator: numerator,
          denominator: denominator,
          rounding: rounding,
        );

  /// Returns a shallow copy of this [FeatureModifierValueData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureModifierValueData copyWith({
    _i2.FeatureModifierValueKind? kind,
    Object? staticValue = _Undefined,
    Object? progression = _Undefined,
    Object? numerator = _Undefined,
    Object? denominator = _Undefined,
    Object? rounding = _Undefined,
  }) {
    return FeatureModifierValueData(
      kind: kind ?? this.kind,
      staticValue: staticValue is int? ? staticValue : this.staticValue,
      progression: progression is Map<int, int>?
          ? progression
          : this.progression?.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
      numerator: numerator is int? ? numerator : this.numerator,
      denominator: denominator is int? ? denominator : this.denominator,
      rounding:
          rounding is _i3.FeatureModifierRounding? ? rounding : this.rounding,
    );
  }
}
