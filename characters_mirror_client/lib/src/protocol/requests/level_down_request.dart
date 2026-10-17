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
import 'package:characters_mirror_client/src/protocol/protocol.dart'
    as _isnx6jbi;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../requests/level_down_choice_repair.dart' as _it9fvwyh;

abstract class LevelDownRequest
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    List<_it9fvwyh.LevelDownChoiceRepair>? repairs,
  }) = _LevelDownRequestImpl;

  factory LevelDownRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return LevelDownRequest(
      characterId: jsonSerialization['characterId'] as int,
      expectedVersion: jsonSerialization['expectedVersion'] as int,
      classEntryId: jsonSerialization['classEntryId'] as String,
      repairs: jsonSerialization['repairs'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_it9fvwyh.LevelDownChoiceRepair>>(
                  jsonSerialization['repairs'],
                ),
    );
  }

  int characterId;

  int expectedVersion;

  String classEntryId;

  List<_it9fvwyh.LevelDownChoiceRepair>? repairs;

  /// Returns a shallow copy of this [LevelDownRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LevelDownRequest copyWith({
    int? characterId,
    int? expectedVersion,
    String? classEntryId,
    List<_it9fvwyh.LevelDownChoiceRepair>? repairs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LevelDownRequest',
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
      '__className__': 'LevelDownRequest',
      'characterId': characterId,
      'expectedVersion': expectedVersion,
      'classEntryId': classEntryId,
      if (repairs != null)
        'repairs': repairs?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LevelDownRequestImpl extends LevelDownRequest {
  _LevelDownRequestImpl({
    required int characterId,
    required int expectedVersion,
    required String classEntryId,
    List<_it9fvwyh.LevelDownChoiceRepair>? repairs,
  }) : super._(
         characterId: characterId,
         expectedVersion: expectedVersion,
         classEntryId: classEntryId,
         repairs: repairs,
       );

  /// Returns a shallow copy of this [LevelDownRequest]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
      repairs: repairs is List<_it9fvwyh.LevelDownChoiceRepair>?
          ? repairs
          : this.repairs?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
