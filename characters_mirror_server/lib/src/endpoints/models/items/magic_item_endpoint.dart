import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MagicItemDataEndpoint extends Endpoint {
  Future<List<MagicItemData>> getAll(Session session) async {
    return await MagicItemData.db.find(session);
  }

  Future<MagicItemData> add(Session session, MagicItemData item) async {
    return await MagicItemData.db.insertRow(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await MagicItemData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
