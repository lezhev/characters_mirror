import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/inventory_selection_matcher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty and multiline selections have no matches', () {
    final catalogs = _catalogs();

    expect(
      findExactInventoryMatches(
        selectedText: '  ',
        weapons: catalogs.weapons,
        armors: catalogs.armors,
        tools: catalogs.tools,
        items: catalogs.items,
        magicItems: catalogs.magicItems,
      ),
      isEmpty,
    );
    expect(
      findExactInventoryMatches(
        selectedText: 'Longsword\nShield',
        weapons: catalogs.weapons,
        armors: catalogs.armors,
        tools: catalogs.tools,
        items: catalogs.items,
        magicItems: catalogs.magicItems,
      ),
      isEmpty,
    );
  });

  test('matches a weapon by trimmed case-insensitive exact name', () {
    final weapon = WeaponData(
      referenceKey: 'longsword',
      name: 'Longsword',
    );

    final matches = findExactInventoryMatches(
      selectedText: '  LONGSWORD  ',
      weapons: [weapon],
    );

    expect(matches, hasLength(1));
    expect(matches.single.kind, InventoryReferenceKind.weapon);
    expect(matches.single.entity, same(weapon));
  });

  test('matches armor as armor and keeps its typed shield category', () {
    final shield = ArmorData(
      referenceKey: 'shield',
      name: 'Shield',
      categoryValue: ArmorCategory.shield,
    );

    final matches = findExactInventoryMatches(
      selectedText: 'shield',
      armors: [shield],
    );

    expect(matches.single.kind, InventoryReferenceKind.armor);
    expect((matches.single.entity as ArmorData).categoryValue,
        ArmorCategory.shield);
  });

  test('includes tool, item, and magic item catalog matches', () {
    final tool = ToolData(referenceKey: 'thieves_tools', name: "Thieves' Tools");
    final item = ItemData(referenceKey: 'rope', name: 'Rope');
    final magicItem = MagicItemData(referenceKey: 'ring', name: 'Ring');

    expect(
      findExactInventoryMatches(selectedText: "thieves' tools", tools: [tool])
          .single
          .entity,
      same(tool),
    );
    expect(
      findExactInventoryMatches(selectedText: 'Rope', items: [item])
          .single
          .entity,
      same(item),
    );
    expect(
      findExactInventoryMatches(
        selectedText: 'Ring',
        magicItems: [magicItem],
      ).single.entity,
      same(magicItem),
    );
  });

  test('returns every exact match so the caller can resolve ambiguity', () {
    final weapon = WeaponData(referenceKey: 'club', name: 'Club');
    final item = ItemData(referenceKey: 'club', name: 'Club');

    final matches = findExactInventoryMatches(
      selectedText: 'Club',
      weapons: [weapon],
      items: [item],
    );

    expect(matches, hasLength(2));
    expect(
      matches.map((match) => match.kind),
      containsAll([InventoryReferenceKind.weapon, InventoryReferenceKind.item]),
    );
  });

  test('does not fuzzy match', () {
    expect(
      findExactInventoryMatches(
        selectedText: 'Longsword!',
        weapons: [WeaponData(referenceKey: 'longsword', name: 'Longsword')],
      ),
      isEmpty,
    );
  });
}

({
  List<WeaponData> weapons,
  List<ArmorData> armors,
  List<ToolData> tools,
  List<ItemData> items,
  List<MagicItemData> magicItems,
}) _catalogs() => (
      weapons: <WeaponData>[],
      armors: <ArmorData>[],
      tools: <ToolData>[],
      items: <ItemData>[],
      magicItems: <MagicItemData>[],
    );
