import 'dart:io';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Spell reference key integrity', (builder, endpoints) {
    for (final (problem, values, message) in [
      ('null', '(NULL)', 'non-null, non-empty'),
      ('empty', "('   ')", 'non-null, non-empty'),
      ('duplicate', "('same'), ('same')", 'unique canonical'),
    ]) {
      test('migration fails before DDL for $problem keys', () async {
        final session = builder.build();
        addTearDown(session.close);
        await session.db.unsafeQuery(
            'CREATE TEMP TABLE spell_data ("referenceKey" text) ON COMMIT DROP');
        await session.db.unsafeQuery('INSERT INTO spell_data VALUES $values');
        final sql = await File(
                'migrations/20261006233630830-spell-reference-key-integrity/migration.sql')
            .readAsString();
        final guard =
            RegExp(r'DO \$\$[\s\S]*?END \$\$;').firstMatch(sql)!.group(0)!;
        await expectLater(
            session.db.unsafeQuery(guard),
            throwsA(isA<DatabaseException>().having((error) => error.toString(),
                'migration guard', contains(message))));
      });
    }

    test('add and upsert reject absent, blank and whitespace-padded keys',
        () async {
      for (final key in [null, '', '   ', ' padded_key ']) {
        final spell = SpellData(referenceKey: key, name: 'Fixture');
        await expectLater(endpoints.spellData.add(builder, spell),
            throwsA(isA<InputValidationException>()));
        await expectLater(endpoints.spellData.upsert(builder, spell),
            throwsA(isA<InputValidationException>()));
      }
    });

    test('database rejects duplicate canonical keys', () async {
      final session = builder.build();
      addTearDown(session.close);
      await SpellData.db.insertRow(
          session, SpellData(referenceKey: 'integrity_fixture', name: 'First'));
      await expectLater(
          SpellData.db.insertRow(session,
              SpellData(referenceKey: 'integrity_fixture', name: 'Second')),
          throwsA(isA<DatabaseException>()));
    });

    test('database rejects null keys', () async {
      final session = builder.build();
      addTearDown(session.close);
      await expectLater(
          session.db.unsafeQuery(
              'INSERT INTO spell_data ("referenceKey") VALUES (NULL)'),
          throwsA(isA<DatabaseException>()));
    });
  });
}
