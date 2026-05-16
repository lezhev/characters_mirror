import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'starting_equipment_endpoints.dart';

class ClassDataEndpoint extends Endpoint {
  Future<List<ClassData>> getAll(Session session) async {
    return ClassData.db.find(session);
  }

  Future<ClassData> add(Session session, ClassData classData) async {
    _stampForInsert(classData);
    return ClassData.db.insertRow(session, classData);
  }

  Future<ClassData> upsert(Session session, ClassData classData) async {
    return _upsertById(
      session,
      classData,
      findExisting: () => ClassData.db.find(
        session,
        where: (t) => t.id.equals(classData.id),
        limit: 1,
      ),
      insert: () => ClassData.db.insertRow(session, classData),
      update: () async {
        await ClassData.db.updateRow(session, classData);
        return classData;
      },
    );
  }

  Future<ClassStepView> getStepView(
    Session session,
    int classId, {
    int selectedLevel = 1,
    bool isStartingClass = true,
    int? selectedSubclassId,
  }) async {
    final classData = await _requireById<ClassData>(
      await ClassData.db.find(
        session,
        where: (t) => t.id.equals(classId),
        limit: 1,
      ),
      'ClassData',
      classId,
    );
    final features = await ClassFeatureData.db.find(
      session,
      where: (t) => t.parentClassId.equals(classId),
      orderBy: (t) => t.level,
      include: _classFeatureInclude(),
    );
    final subclasses = await SubclassData.db.find(
      session,
      where: (t) => t.parentClassId.equals(classId),
      orderBy: (t) => t.levelRequired,
    );
    final subclassFeatures = selectedSubclassId == null
        ? const <SubclassFeatureData>[]
        : await SubclassFeatureData.db.find(
            session,
            where: (t) => t.parentSubclassId.equals(selectedSubclassId),
            orderBy: (t) => t.level,
            include: _subclassFeatureInclude(),
          );
    final progression = await ClassLevelData.db.find(
      session,
      where: (t) => t.classDataId.equals(classId),
      orderBy: (t) => t.level,
    );
    final selectedClassLevel = _classLevelForSelection(
      progression,
      selectedLevel,
    );
    final groups = await ClassChoiceGroupData.db.find(session);
    final currentFeatureIds = features
        .where((feature) => feature.level <= selectedLevel)
        .map((feature) => feature.id)
        .whereType<int>()
        .toSet();
    final currentSubclassFeatureIds = subclassFeatures
        .where((feature) => feature.level <= selectedLevel)
        .map((feature) => feature.id)
        .whereType<int>()
        .toSet();

    final currentGroups = <ClassChoiceGroupView>[];
    for (final group in groups.where((group) {
      if (_isMigratedSkillGroup(group)) {
        return false;
      }
      final byClass = group.sourceClassId == classId;
      final byFeature = group.sourceFeatureId != null &&
          currentFeatureIds.contains(group.sourceFeatureId);
      final bySubclass = selectedSubclassId != null &&
          group.sourceSubclassId == selectedSubclassId;
      final bySubclassFeature = group.sourceSubclassFeatureId != null &&
          currentSubclassFeatureIds.contains(group.sourceSubclassFeatureId);
      final unlocked = (group.level ?? 1) <= selectedLevel;
      return unlocked &&
          (byClass || byFeature || bySubclass || bySubclassFeature);
    })) {
      final options = await ClassChoiceOptionData.db.find(
        session,
        where: (t) => t.choiceGroupId.equals(group.id),
      );
      currentGroups.add(
        ClassChoiceGroupView(
          group: group,
          options: options,
        ),
      );
    }
    final startingEquipmentBlocks = isStartingClass
        ? await startingEquipmentBlockViews(session, sourceClassId: classId)
        : const <StartingEquipmentBlockView>[];
    final skillSelectionGroups = isStartingClass
        ? _buildClassSkillSelectionGroups(classData)
        : const <SkillSelectionGroupView>[];
    final spellSelectionGroups = isStartingClass && selectedClassLevel != null
        ? await _buildSpellSelectionGroups(
            session,
            classId: classId,
            classData: classData,
            selectedLevel: selectedLevel,
            classLevel: selectedClassLevel,
          )
        : const <ClassSpellSelectionGroupView>[];

    final warnings = <String>[];
    if (!isStartingClass) {
      warnings.add(
        'Saving throw proficiencies come only from the starting class.',
      );
      if (classData.multiclassPrerequisites?.isNotEmpty == true) {
        final requirements = classData.multiclassPrerequisites!.entries
            .map((entry) => '${entry.key} ${entry.value}+')
            .join(', ');
        warnings.add('Multiclass prerequisite: $requirements.');
      }
    }

    return ClassStepView(
      classData: classData,
      selectedLevel: selectedLevel,
      currentLevelFeatures: features
          .where((feature) => feature.level <= selectedLevel)
          .map(_normalizeClassFeature)
          .toList(),
      futureLevelFeatures: features
          .where((feature) => feature.level > selectedLevel)
          .map(_normalizeClassFeature)
          .toList(),
      currentSubclassFeatures: subclassFeatures
          .where((feature) => feature.level <= selectedLevel)
          .map(_normalizeSubclassFeature)
          .toList(),
      futureSubclassFeatures: subclassFeatures
          .where((feature) => feature.level > selectedLevel)
          .map(_normalizeSubclassFeature)
          .toList(),
      subclassChoice: ClassStepSubclassChoiceView(
        requiredLevel: classData.subclassChoiceLevel,
        subclasses: subclasses,
      ),
      choiceGroups: currentGroups,
      skillSelectionGroups: skillSelectionGroups,
      spellSelectionGroups: spellSelectionGroups,
      startingEquipmentBlocks: startingEquipmentBlocks,
      startingProficiencies: ProficiencyBundleView(
        savingThrows: classData.savingThrowProficiencies,
        skills: classData.availableSkills,
        armorTraining: isStartingClass
            ? classData.armorTraining
            : classData.multiclassArmorTraining,
        weaponTraining: isStartingClass
            ? classData.weaponTraining
            : classData.multiclassWeaponTraining,
        toolKeys: isStartingClass
            ? classData.toolTraining
            : classData.multiclassToolTraining,
      ),
      multiclassWarnings: warnings,
      progression: progression,
    );
  }

