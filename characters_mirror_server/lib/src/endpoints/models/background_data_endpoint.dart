import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class BackgroundDataEndpoint extends Endpoint {
  Future<List<BackgroundData>> getAll(Session session) async {
    return await BackgroundData.db.find(session);
  }

  Future<BackgroundData> add(Session session, BackgroundData background) async {
    return await BackgroundData.db.insertRow(session, background);
  }

  Future<BackgroundData> upsert(
      Session session, BackgroundData background) async {
    final existing = await BackgroundData.db.find(
      session,
      where: (t) => t.id.equals(background.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      background.id = existing.first.id;
      await BackgroundData.db.updateRow(session, background);
      return background;
    } else {
      return await BackgroundData.db.insertRow(session, background);
    }
  }

  Future<void> delete(Session session, int id) async {
    await BackgroundData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
