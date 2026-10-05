import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_server/src/validation/validation_limits.dart';
import 'package:characters_mirror_server/src/validation/validation_exception.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import '../../../test_fixtures/derived_parity_contract.dart';
import 'test_tools/serverpod_test_tools.dart';

part 'character_data_endpoint_test/character_data_endpoint_scenarios.dart';
part 'character_data_endpoint_test/character_data_creation_scenarios.dart';
part 'character_data_endpoint_test/character_data_proficiency_scenarios.dart';
part 'character_data_endpoint_test/character_data_spell_slot_scenarios.dart';
part 'character_data_endpoint_test/feature_modifier_scenarios.dart';

void main() {
  _registerCharacterDataEndpointTests();
}

Future<ItemData> _ensureItemData(
  Session session, {
  required String referenceKey,
  required String name,
}) async {
  final existing = await ItemData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (existing.isNotEmpty) return existing.first;
  return ItemData.db.insertRow(
    session,
    ItemData(referenceKey: referenceKey, name: name),
  );
}

Future<ToolData> _ensureToolData(
  Session session, {
  required String referenceKey,
  required String name,
  ToolCategory? category,
}) async {
  final existing = await ToolData.db.find(
    session,
    where: (t) => t.referenceKey.equals(referenceKey),
    limit: 1,
  );
  if (existing.isNotEmpty) return existing.first;
  return ToolData.db.insertRow(
    session,
    ToolData(referenceKey: referenceKey, name: name, category: category),
  );
}

class _CreationFixture {
  const _CreationFixture({
    required this.classData,
    required this.classFeature,
    required this.subclass,
    required this.subclassFeature,
    required this.background,
    required this.race,
    required this.raceFeature,
    required this.subrace,
    required this.subraceFeature,
    required this.raceChoiceGroup,
    required this.feat,
    required this.lightSpell,
    required this.magicMissileSpell,
    required this.equipment,
  });

  final ClassData classData;
  final ClassFeatureData classFeature;
  final SubclassData subclass;
  final SubclassFeatureData subclassFeature;
  final BackgroundData background;
  final RaceData race;
  final RaceFeatureData raceFeature;
  final SubraceData subrace;
  final RaceFeatureData subraceFeature;
  final ChoiceGroupData raceChoiceGroup;
  final FeatData feat;
  final SpellData lightSpell;
  final SpellData magicMissileSpell;
  final _StartingEquipmentFixture equipment;
}

class _StartingEquipmentFixture {
  const _StartingEquipmentFixture({
    required this.backgroundItemPick,
    required this.backgroundHolySymbolPack,
    required this.classFixedPack,
    required this.classFixedAnySimple,
    required this.classWeaponPick,
    required this.classSimpleWeaponOption,
    required this.classWeaponAnySimple,
    required this.classFocusPick,
    required this.classFocusOption,
    required this.classFocusAnyFocus,
  });

  final StartingEquipmentEntryData backgroundItemPick;
  final StartingEquipmentEntryData backgroundHolySymbolPack;
  final StartingEquipmentEntryData classFixedPack;
  final StartingEquipmentEntryData classFixedAnySimple;
  final StartingEquipmentEntryData classWeaponPick;
  final StartingEquipmentEntryData classSimpleWeaponOption;
  final StartingEquipmentEntryData classWeaponAnySimple;
  final StartingEquipmentEntryData classFocusPick;
  final StartingEquipmentEntryData classFocusOption;
  final StartingEquipmentEntryData classFocusAnyFocus;
}

