import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:characters_mirror_flutter/core/character_spells/character_spell_projection.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/character_semantic_sync.dart';
import 'package:characters_mirror_flutter/core/offline/character_sync_operation_replay.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';

void main() {
  late OfflineCacheDatabase cache;
  setUp(() => cache = OfflineCacheDatabase.openInMemory());
  tearDown(() => cache.close());

  test(
      'offline grants resolve canonical spells and preserve two casting abilities',
      () async {
    final spell =
        SpellData(id: 5, referenceKey: 'test_spell', name: 'Spell', level: 1);
    final wizard = ClassData(
        id: 1,
        name: 'Wizard',
        spellcastingAbilityValue: Ability.intelligence,
        spellcastingProgression: SpellcastingProgression.full,
        spellSelectionMode: ClassSpellSelectionMode.known);
    final cleric = ClassData(
        id: 2,
        name: 'Cleric',
        spellcastingAbilityValue: Ability.wisdom,
        spellcastingProgression: SpellcastingProgression.full);
    await cache.putReferenceList('spell', 'all', [spell], (s) => s.toJson());
    await cache.putReferenceList(
        'class_spell_grant',
        'all',
        [
          ClassSpellGrantData(
              sourceClassId: 2,
              spell: spell,
              grantedAtLevel: 3,
              alwaysPrepared: true)
        ],
        (g) => g.toJson());
    final character = CharacterData(classEntries: [
      CharacterClassEntryData(id: 'wizard', classData: wizard, level: 3),
      CharacterClassEntryData(id: 'cleric', classData: cleric, level: 3),
    ], spellSelections: [
      CharacterSpellSelectionData(
          spellId: spell.id,
          classDataId: 1,
          kind: CharacterSpellSelectionKind.knownSpell)
    ]);
    final derived = await buildOfflineDerivedData(cache, character);
    final resolved = derived.resolvedSpells!.single;
    expect(resolved.sources.map((s) => s.castingAbility),
        [Ability.intelligence, Ability.wisdom]);
    expect(resolved.sources.last.alwaysPrepared, true);
    expect(character.spellSelections, hasLength(1));
    final reduced = await buildOfflineDerivedData(
        cache,
        character.copyWith(classEntries: [
          character.classEntries!.first,
          character.classEntries!.last.copyWith(level: 2)
        ]));
    expect(reduced.resolvedSpells!.single.sources, hasLength(1));
  });

  test(
      'protocol maps scale and separate pact casts replay without effect mutations',
      () {
    final spell = SpellData(
        referenceKey: 'spell',
        name: 'Spell',
        level: 1,
        damageDice: '1d6',
        concentration: true,
        damageScaling: SpellScalingData(
            mode: SpellScalingMode.slotLevel, scalingBySlotLevel: {3: '3d6'}));
    final source = SpellSourceContextData(
        sourceKey: 'class:1',
        label: 'Wizard',
        castingAbility: Ability.intelligence,
        known: true,
        prepared: true,
        alwaysPrepared: false,
        granted: false,
        canUseSlots: true);
    final character = CharacterData(
        id: 1,
        currentHp: 7,
        activeConditions: [ConditionType.poisoned],
        derived: CharacterDerivedData(spellSlots: {
          1: 2,
          3: 1
        }, pactSlots: {
          3: 2
        }, resolvedSpells: [
          ResolvedCharacterSpellData(
              spellKey: 'spell', spell: spell, sources: [source])
        ]));
    final p = const SpellPresentationResolver().resolve(spell.toJson(),
        context: const SpellPresentationContext(castLevel: 3));
    expect(p.highlights.first.value, '3к6');
    final action = CharacterSemanticActionData(
        spellKey: 'spell',
        spellSourceKey: 'class:1',
        slotSource: 'pact',
        level: 3);
    final op = createCharacterSemanticOperation(
        character: character,
        localId: 1,
        serverId: 1,
        type: CharacterSyncOperationType.castSpell,
        action: action,
        changeId: 'pact-cast',
        createdAt: DateTime.utc(2026, 10, 7));
    final cast = replayCharacterSyncOperation(character, op);
    expect(cast.currentPactSlots, {3: 1});
    expect(cast.currentSpellSlots, isNull);
    expect(cast.currentHp, 7);
    expect(cast.activeConditions, [ConditionType.poisoned]);
    expect(cast.activeConcentrationSpellName, 'Spell');
    final rest = createCharacterSemanticOperation(
        character: cast,
        localId: 1,
        serverId: 1,
        type: CharacterSyncOperationType.applyRest,
        action: CharacterSemanticActionData(restType: RestType.shortRest),
        changeId: 'short-rest',
        createdAt: DateTime.utc(2026, 10, 7));
    final rested = replayCharacterSyncOperation(cast, rest);
    expect(rested.currentPactSlots, {3: 2});
    expect(rested.currentHp, 7);
    expect(rested.activeConcentrationSpellName, 'Spell');
  });

  test('source-specific attack and DC use each derived ability', () {
    final character = CharacterData(
        derived: CharacterDerivedData(
            proficiencyBonus: 3,
            abilityModifiers: {Ability.intelligence: 4, Ability.wisdom: 1}));
    final intContext = characterSpellPresentationContext(
        character,
        const SpellSourceContext(
            sourceKey: 'class:1',
            label: 'Wizard',
            castingAbility: 'intelligence'));
    final wisContext = characterSpellPresentationContext(
        character,
        const SpellSourceContext(
            sourceKey: 'class:2', label: 'Cleric', castingAbility: 'wisdom'));
    expect([intContext.attackBonus, intContext.saveDc], [7, 15]);
    expect([wisContext.attackBonus, wisContext.saveDc], [4, 12]);
  });
  test('unpreparing wizard source preserves cleric preparation', () async {
    final spell = SpellData(id: 5, referenceKey: 'spell', level: 1);
    final character = CharacterData(id: 1, preparedSpellKeys: [
      'spell'
    ], classEntries: [
      CharacterClassEntryData(
          id: 'wizard',
          classData: ClassData(
              id: 1,
              spellcastingAbilityValue: Ability.intelligence,
              spellSelectionMode: ClassSpellSelectionMode.spellbook)),
      CharacterClassEntryData(
          id: 'cleric',
          classData: ClassData(
              id: 2,
              spellcastingAbilityValue: Ability.wisdom,
              spellSelectionMode: ClassSpellSelectionMode.prepared)),
    ], spellSelections: [
      CharacterSpellSelectionData(
          spell: spell,
          classDataId: 1,
          kind: CharacterSpellSelectionKind.spellbookSpell),
      CharacterSpellSelectionData(
          spell: spell,
          classDataId: 1,
          kind: CharacterSpellSelectionKind.preparedSpell),
      CharacterSpellSelectionData(
          spell: spell,
          classDataId: 2,
          kind: CharacterSpellSelectionKind.preparedSpell),
    ]);
    final repository = _SpellRepository(character);
    final container = ProviderContainer(
        overrides: [characterRepositoryProvider.overrideWithValue(repository)]);
    addTearDown(container.dispose);
    final provider = characterSheetControllerProvider(1);
    final subscription = container.listen(provider, (_, __) {});
    addTearDown(subscription.close);
    await container.read(provider.future);
    await container
        .read(provider.notifier)
        .setSpellPrepared(spell, false, classDataId: 1);
    final sources =
        characterResolvedSpells(repository.character).single.sources;
    expect(sources.singleWhere((s) => s.classDataId == 1).prepared, false);
    expect(sources.singleWhere((s) => s.classDataId == 2).prepared, true);
  });
  test('offline replacement removes choice spells and conditional class grants',
      () async {
    final spell =
        SpellData(id: 5, referenceKey: 'choice_spell', name: 'Spell', level: 1);
    final caster =
        ClassData(id: 1, spellcastingAbilityValue: Ability.intelligence);
    final group = ChoiceGroupData(
        id: 4,
        referenceKey: 'spell_choice',
        sourceClassId: 1,
        level: 1,
        selectionCount: 1,
        minimumSelectionCount: 0,
        type: ChoiceType.custom);
    await cache.putReferenceList('spell', 'all', [spell], (s) => s.toJson());
    await cache.putReferenceList(
        'choice_group', 'all', [group], (s) => s.toJson());
    await cache.putReferenceList(
        'choice_option',
        'all',
        [
          ChoiceOptionData(
              id: 10,
              choiceGroupId: 4,
              optionKey: 'magic',
              grantedSpellKeys: ['choice_spell']),
          ChoiceOptionData(id: 11, choiceGroupId: 4, optionKey: 'other'),
        ],
        (s) => s.toJson());
    await cache.putReferenceList(
        'class_spell_grant',
        'all',
        [
          ClassSpellGrantData(
              sourceClassId: 1,
              choiceOptionId: 10,
              spell: spell,
              grantedAtLevel: 1),
        ],
        (s) => s.toJson());
    final character = CharacterData(classEntries: [
      CharacterClassEntryData(classData: caster, level: 3)
    ], choices: [
      CharacterChoiceData(groupKey: 'spell_choice', optionKey: 'magic')
    ]);
    final chosen = await buildOfflineDerivedData(cache, character);
    expect(chosen.resolvedSpells!.single.sources.single.castingAbility,
        Ability.intelligence);
    final replaced = await buildOfflineDerivedData(
        cache,
        character.copyWith(choices: [
          CharacterChoiceData(groupKey: 'spell_choice', optionKey: 'other')
        ]));
    expect(replaced.resolvedSpells, isEmpty);
    expect(replaced.grantedSpellKeys, isEmpty);
  });
  test('offline race grant checks grant level independently of feature level',
      () async {
    final spell =
        SpellData(id: 5, referenceKey: 'race_spell', name: 'Spell', level: 1);
    final character = CharacterData(
        race: RaceData(features: [
          RaceFeatureData(id: 7, level: 1, spellGrants: [
            RaceFeatureSpellGrantData(
                featureId: 7,
                spellId: 5,
                spell: spell,
                grantedAtLevel: 3,
                castingAbility: Ability.charisma,
                castAtSpellLevel: 2,
                canAlsoCastWithSpellSlots: false)
          ])
        ]),
        classEntries: [CharacterClassEntryData(level: 2)]);
    final early = await buildOfflineDerivedData(cache, character);
    expect(early.resolvedSpells, isEmpty);
    expect(early.grantedSpellKeys, isEmpty);
    final granted = await buildOfflineDerivedData(cache,
        character.copyWith(classEntries: [CharacterClassEntryData(level: 3)]));
    expect(granted.resolvedSpells!.single.sources.single.castingAbility,
        Ability.charisma);
    expect(granted.resolvedSpells!.single.sources.single.canUseSlots, false);
  });
}

class _SpellRepository extends CharacterRepository {
  _SpellRepository(this.character);
  CharacterData character;
  @override
  Future<CharacterData> getCharacter(int id) async => character;
  @override
  Future<OfflineCharacterRecord?> getOfflineRecord(int id) async => null;
  @override
  Future<CharacterData> saveCharacter(CharacterData value) async =>
      character = value;
}
