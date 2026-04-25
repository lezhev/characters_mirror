import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class RaceRepository implements Repository<RaceData> {
  @override
  Future<List<RaceData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'race',
        loadRemote: client.raceData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: RaceData.fromJson,
      );

  @override
  Future<RaceData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<RaceStepView> getStepView(int raceId) => cachedValueFallback(
        cache: offlineCacheDatabase,
        kind: offlineRaceStepKind,
        key: offlineRaceStepKey(raceId),
        loadRemote: () => client.raceData.getStepView(raceId),
        toJson: (value) => value.toJson(),
        fromJson: RaceStepView.fromJson,
      );

  @override
  Future<RaceData> upsert(RaceData entity) => client.raceData.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceData.delete(id);
}

class SubraceRepository implements Repository<SubraceData> {
  @override
  Future<List<SubraceData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'subrace',
        loadRemote: client.subraceData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: SubraceData.fromJson,
      );

  @override
  Future<SubraceData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<SubraceData>> getAllByRaceId(int raceId) async {
    final all = await getAll();
    return all.where((s) => s.parentRaceId == raceId).toList();
  }

  @override
  Future<SubraceData> upsert(SubraceData entity) =>
      client.subraceData.upsert(entity);

  @override
  Future<void> delete(int id) => client.subraceData.delete(id);
}

class RaceFeatureRepository implements Repository<RaceFeatureData> {
  @override
  Future<List<RaceFeatureData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'race_feature',
        loadRemote: client.raceFeature.getAll,
        toJson: (value) => value.toJson(),
        fromJson: RaceFeatureData.fromJson,
      );

  @override
  Future<RaceFeatureData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RaceFeatureData> upsert(RaceFeatureData entity) =>
      client.raceFeature.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceFeature.delete(id);
}

class RaceChoiceSetRepository implements Repository<RaceChoiceSetData> {
  @override
  Future<List<RaceChoiceSetData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'race_choice_set',
        loadRemote: client.raceChoiceSetData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: RaceChoiceSetData.fromJson,
      );

  @override
  Future<RaceChoiceSetData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RaceChoiceSetData> upsert(RaceChoiceSetData entity) =>
      client.raceChoiceSetData.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceChoiceSetData.delete(id);
}

class RaceChoiceOptionRepository implements Repository<RaceChoiceOptionData> {
  @override
  Future<List<RaceChoiceOptionData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'race_choice_option',
        loadRemote: client.raceChoiceOptionData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: RaceChoiceOptionData.fromJson,
      );

  @override
  Future<RaceChoiceOptionData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RaceChoiceOptionData> upsert(RaceChoiceOptionData entity) =>
      client.raceChoiceOptionData.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceChoiceOptionData.delete(id);
}

class RaceFeatureSpellGrantRepository
    implements Repository<RaceFeatureSpellGrantData> {
  @override
  Future<List<RaceFeatureSpellGrantData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'race_feature_spell_grant',
        loadRemote: client.raceFeatureSpellGrantData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: RaceFeatureSpellGrantData.fromJson,
      );

  @override
  Future<RaceFeatureSpellGrantData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RaceFeatureSpellGrantData> upsert(
    RaceFeatureSpellGrantData entity,
  ) =>
      client.raceFeatureSpellGrantData.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceFeatureSpellGrantData.delete(id);
}

class BackgroundRepository implements Repository<BackgroundData> {
  @override
  Future<List<BackgroundData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'background',
        loadRemote: client.backgroundData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: BackgroundData.fromJson,
      );

  @override
  Future<BackgroundData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<BackgroundData> upsert(BackgroundData entity) =>
      client.backgroundData.upsert(entity);

  Future<BackgroundStepView> getStepView(int backgroundId) =>
      cachedValueFallback(
        cache: offlineCacheDatabase,
        kind: offlineBackgroundStepKind,
        key: offlineBackgroundStepKey(backgroundId),
        loadRemote: () => client.backgroundData.getStepView(backgroundId),
        toJson: (value) => value.toJson(),
        fromJson: BackgroundStepView.fromJson,
      );

  @override
  Future<void> delete(int id) => client.backgroundData.delete(id);
}
