part of '../offline_cache_database_native.dart';

extension OfflineCacheReferenceOperations on OfflineCacheDatabase {
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
    return fromJson(_decodeCachedPayload(payload));
  }

  Future<List<T>?> getReferenceList<T>(
    String kind,
    String cacheKey,
    T Function(Map<String, dynamic> json) fromJson,
  ) async {
    final payload = _readReferencePayload(kind, cacheKey);
    if (payload == null) return null;
    return [
      for (final item in _decodeCachedListPayload(payload))
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
}
