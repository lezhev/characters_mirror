import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_fixtures/derived_parity_contract.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  test('offline derived payload omits redundant aggregate metadata', () async {
    final derived = await buildOfflineDerivedData(cache, CharacterData());
    final serializedKeys = derived.toJson().keys;

    expect(serializedKeys, isNot(contains('featureTags')));
    expect(serializedKeys, isNot(contains('featIds')));
    expect(serializedKeys, isNot(contains('senses')));
    expect(serializedKeys, isNot(contains('rebuiltAt')));
  });

  test('offline expertise doubles only selected proficient skills', () async {
    const classId = 501;
    const featureId = 502;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId, selectedLevel: 1),
      ClassStepView(
        classData: ClassData(id: classId, name: 'Rogue'),
        selectedLevel: 1,
        currentLevelFeatures: [
          ClassFeatureData(
            id: featureId,
            parentClassId: classId,
            name: 'Expertise',
            level: 1,
          ),
        ],
      ),
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'class_feature',
      offlineAllKey,
      [
        ClassFeatureData(
          id: featureId,
          parentClassId: classId,
          name: 'Expertise',
          level: 1,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 503,
          referenceKey: 'expertise',
          name: 'Компетентность',
          sourceFeatureId: featureId,
          type: ChoiceType.expertise,
          selectionCount: 2,
          minimumSelectionCount: 2,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        for (final skill in [Skill.stealth, Skill.perception, Skill.athletics])
          ChoiceOptionData(
            id: 504 + skill.index,
            choiceGroupId: 503,
            optionKey: skill.name,
            name: skill.name,
            requiredExistingSkill: skill,
            grantedExpertiseSkills: [skill],
          ),
        ChoiceOptionData(
          id: 510,
          choiceGroupId: 503,
          optionKey: 'thieves_tools',
          name: 'Thieves tools',
          requiredExistingToolKey: 'thieves_tools',
          grantedExpertiseToolKeys: const ['thieves_tools'],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        background: BackgroundData(
          skillProficiencies: const [
            Skill.stealth,
            Skill.perception,
            Skill.athletics,
          ],
        ),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId, name: 'Rogue'),
            level: 1,
            isStartingClass: true,
          ),
        ],
        choices: [
          CharacterChoiceData(groupKey: 'expertise', optionKey: 'stealth'),
          CharacterChoiceData(groupKey: 'expertise', optionKey: 'perception'),
        ],
      ),
    );

    expect(
      derived.skillProficiencyLevels!
          .singleWhere((state) => state.skill == Skill.stealth)
          .level,
      CharacterSkillProficiencyLevel.expertise,
    );
    expect(derived.skillBonuses![Skill.stealth], 4);
    expect(derived.skillBonuses![Skill.perception], 4);
    expect(
      derived.skillProficiencyLevels!
          .singleWhere((state) => state.skill == Skill.athletics)
          .level,
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(derived.skillBonuses![Skill.athletics], 2);

    final partialDerived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        background: BackgroundData(
          skillProficiencies: const [
            Skill.stealth,
            Skill.perception,
            Skill.athletics,
          ],
        ),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId, name: 'Rogue'),
            level: 1,
            isStartingClass: true,
          ),
        ],
        choices: [
          CharacterChoiceData(groupKey: 'expertise', optionKey: 'stealth'),
        ],
      ),
    );
    expect(
      partialDerived.skillProficiencyLevels!
          .singleWhere((state) => state.skill == Skill.stealth)
          .level,
      CharacterSkillProficiencyLevel.expertise,
    );
    expect(
      partialDerived.skillProficiencyLevels!
          .singleWhere((state) => state.skill == Skill.perception)
          .level,
      CharacterSkillProficiencyLevel.proficient,
    );

    final toolExpertiseDerived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        background: BackgroundData(
          skillProficiencies: const [Skill.stealth],
          toolProficiencyKeys: const ['thieves_tools'],
        ),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId, name: 'Rogue'),
            level: 1,
            isStartingClass: true,
          ),
        ],
        choices: [
          CharacterChoiceData(groupKey: 'expertise', optionKey: 'stealth'),
          CharacterChoiceData(
            groupKey: 'expertise',
            optionKey: 'thieves_tools',
          ),
        ],
      ),
    );
    expect(toolExpertiseDerived.toolExpertiseKeys, contains('thieves_tools'));
  });

  test('offline restores favored enemy type and language on active feature',
      () async {
    const classId = 511;
    const featureId = 512;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId, selectedLevel: 1),
      ClassStepView(
        classData: ClassData(id: classId, name: 'Ranger'),
        selectedLevel: 1,
        currentLevelFeatures: [
          ClassFeatureData(
            id: featureId,
            parentClassId: classId,
            name: 'Избранный враг',
            level: 1,
          ),
        ],
      ),
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'class_feature',
      offlineAllKey,
      [
        ClassFeatureData(
          id: featureId,
          parentClassId: classId,
          name: 'Избранный враг',
          level: 1,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 513,
          referenceKey: 'favored_enemy',
          name: 'Избранный враг',
          sourceFeatureId: featureId,
          sortOrder: 1,
          selectionCount: 1,
          minimumSelectionCount: 1,
        ),
        ChoiceGroupData(
          id: 514,
          referenceKey: 'favored_enemy_language',
          name: 'Язык избранного врага',
          sourceFeatureId: featureId,
          sortOrder: 2,
          selectionCount: 1,
          minimumSelectionCount: 1,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
          id: 515,
          choiceGroupId: 513,
          optionKey: 'undead',
          name: 'Нежить',
        ),
        ChoiceOptionData(
          id: 516,
          choiceGroupId: 514,
          optionKey: 'undercommon',
          name: 'Подземный',
          grantedLanguages: [Language.undercommon],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId, name: 'Ranger'),
            level: 1,
            isStartingClass: true,
          ),
        ],
        choices: [
          CharacterChoiceData(groupKey: 'favored_enemy', optionKey: 'undead'),
          CharacterChoiceData(
            groupKey: 'favored_enemy_language',
            optionKey: 'undercommon',
          ),
        ],
      ),
    );

    expect(derived.languages, [Language.undercommon]);
    expect(
      derived.activeFeatures!
          .singleWhere((feature) => feature.sourceId == featureId)
          .selectedChoices,
      ['Избранный враг: Нежить', 'Язык избранного врага: Подземный'],
    );
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
          grantedArmorTraining: const [ArmorCategory.light],
          damageType: DamageType.fire,
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

    expect(
      {
        'armorTraining':
            derived.armorTraining!.map((value) => value.name).toList(),
        'resistances': derived.resistances!.map((value) => value.name).toList(),
        'toolProficiencyKeys': derived.toolProficiencyKeys,
      },
      backgroundChoiceDerivedParityContract,
    );
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
              weaponTraining: const ['martialMelee'],
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

  test('offline saving throw proficiency order follows Ability values',
      () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              savingThrowProficiencies: const [
                Ability.charisma,
                Ability.dexterity,
              ],
            ),
            isStartingClass: true,
            level: 1,
          ),
        ],
      ),
    );

    expect(derived.savingThrowProficiencies, [
      Ability.dexterity,
      Ability.charisma,
    ]);
  });

  test('offline resolve recalculates spell slots from local class levels',
      () async {
    await cache.putReferenceList(
      'spell_slot_progression',
      offlineAllKey,
      [
        SpellSlotProgressionData(
          tableKey: 'standard',
          level: 1,
          spellSlots: const {1: 2},
        ),
        SpellSlotProgressionData(
          tableKey: 'standard',
          level: 2,
          spellSlots: const {1: 3},
        ),
        SpellSlotProgressionData(
          tableKey: 'pact_magic',
          level: 3,
          spellSlots: const {2: 2},
        ),
      ],
      (value) => value.toJson(),
    );

    final resolved = await resolveOfflineCharacter(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              id: 10,
              spellcastingProgression: SpellcastingProgression.full,
            ),
            level: 2,
            isStartingClass: true,
            classOrder: 0,
          ),
          CharacterClassEntryData(
            classData: ClassData(
              id: 11,
              spellcastingProgression: SpellcastingProgression.pactMagic,
            ),
            level: 3,
            classOrder: 1,
          ),
        ],
        derived: CharacterDerivedData(
          spellSlots: const {1: 99},
          pactSlots: const {9: 99},
        ),
      ),
    );

    expect(resolved.derived?.spellSlots, const {1: 3});
    expect(resolved.derived?.pactSlots, const {2: 2});
  });

  test('offline always-prepared spells follow local class level', () async {
    await cache.putReferenceList(
      'class_spell_grant',
      offlineAllKey,
      [
        ClassSpellGrantData(
          spell: SpellData(referenceKey: 'bless', name: 'Bless'),
          sourceClass: ClassData(id: 20),
          grantedAtLevel: 3,
          alwaysPrepared: true,
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: 20),
            level: 3,
            isStartingClass: true,
          ),
        ],
        derived: CharacterDerivedData(
          alwaysPreparedSpellKeys: const ['stale_spell'],
        ),
      ),
    );

    expect(derived.alwaysPreparedSpellKeys, ['bless']);
    expect(derived.grantedSpellKeys, contains('bless'));
    expect(derived.grantedSpellKeys, isNot(contains('stale_spell')));
  });

  test('offline always-prepared feature grants use the active class level',
      () async {
    const classId = 90;
    const featureId = 91;
    final feature = ClassFeatureData(
      id: featureId,
      parentClassId: classId,
      name: 'Feature grant source',
      level: 1,
    );
    await cache.putReferenceList(
      'class_feature',
      offlineAllKey,
      [feature],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'class_spell_grant',
      offlineAllKey,
      [
        ClassSpellGrantData(
          spell: SpellData(referenceKey: 'shield', name: 'Shield'),
          sourceFeatureId: featureId,
          sourceFeature: feature,
          grantedAtLevel: 3,
          alwaysPrepared: true,
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId),
            level: 3,
            isStartingClass: true,
          ),
        ],
      ),
    );

    expect(derived.alwaysPreparedSpellKeys, ['shield']);
  });

  test('offline multiclass slot progression rounds each class down', () async {
    await cache.putReferenceList(
      'spell_slot_progression',
      offlineAllKey,
      [
        SpellSlotProgressionData(
          tableKey: 'standard',
          level: 1,
          spellSlots: const {1: 4},
        ),
        SpellSlotProgressionData(
          tableKey: 'standard',
          level: 2,
          spellSlots: const {1: 4, 2: 2},
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(
              id: 70,
              spellcastingProgression: SpellcastingProgression.half,
            ),
            level: 3,
            isStartingClass: true,
          ),
          CharacterClassEntryData(
            classData: ClassData(
              id: 71,
              spellcastingProgression: SpellcastingProgression.third,
            ),
            level: 2,
            isStartingClass: false,
          ),
        ],
      ),
    );

    expect(derived.spellSlots, const {1: 4});
  });

  test('offline racial spell grants use canonical reference keys', () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(
          features: [
            RaceFeatureData(
              id: 31,
              name: 'Gift',
              spellGrants: [
                RaceFeatureSpellGrantData(
                  featureId: 31,
                  spellId: 32,
                  spell: SpellData(
                    referenceKey: 'false_life',
                    name: 'Псевдожизнь',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    expect(derived.grantedSpellKeys, ['false_life']);
  });

  test('offline ignores noncanonical custom ability bonus keys', () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(customAbilityBonuses: const {'strength': 1, 'STR': 5}),
    );

    expect(derived.abilityScores, hasLength(Ability.values.length));
    expect(derived.abilityScores?[Ability.strength], 11);
    expect(derived.abilityScores?.keys, containsAll(Ability.values));
  });

  test('offline total level is zero without class entries', () async {
    final derived = await buildOfflineDerivedData(cache, CharacterData());

    expect(derived.totalLevel, 0);
    expect(derived.proficiencyBonus, 2);
  });

  test('offline omits hit dice for a class entry with no level', () async {
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(hitDieValue: 8),
          ),
        ],
      ),
    );

    expect(derived.hitDiceSummary, isEmpty);
  });

  test('offline applies active feature resource max effects', () async {
    const classId = 50;
    const featureId = 51;
    final feature = ClassFeatureData(
      id: featureId,
      parentClassId: classId,
      name: 'Second Wind',
      level: 1,
      resources: [
        FeatureResourceDefinitionData(
          key: 'uses',
          kind: FeatureResourceKind.uses,
          maxRule: FeatureResourceMaxRule.fixed,
          maxValue: 1,
        ),
      ],
      resourceEffects: [
        FeatureResourceEffectData(
          type: FeatureResourceEffectType.modify,
          targetResourceKey: 'uses',
          addMaxValue: 2,
        ),
      ],
    );
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId),
      ClassStepView(
        classData: ClassData(id: classId, name: 'Fighter'),
        selectedLevel: 1,
        currentLevelFeatures: [feature],
      ),
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId, name: 'Fighter'),
            level: 1,
            isStartingClass: true,
          ),
        ],
      ),
    );

    final resource = derived.activeFeatures!.single.resources!.single;
    expect((resource.key, resource.max, resource.current), ('uses', 3, 1));
  });

  test('offline equal feature override is not customized', () async {
    const classId = 60;
    const featureId = 61;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId),
      ClassStepView(
        classData: ClassData(id: classId, name: 'Rogue'),
        selectedLevel: 1,
        currentLevelFeatures: [
          ClassFeatureData(
            id: featureId,
            parentClassId: classId,
            name: 'Expertise',
            description: 'Default description',
            level: 1,
            tags: const [FeatureTag.utility],
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
            classData: ClassData(id: classId, name: 'Rogue'),
            level: 1,
            isStartingClass: true,
          ),
        ],
        featureOverrides: [
          CharacterFeatureOverrideData(
            sourceType: CharacterFeatureSourceType.classFeature,
            sourceId: featureId,
            name: 'Expertise',
            description: 'Default description',
            tags: const [FeatureTag.utility],
          ),
        ],
      ),
    );

    expect(derived.activeFeatures!.single.isCustomized, isFalse);
  });

  test('offline active feature ordering follows source then level then name',
      () async {
    const classId = 100;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId),
      ClassStepView(
        classData: ClassData(id: classId),
        selectedLevel: 1,
        currentLevelFeatures: [
          ClassFeatureData(
            id: 102,
            parentClassId: classId,
            name: 'Zulu class feature',
            level: 1,
          ),
        ],
      ),
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(
          features: [
            RaceFeatureData(id: 101, name: 'Alpha race feature', level: 1),
          ],
        ),
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId),
            level: 1,
            isStartingClass: true,
          ),
        ],
      ),
    );

    expect(
      derived.activeFeatures!.map((feature) => feature.name),
      ['Zulu class feature', 'Alpha race feature'],
    );
  });

  test('offline does not activate class features when entry level is null',
      () async {
    const classId = 110;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId, selectedLevel: 1),
      ClassStepView(
        classData: ClassData(id: classId),
        selectedLevel: 1,
        currentLevelFeatures: [
          ClassFeatureData(
            id: 111,
            parentClassId: classId,
            name: 'Level one feature',
            level: 1,
          ),
        ],
      ),
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(classData: ClassData(id: classId)),
        ],
      ),
    );

    expect(derived.activeFeatures, isEmpty);
  });

  test('offline includes selected choice damage type in resistances', () async {
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 40,
          referenceKey: 'race_resistance_choice',
          sourceRaceId: 40,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
          id: 41,
          choiceGroupId: 40,
          optionKey: 'fire',
          damageType: DamageType.fire,
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(id: 40),
        choices: [
          CharacterChoiceData(
            groupKey: 'race_resistance_choice',
            optionKey: 'fire',
          ),
        ],
      ),
    );

    expect(derived.resistances, [DamageType.fire]);
  });

  test('offline does not apply a locked race-feature choice', () async {
    await cache.putReferenceList(
      'choice_group',
      offlineAllKey,
      [
        ChoiceGroupData(
          id: 80,
          referenceKey: 'level_three_race_feature_choice',
          sourceRaceFeatureId: 81,
        ),
      ],
      (value) => value.toJson(),
    );
    await cache.putReferenceList(
      'choice_option',
      offlineAllKey,
      [
        ChoiceOptionData(
          id: 82,
          choiceGroupId: 80,
          optionKey: 'athletics',
          grantedSkills: const [Skill.athletics],
        ),
      ],
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        race: RaceData(
          id: 83,
          features: [
            RaceFeatureData(id: 81, name: 'Future trait', level: 3),
          ],
        ),
        choices: [
          CharacterChoiceData(
            groupKey: 'level_three_race_feature_choice',
            optionKey: 'athletics',
          ),
        ],
      ),
    );

    expect(
      derived.skillProficiencyLevels!
          .singleWhere(
            (state) => state.skill == Skill.athletics,
          )
          .level,
      CharacterSkillProficiencyLevel.none,
    );
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
      weaponTraining: const ['martialMelee'],
      multiclassWeaponTraining: const ['simpleMelee'],
    );
    final multiclass = ClassData(
      weaponTraining: const ['simpleRanged'],
      multiclassWeaponTraining: const ['martialRanged'],
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
              weaponTraining: const ['simpleRanged'],
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

    expect(derived.abilityScores?[Ability.strength], 12);
    expect(
      derived.skillProficiencyLevels
          ?.firstWhere((state) => state.skill == Skill.athletics)
          .level,
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(derived.skillBonuses?[Skill.athletics], 3);
    expect(derived.grantedSpellKeys, contains('false_life'));
  });
}
