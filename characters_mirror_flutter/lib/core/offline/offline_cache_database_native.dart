import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

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
    this.baseUpdatedAt,
    this.lastError,
  });

  final String id;
  final int userId;
  final CharacterChangeType changeType;
  final CharacterEntityType entityType;
  final String entityId;
  final CharacterData? payload;
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
      p.join(directory.path, 'characters_mirror_offline_v2.sqlite'),
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

  Future<void> putReference<T>(
    String kind,
    String cacheKey,
    T value,
    Map<String, dynamic> Function(T value) toJson,
  ) async {
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO reference_cache(kind, cache_key, payload_json, fetched_at)
VALUES (?, ?, ?, ?)
''');
    try {
      stmt.execute([
        kind,
        cacheKey,
        jsonEncode(toJson(value)),
        DateTime.now().toUtc().toIso8601String(),
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> putReferenceList<T>(
    String kind,
    String cacheKey,
    List<T> values,
    Map<String, dynamic> Function(T value) toJson,
  ) async {
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO reference_cache(kind, cache_key, payload_json, fetched_at)
VALUES (?, ?, ?, ?)
''');
    try {
      stmt.execute([
        kind,
        cacheKey,
        jsonEncode(values.map(toJson).toList()),
        DateTime.now().toUtc().toIso8601String(),
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<T?> getReference<T>(
    String kind,
    String cacheKey,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final payload = _readReferencePayload(kind, cacheKey);
    if (payload == null) return null;
    return fromJson(jsonDecode(payload) as Map<String, dynamic>);
  }

  Future<List<T>?> getReferenceList<T>(
    String kind,
    String cacheKey,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final payload = _readReferencePayload(kind, cacheKey);
    if (payload == null) return null;
    return [
      for (final item in jsonDecode(payload) as List<dynamic>)
        fromJson(item as Map<String, dynamic>),
    ];
  }

  String? _readReferencePayload(String kind, String cacheKey) {
    final stmt = _db.prepare('''
SELECT payload_json FROM reference_cache
WHERE kind = ? AND cache_key = ?
LIMIT 1
''');
    try {
      final rows = stmt.select([kind, cacheKey]);
      if (rows.isEmpty) return null;
      return rows.first['payload_json'] as String;
    } finally {
      stmt.dispose();
    }
  }

  Future<List<OfflineCharacterRecord>> getCharacters(int userId) async {
    final stmt = _db.prepare('''
SELECT * FROM characters_cache
WHERE user_id = ? AND sync_status != ?
ORDER BY local_updated_at DESC
''');
    try {
      return [
        for (final row
            in stmt.select([userId, OfflineCharacterSyncStatus.deleting.name]))
          _rowToCharacterRecord(row),
      ];
    } finally {
      stmt.dispose();
    }
  }

  Future<OfflineCharacterRecord?> getCharacter(int userId, int id) async {
    final stmt = _db.prepare('''
SELECT * FROM characters_cache
WHERE user_id = ? AND (local_id = ? OR server_id = ?)
LIMIT 1
''');
    try {
      final rows = stmt.select([userId, id, id]);
      if (rows.isEmpty) return null;
      return _rowToCharacterRecord(rows.first);
    } finally {
      stmt.dispose();
    }
  }

  Future<OfflineCharacterRecord?> getCharacterByServerId(
    int userId,
    int serverId,
  ) async {
    return getCharacter(userId, serverId);
  }

  Future<List<OfflineCharacterRecord>> getPendingCharacters(int userId) async {
    final stmt = _db.prepare('''
SELECT * FROM characters_cache
WHERE user_id = ? AND sync_status IN (?, ?)
ORDER BY local_updated_at ASC
''');
    try {
      return [
        for (final row in stmt.select([
          userId,
          OfflineCharacterSyncStatus.dirty.name,
          OfflineCharacterSyncStatus.deleting.name,
        ]))
          _rowToCharacterRecord(row),
      ];
    } finally {
      stmt.dispose();
    }
  }

  Future<List<OfflineCharacterChange>> getPendingChanges(int userId) async {
    final stmt = _db.prepare('''
SELECT * FROM character_changes
WHERE user_id = ? AND status IN (?, ?)
ORDER BY created_at ASC
''');
    try {
      return [
        for (final row in stmt.select([
          userId,
          OfflineCharacterChangeStatus.pending.name,
          OfflineCharacterChangeStatus.failed.name,
        ]))
          _rowToCharacterChange(row),
      ];
    } finally {
      stmt.dispose();
    }
  }

  Future<OfflineCharacterRecord> saveLocal(
    int userId,
    CharacterData character,
  ) async {
    final existing =
        character.id == null ? null : await getCharacter(userId, character.id!);
    final localId = existing?.localId ??
        (character.id != null && character.id! > 0
            ? character.id!
            : await _allocateLocalId(userId));
    final serverId = existing?.serverId ??
        (character.id != null && character.id! > 0 ? character.id : null);
    final localCharacter = character.copyWith(id: localId);
    final now = DateTime.now().toUtc();
    final payload = jsonEncode(localCharacter.toJson());
    final basePayload = existing?._basePayloadJson ??
        jsonEncode(
          (existing?.baseCharacter ?? character).toJson(),
        );

    final stmt = _db.prepare('''
INSERT OR REPLACE INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  base_updated_at, sync_status, sync_operation, local_updated_at,
  server_updated_at, last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      stmt.execute([
        userId,
        localId,
        serverId,
        payload,
        basePayload,
        existing?.baseVersion ?? character.version,
        (existing?.baseUpdatedAt ?? character.updatedAt)?.toUtc().toIso8601String(),
        OfflineCharacterSyncStatus.dirty.name,
        OfflineCharacterSyncOperation.upsert.name,
        now.toIso8601String(),
        existing?._serverUpdatedAt,
        null,
        null,
      ]);
    } finally {
      stmt.dispose();
    }

    await _enqueueChange(
      OfflineCharacterChange(
        id: _generateChangeId(now),
        userId: userId,
        changeType: CharacterChangeType.upsert,
        entityType: CharacterEntityType.character,
        entityId: (serverId ?? localId).toString(),
        payload: localCharacter,
        createdAt: now,
        baseUpdatedAt: existing?.baseUpdatedAt ?? character.updatedAt,
        status: OfflineCharacterChangeStatus.pending,
      ),
    );

    return (await getCharacter(userId, localId))!;
  }

  Future<void> markDeleting(int userId, int id, String? error) async {
    final existing = await getCharacter(userId, id);
    if (existing == null) return;
    final now = DateTime.now().toUtc();
    final stmt = _db.prepare('''
UPDATE characters_cache
SET sync_status = ?, sync_operation = ?, local_updated_at = ?, last_sync_error = ?
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterSyncStatus.deleting.name,
        OfflineCharacterSyncOperation.delete.name,
        now.toIso8601String(),
        error,
        userId,
        existing.localId,
      ]);
    } finally {
      stmt.dispose();
    }

    await _enqueueChange(
      OfflineCharacterChange(
        id: _generateChangeId(now),
        userId: userId,
        changeType: CharacterChangeType.delete,
        entityType: CharacterEntityType.character,
        entityId: (existing.serverId ?? existing.localId).toString(),
        createdAt: now,
        baseUpdatedAt: existing.character.updatedAt ?? existing.baseUpdatedAt,
        status: OfflineCharacterChangeStatus.pending,
      ),
    );
  }

  Future<void> upsertCleanFromServer(
    int userId,
    CharacterData character, {
    bool overwritePending = false,
  }) async {
    final serverId = character.id;
    if (serverId == null) return;
    final existing = await getCharacterByServerId(userId, serverId);
    if (!overwritePending &&
        existing != null &&
        existing.status != OfflineCharacterSyncStatus.clean) {
      return;
    }

    final localId = serverId;
    final now = DateTime.now().toUtc();
    final payload = jsonEncode(character.toJson());
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO characters_cache(
  user_id, local_id, server_id, payload_json, base_payload_json, base_version,
  base_updated_at, sync_status, sync_operation, local_updated_at,
  server_updated_at, last_sync_error, conflict_payload_json
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
      stmt.execute([
        userId,
        localId,
        serverId,
        payload,
        payload,
        character.version,
        character.updatedAt?.toUtc().toIso8601String(),
        OfflineCharacterSyncStatus.clean.name,
        null,
        now.toIso8601String(),
        character.updatedAt?.toUtc().toIso8601String() ?? now.toIso8601String(),
        existing?.lastSyncError,
        null,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markSynced(
    int userId,
    int oldLocalId,
    CharacterData serverCharacter,
  ) async {
    final serverId = serverCharacter.id;
    if (serverId == null) return;
    final deleteStmt = _db.prepare('''
DELETE FROM characters_cache
WHERE user_id = ? AND local_id = ? AND local_id != ?
''');
    try {
      deleteStmt.execute([userId, oldLocalId, serverId]);
    } finally {
      deleteStmt.dispose();
    }
    await upsertCleanFromServer(
      userId,
      serverCharacter,
      overwritePending: true,
    );
  }

  Future<void> markDeleteSynced(int userId, int localId) async {
    final stmt = _db.prepare('''
DELETE FROM characters_cache
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([userId, localId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markConflict(
    int userId,
    int localId,
    CharacterData conflictCharacter,
    String? message,
  ) async {
    final stmt = _db.prepare('''
UPDATE characters_cache
SET sync_status = ?, last_sync_error = ?, conflict_payload_json = ?
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterSyncStatus.conflict.name,
        message,
        jsonEncode(conflictCharacter.toJson()),
        userId,
        localId,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markSyncError(int userId, int localId, Object error) async {
    final stmt = _db.prepare('''
UPDATE characters_cache
SET last_sync_error = ?
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([error.toString(), userId, localId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> clearSyncError(int userId, int localId) async {
    final stmt = _db.prepare('''
UPDATE characters_cache
SET last_sync_error = NULL
WHERE user_id = ? AND local_id = ?
''');
    try {
      stmt.execute([userId, localId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> acceptServerVersion(int userId, int localId) async {
    final local = await getCharacter(userId, localId);
    final conflict = local?.conflictCharacter;
    if (conflict == null) return;
    await markSynced(userId, localId, conflict);
  }

  Future<void> removeChanges(int userId, Iterable<String> changeIds) async {
    final ids = changeIds.toSet();
    if (ids.isEmpty) return;
    final stmt = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ? AND id = ?
''');
    try {
      for (final id in ids) {
        stmt.execute([userId, id]);
      }
    } finally {
      stmt.dispose();
    }
  }

  Future<void> markChangeFailed(int userId, String changeId, Object error) async {
    final stmt = _db.prepare('''
UPDATE character_changes
SET status = ?, last_error = ?
WHERE user_id = ? AND id = ?
''');
    try {
      stmt.execute([
        OfflineCharacterChangeStatus.failed.name,
        error.toString(),
        userId,
        changeId,
      ]);
    } finally {
      stmt.dispose();
    }
  }

  Future<void> deleteQueuedChangesForEntity(int userId, String entityId) async {
    final stmt = _db.prepare('''
DELETE FROM character_changes
WHERE user_id = ? AND entity_id = ?
''');
    try {
      stmt.execute([userId, entityId]);
    } finally {
      stmt.dispose();
    }
  }

  Future<DateTime?> getLastPulledAt(int userId) async {
    final value = _readMeta(userId, 'last_pulled_at');
    return value == null ? null : DateTime.tryParse(value)?.toUtc();
  }

  Future<void> setLastPulledAt(int userId, DateTime value) async {
    _writeMeta(userId, 'last_pulled_at', value.toUtc().toIso8601String());
  }

  Future<void> clearUser(int userId) async {
    final deleteCharacters =
        _db.prepare('DELETE FROM characters_cache WHERE user_id = ?');
    final deleteMeta =
        _db.prepare('DELETE FROM offline_meta WHERE user_id = ?');
    final deleteChanges =
        _db.prepare('DELETE FROM character_changes WHERE user_id = ?');
    try {
      deleteCharacters.execute([userId]);
      deleteMeta.execute([userId]);
      deleteChanges.execute([userId]);
    } finally {
      deleteCharacters.dispose();
      deleteMeta.dispose();
      deleteChanges.dispose();
    }
  }

  Future<bool> hasUnsyncedChanges(int userId) async {
    final stmt = _db.prepare('''
SELECT 1 FROM characters_cache
WHERE user_id = ? AND sync_status IN (?, ?, ?)
LIMIT 1
''');
    try {
      return stmt.select([
        userId,
        OfflineCharacterSyncStatus.dirty.name,
        OfflineCharacterSyncStatus.deleting.name,
        OfflineCharacterSyncStatus.conflict.name,
      ]).isNotEmpty;
    } finally {
      stmt.dispose();
    }
  }

  Future<int> _allocateLocalId(int userId) async {
    final key = 'next_negative_local_id';
    final current = _readMeta(userId, key);
    final next = int.tryParse(current ?? '') ?? -1;
    _writeMeta(userId, key, (next - 1).toString());
    return next;
  }

  Future<void> _enqueueChange(OfflineCharacterChange change) async {
    final stmt = _db.prepare('''
INSERT OR REPLACE INTO character_changes(
  id, user_id, change_type, entity_type, entity_id, payload_json,
  created_at, base_updated_at, status, last_error
) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
''');
    try {
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
    return OfflineCharacterChange(
      id: row['id'] as String,
      userId: row['user_id'] as int,
      changeType: CharacterChangeType.values.byName(row['change_type'] as String),
      entityType:
          CharacterEntityType.values.byName(row['entity_type'] as String),
      entityId: row['entity_id'] as String,
      payload: payloadJson == null
          ? null
          : CharacterData.fromJson(_decodeCharacterPayload(payloadJson)),
      createdAt: _parseDateTime(row['created_at'] as String?) ?? DateTime.now().toUtc(),
      baseUpdatedAt: _parseDateTime(row['base_updated_at'] as String?),
      status: OfflineCharacterChangeStatus.values
          .byName(row['status'] as String),
      lastError: row['last_error'] as String?,
    );
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
    final payload = jsonDecode(payloadJson) as Map<String, dynamic>;
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

  String _generateLegacyId(String seed) {
    final hash = seed.hashCode.toUnsigned(32).toRadixString(16).padLeft(8, '0');
    return 'legacy-$hash';
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
