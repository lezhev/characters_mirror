import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';

const offlineAllKey = 'all';
const offlineRaceStepKind = 'race_step';
const offlineBackgroundStepKind = 'background_step';

String offlineRaceStepKey(int raceId) => raceId.toString();

String offlineBackgroundStepKey(int backgroundId) => backgroundId.toString();

Future<List<T>> cachedListFallback<T>({
  required OfflineCacheDatabase? cache,
  required String kind,
  required Future<List<T>> Function() loadRemote,
  required Map<String, dynamic> Function(T value) toJson,
  required T Function(Map<String, dynamic> json) fromJson,
}) async {
  try {
    final remote = await loadRemote();
    await cache?.putReferenceList(kind, offlineAllKey, remote, toJson);
    return remote;
  } catch (_) {
    final cached = await cache?.getReferenceList(kind, offlineAllKey, fromJson);
    if (cached != null) return cached;
    rethrow;
  }
}

Future<T> cachedValueFallback<T>({
  required OfflineCacheDatabase? cache,
  required String kind,
  required String key,
  required Future<T> Function() loadRemote,
  required Map<String, dynamic> Function(T value) toJson,
  required T Function(Map<String, dynamic> json) fromJson,
}) async {
  try {
    final remote = await loadRemote();
    await cache?.putReference(kind, key, remote, toJson);
    return remote;
  } catch (_) {
    final cached = await cache?.getReference(kind, key, fromJson);
    if (cached != null) return cached;
    rethrow;
  }
}
