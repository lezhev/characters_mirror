part of '../race_endpoints.dart';

class RaceFeatureEndpoint extends Endpoint {
  Future<List<RaceFeatureData>> getAll(Session session) async {
    return RaceFeatureData.db.find(session);
  }

  Future<RaceFeatureData> add(
      Session session, RaceFeatureData raceFeature) async {
    _validateRaceFeature(raceFeature);
    _stampForInsert(raceFeature);
    return RaceFeatureData.db.insertRow(session, raceFeature);
  }

  Future<RaceFeatureData> upsert(
    Session session,
    RaceFeatureData raceFeature,
  ) async {
    _validateRaceFeature(raceFeature);
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
    await RaceFeatureData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
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

class RaceChoiceOptionDataEndpoint extends Endpoint {
  Future<List<RaceChoiceOptionData>> getAll(Session session) async {
    return RaceChoiceOptionData.db.find(
      session,
      include: RaceChoiceOptionData.include(
        spell: SpellData.include(),
        feat: FeatData.include(),
      ),
    );
  }

  Future<RaceChoiceOptionData> add(
    Session session,
    RaceChoiceOptionData item,
  ) async {
    await _validateRaceChoiceOption(session, item);
    _stampForInsert(item);
    return RaceChoiceOptionData.db.insertRow(session, item);
  }

  Future<RaceChoiceOptionData> upsert(
    Session session,
    RaceChoiceOptionData item,
  ) async {
    await _validateRaceChoiceOption(session, item);
    return _upsertRaceLike(
      session,
      item,
      findExisting: () => RaceChoiceOptionData.db.find(
        session,
        where: (t) => t.id.equals(item.id),
        limit: 1,
      ),
      insert: () => RaceChoiceOptionData.db.insertRow(session, item),
      update: () async {
        await RaceChoiceOptionData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceChoiceOptionData.db.deleteWhere(
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
