import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/repositories/repository_base.dart';
import 'package:characters_mirror_flutter/core/serverpod/serverpod_client.dart';

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
