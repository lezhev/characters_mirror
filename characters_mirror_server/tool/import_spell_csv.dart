import 'dart:convert';
import 'dart:io';

import 'package:postgres/postgres.dart';

const _defaultCsvPath =
    r'D:\spell_parser\spell\dndsu_5e14_spells_v2_sorted.csv';
const _expectedSpellCount = 514;

const _ignoredTokens = {'', '-', '"', 'null'};

const _levelOneSeeds = <String, _ClassLevelSeed>{
  'бард': _ClassLevelSeed(knownCantrips: 2, knownSpells: 4),
  'жрец': _ClassLevelSeed(
    knownCantrips: 3,
    preparedSpellFormula: 'wisdom modifier + cleric level',
  ),
  'друид': _ClassLevelSeed(
    knownCantrips: 2,
    preparedSpellFormula: 'wisdom modifier + druid level',
  ),
  'паладин': _ClassLevelSeed(),
  'следопыт': _ClassLevelSeed(),
  'чародей': _ClassLevelSeed(knownCantrips: 4, knownSpells: 2),
  'колдун': _ClassLevelSeed(knownCantrips: 2, knownSpells: 2),
  'волшебник': _ClassLevelSeed(
    knownCantrips: 3,
    knownSpells: 6,
    preparedSpellFormula: 'intelligence modifier + wizard level',
  ),
};

