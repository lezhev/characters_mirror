import 'package:flutter/foundation.dart';

void logCharacterSyncLifecycle({
  required String stage,
  int? characterId,
  String? noteId,
  String? noteText,
  String? changeId,
  String? operationType,
  int? serverVersion,
  int? localVersion,
  int? baseVersion,
  String? status,
  String? reconciliationSource,
  String? reason,
}) {
  if (!kDebugMode) return;

  final fields = <String>[
    'stage=$stage',
    if (characterId != null) 'characterId=$characterId',
    if (noteId != null) 'noteId=$noteId',
    if (noteText != null) ...[
      'noteHash=${characterSyncTextHash(noteText)}',
      'noteLength=${noteText.length}',
    ],
    if (changeId != null) 'changeId=$changeId',
    if (operationType != null) 'operation=$operationType',
    if (serverVersion != null) 'serverVersion=$serverVersion',
    if (localVersion != null) 'localVersion=$localVersion',
    if (baseVersion != null) 'baseVersion=$baseVersion',
    if (status != null) 'status=$status',
    if (reconciliationSource != null) 'source=$reconciliationSource',
    if (reason != null) 'reason=$reason',
  ];
  debugPrint('[character-sync] ${fields.join(' ')}');
}

String characterSyncTextHash(String value) {
  var hash = 0x811c9dc5;
  for (final codeUnit in value.codeUnits) {
    hash ^= codeUnit;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}
