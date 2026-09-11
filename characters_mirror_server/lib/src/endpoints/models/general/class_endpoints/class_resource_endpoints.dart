part of '../class_endpoints.dart';

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