Future<void> main(List<String> args) async {
  final options = _Options.parse(args);
  final modeLabel = options.apply ? 'APPLY' : 'DRY-RUN';
  stdout.writeln('Spell CSV import mode: $modeLabel');
  stdout.writeln('CSV: ${options.csvPath}');
  stdout.writeln(
    'DB: ${options.username}@${options.host}:${options.port}/${options.database}',
  );

  final csvSpells = await _loadCsvSpells(options.csvPath);
  _validateCsvSpells(csvSpells);

  final conn = await Connection.open(
    Endpoint(
      host: options.host,
      port: options.port,
      database: options.database,
      username: options.username,
      password: options.password,
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );

  try {
    final report = await _buildReport(conn, csvSpells);
    report.writeTo(stdout);
    if (!report.canApply) {
      stderr.writeln('Refusing to apply because validation failed.');
      exitCode = 1;
      return;
    }

    if (!options.apply) {
      stdout.writeln('Dry-run only. Re-run with --apply to write changes.');
      return;
    }

    await conn.runTx((tx) async {
      await _applySpellUpdates(tx, report);
      await _upsertLevelOneSeeds(tx, report);
    });

    stdout.writeln('Applied changes successfully.');
    final afterReport = await _buildReport(conn, csvSpells);
    stdout.writeln('');
    stdout.writeln('Post-apply verification:');
    afterReport.writeVerificationTo(stdout);
  } finally {
    await conn.close();
  }
}

Future<List<_CsvSpell>> _loadCsvSpells(String path) async {
  final file = File(path);
  if (!await file.exists()) {
    throw ArgumentError('CSV file was not found: $path');
  }

  final content = await file.readAsString(encoding: utf8);
  final rows = _parseCsv(content);
  if (rows.isEmpty) {
    throw ArgumentError('CSV file is empty: $path');
  }

  final header = rows.first;
  final indexByName = {
    for (var i = 0; i < header.length; i++) header[i].trim(): i,
  };
  final requiredColumns = {
    'name',
    'description',
    'source',
    'level',
    'castingTime',
    'range',
    'duration',
    'concentration',
    'ritual',
    'higherLevel',
    'availableTo',
    'availableToSubclasses',
    'materialDescription',
    'materialCost',
    'materialConsumed',
    'requiresVerbal',
    'requiresSomatic',
    'requiresMaterial',
    'schoolValue',
    'durationType',
  };
  final missingColumns = [
    for (final column in requiredColumns)
      if (!indexByName.containsKey(column)) column,
  ];
  if (missingColumns.isNotEmpty) {
    throw ArgumentError('CSV is missing columns: ${missingColumns.join(', ')}');
  }

  String value(List<String> row, String column) {
    final index = indexByName[column]!;
    return index < row.length ? row[index] : '';
  }

  final spells = <_CsvSpell>[];
  for (var rowIndex = 1; rowIndex < rows.length; rowIndex++) {
    final row = rows[rowIndex];
    if (row.every((value) => value.trim().isEmpty)) {
      continue;
    }

    spells.add(
      _CsvSpell(
        rowNumber: rowIndex + 1,
        name: _requiredText(value(row, 'name'), rowIndex, 'name'),
        description: _nullableText(value(row, 'description')),
        source: _nullableText(value(row, 'source')),
        level: _requiredInt(value(row, 'level'), rowIndex, 'level'),
        castingTime: _nullableText(value(row, 'castingTime')),
        range: _nullableText(value(row, 'range')),
        duration: _nullableText(value(row, 'duration')),
        concentration: _nullableBool(value(row, 'concentration')),
        ritual: _nullableBool(value(row, 'ritual')),
        higherLevel: _nullableText(value(row, 'higherLevel')),
        availableTo: _splitList(value(row, 'availableTo')),
        availableToSubclasses: _splitList(value(row, 'availableToSubclasses')),
        materialDescription: _nullableText(value(row, 'materialDescription')),
        materialCost: _nullableMaterialCost(value(row, 'materialCost')),
        materialConsumed: _nullableBool(value(row, 'materialConsumed')),
        requiresVerbal: _nullableBool(value(row, 'requiresVerbal')),
        requiresSomatic: _nullableBool(value(row, 'requiresSomatic')),
        requiresMaterial: _nullableBool(value(row, 'requiresMaterial')),
        schoolValue: _nullableText(value(row, 'schoolValue')),
        durationType: _nullableText(value(row, 'durationType')),
      ),
    );
  }

  return spells;
}

void _validateCsvSpells(List<_CsvSpell> spells) {
  final duplicateNames = _duplicates(spells.map((spell) => spell.name));
  if (duplicateNames.isNotEmpty) {
    throw StateError(
        'CSV contains duplicate spell names: ${duplicateNames.join(', ')}');
  }
  if (spells.length != _expectedSpellCount) {
    throw StateError(
      'CSV contains ${spells.length} spells, expected $_expectedSpellCount.',
    );
  }
}

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

List<List<String>> _parseCsv(String input) {
  final rows = <List<String>>[];
  var row = <String>[];
  final field = StringBuffer();
  var inQuotes = false;

  void endField() {
    row.add(field.toString());
    field.clear();
  }

  void endRow() {
    endField();
    rows.add(row);
    row = <String>[];
  }

  for (var i = 0; i < input.length; i++) {
    final ch = input[i];
    if (ch == '"') {
      if (inQuotes && i + 1 < input.length && input[i + 1] == '"') {
        field.write('"');
        i++;
      } else {
        inQuotes = !inQuotes;
      }
      continue;
    }

    if (ch == ',' && !inQuotes) {
      endField();
      continue;
    }

    if ((ch == '\n' || ch == '\r') && !inQuotes) {
      if (ch == '\r' && i + 1 < input.length && input[i + 1] == '\n') {
        i++;
      }
      endRow();
      continue;
    }

    field.write(ch);
  }

  if (inQuotes) {
    throw const FormatException('CSV ended inside a quoted field.');
  }
  if (field.isNotEmpty || row.isNotEmpty) {
    endRow();
  }
  return rows;
}

String _requiredText(String value, int rowIndex, String column) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    throw FormatException(
        'CSV row ${rowIndex + 1} has empty required $column.');
  }
  return normalized;
}

int _requiredInt(String value, int rowIndex, String column) {
  final parsed = _nullableInt(value);
  if (parsed == null) {
    throw FormatException(
        'CSV row ${rowIndex + 1} has empty required $column.');
  }
  return parsed;
}

String? _nullableText(String? value) {
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty || trimmed.toLowerCase() == 'null') {
    return null;
  }
  return trimmed;
}

