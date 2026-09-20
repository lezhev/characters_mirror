part of '../character_data_endpoint.dart';

String _syncTargetKey(String kind, Iterable<String> parts) {
  return '$kind:${parts.map(_encodeTargetKeyPart).join(':')}';
}

String _encodeCompositeTargetId(Iterable<String> parts) {
  return parts.map(_encodeTargetKeyPart).join(':');
}

List<String> _decodeCompositeTargetId(String? value) {
  if (value == null || value.isEmpty) {
    return const <String>[];
  }
  return value.split(':').map(_decodeTargetKeyPart).toList();
}

String _encodeTargetKeyPart(String value) {
  return value.replaceAll('%', '%25').replaceAll(':', '%3A');
}

String _decodeTargetKeyPart(String value) {
  return value.replaceAll('%3A', ':').replaceAll('%25', '%');
}

String _fieldTargetKey(String field) => _syncTargetKey('field', [field]);

String _mapTargetKey(String field, String key) {
  return _syncTargetKey('map', [field, key]);
}

String _itemTargetKey(String collection, String id) {
  return _syncTargetKey('item', [collection, id]);
}

String _memberTargetKey(String field, String member) {
  return _syncTargetKey('member', [field, member]);
}

String _memberBaselineTargetKey(String field) {
  return _syncTargetKey('memberBaseline', [field]);
}

String _resourceTargetKey(String sourceType, int sourceId, String resourceKey) {
  return _syncTargetKey(
    'resource',
    [sourceType, sourceId.toString(), resourceKey],
  );
}

String _featureOverrideTargetId(CharacterFeatureOverrideData item) {
  return _encodeCompositeTargetId([
    item.sourceType.name,
    item.sourceId.toString(),
  ]);
}

String _featureOverrideFieldTargetKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  String field,
) {
  return _syncTargetKey('featureOverride', [
    sourceType.name,
    sourceId.toString(),
    field,
  ]);
}

String _featureOverrideTagTargetKey(
  CharacterFeatureSourceType sourceType,
  int sourceId,
  FeatureTag tag,
) {
  return _syncTargetKey('featureOverride', [
    sourceType.name,
    sourceId.toString(),
    'tag',
    tag.name,
  ]);
}

String _resourceTargetId(CharacterResourceStateData state) {
  return _encodeCompositeTargetId([
    state.sourceType.name,
    state.sourceId.toString(),
    state.resourceKey,
  ]);
}

String _startingEquipmentSelectionTargetId(
  CharacterStartingEquipmentSelectionData selection,
) {
  return _encodeCompositeTargetId([
    selection.sourceType?.name ?? '',
    selection.sourceId?.toString() ?? '',
    selection.sourceEntryId?.toString() ?? '',
    selection.selectionIndex?.toString() ?? '',
  ]);
}

String _startingEquipmentResolutionTargetKey(
  String selectionId,
  String sourceLineEntryId,
) {
  return _syncTargetKey('startingEquipmentResolution', [
    selectionId,
    sourceLineEntryId,
  ]);
}

String _legacyStartingEquipmentResolutionTargetKey(
  String selectionId,
  String resolutionId,
) {
  return _syncTargetKey('item', [
    'startingEquipmentSelections',
    selectionId,
    'resolution',
    resolutionId,
  ]);
}
