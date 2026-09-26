import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class ToolDataRepository {
  Future<List<ToolData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'tool',
        loadRemote: client.toolData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ToolData.fromJson,
      );
}
