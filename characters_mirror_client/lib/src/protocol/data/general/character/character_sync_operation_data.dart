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
import '../../../data/general/character/character_sync_value_data.dart'
    as _i65pxzny;
import '../../../enums/character_sync_operation_type.dart' as _i3ui3qxc;
import '../../../enums/character_sync_target_type.dart' as _idvuph1d;

abstract class CharacterSyncOperationData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CharacterSyncOperationData._({
    required this.id,
    this.characterId,
    this.localCharacterId,
    required this.type,
    required this.targetType,
    this.targetId,
    this.fieldPath,
    this.value,
    this.itemPayload,
    this.baseCharacterRevision,
    this.baseTargetRevision,
    required this.createdAt,
  });

  factory CharacterSyncOperationData({
    required String id,
    int? characterId,
    int? localCharacterId,
    required _i3ui3qxc.CharacterSyncOperationType type,
    required _idvuph1d.CharacterSyncTargetType targetType,
    String? targetId,
    String? fieldPath,
    _i65pxzny.CharacterSyncValueData? value,
    _i65pxzny.CharacterSyncValueData? itemPayload,
    int? baseCharacterRevision,
    int? baseTargetRevision,
    required DateTime createdAt,
  }) = _CharacterSyncOperationDataImpl;

  factory CharacterSyncOperationData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CharacterSyncOperationData(
      id: jsonSerialization['id'] as String,
      characterId: jsonSerialization['characterId'] as int?,
      localCharacterId: jsonSerialization['localCharacterId'] as int?,
      type: _i3ui3qxc.CharacterSyncOperationType.fromJson(
        (jsonSerialization['type'] as int),
      ),
      targetType: _idvuph1d.CharacterSyncTargetType.fromJson(
        (jsonSerialization['targetType'] as int),
      ),
      targetId: jsonSerialization['targetId'] as String?,
      fieldPath: jsonSerialization['fieldPath'] as String?,
      value: jsonSerialization['value'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i65pxzny.CharacterSyncValueData>(
              jsonSerialization['value'],
            ),
      itemPayload: jsonSerialization['itemPayload'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<_i65pxzny.CharacterSyncValueData>(
              jsonSerialization['itemPayload'],
            ),
      baseCharacterRevision: jsonSerialization['baseCharacterRevision'] as int?,
      baseTargetRevision: jsonSerialization['baseTargetRevision'] as int?,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  String id;

  int? characterId;

  int? localCharacterId;

  _i3ui3qxc.CharacterSyncOperationType type;

  _idvuph1d.CharacterSyncTargetType targetType;

  String? targetId;

  String? fieldPath;

  _i65pxzny.CharacterSyncValueData? value;

  _i65pxzny.CharacterSyncValueData? itemPayload;

  int? baseCharacterRevision;

  int? baseTargetRevision;

  DateTime createdAt;

  /// Returns a shallow copy of this [CharacterSyncOperationData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CharacterSyncOperationData copyWith({
    String? id,
    int? characterId,
    int? localCharacterId,
    _i3ui3qxc.CharacterSyncOperationType? type,
    _idvuph1d.CharacterSyncTargetType? targetType,
    String? targetId,
    String? fieldPath,
    _i65pxzny.CharacterSyncValueData? value,
    _i65pxzny.CharacterSyncValueData? itemPayload,
    int? baseCharacterRevision,
    int? baseTargetRevision,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CharacterSyncOperationData',
      'id': id,
      if (characterId != null) 'characterId': characterId,
      if (localCharacterId != null) 'localCharacterId': localCharacterId,
      'type': type.toJson(),
      'targetType': targetType.toJson(),
      if (targetId != null) 'targetId': targetId,
      if (fieldPath != null) 'fieldPath': fieldPath,
      if (value != null) 'value': value?.toJson(),
      if (itemPayload != null) 'itemPayload': itemPayload?.toJson(),
      if (baseCharacterRevision != null)
        'baseCharacterRevision': baseCharacterRevision,
      if (baseTargetRevision != null) 'baseTargetRevision': baseTargetRevision,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CharacterSyncOperationData',
      'id': id,
      if (characterId != null) 'characterId': characterId,
      if (localCharacterId != null) 'localCharacterId': localCharacterId,
      'type': type.toJson(),
      'targetType': targetType.toJson(),
      if (targetId != null) 'targetId': targetId,
      if (fieldPath != null) 'fieldPath': fieldPath,
      if (value != null) 'value': value?.toJsonForProtocol(),
      if (itemPayload != null) 'itemPayload': itemPayload?.toJsonForProtocol(),
      if (baseCharacterRevision != null)
        'baseCharacterRevision': baseCharacterRevision,
      if (baseTargetRevision != null) 'baseTargetRevision': baseTargetRevision,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CharacterSyncOperationDataImpl extends CharacterSyncOperationData {
  _CharacterSyncOperationDataImpl({
    required String id,
    int? characterId,
    int? localCharacterId,
    required _i3ui3qxc.CharacterSyncOperationType type,
    required _idvuph1d.CharacterSyncTargetType targetType,
    String? targetId,
    String? fieldPath,
    _i65pxzny.CharacterSyncValueData? value,
    _i65pxzny.CharacterSyncValueData? itemPayload,
    int? baseCharacterRevision,
    int? baseTargetRevision,
    required DateTime createdAt,
  }) : super._(
         id: id,
         characterId: characterId,
         localCharacterId: localCharacterId,
         type: type,
         targetType: targetType,
         targetId: targetId,
         fieldPath: fieldPath,
         value: value,
         itemPayload: itemPayload,
         baseCharacterRevision: baseCharacterRevision,
         baseTargetRevision: baseTargetRevision,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CharacterSyncOperationData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CharacterSyncOperationData copyWith({
    String? id,
    Object? characterId = _Undefined,
    Object? localCharacterId = _Undefined,
    _i3ui3qxc.CharacterSyncOperationType? type,
    _idvuph1d.CharacterSyncTargetType? targetType,
    Object? targetId = _Undefined,
    Object? fieldPath = _Undefined,
    Object? value = _Undefined,
    Object? itemPayload = _Undefined,
    Object? baseCharacterRevision = _Undefined,
    Object? baseTargetRevision = _Undefined,
    DateTime? createdAt,
  }) {
    return CharacterSyncOperationData(
      id: id ?? this.id,
      characterId: characterId is int? ? characterId : this.characterId,
      localCharacterId: localCharacterId is int?
          ? localCharacterId
          : this.localCharacterId,
      type: type ?? this.type,
      targetType: targetType ?? this.targetType,
      targetId: targetId is String? ? targetId : this.targetId,
      fieldPath: fieldPath is String? ? fieldPath : this.fieldPath,
      value: value is _i65pxzny.CharacterSyncValueData?
          ? value
          : this.value?.copyWith(),
      itemPayload: itemPayload is _i65pxzny.CharacterSyncValueData?
          ? itemPayload
          : this.itemPayload?.copyWith(),
      baseCharacterRevision: baseCharacterRevision is int?
          ? baseCharacterRevision
          : this.baseCharacterRevision,
      baseTargetRevision: baseTargetRevision is int?
          ? baseTargetRevision
          : this.baseTargetRevision,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
