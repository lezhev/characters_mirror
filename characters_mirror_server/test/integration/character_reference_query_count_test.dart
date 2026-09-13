import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/endpoints/models/general/character_data_endpoint.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Character reference query count',
    (sessionBuilder, _) {
      test('deduplicates immutable reference lookups during one save',
          () async {
        final setupSession = sessionBuilder.build();
        late final ClassData classData;
        late final StartingEquipmentEntryData categoryLine;
        try {
          classData = await ClassData.db.insertRow(
            setupSession,
            ClassData(name: 'Reference query fixture', hitDieValue: 8),
          );
          for (final name in const [
            'Reference query choice A',
            'Reference query choice B',
          ]) {
            await ClassChoiceGroupData.db.insertRow(
              setupSession,
              ClassChoiceGroupData(
                name: name,
                sourceClassId: classData.id,
                level: 1,
                selectionCount: 1,
              ),
            );
          }
          await WeaponData.db.insertRow(
            setupSession,
            WeaponData(
              referenceKey: 'instrumented_javelin',
              name: 'Instrumented Javelin',
              category: WeaponCategory.simpleMelee,
              damage: '1d6',
              damageType: DamageType.piercing,
              properties: const [
                WeaponProperty.finesse,
                WeaponProperty.thrown,
              ],
            ),
          );
          await StartingEquipmentEntryData.db.insertRow(
            setupSession,
            StartingEquipmentEntryData(
              sourceClassId: classData.id,
              kind: StartingEquipmentEntryKind.fixedLine,
              orderIndex: 0,
              lineKind: StartingEquipmentLineKind.catalogRef,
              catalogType: EquipmentCatalogType.weapon,
              referenceKey: 'instrumented_javelin',
              quantity: 1,
            ),
          );
          categoryLine = await StartingEquipmentEntryData.db.insertRow(
            setupSession,
            StartingEquipmentEntryData(
              sourceClassId: classData.id,
              kind: StartingEquipmentEntryKind.fixedLine,
              orderIndex: 1,
              lineKind: StartingEquipmentLineKind.weaponCategory,
              allowedWeaponCategories: const [WeaponCategory.simpleMelee],
              quantity: 1,
            ),
          );
        } finally {
          await setupSession.close();
        }

        final ownerSessionBuilder = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            901,
            const {},
          ),
        );
        final referenceLoads = <String>[];
        final endpoint = CharacterDataEndpoint(
          referenceQueryObserver: referenceLoads.add,
        );
        final ownerSession = ownerSessionBuilder.build();
        try {
          await endpoint.saveCharacter(
            ownerSession,
            CharacterData(
              name: 'Reference query hero',
              classEntries: [
                CharacterClassEntryData(
                  classData: classData,
                  level: 1,
                  isStartingClass: true,
                  classOrder: 0,
                ),
              ],
              startingEquipmentSelections: [
                CharacterStartingEquipmentSelectionData(
                  sourceType: ChoiceSourceType.classData,
                  sourceId: classData.id,
                  sourceEntryId: categoryLine.id,
                  selectionIndex: 0,
                  resolutions: [
                    CharacterStartingEquipmentResolutionData(
                      sourceLineEntryId: categoryLine.id,
                      catalogType: EquipmentCatalogType.weapon,
                      referenceKey: 'instrumented_javelin',
                      quantity: 1,
                    ),
                  ],
                ),
              ],
            ),
          );
        } finally {
          await ownerSession.close();
        }

        expect(
          referenceLoads.where(
            (key) => key == 'weapon:instrumented_javelin',
          ),
          hasLength(1),
        );
        expect(
          referenceLoads.where((key) => key == 'classChoiceGroups'),
          hasLength(1),
        );
        expect(
          referenceLoads.where((key) => key.startsWith('classChoiceOptions:')),
          hasLength(1),
        );
      });
    },
  );
}
