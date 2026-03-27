import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class RaceDataEndpoint extends Endpoint {
  Future<List<RaceData>> getAll(Session session) async {
    return await RaceData.db.find(session);
  }

  Future<RaceData> add(Session session, RaceData race) async {
    return await RaceData.db.insertRow(session, race);
  }

  Future<RaceData> upsert(Session session, RaceData race) async {
    final existingList = await RaceData.db.find(
      session,
      where: (t) => t.id.equals(race.id),
      limit: 1,
    );

    if (existingList.isNotEmpty) {
      final existing = existingList.first;
      race.id = existing.id;
      await RaceData.db.updateRow(session, race);
      return race;
    } else {
      return await RaceData.db.insertRow(session, race);
    }
  }

  Future<void> delete(Session session, int id) async {
    await RaceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class RaceFeatureEndpoint extends Endpoint {
  Future<List<RaceFeatureData>> getAll(Session session) async {
    return await RaceFeatureData.db.find(session);
  }

  Future<RaceFeatureData> add(
      Session session, RaceFeatureData raceFeature) async {
    return await RaceFeatureData.db.insertRow(session, raceFeature);
  }

  Future<RaceFeatureData> upsert(
      Session session, RaceFeatureData raceFeature) async {
    final existingList = await RaceFeatureData.db.find(
      session,
      where: (t) => t.id.equals(raceFeature.id),
      limit: 1,
    );

    if (existingList.isNotEmpty) {
      raceFeature.id = existingList.first.id;
      await RaceFeatureData.db.updateRow(session, raceFeature);
      return raceFeature;
    } else {
      return await RaceFeatureData.db.insertRow(session, raceFeature);
    }
  }

  Future<void> delete(Session session, int id) async {
    await RaceFeatureData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

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

class RaceOptionDataEndpoint extends Endpoint {
  Future<List<RaceOptionData>> getAll(Session session) async {
    return await RaceOptionData.db.find(session);
  }

  Future<RaceOptionData> add(Session session, RaceOptionData item) async {
    return await RaceOptionData.db.insertRow(session, item);
  }

  Future<RaceOptionData> upsert(
      Session session, RaceOptionData raceOption) async {
    final existing = await RaceOptionData.db.find(
      session,
      where: (t) => t.id.equals(raceOption.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      raceOption.id = old.id;
      raceOption.version = (old.version ?? 0) + 1;
      raceOption.createdAt = old.createdAt ?? now;
      raceOption.updatedAt = now;

      await RaceOptionData.db.updateRow(session, raceOption);
      return raceOption;
    } else {
      raceOption.version = raceOption.version ?? 1;
      raceOption.createdAt = now;
      raceOption.updatedAt = now;

      return await RaceOptionData.db.insertRow(session, raceOption);
    }
  }

  Future<void> delete(Session session, int id) async {
    await RaceOptionData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class DragonbornAncestryDataEndpoint extends Endpoint {
  Future<List<DragonbornAncestryData>> getAll(Session session) async {
    return await DragonbornAncestryData.db.find(session);
  }

  Future<DragonbornAncestryData> add(
      Session session, DragonbornAncestryData item) async {
    return await DragonbornAncestryData.db.insertRow(session, item);
  }

  Future<DragonbornAncestryData> upsert(
      Session session, DragonbornAncestryData dragonbornAncestry) async {
    final existing = await DragonbornAncestryData.db.find(
      session,
      where: (t) => t.id.equals(dragonbornAncestry.id),
      limit: 1,
    );
    final now = DateTime.now();
    if (existing.isNotEmpty) {
      final old = existing.first;
      dragonbornAncestry.id = old.id;
      dragonbornAncestry.version = (old.version ?? 0) + 1;
      dragonbornAncestry.createdAt = old.createdAt ?? now;
      dragonbornAncestry.updatedAt = now;

      await DragonbornAncestryData.db.updateRow(session, dragonbornAncestry);
      return dragonbornAncestry;
    } else {
      dragonbornAncestry.version = dragonbornAncestry.version ?? 1;
      dragonbornAncestry.createdAt = now;
      dragonbornAncestry.updatedAt = now;

      return await DragonbornAncestryData.db
          .insertRow(session, dragonbornAncestry);
    }
  }

  Future<void> delete(Session session, int id) async {
    await DragonbornAncestryData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
