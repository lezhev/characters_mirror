import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class FeatureRelationDataEndpoint extends Endpoint {
  Future<List<FeatureRelationData>> getAll(Session session) =>
      FeatureRelationData.db.find(session, orderBy: (t) => t.priority);
}
