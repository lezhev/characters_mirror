part of '../class_endpoints.dart';

void _stampForInsert(dynamic row) {
  final now = DateTime.now();
  row.version ??= 1;
  row.createdAt ??= now;
  row.updatedAt ??= now;
}

Future<T> _upsertById<T>(
  Session session,
  dynamic row, {
  required Future<List<dynamic>> Function() findExisting,
  required Future<T> Function() insert,
  required Future<T> Function() update,
}) async {
  final existing = await findExisting();
  final now = DateTime.now();
  if (existing.isNotEmpty) {
    final old = existing.first;
    row.id = old.id;
    if (row.version != null || old.version != null) {
      row.version = (old.version ?? 0) + 1;
    }
    if (row.createdAt != null || old.createdAt != null) {
      row.createdAt = old.createdAt ?? now;
      row.updatedAt = now;
    }
    return update();
  }

  _stampForInsert(row);
  return insert();
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

void _validateClassSpellGrant(ClassSpellGrantData item) {
  if (item.spellId == null || item.spellId! <= 0) {
    throw Exception(
      'ClassSpellGrantData must reference a spell by spellId or spellReferenceKey.',
    );
  }

  final hasSource = item.sourceClassId != null ||
      item.sourceSubclassId != null ||
      item.sourceFeatureId != null ||
      item.sourceSubclassFeatureId != null;
  if (!hasSource) {
    throw Exception(
      'ClassSpellGrantData must reference a class, subclass, class feature, or subclass feature.',
    );
  }
}

ClassFeatureDataInclude _classFeatureInclude() {
  return ClassFeatureData.include(
    resources: FeatureResourceDefinitionData.includeList(
      include: _featureResourceDefinitionInclude(),
    ),
    resourceEffects: FeatureResourceEffectData.includeList(),
    spellGrants: ClassSpellGrantData.includeList(
      include: ClassSpellGrantData.include(
        spell: SpellData.include(),
      ),
    ),
  );
}

SubclassFeatureDataInclude _subclassFeatureInclude() {
  return SubclassFeatureData.include(
    resources: FeatureResourceDefinitionData.includeList(
      include: _featureResourceDefinitionInclude(),
    ),
    resourceEffects: FeatureResourceEffectData.includeList(),
    spellGrants: ClassSpellGrantData.includeList(
      include: ClassSpellGrantData.include(
        spell: SpellData.include(),
      ),
    ),
  );
}

ClassFeatureData _normalizeClassFeature(ClassFeatureData feature) {
  final resources = _normalizedFeatureResources(feature.resources);
  final resourceEffects = _normalizedFeatureResourceEffects(
    feature.resourceEffects,
  );
  final spellGrants = [
    ...?feature.spellGrants,
  ]..sort(_compareClassSpellGrants);
  return feature.copyWith(
    resources: resources,
    resourceEffects: resourceEffects,
    spellGrants: spellGrants,
  );
}

SubclassFeatureData _normalizeSubclassFeature(SubclassFeatureData feature) {
  final resources = _normalizedFeatureResources(feature.resources);
  final resourceEffects = _normalizedFeatureResourceEffects(
    feature.resourceEffects,
  );
  final spellGrants = [
    ...?feature.spellGrants,
  ]..sort(_compareClassSpellGrants);
  return feature.copyWith(
    resources: resources,
    resourceEffects: resourceEffects,
    spellGrants: spellGrants,
  );
}

Future<List<ClassStepFeatureView>> _classStepFeatureViews(
  Session session,
  Iterable<ClassFeatureData> sourceFeatures, {
  required int sourceLevel,
  required Map<String, int> abilityModifiers,
}) async {
  final features = sourceFeatures.map(_normalizeClassFeature).toList();
  final featureIds = {
    for (final feature in features)
      if (feature.id != null) feature.id!,
  };
  final properties = featureIds.isEmpty
      ? const <FeatureDisplayPropertyData>[]
      : await FeatureDisplayPropertyData.db.find(
          session,
          where: (t) => t.sourceClassFeatureId.inSet(featureIds),
          orderBy: (t) => t.sortOrder,
        );
  return [
    for (final feature in features)
      ClassStepFeatureView(
        classFeature: feature,
        resources: referenceResourceSummaries(feature.resources,
            name: feature.name,
            sourceLevel: sourceLevel,
            abilityModifiers: abilityModifiers),
        displayProperties: resolveDisplayPropertyViews(
          definitions: properties.where(
            (property) => property.sourceClassFeatureId == feature.id,
          ),
          sourceLevel: sourceLevel,
          abilityModifiers: abilityModifiers,
          subclassLevel: sourceLevel,
        ),
      ),
  ];
}

Future<List<ClassStepFeatureView>> _subclassStepFeatureViews(
  Session session,
  Iterable<SubclassFeatureData> sourceFeatures, {
  required int sourceLevel,
  required Map<String, int> abilityModifiers,
}) async {
  final features = sourceFeatures.map(_normalizeSubclassFeature).toList();
  final featureIds = {
    for (final feature in features)
      if (feature.id != null) feature.id!,
  };
  final properties = featureIds.isEmpty
      ? const <FeatureDisplayPropertyData>[]
      : await FeatureDisplayPropertyData.db.find(
          session,
          where: (t) => t.sourceSubclassFeatureId.inSet(featureIds),
          orderBy: (t) => t.sortOrder,
        );
  return [
    for (final feature in features)
      ClassStepFeatureView(
        subclassFeature: feature,
        resources: referenceResourceSummaries(feature.resources,
            name: feature.name,
            sourceLevel: sourceLevel,
            abilityModifiers: abilityModifiers),
        displayProperties: resolveDisplayPropertyViews(
          definitions: properties.where(
            (property) => property.sourceSubclassFeatureId == feature.id,
          ),
          sourceLevel: sourceLevel,
          abilityModifiers: abilityModifiers,
          subclassLevel: sourceLevel,
        ),
      ),
  ];
}

Map<String, int> _abilityModifiersForScores(Map<String, int>? scores) {
  if (scores == null) return const {};
  return {
    for (final ability in Ability.values)
      if (scores[ability.name] != null)
        ability.name: ((scores[ability.name]! - 10) / 2).floor(),
  };
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

Future<ClassFeatureData> _loadClassFeature(Session session, int id) async {
  final row = await ClassFeatureData.db.findById(
    session,
    id,
    include: _classFeatureInclude(),
  );
  if (row == null) {
    throw Exception('ClassFeatureData with id=$id was not found.');
  }
  return _normalizeClassFeature(row);
}

Future<SubclassFeatureData> _loadSubclassFeature(
    Session session, int id) async {
  final row = await SubclassFeatureData.db.findById(
    session,
    id,
    include: _subclassFeatureInclude(),
  );
  if (row == null) {
    throw Exception('SubclassFeatureData with id=$id was not found.');
  }
  return _normalizeSubclassFeature(row);
}

Future<void> _upsertClassFeatureSpellGrants(
  Session session,
  int featureId,
  List<ClassSpellGrantData>? spellGrants,
) async {
  if (spellGrants == null) {
    return;
  }

  for (final grant in spellGrants) {
    await _upsertClassSpellGrant(
      session,
      grant.copyWith(
        sourceClassId: null,
        sourceSubclassId: null,
        sourceFeatureId: featureId,
        sourceSubclassFeatureId: null,
      ),
      findByNaturalKey: true,
    );
  }
}

Future<void> _upsertSubclassFeatureSpellGrants(
  Session session,
  int featureId,
  List<ClassSpellGrantData>? spellGrants,
) async {
  if (spellGrants == null) {
    return;
  }

  for (final grant in spellGrants) {
    await _upsertClassSpellGrant(
      session,
      grant.copyWith(
        sourceClassId: null,
        sourceSubclassId: null,
        sourceFeatureId: null,
        sourceSubclassFeatureId: featureId,
      ),
      findByNaturalKey: true,
    );
  }
}

Future<ClassSpellGrantData> _upsertClassSpellGrant(
  Session session,
  ClassSpellGrantData item, {
  bool findByNaturalKey = false,
}) async {
  await _prepareClassSpellGrantForWrite(session, item);
  return _upsertById(
    session,
    item,
    findExisting: () {
      if (item.id != null || !findByNaturalKey) {
        return ClassSpellGrantData.db.find(
          session,
          where: (t) => t.id.equals(item.id),
          limit: 1,
        );
      }
      return ClassSpellGrantData.db.find(
        session,
        where: (t) =>
            t.spellId.equals(item.spellId) &
            t.sourceClassId.equals(item.sourceClassId) &
            t.sourceSubclassId.equals(item.sourceSubclassId) &
            t.sourceFeatureId.equals(item.sourceFeatureId) &
            t.sourceSubclassFeatureId.equals(item.sourceSubclassFeatureId) &
            t.grantedAtLevel.equals(item.grantedAtLevel),
        limit: 1,
      );
    },
    insert: () => ClassSpellGrantData.db.insertRow(session, item),
    update: () async {
      await ClassSpellGrantData.db.updateRow(session, item);
      return item;
    },
  );
}

Future<void> _prepareClassSpellGrantForWrite(
  Session session,
  ClassSpellGrantData item,
) async {
  final spellReferenceKey = item.spellReferenceKey?.trim();
  if ((item.spellId == null || item.spellId! <= 0) &&
      spellReferenceKey != null &&
      spellReferenceKey.isNotEmpty) {
    final spells = await SpellData.db.find(
      session,
      where: (t) => t.referenceKey.equals(spellReferenceKey),
      limit: 1,
    );
    if (spells.isEmpty || spells.first.id == null) {
      throw Exception(
        'SpellData with referenceKey="$spellReferenceKey" was not found.',
      );
    }
    item.spellId = spells.first.id;
  }
  _validateClassSpellGrant(item);
}

int _compareClassSpellGrants(
  ClassSpellGrantData a,
  ClassSpellGrantData b,
) {
  final levelCompare = (a.grantedAtLevel ?? 1).compareTo(b.grantedAtLevel ?? 1);
  if (levelCompare != 0) return levelCompare;
  return (a.spell?.name ?? '').compareTo(b.spell?.name ?? '');
}