int? _nullableInt(String? value) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    return null;
  }
  return int.parse(normalized);
}

int? _nullableMaterialCost(String? value) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    return null;
  }
  final digits = normalized.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) {
    return null;
  }
  return int.parse(digits);
}

bool? _nullableBool(String? value) {
  final normalized = _nullableText(value)?.toLowerCase();
  if (normalized == null) {
    return null;
  }
  if (normalized == 'true') {
    return true;
  }
  if (normalized == 'false') {
    return false;
  }
  throw FormatException('Expected boolean, got "$value".');
}

List<int> _dbIntList(Object? value) {
  if (value == null) {
    return const [];
  }

  final Object? decoded = value is String ? jsonDecode(value) : value;
  if (decoded is! List) {
    return const [];
  }

  final result = <int>[];
  for (final item in decoded) {
    if (item is int) {
      result.add(item);
    } else if (item is num) {
      result.add(item.toInt());
    } else if (item is String) {
      final parsed = int.tryParse(item);
      if (parsed != null) {
        result.add(parsed);
      }
    }
  }
  return result..sort();
}

bool _sameIntList(List<int> first, List<int> second) {
  if (first.length != second.length) {
    return false;
  }
  final sortedFirst = [...first]..sort();
  final sortedSecond = [...second]..sort();
  for (var i = 0; i < sortedFirst.length; i++) {
    if (sortedFirst[i] != sortedSecond[i]) {
      return false;
    }
  }
  return true;
}

List<String> _splitList(String? value) {
  final normalized = _nullableText(value);
  if (normalized == null) {
    return const [];
  }
  final listText = normalized.replaceAll(r'\r', ',').replaceAll(r'\n', ',');
  final result = <String>[];
  final seen = <String>{};
  for (final part in listText.split(RegExp(r'[,\r\n]+'))) {
    final trimmed = part.trim().replaceAll('"', '');
    final key = _normalize(trimmed);
    if (_ignoredTokens.contains(key) || !seen.add(key)) {
      continue;
    }
    result.add(trimmed);
  }
  return result;
}

List<String> _duplicates(Iterable<String> values) {
  final seen = <String>{};
  final duplicates = <String>{};
  for (final value in values) {
    if (!seen.add(value)) {
      duplicates.add(value);
    }
  }
  return duplicates.toList()..sort();
}

String _normalize(String value) {
  return value
      .trim()
      .toLowerCase()
      .replaceAll('ё', 'е')
      .replaceAll(RegExp(r'\s+'), ' ');
}

String _quoteList(Iterable<String> values, {int max = 20}) {
  final list = values.toList()..sort();
  if (list.isEmpty) {
    return '-';
  }
  final visible = list.take(max).join(', ');
  final hidden = list.length - max;
  return hidden > 0 ? '$visible, ... (+$hidden)' : visible;
}

class _Options {
  const _Options({
    required this.apply,
    required this.csvPath,
    required this.host,
    required this.port,
    required this.database,
    required this.username,
    required this.password,
  });

  final bool apply;
  final String csvPath;
  final String host;
  final int port;
  final String database;
  final String username;
  final String password;

  static _Options parse(List<String> args) {
    var apply = false;
    var csvPath = _defaultCsvPath;
    var host = 'localhost';
    var port = 5432;
    var database = 'characters_mirror';
    var username = 'postgres';
    var password = '';

    for (var i = 0; i < args.length; i++) {
      final arg = args[i];
      String nextValue(String name) {
        if (i + 1 >= args.length) {
          throw ArgumentError('Missing value for $name.');
        }
        return args[++i];
      }

      if (arg == '--apply') {
        apply = true;
      } else if (arg == '--dry-run') {
        apply = false;
      } else if (arg == '--csv') {
        csvPath = nextValue(arg);
      } else if (arg == '--host') {
        host = nextValue(arg);
      } else if (arg == '--port') {
        port = int.parse(nextValue(arg));
      } else if (arg == '--database') {
        database = nextValue(arg);
      } else if (arg == '--user') {
        username = nextValue(arg);
      } else if (arg == '--password') {
        password = nextValue(arg);
      } else if (arg == '--help' || arg == '-h') {
        _printUsage();
        exit(0);
      } else {
        throw ArgumentError('Unknown argument: $arg');
      }
    }

    return _Options(
      apply: apply,
      csvPath: csvPath,
      host: host,
      port: port,
      database: database,
      username: username,
      password: password,
    );
  }

