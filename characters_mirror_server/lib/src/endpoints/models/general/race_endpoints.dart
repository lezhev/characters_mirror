import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class RaceDataEndpoint extends Endpoint {
  Future<List<RaceData>> getAll(Session session) async {
    return RaceData.db.find(session);
  }

  Future<RaceData> add(Session session, RaceData race) async {
    _stampForInsert(race);
    return RaceData.db.insertRow(session, race);
  }

  Future<RaceData> upsert(Session session, RaceData race) async {
    return _upsertRaceLike(
      session,
      race,
      findExisting: () => RaceData.db.find(
        session,
        where: (t) => t.id.equals(race.id),
        limit: 1,
      ),
      insert: () => RaceData.db.insertRow(session, race),
      update: () async {
        await RaceData.db.updateRow(session, race);
        return race;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class RaceFeatureEndpoint extends Endpoint {
  Future<List<RaceFeatureData>> getAll(Session session) async {
    return RaceFeatureData.db.find(session);
  }

  Future<RaceFeatureData> add(Session session, RaceFeatureData raceFeature) async {
    _stampForInsert(raceFeature);
    return RaceFeatureData.db.insertRow(session, raceFeature);
  }

  Future<RaceFeatureData> upsert(
    Session session,
    RaceFeatureData raceFeature,
  ) async {
    return _upsertRaceLike(
      session,
      raceFeature,
      findExisting: () => RaceFeatureData.db.find(
        session,
        where: (t) => t.id.equals(raceFeature.id),
        limit: 1,
      ),
      insert: () => RaceFeatureData.db.insertRow(session, raceFeature),
      update: () async {
        await RaceFeatureData.db.updateRow(session, raceFeature);
        return raceFeature;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceFeatureData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class SubraceDataEndpoint extends Endpoint {
  Future<List<SubraceData>> getAll(Session session) async {
    return SubraceData.db.find(session);
  }

  Future<SubraceData> add(Session session, SubraceData subrace) async {
    _stampForInsert(subrace);
    return SubraceData.db.insertRow(session, subrace);
  }

  Future<SubraceData> upsert(Session session, SubraceData subrace) async {
    return _upsertRaceLike(
      session,
      subrace,
      findExisting: () => SubraceData.db.find(
        session,
        where: (t) => t.id.equals(subrace.id),
        limit: 1,
      ),
      insert: () => SubraceData.db.insertRow(session, subrace),
      update: () async {
        await SubraceData.db.updateRow(session, subrace);
        return subrace;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await SubraceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class DragonbornAncestryDataEndpoint extends Endpoint {
  Future<List<DragonbornAncestryData>> getAll(Session session) async {
    return DragonbornAncestryData.db.find(session);
  }

  Future<DragonbornAncestryData> add(
    Session session,
    DragonbornAncestryData item,
  ) async {
    _stampForInsert(item);
    return DragonbornAncestryData.db.insertRow(session, item);
  }

  Future<DragonbornAncestryData> upsert(
    Session session,
    DragonbornAncestryData dragonbornAncestry,
  ) async {
    return _upsertRaceLike(
      session,
      dragonbornAncestry,
      findExisting: () => DragonbornAncestryData.db.find(
        session,
        where: (t) => t.id.equals(dragonbornAncestry.id),
        limit: 1,
      ),
      insert: () => DragonbornAncestryData.db.insertRow(
        session,
        dragonbornAncestry,
      ),
      update: () async {
        await DragonbornAncestryData.db.updateRow(session, dragonbornAncestry);
        return dragonbornAncestry;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await DragonbornAncestryData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class RaceChoiceSetDataEndpoint extends Endpoint {
  Future<List<RaceChoiceSetData>> getAll(Session session) async {
    return RaceChoiceSetData.db.find(session);
  }

  Future<RaceChoiceSetData> add(Session session, RaceChoiceSetData item) async {
    _validateRaceChoiceSet(item);
    _stampForInsert(item);
    return RaceChoiceSetData.db.insertRow(session, item);
  }

  Future<RaceChoiceSetData> upsert(
    Session session,
    RaceChoiceSetData item,
  ) async {
    _validateRaceChoiceSet(item);
    return _upsertRaceLike(
      session,
      item,
      findExisting: () => RaceChoiceSetData.db.find(
        session,
        where: (t) => t.id.equals(item.id),
        limit: 1,
      ),
      insert: () => RaceChoiceSetData.db.insertRow(session, item),
      update: () async {
        await RaceChoiceSetData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceChoiceSetData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class RaceFeatureSpellGrantDataEndpoint extends Endpoint {
  Future<List<RaceFeatureSpellGrantData>> getAll(Session session) async {
    return RaceFeatureSpellGrantData.db.find(session);
  }

  Future<RaceFeatureSpellGrantData> add(
    Session session,
    RaceFeatureSpellGrantData item,
  ) async {
    _validateRaceFeatureSpellGrant(item);
    _stampForInsert(item);
    return RaceFeatureSpellGrantData.db.insertRow(session, item);
  }

  Future<RaceFeatureSpellGrantData> upsert(
    Session session,
    RaceFeatureSpellGrantData item,
  ) async {
    _validateRaceFeatureSpellGrant(item);
    return _upsertRaceLike(
      session,
      item,
      findExisting: () => RaceFeatureSpellGrantData.db.find(
        session,
        where: (t) => t.id.equals(item.id),
        limit: 1,
      ),
      insert: () => RaceFeatureSpellGrantData.db.insertRow(session, item),
      update: () async {
        await RaceFeatureSpellGrantData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceFeatureSpellGrantData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

void _stampForInsert(dynamic row) {
  final now = DateTime.now();
  if (row.version != null || row.createdAt != null || row.updatedAt != null) {
    row.version ??= 1;
    row.createdAt ??= now;
    row.updatedAt ??= now;
  }
}

Future<T> _upsertRaceLike<T>(
  Session session,
  dynamic row, {
  required Future<List<dynamic>> Function() findExisting,
  required Future<T> Function() insert,
  required Future<T> Function() update,
}) async {
  final existingList = await findExisting();
  if (existingList.isEmpty) {
    _stampForInsert(row);
    return insert();
  }

  final existing = existingList.first;
  row.id = existing.id;
  if (row.version != null || existing.version != null) {
    row.version = (existing.version ?? 0) + 1;
  }
  if (row.createdAt != null || existing.createdAt != null) {
    row.createdAt = existing.createdAt ?? DateTime.now();
    row.updatedAt = DateTime.now();
  }
  return update();
}

void _validateRaceChoiceSet(RaceChoiceSetData item) {
  final owners = [
    item.raceId,
    item.subraceId,
    item.featureId,
  ].whereType<int>().length;

  if (owners != 1) {
    throw ArgumentError(
      'RaceChoiceSetData must belong to exactly one owner: race, subrace, or feature.',
    );
  }
}

void _validateRaceFeatureSpellGrant(RaceFeatureSpellGrantData item) {
  if (item.featureId <= 0) {
    throw ArgumentError(
      'RaceFeatureSpellGrantData.featureId must reference a RaceFeatureData row.',
    );
  }

  if (item.spellId <= 0) {
    throw ArgumentError(
      'RaceFeatureSpellGrantData.spellId must reference a SpellData row.',
    );
  }
}
