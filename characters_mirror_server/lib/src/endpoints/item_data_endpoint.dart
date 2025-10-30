import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ItemDataEndpoint extends Endpoint {
  Future<List<ItemData>> getAll(Session session) async {
    return await ItemData.db.find(session);
  }

  Future<ItemData> add(Session session, ItemData item) async {
    return await ItemData.db.insertRow(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await ItemData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
