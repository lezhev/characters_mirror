import 'dart:convert';
import 'dart:io';

import 'package:postgres/postgres.dart';

part 'import_spell_csv/csv_loading.dart';
part 'import_spell_csv/database_report.dart';
part 'import_spell_csv/parsing_utils.dart';
part 'import_spell_csv/models.dart';

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
