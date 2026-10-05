import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() => cache = OfflineCacheDatabase.openInMemory());
  tearDown(() => cache.close());

  test('offline Jack of All Trades matches server derived contract', () async {
    final bard = ClassData(id: 9301, referenceKey: 'stage3_parity_bard');
    const featureKey = 'stage3_parity_jack';
    const featureId = 9302;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(bard.id!, selectedLevel: 2),
      ClassStepView(
        classData: bard,
        selectedLevel: 2,
        currentLevelFeatures: [
          ClassFeatureData(
            id: featureId,
            parentClassId: bard.id!,
            referenceKey: featureKey,
            name: 'Jack test feature',
            level: 2,
          ),
        ],
        featureModifiers: [
          FeatureModifierData(
            referenceKey: 'stage3.parity.jack',
            classFeatureId: featureId,
            target: FeatureModifierTarget.abilityCheck,
            operation: FeatureModifierOperation.add,
            value: FeatureModifierValueData(
              kind: FeatureModifierValueKind.proficiencyBonusFraction,
              numerator: 1,
              denominator: 2,
              rounding: FeatureModifierRounding.floor,
            ),
            conditions: [
              FeatureModifierConditionData(
                type: FeatureModifierConditionType.abilityCheckIsNotProficient,
              ),
            ],
          ),
        ],
      ),
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: bard,
            level: 2,
            isStartingClass: true,
          ),
        ],
        manualSkillProficiencyOverrides: [
          CharacterSkillProficiencyState(
            skill: Skill.acrobatics,
            level: CharacterSkillProficiencyLevel.proficient,
          ),
          CharacterSkillProficiencyState(
            skill: Skill.stealth,
            level: CharacterSkillProficiencyLevel.expertise,
          ),
        ],
      ),
    );

    expect(derived.skillBonuses?[Skill.athletics], 1);
    expect(derived.skillBonuses?[Skill.acrobatics], 2);
    expect(derived.skillBonuses?[Skill.stealth], 4);
    expect(derived.initiative, 1);
    expect(derived.savingThrowBonuses?[Ability.dexterity], 0);
  });

  test('offline Monk movement parity uses class level and equipment state',
      () async {
    final monk = ClassData(id: 9311, referenceKey: 'stage3_parity_monk');
    final fighter = ClassData(id: 9312, referenceKey: 'stage3_parity_fighter');
    const featureId = 9313;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(monk.id!, selectedLevel: 2),
      ClassStepView(
        classData: monk,
        selectedLevel: 2,
        currentLevelFeatures: [
          ClassFeatureData(
            id: featureId,
            parentClassId: monk.id!,
            referenceKey: 'stage3_parity_movement',
            name: 'Movement test feature',
            level: 2,
          ),
        ],
        featureModifiers: [
          FeatureModifierData(
            referenceKey: 'stage3.parity.movement',
            classFeatureId: featureId,
            target: FeatureModifierTarget.speed,
            operation: FeatureModifierOperation.add,
            value: FeatureModifierValueData(
              kind: FeatureModifierValueKind.classLevelProgression,
              progression: const {2: 10, 6: 15, 10: 20, 14: 25, 18: 30},
            ),
            conditions: [
              FeatureModifierConditionData(
                type: FeatureModifierConditionType.unarmored,
              ),
              FeatureModifierConditionData(
                type: FeatureModifierConditionType.noShield,
              ),
            ],
          ),
        ],
      ),
      (value) => value.toJson(),
    );
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(fighter.id!, selectedLevel: 8),
      ClassStepView(classData: fighter, selectedLevel: 8),
      (value) => value.toJson(),
    );

    CharacterData character({bool armor = false, bool shield = false}) =>
        CharacterData(
          classEntries: [
            CharacterClassEntryData(
              classData: monk,
              level: 2,
              isStartingClass: true,
            ),
            CharacterClassEntryData(classData: fighter, level: 8),
          ],
          equippedArmor:
              armor ? CharacterEquipmentSelectionData(name: 'Armor') : null,
          equippedShield:
              shield ? CharacterEquipmentSelectionData(name: 'Shield') : null,
        );

    expect((await buildOfflineDerivedData(cache, character())).speed, 40);
    expect(
      (await buildOfflineDerivedData(cache, character(armor: true))).speed,
      30,
    );
    expect(
      (await buildOfflineDerivedData(cache, character(shield: true))).speed,
      30,
    );
  });
}
