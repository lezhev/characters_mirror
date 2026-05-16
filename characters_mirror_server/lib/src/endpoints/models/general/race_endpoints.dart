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

Future<List<RaceFeatureData>> _findRaceFeatures(
  Session session, {
  required WhereExpressionBuilder<RaceFeatureDataTable> where,
}) async {
  final rows = await RaceFeatureData.db.find(
    session,
    where: where,
    include: RaceFeatureData.include(
      resources: FeatureResourceDefinitionData.includeList(
        include: _featureResourceDefinitionInclude(),
      ),
      resourceEffects: FeatureResourceEffectData.includeList(),
      spellGrants: RaceFeatureSpellGrantData.includeList(
        include: RaceFeatureSpellGrantData.include(
          spell: SpellData.include(),
        ),
      ),
      choiceSets: RaceChoiceSetData.includeList(
        include: RaceChoiceSetData.include(
          choiceOptions: RaceChoiceOptionData.includeList(
            include: RaceChoiceOptionData.include(
              spell: SpellData.include(),
              feat: FeatData.include(),
            ),
          ),
        ),
      ),
    ),
  );

  return rows.map(_normalizeRaceFeature).toList();
}

RaceFeatureData _normalizeRaceFeature(RaceFeatureData feature) {
  final resources = _normalizedFeatureResources(feature.resources);
  final resourceEffects = _normalizedFeatureResourceEffects(
    feature.resourceEffects,
  );
  final spellGrants = [
    ...?feature.spellGrants,
  ]..sort(_compareRaceFeatureSpellGrants);
  final choiceSets = choiceSetsOrNormalized(feature.choiceSets)
    ..sort(_compareRaceChoiceSets);

  return feature.copyWith(
    resources: resources,
    resourceEffects: resourceEffects,
    spellGrants: spellGrants,
    choiceSets: choiceSets,
  );
}

FeatureResourceDefinitionDataInclude _featureResourceDefinitionInclude() {
  return FeatureResourceDefinitionData.include(
    progressionValues: FeatureResourceProgressionValueData.includeList(),
  );
}

List<FeatureResourceDefinitionData>? _normalizedFeatureResources(
  List<FeatureResourceDefinitionData>? resources,
) {
  final normalized = [
    for (final resource in resources ?? const <FeatureResourceDefinitionData>[])
      resource.copyWith(
        progressionValues: _normalizedFeatureResourceProgressionValues(
          resource.progressionValues,
        ),
      ),
  ]..sort(_compareFeatureResources);
  return normalized.isEmpty ? null : normalized;
}

List<FeatureResourceProgressionValueData>?
    _normalizedFeatureResourceProgressionValues(
  List<FeatureResourceProgressionValueData>? values,
) {
  final normalized = [...?values]..sort(_compareFeatureResourceProgression);
  return normalized.isEmpty ? null : normalized;
}

List<FeatureResourceEffectData>? _normalizedFeatureResourceEffects(
  List<FeatureResourceEffectData>? effects,
) {
  final normalized = [...?effects]..sort(_compareFeatureResourceEffects);
  return normalized.isEmpty ? null : normalized;
}

int _compareFeatureResources(
  FeatureResourceDefinitionData a,
  FeatureResourceDefinitionData b,
) {
  return a.key.compareTo(b.key);
}

int _compareFeatureResourceProgression(
  FeatureResourceProgressionValueData a,
  FeatureResourceProgressionValueData b,
) {
  final levelCompare = a.level.compareTo(b.level);
  if (levelCompare != 0) return levelCompare;
  return a.value.compareTo(b.value);
}

int _compareFeatureResourceEffects(
  FeatureResourceEffectData a,
  FeatureResourceEffectData b,
) {
  final typeCompare = a.type.name.compareTo(b.type.name);
  if (typeCompare != 0) return typeCompare;
  return (a.targetResourceKey ?? '').compareTo(b.targetResourceKey ?? '');
}

List<RaceChoiceSetData> choiceSetsOrNormalized(
  List<RaceChoiceSetData>? choiceSets,
) {
  return [
    for (final choiceSet in choiceSets ?? const <RaceChoiceSetData>[])
      _normalizeRaceChoiceSet(choiceSet),
  ];
}

RaceChoiceSetData _normalizeRaceChoiceSet(RaceChoiceSetData choiceSet) {
  final choiceOptions = [
    ...?choiceSet.choiceOptions,
  ]..sort(_compareRaceChoiceOptions);

  return choiceSet.copyWith(
    choiceOptions: choiceOptions,
  );
}

void _stampForInsert(dynamic row) {
  final now = DateTime.now();
  row.version ??= 1;
  row.createdAt ??= now;
  row.updatedAt ??= now;
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
  row.version = (existing.version ?? 0) + 1;
  row.createdAt = existing.createdAt ?? DateTime.now();
  row.updatedAt = DateTime.now();
  return update();
}

