import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/src/serverpod_client.dart';

abstract class Repository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<T> upsert(T entity);
  Future<void> delete(int id);
}

class ClassRepository implements Repository<ClassData> {
  @override
  Future<List<ClassData>> getAll() => client.classData.getAll();

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
  }) {
    return client.classData.getStepView(
      classId,
      selectedLevel: selectedLevel,
      isStartingClass: isStartingClass,
    );
  }

  @override
  Future<ClassData> upsert(ClassData entity) => client.classData.upsert(entity);

  @override
  Future<void> delete(int id) => client.classData.delete(id);
}

class RaceRepository implements Repository<RaceData> {
  @override
  Future<List<RaceData>> getAll() => client.raceData.getAll();

  @override
  Future<RaceData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<RaceData> upsert(RaceData entity) => client.raceData.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceData.delete(id);
}

class SubraceRepository implements Repository<SubraceData> {
  @override
  Future<List<SubraceData>> getAll() => client.subraceData.getAll();

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
  Future<List<RaceFeatureData>> getAll() => client.raceFeature.getAll();

  @override
  Future<RaceFeatureData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<RaceFeatureData>> getAllByRaceId(int raceId) async {
    final all = await getAll();
    return all.where((s) => s.raceId == raceId).toList();
  }

  Future<List<RaceFeatureData>> getAllByRaceContext(
    int raceId, {
    List<int> subraceIds = const [],
  }) async {
    final all = await getAll();
    final subraceIdSet = subraceIds.toSet();

    return all.where((feature) {
      final belongsToRace = feature.raceId == raceId;
      final belongsToSubrace = feature.subraceId != null &&
          subraceIdSet.contains(feature.subraceId);
      return belongsToRace || belongsToSubrace;
    }).toList();
  }

  @override
  Future<RaceFeatureData> upsert(RaceFeatureData entity) =>
      client.raceFeature.upsert(entity);

  @override
  Future<void> delete(int id) => client.raceFeature.delete(id);
}

class ItemRepository implements Repository<ItemData> {
  @override
  Future<List<ItemData>> getAll() => client.itemData.getAll();

  @override
  Future<ItemData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ItemData> upsert(ItemData entity) => client.itemData.upsert(entity);

  @override
  Future<void> delete(int id) => client.itemData.delete(id);
}

class WeaponRepository implements Repository<WeaponData> {
  @override
  Future<List<WeaponData>> getAll() => client.weaponData.getAll();

  @override
  Future<WeaponData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<WeaponData> upsert(WeaponData entity) =>
      client.weaponData.upsert(entity);

  @override
  Future<void> delete(int id) => client.weaponData.delete(id);
}

class ArmorRepository implements Repository<ArmorData> {
  @override
  Future<List<ArmorData>> getAll() => client.armorData.getAll();

  @override
  Future<ArmorData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<ArmorData> upsert(ArmorData entity) => client.armorData.upsert(entity);

  @override
  Future<void> delete(int id) => client.armorData.delete(id);
}

class MagicItemRepository implements Repository<MagicItemData> {
  @override
  Future<List<MagicItemData>> getAll() => client.magicItemData.getAll();

  @override
  Future<MagicItemData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<MagicItemData> upsert(MagicItemData entity) =>
      client.magicItemData.upsert(entity);

  @override
  Future<void> delete(int id) => client.magicItemData.delete(id);
}

class BackgroundRepository implements Repository<BackgroundData> {
  @override
  Future<List<BackgroundData>> getAll() => client.backgroundData.getAll();

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

  @override
  Future<void> delete(int id) => client.backgroundData.delete(id);
}

class FeatRepository implements Repository<FeatData> {
  @override
  Future<List<FeatData>> getAll() => client.featData.getAll();

  @override
  Future<FeatData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<FeatData> upsert(FeatData entity) => client.featData.upsert(entity);

  @override
  Future<void> delete(int id) => client.featData.delete(id);
}

class SpellRepository implements Repository<SpellData> {
  @override
  Future<List<SpellData>> getAll() => client.spellData.getAll();

  @override
  Future<SpellData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<SpellData> upsert(SpellData entity) => client.spellData.upsert(entity);

  @override
  Future<void> delete(int id) => client.spellData.delete(id);
}

class ClassFeatureRepository implements Repository<ClassFeatureData> {
  @override
  Future<List<ClassFeatureData>> getAll() => client.classFeatureData.getAll();

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
  Future<List<ClassLevelData>> getAll() => client.classLevelData.getAll();

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
  Future<List<SubclassData>> getAll() => client.subclassData.getAll();

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
  Future<List<ClassChoiceGroupData>> getAll() =>
      client.classChoiceGroupData.getAll();

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
  Future<List<ClassChoiceOptionData>> getAll() =>
      client.classChoiceOptionData.getAll();

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
  Future<List<SubclassFeatureData>> getAll() =>
      client.subclassFeatureData.getAll();

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

class DragonbornAncestryRepository
    implements Repository<DragonbornAncestryData> {
  @override
  Future<List<DragonbornAncestryData>> getAll() =>
      client.dragonbornAncestryData.getAll();

  @override
  Future<DragonbornAncestryData?> getById(int id) async {
    final all = await getAll();
    try {
      return all.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<DragonbornAncestryData> upsert(DragonbornAncestryData entity) =>
      client.dragonbornAncestryData.upsert(entity);

  Future<void> upsertAll(List<DragonbornAncestryData> entities) async {
    for (final entity in entities) {
      await upsert(entity);
    }
  }

  @override
  Future<void> delete(int id) => client.dragonbornAncestryData.delete(id);
}

class CharacterBuildRepository {
  Future<CharacterBuildData> upsertBuild(CharacterBuildData build) =>
      client.characterData.upsertBuild(build);

  Future<CharacterBuildData> getBuild(int characterId) =>
      client.characterData.getBuild(characterId);

  Future<CharacterSheetView> getCharacterSheet(int characterId) =>
      client.characterData.getCharacterSheet(characterId);
}
