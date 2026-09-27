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

  test('offline starting equipment resolves fixed and selected ToolData',
      () async {
    final startingClass = ClassData(id: 12, name: 'Bard');
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(12),
      ClassStepView(
        classData: startingClass,
        selectedLevel: 1,
        startingEquipmentBlocks: [
          StartingEquipmentBlockView(
            block: StartingEquipmentBlockData(
              entryId: 101,
              kind: StartingEquipmentBlockKind.fixedGrant,
            ),
            fixedLines: [
              StartingEquipmentLineData(
                entryId: 102,
                kind: StartingEquipmentLineKind.itemCategory,
                catalogType: EquipmentCatalogType.tool,
                allowedItemCategories: [ToolCategory.musicalInstrument.name],
              ),
              StartingEquipmentLineData(
                entryId: 103,
                kind: StartingEquipmentLineKind.catalogRef,
                catalogType: EquipmentCatalogType.tool,
                referenceKey: 'thieves_tools',
              ),
            ],
          ),
        ],
      ),
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'tool',
      offlineAllKey,
      [
        ToolData(
          referenceKey: 'lute',
          name: 'Lute from tools',
          category: ToolCategory.musicalInstrument,
        ),
        ToolData(referenceKey: 'thieves_tools', name: 'Thieves’ tools'),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: startingClass,
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        startingEquipmentSelections: [
          CharacterStartingEquipmentSelectionData(
            sourceType: ChoiceSourceType.classData,
            sourceId: 12,
            sourceEntryId: 101,
            isSelected: true,
            resolutions: [
              CharacterStartingEquipmentResolutionData(
                sourceLineEntryId: 102,
                catalogType: EquipmentCatalogType.tool,
                referenceKey: 'lute',
              ),
            ],
          ),
        ],
      ),
    );

    expect(
      derived.grantedEquipment
          ?.map((entry) =>
              (entry.catalogType, entry.referenceKey, entry.displayText))
          .toSet(),
      {
        (EquipmentCatalogType.tool, 'lute', 'Lute from tools'),
        (EquipmentCatalogType.tool, 'thieves_tools', 'Thieves’ tools'),
      },
    );
  });

  test('offline background equipment keeps fixed, category, and coin data',
      () async {
    const backgroundId = 19;
    const fixedLineId = 1901;
    const groupId = 1902;
    const optionId = 1903;
    const categoryLineId = 1904;
    final background = BackgroundData(
      id: backgroundId,
      name: 'Народный герой',
      coins: 10,
      items: const ['legacy free-text equipment'],
    );
    final fixedLine = StartingEquipmentLineData(
      entryId: fixedLineId,
      kind: StartingEquipmentLineKind.catalogRef,
      catalogType: EquipmentCatalogType.item,
      referenceKey: 'common_clothes',
      quantity: 1,
    );
    final categoryLine = StartingEquipmentLineData(
      entryId: categoryLineId,
      kind: StartingEquipmentLineKind.itemCategory,
      catalogType: EquipmentCatalogType.tool,
      allowedItemCategories: [ToolCategory.artisan.name],
      quantity: 1,
    );
    final option = StartingEquipmentOptionData(
      entryId: optionId,
      parentEntryId: groupId,
      orderIndex: 0,
      lines: [categoryLine],
    );
    final stepView = BackgroundStepView(
      background: background,
      startingEquipmentBlocks: [
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            entryId: fixedLineId,
            kind: StartingEquipmentBlockKind.fixedGrant,
            fixedLines: [fixedLine],
          ),
          fixedLines: [fixedLine],
        ),
        StartingEquipmentBlockView(
          block: StartingEquipmentBlockData(
            entryId: groupId,
            kind: StartingEquipmentBlockKind.choice,
            selectionCount: 1,
            options: [option],
          ),
          options: [
            StartingEquipmentOptionView(option: option, lines: [categoryLine])
          ],
        ),
      ],
    );
    await cache.putReference(
      offlineBackgroundStepKind,
      offlineBackgroundStepKey(backgroundId),
      stepView,
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'item',
      offlineAllKey,
      [ItemData(referenceKey: 'common_clothes', name: 'Common clothes')],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'tool',
      offlineAllKey,
      [
        ToolData(
          referenceKey: 'smith_tools',
          name: 'Smith tools',
          category: ToolCategory.artisan,
        ),
      ],
      (value) => value.toJson(),
    );

    final character = CharacterData(
      background: background,
      startingEquipmentSelections: [
        CharacterStartingEquipmentSelectionData(
          sourceType: ChoiceSourceType.background,
          sourceId: backgroundId,
          sourceEntryId: groupId,
          choiceOptionEntryId: optionId,
          isSelected: true,
          resolutions: [
            CharacterStartingEquipmentResolutionData(
              sourceLineEntryId: categoryLineId,
              catalogType: EquipmentCatalogType.tool,
              referenceKey: 'smith_tools',
            ),
          ],
        ),
      ],
    );
    final derived = await buildOfflineDerivedData(cache, character);

    expect(character.background?.coins, 10);
    expect(
      derived.grantedEquipment
          ?.map((entry) =>
              (entry.catalogType, entry.referenceKey, entry.displayText))
          .toSet(),
      {
        (EquipmentCatalogType.item, 'common_clothes', 'Common clothes'),
        (EquipmentCatalogType.tool, 'smith_tools', 'Smith tools'),
      },
    );
  });

  test('offline tool grants merge canonical keys and ignore category markers',
      () async {
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 1,
          referenceKey: 'class_tool_choice',
          sourceClassId: 10,
          exclusiveKey: 'tool_choice',
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
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

  test('generic background choice resolves its typed tool grant offline',
      () async {
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 7,
          referenceKey: 'folk_hero_artisan_tool',
          sourceBackgroundId: 3,
          selectionCount: 1,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
          id: 17,
          choiceGroupId: 7,
          optionKey: 'smith_tools',
          grantedToolKeys: const ['smith_tools'],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        background: BackgroundData(id: 3),
        choices: [
          CharacterChoiceData(
            groupKey: 'folk_hero_artisan_tool',
            optionKey: 'smith_tools',
          ),
        ],
      ),
    );

    expect(derived.toolProficiencyKeys, ['smith_tools']);
  });

  test('offline proficiency overrides preserve canonical identities and deltas',
      () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(
          languages: const [Language.common],
          armorProficiencies: const [ArmorCategory.light],
          toolProficiencyKeys: const ['smith_tools'],
          weaponProficiencyKeys: const ['battleaxe'],
        ),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              weaponTraining: const [WeaponCategory.martialMelee],
            ),
            level: 1,
            isStartingClass: true,
            classOrder: 0,
          ),
        ],
        manualLanguageOverrides: CharacterLanguageOverridesData(
          added: const [Language.elvish],
          removed: const [Language.common],
          custom: const ['  River speech  ', 'river SPEECH'],
        ),
        manualToolProficiencyOverrides: CharacterToolProficiencyOverridesData(
          addedKeys: const ['thieves_tools'],
          removedKeys: const ['smith_tools'],
          custom: const ['  Clockwork tools  '],
        ),
        manualWeaponProficiencyOverrides:
            CharacterWeaponProficiencyOverridesData(
          addedCategories: const [WeaponCategory.simpleRanged],
          removedCategories: const [WeaponCategory.martialMelee],
          addedKeys: const ['longsword'],
          removedKeys: const ['battleaxe'],
          custom: const ['  Moonblade  '],
        ),
        manualArmorTrainingOverrides: CharacterArmorTrainingOverridesData(
          addedCategories: const [ArmorCategory.shield],
          removedCategories: const [ArmorCategory.light],
          custom: const ['  Bone armor  '],
        ),
      ),
    );

    expect(derived.languages, [Language.elvish]);
    expect(derived.customLanguages, ['River speech']);
    expect(derived.toolProficiencyKeys, ['thieves_tools']);
    expect(derived.customToolProficiencies, ['Clockwork tools']);
    expect(derived.weaponTraining, [WeaponCategory.simpleRanged]);
    expect(derived.weaponProficiencyKeys, ['longsword']);
    expect(derived.customWeaponProficiencies, ['Moonblade']);
    expect(derived.armorTraining, [ArmorCategory.shield]);
    expect(derived.customArmorTraining, ['Bone armor']);
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
    expect(derived.languages, [Language.common]);
    expect(
      derived.armorTraining,
      unorderedEquals([
        ArmorCategory.heavy,
        ArmorCategory.shield,
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
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 1,
          referenceKey: 'class_weapon_choice',
          sourceClassId: 10,
          exclusiveKey: 'weapon_choice',
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
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
            groupKey: 'class_weapon_choice',
            optionKey: 'martial',
          ),
        ],
      ),
    );

    expect(derived.weaponTraining, [WeaponCategory.martialMelee]);
  });

  test('offline applies typed ability, skill, and spell choice grants',
      () async {
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 30,
          referenceKey: 'race_feature_choice',
          sourceRaceId: 7,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
          choiceGroupId: 30,
          optionKey: 'gift',
          grantedAbilityBonuses: const {'strength': 2},
          grantedSkills: const [Skill.athletics],
          grantedSpellKeys: const ['false_life'],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(id: 7),
        baseAbilityScores: const {'strength': 10},
        choices: [
          CharacterChoiceData(
            groupKey: 'race_feature_choice',
            optionKey: 'gift',
          ),
        ],
      ),
    );

    expect(derived.abilityScores?['strength'], 12);
    expect(
      derived.skillProficiencyLevels
          ?.firstWhere((state) => state.skill == Skill.athletics)
          .level,
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(derived.skillBonuses?['athletics'], 3);
    expect(derived.grantedSpellKeys, contains('false_life'));
  });
}
