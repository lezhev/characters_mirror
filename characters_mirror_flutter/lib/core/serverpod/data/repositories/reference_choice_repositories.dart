import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

import 'repository_base.dart';

class ChoiceGroupRepository implements Repository<ChoiceGroupData> {
  @override
  Future<List<ChoiceGroupData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'choice_group',
        loadRemote: client.choiceGroupData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ChoiceGroupData.fromJson,
      );

  @override
  Future<ChoiceGroupData?> getById(int id) async {
    final groups = await getAll();
    for (final group in groups) {
      if (group.id == id) return group;
    }
    return null;
  }

  @override
  Future<ChoiceGroupData> upsert(ChoiceGroupData entity) =>
      throw UnsupportedError('Choice groups are reference data.');

  @override
  Future<void> delete(int id) =>
      throw UnsupportedError('Choice groups are reference data.');
}

class ChoiceOptionRepository implements Repository<ChoiceOptionData> {
  @override
  Future<List<ChoiceOptionData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'choice_option',
        loadRemote: client.choiceOptionData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ChoiceOptionData.fromJson,
      );

  @override
  Future<ChoiceOptionData?> getById(int id) async {
    final options = await getAll();
    for (final option in options) {
      if (option.id == id) return option;
    }
    return null;
  }

  @override
  Future<ChoiceOptionData> upsert(ChoiceOptionData entity) =>
      throw UnsupportedError('Choice options are reference data.');

  @override
  Future<void> delete(int id) =>
      throw UnsupportedError('Choice options are reference data.');
}
