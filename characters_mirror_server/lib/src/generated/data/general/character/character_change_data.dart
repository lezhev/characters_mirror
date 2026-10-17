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
import 'package:characters_mirror_server/src/generated/protocol.dart'
    as _ikmnmw29;
import 'package:serverpod/serverpod.dart' as _is;
import '../../../data/general/character/character_data.dart' as _isbrf1qr;
import '../../../enums/character_change_type.dart' as _ifby6flz;
import '../../../enums/character_entity_type.dart' as _i5z86n8e;

abstract class CharacterChangeData
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CharacterChangeData._({
    required this.id,
    required this.changeType,
    required this.entityType,
    required this.entityId,
    this.payload,
    required this.createdAt,
    this.baseUpdatedAt,
  });

  factory CharacterChangeData({
    required String id,
    required _ifby6flz.CharacterChangeType changeType,
    required _i5z86n8e.CharacterEntityType entityType,
    required String entityId,
    _isbrf1qr.CharacterData? payload,
    required DateTime createdAt,
    DateTime? baseUpdatedAt,
  }) = _CharacterChangeDataImpl;

  factory CharacterChangeData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChangeData(
      id: jsonSerialization['id'] as String,
      changeType: _ifby6flz.CharacterChangeType.fromJson(
        (jsonSerialization['changeType'] as int),
      ),
      entityType: _i5z86n8e.CharacterEntityType.fromJson(
        (jsonSerialization['entityType'] as int),
      ),
      entityId: jsonSerialization['entityId'] as String,
      payload: jsonSerialization['payload'] == null
          ? null
          : _ikmnmw29.Protocol().deserialize<_isbrf1qr.CharacterData>(
              jsonSerialization['payload'],
            ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      baseUpdatedAt: jsonSerialization['baseUpdatedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['baseUpdatedAt'],
            ),
    );
  }

  String id;

  _ifby6flz.CharacterChangeType changeType;

  _i5z86n8e.CharacterEntityType entityType;

  String entityId;

  _isbrf1qr.CharacterData? payload;

  DateTime createdAt;

  DateTime? baseUpdatedAt;

  /// Returns a shallow copy of this [CharacterChangeData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CharacterChangeData copyWith({
    String? id,
    _ifby6flz.CharacterChangeType? changeType,
    _i5z86n8e.CharacterEntityType? entityType,
    String? entityId,
    _isbrf1qr.CharacterData? payload,
    DateTime? createdAt,
    DateTime? baseUpdatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterChangeData',
      'id': id,
      'changeType': changeType.toJson(),
      'entityType': entityType.toJson(),
      'entityId': entityId,
      if (payload != null) 'payload': payload?.toJson(),
      'createdAt': createdAt.toJson(),
      if (baseUpdatedAt != null) 'baseUpdatedAt': baseUpdatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterChangeData',
      'id': id,
      'changeType': changeType.toJson(),
      'entityType': entityType.toJson(),
      'entityId': entityId,
      if (payload != null) 'payload': payload?.toJsonForProtocol(),
      'createdAt': createdAt.toJson(),
      if (baseUpdatedAt != null) 'baseUpdatedAt': baseUpdatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChangeDataImpl extends CharacterChangeData {
  _CharacterChangeDataImpl({
    required String id,
    required _ifby6flz.CharacterChangeType changeType,
    required _i5z86n8e.CharacterEntityType entityType,
    required String entityId,
    _isbrf1qr.CharacterData? payload,
    required DateTime createdAt,
    DateTime? baseUpdatedAt,
  }) : super._(
         id: id,
         changeType: changeType,
         entityType: entityType,
         entityId: entityId,
         payload: payload,
         createdAt: createdAt,
         baseUpdatedAt: baseUpdatedAt,
       );

  /// Returns a shallow copy of this [CharacterChangeData]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CharacterChangeData copyWith({
    String? id,
    _ifby6flz.CharacterChangeType? changeType,
    _i5z86n8e.CharacterEntityType? entityType,
    String? entityId,
    Object? payload = _Undefined,
    DateTime? createdAt,
    Object? baseUpdatedAt = _Undefined,
  }) {
    return CharacterChangeData(
      id: id ?? this.id,
      changeType: changeType ?? this.changeType,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      payload: payload is _isbrf1qr.CharacterData?
          ? payload
          : this.payload?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      baseUpdatedAt: baseUpdatedAt is DateTime?
          ? baseUpdatedAt
          : this.baseUpdatedAt,
    );
  }
}
