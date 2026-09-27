import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class ChoiceGroupDataEndpoint extends Endpoint {
  Future<List<ChoiceGroupData>> getAll(Session session) async {
    return ChoiceGroupData.db.find(
      session,
      orderBy: (t) => t.referenceKey,
    );
  }
}

class ChoiceOptionDataEndpoint extends Endpoint {
  Future<List<ChoiceOptionData>> getAll(Session session) async {
    return ChoiceOptionData.db.find(
      session,
      orderBy: (t) => t.sortOrder,
    );
  }
}
