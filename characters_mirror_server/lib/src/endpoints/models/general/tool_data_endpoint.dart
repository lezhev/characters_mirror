import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ToolDataEndpoint extends Endpoint {
  Future<List<ToolData>> getAll(Session session) async {
    return ToolData.db.find(session);
  }
}
