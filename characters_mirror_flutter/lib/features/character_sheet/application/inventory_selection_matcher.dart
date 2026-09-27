import 'package:characters_mirror_client/characters_mirror_client.dart';

enum InventoryReferenceKind { weapon, armor, tool, item, magicItem }

class InventoryReferenceMatch {
  const InventoryReferenceMatch({
    required this.kind,
    required this.entity,
  });

  final InventoryReferenceKind kind;
  final Object entity;
}

List<InventoryReferenceMatch> findExactInventoryMatches({
  required String? selectedText,
  Iterable<WeaponData> weapons = const [],
  Iterable<ArmorData> armors = const [],
  Iterable<ToolData> tools = const [],
  Iterable<ItemData> items = const [],
  Iterable<MagicItemData> magicItems = const [],
}) {
  final normalizedSelection = _normalize(selectedText);
  if (normalizedSelection == null ||
      (selectedText?.contains('\n') ?? false) ||
      (selectedText?.contains('\r') ?? false)) {
    return const [];
  }

  final matches = <InventoryReferenceMatch>[];
  void addMatches<T>(
    Iterable<T> entities,
    InventoryReferenceKind kind,
    String? Function(T entity) nameOf,
  ) {
    for (final entity in entities) {
      if (_normalize(nameOf(entity)) == normalizedSelection) {
        matches.add(InventoryReferenceMatch(kind: kind, entity: entity as Object));
      }
    }
  }

  addMatches(weapons, InventoryReferenceKind.weapon, (entity) => entity.name);
  addMatches(armors, InventoryReferenceKind.armor, (entity) => entity.name);
  addMatches(tools, InventoryReferenceKind.tool, (entity) => entity.name);
  addMatches(items, InventoryReferenceKind.item, (entity) => entity.name);
  addMatches(
    magicItems,
    InventoryReferenceKind.magicItem,
    (entity) => entity.name,
  );
  return matches;
}

String? _normalize(String? value) {
  final normalized = value?.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase();
  return normalized == null || normalized.isEmpty ? null : normalized;
}
