import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'foundry_creature_importer.dart';

class DmCreatureStore {
  Future<DmCreatureImportResult> import(Session session, int userId, String raw,
      ParsedFoundryCreature parsed) async {
    return _transaction(session, (transaction) async {
      // Serialize identical concurrent imports across server processes. The
      // unique index remains the final authority; names are not identities.
      await session.db.unsafeQuery(
        'SELECT pg_advisory_xact_lock(hashtext(@key)::bigint)',
        parameters: QueryParameters.named(
            {'key': 'dm-import:$userId:${parsed.importHash}'}),
        transaction: transaction,
      );
      final existing = await DmCreatureRecord.db.findFirstRow(session,
          where: (t) =>
              t.userId.equals(userId) & t.importHash.equals(parsed.importHash),
          transaction: transaction);
      if (existing != null) {
        return DmCreatureImportResult(
            creature: summary(existing), duplicate: true);
      }
      final now = DateTime.now().toUtc();
      final record = await DmCreatureRecord.db.insertRow(
          session,
          DmCreatureRecord(
            userId: userId,
            name: parsed.name,
            sourceType: 'foundry_dnd5e',
            sourceVersion: parsed.sourceVersion,
            challengeRating: parsed.challengeRating,
            rawJson: raw,
            normalizedJson: parsed.normalizedJson,
            importHash: parsed.importHash,
            schemaVersion: 1,
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction);
      return DmCreatureImportResult(
          creature: summary(record), duplicate: false);
    });
  }

  DmCreatureSummary summary(DmCreatureRecord record) => DmCreatureSummary(
        id: record.id!,
        name: record.name,
        challengeRating: record.challengeRating,
        hpMax: NormalizedCreature.decode(record.normalizedJson).hpMax,
        createdAt: record.createdAt,
      );

  Future<T> _transaction<T>(
      Session session, Future<T> Function(Transaction) body) async {
    // Serverpod test sessions already own the rollback transaction.
    // ignore: invalid_use_of_visible_for_testing_member
    final existing = session.transaction;
    if (existing == null) return session.db.transaction(body);
    final savepoint = await existing.createSavepoint();
    try {
      final result = await body(existing);
      await savepoint.release();
      return result;
    } catch (_) {
      await savepoint.rollback();
      rethrow;
    }
  }
}
