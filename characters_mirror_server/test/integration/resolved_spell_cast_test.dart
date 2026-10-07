import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_server/src/rate_limiting/character_save_rate_limiter.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Resolved spell casts', (sessionBuilder, endpoints) {
    setUp(CharacterSaveRateLimiter.resetForTests);
    final owner = sessionBuilder.copyWith(
        authentication:
            AuthenticationOverride.authenticationInfo(9401, <Scope>{}));

    Future<(CharacterData, SpellData, ClassData)> fixture(
        {bool twoSources = false}) async {
      final wizard = await endpoints.classData.upsert(
          sessionBuilder,
          ClassData(
              name: 'Pipeline Wizard',
              hitDieValue: 6,
              spellcastingProgression: SpellcastingProgression.full,
              spellcastingAbilityValue: Ability.intelligence,
              spellSelectionMode: ClassSpellSelectionMode.known));
      final secondary = await endpoints.classData.upsert(
          sessionBuilder,
          ClassData(
              name: twoSources ? 'Pipeline Cleric' : 'Pipeline Warlock',
              hitDieValue: 8,
              spellcastingProgression: twoSources
                  ? SpellcastingProgression.full
                  : SpellcastingProgression.pactMagic,
              spellcastingAbilityValue:
                  twoSources ? Ability.wisdom : Ability.charisma));
      final spell = await endpoints.spellData.upsert(
          sessionBuilder,
          SpellData(
              referenceKey: 'pipeline_spell',
              name: 'Pipeline Spell',
              level: 1,
              description: r'Правила.\n\nПолное описание.',
              concentration: true,
              isHealing: true,
              healingDice: '1d8'));
      await endpoints.spellSlotProgressionData.upsert(
          sessionBuilder,
          SpellSlotProgressionData(
              tableKey: 'standard',
              level: twoSources ? 10 : 5,
              spellSlots: {1: 2, 3: 1}));
      await endpoints.spellSlotProgressionData.upsert(
          sessionBuilder,
          SpellSlotProgressionData(
              tableKey: 'pact_magic', level: 5, spellSlots: {3: 2}));
      final db = sessionBuilder.build();
      try {
        await ClassSpellGrantData.db.insertRow(
            db,
            ClassSpellGrantData(
                spellId: spell.id,
                sourceClassId: wizard.id,
                grantedAtLevel: 3,
                alwaysPrepared: true));
        if (twoSources) {
          await ClassSpellGrantData.db.insertRow(
              db,
              ClassSpellGrantData(
                  spellId: spell.id,
                  sourceClassId: secondary.id,
                  grantedAtLevel: 3,
                  alwaysPrepared: true));
        }
      } finally {
        await db.close();
      }
      final character = await endpoints.characterData.saveCharacter(
          owner,
          CharacterData(
              name: 'Pipeline Character',
              currentHp: 7,
              activeConditions: [
                ConditionType.poisoned
              ],
              baseAbilityScores: {
                'intelligence': 18,
                'wisdom': 12,
                'constitution': 10
              },
              classEntries: [
                CharacterClassEntryData(
                    id: 'wizard',
                    classData: wizard,
                    level: 5,
                    classOrder: 0,
                    isStartingClass: true),
                CharacterClassEntryData(
                    id: 'secondary',
                    classData: secondary,
                    level: 5,
                    classOrder: 1),
              ]));
      return (character, spell, wizard);
    }

    Future<CharacterSyncResponse> sync(
        CharacterData c, CharacterSemanticActionData action, String id,
        {CharacterSyncOperationType type =
            CharacterSyncOperationType.castSpell}) {
      final targets = [
        ...spellSlotActionTargetKeys(c.toJson(), action.toJson()),
        if (spellCastStartsConcentration(c.toJson(), action.toJson()))
          'field:activeConcentrationSpellName',
      ];
      return endpoints.characterData.syncCharacters(
          owner,
          CharacterSyncRequest(syncProtocolVersion: 4, operations: [
            CharacterSyncOperationData(
                id: id,
                characterId: c.id,
                localCharacterId: c.id,
                type: type,
                targetType: CharacterSyncTargetType.field,
                baseCharacterRevision: c.version,
                value: CharacterSyncValueData(
                    semanticActionValue: action.copyWith(baseBarrierTokens: {
                  for (final t in targets)
                    t: c.syncBarrierTokens?[t] ??
                        'revision:${c.syncTargetRevisions?[t] ?? 0}',
                })),
                createdAt: DateTime.utc(2026, 10, 7))
          ]));
    }

    test('grant-only spell is one row with both canonical casting sources',
        () async {
      final (character, _, _) = await fixture(twoSources: true);
      expect(character.spellSelections ?? [], isEmpty);
      final row = character.derived!.resolvedSpells!.single;
      expect(row.sources.map((s) => s.castingAbility),
          [Ability.intelligence, Ability.wisdom]);
      expect(row.sources.every((s) => s.alwaysPrepared && s.granted), true);
      final lower = await endpoints.characterData.saveCharacter(
          owner,
          character.copyWith(classEntries: [
            for (final e in character.classEntries!) e.copyWith(level: 2),
          ]));
      expect(lower.derived!.resolvedSpells, isEmpty);
    });

    test(
        'standard upcast and pact cast spend distinct resources without healing',
        () async {
      final (base, spell, wizard) = await fixture();
      CharacterSemanticActionData action(String pool, int level) =>
          CharacterSemanticActionData(
              spellKey: spell.referenceKey,
              spellSourceKey: 'class:${wizard.id}',
              slotSource: pool,
              level: level,
              startsConcentration: false,
              spellName: 'Client-provided name');
      final first =
          await sync(base, action('standard', 3), 'pipeline-standard');
      expect(first.rejectedChanges ?? [], isEmpty);
      final afterStandard =
          await endpoints.characterData.getCharacter(owner, base.id!);
      expect(afterStandard.currentSpellSlots, {3: 0});
      expect(afterStandard.currentPactSlots, {3: 2});
      expect(afterStandard.activeConcentrationSpellName, spell.name);
      final second =
          await sync(afterStandard, action('pact', 3), 'pipeline-pact');
      expect(second.rejectedChanges ?? [], isEmpty);
      final cast = await endpoints.characterData.getCharacter(owner, base.id!);
      expect(cast.currentSpellSlots, {3: 0});
      expect(cast.currentPactSlots, {3: 1});
      expect(cast.currentHp, base.currentHp);
      expect(cast.activeConditions, base.activeConditions);
      final invalid =
          await sync(cast, action('standard', 2), 'pipeline-invalid');
      expect(invalid.rejectedChanges!.single.reason, 'invalid_cast');
      final unavailable = await sync(
          cast,
          action('pact', 3).copyWith(spellSourceKey: 'class:unknown'),
          'pipeline-source');
      expect(unavailable.rejectedChanges!.single.reason, 'invalid_cast');
      final persisted =
          await endpoints.characterData.getCharacter(owner, base.id!);
      expect(persisted.currentPactSlots, {3: 1});
      expect(persisted.currentHp, base.currentHp);
    });

    test('selection and grant deduplicate without persisting a synthetic grant',
        () async {
      final (base, spell, wizard) = await fixture();
      final saved = await endpoints.characterData.saveCharacter(
          owner,
          base.copyWith(spellSelections: [
            CharacterSpellSelectionData(
                spellId: spell.id,
                classDataId: wizard.id,
                kind: CharacterSpellSelectionKind.knownSpell),
          ]));
      expect(saved.spellSelections, hasLength(1));
      expect(saved.derived!.resolvedSpells, hasLength(1));
      expect(saved.derived!.resolvedSpells!.single.sources, hasLength(1));
      expect(
          saved.derived!.resolvedSpells!.single.sources.single.granted, true);
    });
    test(
        'racial grant respects its own level and ability without free-cast automation',
        () async {
      final (base, spell, _) = await fixture();
      final db = sessionBuilder.build();
      late RaceData race;
      try {
        race = await RaceData.db.insertRow(db, RaceData(name: 'Pipeline Race'));
        final feature = await RaceFeatureData.db.insertRow(
            db, RaceFeatureData(raceId: race.id, name: 'Race Spell', level: 1));
        await RaceFeatureSpellGrantData.db.insertRow(
            db,
            RaceFeatureSpellGrantData(
                featureId: feature.id!,
                spellId: spell.id!,
                grantedAtLevel: 3,
                castingAbility: Ability.charisma,
                freeCastsFormula: '1',
                freeCastsPerRest: RestType.longRest,
                castAtSpellLevel: 2,
                canAlsoCastWithSpellSlots: false));
      } finally {
        await db.close();
      }
      final early = await endpoints.characterData.saveCharacter(
          owner,
          base.copyWith(
              race: race,
              classEntries: [base.classEntries!.first.copyWith(level: 2)]));
      expect(early.derived!.resolvedSpells, isEmpty);
      final granted = await endpoints.characterData.saveCharacter(
          owner,
          early.copyWith(
              classEntries: [early.classEntries!.single.copyWith(level: 3)]));
      final row = granted.derived!.resolvedSpells!.single;
      final racial = row.sources
          .singleWhere((s) => s.sourceKey.startsWith('raceFeature:'));
      expect(racial.castingAbility, Ability.charisma);
      expect(racial.canUseSlots, false);
      expect(racial.castAtSpellLevel, 2);
      expect(racial.freeCastsFormula, '1');
    });
  });
}
