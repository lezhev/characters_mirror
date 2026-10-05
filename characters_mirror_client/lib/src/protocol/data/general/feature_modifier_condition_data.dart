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
import '../../enums/feature_modifier_condition_type.dart' as _i2;

abstract class FeatureModifierConditionData implements _i1.SerializableModel {
  FeatureModifierConditionData._({required this.type});

  factory FeatureModifierConditionData(
          {required _i2.FeatureModifierConditionType type}) =
      _FeatureModifierConditionDataImpl;

  factory FeatureModifierConditionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureModifierConditionData(
        type: _i2.FeatureModifierConditionType.fromJson(
            (jsonSerialization['type'] as int)));
  }

  _i2.FeatureModifierConditionType type;

  /// Returns a shallow copy of this [FeatureModifierConditionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureModifierConditionData copyWith(
      {_i2.FeatureModifierConditionType? type});
  @override
  Map<String, dynamic> toJson() {
    return {'type': type.toJson()};
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _FeatureModifierConditionDataImpl extends FeatureModifierConditionData {
  _FeatureModifierConditionDataImpl(
      {required _i2.FeatureModifierConditionType type})
      : super._(type: type);

  /// Returns a shallow copy of this [FeatureModifierConditionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureModifierConditionData copyWith(
      {_i2.FeatureModifierConditionType? type}) {
    return FeatureModifierConditionData(type: type ?? this.type);
  }
}
