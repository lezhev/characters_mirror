part of '../import_spell_csv.dart';

Future<_ImportReport> _buildReport(
  Session conn,
  List<_CsvSpell> csvSpells,
) async {
  final dbSpells = await _loadDbSpells(conn);
  final classes = await _loadClasses(conn);
  final subclasses = await _loadSubclasses(conn);
  final existingClassLevels = await _loadClassLevels(conn);

  final csvByName = {for (final spell in csvSpells) spell.name: spell};
  final dbByName = {for (final spell in dbSpells) spell.name: spell};
  final missingInDb = csvByName.keys
      .where((name) => !dbByName.containsKey(name))
      .toList()
    ..sort();
  final extraInDb = dbByName.keys
      .where((name) => !csvByName.containsKey(name))
      .toList()
    ..sort();

  final spellUpdates = <_SpellUpdate>[];
  final desiredClassIdsBySpellId = <int, Set<int>>{};
  final desiredSubclassIdsBySpellId = <int, Set<int>>{};
  final skippedClassTokens = <String, int>{};
  final subclassReport = _SubclassReport();

  for (final csvSpell in csvSpells) {
    final dbSpell = dbByName[csvSpell.name];
    if (dbSpell == null) {
      continue;
    }

    final patch = _SpellPatch.from(csvSpell, dbSpell);
    if (patch.hasChanges) {
      spellUpdates.add(
          _SpellUpdate(dbSpell: dbSpell, csvSpell: csvSpell, patch: patch));
    }

    for (final token in csvSpell.availableTo) {
      final classData = classes.byNormalizedName[_normalize(token)];
      if (classData == null) {
        skippedClassTokens[token] = (skippedClassTokens[token] ?? 0) + 1;
        continue;
      }
      desiredClassIdsBySpellId
          .putIfAbsent(dbSpell.id, () => <int>{})
          .add(classData.id);
    }

    for (final token in csvSpell.availableToSubclasses) {
      final parsed = _ParsedSubclassToken.parse(token);
      if (parsed == null) {
        subclassReport.unparsed[token] =
            (subclassReport.unparsed[token] ?? 0) + 1;
        continue;
      }
      final classData = classes.byNormalizedName[_normalize(parsed.className)];
      if (classData == null) {
        subclassReport.unknownClasses[token] =
            (subclassReport.unknownClasses[token] ?? 0) + 1;
        continue;
      }
      final subclassData = subclasses.find(classData.id, parsed.subclassName);
      if (subclassData != null) {
        subclassReport.matched[token] =
            (subclassReport.matched[token] ?? 0) + 1;
        desiredSubclassIdsBySpellId
            .putIfAbsent(dbSpell.id, () => <int>{})
            .add(subclassData.id);
      } else {
        subclassReport.missing[token] =
            (subclassReport.missing[token] ?? 0) + 1;
      }
    }

    final nextClassIds =
        (desiredClassIdsBySpellId[dbSpell.id]?.toList() ?? <int>[])..sort();
    final nextSubclassIds =
        (desiredSubclassIdsBySpellId[dbSpell.id]?.toList() ?? <int>[])..sort();
    final availabilityPatch = _SpellPatch.availability(
      dbSpell,
      availableForClassIds: nextClassIds,
      availableForSubclassIds: nextSubclassIds,
    );
    if (availabilityPatch.hasChanges) {
      final existingIndex =
          spellUpdates.indexWhere((update) => update.dbSpell.id == dbSpell.id);
      if (existingIndex == -1) {
        spellUpdates.add(
          _SpellUpdate(
            dbSpell: dbSpell,
            csvSpell: csvSpell,
            patch: availabilityPatch,
          ),
        );
      } else {
        spellUpdates[existingIndex] = spellUpdates[existingIndex].merge(
          availabilityPatch,
        );
      }
    }
  }

  final levelSeedPlans = <_ClassLevelSeedPlan>[];
  for (final entry in _levelOneSeeds.entries) {
    final classData = classes.byNormalizedName[_normalize(entry.key)];
    if (classData == null) {
      levelSeedPlans
          .add(_ClassLevelSeedPlan.missingClass(entry.key, entry.value));
      continue;
    }
    final existing = existingClassLevels['${classData.id}:1'];
    levelSeedPlans.add(
      _ClassLevelSeedPlan(
        classData: classData,
        seed: entry.value,
        existing: existing,
      ),
    );
  }

  return _ImportReport(
    csvSpells: csvSpells,
    dbSpells: dbSpells,
    missingInDb: missingInDb,
    extraInDb: extraInDb,
    spellUpdates: spellUpdates,
    desiredClassAvailabilityCount:
        desiredClassIdsBySpellId.values.fold(0, (sum, ids) => sum + ids.length),
    desiredSubclassAvailabilityCount: desiredSubclassIdsBySpellId.values
        .fold(0, (sum, ids) => sum + ids.length),
    skippedClassTokens: skippedClassTokens,
    subclassReport: subclassReport,
    levelSeedPlans: levelSeedPlans,
  );
}

