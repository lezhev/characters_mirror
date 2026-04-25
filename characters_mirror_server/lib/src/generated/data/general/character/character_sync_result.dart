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
import '../../../data/general/character/character_sync_status.dart' as _i2;
import '../../../data/general/character/character_data.dart' as _i3;

abstract class CharacterSyncResult
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterSyncResult._({
    required this.status,
    this.character,
    this.conflictCharacter,
    this.message,
  });

  factory CharacterSyncResult({
    required _i2.CharacterSyncStatus status,
    _i3.CharacterData? character,
    _i3.CharacterData? conflictCharacter,
    String? message,
  }) = _CharacterSyncResultImpl;

  factory CharacterSyncResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterSyncResult(
      status: _i2.CharacterSyncStatus.fromJson(
          (jsonSerialization['status'] as int)),
      character: jsonSerialization['character'] == null
          ? null
          : _i3.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
      conflictCharacter: jsonSerialization['conflictCharacter'] == null
          ? null
          : _i3.CharacterData.fromJson(
              (jsonSerialization['conflictCharacter'] as Map<String, dynamic>)),
      message: jsonSerialization['message'] as String?,
    );
  }

  _i2.CharacterSyncStatus status;

  _i3.CharacterData? character;

  _i3.CharacterData? conflictCharacter;

  String? message;

  /// Returns a shallow copy of this [CharacterSyncResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterSyncResult copyWith({
    _i2.CharacterSyncStatus? status,
    _i3.CharacterData? character,
    _i3.CharacterData? conflictCharacter,
    String? message,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
      'status': status.toJson(),
      if (character != null) 'character': character?.toJsonForProtocol(),
      if (conflictCharacter != null)
        'conflictCharacter': conflictCharacter?.toJsonForProtocol(),
      if (message != null) 'message': message,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncResultImpl extends CharacterSyncResult {
  _CharacterSyncResultImpl({
    required _i2.CharacterSyncStatus status,
    _i3.CharacterData? character,
    _i3.CharacterData? conflictCharacter,
    String? message,
  }) : super._(
          status: status,
          character: character,
          conflictCharacter: conflictCharacter,
          message: message,
        );

  /// Returns a shallow copy of this [CharacterSyncResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterSyncResult copyWith({
    _i2.CharacterSyncStatus? status,
    Object? character = _Undefined,
    Object? conflictCharacter = _Undefined,
    Object? message = _Undefined,
  }) {
    return CharacterSyncResult(
      status: status ?? this.status,
      character: character is _i3.CharacterData?
          ? character
          : this.character?.copyWith(),
      conflictCharacter: conflictCharacter is _i3.CharacterData?
          ? conflictCharacter
          : this.conflictCharacter?.copyWith(),
      message: message is String? ? message : this.message,
    );
  }
}
