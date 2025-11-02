import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class CharacterDataEndpoint extends Endpoint {
  Future<List<CharacterData>> getAll(Session session) async {
    return await CharacterData.db.find(session);
  }

  Future<CharacterData> add(Session session, CharacterData character) async {
    final inserted = await CharacterData.db.insertRow(session, character);
    return inserted;
  }

  Future<void> delete(Session session, int id) async {
    await CharacterData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
