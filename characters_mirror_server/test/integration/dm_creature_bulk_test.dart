import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/dungeon_master/dm_creature_store.dart';
import 'package:characters_mirror_server/src/dungeon_master/foundry_creature_importer.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:test/test.dart';
import '../../tool/dm_bulk_audit/bulk_inventory.dart';
import '../../tool/dm_bulk_audit/fidelity_checks.dart';
import 'test_tools/serverpod_test_tools.dart';

/// Opt-in external data: no copyrighted pack is checked into the repository.
void main() {
  final input = Platform.environment['CM_DM_BULK_INPUT'];
  if (input == null || input.isEmpty) {
    test('bulk PostgreSQL audit requires CM_DM_BULK_INPUT', () {},
        skip:
            'Set CM_DM_BULK_INPUT to the downloaded JSON Lines/JSON array file.');
    return;
  }
  withServerpod('Isolated creature bulk persistence', (sessions, endpoints) {
    test('all valid Actors persist, round-trip, deduplicate and delete',
        () async {
      final inventory = await BulkInventory.load(input);
      final session = sessions.build();
      final wall = Stopwatch()..start();
      var rejected = 0,
          persisted = 0,
          duplicates = 0,
          fetched = 0,
          deleted = 0,
          itemCount = 0;
      var saveUs = 0, fetchUs = 0, duplicateUs = 0, deleteUs = 0;
      final problems = <String>[];
      try {
        if (session.serverpod.runMode != 'test' ||
            session.serverpod.config.database?.name !=
                'characters_mirror_test') {
          throw StateError(
              'Bulk writes are restricted to the dedicated test database.');
        }
        final dbName =
            await session.db.unsafeQuery('SELECT current_database()');
        expect(dbName.single.single, 'characters_mirror_test');
        final user = await auth.UserInfo.db.insertRow(
            session,
            auth.UserInfo(
              userIdentifier: 'dm-bulk-audit-${const Uuid().v4()}',
              userName: 'Bulk audit fixture',
              created: DateTime.now().toUtc(),
              scopeNames: ['gm'],
              blocked: false,
            ));
        final userId = user.id!;
        expect(
            await DmCreatureRecord.db
                .count(session, where: (t) => t.userId.equals(userId)),
            0,
            reason: 'A fresh fixture owner must have no pre-existing library.');
        final gm = sessions.copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
                userId, {Scope('gm')}));
        final ids = <int>[];
        final importer = FoundryCreatureImporter();
        final store = DmCreatureStore();
        for (var i = 0; i < inventory.entries.length; i++) {
          final raw = inventory.raw(i);
          ParsedFoundryCreature parsed;
          try {
            parsed = importer.parse(raw);
          } on DmCreatureException {
            rejected++;
            continue;
          }
          try {
            final saving = Stopwatch()..start();
            // Invoke the same validated production persistence service, below
            // the endpoint's rate limiter. No limiter/config change in production.
            final result = await store.import(session, userId, raw, parsed);
            saveUs += saving.elapsedMicroseconds;
            expect(result.duplicate, false);
            persisted++;
            ids.add(result.creature.id);
            final reading = Stopwatch()..start();
            final row =
                await endpoints.dmCreature.getCreature(gm, result.creature.id);
            fetchUs += reading.elapsedMicroseconds;
            fetched++;
            expect(row.rawJson, raw,
                reason:
                    'Original line must remain byte-for-byte equal after UTF-8 decoding.');
            expect(row.normalizedJson, parsed.normalizedJson);
            expect(row.userId, userId);
            expect(row.importHash, parsed.importHash);
            expect(row.sourceVersion, parsed.sourceVersion);
            final source = jsonDecode(raw) as Map<String, dynamic>;
            final creature = NormalizedCreature.decode(row.normalizedJson);
            expect(checkFidelity(source, creature), isEmpty);
            itemCount += creature.items.length;
            final protocolRow = DmCreatureRecord.fromJson(row.toJson());
            expect(protocolRow.rawJson, raw);
            expect(protocolRow.normalizedJson, row.normalizedJson);
            final repeat = Stopwatch()..start();
            final reorderedRaw = jsonEncode(source);
            final again = await store.import(
                session, userId, reorderedRaw, importer.parse(reorderedRaw));
            duplicateUs += repeat.elapsedMicroseconds;
            expect(again.duplicate, true);
            expect(again.creature.id, row.id);
            duplicates++;
          } catch (error) {
            // Failure reports retain row index and type only, never raw JSON.
            problems.add('Row $i: ${error.runtimeType}');
          }
        }
        expect(
            await DmCreatureRecord.db
                .count(session, where: (t) => t.userId.equals(userId)),
            persisted);
        final listed = await endpoints.dmCreature.getCreatures(gm);
        expect(listed, hasLength(persisted));
        for (final id in ids) {
          final deletion = Stopwatch()..start();
          await endpoints.dmCreature.deleteCreature(gm, id);
          deleteUs += deletion.elapsedMicroseconds;
          expect(await DmCreatureRecord.db.findById(session, id), null);
          await expectLater(endpoints.dmCreature.getCreature(gm, id),
              throwsA(isA<DmCreatureException>()));
          deleted++;
        }
        expect(await endpoints.dmCreature.getCreatures(gm), isEmpty);
        await auth.UserInfo.db.deleteRow(session, user);
        expect(await auth.UserInfo.db.findById(session, userId), null);
        expect(problems, isEmpty);
        expect(rejected, 0);
        expect(persisted, inventory.entries.length);
        final report = {
          'database': 'characters_mirror_test',
          'records': inventory.entries.length,
          'persisted': persisted,
          'rejected': rejected,
          'fetched': fetched,
          'duplicates': duplicates,
          'deleted': deleted,
          'items': itemCount,
          'ownedRowsAfterDelete': 0,
          'problems': problems,
          'wallMs': wall.elapsedMicroseconds / 1000,
          'saveMs': saveUs / 1000,
          'fetchMs': fetchUs / 1000,
          'duplicateMs': duplicateUs / 1000,
          'deleteMs': deleteUs / 1000,
          'peakRssBytes': ProcessInfo.maxRss,
          'inputUnchanged':
              inventory.checksum == (await BulkInventory.load(input)).checksum
        };
        final output = Platform.environment['CM_DM_BULK_DB_OUTPUT'];
        if (output != null && output.isNotEmpty) {
          await File(output).parent.create(recursive: true);
          await File(output).writeAsString(
              const JsonEncoder.withIndent('  ').convert(report));
        }
        stdout.writeln(jsonEncode(report));
      } finally {
        // withServerpod's outer transaction always rolls back, including on
        // assertion failure or connection loss. Explicit deletes are verified too.
        await session.close();
      }
    }, timeout: const Timeout(Duration(minutes: 10)));
  }, runMode: 'test', rollbackDatabase: RollbackDatabase.afterEach);
}
