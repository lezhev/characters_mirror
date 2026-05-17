import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'SpellData database loading',
    (sessionBuilder, _) {
      test('loads every spell row without enum or type deserialization errors',
          () async {
        final session = sessionBuilder.build();
        late final List<dynamic> spellRows;

        try {
          spellRows = await session.db.unsafeQuery(
            'SELECT id, name FROM spell_data ORDER BY id',
          );
        } finally {
          await session.close();
        }
        expect(
          spellRows,
          isNotEmpty,
          reason:
              'spell_data is empty, so type deserialization was not checked.',
        );

        final failures = <String>[];

        for (final row in spellRows) {
          final columns = row.toColumnMap();
          final spellId = columns['id'] as int;
          final spellName = columns['name'] as String?;
          final rowSession = sessionBuilder.build();

          try {
            final spell = await SpellData.db.findById(
              rowSession,
              spellId,
            );

            if (spell == null) {
              failures.add(
                'id=$spellId name=${spellName ?? '<null>'}: row disappeared during test',
              );
              continue;
            }

            spell.toJson();
          } catch (error) {
            failures.add(
              'id=$spellId name=${spellName ?? '<null>'}: $error',
            );
          } finally {
            await rowSession.close();
          }
        }

        expect(
          failures,
          isEmpty,
          reason: [
            'Failed to deserialize one or more spells from the database:',
            ...failures,
          ].join('\n'),
        );
      });
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}
