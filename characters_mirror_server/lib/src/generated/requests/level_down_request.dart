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
import '../requests/level_down_choice_repair.dart' as _i2;

abstract class LevelDownRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  LevelDownRequest._({
    required this.characterId,
    required this.expectedVersion,
    required this.classEntryId,
    this.repairs,
  });

  factory LevelDownRequest({
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    List<_i2.LevelDownChoiceRepair>? repairs,
  }) = _LevelDownRequestImpl;

  factory LevelDownRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelDownRequest(
      characterId: jsonSerialization['characterId'] as int,
      expectedVersion: jsonSerialization['expectedVersion'] as int,
      classEntryId: jsonSerialization['classEntryId'] as String,
      repairs: (jsonSerialization['repairs'] as List?)
          ?.map((e) =>
              _i2.LevelDownChoiceRepair.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  int characterId;

  int expectedVersion;

  String classEntryId;

  List<_i2.LevelDownChoiceRepair>? repairs;

  /// Returns a shallow copy of this [LevelDownRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LevelDownRequest copyWith({
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    List<_i2.LevelDownChoiceRepair>? repairs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'characterId': characterId,
      'expectedVersion': expectedVersion,
      'classEntryId': classEntryId,
      if (repairs != null)
        'repairs': repairs?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'characterId': characterId,
      'expectedVersion': expectedVersion,
      'classEntryId': classEntryId,
      if (repairs != null)
        'repairs': repairs?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelDownRequestImpl extends LevelDownRequest {
  _LevelDownRequestImpl({
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    List<_i2.LevelDownChoiceRepair>? repairs,
  }) : super._(
          characterId: characterId,
          expectedVersion: expectedVersion,
          classEntryId: classEntryId,
          repairs: repairs,
        );

  /// Returns a shallow copy of this [LevelDownRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LevelDownRequest copyWith({
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    Object? repairs = _Undefined,
  }) {
    return LevelDownRequest(
      characterId: characterId ?? this.characterId,
      expectedVersion: expectedVersion ?? this.expectedVersion,
      classEntryId: classEntryId ?? this.classEntryId,
      repairs: repairs is List<_i2.LevelDownChoiceRepair>?
          ? repairs
          : this.repairs?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
