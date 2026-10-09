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

abstract class LevelUpChoiceReplacementData implements _i1.SerializableModel {
  LevelUpChoiceReplacementData._({
    required this.groupKey,
    required this.selectionId,
    required this.optionKey,
  });

  factory LevelUpChoiceReplacementData({
    required String groupKey,
    required String selectionId,
    required String optionKey,
  }) = _LevelUpChoiceReplacementDataImpl;

  factory LevelUpChoiceReplacementData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return LevelUpChoiceReplacementData(
      groupKey: jsonSerialization['groupKey'] as String,
      selectionId: jsonSerialization['selectionId'] as String,
      optionKey: jsonSerialization['optionKey'] as String,
    );
  }

  String groupKey;

  String selectionId;

  String optionKey;

  /// Returns a shallow copy of this [LevelUpChoiceReplacementData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelUpChoiceReplacementData copyWith({
    String? groupKey,
    String? selectionId,
    String? optionKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'groupKey': groupKey,
      'selectionId': selectionId,
      'optionKey': optionKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LevelUpChoiceReplacementDataImpl extends LevelUpChoiceReplacementData {
  _LevelUpChoiceReplacementDataImpl({
    required String groupKey,
    required String selectionId,
    required String optionKey,
  }) : super._(
          groupKey: groupKey,
          selectionId: selectionId,
          optionKey: optionKey,
        );

  /// Returns a shallow copy of this [LevelUpChoiceReplacementData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LevelUpChoiceReplacementData copyWith({
    String? groupKey,
    String? selectionId,
    String? optionKey,
  }) {
    return LevelUpChoiceReplacementData(
      groupKey: groupKey ?? this.groupKey,
      selectionId: selectionId ?? this.selectionId,
      optionKey: optionKey ?? this.optionKey,
    );
  }
}
