import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_mutation_stamper.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_dev_log.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_sync_operations.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

part 'offline_cache_database_native/reference_cache_operations.dart';
part 'offline_cache_database_native/character_read_operations.dart';
part 'offline_cache_database_native/character_write_operations.dart';
part 'offline_cache_database_native/sync_meta_operations.dart';

enum OfflineCharacterSyncStatus {
  clean,
  dirty,
  deleting,
  conflict,
}

enum OfflineCharacterSyncOperation {
  upsert,
  delete,
}

enum OfflineCharacterChangeStatus {
  pending,
  processing,
  failed,
  conflict,
}

class OfflineCharacterRecord {
  const OfflineCharacterRecord({
    required this.userId,
    required this.localId,
    required this.character,
    required this.status,
    this.serverId,
    this.baseVersion,
    this.baseUpdatedAt,
    this.baseCharacter,
    this.operation,
    this.lastSyncError,
    this.conflictCharacter,
  });

  final int userId;
  final int localId;
  final int? serverId;
  final CharacterData character;
  final int? baseVersion;
  final DateTime? baseUpdatedAt;
  final CharacterData? baseCharacter;
  final OfflineCharacterSyncStatus status;
  final OfflineCharacterSyncOperation? operation;
  final String? lastSyncError;
  final CharacterData? conflictCharacter;

  bool get isPending =>
      status == OfflineCharacterSyncStatus.dirty ||
      status == OfflineCharacterSyncStatus.deleting;
  bool get isConflict => status == OfflineCharacterSyncStatus.conflict;
}

class OfflineCharacterChange {
  const OfflineCharacterChange({
    required this.id,
    required this.userId,
    required this.changeType,
    required this.entityType,
    required this.entityId,
    required this.createdAt,
    required this.status,
    this.payload,
    this.operationData,
    this.baseUpdatedAt,
    this.lastError,
  });

  final String id;
  final int userId;
  final CharacterChangeType changeType;
  final CharacterEntityType entityType;
  final String entityId;
  final CharacterData? payload;
  final CharacterSyncOperationData? operationData;
  final DateTime createdAt;
  final DateTime? baseUpdatedAt;
  final OfflineCharacterChangeStatus status;
  final String? lastError;
}

class OfflineCacheDatabase {
  OfflineCacheDatabase._(this._db);

  final Database _db;

  static Future<OfflineCacheDatabase> openDefault() async {
    final directory = await getApplicationSupportDirectory();
    await Directory(directory.path).create(recursive: true);
    return openAt(
      p.join(directory.path, 'characters_mirror_offline_v5.sqlite'),
    );
  }

  static Future<OfflineCacheDatabase> openAt(String path) async {
    final db = sqlite3.open(path);
    final cache = OfflineCacheDatabase._(db);
    cache._createSchema();
    return cache;
  }

  static OfflineCacheDatabase openInMemory() {
    final cache = OfflineCacheDatabase._(sqlite3.openInMemory());
    cache._createSchema();
    return cache;
  }

  void close() {
    _db.dispose();
  }

  T _runTransaction<T>(T Function() action) {
    _db.execute('BEGIN IMMEDIATE');
    try {
      final result = action();
      _db.execute('COMMIT');
      return result;
    } catch (_) {
      _db.execute('ROLLBACK');
      rethrow;
    }
  }