  Future<void> delete(Session session, int id) async {
    await ClassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

bool _isMigratedSkillGroup(ClassChoiceGroupData group) {
  return group.type == null &&
      (group.sourceClassId != null || group.sourceBackgroundId != null) &&
      (group.exclusiveKey?.contains('skill') == true ||
          group.name?.toLowerCase().contains('skill') == true);
}

const _standardSpellSlotTableKey = 'standard';
const _pactMagicSpellSlotTableKey = 'pact_magic';

List<SkillSelectionGroupView> _buildClassSkillSelectionGroups(
  ClassData classData,
) {
  final classId = classData.id;
  final skillCount = classData.skillCount ?? 0;
  final options = _uniqueSkills(classData.availableSkills);
  if (classId == null || skillCount <= 0 || options.isEmpty) {
    return const <SkillSelectionGroupView>[];
  }

  return [
    SkillSelectionGroupView(
      kind: CharacterSkillSelectionKind.classSkill,
      selectionCount: skillCount,
      classDataId: classId,
      options: options,
    ),
  ];
}

List<Skill> _uniqueSkills(List<Skill>? skills) {
  final result = <Skill>[];
  final seen = <Skill>{};
  for (final skill in skills ?? const <Skill>[]) {
    if (seen.add(skill)) {
      result.add(skill);
    }
  }
  return result;
}

ClassLevelData? _classLevelForSelection(
  List<ClassLevelData> progression,
  int selectedLevel,
) {
  ClassLevelData? best;
  for (final row in progression) {
    if (row.level == selectedLevel) {
      return row;
    }
    if (row.level <= selectedLevel &&
        (best == null || row.level > best.level)) {
      best = row;
    }
  }
  return best;
}

Future<List<ClassSpellSelectionGroupView>> _buildSpellSelectionGroups(
  Session session, {
  required int classId,
  required ClassData classData,
  required int selectedLevel,
  required ClassLevelData classLevel,
}) async {
  final availability = await SpellClassAvailabilityData.db.find(
    session,
    where: (t) => t.classDataId.equals(classId),
    include: SpellClassAvailabilityData.include(
      spell: SpellData.include(),
    ),
  );
  final spells = [
    for (final row in availability)
      if (row.spell != null) row.spell!,
  ]..sort(_compareSpells);

  final groups = <ClassSpellSelectionGroupView>[];
  final knownCantrips = classLevel.knownCantrips ?? 0;
  if (knownCantrips > 0) {
    final cantrips = [
      for (final spell in spells)
        if ((spell.level ?? -1) == 0) spell,
    ];
    if (cantrips.isNotEmpty) {
      groups.add(
        ClassSpellSelectionGroupView(
          kind: CharacterSpellSelectionKind.knownCantrip,
          selectionCount: knownCantrips,
          classDataId: classId,
          classLevel: selectedLevel,
          options: cantrips,
        ),
      );
    }
  }

  final knownSpells = classLevel.knownSpells ?? 0;
  final spellSlots = await _spellSlotsForClassStep(
    session,
    classData.spellcastingProgression,
    selectedLevel,
  );
  final maxSpellLevel = _maxKnownSpellLevel(spellSlots);
  if (knownSpells > 0 && maxSpellLevel > 0) {
    final knownSpellOptions = [
      for (final spell in spells)
        if ((spell.level ?? 0) > 0 && spell.level! <= maxSpellLevel) spell,
    ];
    if (knownSpellOptions.isNotEmpty) {
      groups.add(
        ClassSpellSelectionGroupView(
          kind: CharacterSpellSelectionKind.knownSpell,
          selectionCount: knownSpells,
          classDataId: classId,
          classLevel: selectedLevel,
          options: knownSpellOptions,
        ),
      );
    }
  }

  return groups;
}

Future<Map<int, int>?> _spellSlotsForClassStep(
  Session session,
  SpellcastingProgression? progression,
  int classLevel,
) async {
  if (classLevel <= 0 || progression == null) {
    return null;
  }

  final tableKey = progression == SpellcastingProgression.pactMagic
      ? _pactMagicSpellSlotTableKey
      : _standardSpellSlotTableKey;
  final progressionLevel = _classStepProgressionLevel(
    progression,
    classLevel,
  );
  if (progressionLevel <= 0) {
    return null;
  }

  return _spellSlotsForProgressionLevel(
    session,
    tableKey,
    progressionLevel,
  );
}

int _classStepProgressionLevel(
  SpellcastingProgression progression,
  int classLevel,
) {
  switch (progression) {
    case SpellcastingProgression.full:
    case SpellcastingProgression.pactMagic:
      return classLevel;
    case SpellcastingProgression.half:
      return (classLevel + 1) ~/ 2;
    case SpellcastingProgression.third:
      return (classLevel + 2) ~/ 3;
    case SpellcastingProgression.none:
      return 0;
  }
}

Future<Map<int, int>?> _spellSlotsForProgressionLevel(
  Session session,
  String tableKey,
  int level,
) async {
  if (level <= 0) {
    return null;
  }
  final rows = await SpellSlotProgressionData.db.find(
    session,
    where: (t) => t.tableKey.equals(tableKey) & t.level.equals(level),
    limit: 1,
  );
  if (rows.isEmpty) {
    return null;
  }
  return _nonZeroSpellSlots(rows.first.spellSlots);
}

Map<int, int>? _nonZeroSpellSlots(Map<int, int>? slots) {
  final result = <int, int>{};
  for (final entry in slots?.entries ?? const Iterable.empty()) {
    if (entry.key > 0 && entry.value > 0) {
      result[entry.key] = entry.value;
    }
  }
  return result.isEmpty ? null : result;
}

int _maxKnownSpellLevel(Map<int, int>? spellSlots) {
  var maxLevel = 0;
  for (final entry in spellSlots?.entries ?? const Iterable.empty()) {
    if (entry.value > 0 && entry.key > maxLevel) {
      maxLevel = entry.key;
    }
  }
  return maxLevel;
}

int _compareSpells(SpellData left, SpellData right) {
  final levelCompare = (left.level ?? 0).compareTo(right.level ?? 0);
  if (levelCompare != 0) {
    return levelCompare;
  }
  return (left.name ?? '').compareTo(right.name ?? '');
}

class ClassFeatureDataEndpoint extends Endpoint {
  Future<List<ClassFeatureData>> getAll(Session session) async {
    final rows = await ClassFeatureData.db.find(
      session,
      include: _classFeatureInclude(),
    );
    return rows.map(_normalizeClassFeature).toList();
  }

  Future<ClassFeatureData> add(Session session, ClassFeatureData item) async {
    final spellGrants = item.spellGrants;
    final row = item.copyWith(spellGrants: null);
    _stampForInsert(row);
    final saved = await ClassFeatureData.db.insertRow(session, row);
    await _upsertClassFeatureSpellGrants(
      session,
      saved.id!,
      spellGrants,
    );
    return _loadClassFeature(session, saved.id!);
  }

  Future<ClassFeatureData> upsert(
    Session session,
    ClassFeatureData feature,
  ) async {
    final spellGrants = feature.spellGrants;
    final row = feature.copyWith(spellGrants: null);
    final saved = await _upsertById(
      session,
      row,
      findExisting: () => ClassFeatureData.db.find(
        session,
        where: (t) => t.id.equals(row.id),
        limit: 1,
      ),
      insert: () => ClassFeatureData.db.insertRow(session, row),
      update: () async {
        await ClassFeatureData.db.updateRow(session, row);
        return row;
      },
    );
    await _upsertClassFeatureSpellGrants(
      session,
      saved.id!,
      spellGrants,
    );
    return _loadClassFeature(session, saved.id!);
  }

  Future<void> delete(Session session, int id) async {
    await ClassFeatureData.db
        .deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class ClassSpellGrantDataEndpoint extends Endpoint {
  Future<List<ClassSpellGrantData>> getAll(Session session) async {
    return ClassSpellGrantData.db.find(
      session,
      include: ClassSpellGrantData.include(
        spell: SpellData.include(),
        sourceClass: ClassData.include(),
        sourceSubclass: SubclassData.include(),
        sourceFeature: ClassFeatureData.include(),
        sourceSubclassFeature: SubclassFeatureData.include(),
      ),
    );
  }

  Future<ClassSpellGrantData> add(
    Session session,
    ClassSpellGrantData item,
  ) async {
    await _prepareClassSpellGrantForWrite(session, item);
    _stampForInsert(item);
    return ClassSpellGrantData.db.insertRow(session, item);
  }

  Future<ClassSpellGrantData> upsert(
    Session session,
    ClassSpellGrantData item,
  ) async {
    return _upsertClassSpellGrant(session, item);
  }

  Future<void> delete(Session session, int id) async {
    await ClassSpellGrantData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class ClassLevelDataEndpoint extends Endpoint {
  Future<List<ClassLevelData>> getAll(Session session) async {
    return ClassLevelData.db.find(session);
  }

  Future<ClassLevelData> add(Session session, ClassLevelData item) async {
    _stampForInsert(item);
    return ClassLevelData.db.insertRow(session, item);
  }

  Future<ClassLevelData> upsert(Session session, ClassLevelData item) async {
    return _upsertById(
      session,
      item,
      findExisting: () => ClassLevelData.db.find(
        session,
        where: (t) => t.id.equals(item.id),
        limit: 1,
      ),
      insert: () => ClassLevelData.db.insertRow(session, item),
      update: () async {
        await ClassLevelData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await ClassLevelData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class SpellSlotProgressionDataEndpoint extends Endpoint {
  Future<List<SpellSlotProgressionData>> getAll(Session session) async {
    final rows = await SpellSlotProgressionData.db.find(session);
    rows.sort((a, b) {
      final tableCompare = (a.tableKey ?? '').compareTo(b.tableKey ?? '');
      if (tableCompare != 0) return tableCompare;
      return a.level.compareTo(b.level);
    });
    return rows;
  }

  Future<SpellSlotProgressionData> add(
    Session session,
    SpellSlotProgressionData item,
  ) async {
    _stampForInsert(item);
    return SpellSlotProgressionData.db.insertRow(session, item);
  }

  Future<SpellSlotProgressionData> upsert(
    Session session,
    SpellSlotProgressionData item,
  ) async {
    return _upsertById(
      session,
      item,
      findExisting: () {
        if (item.id != null) {
          return SpellSlotProgressionData.db.find(
            session,
            where: (t) => t.id.equals(item.id),
            limit: 1,
          );
        }
        return SpellSlotProgressionData.db.find(
          session,
          where: (t) =>
              t.tableKey.equals(item.tableKey) & t.level.equals(item.level),
          limit: 1,
        );
      },
      insert: () => SpellSlotProgressionData.db.insertRow(session, item),
      update: () async {
        await SpellSlotProgressionData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await SpellSlotProgressionData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class SubclassDataEndpoint extends Endpoint {
  Future<List<SubclassData>> getAll(Session session) async {
    return SubclassData.db.find(session);
  }

  Future<SubclassData> add(Session session, SubclassData item) async {
    _stampForInsert(item);
    return SubclassData.db.insertRow(session, item);
  }

  Future<SubclassData> upsert(Session session, SubclassData subclass) async {
    return _upsertById(
      session,
      subclass,
      findExisting: () => SubclassData.db.find(
        session,
        where: (t) => t.id.equals(subclass.id),
        limit: 1,
      ),
      insert: () => SubclassData.db.insertRow(session, subclass),
      update: () async {
        await SubclassData.db.updateRow(session, subclass);
        return subclass;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await SubclassData.db.deleteWhere(session, where: (t) => t.id.equals(id));
  }
}

class ClassChoiceGroupDataEndpoint extends Endpoint {
  Future<List<ClassChoiceGroupData>> getAll(Session session) async {
    return ClassChoiceGroupData.db.find(session);
  }

  Future<ClassChoiceGroupData> add(
    Session session,
    ClassChoiceGroupData item,
  ) async {
    _stampForInsert(item);
    return ClassChoiceGroupData.db.insertRow(session, item);
  }

  Future<ClassChoiceGroupData> upsert(
    Session session,
    ClassChoiceGroupData item,
  ) async {
    return _upsertById(
      session,
      item,
      findExisting: () => ClassChoiceGroupData.db.find(
        session,
        where: (t) => t.id.equals(item.id),
        limit: 1,
      ),
      insert: () => ClassChoiceGroupData.db.insertRow(session, item),
      update: () async {
        await ClassChoiceGroupData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await ClassChoiceGroupData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class ClassChoiceOptionDataEndpoint extends Endpoint {
  Future<List<ClassChoiceOptionData>> getAll(Session session) async {
    return ClassChoiceOptionData.db.find(session);
  }

  Future<ClassChoiceOptionData> add(
    Session session,
    ClassChoiceOptionData item,
  ) async {
    _stampForInsert(item);
    return ClassChoiceOptionData.db.insertRow(session, item);
  }

  Future<ClassChoiceOptionData> upsert(
    Session session,
    ClassChoiceOptionData item,
  ) async {
    return _upsertById(
      session,
      item,
      findExisting: () => ClassChoiceOptionData.db.find(
        session,
        where: (t) => t.id.equals(item.id),
        limit: 1,
      ),
      insert: () => ClassChoiceOptionData.db.insertRow(session, item),
      update: () async {
        await ClassChoiceOptionData.db.updateRow(session, item);
        return item;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await ClassChoiceOptionData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

class SubclassFeatureDataEndpoint extends Endpoint {
  Future<List<SubclassFeatureData>> getAll(Session session) async {
    final rows = await SubclassFeatureData.db.find(
      session,
      include: _subclassFeatureInclude(),
    );
    return rows.map(_normalizeSubclassFeature).toList();
  }

  Future<SubclassFeatureData> add(
    Session session,
    SubclassFeatureData item,
  ) async {
    final spellGrants = item.spellGrants;
    final row = item.copyWith(spellGrants: null);
    _stampForInsert(row);
    final saved = await SubclassFeatureData.db.insertRow(session, row);
    await _upsertSubclassFeatureSpellGrants(
      session,
      saved.id!,
      spellGrants,
    );
    return _loadSubclassFeature(session, saved.id!);
  }

  Future<SubclassFeatureData> upsert(
    Session session,
    SubclassFeatureData subclassFeature,
  ) async {
    final spellGrants = subclassFeature.spellGrants;
    final row = subclassFeature.copyWith(spellGrants: null);
    final saved = await _upsertById(
      session,
      row,
      findExisting: () => SubclassFeatureData.db.find(
        session,
        where: (t) => t.id.equals(row.id),
        limit: 1,
      ),
      insert: () => SubclassFeatureData.db.insertRow(session, row),
      update: () async {
        await SubclassFeatureData.db.updateRow(session, row);
        return row;
      },
    );
    await _upsertSubclassFeatureSpellGrants(
      session,
      saved.id!,
      spellGrants,
    );
    return _loadSubclassFeature(session, saved.id!);
  }

  Future<void> delete(Session session, int id) async {
    await SubclassFeatureData.db.deleteWhere(
      session,
      where: (t) => t.id.equals(id),
    );
  }
}

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
