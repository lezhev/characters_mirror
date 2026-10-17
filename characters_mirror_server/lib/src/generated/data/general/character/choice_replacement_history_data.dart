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

abstract class ChoiceReplacementHistoryData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ChoiceReplacementHistoryData._({
    required this.classLevel,
    required this.previousOptionKey,
    this.replacementGroupKey,
  });

  factory ChoiceReplacementHistoryData({
    required int classLevel,
    required String previousOptionKey,
    String? replacementGroupKey,
  }) = _ChoiceReplacementHistoryDataImpl;

  factory ChoiceReplacementHistoryData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChoiceReplacementHistoryData(
      classLevel: jsonSerialization['classLevel'] as int,
      previousOptionKey: jsonSerialization['previousOptionKey'] as String,
      replacementGroupKey: jsonSerialization['replacementGroupKey'] as String?,
    );
  }

  int classLevel;

  String previousOptionKey;

  String? replacementGroupKey;

  /// Returns a shallow copy of this [ChoiceReplacementHistoryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ChoiceReplacementHistoryData copyWith({
    int? classLevel,
    String? previousOptionKey,
    String? replacementGroupKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChoiceReplacementHistoryData',
      'classLevel': classLevel,
      'previousOptionKey': previousOptionKey,
      if (replacementGroupKey != null)
        'replacementGroupKey': replacementGroupKey,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChoiceReplacementHistoryData',
      'classLevel': classLevel,
      'previousOptionKey': previousOptionKey,
      if (replacementGroupKey != null)
        'replacementGroupKey': replacementGroupKey,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChoiceReplacementHistoryDataImpl extends ChoiceReplacementHistoryData {
  _ChoiceReplacementHistoryDataImpl({
    required int classLevel,
    required String previousOptionKey,
    String? replacementGroupKey,
  }) : super._(
         classLevel: classLevel,
         previousOptionKey: previousOptionKey,
         replacementGroupKey: replacementGroupKey,
       );

  /// Returns a shallow copy of this [ChoiceReplacementHistoryData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ChoiceReplacementHistoryData copyWith({
    int? classLevel,
    String? previousOptionKey,
    Object? replacementGroupKey = _Undefined,
  }) {
    return ChoiceReplacementHistoryData(
      classLevel: classLevel ?? this.classLevel,
      previousOptionKey: previousOptionKey ?? this.previousOptionKey,
      replacementGroupKey: replacementGroupKey is String?
          ? replacementGroupKey
          : this.replacementGroupKey,
    );
  }
}
