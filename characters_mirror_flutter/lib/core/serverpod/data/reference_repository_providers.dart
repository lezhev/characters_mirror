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

final itemCatalogProvider = FutureProvider<List<ItemData>>((ref) {
  return ref.watch(itemRepositoryProvider).getAll();
});

final weaponCatalogProvider = FutureProvider<List<WeaponData>>((ref) {
  return ref.watch(weaponRepositoryProvider).getAll();
});
