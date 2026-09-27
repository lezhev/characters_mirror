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
    final featureIds =
        allFeatures.map((feature) => feature.id).whereType<int>().toSet();
    final genericGroupsById = <int, ChoiceGroupData>{};
    final raceGroups = await ChoiceGroupData.db.find(
      session,
      where: (t) => t.sourceRaceId.equals(raceId),
    );
    for (final group in raceGroups) {
      if (group.id != null) genericGroupsById[group.id!] = group;
    }
    if (subraceIds.isNotEmpty) {
      final subraceGroups = await ChoiceGroupData.db.find(
        session,
        where: (t) => t.sourceSubraceId.inSet(subraceIds.toSet()),
      );
      for (final group in subraceGroups) {
        if (group.id != null) genericGroupsById[group.id!] = group;
      }
    }
    if (featureIds.isNotEmpty) {
      final featureGroups = await ChoiceGroupData.db.find(
        session,
        where: (t) => t.sourceRaceFeatureId.inSet(featureIds),
      );
      for (final group in featureGroups) {
        if (group.id != null) genericGroupsById[group.id!] = group;
      }
    }
    final genericGroups = genericGroupsById.values.toList()
      ..sort((a, b) {
        final sortCompare = (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
        if (sortCompare != 0) return sortCompare;
        return a.referenceKey.compareTo(b.referenceKey);
      });
    final genericGroupViews = <ChoiceGroupView>[];
    for (final group in genericGroups) {
      final options = await ChoiceOptionData.db.find(
        session,
        where: (t) => t.choiceGroupId.equals(group.id),
        orderBy: (t) => t.sortOrder,
      );
      genericGroupViews.add(ChoiceGroupView(group: group, options: options));
    }

    return RaceStepView(
      race: enrichedRace,
      subraces: enrichedSubraces,
      features: allFeatures,
      choiceGroups: genericGroupViews,
    );
  }

  Future<void> delete(Session session, int id) async {
    await RaceData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}
