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
import '../views/choice_requirement_failure_view.dart' as _ium34bdn;

abstract class ChoiceOptionEligibilityView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChoiceOptionEligibilityView._({
    required this.optionKey,
    required this.isEligible,
    this.failedRequirements,
  });

  factory ChoiceOptionEligibilityView({
    required String optionKey,
    required bool isEligible,
    List<_ium34bdn.ChoiceRequirementFailureView>? failedRequirements,
  }) = _ChoiceOptionEligibilityViewImpl;

  factory ChoiceOptionEligibilityView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChoiceOptionEligibilityView(
      optionKey: jsonSerialization['optionKey'] as String,
      isEligible: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isEligible'],
      ),
      failedRequirements: jsonSerialization['failedRequirements'] == null
          ? null
          : _ikmnmw29.Protocol()
                .deserialize<List<_ium34bdn.ChoiceRequirementFailureView>>(
                  jsonSerialization['failedRequirements'],
                ),
    );
  }

  String optionKey;

  bool isEligible;

  List<_ium34bdn.ChoiceRequirementFailureView>? failedRequirements;

  /// Returns a shallow copy of this [ChoiceOptionEligibilityView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChoiceOptionEligibilityView copyWith({
    String? optionKey,
    bool? isEligible,
    List<_ium34bdn.ChoiceRequirementFailureView>? failedRequirements,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChoiceOptionEligibilityView',
      'optionKey': optionKey,
      'isEligible': isEligible,
      if (failedRequirements != null)
        'failedRequirements': failedRequirements?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChoiceOptionEligibilityView',
      'optionKey': optionKey,
      'isEligible': isEligible,
      if (failedRequirements != null)
        'failedRequirements': failedRequirements?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceOptionEligibilityViewImpl extends ChoiceOptionEligibilityView {
  _ChoiceOptionEligibilityViewImpl({
    required String optionKey,
    required bool isEligible,
    List<_ium34bdn.ChoiceRequirementFailureView>? failedRequirements,
  }) : super._(
         optionKey: optionKey,
         isEligible: isEligible,
         failedRequirements: failedRequirements,
       );

  /// Returns a shallow copy of this [ChoiceOptionEligibilityView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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
          failedRequirements is List<_ium34bdn.ChoiceRequirementFailureView>?
          ? failedRequirements
          : this.failedRequirements?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
