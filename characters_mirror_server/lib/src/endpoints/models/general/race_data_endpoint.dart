import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class RaceDataEndpoint extends Endpoint {
  Future<List<RaceData>> getAll(Session session) async {
    return await RaceData.db.find(session);
  }

  Future<RaceData> add(Session session, RaceData race) async {
    return await RaceData.db.insertRow(session, race);
  }

  Future<void> delete(Session session, int id) async {
    await RaceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
