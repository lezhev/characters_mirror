import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../dungeon_master/dm_access.dart';
import '../dungeon_master/dm_creature_store.dart';
import '../dungeon_master/foundry_creature_importer.dart';
import '../rate_limiting/character_save_rate_limiter.dart';

class DmCreatureEndpoint extends Endpoint {
  // A separate bucket set: imports never consume character-save capacity.
  final _imports = CharacterSaveRateLimiter(capacity: 30, refillPerMinute: 20);
  @override
  bool get requireLogin => true;

  Future<DmCreatureImportResult> importCreature(
      Session session, String rawJson) async {
    final userId = await DmAccess.requireMaster(session);
    return _guard(session, 'import', () async {
      try {
        _imports.consume(userId: userId, characterId: null);
      } on CharacterSaveRateLimitException {
        throw DmCreatureException(
            code: 'rate_limited',
            message: 'Слишком много попыток импорта. Попробуйте позже.');
      }
      final parsed = FoundryCreatureImporter().parse(rawJson);
      return DmCreatureStore().import(session, userId, rawJson, parsed);
    });
  }

  Future<List<DmCreatureSummary>> getCreatures(Session session) async {
    final userId = await DmAccess.requireMaster(session);
    return _guard(session, 'list', () async {
      final rows = await DmCreatureRecord.db.find(session,
          where: (t) => t.userId.equals(userId),
          orderBy: (t) => t.createdAt,
          orderDescending: true);
      return rows.map(DmCreatureStore().summary).toList();
    });
  }

  Future<DmCreatureRecord> getCreature(Session session, int id) async {
    final userId = await DmAccess.requireMaster(session);
    return _guard(session, 'get', () async {
      final record = await DmCreatureRecord.db.findFirstRow(session,
          where: (t) => t.id.equals(id) & t.userId.equals(userId));
      if (record == null) throw _notFound();
      return record;
    });
  }

  Future<void> deleteCreature(Session session, int id) async {
    final userId = await DmAccess.requireMaster(session);
    return _guard(session, 'delete', () async {
      final deleted = await DmCreatureRecord.db.deleteWhere(session,
          where: (t) => t.id.equals(id) & t.userId.equals(userId));
      if (deleted.isEmpty) throw _notFound();
    });
  }

  DmCreatureException _notFound() => DmCreatureException(
      code: 'not_found', message: 'Существо не найдено в вашей библиотеке.');

  Future<T> _guard<T>(
      Session session, String operation, Future<T> Function() body) async {
    try {
      return await body();
    } on DmCreatureException {
      rethrow;
    } catch (error) {
      // Database exceptions can embed private bind parameters. Never log them.
      session.log('DM $operation failed (${error.runtimeType}).',
          level: LogLevel.error);
      throw DmCreatureException(
          code: 'server_error',
          message:
              'Не удалось выполнить операцию на сервере. Попробуйте снова.');
    }
  }
}
