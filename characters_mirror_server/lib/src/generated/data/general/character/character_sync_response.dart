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
import '../../../data/general/character/character_rejected_change_data.dart'
    as _i2;
import '../../../data/general/character/character_data.dart' as _i3;

abstract class CharacterSyncResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterSyncResponse._({
    this.acknowledgedChangeIds,
    this.rejectedChanges,
    this.characters,
    this.serverTime,
  });

  factory CharacterSyncResponse({
    List<String>? acknowledgedChangeIds,
    List<_i2.CharacterRejectedChangeData>? rejectedChanges,
    List<_i3.CharacterData>? characters,
    DateTime? serverTime,
  }) = _CharacterSyncResponseImpl;

  factory CharacterSyncResponse.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterSyncResponse(
      acknowledgedChangeIds:
          (jsonSerialization['acknowledgedChangeIds'] as List?)
              ?.map((e) => e as String)
              .toList(),
      rejectedChanges: (jsonSerialization['rejectedChanges'] as List?)
          ?.map((e) => _i2.CharacterRejectedChangeData.fromJson(
              (e as Map<String, dynamic>)))
          .toList(),
      characters: (jsonSerialization['characters'] as List?)
          ?.map((e) => _i3.CharacterData.fromJson((e as Map<String, dynamic>)))
          .toList(),
      serverTime: jsonSerialization['serverTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['serverTime']),
    );
  }

  List<String>? acknowledgedChangeIds;

  List<_i2.CharacterRejectedChangeData>? rejectedChanges;

  List<_i3.CharacterData>? characters;

  DateTime? serverTime;

  /// Returns a shallow copy of this [CharacterSyncResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSyncResponse copyWith({
    List<String>? acknowledgedChangeIds,
    List<_i2.CharacterRejectedChangeData>? rejectedChanges,
    List<_i3.CharacterData>? characters,
    DateTime? serverTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (acknowledgedChangeIds != null)
        'acknowledgedChangeIds': acknowledgedChangeIds?.toJson(),
      if (rejectedChanges != null)
        'rejectedChanges':
            rejectedChanges?.toJson(valueToJson: (v) => v.toJson()),
      if (characters != null)
        'characters': characters?.toJson(valueToJson: (v) => v.toJson()),
      if (serverTime != null) 'serverTime': serverTime?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (acknowledgedChangeIds != null)
        'acknowledgedChangeIds': acknowledgedChangeIds?.toJson(),
      if (rejectedChanges != null)
        'rejectedChanges':
            rejectedChanges?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (characters != null)
        'characters':
            characters?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      if (serverTime != null) 'serverTime': serverTime?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncResponseImpl extends CharacterSyncResponse {
  _CharacterSyncResponseImpl({
    List<String>? acknowledgedChangeIds,
    List<_i2.CharacterRejectedChangeData>? rejectedChanges,
    List<_i3.CharacterData>? characters,
    DateTime? serverTime,
  }) : super._(
          acknowledgedChangeIds: acknowledgedChangeIds,
          rejectedChanges: rejectedChanges,
          characters: characters,
          serverTime: serverTime,
        );

  /// Returns a shallow copy of this [CharacterSyncResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSyncResponse copyWith({
    Object? acknowledgedChangeIds = _Undefined,
    Object? rejectedChanges = _Undefined,
    Object? characters = _Undefined,
    Object? serverTime = _Undefined,
  }) {
    return CharacterSyncResponse(
      acknowledgedChangeIds: acknowledgedChangeIds is List<String>?
          ? acknowledgedChangeIds
          : this.acknowledgedChangeIds?.map((e0) => e0).toList(),
      rejectedChanges: rejectedChanges is List<_i2.CharacterRejectedChangeData>?
          ? rejectedChanges
          : this.rejectedChanges?.map((e0) => e0.copyWith()).toList(),
      characters: characters is List<_i3.CharacterData>?
          ? characters
          : this.characters?.map((e0) => e0.copyWith()).toList(),
      serverTime: serverTime is DateTime? ? serverTime : this.serverTime,
    );
  }
}
