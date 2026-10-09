part of '../race_endpoints.dart';

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
  return feature.copyWith(
    resources: resources,
    resourceEffects: resourceEffects,
    spellGrants: spellGrants,
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

void _validateRaceFeatureSpellGrant(RaceFeatureSpellGrantData item) {
  if (item.activation != null) {
    validateSpellActivation(item.activation!.toJson());
  }
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

int _compareRaceFeatures(RaceFeatureData a, RaceFeatureData b) {
  final levelCompare = (a.level ?? 1).compareTo(b.level ?? 1);
  if (levelCompare != 0) return levelCompare;
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
