import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CharacterEndpoint extends Endpoint {
  Future<List<Character>> getAll(Session session) async {
    return await Character.db.find(session);
  }

  Future<Character> add(Session session, Character character) async {
    final inserted = await Character.db.insertRow(session, character);
    return inserted;
  }

  Future<void> delete(Session session, int id) async {
    await Character.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
