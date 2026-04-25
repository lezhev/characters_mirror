import 'package:serverpod/serverpod.dart';

class PingEndpoint extends Endpoint {
  Future<bool> ping(Session session) async {
    return true;
  }
}
