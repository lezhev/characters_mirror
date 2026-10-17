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
import '../../../data/general/character/character_data.dart' as _isbrf1qr;
import '../../../data/general/character/character_rejected_change_data.dart'
    as _ihrug7t0;

abstract class CharacterSyncResponse
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterSyncResponse._({
    this.acknowledgedChangeIds,
    this.rejectedChanges,
    this.characters,
    this.changedCharacters,
    this.serverTime,
    this.pullCursor,
    this.deletedCharacterIds,
    this.syncProtocolVersion,
    this.capabilities,
  });

  factory CharacterSyncResponse({
    List<String>? acknowledgedChangeIds,
    List<_ihrug7t0.CharacterRejectedChangeData>? rejectedChanges,
    List<_isbrf1qr.CharacterData>? characters,
    Map<String, _isbrf1qr.CharacterData>? changedCharacters,
    DateTime? serverTime,
    int? pullCursor,
    List<int>? deletedCharacterIds,
    int? syncProtocolVersion,
    List<String>? capabilities,
  }) = _CharacterSyncResponseImpl;

  factory CharacterSyncResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSyncResponse(
      acknowledgedChangeIds: jsonSerialization['acknowledgedChangeIds'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['acknowledgedChangeIds'],
            ),
      rejectedChanges: jsonSerialization['rejectedChanges'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<List<_ihrug7t0.CharacterRejectedChangeData>>(
                  jsonSerialization['rejectedChanges'],
                ),
      characters: jsonSerialization['characters'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<_isbrf1qr.CharacterData>>(
              jsonSerialization['characters'],
            ),
      changedCharacters: jsonSerialization['changedCharacters'] == null
          ? null
          : _isnx6jbi.Protocol()
                .deserialize<Map<String, _isbrf1qr.CharacterData>>(
                  jsonSerialization['changedCharacters'],
                ),
      serverTime: jsonSerialization['serverTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['serverTime'],
            ),
      pullCursor: jsonSerialization['pullCursor'] as int?,
      deletedCharacterIds: jsonSerialization['deletedCharacterIds'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<int>>(
              jsonSerialization['deletedCharacterIds'],
            ),
      syncProtocolVersion: jsonSerialization['syncProtocolVersion'] as int?,
      capabilities: jsonSerialization['capabilities'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<List<String>>(
              jsonSerialization['capabilities'],
            ),
    );
  }

  List<String>? acknowledgedChangeIds;

  List<_ihrug7t0.CharacterRejectedChangeData>? rejectedChanges;

  List<_isbrf1qr.CharacterData>? characters;

  Map<String, _isbrf1qr.CharacterData>? changedCharacters;

  DateTime? serverTime;

  int? pullCursor;

  List<int>? deletedCharacterIds;

  int? syncProtocolVersion;

  List<String>? capabilities;

  /// Returns a shallow copy of this [CharacterSyncResponse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterSyncResponse copyWith({
    List<String>? acknowledgedChangeIds,
    List<_ihrug7t0.CharacterRejectedChangeData>? rejectedChanges,
    List<_isbrf1qr.CharacterData>? characters,
    Map<String, _isbrf1qr.CharacterData>? changedCharacters,
    DateTime? serverTime,
    int? pullCursor,
    List<int>? deletedCharacterIds,
    int? syncProtocolVersion,
    List<String>? capabilities,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSyncResponse',
      if (acknowledgedChangeIds != null)
        'acknowledgedChangeIds': acknowledgedChangeIds?.toJson(),
      if (rejectedChanges != null)
        'rejectedChanges': rejectedChanges?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (characters != null)
        'characters': characters?.toJson(valueToJson: (v) => v.toJson()),
      if (changedCharacters != null)
        'changedCharacters': changedCharacters?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
      if (serverTime != null) 'serverTime': serverTime?.toJson(),
      if (pullCursor != null) 'pullCursor': pullCursor,
      if (deletedCharacterIds != null)
        'deletedCharacterIds': deletedCharacterIds?.toJson(),
      if (syncProtocolVersion != null)
        'syncProtocolVersion': syncProtocolVersion,
      if (capabilities != null) 'capabilities': capabilities?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSyncResponse',
      if (acknowledgedChangeIds != null)
        'acknowledgedChangeIds': acknowledgedChangeIds?.toJson(),
      if (rejectedChanges != null)
        'rejectedChanges': rejectedChanges?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (characters != null)
        'characters': characters?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (changedCharacters != null)
        'changedCharacters': changedCharacters?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
      if (serverTime != null) 'serverTime': serverTime?.toJson(),
      if (pullCursor != null) 'pullCursor': pullCursor,
      if (deletedCharacterIds != null)
        'deletedCharacterIds': deletedCharacterIds?.toJson(),
      if (syncProtocolVersion != null)
        'syncProtocolVersion': syncProtocolVersion,
      if (capabilities != null) 'capabilities': capabilities?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncResponseImpl extends CharacterSyncResponse {
  _CharacterSyncResponseImpl({
    List<String>? acknowledgedChangeIds,
    List<_ihrug7t0.CharacterRejectedChangeData>? rejectedChanges,
    List<_isbrf1qr.CharacterData>? characters,
    Map<String, _isbrf1qr.CharacterData>? changedCharacters,
    DateTime? serverTime,
    int? pullCursor,
    List<int>? deletedCharacterIds,
    int? syncProtocolVersion,
    List<String>? capabilities,
  }) : super._(
         acknowledgedChangeIds: acknowledgedChangeIds,
         rejectedChanges: rejectedChanges,
         characters: characters,
         changedCharacters: changedCharacters,
         serverTime: serverTime,
         pullCursor: pullCursor,
         deletedCharacterIds: deletedCharacterIds,
         syncProtocolVersion: syncProtocolVersion,
         capabilities: capabilities,
       );

  /// Returns a shallow copy of this [CharacterSyncResponse]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterSyncResponse copyWith({
    Object? acknowledgedChangeIds = _Undefined,
    Object? rejectedChanges = _Undefined,
    Object? characters = _Undefined,
    Object? changedCharacters = _Undefined,
    Object? serverTime = _Undefined,
    Object? pullCursor = _Undefined,
    Object? deletedCharacterIds = _Undefined,
    Object? syncProtocolVersion = _Undefined,
    Object? capabilities = _Undefined,
  }) {
    return CharacterSyncResponse(
      acknowledgedChangeIds: acknowledgedChangeIds is List<String>?
          ? acknowledgedChangeIds
          : this.acknowledgedChangeIds?.map((e0) => e0).toList(),
      rejectedChanges:
          rejectedChanges is List<_ihrug7t0.CharacterRejectedChangeData>?
          ? rejectedChanges
          : this.rejectedChanges?.map((e0) => e0.copyWith()).toList(),
      characters: characters is List<_isbrf1qr.CharacterData>?
          ? characters
          : this.characters?.map((e0) => e0.copyWith()).toList(),
      changedCharacters:
          changedCharacters is Map<String, _isbrf1qr.CharacterData>?
          ? changedCharacters
          : this.changedCharacters?.map(
              (key0, value0) => MapEntry(key0, value0.copyWith()),
            ),
      serverTime: serverTime is DateTime? ? serverTime : this.serverTime,
      pullCursor: pullCursor is int? ? pullCursor : this.pullCursor,
      deletedCharacterIds: deletedCharacterIds is List<int>?
          ? deletedCharacterIds
          : this.deletedCharacterIds?.map((e0) => e0).toList(),
      syncProtocolVersion: syncProtocolVersion is int?
          ? syncProtocolVersion
          : this.syncProtocolVersion,
      capabilities: capabilities is List<String>?
          ? capabilities
          : this.capabilities?.map((e0) => e0).toList(),
    );
  }
}
