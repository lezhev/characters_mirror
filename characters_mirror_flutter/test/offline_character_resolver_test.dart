import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  test('ToolData preserves nullable and available category identities', () {
    final tools = [
      ToolData(referenceKey: 'thieves_tools', name: 'Воровские инструменты'),
      ToolData(
        referenceKey: 'smith_tools',
        name: 'Инструменты кузнеца',
        category: ToolCategory.artisan,
      ),
      ToolData(
        referenceKey: 'lute',
        name: 'Лютня',
        category: ToolCategory.musicalInstrument,
      ),
      ToolData(
        referenceKey: 'dice_set',
        name: 'Кости',
        category: ToolCategory.gamingSet,
      ),
    ];

    final decoded = [
      for (final tool in tools) ToolData.fromJson(tool.toJson()),
    ];

    expect(decoded.map((tool) => tool.referenceKey), [
      'thieves_tools',
      'smith_tools',
      'lute',
      'dice_set',
    ]);
    expect(decoded.map((tool) => tool.category), [
      isNull,
      ToolCategory.artisan,
      ToolCategory.musicalInstrument,
      ToolCategory.gamingSet,
    ]);
  });

  test('offline tool grants merge canonical keys and ignore category markers',
      () async {
    await cache.putReferenceList(
      'class_choice_group',
      offlineAllKey,
      [
        ClassChoiceGroupData(
          id: 1,
          sourceClassId: 10,
          exclusiveKey: 'tool_choice',
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'class_choice_option',
      offlineAllKey,
      [
        ClassChoiceOptionData(
          id: 2,
          choiceGroupId: 1,
          optionKey: 'tools',
          grantedToolKeys: const ['lute', 'dice_set'],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(
          toolProficiencyKeys: const ['smith_tools', 'thieves_tools'],
        ),
        subrace: SubraceData(
          parentRaceId: 1,
          toolProficiencyKeys: const ['lute'],
        ),
        background: BackgroundData(
          toolProficiencies: const [
            'Музыкальный инструмент',
            'Игровой набор',
            'Инструменты ремесленника',
          ],
          toolProficiencyKeys: const ['smith_tools', 'dice_set'],
        ),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              id: 10,
              toolTrainingKeys: const ['navigator_tools', 'smith_tools'],
              multiclassToolTrainingKeys: const ['wrong_starting_grant'],
            ),
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
          CharacterClassEntryData(
            classData: ClassData(
              id: 11,
              toolTrainingKeys: const ['wrong_multiclass_grant'],
              multiclassToolTrainingKeys: const ['vehicle_land'],
            ),
            level: 1,
            isStartingClass: false,
            classOrder: 1,
          ),
        ],
        choices: [
          CharacterChoiceData(
            sourceType: ChoiceSourceType.classData,
            groupKey: 'tool_choice',
            optionKey: 'tools',
          ),
        ],
      ),
    );

    expect(
      derived.toolProficiencyKeys,
      unorderedEquals([
        'dice_set',
        'lute',
        'navigator_tools',
        'smith_tools',
        'thieves_tools',
        'vehicle_land',
      ]),
    );
  });

  test('fixed reference skills contribute to offline derived proficiencies',
      () async {
    final character = CharacterData(
      race: RaceData(
        skillProficiencies: const [Skill.athletics],
        languages: const [Language.common],
        armorProficiencies: const [ArmorCategory.heavy],
      ),
      subrace: SubraceData(
        parentRaceId: 1,
        skillProficiencies: const [Skill.stealth],
        armorProficiencies: const [ArmorCategory.shield],
      ),
      background: BackgroundData(skillProficiencies: const [Skill.insight]),
    );

    final derived = await buildOfflineDerivedData(cache, character);
    final levels = {
      for (final state in derived.skillProficiencyLevels ??
          const <CharacterSkillProficiencyState>[])
        state.skill: state.level,
    };

    expect(
      levels[Skill.athletics],
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(
      levels[Skill.stealth],
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(
      levels[Skill.insight],
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(
      levels[Skill.arcana],
      CharacterSkillProficiencyLevel.none,
    );
    expect(derived.languages, [Language.common.name]);
    expect(
      derived.armorTraining,
      unorderedEquals([
        ArmorCategory.heavy.name,
        ArmorCategory.shield.name,
      ]),
    );
  });

  test('multiclass saving throws match server starting-class semantics',
      () async {
    final fighter = ClassData(
      name: 'Fighter',
      savingThrowProficiencies: const [
        Ability.strength,
        Ability.constitution,
      ],
    );
    final wizard = ClassData(
      name: 'Wizard',
      savingThrowProficiencies: const [
        Ability.intelligence,
        Ability.wisdom,
      ],
    );
    final character = CharacterData(
      classEntries: [
        CharacterClassEntryData(
          classData: wizard,
          level: 1,
          isStartingClass: false,
          classOrder: 1,
        ),
        CharacterClassEntryData(
          classData: fighter,
          level: 1,
          isStartingClass: true,
          classOrder: 0,
        ),
      ],
      manualSavingThrowProficiencyOverrides: [
        CharacterSavingThrowProficiencyOverrideData(
          ability: Ability.constitution,
          state: CharacterSavingThrowProficiencyOverride.remove,
        ),
        CharacterSavingThrowProficiencyOverrideData(
          ability: Ability.dexterity,
          state: CharacterSavingThrowProficiencyOverride.add,
        ),
      ],
    );

    final derived = await buildOfflineDerivedData(cache, character);

    expect(
      derived.savingThrowProficiencies,
      unorderedEquals([Ability.strength, Ability.dexterity]),
    );
  });

  test('saving throw fallback uses the lowest class order', () async {
    final fighter = ClassData(
      name: 'Fighter',
      savingThrowProficiencies: const [
        Ability.strength,
        Ability.constitution,
      ],
    );
    final wizard = ClassData(
      name: 'Wizard',
      savingThrowProficiencies: const [
        Ability.intelligence,
        Ability.wisdom,
      ],
    );
    final character = CharacterData(
      classEntries: [
        CharacterClassEntryData(
          classData: wizard,
          level: 1,
          classOrder: 2,
        ),
        CharacterClassEntryData(
          classData: fighter,
          level: 1,
          classOrder: 1,
        ),
      ],
    );

    final derived = await buildOfflineDerivedData(cache, character);

    expect(
      derived.savingThrowProficiencies,
      unorderedEquals([Ability.strength, Ability.constitution]),
    );
  });

  test('local resolve preserves server spell-slot progression', () async {
    final resolved = await resolveOfflineCharacter(
      cache,
      CharacterData(
        currentSpellSlots: const {1: 0},
        derived: CharacterDerivedData(
          spellSlots: const {1: 2},
          pactSlots: const {2: 1},
        ),
      ),
    );

    expect(resolved.currentSpellSlots, const {1: 0});
    expect(resolved.derived?.spellSlots, const {1: 2});
    expect(resolved.derived?.pactSlots, const {2: 1});
  });

  test('racial weapon proficiency keys stay separate offline', () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(
          weaponProficiencyKeys: const [
            'battleaxe',
            'handaxe',
            'light_hammer',
            'warhammer',
          ],
        ),
      ),
    );

    expect(derived.weaponTraining, isEmpty);
    expect(
      derived.weaponProficiencyKeys,
      unorderedEquals([
        'battleaxe',
        'handaxe',
        'light_hammer',
        'warhammer',
      ]),
    );
  });

  test('offline weapon training uses starting and multiclass semantics',
      () async {
    final startingClass = ClassData(
      weaponTraining: const [WeaponCategory.martialMelee],
      multiclassWeaponTraining: const [WeaponCategory.simpleMelee],
    );
    final multiclass = ClassData(
      weaponTraining: const [WeaponCategory.simpleRanged],
      multiclassWeaponTraining: const [WeaponCategory.martialRanged],
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: startingClass,
            isStartingClass: true,
            classOrder: 0,
            level: 1,
          ),
          CharacterClassEntryData(
            classData: multiclass,
            isStartingClass: false,
            classOrder: 1,
            level: 1,
          ),
        ],
      ),
    );

    expect(
      derived.weaponTraining,
      unorderedEquals([
        WeaponCategory.martialMelee,
        WeaponCategory.martialRanged,
      ]),
    );
    expect(derived.weaponProficiencyKeys, isEmpty);
  });

  test('offline keeps race keys and class categories independent', () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(weaponProficiencyKeys: const ['battleaxe']),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              weaponTraining: const [WeaponCategory.simpleRanged],
            ),
            isStartingClass: true,
            classOrder: 0,
            level: 1,
          ),
        ],
      ),
    );

    expect(derived.weaponTraining, [WeaponCategory.simpleRanged]);
    expect(derived.weaponProficiencyKeys, ['battleaxe']);
  });

  test('offline applies cached supported class choice weapon training',
      () async {
    await cache.putReferenceList(
      'class_choice_group',
      offlineAllKey,
      [
        ClassChoiceGroupData(
          id: 1,
          sourceClassId: 10,
          exclusiveKey: 'weapon_choice',
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'class_choice_option',
      offlineAllKey,
      [
        ClassChoiceOptionData(
          id: 2,
          choiceGroupId: 1,
          optionKey: 'martial',
          grantedWeaponTraining: const [WeaponCategory.martialMelee],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: 10),
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        choices: [
          CharacterChoiceData(
            sourceType: ChoiceSourceType.classData,
            sourceId: 10,
            groupKey: 'weapon_choice',
            optionKey: 'martial',
          ),
        ],
      ),
    );

    expect(derived.weaponTraining, [WeaponCategory.martialMelee]);
  });
}