Future<_StartingEquipmentFixture> _seedStartingEquipmentEntries(
  TestSessionBuilder sessionBuilder, {
  required ClassData classData,
  required BackgroundData background,
}) async {
  final session = sessionBuilder.build();
  try {
    Future<StartingEquipmentEntryData> insert(
      StartingEquipmentEntryData entry,
    ) {
      return StartingEquipmentEntryData.db.insertRow(session, entry);
    }

    final backgroundItemPick = await insert(
      StartingEquipmentEntryData(
        sourceBackgroundId: background.id!,
        kind: StartingEquipmentEntryKind.choiceGroup,
        orderIndex: 0,
        selectionCount: 1,
      ),
    );
    final backgroundHolySymbolPack = await insert(
      StartingEquipmentEntryData(
        sourceBackgroundId: background.id!,
        parentEntryId: backgroundItemPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 0,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceBackgroundId: background.id!,
        parentEntryId: backgroundHolySymbolPack.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.item,
        referenceKey: 'holy_symbol',
        quantity: 1,
      ),
    );

    final classFixedPack = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.fixedLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.armor,
        referenceKey: 'leather_armor',
        quantity: 1,
      ),
    );
    final classFixedAnySimple = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.fixedLine,
        orderIndex: 1,
        lineKind: StartingEquipmentLineKind.weaponCategory,
        quantity: 1,
        allowedWeaponCategories: const [
          WeaponCategory.simpleMelee,
          WeaponCategory.simpleRanged,
        ],
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.fixedLine,
        orderIndex: 2,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.weapon,
        referenceKey: 'dagger',
        quantity: 2,
      ),
    );

    final classWeaponPick = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.choiceGroup,
        orderIndex: 3,
        selectionCount: 1,
      ),
    );
    final crossbowPack = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classWeaponPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 0,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: crossbowPack.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.weapon,
        referenceKey: 'light_crossbow',
        quantity: 1,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: crossbowPack.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 1,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.item,
        referenceKey: 'bolts',
        quantity: 20,
      ),
    );
    final classSimpleWeaponOption = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classWeaponPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 1,
      ),
    );
    final classWeaponAnySimple = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classSimpleWeaponOption.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.weaponCategory,
        quantity: 1,
        allowedWeaponCategories: const [
          WeaponCategory.simpleMelee,
          WeaponCategory.simpleRanged,
        ],
      ),
    );

    final classFocusPick = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        kind: StartingEquipmentEntryKind.choiceGroup,
        orderIndex: 4,
        selectionCount: 1,
      ),
    );
    final componentPouchOption = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classFocusPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 0,
      ),
    );
    await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: componentPouchOption.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.catalogRef,
        catalogType: EquipmentCatalogType.item,
        referenceKey: 'component_pouch',
        quantity: 1,
      ),
    );
    final classFocusOption = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classFocusPick.id,
        kind: StartingEquipmentEntryKind.choiceOption,
        orderIndex: 1,
      ),
    );
    final classFocusAnyFocus = await insert(
      StartingEquipmentEntryData(
        sourceClassId: classData.id!,
        parentEntryId: classFocusOption.id,
        kind: StartingEquipmentEntryKind.optionLine,
        orderIndex: 0,
        lineKind: StartingEquipmentLineKind.itemCategory,
        catalogType: EquipmentCatalogType.item,
        quantity: 1,
        allowedItemCategories: const ['Focus'],
      ),
    );

    return _StartingEquipmentFixture(
      backgroundItemPick: backgroundItemPick,
      backgroundHolySymbolPack: backgroundHolySymbolPack,
      classFixedPack: classFixedPack,
      classFixedAnySimple: classFixedAnySimple,
      classWeaponPick: classWeaponPick,
      classSimpleWeaponOption: classSimpleWeaponOption,
      classWeaponAnySimple: classWeaponAnySimple,
      classFocusPick: classFocusPick,
      classFocusOption: classFocusOption,
      classFocusAnyFocus: classFocusAnyFocus,
    );
  } finally {
    await session.close();
  }
}

class _MixedAbilityBonusRaceFixture {
  const _MixedAbilityBonusRaceFixture({
    required this.race,
    required this.anyBonusChoiceGroup,
  });

  final RaceData race;
  final ChoiceGroupData anyBonusChoiceGroup;

  String get anyBonusGroupKey => anyBonusChoiceGroup.referenceKey;
}

