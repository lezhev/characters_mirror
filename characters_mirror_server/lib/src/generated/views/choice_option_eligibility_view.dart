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
import '../views/choice_requirement_failure_view.dart' as _i2;

abstract class ChoiceOptionEligibilityView
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChoiceOptionEligibilityView._({
    required this.optionKey,
    required this.isEligible,
    this.failedRequirements,
  });

  factory ChoiceOptionEligibilityView({
    required String optionKey,
    required bool isEligible,
    List<_i2.ChoiceRequirementFailureView>? failedRequirements,
  }) = _ChoiceOptionEligibilityViewImpl;

  factory ChoiceOptionEligibilityView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return ChoiceOptionEligibilityView(
      optionKey: jsonSerialization['optionKey'] as String,
      isEligible: jsonSerialization['isEligible'] as bool,
      failedRequirements: (jsonSerialization['failedRequirements'] as List?)
          ?.map((e) => _i2.ChoiceRequirementFailureView.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
    );
  }

  String optionKey;

  bool isEligible;

  List<_i2.ChoiceRequirementFailureView>? failedRequirements;

  /// Returns a shallow copy of this [ChoiceOptionEligibilityView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChoiceOptionEligibilityView copyWith({
    String? optionKey,
    bool? isEligible,
    List<_i2.ChoiceRequirementFailureView>? failedRequirements,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'optionKey': optionKey,
      'isEligible': isEligible,
      if (failedRequirements != null)
        'failedRequirements':
            failedRequirements?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'optionKey': optionKey,
      'isEligible': isEligible,
      if (failedRequirements != null)
        'failedRequirements': failedRequirements?.toJson(
            valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceOptionEligibilityViewImpl extends ChoiceOptionEligibilityView {
  _ChoiceOptionEligibilityViewImpl({
    required String optionKey,
    required bool isEligible,
    List<_i2.ChoiceRequirementFailureView>? failedRequirements,
  }) : super._(
          optionKey: optionKey,
          isEligible: isEligible,
          failedRequirements: failedRequirements,
        );

  /// Returns a shallow copy of this [ChoiceOptionEligibilityView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChoiceOptionEligibilityView copyWith({
    String? optionKey,
    bool? isEligible,
    Object? failedRequirements = _Undefined,
  }) {
    return ChoiceOptionEligibilityView(
      optionKey: optionKey ?? this.optionKey,
      isEligible: isEligible ?? this.isEligible,
      failedRequirements:
          failedRequirements is List<_i2.ChoiceRequirementFailureView>?
              ? failedRequirements
              : this.failedRequirements?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