  static void _printUsage() {
    stdout.writeln('''
Usage:
  dart run tool/import_spell_csv.dart [--apply] [options]

Options:
  --dry-run              Validate and print changes without writing. Default.
  --apply                Write changes in one transaction.
  --csv <path>           CSV path. Default: $_defaultCsvPath
  --host <host>          PostgreSQL host. Default: localhost
  --port <port>          PostgreSQL port. Default: 5432
  --database <name>      Database name. Default: characters_mirror
  --user <name>          Database user. Default: postgres
  --password <password>  Database password. Default: empty
''');
  }
}

class _CsvSpell {
  const _CsvSpell({
    required this.rowNumber,
    required this.name,
    required this.description,
    required this.source,
    required this.level,
    required this.castingTime,
    required this.range,
    required this.duration,
    required this.concentration,
    required this.ritual,
    required this.higherLevel,
    required this.availableTo,
    required this.availableToSubclasses,
    required this.materialDescription,
    required this.materialCost,
    required this.materialConsumed,
    required this.requiresVerbal,
    required this.requiresSomatic,
    required this.requiresMaterial,
    required this.schoolValue,
    required this.durationType,
  });

  final int rowNumber;
  final String name;
  final String? description;
  final String? source;
  final int level;
  final String? castingTime;
  final String? range;
  final String? duration;
  final bool? concentration;
  final bool? ritual;
  final String? higherLevel;
  final List<String> availableTo;
  final List<String> availableToSubclasses;
  final String? materialDescription;
  final int? materialCost;
  final bool? materialConsumed;
  final bool? requiresVerbal;
  final bool? requiresSomatic;
  final bool? requiresMaterial;
  final String? schoolValue;
  final String? durationType;
}

class _DbSpell {
  const _DbSpell({
    required this.id,
    required this.name,
    required this.description,
    required this.source,
    required this.level,
    required this.castingTime,
    required this.range,
    required this.duration,
    required this.concentration,
    required this.ritual,
    required this.higherLevel,
    required this.materialDescription,
    required this.materialCost,
    required this.materialConsumed,
    required this.requiresVerbal,
    required this.requiresSomatic,
    required this.requiresMaterial,
    required this.schoolValue,
    required this.durationType,
    required this.availableForClassIds,
    required this.availableForSubclassIds,
  });

  final int id;
  final String name;
  final String? description;
  final String? source;
  final int? level;
  final String? castingTime;
  final String? range;
  final String? duration;
  final bool? concentration;
  final bool? ritual;
  final String? higherLevel;
  final String? materialDescription;
  final int? materialCost;
  final bool? materialConsumed;
  final bool? requiresVerbal;
  final bool? requiresSomatic;
  final bool? requiresMaterial;
  final String? schoolValue;
  final String? durationType;
  final List<int> availableForClassIds;
  final List<int> availableForSubclassIds;
}

class _SpellPatch {
  const _SpellPatch(
    this.changes, {
    required this.availableForClassIds,
    required this.availableForSubclassIds,
  });