Future<_MixedAbilityBonusRaceFixture> _seedMixedAbilityBonusRace(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
) async {
  final race = await endpoints.raceData.upsert(
    sessionBuilder,
    RaceData(
      name: 'Fixture Charisma Plus Any Race',
      charismaBonus: 2,
    ),
  );
  final feature = await endpoints.raceFeature.upsert(
    sessionBuilder,
    RaceFeatureData(
      raceId: race.id,
      name: 'Flexible Aptitude',
      level: 1,
    ),
  );
  final choiceGroup = await _insertGenericChoiceGroup(
    sessionBuilder,
    ChoiceGroupData(
      referenceKey: 'fixture_any_race_ability_plus_one',
      sourceRaceFeatureId: feature.id,
      type: ChoiceType.abilityIncrease,
      selectionCount: 1,
      allowDuplicates: false,
      description: 'Choose one ability score to increase by 1.',
    ),
  );

  for (final ability in Ability.values) {
    await _insertGenericChoiceOption(
      sessionBuilder,
      ChoiceOptionData(
        choiceGroupId: choiceGroup.id!,
        optionKey: ability.name,
        name: ability.name,
        grantedAbilityBonuses: {ability.name: 1},
      ),
    );
  }

  final modeGroup = await _insertGenericChoiceGroup(
    sessionBuilder,
    ChoiceGroupData(
      referenceKey: 'race_bonus_mode',
      sourceRaceId: race.id,
      type: ChoiceType.abilityIncrease,
      selectionCount: 1,
    ),
  );
  await _insertGenericChoiceOption(
    sessionBuilder,
    ChoiceOptionData(
      choiceGroupId: modeGroup.id!,
      optionKey: 'flexible_plus_two_one',
      name: 'Flexible +2/+1',
    ),
  );

  for (final (groupKey, bonus) in const [
    ('race_flexible_bonus_plus2', 2),
    ('race_flexible_bonus_plus1', 1),
  ]) {
    final group = await _insertGenericChoiceGroup(
      sessionBuilder,
      ChoiceGroupData(
        referenceKey: groupKey,
        sourceRaceId: race.id,
        type: ChoiceType.abilityIncrease,
        selectionCount: 1,
      ),
    );
    for (final ability in Ability.values) {
      await _insertGenericChoiceOption(
        sessionBuilder,
        ChoiceOptionData(
          choiceGroupId: group.id!,
          optionKey: ability.name,
          name: ability.name,
          grantedAbilityBonuses: {ability.name: bonus},
        ),
      );
    }
  }

  final hydratedRace = await endpoints.raceData.getStepView(
    sessionBuilder,
    race.id!,
  );

  return _MixedAbilityBonusRaceFixture(
    race: hydratedRace.race!,
    anyBonusChoiceGroup: choiceGroup,
  );
}

Future<ChoiceGroupData> _insertGenericChoiceGroup(
  TestSessionBuilder sessionBuilder,
  ChoiceGroupData group,
) async {
  final session = sessionBuilder.build();
  try {
    return await ChoiceGroupData.db.insertRow(session, group);
  } finally {
    await session.close();
  }
}

Future<ChoiceOptionData> _insertGenericChoiceOption(
  TestSessionBuilder sessionBuilder,
  ChoiceOptionData option,
) async {
  final session = sessionBuilder.build();
  try {
    return await ChoiceOptionData.db.insertRow(session, option);
  } finally {
    await session.close();
  }
}