void _validateRaceFeature(RaceFeatureData item) {
  final owners = [
    item.raceId,
    item.subraceId,
  ].whereType<int>().length;

  if (owners != 1) {
    throw ArgumentError(
      'RaceFeatureData must belong to exactly one owner: race or subrace.',
    );
  }
}

void _validateRaceChoiceSet(RaceChoiceSetData item) {
  final featureId = item.featureId;
  if (featureId <= 0) {
    throw ArgumentError(
      'RaceChoiceSetData.featureId must reference a RaceFeatureData row.',
    );
  }

  if ((item.pickCount ?? 0) <= 0) {
    throw ArgumentError(
      'RaceChoiceSetData.pickCount must be greater than zero.',
    );
  }
}

Future<void> _validateRaceChoiceOption(
  Session session,
  RaceChoiceOptionData item,
) async {
  final choiceSetId = item.choiceSetId;
  if (choiceSetId <= 0) {
    throw ArgumentError(
      'RaceChoiceOptionData.choiceSetId must reference a RaceChoiceSetData row.',
    );
  }

  final optionKey = item.optionKey?.trim();
  if (optionKey == null || optionKey.isEmpty) {
    throw ArgumentError(
      'RaceChoiceOptionData.optionKey is required.',
    );
  }

  final kind = await _resolveRaceChoiceKind(session, item);
  switch (kind) {
    case RaceChoiceKind.abilityBonusChoice:
      if (item.ability == null || (item.bonusValue ?? 0) <= 0) {
        throw ArgumentError(
          'Ability bonus options require ability and a positive bonusValue.',
        );
      }
      break;
    case RaceChoiceKind.skillProficiencyChoice:
      if (item.skill == null) {
        throw ArgumentError(
          'Skill proficiency options require skill.',
        );
      }
      break;
    case RaceChoiceKind.languageChoice:
      if (item.language == null) {
        throw ArgumentError(
          'Language choice options require language.',
        );
      }
      break;
    case RaceChoiceKind.toolProficiencyChoice:
      if (item.toolKey?.trim().isEmpty ?? true) {
        throw ArgumentError(
          'Tool proficiency options require toolKey.',
        );
      }
      break;
    case RaceChoiceKind.cantripChoice:
      if (item.spellId == null || item.spellId! <= 0) {
        throw ArgumentError(
          'Cantrip choice options require spellId.',
        );
      }
      break;
    case RaceChoiceKind.featChoice:
      if (item.featId == null || item.featId! <= 0) {
        throw ArgumentError(
          'Feat choice options require featId.',
        );
      }
      break;
    case RaceChoiceKind.dragonbornAncestryChoice:
      if (item.damageType == null ||
          item.areaOfEffectType == null ||
          item.areaText == null ||
          item.areaText!.trim().isEmpty ||
          item.saveAbility == null ||
          item.damageByLevel?.isEmpty != false) {
        throw ArgumentError(
          'Dragonborn ancestry options require damageType, areaOfEffectType, areaText, saveAbility, and damageByLevel.',
        );
      }
      break;
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

Future<RaceChoiceKind> _resolveRaceChoiceKind(
  Session session,
  RaceChoiceOptionData item,
) async {
  if (item.choiceSet?.kind != null) {
    return item.choiceSet!.kind!;
  }

  final rows = await RaceChoiceSetData.db.find(
    session,
    where: (t) => t.id.equals(item.choiceSetId),
    limit: 1,
  );
  if (rows.isEmpty || rows.first.kind == null) {
    throw ArgumentError(
      'RaceChoiceOptionData.choiceSetId must reference a RaceChoiceSetData row with kind.',
    );
  }
  return rows.first.kind!;
}

int _compareRaceFeatures(RaceFeatureData a, RaceFeatureData b) {
  final levelCompare = (a.level ?? 1).compareTo(b.level ?? 1);
  if (levelCompare != 0) return levelCompare;
  return (a.name ?? '').compareTo(b.name ?? '');
}

int _compareRaceChoiceSets(RaceChoiceSetData a, RaceChoiceSetData b) {
  final kindCompare = (a.kind?.name ?? '').compareTo(b.kind?.name ?? '');
  if (kindCompare != 0) return kindCompare;
  return (a.description ?? '').compareTo(b.description ?? '');
}

int _compareRaceChoiceOptions(RaceChoiceOptionData a, RaceChoiceOptionData b) {
  final sortCompare = (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
  if (sortCompare != 0) return sortCompare;
  return (a.name ?? '').compareTo(b.name ?? '');
}

int _compareRaceFeatureSpellGrants(
  RaceFeatureSpellGrantData a,
  RaceFeatureSpellGrantData b,
) {
  final levelCompare = (a.grantedAtLevel ?? 1).compareTo(b.grantedAtLevel ?? 1);
  if (levelCompare != 0) return levelCompare;
  return (a.spell?.name ?? '').compareTo(b.spell?.name ?? '');
}

Future<T> _requireById<T>(
  List<T> rows,
  String entityName,
  int id,
) async {
  if (rows.isEmpty) {
    throw Exception('$entityName with id=$id was not found.');
  }
  return rows.first;
}
