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
import '../data/general/choice_requirement_data.dart' as _i2;

abstract class ChoiceRequirementFailureView implements _i1.SerializableModel {
  ChoiceRequirementFailureView._({
    this.requirement,
    required this.reason,
    this.actualValue,
  });

  factory ChoiceRequirementFailureView({
    _i2.ChoiceRequirementData? requirement,
    required String reason,
    int? actualValue,
  }) = _ChoiceRequirementFailureViewImpl;

  factory ChoiceRequirementFailureView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChoiceRequirementFailureView(
      requirement: jsonSerialization['requirement'] == null
          ? null
          : _i2.ChoiceRequirementData.fromJson(
              (jsonSerialization['requirement'] as Map<String, dynamic>)),
      reason: jsonSerialization['reason'] as String,
      actualValue: jsonSerialization['actualValue'] as int?,
    );
  }

  _i2.ChoiceRequirementData? requirement;

  String reason;

  int? actualValue;

  /// Returns a shallow copy of this [ChoiceRequirementFailureView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChoiceRequirementFailureView copyWith({
    _i2.ChoiceRequirementData? requirement,
    String? reason,
    int? actualValue,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (requirement != null) 'requirement': requirement?.toJson(),
      'reason': reason,
      if (actualValue != null) 'actualValue': actualValue,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceRequirementFailureViewImpl extends ChoiceRequirementFailureView {
  _ChoiceRequirementFailureViewImpl({
    _i2.ChoiceRequirementData? requirement,
    required String reason,
    int? actualValue,
  }) : super._(
          requirement: requirement,
          reason: reason,
          actualValue: actualValue,
        );

  /// Returns a shallow copy of this [ChoiceRequirementFailureView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChoiceRequirementFailureView copyWith({
    Object? requirement = _Undefined,
    String? reason,
    Object? actualValue = _Undefined,
  }) {
    return ChoiceRequirementFailureView(
      requirement: requirement is _i2.ChoiceRequirementData?
          ? requirement
          : this.requirement?.copyWith(),
      reason: reason ?? this.reason,
      actualValue: actualValue is int? ? actualValue : this.actualValue,
    );
  }
}