  factory _SpellPatch.from(_CsvSpell csv, _DbSpell db) {
    final changes = <String, (Object?, Object?)>{};
    void compare(String field, Object? oldValue, Object? newValue) {
      if (oldValue != newValue) {
        changes[field] = (oldValue, newValue);
      }
    }

    compare('description', db.description, csv.description);
    compare('source', db.source, csv.source);
    compare('level', db.level, csv.level);
    compare('castingTime', db.castingTime, csv.castingTime);
    compare('range', db.range, csv.range);
    compare('duration', db.duration, csv.duration);
    compare('concentration', db.concentration, csv.concentration);
    compare('ritual', db.ritual, csv.ritual);
    compare('higherLevel', db.higherLevel, csv.higherLevel);
    compare(
        'materialDescription', db.materialDescription, csv.materialDescription);
    compare('materialCost', db.materialCost, csv.materialCost);
    compare('materialConsumed', db.materialConsumed, csv.materialConsumed);
    compare('requiresVerbal', db.requiresVerbal, csv.requiresVerbal);
    compare('requiresSomatic', db.requiresSomatic, csv.requiresSomatic);
    compare('requiresMaterial', db.requiresMaterial, csv.requiresMaterial);
    compare('schoolValue', db.schoolValue, csv.schoolValue);
    compare('durationType', db.durationType, csv.durationType);
    return _SpellPatch(
      changes,
      availableForClassIds: db.availableForClassIds,
      availableForSubclassIds: db.availableForSubclassIds,
    );
  }

  factory _SpellPatch.availability(
    _DbSpell db, {
    required List<int> availableForClassIds,
    required List<int> availableForSubclassIds,
  }) {
    final changes = <String, (Object?, Object?)>{};
    if (!_sameIntList(db.availableForClassIds, availableForClassIds)) {
      changes['availableForClassIds'] = (
        db.availableForClassIds,
        availableForClassIds,
      );
    }
    if (!_sameIntList(db.availableForSubclassIds, availableForSubclassIds)) {
      changes['availableForSubclassIds'] = (
        db.availableForSubclassIds,
        availableForSubclassIds,
      );
    }
    return _SpellPatch(
      changes,
      availableForClassIds: availableForClassIds,
      availableForSubclassIds: availableForSubclassIds,
    );
  }

  final Map<String, (Object?, Object?)> changes;
  final List<int> availableForClassIds;
  final List<int> availableForSubclassIds;

  bool get hasChanges => changes.isNotEmpty;

  _SpellPatch merge(_SpellPatch other) {
    return _SpellPatch(
      {...changes, ...other.changes},
      availableForClassIds: other.availableForClassIds,
      availableForSubclassIds: other.availableForSubclassIds,
    );
  }
}

class _SpellUpdate {
  const _SpellUpdate({
    required this.dbSpell,
    required this.csvSpell,
    required this.patch,
  });

  final _DbSpell dbSpell;
  final _CsvSpell csvSpell;
  final _SpellPatch patch;

  _SpellUpdate merge(_SpellPatch patch) {
    return _SpellUpdate(
      dbSpell: dbSpell,
      csvSpell: csvSpell,
      patch: this.patch.merge(patch),
    );
  }
}

class _ClassData {
  const _ClassData({required this.id, required this.name});

  final int id;
  final String? name;
}

class _ClassCatalog {
  _ClassCatalog(List<_ClassData> classes)
      : byNormalizedName = {
          for (final item in classes)
            if (item.name != null) _normalize(item.name!): item,
        };

  final Map<String, _ClassData> byNormalizedName;
}

class _SubclassData {
  const _SubclassData({
    required this.id,
    required this.parentClassId,
    required this.subclassName,
    required this.name,
  });

  final int id;
  final int parentClassId;
  final String? subclassName;
  final String? name;
}

class _SubclassCatalog {
  _SubclassCatalog(List<_SubclassData> subclasses) {
    for (final subclass in subclasses) {
      final keys = <String>{};
      final name = subclass.name;
      final prefix = subclass.subclassName;
      if (name != null) {
        keys.add(_normalize(name));
      }
      if (name != null && prefix != null) {
        keys.add(_normalize('$prefix $name'));
      }
      final byClass = _byClassId.putIfAbsent(
        subclass.parentClassId,
        () => <String, _SubclassData>{},
      );
      for (final key in keys) {
        byClass[key] = subclass;
      }
    }
  }

