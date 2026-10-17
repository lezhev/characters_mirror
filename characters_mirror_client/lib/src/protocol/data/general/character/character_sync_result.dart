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
import '../../../data/general/character/character_sync_status.dart'
    as _ivhkr1he;

abstract class CharacterSyncResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterSyncResult._({
    required this.status,
    this.character,
    this.conflictCharacter,
    this.message,
  });

  factory CharacterSyncResult({
    required _ivhkr1he.CharacterSyncStatus status,
    _isbrf1qr.CharacterData? character,
    _isbrf1qr.CharacterData? conflictCharacter,
    String? message,
  }) = _CharacterSyncResultImpl;

  factory CharacterSyncResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterSyncResult(
      status: _ivhkr1he.CharacterSyncStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      character: jsonSerialization['character'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_isbrf1qr.CharacterData>(
              jsonSerialization['character'],
            ),
      conflictCharacter: jsonSerialization['conflictCharacter'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_isbrf1qr.CharacterData>(
              jsonSerialization['conflictCharacter'],
            ),
      message: jsonSerialization['message'] as String?,
    );
  }

  _ivhkr1he.CharacterSyncStatus status;

  _isbrf1qr.CharacterData? character;

  _isbrf1qr.CharacterData? conflictCharacter;

  String? message;

  /// Returns a shallow copy of this [CharacterSyncResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterSyncResult copyWith({
    _ivhkr1he.CharacterSyncStatus? status,
    _isbrf1qr.CharacterData? character,
    _isbrf1qr.CharacterData? conflictCharacter,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSyncResult',
      'status': status.toJson(),
      if (character != null) 'character': character?.toJson(),
      if (conflictCharacter != null)
        'conflictCharacter': conflictCharacter?.toJson(),
      if (message != null) 'message': message,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSyncResult',
      'status': status.toJson(),
      if (character != null) 'character': character?.toJsonForProtocol(),
      if (conflictCharacter != null)
        'conflictCharacter': conflictCharacter?.toJsonForProtocol(),
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncResultImpl extends CharacterSyncResult {
  _CharacterSyncResultImpl({
    required _ivhkr1he.CharacterSyncStatus status,
    _isbrf1qr.CharacterData? character,
    _isbrf1qr.CharacterData? conflictCharacter,
    String? message,
  }) : super._(
         status: status,
         character: character,
         conflictCharacter: conflictCharacter,
         message: message,
       );

  /// Returns a shallow copy of this [CharacterSyncResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterSyncResult copyWith({
    _ivhkr1he.CharacterSyncStatus? status,
    Object? character = _Undefined,
    Object? conflictCharacter = _Undefined,
    Object? message = _Undefined,
  }) {
    return CharacterSyncResult(
      status: status ?? this.status,
      character: character is _isbrf1qr.CharacterData?
          ? character
          : this.character?.copyWith(),
      conflictCharacter: conflictCharacter is _isbrf1qr.CharacterData?
          ? conflictCharacter
          : this.conflictCharacter?.copyWith(),
      message: message is String? ? message : this.message,
    );
  }
}
