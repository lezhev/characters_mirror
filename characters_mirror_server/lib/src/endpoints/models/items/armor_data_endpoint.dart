import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ArmorDataEndpoint extends Endpoint {
  Future<List<ArmorData>> getAll(Session session) async {
    return await ArmorData.db.find(session);
  }

  Future<ArmorData> add(Session session, ArmorData armor) async {
    return await ArmorData.db.insertRow(session, armor);
  }

  Future<ArmorData> upsert(Session session, ArmorData armor) async {
    final normalizedReferenceKey = armor.referenceKey?.trim();
    final existing = await ArmorData.db.find(
      session,
      where: normalizedReferenceKey != null && normalizedReferenceKey.isNotEmpty
          ? (t) => t.referenceKey.equals(normalizedReferenceKey)
          : (t) => t.name.equals(armor.name),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      armor.id = existing.first.id;
      await ArmorData.db.updateRow(session, armor);
      return armor;
    } else {
      return await ArmorData.db.insertRow(session, armor);
    }
  }

  Future<void> delete(Session session, int id) async {
    await ArmorData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