Future<List<_DbSpell>> _loadDbSpells(Session conn) async {
  final rows = await conn.execute(r'''
    SELECT
      id,
      name,
      description,
      source,
      level,
      "castingTime",
      range,
      duration,
      concentration,
      ritual,
      "higherLevel",
      "materialDescription",
      "materialCost",
      "materialConsumed",
      "requiresVerbal",
      "requiresSomatic",
      "requiresMaterial",
      "schoolValue",
      "durationType",
      "availableForClassIds",
      "availableForSubclassIds"
    FROM spell_data
    ORDER BY name
  ''');

  return [
    for (final row in rows)
      _DbSpell(
        id: row[0] as int,
        name: row[1] as String,
        description: row[2] as String?,
        source: row[3] as String?,
        level: row[4] as int?,
        castingTime: row[5] as String?,
        range: row[6] as String?,
        duration: row[7] as String?,
        concentration: row[8] as bool?,
        ritual: row[9] as bool?,
        higherLevel: row[10] as String?,
        materialDescription: row[11] as String?,
        materialCost: row[12] as int?,
        materialConsumed: row[13] as bool?,
        requiresVerbal: row[14] as bool?,
        requiresSomatic: row[15] as bool?,
        requiresMaterial: row[16] as bool?,
        schoolValue: row[17] as String?,
        durationType: row[18] as String?,
        availableForClassIds: _dbIntList(row[19]),
        availableForSubclassIds: _dbIntList(row[20]),
      ),
  ];
}

Future<_ClassCatalog> _loadClasses(Session conn) async {
  final rows =
      await conn.execute('SELECT id, name FROM class_data ORDER BY id');
  final classes = [
    for (final row in rows)
      _ClassData(id: row[0] as int, name: row[1] as String?),
  ];
  return _ClassCatalog(classes);
}

Future<_SubclassCatalog> _loadSubclasses(Session conn) async {
  final rows = await conn.execute(
    'SELECT id, "parentClassId", "subclassName", name FROM subclass_data ORDER BY id',
  );
  final subclasses = [
    for (final row in rows)
      _SubclassData(
        id: row[0] as int,
        parentClassId: row[1] as int,
        subclassName: row[2] as String?,
        name: row[3] as String?,
      ),
  ];
  return _SubclassCatalog(subclasses);
}

Future<Map<String, _ClassLevelRow>> _loadClassLevels(Session conn) async {
  final rows = await conn.execute(r'''
    SELECT id, "classDataId", level, "knownCantrips", "knownSpells", "preparedSpellFormula"
    FROM class_level_data
  ''');
  return {
    for (final row in rows)
      '${row[1]}:${row[2]}': _ClassLevelRow(
        id: row[0] as int,
        classDataId: row[1] as int,
        level: row[2] as int,
        knownCantrips: row[3] as int?,
        knownSpells: row[4] as int?,
        preparedSpellFormula: row[5] as String?,
      ),
  };
}

