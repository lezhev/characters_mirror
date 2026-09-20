import 'package:characters_mirror_client/characters_mirror_client.dart';

String characterSyncTargetKey(String kind, Iterable<String> parts) {
  return '$kind:${parts.map(encodeCharacterSyncTargetPart).join(':')}';
}

String encodeCharacterSyncCompositeId(Iterable<String> parts) {
  return parts.map(encodeCharacterSyncTargetPart).join(':');
}

List<String> decodeCharacterSyncCompositeId(String? value) {
  if (value == null || value.isEmpty) {
    return const <String>[];
  }
  return value.split(':').map(decodeCharacterSyncTargetPart).toList();
}

String encodeCharacterSyncTargetPart(String value) {
  return value.replaceAll('%', '%25').replaceAll(':', '%3A');
}

String decodeCharacterSyncTargetPart(String value) {
  return value.replaceAll('%3A', ':').replaceAll('%25', '%');
}

String characterSyncFieldTargetKey(String field) {
  return characterSyncTargetKey('field', [field]);
}

String characterSyncMapTargetKey(String field, String key) {
  return characterSyncTargetKey('map', [field, key]);
}

String characterSyncItemTargetKey(String collection, String id) {
  return characterSyncTargetKey('item', [collection, id]);
}

String characterSyncMemberTargetKey(String field, String member) {
  return characterSyncTargetKey('member', [field, member]);
}

String characterSyncMemberBaselineTargetKey(String field) {
  return characterSyncTargetKey('memberBaseline', [field]);
}

String characterSyncResourceTargetKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String resourceKey,
) {
  return characterSyncTargetKey('resource', [
    sourceType.name,
    sourceId.toString(),
    resourceKey,
  ]);
}

String characterSyncFeatureOverrideId(CharacterFeatureOverrideData item) {
  return encodeCharacterSyncCompositeId([
    item.sourceType.name,
    item.sourceId.toString(),
  ]);
}

String characterSyncFeatureOverrideFieldTargetKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String field,
) {
  return characterSyncTargetKey('featureOverride', [
    sourceType.name,
    sourceId.toString(),
    field,
  ]);
}

String characterSyncFeatureOverrideTagTargetKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  FeatureTag tag,
) {
  return characterSyncTargetKey('featureOverride', [
    sourceType.name,
    sourceId.toString(),
    'tag',
    tag.name,
  ]);
}

String characterSyncStartingEquipmentSelectionId(
  CharacterStartingEquipmentSelectionData selection,
) {
  return encodeCharacterSyncCompositeId([
    selection.sourceType?.name ?? '',
    selection.sourceId?.toString() ?? '',
    selection.sourceEntryId?.toString() ?? '',
    selection.selectionIndex?.toString() ?? '',
  ]);
}

String characterSyncStartingEquipmentResolutionId(
  CharacterStartingEquipmentSelectionData selection,
  CharacterStartingEquipmentResolutionData resolution,
) {
  return encodeCharacterSyncCompositeId([
    characterSyncStartingEquipmentSelectionId(selection),
    resolution.sourceLineEntryId?.toString() ?? '',
  ]);
}

String characterSyncStartingEquipmentResolutionTargetKey(
  String selectionId,
  String sourceLineEntryId,
) {
  return characterSyncTargetKey('startingEquipmentResolution', [
    selectionId,
    sourceLineEntryId,
  ]);
}
