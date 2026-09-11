part of '../import_spell_csv.dart';

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
