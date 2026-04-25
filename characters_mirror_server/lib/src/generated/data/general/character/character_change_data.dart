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
import '../../../enums/character_change_type.dart' as _i2;
import '../../../enums/character_entity_type.dart' as _i3;
import '../../../data/general/character/character_data.dart' as _i4;

abstract class CharacterChangeData
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
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
    required _i2.CharacterChangeType changeType,
    required _i3.CharacterEntityType entityType,
    required String entityId,
    _i4.CharacterData? payload,
    required DateTime createdAt,
    DateTime? baseUpdatedAt,
  }) = _CharacterChangeDataImpl;

  factory CharacterChangeData.fromJson(Map<String, dynamic> jsonSerialization) {
    return CharacterChangeData(
      id: jsonSerialization['id'] as String,
      changeType: _i2.CharacterChangeType.fromJson(
          (jsonSerialization['changeType'] as int)),
      entityType: _i3.CharacterEntityType.fromJson(
          (jsonSerialization['entityType'] as int)),
      entityId: jsonSerialization['entityId'] as String,
      payload: jsonSerialization['payload'] == null
          ? null
          : _i4.CharacterData.fromJson(
              (jsonSerialization['payload'] as Map<String, dynamic>)),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      baseUpdatedAt: jsonSerialization['baseUpdatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['baseUpdatedAt']),
    );
  }

  String id;

  _i2.CharacterChangeType changeType;

  _i3.CharacterEntityType entityType;

  String entityId;

  _i4.CharacterData? payload;

  DateTime createdAt;

  DateTime? baseUpdatedAt;

  /// Returns a shallow copy of this [CharacterChangeData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CharacterChangeData copyWith({
    String? id,
    _i2.CharacterChangeType? changeType,
    _i3.CharacterEntityType? entityType,
    String? entityId,
    _i4.CharacterData? payload,
    DateTime? createdAt,
    DateTime? baseUpdatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
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
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterChangeDataImpl extends CharacterChangeData {
  _CharacterChangeDataImpl({
    required String id,
    required _i2.CharacterChangeType changeType,
    required _i3.CharacterEntityType entityType,
    required String entityId,
    _i4.CharacterData? payload,
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
  @_i1.useResult
  @override
  CharacterChangeData copyWith({
    String? id,
    _i2.CharacterChangeType? changeType,
    _i3.CharacterEntityType? entityType,
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
      payload:
          payload is _i4.CharacterData? ? payload : this.payload?.copyWith(),
      createdAt: createdAt ?? this.createdAt,
      baseUpdatedAt:
          baseUpdatedAt is DateTime? ? baseUpdatedAt : this.baseUpdatedAt,
    );
  }
}
