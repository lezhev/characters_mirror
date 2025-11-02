import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {Scope('admin')};

  Future<List<UserInfo>> getAllUsers(Session session) async {
    return await UserInfo.db.find(session);
  }

  Future<void> setAdminRole(Session session, int userId, bool isAdmin) async {
    if (isAdmin) {
      await Users.updateUserScopes(session, userId, {Scope('admin')});
    } else {
      await Users.updateUserScopes(session, userId, <Scope>{});
    }
  }
}
