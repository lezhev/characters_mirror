import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('BackgroundData database loading', (sessionBuilder, _) {
    test('all backgrounds load canonical typed skill proficiencies', () async {
      final querySession = sessionBuilder.build();
      late final List<dynamic> rows;
      try {
        rows = await querySession.db.unsafeQuery(
          'SELECT id, name FROM background_data ORDER BY id',
        );
      } finally {
        await querySession.close();
      }
      expect(rows, hasLength(14));

      final failures = <String>[];
      final backgroundsByName = <String, BackgroundData>{};
      for (final row in rows) {
        final columns = row.toColumnMap();
        final id = columns['id'] as int;
        final name = columns['name'] as String;
        final rowSession = sessionBuilder.build();
        try {
          final background = await BackgroundData.db.findById(rowSession, id);
          if (background == null) {
            failures.add('$name: row disappeared during test');
            continue;
          }
          backgroundsByName[name] = background;
        } catch (error) {
          failures.add('$name: $error');
        } finally {
          await rowSession.close();
        }
      }

      expect(failures, isEmpty, reason: failures.join('\n'));
      expect(
        backgroundsByName['Беспризорник']?.skillProficiencies,
        containsAll([Skill.stealth, Skill.sleightOfHand]),
      );
      expect(
        backgroundsByName['Народный герой']?.skillProficiencies,
        containsAll([Skill.animalHandling, Skill.survival]),
      );
    });
  }, rollbackDatabase: RollbackDatabase.disabled);
}
