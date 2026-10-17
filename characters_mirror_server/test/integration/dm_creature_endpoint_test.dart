import 'dart:convert';
import 'dart:io';

import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

String _fixture(String name) =>
    File('test/fixtures/foundry/$name.json').readAsStringSync();

void main() {
  withServerpod('DM library and roles', (sessions, endpoints) {
    final gm = sessions.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
            (9901).toString(), {Scope('gm')}));
    final other = sessions.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
            (9902).toString(), {Scope('gm')}));
    final admin = sessions.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
            (9903).toString(), {Scope('admin')}));
    final ordinary = sessions.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
            (9904).toString(), <Scope>{}));

    test('anonymous and ordinary users cannot use any DM method', () async {
      for (final caller in [sessions, ordinary]) {
        await expectLater(endpoints.dmCreature.getCreatures(caller),
            throwsA(isA<Exception>()));
        await expectLater(
            endpoints.dmCreature.importCreature(caller, _fixture('Goblin')),
            throwsA(isA<Exception>()));
        await expectLater(endpoints.dmCreature.getCreature(caller, 1),
            throwsA(isA<Exception>()));
        await expectLater(endpoints.dmCreature.deleteCreature(caller, 1),
            throwsA(isA<Exception>()));
      }
    });

    test('gm and admin have access independently; gm cannot administer users',
        () async {
      expect(await endpoints.dmCreature.getCreatures(gm), isEmpty);
      expect(await endpoints.dmCreature.getCreatures(admin), isEmpty);
      await expectLater(
          endpoints.admin.getAllUsers(gm), throwsA(isA<Exception>()));
      await expectLater(
          endpoints.admin.setGmRole(gm, 9901, true), throwsA(isA<Exception>()));
      await expectLater(endpoints.admin.setAdminRole(gm, 9901, true),
          throwsA(isA<Exception>()));
    });

    test(
        'import persists both documents in PostgreSQL and another session reads them',
        () async {
      final raw = _fixture('Mage');
      final result = await endpoints.dmCreature.importCreature(gm, raw);
      expect(result.duplicate, false);
      final session = gm.build();
      try {
        final row =
            await DmCreatureRecord.db.findById(session, result.creature.id);
        expect(row, isNotNull);
        expect(row!.userId, 9901);
        expect(row.rawJson, raw);
        expect(row.sourceType, 'foundry_dnd5e');
        expect(row.schemaVersion, 1);
        expect(jsonDecode(row.normalizedJson)['items'], isNotEmpty);
      } finally {
        await session.close();
      }
      final fetched =
          await endpoints.dmCreature.getCreature(gm, result.creature.id);
      expect(fetched.rawJson, raw);
      expect((await endpoints.dmCreature.getCreatures(gm)).single.hpMax, 40);
    });

    test('owner filters apply even to admin; foreign reads and deletes fail',
        () async {
      final result =
          await endpoints.dmCreature.importCreature(gm, _fixture('Goblin'));
      for (final caller in [other, admin]) {
        expect(await endpoints.dmCreature.getCreatures(caller), isEmpty);
        await expectLater(
            endpoints.dmCreature.getCreature(caller, result.creature.id),
            throwsA(isA<DmCreatureException>()));
        await expectLater(
            endpoints.dmCreature.deleteCreature(caller, result.creature.id),
            throwsA(isA<DmCreatureException>()));
      }
      expect((await endpoints.dmCreature.getCreatures(gm)).single.id,
          result.creature.id);
    });

    test('invalid import is atomic and returns a serializable error', () async {
      await expectLater(endpoints.dmCreature.importCreature(gm, '{broken'),
          throwsA(isA<DmCreatureException>()));
      expect(await endpoints.dmCreature.getCreatures(gm), isEmpty);
    });

    test(
        'duplicate dragon returns existing id, different owners remain independent',
        () async {
      final first = await endpoints.dmCreature
          .importCreature(gm, _fixture('Adult Red Dragon'));
      final second = await endpoints.dmCreature
          .importCreature(gm, _fixture('Adult Red Dragon (1)'));
      expect(second.duplicate, true);
      expect(second.creature.id, first.creature.id);
      expect(await endpoints.dmCreature.getCreatures(gm), hasLength(1));
      final theirs = await endpoints.dmCreature
          .importCreature(other, _fixture('Adult Red Dragon'));
      expect(theirs.duplicate, false);
      expect(theirs.creature.id, isNot(first.creature.id));
    });

    test('same name with different data is allowed', () async {
      final source = jsonDecode(_fixture('Goblin')) as Map<String, dynamic>;
      final first =
          await endpoints.dmCreature.importCreature(gm, jsonEncode(source));
      source['system']['attributes']['hp']['max'] = 8;
      final second =
          await endpoints.dmCreature.importCreature(gm, jsonEncode(source));
      expect(second.duplicate, false);
      expect(second.creature.id, isNot(first.creature.id));
      expect(await endpoints.dmCreature.getCreatures(gm), hasLength(2));
    });

    test('delete removes database row and subsequent fetch fails', () async {
      final result =
          await endpoints.dmCreature.importCreature(gm, _fixture('Imp'));
      await endpoints.dmCreature.deleteCreature(gm, result.creature.id);
      expect(await endpoints.dmCreature.getCreatures(gm), isEmpty);
      await expectLater(
          endpoints.dmCreature.getCreature(gm, result.creature.id),
          throwsA(isA<DmCreatureException>()));
      final session = gm.build();
      try {
        expect(await DmCreatureRecord.db.findById(session, result.creature.id),
            isNull);
      } finally {
        await session.close();
      }
    });

    test(
        'assigning and revoking each role preserves unrelated scopes and auth keys',
        () async {
      final session = admin.build();
      try {
        final user = await auth.UserInfo.db.insertRow(
            session,
            auth.UserInfo(
              userIdentifier: 'dm-role-test',
              created: DateTime.now().toUtc(),
              scopeNames: ['unrelated', 'gm'],
              blocked: false,
            ));
        await endpoints.admin.setAdminRole(admin, user.id!, true);
        expect(
            (await auth.UserInfo.db.findById(session, user.id!))!
                .scopeNames
                .toSet(),
            {'unrelated', 'gm', 'admin'});
        await endpoints.admin.setAdminRole(admin, user.id!, false);
        expect(
            (await auth.UserInfo.db.findById(session, user.id!))!
                .scopeNames
                .toSet(),
            {'unrelated', 'gm'});
        await endpoints.admin.setGmRole(admin, user.id!, false);
        expect((await auth.UserInfo.db.findById(session, user.id!))!.scopeNames,
            ['unrelated']);
        await endpoints.admin.setGmRole(admin, user.id!, true);
        expect(
            (await auth.UserInfo.db.findById(session, user.id!))!
                .scopeNames
                .toSet(),
            {'unrelated', 'gm'});
      } finally {
        await session.close();
      }
    });
  },
    ephemeralDatabase: false,
  );
}
