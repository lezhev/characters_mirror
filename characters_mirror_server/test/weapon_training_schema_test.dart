import 'dart:convert';
import 'dart:io';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  final versions = File('migrations/migration_registry.txt')
      .readAsLinesSync()
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty && !line.startsWith('#'))
      .toList();
  final table = Protocol.targetTableDefinitions
      .singleWhere((table) => table.name == 'class_data');

  for (final filename in ['definition_project.json', 'definition.json']) {
    test('latest $filename preserves weapon training string-list types', () {
      final definition = jsonDecode(
        File('migrations/${versions.last}/$filename').readAsStringSync(),
      ) as Map<String, dynamic>;
      final snapshotTable = (definition['tables'] as List)
          .cast<Map<String, dynamic>>()
          .singleWhere((table) => table['name'] == 'class_data');
      final columns =
          (snapshotTable['columns'] as List).cast<Map<String, dynamic>>();

      for (final name in ['weaponTraining', 'multiclassWeaponTraining']) {
        final column =
            table.columns.singleWhere((column) => column.name == name);
        final snapshot =
            columns.singleWhere((column) => column['name'] == name);
        expect(column.dartType, 'List<String>?');
        expect(snapshot['dartType'], column.dartType);
        expect(snapshot['columnType'], column.columnType.index);
        expect(snapshot['isNullable'], column.isNullable);
      }
    });
  }

  test('weapon training correction updates migration metadata without DDL', () {
    final version = versions.singleWhere(
      (version) => version.endsWith('-weapon-training-metadata'),
    );
    final migration = jsonDecode(
      File('migrations/$version/migration.json').readAsStringSync(),
    ) as Map<String, dynamic>;
    expect(migration['actions'], isEmpty);
    expect(migration['warnings'], isEmpty);

    final sql = File('migrations/$version/migration.sql').readAsStringSync();
    expect(sql.trim(), startsWith('BEGIN;'));
    expect(sql.trim(), endsWith('COMMIT;'));
    expect(sql, contains(version));
    expect(
      RegExp(r'\b(ALTER|DROP|CREATE|TRUNCATE|DELETE)\b', caseSensitive: false)
          .hasMatch(sql),
      isFalse,
    );
    final insertedTables = RegExp(r'INSERT INTO "([^"]+)"')
        .allMatches(sql)
        .map((match) => match.group(1))
        .toList();
    expect(insertedTables, isNotEmpty);
    expect(insertedTables, everyElement('serverpod_migrations'));
  });
}
