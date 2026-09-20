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

  test('editing one inventory item preserves sibling data', () {
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

    final result = upsertCharacterInventoryItem(
      items,
      id: 'item-a',
      name: 'Silk rope',
    );

    expect(result, hasLength(2));
    expect(result![0].id, 'item-a');
    expect(result[0].name, 'Silk rope');
    expect(result[0].quantity, 2);
    expect(result[0].type, CharacterInventoryItemType.item);
    expect(result[1].id, 'item-b');
    expect(result[1].name, 'Torch');
    expect(result[1].quantity, 4);
  });
}
