import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SubclassDataEndpoint extends Endpoint {
  Future<List<SubclassData>> getAll(Session session) async {
    return await SubclassData.db.find(session);
  }

  Future<SubclassData> add(Session session, SubclassData item) async {
    return await SubclassData.db.insertRow(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await SubclassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
