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

abstract class LevelDownInvalidChoiceView implements _i1.SerializableModel {
  LevelDownInvalidChoiceView._({
    required this.groupKey,
    required this.selectionIndex,
    required this.optionKey,
    required this.reason,
    required this.eligibleAlternativeOptionKeys,
  });

  factory LevelDownInvalidChoiceView({
    required String groupKey,
    required int selectionIndex,
    required String optionKey,
    required String reason,
    required List<String> eligibleAlternativeOptionKeys,
  }) = _LevelDownInvalidChoiceViewImpl;

  factory LevelDownInvalidChoiceView.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return LevelDownInvalidChoiceView(
      groupKey: jsonSerialization['groupKey'] as String,
      selectionIndex: jsonSerialization['selectionIndex'] as int,
      optionKey: jsonSerialization['optionKey'] as String,
      reason: jsonSerialization['reason'] as String,
      eligibleAlternativeOptionKeys:
          (jsonSerialization['eligibleAlternativeOptionKeys'] as List)
              .map((e) => e as String)
              .toList(),
    );
  }

  String groupKey;

  int selectionIndex;

  String optionKey;

  String reason;

  List<String> eligibleAlternativeOptionKeys;

  /// Returns a shallow copy of this [LevelDownInvalidChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelDownInvalidChoiceView copyWith({
    String? groupKey,
    int? selectionIndex,
    String? optionKey,
    String? reason,
    List<String>? eligibleAlternativeOptionKeys,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'groupKey': groupKey,
      'selectionIndex': selectionIndex,
      'optionKey': optionKey,
      'reason': reason,
      'eligibleAlternativeOptionKeys': eligibleAlternativeOptionKeys.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LevelDownInvalidChoiceViewImpl extends LevelDownInvalidChoiceView {
  _LevelDownInvalidChoiceViewImpl({
    required String groupKey,
    required int selectionIndex,
    required String optionKey,
    required String reason,
    required List<String> eligibleAlternativeOptionKeys,
  }) : super._(
          groupKey: groupKey,
          selectionIndex: selectionIndex,
          optionKey: optionKey,
          reason: reason,
          eligibleAlternativeOptionKeys: eligibleAlternativeOptionKeys,
        );

  /// Returns a shallow copy of this [LevelDownInvalidChoiceView]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LevelDownInvalidChoiceView copyWith({
    String? groupKey,
    int? selectionIndex,
    String? optionKey,
    String? reason,
    List<String>? eligibleAlternativeOptionKeys,
  }) {
    return LevelDownInvalidChoiceView(
      groupKey: groupKey ?? this.groupKey,
      selectionIndex: selectionIndex ?? this.selectionIndex,
      optionKey: optionKey ?? this.optionKey,
      reason: reason ?? this.reason,
      eligibleAlternativeOptionKeys: eligibleAlternativeOptionKeys ??
          this.eligibleAlternativeOptionKeys.map((e0) => e0).toList(),
    );
  }
}