  final Map<int, Map<String, _SubclassData>> _byClassId = {};

  _SubclassData? find(int classDataId, String subclassName) {
    return _byClassId[classDataId]?[_normalize(subclassName)];
  }
}

class _ParsedSubclassToken {
  const _ParsedSubclassToken({
    required this.subclassName,
    required this.className,
  });

  final String subclassName;
  final String className;

  static _ParsedSubclassToken? parse(String token) {
    final match = RegExp(r'^(.*)\(([^()]*)\)$').firstMatch(token.trim());
    if (match == null) {
      return null;
    }
    final subclassName = match.group(1)?.trim();
    final className = match.group(2)?.trim();
    if (subclassName == null ||
        subclassName.isEmpty ||
        className == null ||
        className.isEmpty) {
      return null;
    }
    return _ParsedSubclassToken(
      subclassName: subclassName,
      className: className,
    );
  }
}

class _ClassLevelSeed {
  const _ClassLevelSeed({
    this.knownCantrips,
    this.knownSpells,
    this.preparedSpellFormula,
  });

  final int? knownCantrips;
  final int? knownSpells;
  final String? preparedSpellFormula;
}

class _ClassLevelRow {
  const _ClassLevelRow({
    required this.id,
    required this.classDataId,
    required this.level,
    required this.knownCantrips,
    required this.knownSpells,
    required this.preparedSpellFormula,
  });

  final int id;
  final int classDataId;
  final int level;
  final int? knownCantrips;
  final int? knownSpells;
  final String? preparedSpellFormula;
}

class _ClassLevelSeedPlan {
  const _ClassLevelSeedPlan({
    required this.classData,
    required this.seed,
    required this.existing,
    this.missingClassName,
  });

  const _ClassLevelSeedPlan.missingClass(String className, _ClassLevelSeed seed)
      : this(
          classData: null,
          seed: seed,
          existing: null,
          missingClassName: className,
        );

  final _ClassData? classData;
  final _ClassLevelSeed seed;
  final _ClassLevelRow? existing;
  final String? missingClassName;

  bool get isInsert => classData != null && existing == null;

  bool get isUpdate {
    final current = existing;
    return classData != null &&
        current != null &&
        (current.knownCantrips != seed.knownCantrips ||
            current.knownSpells != seed.knownSpells ||
            current.preparedSpellFormula != seed.preparedSpellFormula);
  }

  bool get isUnchanged => classData != null && existing != null && !isUpdate;
}

class _SubclassReport {
  final matched = <String, int>{};
  final missing = <String, int>{};
  final unknownClasses = <String, int>{};
  final unparsed = <String, int>{};
}

class _ImportReport {
  const _ImportReport({
    required this.csvSpells,
    required this.dbSpells,
    required this.missingInDb,
    required this.extraInDb,
    required this.spellUpdates,
    required this.desiredClassAvailabilityCount,
    required this.desiredSubclassAvailabilityCount,
    required this.skippedClassTokens,
    required this.subclassReport,
    required this.levelSeedPlans,
  });

  final List<_CsvSpell> csvSpells;
  final List<_DbSpell> dbSpells;
  final List<String> missingInDb;
  final List<String> extraInDb;
  final List<_SpellUpdate> spellUpdates;
  final int desiredClassAvailabilityCount;
  final int desiredSubclassAvailabilityCount;
  final Map<String, int> skippedClassTokens;
  final _SubclassReport subclassReport;
  final List<_ClassLevelSeedPlan> levelSeedPlans;

  bool get canApply =>
      csvSpells.length == _expectedSpellCount &&
      dbSpells.length == _expectedSpellCount &&
      missingInDb.isEmpty &&
      extraInDb.isEmpty;

