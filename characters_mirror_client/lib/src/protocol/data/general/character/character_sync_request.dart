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
import '../../../data/general/character/character_change_data.dart' as _i2;
import '../../../data/general/character/character_sync_operation_data.dart'
    as _i3;

abstract class CharacterSyncRequest implements _i1.SerializableModel {
  CharacterSyncRequest._({
    this.changes,
    this.operations,
    this.pullSince,
    this.pullAfterEventId,
    this.fullResync,
    this.syncProtocolVersion,
  });

  factory CharacterSyncRequest({
    List<_i2.CharacterChangeData>? changes,
    List<_i3.CharacterSyncOperationData>? operations,
    DateTime? pullSince,
    int? pullAfterEventId,
    bool? fullResync,
    int? syncProtocolVersion,
  }) = _CharacterSyncRequestImpl;

  factory CharacterSyncRequest.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSyncRequest(
      changes: (jsonSerialization['changes'] as List?)
          ?.map((e) =>
              _i2.CharacterChangeData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      operations: (jsonSerialization['operations'] as List?)
          ?.map((e) => _i3.CharacterSyncOperationData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      pullSince: jsonSerialization['pullSince'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['pullSince']),
      pullAfterEventId: jsonSerialization['pullAfterEventId'] as int?,
      fullResync: jsonSerialization['fullResync'] as bool?,
      syncProtocolVersion: jsonSerialization['syncProtocolVersion'] as int?,
    );
  }

  List<_i2.CharacterChangeData>? changes;

  List<_i3.CharacterSyncOperationData>? operations;

  DateTime? pullSince;

  int? pullAfterEventId;

  bool? fullResync;

  int? syncProtocolVersion;

  /// Returns a shallow copy of this [CharacterSyncRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSyncRequest copyWith({
    List<_i2.CharacterChangeData>? changes,
    List<_i3.CharacterSyncOperationData>? operations,
    DateTime? pullSince,
    int? pullAfterEventId,
    bool? fullResync,
    int? syncProtocolVersion,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (changes != null)
        'changes': changes?.toJson(valueToJson: (v) => v.toJson()),
      if (operations != null)
        'operations': operations?.toJson(valueToJson: (v) => v.toJson()),
      if (pullSince != null) 'pullSince': pullSince?.toJson(),
      if (pullAfterEventId != null) 'pullAfterEventId': pullAfterEventId,
      if (fullResync != null) 'fullResync': fullResync,
      if (syncProtocolVersion != null)
        'syncProtocolVersion': syncProtocolVersion,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncRequestImpl extends CharacterSyncRequest {
  _CharacterSyncRequestImpl({
    List<_i2.CharacterChangeData>? changes,
    List<_i3.CharacterSyncOperationData>? operations,
    DateTime? pullSince,
    int? pullAfterEventId,
    bool? fullResync,
    int? syncProtocolVersion,
  }) : super._(
          changes: changes,
          operations: operations,
          pullSince: pullSince,
          pullAfterEventId: pullAfterEventId,
          fullResync: fullResync,
          syncProtocolVersion: syncProtocolVersion,
        );

  /// Returns a shallow copy of this [CharacterSyncRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSyncRequest copyWith({
    Object? changes = _Undefined,
    Object? operations = _Undefined,
    Object? pullSince = _Undefined,
    Object? pullAfterEventId = _Undefined,
    Object? fullResync = _Undefined,
    Object? syncProtocolVersion = _Undefined,
  }) {
    return CharacterSyncRequest(
      changes: changes is List<_i2.CharacterChangeData>?
          ? changes
          : this.changes?.map((e0) => e0.copyWith()).toList(),
      operations: operations is List<_i3.CharacterSyncOperationData>?
          ? operations
          : this.operations?.map((e0) => e0.copyWith()).toList(),
      pullSince: pullSince is DateTime? ? pullSince : this.pullSince,
      pullAfterEventId:
          pullAfterEventId is int? ? pullAfterEventId : this.pullAfterEventId,
      fullResync: fullResync is bool? ? fullResync : this.fullResync,
      syncProtocolVersion: syncProtocolVersion is int?
          ? syncProtocolVersion
          : this.syncProtocolVersion,
    );
  }
}
