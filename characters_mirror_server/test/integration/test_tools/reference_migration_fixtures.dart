import 'package:serverpod/serverpod.dart';

/// Shadows the current catalog while exercising historical reference migrations.
/// Call only inside a test's rollback transaction, on the session running its SQL.
Future<void> isolateReferenceMigration(
    Session session, List<String> tables) async {
  const allowed = {
    'class_data',
    'class_feature_data',
    'subclass_data',
    'subclass_feature_data',
    'feature_modifier_data',
    'spell_data',
    'class_spell_grant_data',
  };
  for (final table in tables) {
    if (!allowed.contains(table)) {
      throw ArgumentError.value(table, 'tables');
    }
    await session.db.unsafeQuery(
        'CREATE TEMP TABLE "$table" (LIKE public."$table" INCLUDING ALL) '
        'ON COMMIT DROP');
  }
}