  void writeTo(IOSink out) {
    out.writeln('');
    out.writeln('Validation:');
    out.writeln('  CSV spells: ${csvSpells.length}');
    out.writeln('  DB spells: ${dbSpells.length}');
    out.writeln('  Missing in DB: ${missingInDb.length}');
    if (missingInDb.isNotEmpty) {
      out.writeln('    ${_quoteList(missingInDb)}');
    }
    out.writeln('  Extra in DB: ${extraInDb.length}');
    if (extraInDb.isNotEmpty) {
      out.writeln('    ${_quoteList(extraInDb)}');
    }

    final levelUpdates = spellUpdates
        .where((update) => update.patch.changes.containsKey('level'))
        .toList();
    out.writeln('');
    out.writeln('SpellData updates: ${spellUpdates.length}');
    out.writeln('  Level mismatches: ${levelUpdates.length}');
    for (final update in levelUpdates.take(25)) {
      final change = update.patch.changes['level']!;
      out.writeln('    ${update.dbSpell.name}: ${change.$1} -> ${change.$2}');
    }

    out.writeln('');
    out.writeln('Spell availability lists:');
    out.writeln('  Desired class links: $desiredClassAvailabilityCount');
    out.writeln('  Desired subclass links: $desiredSubclassAvailabilityCount');
    out.writeln('  Skipped class tokens: ${skippedClassTokens.length}');
    if (skippedClassTokens.isNotEmpty) {
      for (final entry in _sortedCountEntries(skippedClassTokens).take(20)) {
        out.writeln('    ${entry.key}: ${entry.value}');
      }
    }

    out.writeln('');
    out.writeln('Subclass availability report:');
    out.writeln(
        '  Matched existing subclasses: ${subclassReport.matched.length}');
    out.writeln('  Missing subclasses: ${subclassReport.missing.length}');
    for (final entry in _sortedCountEntries(subclassReport.missing).take(30)) {
      out.writeln('    missing ${entry.key}: ${entry.value}');
    }
    out.writeln(
        '  Unknown subclass parent classes: ${subclassReport.unknownClasses.length}');
    for (final entry
        in _sortedCountEntries(subclassReport.unknownClasses).take(20)) {
      out.writeln('    unknown class ${entry.key}: ${entry.value}');
    }
    out.writeln(
        '  Unparsed subclass tokens: ${subclassReport.unparsed.length}');
    for (final entry in _sortedCountEntries(subclassReport.unparsed).take(20)) {
      out.writeln('    unparsed ${entry.key}: ${entry.value}');
    }

    final inserts = levelSeedPlans.where((plan) => plan.isInsert).length;
    final updates = levelSeedPlans.where((plan) => plan.isUpdate).length;
    final unchanged = levelSeedPlans.where((plan) => plan.isUnchanged).length;
    final missingClasses =
        levelSeedPlans.where((plan) => plan.classData == null).length;
    out.writeln('');
    out.writeln('Level-1 class progression seeds:');
    out.writeln('  Inserts: $inserts');
    out.writeln('  Updates: $updates');
    out.writeln('  Unchanged: $unchanged');
    out.writeln('  Missing classes: $missingClasses');
    for (final plan in levelSeedPlans) {
      final name = plan.classData?.name ?? plan.missingClassName ?? '<unknown>';
      final action = plan.classData == null
          ? 'missing class'
          : plan.isInsert
              ? 'insert'
              : plan.isUpdate
                  ? 'update'
                  : 'unchanged';
      out.writeln('    $name: $action');
    }
  }

  void writeVerificationTo(IOSink out) {
    out.writeln('  SpellData updates remaining: ${spellUpdates.length}');
    out.writeln('  Desired class links: $desiredClassAvailabilityCount');
    out.writeln('  Desired subclass links: $desiredSubclassAvailabilityCount');
    out.writeln(
      '  Level-1 seed changes remaining: '
      '${levelSeedPlans.where((plan) => plan.isInsert || plan.isUpdate).length}',
    );
  }

  static List<MapEntry<String, int>> _sortedCountEntries(Map<String, int> map) {
    return map.entries.toList()
      ..sort((a, b) {
        final countCompare = b.value.compareTo(a.value);
        if (countCompare != 0) return countCompare;
        return a.key.compareTo(b.key);
      });
  }
}
