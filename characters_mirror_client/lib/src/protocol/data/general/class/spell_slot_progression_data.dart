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

abstract class SpellSlotProgressionData
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SpellSlotProgressionData._({
    this.id,
    this.tableKey,
    required this.level,
    this.spellSlots,
    this.source,
    this.version,
    this.createdAt,
    this.updatedAt,
  });

  factory SpellSlotProgressionData({
    int? id,
    String? tableKey,
    required int level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpellSlotProgressionDataImpl;

  factory SpellSlotProgressionData.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SpellSlotProgressionData(
      id: jsonSerialization['id'] as int?,
      tableKey: jsonSerialization['tableKey'] as String?,
      level: jsonSerialization['level'] as int,
      spellSlots: jsonSerialization['spellSlots'] == null
          ? null
          : _isnx6jbi.Protocol().deserialize<Map<int, int>>(
              jsonSerialization['spellSlots'],
            ),
      source: jsonSerialization['source'] as String?,
      version: jsonSerialization['version'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? tableKey;

  int level;

  Map<int, int>? spellSlots;

  String? source;

  int? version;

  DateTime? createdAt;

  DateTime? updatedAt;

  /// Returns a shallow copy of this [SpellSlotProgressionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SpellSlotProgressionData copyWith({
    int? id,
    String? tableKey,
    int? level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpellSlotProgressionData',
      if (id != null) 'id': id,
      if (tableKey != null) 'tableKey': tableKey,
      'level': level,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpellSlotProgressionData',
      if (id != null) 'id': id,
      if (tableKey != null) 'tableKey': tableKey,
      'level': level,
      if (spellSlots != null) 'spellSlots': spellSlots?.toJson(),
      if (source != null) 'source': source,
      if (version != null) 'version': version,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpellSlotProgressionDataImpl extends SpellSlotProgressionData {
  _SpellSlotProgressionDataImpl({
    int? id,
    String? tableKey,
    required int level,
    Map<int, int>? spellSlots,
    String? source,
    int? version,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         tableKey: tableKey,
         level: level,
         spellSlots: spellSlots,
         source: source,
         version: version,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SpellSlotProgressionData]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SpellSlotProgressionData copyWith({
    Object? id = _Undefined,
    Object? tableKey = _Undefined,
    int? level,
    Object? spellSlots = _Undefined,
    Object? source = _Undefined,
    Object? version = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return SpellSlotProgressionData(
      id: id is int? ? id : this.id,
      tableKey: tableKey is String? ? tableKey : this.tableKey,
      level: level ?? this.level,
      spellSlots: spellSlots is Map<int, int>?
          ? spellSlots
          : this.spellSlots?.map((key0, value0) => MapEntry(key0, value0)),
      source: source is String? ? source : this.source,
      version: version is int? ? version : this.version,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}
