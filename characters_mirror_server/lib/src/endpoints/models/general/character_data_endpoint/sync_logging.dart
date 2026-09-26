part of '../character_data_endpoint.dart';

void _logCharacterSyncSummary(
  Session session,
  CharacterSyncRequest request,
  CharacterSyncResponse response,
) {
  final operationCount = request.operations?.length ?? 0;
  final legacyChangeCount = request.changes?.length ?? 0;
  final acknowledgedCount = response.acknowledgedChangeIds?.length ?? 0;
  final rejectedCount = response.rejectedChanges?.length ?? 0;
  final snapshotCount = (response.characters?.length ?? 0) +
      (response.changedCharacters?.length ?? 0);
  final deletedCount = response.deletedCharacterIds?.length ?? 0;

  if (operationCount == 0 &&
      legacyChangeCount == 0 &&
      acknowledgedCount == 0 &&
      rejectedCount == 0 &&
      snapshotCount == 0 &&
      deletedCount == 0) {
    return;
  }

  session.log(
    '[character-sync] operations=$operationCount '
    'legacyChanges=$legacyChangeCount acknowledged=$acknowledgedCount '
    'rejected=$rejectedCount snapshots=$snapshotCount deleted=$deletedCount',
  );
}
