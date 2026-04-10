import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MagicItemDataEndpoint extends Endpoint {
  Future<List<MagicItemData>> getAll(Session session) async {
    return await MagicItemData.db.find(session);
  }

  Future<MagicItemData> add(Session session, MagicItemData item) async {
    return await MagicItemData.db.insertRow(session, item);
  }

  Future<MagicItemData> upsert(Session session, MagicItemData magicItem) async {
    final normalizedReferenceKey = magicItem.referenceKey?.trim();
    final existing = await MagicItemData.db.find(
      session,
      where: normalizedReferenceKey != null && normalizedReferenceKey.isNotEmpty
          ? (t) => t.referenceKey.equals(normalizedReferenceKey)
          : (t) => t.name.equals(magicItem.name),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      magicItem.id = existing.first.id;
      await MagicItemData.db.updateRow(session, magicItem);
      return magicItem;
    } else {
      return await MagicItemData.db.insertRow(session, magicItem);
    }
  }

  Future<void> delete(Session session, int id) async {
    await MagicItemData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
