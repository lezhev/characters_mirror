import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final mixed in [false, true]) {
    test(
        'short rest restores pact slots without feature resources, mixed=$mixed',
        () async {
      final character = CharacterData(
        id: 1,
        currentHp: 7,
        temporaryHp: 3,
        deathSaveSuccesses: 1,
        currentHitDice: {'d8': 0},
        currentSpellSlots: mixed ? {2: 1} : null,
        currentPactSlots: {2: 0},
        derived: CharacterDerivedData(
          spellSlots: mixed ? {2: 2} : null,
          pactSlots: {2: 2},
        ),
      );
      final repository = await _rest(character);
      expect(repository.savedCharacter?.currentPactSlots, {2: 2});
      expect(repository.savedCharacter?.currentSpellSlots,
          character.currentSpellSlots);
      expect(repository.savedCharacter?.currentHp, 7);
      expect(repository.savedCharacter?.temporaryHp, 3);
      expect(repository.savedCharacter?.deathSaveSuccesses, 1);
      expect(repository.savedCharacter?.currentHitDice, {'d8': 0});
      expect(repository.semanticType, CharacterSyncOperationType.applyRest);
      expect(repository.semanticAction?.restType, RestType.shortRest);
      expect(repository.saveCount, 1);
    });
  }

  test('short rest separates legacy counters without restoring standard slots',
      () async {
    final repository = await _rest(CharacterData(
      id: 1,
      currentSpellSlots: {2: 1},
      derived: CharacterDerivedData(spellSlots: {2: 2}, pactSlots: {2: 2}),
    ));
    expect(repository.savedCharacter?.currentPactSlots, {2: 2});
    expect(repository.savedCharacter?.currentSpellSlots, {2: 1});
    expect(repository.saveCount, 1);
  });

  for (final standard in [false, true]) {
    test(
        'short rest remains a no-op without pact slots or resources, standard=$standard',
        () async {
      final repository = await _rest(CharacterData(
        id: 1,
        currentSpellSlots: standard ? {1: 0} : null,
        derived: CharacterDerivedData(spellSlots: standard ? {1: 2} : null),
      ));
      expect(repository.saveCount, 0);
      expect(repository.character.currentSpellSlots, standard ? {1: 0} : null);
    });
  }
  test('new day resets a daily resource without restoring either slot pool',
      () async {
    final character = CharacterData(
        id: 1,
        currentSpellSlots: {1: 0},
        currentPactSlots: {2: 0},
        derived: CharacterDerivedData(spellSlots: {
          1: 2
        }, pactSlots: {
          2: 2
        }, activeFeatures: [
          CharacterFeatureViewData(
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: 1,
              resources: [
                CharacterResourceViewData(
                    key: 'daily',
                    kind: FeatureResourceKind.uses,
                    current: 0,
                    max: 1,
                    resetOn: RestType.dawn)
              ])
        ]),
        resourceStates: [
          CharacterResourceStateData(
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: 1,
              resourceKey: 'daily',
              current: 0)
        ]);
    final repository = await _rest(character, restType: RestType.dawn);
    expect(repository.savedCharacter?.currentSpellSlots, {1: 0});
    expect(repository.savedCharacter?.currentPactSlots, {2: 0});
    expect(repository.savedCharacter?.resourceStates ?? [], isEmpty);
    expect(
        repository.savedCharacter?.derived?.activeFeatures?.single.resources
            ?.single.current,
        1);
    expect(repository.semanticAction?.restType, RestType.dawn);
  });
  test(
      'short rest records a recovery opportunity without restoring daily uses or standard slots',
      () async {
    final character = CharacterData(
        id: 1,
        currentSpellSlots: {1: 0},
        derived: CharacterDerivedData(spellSlots: {
          1: 2
        }, activeFeatures: [
          CharacterFeatureViewData(
              sourceType: CharacterFeatureSourceType.classFeature,
              sourceId: 1,
              sourceClassLevel: 1,
              resources: [
                CharacterResourceViewData(
                    key: 'daily',
                    kind: FeatureResourceKind.uses,
                    current: 1,
                    max: 1,
                    resetOn: RestType.dawn)
              ],
              spellSlotRecoveryEffects: [
                FeatureResourceEffectData(
                    id: 2,
                    type: FeatureResourceEffectType.restore,
                    targetType: FeatureResourceTargetType.spellSlots,
                    activationTrigger: FeatureResourceTrigger.shortRest,
                    recoveryPolicy: SpellSlotRecoveryPolicyData(
                        mode: SpellSlotRecoveryMode.levelBudget,
                        resourceKey: 'daily',
                        levelBudgetBySourceLevel: {1: 1},
                        maximumSlotLevel: 5))
              ])
        ]));
    final repository = await _rest(character);
    expect(repository.saveCount, 1);
    expect(repository.savedCharacter?.currentSpellSlots, {1: 0});
    expect(
        repository.savedCharacter?.derived?.activeFeatures?.single.resources
            ?.single.current,
        1);
    expect(repository.semanticAction?.restType, RestType.shortRest);
  });
}

Future<_RestRepository> _rest(CharacterData character,
    {RestType restType = RestType.shortRest}) async {
  final repository = _RestRepository(character);
  final container = ProviderContainer(overrides: [
    characterRepositoryProvider.overrideWithValue(repository),
  ]);
  addTearDown(container.dispose);
  final subscription =
      container.listen(characterSheetControllerProvider(1), (_, __) {});
  addTearDown(subscription.close);
  await container.read(characterSheetControllerProvider(1).future);
  await container
      .read(characterSheetControllerProvider(1).notifier)
      .restoreResources(restType);
  final restored =
      container.read(characterSheetControllerProvider(1)).requireValue;
  expect(
      restored.currentPactSlots,
      repository.savedCharacter?.currentPactSlots ??
          character.currentPactSlots);
  return repository;
}

class _RestRepository extends CharacterRepository {
  _RestRepository(this.character);
  CharacterData character;
  CharacterData? savedCharacter;
  CharacterSyncOperationType? semanticType;
  CharacterSemanticActionData? semanticAction;
  int saveCount = 0;

  @override
  Future<CharacterData> getCharacter(int characterId) async => character;

  @override
  Future<CharacterData> saveSemanticAction({
    required CharacterData character,
    required CharacterSyncOperationType type,
    required CharacterSemanticActionData action,
  }) async {
    saveCount++;
    semanticType = type;
    semanticAction = action;
    savedCharacter = character;
    return this.character = character;
  }
}
