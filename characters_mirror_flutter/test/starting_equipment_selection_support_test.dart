import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/application/starting_equipment_selection_support.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalizeStartingEquipmentSelections', () {
    test('keeps fixed-block category resolutions and drops unrelated ones', () {
      final blocks = [
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            blockKey: 'fixed_block',
            kind: StartingEquipmentBlockKind.fixedGrant,
          ),
          fixedLines: [
            StartingEquipmentLineData(
              lineKey: 'fixed_simple_weapon',
              kind: StartingEquipmentLineKind.weaponCategory,
              quantity: 1,
            ),
            StartingEquipmentLineData(
              lineKey: 'fixed_dagger',
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
            blockKey: 'fixed_block',
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                lineKey: 'fixed_simple_weapon',
                catalogType: EquipmentCatalogType.weapon,
                referenceKey: 'club',
                quantity: 1,
              ),
              CharacterStartingEquipmentResolutionData(
                lineKey: 'unknown_line',
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
      expect(normalized.single.blockKey, 'fixed_block');
      expect(normalized.single.optionKey, isNull);
      expect(normalized.single.resolutions, hasLength(1));
      expect(
          normalized.single.resolutions!.single.lineKey, 'fixed_simple_weapon');
      expect(normalized.single.resolutions!.single.referenceKey, 'club');
    });

    test('drops choice selections whose option is no longer available', () {
      final blocks = [
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            blockKey: 'choice_block',
            kind: StartingEquipmentBlockKind.choice,
            selectionCount: 1,
          ),
          options: [
            StartingEquipmentOptionView(
              option: StartingEquipmentOptionData(
                optionKey: 'crossbow_option',
              ),
              lines: [
                StartingEquipmentLineData(
                  lineKey: 'crossbow_line',
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
            blockKey: 'choice_block',
            optionKey: 'removed_option',
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
            blockKey: 'armor_block',
            kind: StartingEquipmentBlockKind.fixedGrant,
          ),
          fixedLines: [
            StartingEquipmentLineData(
              lineKey: 'armor_choice',
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
            blockKey: 'armor_block',
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                lineKey: 'armor_choice',
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
