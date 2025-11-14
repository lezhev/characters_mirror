import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class SpellDataEndpoint extends Endpoint {
  Future<List<SpellData>> getAll(Session session) async {
    return await SpellData.db.find(session);
  }

  Future<SpellData> add(Session session, SpellData spell) async {
    return await SpellData.db.insertRow(session, spell);
  }

  Future<SpellData> upsert(Session session, SpellData spell) async {
    final existing = await SpellData.db.find(
      session,
      where: (t) => t.id.equals(spell.id),
      limit: 1,
    );

    if (existing.isNotEmpty) {
      spell.id = existing.first.id;
      await SpellData.db.updateRow(session, spell);
      return spell;
    } else {
      return await SpellData.db.insertRow(session, spell);
    }
  }

  Future<void> delete(Session session, int id) async {
    await SpellData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
