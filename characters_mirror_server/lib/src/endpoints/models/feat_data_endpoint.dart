import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class FeatDataEndpoint extends Endpoint {
  Future<List<FeatData>> getAll(Session session) async {
    return await FeatData.db.find(session);
  }

  Future<FeatData> add(Session session, FeatData feat) async {
    return await FeatData.db.insertRow(session, feat);
  }

  Future<FeatData> upsert(Session session, FeatData feat) async {
    final existing = await FeatData.db.find(
      session,
      where: (t) => t.id.equals(feat.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      feat.id = existing.first.id;
      await FeatData.db.updateRow(session, feat);
      return feat;
    } else {
      return await FeatData.db.insertRow(session, feat);
    }
  }

  Future<void> delete(Session session, int id) async {
    await FeatData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
