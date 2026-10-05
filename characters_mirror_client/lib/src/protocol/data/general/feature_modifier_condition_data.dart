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
  FeatureModifierConditionData._({
    required this.type,
    this.choiceGroupKey,
    this.optionKey,
  });

  factory FeatureModifierConditionData({
    required _i2.FeatureModifierConditionType type,
    String? choiceGroupKey,
    String? optionKey,
  }) = _FeatureModifierConditionDataImpl;

  factory FeatureModifierConditionData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return FeatureModifierConditionData(
      type: _i2.FeatureModifierConditionType.fromJson(
          (jsonSerialization['type'] as int)),
      choiceGroupKey: jsonSerialization['choiceGroupKey'] as String?,
      optionKey: jsonSerialization['optionKey'] as String?,
    );
  }

  _i2.FeatureModifierConditionType type;

  String? choiceGroupKey;

  String? optionKey;

  /// Returns a shallow copy of this [FeatureModifierConditionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FeatureModifierConditionData copyWith({
    _i2.FeatureModifierConditionType? type,
    String? choiceGroupKey,
    String? optionKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.toJson(),
      if (choiceGroupKey != null) 'choiceGroupKey': choiceGroupKey,
      if (optionKey != null) 'optionKey': optionKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeatureModifierConditionDataImpl extends FeatureModifierConditionData {
  _FeatureModifierConditionDataImpl({
    required _i2.FeatureModifierConditionType type,
    String? choiceGroupKey,
    String? optionKey,
  }) : super._(
          type: type,
          choiceGroupKey: choiceGroupKey,
          optionKey: optionKey,
        );

  /// Returns a shallow copy of this [FeatureModifierConditionData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FeatureModifierConditionData copyWith({
    _i2.FeatureModifierConditionType? type,
    Object? choiceGroupKey = _Undefined,
    Object? optionKey = _Undefined,
  }) {
    return FeatureModifierConditionData(
      type: type ?? this.type,
      choiceGroupKey:
          choiceGroupKey is String? ? choiceGroupKey : this.choiceGroupKey,
      optionKey: optionKey is String? ? optionKey : this.optionKey,
    );
  }
}
