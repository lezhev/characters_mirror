import 'package:characters_mirror_client/characters_mirror_client.dart';

final _validationFailurePattern = RegExp(r'Validation failed for ([^:]+):');

bool isRetryableUntouchedFieldValidationRejection({
  required String? reason,
  required String? message,
  required CharacterSyncOperationType? operationType,
  required String? fieldPath,
}) {
  if (reason != 'invalid_operation' ||
      message == null ||
      fieldPath == null ||
      !_isTargetedMutation(operationType)) {
    return false;
  }

  final failedField = _validationFailurePattern.firstMatch(message)?.group(1);
  if (failedField == null) return false;

  final targetField = fieldPath == 'name' ? 'characterName' : fieldPath;
  return failedField != targetField &&
      !failedField.startsWith('$targetField.') &&
      !failedField.startsWith('$targetField[');
}

bool _isTargetedMutation(CharacterSyncOperationType? type) {
  return switch (type) {
    CharacterSyncOperationType.setField ||
    CharacterSyncOperationType.setMapEntry ||
    CharacterSyncOperationType.removeMapEntry ||
    CharacterSyncOperationType.upsertListItem ||
    CharacterSyncOperationType.removeListItem =>
      true,
    _ => false,
  };
}