Future<void> _applySpellUpdates(Session tx, _ImportReport report) async {
  final now = DateTime.now().toUtc();
  for (final update in report.spellUpdates) {
    await tx.execute(
      Sql.named(r'''
        UPDATE spell_data
        SET
          description = @description,
          source = @source,
          level = @level,
          "castingTime" = @castingTime,
          range = @range,
          duration = @duration,
          concentration = @concentration,
          ritual = @ritual,
          "higherLevel" = @higherLevel,
          "materialDescription" = @materialDescription,
          "materialCost" = @materialCost,
          "materialConsumed" = @materialConsumed,
          "requiresVerbal" = @requiresVerbal,
          "requiresSomatic" = @requiresSomatic,
          "requiresMaterial" = @requiresMaterial,
          "schoolValue" = @schoolValue,
          "durationType" = @durationType,
          "availableForClassIds" = CAST(@availableForClassIds AS json),
          "availableForSubclassIds" = CAST(@availableForSubclassIds AS json),
          "updatedAt" = @updatedAt
        WHERE id = @id
      '''),
      parameters: {
        'id': update.dbSpell.id,
        'description': update.csvSpell.description,
        'source': update.csvSpell.source,
        'level': update.csvSpell.level,
        'castingTime': update.csvSpell.castingTime,
        'range': update.csvSpell.range,
        'duration': update.csvSpell.duration,
        'concentration': update.csvSpell.concentration,
        'ritual': update.csvSpell.ritual,
        'higherLevel': update.csvSpell.higherLevel,
        'materialDescription': update.csvSpell.materialDescription,
        'materialCost': update.csvSpell.materialCost,
        'materialConsumed': update.csvSpell.materialConsumed,
        'requiresVerbal': update.csvSpell.requiresVerbal,
        'requiresSomatic': update.csvSpell.requiresSomatic,
        'requiresMaterial': update.csvSpell.requiresMaterial,
        'schoolValue': update.csvSpell.schoolValue,
        'durationType': update.csvSpell.durationType,
        'availableForClassIds': jsonEncode(update.patch.availableForClassIds),
        'availableForSubclassIds':
            jsonEncode(update.patch.availableForSubclassIds),
        'updatedAt': now,
      },
    );
  }
}

Future<void> _upsertLevelOneSeeds(Session tx, _ImportReport report) async {
  final now = DateTime.now().toUtc();
  for (final plan in report.levelSeedPlans) {
    final classData = plan.classData;
    if (classData == null || plan.isUnchanged) {
      continue;
    }

    if (plan.existing == null) {
      await tx.execute(
        Sql.named(r'''
          INSERT INTO class_level_data
            ("classDataId", level, "knownCantrips", "knownSpells", "preparedSpellFormula", "createdAt", "updatedAt")
          VALUES
            (@classDataId, 1, @knownCantrips, @knownSpells, @preparedSpellFormula, @createdAt, @updatedAt)
        '''),
        parameters: {
          'classDataId': classData.id,
          'knownCantrips': plan.seed.knownCantrips,
          'knownSpells': plan.seed.knownSpells,
          'preparedSpellFormula': plan.seed.preparedSpellFormula,
          'createdAt': now,
          'updatedAt': now,
        },
      );
    } else {
      await tx.execute(
        Sql.named(r'''
          UPDATE class_level_data
          SET
            "knownCantrips" = @knownCantrips,
            "knownSpells" = @knownSpells,
            "preparedSpellFormula" = @preparedSpellFormula,
            "updatedAt" = @updatedAt
          WHERE id = @id
        '''),
        parameters: {
          'id': plan.existing!.id,
          'knownCantrips': plan.seed.knownCantrips,
          'knownSpells': plan.seed.knownSpells,
          'preparedSpellFormula': plan.seed.preparedSpellFormula,
          'updatedAt': now,
        },
      );
    }
  }
}
