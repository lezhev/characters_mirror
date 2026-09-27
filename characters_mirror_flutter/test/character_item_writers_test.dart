import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/character_model_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deleting the first note preserves the second note identity', () {
    final notes = [
      CharacterNoteData(id: 'note-a', text: 'A'),
      CharacterNoteData(id: 'note-b', text: 'B'),
    ];

    final result = removeCharacterNote(notes, 'note-a');

    expect(result, hasLength(1));
    expect(result!.single.id, 'note-b');
    expect(result.single.text, 'B');
  });

  test('inventory text is stored as one custom text value', () {
    final items = [
      CharacterInventoryItemData(
        id: 'item-a',
        name: 'Rope',
        quantity: 2,
        type: CharacterInventoryItemType.item,
      ),
      CharacterInventoryItemData(
        id: 'item-b',
        name: 'Torch',
        quantity: 4,
        type: CharacterInventoryItemType.custom,
      ),
    ];

    final result = inventoryItemsFromText(
      'Silk rope x2, Torch x4',
      previous: items,
    );

    expect(result, hasLength(1));
    expect(result!.single.id, 'item-a');
    expect(result.single.name, 'Silk rope x2, Torch x4');
    expect(result.single.quantity, 1);
    expect(result.single.type, CharacterInventoryItemType.custom);
  });
}
