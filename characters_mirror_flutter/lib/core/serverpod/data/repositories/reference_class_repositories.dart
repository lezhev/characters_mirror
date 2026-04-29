import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class ClassRepository implements Repository<ClassData> {
  @override
  Future<List<ClassData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'class',
        loadRemote: client.classData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ClassData.fromJson,
      );

  @override
  Future<ClassData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<ClassStepView> getStepView(
    int classId, {
    int selectedLevel = 1,
    bool isStartingClass = true,
    int? selectedSubclassId,
  }) =>
      cachedValueFallback(
        cache: offlineCacheDatabase,
        kind: offlineClassStepKind,
        key: offlineClassStepKey(
          classId,
          selectedLevel: selectedLevel,
          selectedSubclassId: selectedSubclassId,
        ),
        loadRemote: () => client.classData.getStepView(
          classId,
          selectedLevel: selectedLevel,
          isStartingClass: isStartingClass,
          selectedSubclassId: selectedSubclassId,
        ),
        toJson: (value) => value.toJson(),
        fromJson: ClassStepView.fromJson,
      );

  @override
  Future<ClassData> upsert(ClassData entity) => client.classData.upsert(entity);

  @override
  Future<void> delete(int id) => client.classData.delete(id);
}

class ClassFeatureRepository implements Repository<ClassFeatureData> {
  @override
  Future<List<ClassFeatureData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'class_feature',
        loadRemote: client.classFeatureData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ClassFeatureData.fromJson,
      );

  @override
  Future<ClassFeatureData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<ClassFeatureData>> getAllByClassId(int classId) async {
    final all = await getAll();
    return all.where((f) => f.parentClassId == classId).toList();
  }

  @override
  Future<ClassFeatureData> upsert(ClassFeatureData entity) =>
      client.classFeatureData.upsert(entity);

  @override
  Future<void> delete(int id) => client.classFeatureData.delete(id);
}

class ClassLevelRepository implements Repository<ClassLevelData> {
  @override
  Future<List<ClassLevelData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'class_level',
        loadRemote: client.classLevelData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ClassLevelData.fromJson,
      );

  @override
  Future<ClassLevelData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<ClassLevelData>> getAllByClassId(int classId) async {
    final all = await getAll();
    return all.where((e) => e.classDataId == classId).toList();
  }

  @override
  Future<ClassLevelData> upsert(ClassLevelData entity) =>
      client.classLevelData.upsert(entity);

  @override
  Future<void> delete(int id) => client.classLevelData.delete(id);
}

class SubclassRepository implements Repository<SubclassData> {
  @override
  Future<List<SubclassData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'subclass',
        loadRemote: client.subclassData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: SubclassData.fromJson,
      );

  @override
  Future<SubclassData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<SubclassData>> getAllByClassId(int classId) async {
    final all = await getAll();
    return all.where((s) => s.parentClassId == classId).toList();
  }

  @override
  Future<SubclassData> upsert(SubclassData entity) =>
      client.subclassData.upsert(entity);

  @override
  Future<void> delete(int id) => client.subclassData.delete(id);
}

class ClassChoiceGroupRepository implements Repository<ClassChoiceGroupData> {
  @override
  Future<List<ClassChoiceGroupData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'class_choice_group',
        loadRemote: client.classChoiceGroupData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ClassChoiceGroupData.fromJson,
      );

  @override
  Future<ClassChoiceGroupData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ClassChoiceGroupData> upsert(ClassChoiceGroupData entity) =>
      client.classChoiceGroupData.upsert(entity);

  @override
  Future<void> delete(int id) => client.classChoiceGroupData.delete(id);
}

class ClassChoiceOptionRepository implements Repository<ClassChoiceOptionData> {
  @override
  Future<List<ClassChoiceOptionData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'class_choice_option',
        loadRemote: client.classChoiceOptionData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ClassChoiceOptionData.fromJson,
      );

  @override
  Future<ClassChoiceOptionData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<ClassChoiceOptionData>> getAllByGroupId(int groupId) async {
    final all = await getAll();
    return all.where((e) => e.choiceGroupId == groupId).toList();
  }

  @override
  Future<ClassChoiceOptionData> upsert(ClassChoiceOptionData entity) =>
      client.classChoiceOptionData.upsert(entity);

  @override
  Future<void> delete(int id) => client.classChoiceOptionData.delete(id);
}

class SubclassFeatureRepository implements Repository<SubclassFeatureData> {
  @override
  Future<List<SubclassFeatureData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'subclass_feature',
        loadRemote: client.subclassFeatureData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: SubclassFeatureData.fromJson,
      );

  @override
  Future<SubclassFeatureData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<SubclassFeatureData>> getAllBySubclassId(int subclassId) async {
    final all = await getAll();
    return all.where((s) => s.parentSubclassId == subclassId).toList();
  }

  @override
  Future<SubclassFeatureData> upsert(SubclassFeatureData entity) =>
      client.subclassFeatureData.upsert(entity);

  @override
  Future<void> delete(int id) => client.subclassFeatureData.delete(id);
}
