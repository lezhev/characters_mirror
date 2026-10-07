import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/validation/rules.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:serverpod/serverpod.dart';

class SpellDataEndpoint extends Endpoint {
  Future<List<SpellData>> getAll(Session session) async {
    return await SpellData.db.find(session);
  }

  Future<SpellData> add(Session session, SpellData spell) async {
    _validateReferenceKey(spell);
    return await SpellData.db.insertRow(session, spell);
  }

  Future<SpellData> upsert(Session session, SpellData spell) async {
    _validateReferenceKey(spell);
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

  void _validateReferenceKey(SpellData spell) {
    Rules.shortText('referenceKey', spell.referenceKey);
    if (spell.referenceKey.trim().isEmpty ||
        spell.referenceKey != spell.referenceKey.trim()) {
      throw InputValidationException(
          'referenceKey', 'must be a non-empty canonical reference key.');
    }
  }
}
