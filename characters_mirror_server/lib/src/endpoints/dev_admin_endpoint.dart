import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class DevAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Передаём session как параметр
  Future<void> giveAdmin(Session session, int userId) async {
    await Users.updateUserScopes(session, userId, {Scope('admin')});
  }
}
