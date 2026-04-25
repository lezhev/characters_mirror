import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:characters_mirror_flutter/core/offline/offline_services.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

class ItemRepository implements Repository<ItemData> {
  @override
  Future<List<ItemData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'item',
        loadRemote: client.itemData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ItemData.fromJson,
      );

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
  Future<List<WeaponData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'weapon',
        loadRemote: client.weaponData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: WeaponData.fromJson,
      );

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
  Future<List<ArmorData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'armor',
        loadRemote: client.armorData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: ArmorData.fromJson,
      );

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
  Future<List<MagicItemData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'magic_item',
        loadRemote: client.magicItemData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: MagicItemData.fromJson,
      );

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

class FeatRepository implements Repository<FeatData> {
  @override
  Future<List<FeatData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'feat',
        loadRemote: client.featData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: FeatData.fromJson,
      );

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
  Future<List<SpellData>> getAll() => cachedListFallback(
        cache: offlineCacheDatabase,
        kind: 'spell',
        loadRemote: client.spellData.getAll,
        toJson: (value) => value.toJson(),
        fromJson: SpellData.fromJson,
      );

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
