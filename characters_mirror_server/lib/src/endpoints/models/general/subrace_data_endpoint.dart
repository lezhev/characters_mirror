import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SubraceDataEndpoint extends Endpoint {
  Future<List<SubraceData>> getAll(Session session) async {
    return await SubraceData.db.find(session);
  }

  Future<SubraceData> add(Session session, SubraceData subrace) async {
    return await SubraceData.db.insertRow(session, subrace);
  }

  Future<SubraceData> upsert(Session session, SubraceData subrace) async {
    final existingList = await SubraceData.db.find(
      session,
      where: (t) => t.id.equals(subrace.id),
      limit: 1,
    );

    if (existingList.isNotEmpty) {
      subrace.id = existingList.first.id;
      await SubraceData.db.updateRow(session, subrace);
      return subrace;
    } else {
      return await SubraceData.db.insertRow(session, subrace);
    }
  }

  Future<void> delete(Session session, int id) async {
    await SubraceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
