import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

part 'race_endpoints/race_resource_endpoints.dart';
part 'race_endpoints/race_helpers.dart';

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

  Future<RaceStepView> getStepView(Session session, int raceId) async {
    final race = await _requireById<RaceData>(
      await RaceData.db.find(
        session,
        where: (t) => t.id.equals(raceId),
        limit: 1,
      ),
      'RaceData',
      raceId,
    );
    final subraces = await SubraceData.db.find(
      session,
      where: (t) => t.parentRaceId.equals(raceId),
      orderBy: (t) => t.name,
    );
    final raceFeatures = await _findRaceFeatures(
      session,
      where: (t) => t.raceId.equals(raceId),
    );
    final subraceIds = subraces.map((subrace) => subrace.id).whereType<int>();
    final subraceFeatures = subraceIds.isEmpty
        ? const <RaceFeatureData>[]
        : await _findRaceFeatures(
            session,
            where: (t) => t.subraceId.inSet(subraceIds.toSet()),
          );
    final featuresBySubraceId = <int, List<RaceFeatureData>>{};
    for (final feature in subraceFeatures) {
      final subraceId = feature.subraceId;
      if (subraceId == null) continue;
      featuresBySubraceId.putIfAbsent(subraceId, () => []).add(feature);
    }
    for (final entry in featuresBySubraceId.entries) {
      entry.value.sort(_compareRaceFeatures);
    }

    final enrichedRace = race.copyWith(
      features: [...raceFeatures]..sort(_compareRaceFeatures),
    );
    final enrichedSubraces = subraces
        .map(
          (subrace) => subrace.copyWith(
            features: [
              ...?featuresBySubraceId[subrace.id],
            ]..sort(_compareRaceFeatures),
          ),
        )
        .toList();
    final allFeatures = [
      ...raceFeatures,
      ...subraceFeatures,
    ]..sort(_compareRaceFeatures);

    return RaceStepView(
      race: enrichedRace,
      subraces: enrichedSubraces,
      features: allFeatures,
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
