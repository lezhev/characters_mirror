import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/starting_equipment_selection_support.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeStartingEquipmentSelections', () {
    test('creates default selected fixed selections', () {
      final normalized = normalizeStartingEquipmentSelections(
        blocks: [
          StartingEquipmentBlockView(
            block: StartingEquipmentBlockData(
              entryId: 5,
              kind: StartingEquipmentBlockKind.fixedGrant,
            ),
            fixedLines: [
              StartingEquipmentLineData(
                entryId: 6,
                kind: StartingEquipmentLineKind.catalogRef,
              ),
            ],
          ),
        ],
        selections: const [],
        sourceType: ChoiceSourceType.classData,
        sourceId: 7,
      );

      expect(normalized, hasLength(1));
      expect(normalized.single.sourceEntryId, 5);
      expect(normalized.single.isSelected, isTrue);
    });

    test('keeps explicitly unselected fixed selections', () {
      final normalized = normalizeStartingEquipmentSelections(
        blocks: [
          StartingEquipmentBlockView(
            block: StartingEquipmentBlockData(
              entryId: 5,
              kind: StartingEquipmentBlockKind.fixedGrant,
            ),
            fixedLines: [
              StartingEquipmentLineData(
                entryId: 6,
                kind: StartingEquipmentLineKind.catalogRef,
              ),
            ],
          ),
        ],
        selections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.classData,
            sourceId: 7,
            sourceEntryId: 5,
            isSelected: false,
          ),
        ],
        sourceType: ChoiceSourceType.classData,
        sourceId: 7,
      );

      expect(normalized, hasLength(1));
      expect(normalized.single.sourceEntryId, 5);
      expect(normalized.single.isSelected, isFalse);
    });

    test('keeps fixed-block category resolutions and drops unrelated ones', () {
      final blocks = [
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            entryId: 10,
            kind: StartingEquipmentBlockKind.fixedGrant,
          ),
          fixedLines: [
            StartingEquipmentLineData(
              entryId: 11,
              kind: StartingEquipmentLineKind.weaponCategory,
              quantity: 1,
            ),
            StartingEquipmentLineData(
              entryId: 12,
              kind: StartingEquipmentLineKind.catalogRef,
              quantity: 2,
            ),
          ],
        ),
      ];

      final normalized = normalizeStartingEquipmentSelections(
        blocks: blocks,
        selections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.classData,
            sourceId: 7,
            sourceEntryId: 10,
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                sourceLineEntryId: 11,
                catalogType: EquipmentCatalogType.weapon,
                referenceKey: 'club',
                quantity: 1,
              ),
              CharacterStartingEquipmentResolutionData(
                sourceLineEntryId: 99,
                catalogType: EquipmentCatalogType.weapon,
                referenceKey: 'dagger',
                quantity: 1,
              ),
            ],
          ),
        ],
        sourceType: ChoiceSourceType.classData,
        sourceId: 7,
      );

      expect(normalized, hasLength(1));
      expect(normalized.single.sourceEntryId, 10);
      expect(normalized.single.choiceOptionEntryId, isNull);
      expect(normalized.single.resolutions, hasLength(1));
      expect(normalized.single.resolutions!.single.sourceLineEntryId, 11);
      expect(normalized.single.resolutions!.single.referenceKey, 'club');
    });

    test('drops choice selections whose option is no longer available', () {
      final blocks = [
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            entryId: 20,
            kind: StartingEquipmentBlockKind.choice,
            selectionCount: 1,
          ),
          options: [
            StartingEquipmentOptionView(
              option: StartingEquipmentOptionData(entryId: 21),
              lines: [
                StartingEquipmentLineData(
                  entryId: 22,
                  kind: StartingEquipmentLineKind.catalogRef,
                ),
              ],
            ),
          ],
        ),
      ];

      final normalized = normalizeStartingEquipmentSelections(
        blocks: blocks,
        selections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.classData,
            sourceId: 9,
            sourceEntryId: 20,
            choiceOptionEntryId: 99,
          ),
        ],
        sourceType: ChoiceSourceType.classData,
        sourceId: 9,
      );

      expect(normalized, isEmpty);
    });

    test('keeps armor category resolutions as armor catalog entries', () {
      final blocks = [
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            entryId: 30,
            kind: StartingEquipmentBlockKind.fixedGrant,
          ),
          fixedLines: [
            StartingEquipmentLineData(
              entryId: 31,
              kind: StartingEquipmentLineKind.itemCategory,
              catalogType: EquipmentCatalogType.armor,
              quantity: 1,
            ),
          ],
        ),
      ];

      final normalized = normalizeStartingEquipmentSelections(
        blocks: blocks,
        selections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.classData,
            sourceId: 7,
            sourceEntryId: 30,
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                sourceLineEntryId: 31,
                catalogType: EquipmentCatalogType.armor,
                referenceKey: 'leather_armor',
                quantity: 1,
              ),
            ],
          ),
        ],
        sourceType: ChoiceSourceType.classData,
        sourceId: 7,
      );

      expect(normalized, hasLength(1));
      expect(normalized.single.resolutions, hasLength(1));
      expect(
        normalized.single.resolutions!.single.catalogType,
        EquipmentCatalogType.armor,
      );
      expect(
        normalized.single.resolutions!.single.referenceKey,
        'leather_armor',
      );
    });
  });
}
