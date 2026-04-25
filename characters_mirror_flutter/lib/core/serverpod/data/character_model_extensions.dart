import 'package:characters_mirror_client/characters_mirror_client.dart';

extension CharacterEquipmentTextX on CharacterData {
  String? get equipmentText {
    final items = equipment ?? const <CharacterInventoryItemData>[];
    if (items.isEmpty) {
      return null;
    }
    final parts = <String>[];
    for (final item in items) {
      final name = item.name?.trim();
      if (name == null || name.isEmpty) {
        continue;
      }
      final quantity = item.quantity ?? 1;
      parts.add(quantity > 1 ? '$name x$quantity' : name);
    }
    return parts.isEmpty ? null : parts.join(', ');
  }

  List<String> get noteTexts => [
        for (final note in notes ?? const <CharacterNoteData>[])
          if ((note.text ?? '').trim().isNotEmpty) note.text!.trim(),
      ];
}

List<CharacterInventoryItemData>? inventoryItemsFromText(
  String? value, {
  List<CharacterInventoryItemData>? previous,
}) {
  // TODO(op-sync): replace this text bridge with a structured inventory editor
  // so item-level add/remove/update operations can be queued separately.
  final trimmed = value?.trim();
  if (trimmed == null || trimmed.isEmpty) {
    return null;
  }

  final previousItem = previous?.firstOrNull;
  return [
    CharacterInventoryItemData(
      id: previousItem?.id,
      name: trimmed,
      quantity: previousItem?.quantity ?? 1,
      type: previousItem?.type ?? CharacterInventoryItemType.custom,
      updatedAt: previousItem?.updatedAt,
    ),
  ];
}

List<CharacterNoteData>? notesFromTexts(
  Iterable<String> values, {
  List<CharacterNoteData>? previous,
}) {
  // TODO(op-sync): switch note persistence from whole-list snapshots to
  // per-note operations once the sync endpoint supports them.
  final previousByIndex = {
    for (var index = 0; index < (previous?.length ?? 0); index++) index: previous![index],
  };
  final normalized = <CharacterNoteData>[];
  var index = 0;
  for (final rawValue in values) {
    final text = rawValue.trim();
    if (text.isEmpty) {
      index++;
      continue;
    }
    final previousNote = previousByIndex[index];
    normalized.add(
      CharacterNoteData(
        id: previousNote?.id,
        text: text,
        updatedAt: previousNote?.updatedAt,
      ),
    );
    index++;
  }
  return normalized.isEmpty ? null : normalized;
}
