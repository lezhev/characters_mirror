import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';

OfflineCacheDatabase? offlineCacheDatabase;
OfflineSyncCoordinator? offlineSyncCoordinator;

bool get isAndroidOfflineCacheEnabled => false;

Future<void> initializeOfflineServices() async {}

int? currentOfflineUserId() => null;

class OfflineSyncCoordinator {
  Future<void> syncNow() async {}

  Future<void> keepLocalVersion(OfflineCharacterRecord record) async {}

  Future<void> acceptServerVersion(OfflineCharacterRecord record) async {}
}
