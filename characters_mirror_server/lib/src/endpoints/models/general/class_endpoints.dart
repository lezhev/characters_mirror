import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

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
    );
    final subclasses = await SubclassData.db.find(
      session,
      where: (t) => t.parentClassId.equals(classId),
      orderBy: (t) => t.levelRequired,
    );
    final progression = await ClassLevelData.db.find(
      session,
      where: (t) => t.classDataId.equals(classId),
      orderBy: (t) => t.level,
    );
    final groups = await ClassChoiceGroupData.db.find(session);
    final currentFeatureIds = features
        .where((feature) => feature.level <= selectedLevel)
        .map((feature) => feature.id)
        .whereType<int>()
        .toSet();

    final currentGroups = <ClassChoiceGroupView>[];
    for (final group in groups.where((group) {
      final byClass = group.sourceClassId == classId;
      final byFeature = group.sourceFeatureId != null &&
          currentFeatureIds.contains(group.sourceFeatureId);
      final unlocked = (group.level ?? 1) <= selectedLevel;
      return unlocked && (byClass || byFeature);
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
      currentLevelFeatures:
          features.where((feature) => feature.level <= selectedLevel).toList(),
      futureLevelFeatures:
          features.where((feature) => feature.level > selectedLevel).toList(),
      subclassChoice: ClassStepSubclassChoiceView(
        requiredLevel: classData.subclassChoiceLevel,
        subclasses: subclasses,
      ),
      choiceGroups: currentGroups,
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

class ClassFeatureDataEndpoint extends Endpoint {
  Future<List<ClassFeatureData>> getAll(Session session) async {
    return ClassFeatureData.db.find(session);
  }

  Future<ClassFeatureData> add(Session session, ClassFeatureData item) async {
    _stampForInsert(item);
    return ClassFeatureData.db.insertRow(session, item);
  }

  Future<ClassFeatureData> upsert(
    Session session,
    ClassFeatureData feature,
  ) async {
    return _upsertById(
      session,
      feature,
      findExisting: () => ClassFeatureData.db.find(
        session,
        where: (t) => t.id.equals(feature.id),
        limit: 1,
      ),
      insert: () => ClassFeatureData.db.insertRow(session, feature),
      update: () async {
        await ClassFeatureData.db.updateRow(session, feature);
        return feature;
      },
    );
  }

  Future<void> delete(Session session, int id) async {
    await ClassFeatureData.db.deleteWhere(session, where: (t) => t.id.equals(id));
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
    return SubclassFeatureData.db.find(session);
  }

  Future<SubclassFeatureData> add(
    Session session,
    SubclassFeatureData item,
  ) async {
    _stampForInsert(item);
    return SubclassFeatureData.db.insertRow(session, item);
  }

  Future<SubclassFeatureData> upsert(
    Session session,
    SubclassFeatureData subclassFeature,
  ) async {
    return _upsertById(
      session,
      subclassFeature,
      findExisting: () => SubclassFeatureData.db.find(
        session,
        where: (t) => t.id.equals(subclassFeature.id),
        limit: 1,
      ),
      insert: () => SubclassFeatureData.db.insertRow(session, subclassFeature),
      update: () async {
        await SubclassFeatureData.db.updateRow(session, subclassFeature);
        return subclassFeature;
      },
    );
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
