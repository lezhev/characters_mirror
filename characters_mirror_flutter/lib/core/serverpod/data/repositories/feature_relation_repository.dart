import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

import 'repository_base.dart';

class FeatureRelationRepository implements Repository<FeatureRelationData> {
  @override
  Future<List<FeatureRelationData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'feature_relation',
        loadRemote: client.featureRelationData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: FeatureRelationData.fromJson,
      );

  @override
  Future<FeatureRelationData?> getById(int id) async {
    for (final relation in await getAll()) {
      if (relation.id == id) return relation;
    }
    return null;
  }

  @override
  Future<FeatureRelationData> upsert(FeatureRelationData entity) =>
      throw UnsupportedError('Feature relations are reference data.');

  @override
  Future<void> delete(int id) =>
      throw UnsupportedError('Feature relations are reference data.');
}
