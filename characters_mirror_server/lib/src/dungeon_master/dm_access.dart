import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

abstract final class DmAccess {
  static const gm = Scope('gm');
  static const admin = Scope('admin');

  static Future<int> requireMaster(Session session) async {
    final auth = await session.authenticated;
    if (auth == null ||
        !(auth.scopes.contains(gm) || auth.scopes.contains(admin))) {
      throw DmCreatureException(
          code: 'forbidden',
          message: 'Для инструментов Мастера нужны права gm или admin.');
    }
    return auth.userId;
  }

  static Future<int> requireAdmin(Session session) async {
    final auth = await session.authenticated;
    if (auth == null || !auth.scopes.contains(admin)) {
      throw DmCreatureException(
          code: 'forbidden', message: 'Требуются права администратора.');
    }
    return auth.userId;
  }
}