Future<_CreationFixture> _seedCreationFixture(
  TestSessionBuilder sessionBuilder,
  TestEndpoints endpoints,
) async {
  final classData = await endpoints.classData.upsert(
    sessionBuilder,
    ClassData(
      name: 'Fixture Fighter',
      hitDieValue: 10,
      primaryAbilities: const [Ability.strength],
      savingThrowProficiencies: const [
        Ability.strength,
        Ability.constitution,
      ],
      armorTraining: const [
        ArmorCategory.light,
        ArmorCategory.medium,
      ],
      weaponTraining: const [
        'simpleMelee',
        'martialMelee',
      ],
      availableSkills: const [
        Skill.acrobatics,
        Skill.athletics,
        Skill.perception,
      ],
      skillCount: 2,
      subclassChoiceLevel: 1,
      spellcastingProgression: SpellcastingProgression.full,
      imageURL: 'fighter',
    ),
  );
  await endpoints.classLevelData.upsert(
    sessionBuilder,
    ClassLevelData(
      classDataId: classData.id!,
      level: 1,
      knownCantrips: 1,
      knownSpells: 1,
    ),
  );
  await endpoints.spellSlotProgressionData.upsert(
    sessionBuilder,
    SpellSlotProgressionData(
      tableKey: 'standard',
      level: 1,
      spellSlots: const {1: 2},
    ),
  );
  final lightSpell = await endpoints.spellData.add(
    sessionBuilder,
    SpellData(
      referenceKey: 'light',
      name: 'Light',
      level: 0,
      schoolValue: SpellSchool.evocation,
    ),
  );
  final magicMissileSpell = await endpoints.spellData.add(
    sessionBuilder,
    SpellData(
      referenceKey: 'magic_missile',
      name: 'Magic Missile',
      level: 1,
      schoolValue: SpellSchool.evocation,
    ),
  );
  await endpoints.spellData.add(
    sessionBuilder,
    SpellData(
      referenceKey: 'shield',
      name: 'Shield',
      level: 1,
      schoolValue: SpellSchool.abjuration,
    ),
  );
  final session = sessionBuilder.build();
  try {
    await SpellData.db.updateRow(
      session,
      lightSpell.copyWith(availableForClassIds: [classData.id!]),
    );
    await SpellData.db.updateRow(
      session,
      magicMissileSpell.copyWith(availableForClassIds: [classData.id!]),
    );
  } finally {
    await session.close();
  }

  final classFeature = await endpoints.classFeatureData.upsert(
    sessionBuilder,
    ClassFeatureData(
      parentClassId: classData.id!,
      name: 'Fighting Style',
      level: 1,
      tags: const [FeatureTag.combat],
    ),
  );

  final subclass = await endpoints.subclassData.upsert(
    sessionBuilder,
    SubclassData(
      parentClassId: classData.id!,
      subclassName: 'Fixture Archetype',
      name: 'Fixture Champion',
      levelRequired: 1,
      description: 'Subclass used in integration tests.',
    ),
  );

  final subclassFeature = await endpoints.subclassFeatureData.upsert(
    sessionBuilder,
    SubclassFeatureData(
      parentSubclassId: subclass.id!,
      name: 'Fixture Specialty',
      level: 1,
      tags: const [FeatureTag.utility],
    ),
  );

  final subclassToolGroup = await _insertGenericChoiceGroup(
    sessionBuilder,
    ChoiceGroupData(
      referenceKey: 'fixture_subclass_tool_pick',
      name: 'Subclass tools',
      sourceSubclassFeatureId: subclassFeature.id,
      type: ChoiceType.tool,
      selectionCount: 1,
      allowDuplicates: false,
      exclusiveKey: 'subclass_tool_pick',
    ),
  );
  await _insertGenericChoiceOption(
    sessionBuilder,
    ChoiceOptionData(
      choiceGroupId: subclassToolGroup.id!,
      optionKey: 'smith_tools',
      name: 'Smith tools',
      grantedToolKeys: const ['smith_tools'],
    ),
  );
  final toolSession = sessionBuilder.build();
  try {
    await _ensureToolData(
      toolSession,
      referenceKey: 'smith_tools',
      name: 'Smith’s tools',
      category: ToolCategory.artisan,
    );
  } finally {
    await toolSession.close();
  }

  final background = await endpoints.backgroundData.upsert(
    sessionBuilder,
    BackgroundData(
      name: 'Fixture Acolyte',
      skillProficiencies: const [Skill.insight, Skill.religion],
      availableSkills: const [Skill.survival, Skill.history],
      skillCount: 1,
      feature: 'Shelter of the Faithful',
    ),
  );

  final backgroundLanguageGroup = await _insertGenericChoiceGroup(
    sessionBuilder,
    ChoiceGroupData(
      referenceKey: 'background_language_pick',
      name: 'Background language',
      sourceBackgroundId: background.id,
      type: ChoiceType.language,
      selectionCount: 1,
      allowDuplicates: false,
      exclusiveKey: 'background_language_pick',
    ),
  );
  await _insertGenericChoiceOption(
    sessionBuilder,
    ChoiceOptionData(
      choiceGroupId: backgroundLanguageGroup.id!,
      optionKey: 'celestial_language',
      name: 'Celestial',
      grantedLanguages: const [Language.celestial],
    ),
  );

  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'holy_symbol',
      name: 'Holy Symbol',
      category: 'Gear',
    ),
  );
  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'crystal_focus',
      name: 'Crystal Focus',
      category: 'Focus',
    ),
  );
  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'component_pouch',
      name: 'Component Pouch',
      category: 'Gear',
    ),
  );
  await endpoints.itemData.upsert(
    sessionBuilder,
    ItemData(
      referenceKey: 'bolts',
      name: 'Crossbow Bolts',
      category: 'Ammunition',
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'club',
      name: 'Club',
      category: WeaponCategory.simpleMelee,
      damage: '1d4',
      damageType: DamageType.bludgeoning,
      properties: const [WeaponProperty.light],
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'dagger',
      name: 'Dagger',
      category: WeaponCategory.simpleMelee,
      damage: '1d4',
      damageType: DamageType.piercing,
      properties: const [
        WeaponProperty.finesse,
        WeaponProperty.light,
        WeaponProperty.thrown,
      ],
    ),
  );
  await endpoints.weaponData.upsert(
    sessionBuilder,
    WeaponData(
      referenceKey: 'light_crossbow',
      name: 'Light Crossbow',
      category: WeaponCategory.simpleRanged,
      damage: '1d8',
      damageType: DamageType.piercing,
      properties: const [
        WeaponProperty.ammunition,
        WeaponProperty.loading,
        WeaponProperty.twoHanded,
      ],
    ),
  );
  await endpoints.armorData.upsert(
    sessionBuilder,
    ArmorData(
      referenceKey: 'leather_armor',
      name: 'Leather Armor',
      categoryValue: ArmorCategory.light,
    ),
  );

  final equipment = await _seedStartingEquipmentEntries(
    sessionBuilder,
    classData: classData,
    background: background,
  );

  final feat = await endpoints.featData.upsert(
    sessionBuilder,
    FeatData(
      name: 'Skilled',
      tags: const [FeatureTag.utility],
    ),
  );

  final race = await endpoints.raceData.upsert(
    sessionBuilder,
    RaceData(
      name: 'Fixture Variant Human',
      size: CreatureSize.medium,
      speed: 30,
      languages: const [Language.common],
      visionType: SenseType.darkvision,
      skillProficiencies: const [Skill.perception],
      armorProficiencies: const [ArmorCategory.heavy],
      weaponProficiencyKeys: const [],
    ),
  );

  final raceFeature = await endpoints.raceFeature.upsert(
    sessionBuilder,
    RaceFeatureData(
      raceId: race.id,
      name: 'Variant Human Bonus Feat',
      level: 1,
    ),
  );

  final subrace = await endpoints.subraceData.upsert(
    sessionBuilder,
    SubraceData(
      parentRaceId: race.id!,
      name: 'Fixture Nightfolk',
      description: 'Subrace used in integration tests.',
      armorProficiencies: const [ArmorCategory.shield],
    ),
  );

  final subraceFeature = await endpoints.raceFeature.upsert(
    sessionBuilder,
    RaceFeatureData(
      subraceId: subrace.id,
      name: 'Shadow Sight',
      description: 'See through darkness more clearly.',
      level: 1,
      tags: const [FeatureTag.utility],
    ),
  );

  final raceChoiceGroup = await _insertGenericChoiceGroup(
    sessionBuilder,
    ChoiceGroupData(
      referenceKey: 'fixture_race_feature_option',
      sourceRaceFeatureId: raceFeature.id,
      type: ChoiceType.featureOption,
      selectionCount: 1,
      allowDuplicates: false,
      description: 'Choose one feat.',
    ),
  );

  await _insertGenericChoiceOption(
    sessionBuilder,
    ChoiceOptionData(
      choiceGroupId: raceChoiceGroup.id!,
      optionKey: 'skilled_feat',
      name: 'Skilled',
      grantedFeatureTags: const [FeatureTag.exploration],
    ),
  );

  final hydratedRace = await endpoints.raceData.getStepView(
    sessionBuilder,
    race.id!,
  );

  return _CreationFixture(
    classData: classData,
    classFeature: classFeature,
    subclass: subclass,
    subclassFeature: subclassFeature,
    background: background,
    race: hydratedRace.race!,
    raceFeature: raceFeature,
    subrace: subrace,
    subraceFeature: subraceFeature,
    raceChoiceGroup: raceChoiceGroup,
    feat: feat,
    lightSpell: lightSpell,
    magicMissileSpell: magicMissileSpell,
    equipment: equipment,
  );
}
