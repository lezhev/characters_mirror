import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ClassDataEndpoint extends Endpoint {
  Future<List<ClassData>> getAll(Session session) async {
    return await ClassData.db.find(session);
  }

  Future<ClassData> add(Session session, ClassData classData) async {
    return await ClassData.db.insertRow(session, classData);
  }

  Future<void> delete(Session session, int id) async {
    await ClassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
