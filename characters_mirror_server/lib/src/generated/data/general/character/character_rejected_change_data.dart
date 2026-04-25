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
import '../../../data/general/character/character_data.dart' as _i2;

abstract class CharacterRejectedChangeData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  CharacterRejectedChangeData._({
    required this.changeId,
    this.reason,
    this.message,
    this.character,
  });

  factory CharacterRejectedChangeData({
    required String changeId,
    String? reason,
    String? message,
    _i2.CharacterData? character,
  }) = _CharacterRejectedChangeDataImpl;

  factory CharacterRejectedChangeData.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return CharacterRejectedChangeData(
      changeId: jsonSerialization['changeId'] as String,
      reason: jsonSerialization['reason'] as String?,
      message: jsonSerialization['message'] as String?,
      character: jsonSerialization['character'] == null
          ? null
          : _i2.CharacterData.fromJson(
              (jsonSerialization['character'] as Map<String, dynamic>)),
    );
  }

  String changeId;

  String? reason;

  String? message;

  _i2.CharacterData? character;

  /// Returns a shallow copy of this [CharacterRejectedChangeData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterRejectedChangeData copyWith({
    String? changeId,
    String? reason,
    String? message,
    _i2.CharacterData? character,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'changeId': changeId,
      if (reason != null) 'reason': reason,
      if (message != null) 'message': message,
      if (character != null) 'character': character?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'changeId': changeId,
      if (reason != null) 'reason': reason,
      if (message != null) 'message': message,
      if (character != null) 'character': character?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterRejectedChangeDataImpl extends CharacterRejectedChangeData {
  _CharacterRejectedChangeDataImpl({
    required String changeId,
    String? reason,
    String? message,
    _i2.CharacterData? character,
  }) : super._(
          changeId: changeId,
          reason: reason,
          message: message,
          character: character,
        );

  /// Returns a shallow copy of this [CharacterRejectedChangeData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CharacterRejectedChangeData copyWith({
    String? changeId,
    Object? reason = _Undefined,
    Object? message = _Undefined,
    Object? character = _Undefined,
  }) {
    return CharacterRejectedChangeData(
      changeId: changeId ?? this.changeId,
      reason: reason is String? ? reason : this.reason,
      message: message is String? ? message : this.message,
      character: character is _i2.CharacterData?
          ? character
          : this.character?.copyWith(),
    );
  }
}