  void _createSchema() {
    _db.execute('PRAGMA foreign_keys = ON');
    _db.execute('''
CREATE TABLE IF NOT EXISTS offline_meta (
  user_id INTEGER NOT NULL,
  key TEXT NOT NULL,
  value TEXT NOT NULL,
  PRIMARY KEY (user_id, key)
)
''');
    _db.execute('''
CREATE TABLE IF NOT EXISTS reference_cache (
  kind TEXT NOT NULL,
  cache_key TEXT NOT NULL,
  payload_json TEXT NOT NULL,
  fetched_at TEXT NOT NULL,
  PRIMARY KEY (kind, cache_key)
)
''');
    _db.execute('''
CREATE TABLE IF NOT EXISTS characters_cache (
  user_id INTEGER NOT NULL,
  local_id INTEGER NOT NULL,
  server_id INTEGER,
  payload_json TEXT NOT NULL,
  base_payload_json TEXT,
  base_version INTEGER,
  base_updated_at TEXT,
  sync_status TEXT NOT NULL,
  sync_operation TEXT,
  local_updated_at TEXT NOT NULL,
  server_updated_at TEXT,
  last_sync_error TEXT,
  conflict_payload_json TEXT,
  PRIMARY KEY (user_id, local_id)
)
''');
    _db.execute('''
CREATE UNIQUE INDEX IF NOT EXISTS characters_cache_server_id_idx
ON characters_cache(user_id, server_id)
WHERE server_id IS NOT NULL
''');
    _db.execute('''
CREATE TABLE IF NOT EXISTS character_changes (
  id TEXT PRIMARY KEY,
  user_id INTEGER NOT NULL,
  change_type TEXT NOT NULL,
  entity_type TEXT NOT NULL,
  entity_id TEXT NOT NULL,
  payload_json TEXT,
  created_at TEXT NOT NULL,
  base_updated_at TEXT,
  status TEXT NOT NULL,
  last_error TEXT
)
''');
    _db.execute('''
CREATE INDEX IF NOT EXISTS character_changes_user_created_idx
ON character_changes(user_id, created_at)
''');

    _ensureColumn(
      table: 'characters_cache',
      column: 'base_updated_at',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'operation_type',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'target_type',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'target_id',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'field_path',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'operation_character_id',
      definition: 'INTEGER',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'operation_local_character_id',
      definition: 'INTEGER',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'value_json',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'item_payload_json',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'base_character_revision',
      definition: 'INTEGER',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'base_target_revision',
      definition: 'INTEGER',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'conflict_payload_json',
      definition: 'TEXT',
    );
    _ensureColumn(
      table: 'character_changes',
      column: 'rejected_at',
      definition: 'TEXT',
    );
  }

  void _ensureColumn({
    required String table,
    required String column,
    required String definition,
  }) {
    final rows = _db.select('PRAGMA table_info($table)');
    final hasColumn = rows.any((row) => row['name'] == column);
    if (!hasColumn) {
      _db.execute('ALTER TABLE $table ADD COLUMN $column $definition');
    }
  }

  Future<int> _allocateLocalId(int userId) async {
    final key = 'next_negative_local_id';
    final current = _readMeta(userId, key);
    final next = int.tryParse(current ?? '') ?? -1;
    _writeMeta(userId, key, (next - 1).toString());
    return next;
  }

