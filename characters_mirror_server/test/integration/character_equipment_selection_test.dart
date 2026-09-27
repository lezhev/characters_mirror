import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Character equipment selections', (sessionBuilder, endpoints) {
    final owner = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(781, <Scope>{}),
    );

    test('save and reload preserves canonical catalog armor and shield',
        () async {
      final session = owner.build();
      late ArmorData bodyArmor;
      late ArmorData shield;
      try {
        bodyArmor = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_leather_armor',
            name: 'Leather Armor',
            categoryValue: ArmorCategory.light,
          ),
        );
        shield = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_shield',
            name: 'Shield',
            categoryValue: ArmorCategory.shield,
          ),
        );
      } finally {
        await session.close();
      }

      final saved = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(
          name: 'Equipment selection persistence',
          equippedArmor: CharacterEquipmentSelectionData(
            referenceKey: bodyArmor.referenceKey,
            name: 'client supplied name',
          ),
          equippedShield: CharacterEquipmentSelectionData(
            referenceKey: shield.referenceKey,
            name: 'client supplied shield name',
          ),
        ),
      );
      final loaded =
          await endpoints.characterData.getCharacter(owner, saved.id!);

      expect(loaded.equippedArmor?.referenceKey, 'stage5_leather_armor');
      expect(loaded.equippedArmor?.name, 'Leather Armor');
      expect(loaded.equippedShield?.referenceKey, 'stage5_shield');
      expect(loaded.equippedShield?.name, 'Shield');

      final custom = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(
          name: 'Custom equipment selection',
          equippedArmor: CharacterEquipmentSelectionData(
            name: '  Custom armor  ',
          ),
        ),
      );
      final loadedCustom = await endpoints.characterData.getCharacter(
        owner,
        custom.id!,
      );
      expect(loadedCustom.equippedArmor?.referenceKey, isNull);
      expect(loadedCustom.equippedArmor?.name, 'Custom armor');
    });

    test('derived AC uses equipped catalog armor and shield statistics',
        () async {
      final session = owner.build();
      try {
        for (final armor in [
          ArmorData(
            referenceKey: 'stage8_leather_armor',
            name: 'Leather Armor',
            categoryValue: ArmorCategory.light,
            baseAC: 11,
            dexBonus: true,
          ),
          ArmorData(
            referenceKey: 'stage8_scale_mail',
            name: 'Scale Mail',
            categoryValue: ArmorCategory.medium,
            baseAC: 14,
            dexBonus: true,
            dexBonusMax: 2,
          ),
          ArmorData(
            referenceKey: 'stage8_chain_mail',
            name: 'Chain Mail',
            categoryValue: ArmorCategory.heavy,
            baseAC: 16,
            dexBonus: false,
          ),
          ArmorData(
            referenceKey: 'stage8_shield',
            name: 'Shield',
            categoryValue: ArmorCategory.shield,
            bonusAC: 3,
          ),
        ]) {
          await ArmorData.db.insertRow(session, armor);
        }
      } finally {
        await session.close();
      }

      Future<int?> derivedArmorClass({
        int dexterity = 16,
        String? armorKey,
        String? shieldKey,
        int? customBonus,
      }) async {
        final saved = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(
            name: 'Stage 8 AC fixture',
            baseAbilityScores: {'dexterity': dexterity},
            equippedArmor: armorKey == null
                ? null
                : CharacterEquipmentSelectionData(
                    referenceKey: armorKey,
                    name: 'Client armor name',
                  ),
            equippedShield: shieldKey == null
                ? null
                : CharacterEquipmentSelectionData(
                    referenceKey: shieldKey,
                    name: 'Client shield name',
                  ),
            customArmorClassBonus: customBonus,
          ),
        );
        final loaded = await endpoints.characterData.getCharacter(
          owner,
          saved.id!,
        );
        return loaded.derived?.armorClass;
      }

      expect(await derivedArmorClass(dexterity: 16), 13);
      expect(await derivedArmorClass(dexterity: 8), 9);
      expect(
        await derivedArmorClass(
          dexterity: 18,
          armorKey: 'stage8_leather_armor',
        ),
        15,
      );
      expect(
        await derivedArmorClass(
          dexterity: 18,
          armorKey: 'stage8_scale_mail',
        ),
        16,
      );
      expect(
        await derivedArmorClass(
          dexterity: 8,
          armorKey: 'stage8_scale_mail',
        ),
        13,
      );
      expect(
        await derivedArmorClass(
          dexterity: 18,
          armorKey: 'stage8_chain_mail',
        ),
        16,
      );
      expect(
        await derivedArmorClass(
          dexterity: 14,
          shieldKey: 'stage8_shield',
        ),
        15,
      );
      expect(
        await derivedArmorClass(
          dexterity: 18,
          armorKey: 'stage8_leather_armor',
          shieldKey: 'stage8_shield',
        ),
        18,
      );
      expect(
        await derivedArmorClass(
          dexterity: 18,
          armorKey: 'stage8_scale_mail',
          shieldKey: 'stage8_shield',
          customBonus: 2,
        ),
        21,
      );
    });

    test('unknown armor key is not resolved by a matching display name',
        () async {
      final session = owner.build();
      late ArmorData leatherArmor;
      try {
        leatherArmor = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage8_name_match_armor',
            name: 'Leather Armor',
            categoryValue: ArmorCategory.light,
            baseAC: 11,
            dexBonus: true,
          ),
        );
      } finally {
        await session.close();
      }

      final saved = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(
          name: 'Unknown armor key fallback',
          baseAbilityScores: const {'dexterity': 16},
          equippedArmor: CharacterEquipmentSelectionData(
            referenceKey: leatherArmor.referenceKey,
            name: leatherArmor.name!,
          ),
        ),
      );
      final mutationSession = owner.build();
      try {
        final record = await CharacterRecord.db.findById(
          mutationSession,
          saved.id!,
        );
        expect(record, isNotNull);
        await CharacterRecord.db.updateRow(
          mutationSession,
          record!.copyWith(
            equippedArmor: CharacterEquipmentSelectionData(
              referenceKey: 'missing_stage8_reference',
              name: leatherArmor.name!,
            ),
          ),
        );
      } finally {
        await mutationSession.close();
      }

      final loaded = await endpoints.characterData.getCharacter(
        owner,
        saved.id!,
      );
      expect(loaded.derived?.armorClass, 13);
    });

    test('body armor rejects a shield reference', () async {
      final session = owner.build();
      try {
        await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_invalid_body_shield',
            name: 'Shield',
            categoryValue: ArmorCategory.shield,
          ),
        );
      } finally {
        await session.close();
      }

      await expectLater(
        endpoints.characterData.saveCharacter(
          owner,
          CharacterData(
            name: 'Invalid body armor type',
            equippedArmor: CharacterEquipmentSelectionData(
              referenceKey: 'stage5_invalid_body_shield',
              name: 'Shield',
            ),
          ),
        ),
        throwsA(isA<InputValidationException>()),
      );
    });

    test('rejects an unknown armor reference key', () async {
      for (final key in ['missing_stage5_armor', '  ']) {
        await expectLater(
          endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
              name: 'Unknown armor reference',
              equippedArmor: CharacterEquipmentSelectionData(
                referenceKey: key,
                name: 'Some armor',
              ),
            ),
          ),
          throwsA(isA<InputValidationException>()),
        );
      }
    });

    test('shield rejects a body armor reference', () async {
      final session = owner.build();
      try {
        await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_invalid_shield_armor',
            name: 'Leather Armor',
            categoryValue: ArmorCategory.light,
          ),
        );
      } finally {
        await session.close();
      }

      await expectLater(
        endpoints.characterData.saveCharacter(
          owner,
          CharacterData(
            name: 'Invalid shield type',
            equippedShield: CharacterEquipmentSelectionData(
              referenceKey: 'stage5_invalid_shield_armor',
              name: 'Leather Armor',
            ),
          ),
        ),
        throwsA(isA<InputValidationException>()),
      );
    });

    test('unknown armor category cannot be assigned to either equipment slot',
        () async {
      final session = owner.build();
      try {
        await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_unknown_category_armor',
            name: 'Uncategorized armor',
          ),
        );
      } finally {
        await session.close();
      }

      for (final selection in [
        (field: 'equippedArmor', name: 'Body slot'),
        (field: 'equippedShield', name: 'Shield slot'),
      ]) {
        await expectLater(
          endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
              name: selection.name,
              equippedArmor: selection.field == 'equippedArmor'
                  ? CharacterEquipmentSelectionData(
                      referenceKey: 'stage5_unknown_category_armor',
                      name: 'Uncategorized armor',
                    )
                  : null,
              equippedShield: selection.field == 'equippedShield'
                  ? CharacterEquipmentSelectionData(
                      referenceKey: 'stage5_unknown_category_armor',
                      name: 'Uncategorized armor',
                    )
                  : null,
            ),
          ),
          throwsA(isA<InputValidationException>()),
        );
      }
    });

    test('custom equipment requires a name of at most 120 characters',
        () async {
      for (final name in ['', '  ', List.filled(121, 'x').join()]) {
        await expectLater(
          endpoints.characterData.saveCharacter(
            owner,
            CharacterData(
              name: 'Invalid custom equipment',
              equippedArmor: CharacterEquipmentSelectionData(name: name),
            ),
          ),
          throwsA(isA<InputValidationException>()),
        );
      }
    });

    test('sync v2.8 set, replacement, and clear persist armor selection',
        () async {
      final session = owner.build();
      late ArmorData firstArmor;
      late ArmorData secondArmor;
      try {
        firstArmor = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_sync_leather',
            name: 'Leather Armor',
            categoryValue: ArmorCategory.light,
          ),
        );
        secondArmor = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_sync_chain',
            name: 'Chain Mail',
            categoryValue: ArmorCategory.heavy,
          ),
        );
      } finally {
        await session.close();
      }

      var current = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(name: 'Equipment sync'),
      );
      final armorSelections = <CharacterEquipmentSelectionData?>[
        CharacterEquipmentSelectionData(
          referenceKey: firstArmor.referenceKey,
          name: firstArmor.name!,
        ),
        CharacterEquipmentSelectionData(
          referenceKey: secondArmor.referenceKey,
          name: secondArmor.name!,
        ),
        null,
      ];
      for (var index = 0; index < armorSelections.length; index++) {
        final selection = armorSelections[index];
        final targetRevision =
            current.syncTargetRevisions?['field:equippedArmor'] ??
                current.version ??
                0;
        final response = await endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(
            syncProtocolVersion: 4,
            operations: [
              CharacterSyncOperationData(
                id: 'armor-${current.version}',
                characterId: current.id,
                localCharacterId: current.id,
                type: CharacterSyncOperationType.setField,
                targetType: CharacterSyncTargetType.field,
                targetId: 'equippedArmor',
                fieldPath: 'equippedArmor',
                value: CharacterSyncValueData(
                  equipmentSelectionValue: selection,
                ),
                baseCharacterRevision: current.version,
                baseTargetRevision: targetRevision,
                createdAt: DateTime.utc(2026, 9, 27),
              ),
            ],
          ),
        );
        expect(response.acknowledgedChangeIds, isNotEmpty);
        current = await endpoints.characterData.getCharacter(
          owner,
          current.id!,
        );
        expect(
          current.equippedArmor?.referenceKey,
          [firstArmor.referenceKey, secondArmor.referenceKey, null][index],
        );
      }
      expect(current.equippedArmor, isNull);
    });

    test('sync v2.8 set, replacement, and clear persist shield selection',
        () async {
      final session = owner.build();
      late ArmorData firstShield;
      late ArmorData secondShield;
      try {
        firstShield = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_sync_wooden_shield',
            name: 'Wooden Shield',
            categoryValue: ArmorCategory.shield,
          ),
        );
        secondShield = await ArmorData.db.insertRow(
          session,
          ArmorData(
            referenceKey: 'stage5_sync_steel_shield',
            name: 'Steel Shield',
            categoryValue: ArmorCategory.shield,
          ),
        );
      } finally {
        await session.close();
      }

      var current = await endpoints.characterData.saveCharacter(
        owner,
        CharacterData(name: 'Shield sync'),
      );
      final shieldSelections = <CharacterEquipmentSelectionData?>[
        CharacterEquipmentSelectionData(
          referenceKey: firstShield.referenceKey,
          name: firstShield.name!,
        ),
        CharacterEquipmentSelectionData(
          referenceKey: secondShield.referenceKey,
          name: secondShield.name!,
        ),
        null,
      ];
      for (var index = 0; index < shieldSelections.length; index++) {
        final targetRevision =
            current.syncTargetRevisions?['field:equippedShield'] ??
                current.version ??
                0;
        final response = await endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(
            syncProtocolVersion: 4,
            operations: [
              CharacterSyncOperationData(
                id: 'shield-${current.version}',
                characterId: current.id,
                localCharacterId: current.id,
                type: CharacterSyncOperationType.setField,
                targetType: CharacterSyncTargetType.field,
                targetId: 'equippedShield',
                fieldPath: 'equippedShield',
                value: CharacterSyncValueData(
                  equipmentSelectionValue: shieldSelections[index],
                ),
                baseCharacterRevision: current.version,
                baseTargetRevision: targetRevision,
                createdAt: DateTime.utc(2026, 9, 27),
              ),
            ],
          ),
        );
        expect(response.acknowledgedChangeIds, isNotEmpty);
        current = await endpoints.characterData.getCharacter(
          owner,
          current.id!,
        );
        expect(
          current.equippedShield?.referenceKey,
          [firstShield.referenceKey, secondShield.referenceKey, null][index],
        );
      }
    });
  });
}
