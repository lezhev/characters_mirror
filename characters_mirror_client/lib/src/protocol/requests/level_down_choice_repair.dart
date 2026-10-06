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

abstract class LevelDownChoiceRepair implements _i1.SerializableModel {
  LevelDownChoiceRepair._({
    required this.groupKey,
    required this.selectionIndex,
    required this.currentOptionKey,
    required this.replacementOptionKey,
  });

  factory LevelDownChoiceRepair({
    required String groupKey,
    required int selectionIndex,
    required String currentOptionKey,
    required String replacementOptionKey,
  }) = _LevelDownChoiceRepairImpl;

  factory LevelDownChoiceRepair.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return LevelDownChoiceRepair(
      groupKey: jsonSerialization['groupKey'] as String,
      selectionIndex: jsonSerialization['selectionIndex'] as int,
      currentOptionKey: jsonSerialization['currentOptionKey'] as String,
      replacementOptionKey: jsonSerialization['replacementOptionKey'] as String,
    );
  }

  String groupKey;

  int selectionIndex;

  String currentOptionKey;

  String replacementOptionKey;

  /// Returns a shallow copy of this [LevelDownChoiceRepair]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelDownChoiceRepair copyWith({
    String? groupKey,
    int? selectionIndex,
    String? currentOptionKey,
    String? replacementOptionKey,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'groupKey': groupKey,
      'selectionIndex': selectionIndex,
      'currentOptionKey': currentOptionKey,
      'replacementOptionKey': replacementOptionKey,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _LevelDownChoiceRepairImpl extends LevelDownChoiceRepair {
  _LevelDownChoiceRepairImpl({
    required String groupKey,
    required int selectionIndex,
    required String currentOptionKey,
    required String replacementOptionKey,
  }) : super._(
          groupKey: groupKey,
          selectionIndex: selectionIndex,
          currentOptionKey: currentOptionKey,
          replacementOptionKey: replacementOptionKey,
        );

  /// Returns a shallow copy of this [LevelDownChoiceRepair]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LevelDownChoiceRepair copyWith({
    String? groupKey,
    int? selectionIndex,
    String? currentOptionKey,
    String? replacementOptionKey,
  }) {
    return LevelDownChoiceRepair(
      groupKey: groupKey ?? this.groupKey,
      selectionIndex: selectionIndex ?? this.selectionIndex,
      currentOptionKey: currentOptionKey ?? this.currentOptionKey,
      replacementOptionKey: replacementOptionKey ?? this.replacementOptionKey,
    );
  }
}
