import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/dungeon_master/foundry_creature_importer.dart';
import 'dm_bulk_audit/bulk_inventory.dart';

/// Produces temporary presentation test input using the production importer.
/// Does not connect to a database or change source documents.
Future<void> main(List<String> args) async {
  if (args.length != 2) {
    stderr.writeln(
        'Usage: dart run tool/dm_prepare_statblock_audit.dart INPUT.db OUTPUT.json');
    exitCode = 64;
    return;
  }
  final input = await BulkInventory.load(args[0]);
  final output = File(args[1]);
  if (output.absolute.path == File(args[0]).absolute.path) {
    throw ArgumentError('Output must differ from source.');
  }
  final importer = FoundryCreatureImporter();
  Map<String, Object?> prepare(String raw, String origin) {
    final parsed = importer.parse(raw);
    return {
      'origin': origin,
      'name': parsed.name,
      'sourceVersion': parsed.sourceVersion,
      'rawJson': raw,
      'normalizedJson': parsed.normalizedJson
    };
  }

  final records = [
    for (var i = 0; i < input.entries.length; i++) prepare(input.raw(i), 'srd')
  ];
  final fixtures = <Map<String, Object?>>[];
  for (final name in [
    'Goblin',
    'Mage',
    'Adult Red Dragon',
    'Imp',
    'Iron Consul'
  ]) {
    fixtures.add(prepare(
        await File('test/fixtures/foundry/$name.json').readAsString(),
        'fixture'));
  }
  final after = await BulkInventory.load(args[0]);
  if (after.checksum != input.checksum) {
    throw StateError('Source checksum changed.');
  }
  await output.parent.create(recursive: true);
  await output.writeAsString(jsonEncode({
    'sourceChecksum': input.checksum,
    'records': records,
    'fixtures': fixtures
  }));
  stdout.writeln(jsonEncode({
    'output': output.path,
    'srdCreatures': records.length,
    'fixtures': fixtures.length,
    'sourceUnchanged': true
  }));
}
