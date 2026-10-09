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

abstract class SpellResourceUpcastPolicyData implements _i1.SerializableModel {
  SpellResourceUpcastPolicyData._({
    required this.resourcePerAdditionalSpellLevel,
    required this.maxResourceCostBySourceLevel,
  });

  factory SpellResourceUpcastPolicyData({
    required int resourcePerAdditionalSpellLevel,
    required Map<int, int> maxResourceCostBySourceLevel,
  }) = _SpellResourceUpcastPolicyDataImpl;

  factory SpellResourceUpcastPolicyData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return SpellResourceUpcastPolicyData(
      resourcePerAdditionalSpellLevel:
          jsonSerialization['resourcePerAdditionalSpellLevel'] as int,
      maxResourceCostBySourceLevel:
          (jsonSerialization['maxResourceCostBySourceLevel'] as List)
              .fold<Map<int, int>>(
                  {}, (t, e) => {...t, e['k'] as int: e['v'] as int}),
    );
  }

  int resourcePerAdditionalSpellLevel;

  Map<int, int> maxResourceCostBySourceLevel;

  /// Returns a shallow copy of this [SpellResourceUpcastPolicyData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SpellResourceUpcastPolicyData copyWith({
    int? resourcePerAdditionalSpellLevel,
    Map<int, int>? maxResourceCostBySourceLevel,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'resourcePerAdditionalSpellLevel': resourcePerAdditionalSpellLevel,
      'maxResourceCostBySourceLevel': maxResourceCostBySourceLevel.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SpellResourceUpcastPolicyDataImpl extends SpellResourceUpcastPolicyData {
  _SpellResourceUpcastPolicyDataImpl({
    required int resourcePerAdditionalSpellLevel,
    required Map<int, int> maxResourceCostBySourceLevel,
  }) : super._(
          resourcePerAdditionalSpellLevel: resourcePerAdditionalSpellLevel,
          maxResourceCostBySourceLevel: maxResourceCostBySourceLevel,
        );

  /// Returns a shallow copy of this [SpellResourceUpcastPolicyData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SpellResourceUpcastPolicyData copyWith({
    int? resourcePerAdditionalSpellLevel,
    Map<int, int>? maxResourceCostBySourceLevel,
  }) {
    return SpellResourceUpcastPolicyData(
      resourcePerAdditionalSpellLevel: resourcePerAdditionalSpellLevel ??
          this.resourcePerAdditionalSpellLevel,
      maxResourceCostBySourceLevel: maxResourceCostBySourceLevel ??
          this.maxResourceCostBySourceLevel.map((
                key0,
                value0,
              ) =>
                  MapEntry(
                    key0,
                    value0,
                  )),
    );
  }
}
