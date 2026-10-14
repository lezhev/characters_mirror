import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/auth/application/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DmCreatureRepository {
  Future<List<DmCreatureSummary>> list();
  Future<DmCreatureRecord> get(int id);
  Future<DmCreatureImportResult> import(String rawJson);
  Future<void> delete(int id);
}

final dmCreatureRepositoryProvider = Provider<DmCreatureRepository>((ref) {
  ref.watch(authProvider);
  return ServerpodDmCreatureRepository(ref.watch(serverpodClientProvider));
});

class ServerpodDmCreatureRepository implements DmCreatureRepository {
  ServerpodDmCreatureRepository(this.client);
  final Client client;
  @override
  Future<List<DmCreatureSummary>> list() => client.dmCreature.getCreatures();
  @override
  Future<DmCreatureRecord> get(int id) => client.dmCreature.getCreature(id);
  @override
  Future<DmCreatureImportResult> import(String rawJson) =>
      client.dmCreature.importCreature(rawJson);
  @override
  Future<void> delete(int id) => client.dmCreature.deleteCreature(id);
}