  void _enqueueChange(OfflineCharacterChange change) {
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO character_changes(
  id, user_id, change_type, entity_type, entity_id, payload_json,
  created_at, base_updated_at, status, last_error, operation_type,
  target_type, target_id, field_path, operation_character_id,
  operation_local_character_id, value_json, item_payload_json,
  base_character_revision, base_target_revision
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      final operation = change.operationData;
      stmt.execute([
        change.id,
        change.userId,
        change.changeType.name,
        change.entityType.name,
        change.entityId,
        change.payload == null ? null : jsonEncode(change.payload!.toJson()),
        change.createdAt.toUtc().toIso8601String(),
        change.baseUpdatedAt?.toUtc().toIso8601String(),
        change.status.name,
        change.lastError,
        operation?.type.name,
        operation?.targetType.name,
        operation?.targetId,
        operation?.fieldPath,
        operation?.characterId,
        operation?.localCharacterId,
        operation?.value == null ? null : _encodeSyncValue(operation!.value!),
        operation?.itemPayload == null
            ? null
            : _encodeSyncValue(operation!.itemPayload!),
        operation?.baseCharacterRevision,
        operation?.baseTargetRevision,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  String? _readMeta(int userId, String key) {
    final stmt = _db.prepare('''
SELECT value FROM offline_meta
WHERE user_id = ? AND key = ?
LIMIT 1
''');
    try {
      final rows = stmt.select([userId, key]);
      return rows.isEmpty ? null : rows.first['value'] as String;
    } finally {
      stmt.dispose();
    }
  }

  void _writeMeta(int userId, String key, String value) {
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO offline_meta(user_id, key, value)
VALUES (?, ?, ?)
''');
    try {
      stmt.execute([userId, key, value]);
    } finally {
      stmt.dispose();
    }
  }

  OfflineCharacterRecord _rowToCharacterRecord(Row row) {
    final payloadJson = row['payload_json'] as String;
    final basePayloadJson = row['base_payload_json'] as String?;
    final conflictPayloadJson = row['conflict_payload_json'] as String?;
    return _OfflineCharacterRecordWithInternals(
      userId: row['user_id'] as int,
      localId: row['local_id'] as int,
      serverId: row['server_id'] as int?,
      character: CharacterData.fromJson(_decodeCharacterPayload(payloadJson)),
      baseVersion: row['base_version'] as int?,
      baseUpdatedAt: _parseDateTime(row['base_updated_at'] as String?),
      baseCharacter: basePayloadJson == null
          ? null
          : CharacterData.fromJson(_decodeCharacterPayload(basePayloadJson)),
      status: OfflineCharacterSyncStatus.values.byName(
        row['sync_status'] as String,
      ),
      operation: _operationFromName(row['sync_operation'] as String?),
      lastSyncError: row['last_sync_error'] as String?,
      conflictCharacter: conflictPayloadJson == null
          ? null
          : CharacterData.fromJson(
              _decodeCharacterPayload(conflictPayloadJson),
            ),
      basePayloadJson: basePayloadJson,
      serverUpdatedAt: row['server_updated_at'] as String?,
    );
  }

  OfflineCharacterChange _rowToCharacterChange(Row row) {
    final payloadJson = row['payload_json'] as String?;
    final operationTypeName = row['operation_type'] as String?;
    final targetTypeName = row['target_type'] as String?;
    final operation = operationTypeName == null || targetTypeName == null
        ? null
        : CharacterSyncOperationData(
            id: row['id'] as String,
            characterId: row['operation_character_id'] as int? ??
                int.tryParse(row['entity_id'] as String),
            localCharacterId: row['operation_local_character_id'] as int? ??
                int.tryParse(row['entity_id'] as String),
            type: CharacterSyncOperationType.values.byName(operationTypeName),
            targetType: CharacterSyncTargetType.values.byName(targetTypeName),
            targetId: row['target_id'] as String?,
            fieldPath: row['field_path'] as String?,
            value: _decodeSyncValue(row['value_json'] as String?),
            itemPayload: _decodeSyncValue(row['item_payload_json'] as String?),
            baseCharacterRevision: row['base_character_revision'] as int?,
            baseTargetRevision: row['base_target_revision'] as int?,
            createdAt: _parseDateTime(row['created_at'] as String?) ??
                DateTime.now().toUtc(),
          );
    return OfflineCharacterChange(
      id: row['id'] as String,
      userId: row['user_id'] as int,
      changeType:
          CharacterChangeType.values.byName(row['change_type'] as String),
      entityType:
          CharacterEntityType.values.byName(row['entity_type'] as String),
      entityId: row['entity_id'] as String,
      payload: payloadJson == null
          ? null
          : CharacterData.fromJson(_decodeCharacterPayload(payloadJson)),
      operationData: operation,
      createdAt: _parseDateTime(row['created_at'] as String?) ??
          DateTime.now().toUtc(),
      baseUpdatedAt: _parseDateTime(row['base_updated_at'] as String?),
      status:
          OfflineCharacterChangeStatus.values.byName(row['status'] as String),
      lastError: row['last_error'] as String?,
    );
  }

  CharacterSyncValueData? _decodeSyncValue(String? payloadJson) {
    if (payloadJson == null) return null;
    final decoded = jsonDecode(payloadJson);
    if (decoded is Map) {
      return CharacterSyncValueData.fromJson(
        Map<String, dynamic>.from(decoded),
      );
    }
    if (decoded is String) {
      return CharacterSyncValueData(stringValue: decoded);
    }
    if (decoded is int) {
      return CharacterSyncValueData(intValue: decoded);
    }
    if (decoded is bool) {
      return CharacterSyncValueData(boolValue: decoded);
    }
    if (decoded is List) {
      final stringValues = decoded.whereType<String>().toList();
      if (stringValues.length == decoded.length) {
        return CharacterSyncValueData(stringListValue: stringValues);
      }
    }
    throw FormatException(
      'Unsupported cached sync value payload: ${decoded.runtimeType}',
    );
  }

  String _encodeSyncValue(CharacterSyncValueData value) {
    return jsonEncode(value.toJson());
  }

  DateTime? _parseDateTime(String? value) {
    if (value == null) return null;
    return DateTime.tryParse(value)?.toUtc();
  }

  OfflineCharacterSyncOperation? _operationFromName(String? name) {
    if (name == null) return null;
    return OfflineCharacterSyncOperation.values.byName(name);
  }

  Map<String, dynamic> _decodeCharacterPayload(String payloadJson) {
    final payload = _decodeCachedPayload(payloadJson);
    final notes = payload['notes'];
    if (notes is String) {
      final trimmed = notes.trim();
      payload['notes'] = trimmed.isEmpty
          ? null
          : [
              {
                'id': _generateLegacyId(trimmed),
                'text': trimmed,
              }
            ];
    }
    final equipment = payload['equipment'];
    if (equipment is String) {
      final trimmed = equipment.trim();
      payload['equipment'] = trimmed.isEmpty
          ? null
          : [
              {
                'id': _generateLegacyId(trimmed),
                'name': trimmed,
                'quantity': 1,
                'type': CharacterInventoryItemType.custom.toJson(),
              }
            ];
    }
    final attacks = payload['attacks'];
    if (attacks is List<dynamic>) {
      payload['attacks'] = [
        for (final item in attacks)
          if (item is Map<String, dynamic>)
            {
              'id': item['id'] ?? _generateLegacyId(jsonEncode(item)),
              ...item,
            }
          else
            item,
      ];
    }
    return payload;
  }

  Map<String, dynamic> _decodeCachedPayload(String payloadJson) {
    final payload = jsonDecode(payloadJson) as Map<String, dynamic>;
    _normalizeLegacyClassChoiceTypes(payload);
    return payload;
  }

  List<dynamic> _decodeCachedListPayload(String payloadJson) {
    final payload = jsonDecode(payloadJson) as List<dynamic>;
    _normalizeLegacyClassChoiceTypes(payload);
    return payload;
  }

  void _normalizeLegacyClassChoiceTypes(Object? value) {
    if (value is List<dynamic>) {
      for (final item in value) {
        _normalizeLegacyClassChoiceTypes(item);
      }
      return;
    }
    if (value is! Map<String, dynamic>) return;

    if (value['type'] == 'skill' && _looksLikeClassChoiceGroup(value)) {
      value['type'] = null;
    }
    for (final item in value.values) {
      _normalizeLegacyClassChoiceTypes(item);
    }
  }

  bool _looksLikeClassChoiceGroup(Map<String, dynamic> value) {
    return value.containsKey('selectionCount') ||
        value.containsKey('exclusiveKey') ||
        value.containsKey('allowDuplicates') ||
        value.containsKey('sourceClassId') ||
        value.containsKey('sourceBackgroundId') ||
        value.containsKey('sourceFeatureId') ||
        value.containsKey('sourceSubclassId');
  }

  String _generateLegacyId(String seed) {
    var hash = 0x811c9dc5;
    for (final unit in seed.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193).toUnsigned(32);
    }
    return 'legacy-${hash.toRadixString(16).padLeft(8, '0')}';
  }

  String _generateChangeId(DateTime now) {
    return '${now.microsecondsSinceEpoch}-${Random().nextInt(1 << 32)}';
  }
}

class _OfflineCharacterRecordWithInternals extends OfflineCharacterRecord {
  const _OfflineCharacterRecordWithInternals({
    required super.userId,
    required super.localId,
    required super.character,
    required super.status,
    required this.basePayloadJson,
    required this.serverUpdatedAt,
    super.serverId,
    super.baseVersion,
    super.baseUpdatedAt,
    super.baseCharacter,
    super.operation,
    super.lastSyncError,
    super.conflictCharacter,
  });

  final String? basePayloadJson;
  final String? serverUpdatedAt;
}

extension on OfflineCharacterRecord {
  String? get _basePayloadJson => this is _OfflineCharacterRecordWithInternals
      ? (this as _OfflineCharacterRecordWithInternals).basePayloadJson
      : null;

  String? get _serverUpdatedAt => this is _OfflineCharacterRecordWithInternals
      ? (this as _OfflineCharacterRecordWithInternals).serverUpdatedAt
      : null;
}
