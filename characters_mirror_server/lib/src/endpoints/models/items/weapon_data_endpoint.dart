import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class WeaponDataEndpoint extends Endpoint {
  Future<List<WeaponData>> getAll(Session session) async {
    return await WeaponData.db.find(session);
  }

  Future<WeaponData> add(Session session, WeaponData weapon) async {
    return await WeaponData.db.insertRow(session, weapon);
  }

  Future<WeaponData> upsert(Session session, WeaponData weapon) async {
    final normalizedReferenceKey = weapon.referenceKey?.trim();
    final existing = await WeaponData.db.find(
      session,
      where: normalizedReferenceKey != null && normalizedReferenceKey.isNotEmpty
          ? (t) => t.referenceKey.equals(normalizedReferenceKey)
          : (t) => t.name.equals(weapon.name),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      weapon.id = existing.first.id;
      await WeaponData.db.updateRow(session, weapon);
      return weapon;
    } else {
      return await WeaponData.db.insertRow(session, weapon);
    }
  }

  Future<void> delete(Session session, int id) async {
    await WeaponData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
