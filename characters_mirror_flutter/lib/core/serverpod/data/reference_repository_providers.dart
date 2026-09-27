import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final raceRepositoryProvider = Provider<RaceRepository>((ref) {
  return RaceRepository();
});

final classRepositoryProvider = Provider<ClassRepository>((ref) {
  return ClassRepository();
});

final backgroundRepositoryProvider = Provider<BackgroundRepository>((ref) {
  return BackgroundRepository();
});

final itemRepositoryProvider = Provider<ItemRepository>((ref) {
  return ItemRepository();
});

final weaponRepositoryProvider = Provider<WeaponRepository>((ref) {
  return WeaponRepository();
});

final armorRepositoryProvider = Provider<ArmorRepository>((ref) {
  return ArmorRepository();
});

final toolDataRepositoryProvider = Provider<ToolDataRepository>((ref) {
  return ToolDataRepository();
});

final magicItemRepositoryProvider = Provider<MagicItemRepository>((ref) {
  return MagicItemRepository();
});

final itemCatalogProvider = FutureProvider<List<ItemData>>((ref) {
  return ref.watch(itemRepositoryProvider).getAll();
});

final weaponCatalogProvider = FutureProvider<List<WeaponData>>((ref) {
  return ref.watch(weaponRepositoryProvider).getAll();
});

final armorCatalogProvider = FutureProvider<List<ArmorData>>((ref) {
  return ref.watch(armorRepositoryProvider).getAll();
});

final toolCatalogProvider = FutureProvider<List<ToolData>>((ref) {
  return ref.watch(toolDataRepositoryProvider).getAll();
});

final magicItemCatalogProvider = FutureProvider<List<MagicItemData>>((ref) {
  return ref.watch(magicItemRepositoryProvider).getAll();
});
