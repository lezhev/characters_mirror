import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/hit_points_calculator.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/helpers/fight_page_formatters.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/combat_stats_row.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/fight/widgets/hit_points_calculator_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hit point calculator logic', () {
    test('damage spends temporary hp before current hp', () {
      final result = applyHitPointChange(
        totals: const HitPointTotals(
          currentHp: 10,
          maxHp: 20,
          temporaryHp: 5,
        ),
        value: 7,
        action: HitPointAction.damage,
      );

      expect(result.currentHp, 8);
      expect(result.temporaryHp, 0);
    });

    test('healing is capped at maximum hp', () {
      final result = applyHitPointChange(
        totals: const HitPointTotals(
          currentHp: 18,
          maxHp: 20,
          temporaryHp: 0,
        ),
        value: 5,
        action: HitPointAction.heal,
      );

      expect(result.currentHp, 20);
    });

    test('temporary hp are added', () {
      final result = applyHitPointChange(
        totals: const HitPointTotals(
          currentHp: 10,
          maxHp: 20,
          temporaryHp: 2,
        ),
        value: 3,
        action: HitPointAction.temporary,
      );

      expect(result.temporaryHp, 5);
    });

    test('full current hp and zero temporary hp are stored as null', () {
      final result = normalizeHitPointsForSave(
        currentHp: 20,
        maxHp: 20,
        temporaryHp: 0,
      );

      expect(result.currentHp, isNull);
      expect(result.temporaryHp, isNull);
    });

    test('invalid expressions do not produce values', () {
      expect(evaluateHitPointExpression(''), isNull);
      expect(evaluateHitPointExpression('4+'), isNull);
      expect(evaluateHitPointExpression('-4'), isNull);
      expect(evaluateHitPointExpression('10-4+2'), 8);
    });

    test('death saves normalize to nullable 0..3 values', () {
      expect(normalizeDeathSaveCount(-1), 0);
      expect(normalizeDeathSaveCount(4), 3);
      expect(normalizeDeathSaveCountForSave(0), isNull);
      expect(normalizeDeathSaveCountForSave(2), 2);
    });

    test('max hp uses per-level gains and hp bonuses', () {
      final character = protocol.CharacterData(
        hpPerLevelBonus: 1,
        hpFlatBonus: 2,
        derived: protocol.CharacterDerivedData(
          abilityModifiers: const {'constitution': 2},
        ),
        classEntries: [
          protocol.CharacterClassEntryData(
            classData: protocol.ClassData(hitDieValue: 10),
            level: 3,
            classOrder: 0,
            hpRolledValues: const [8, 7, 6],
          ),
        ],
      );

      expect(calculateMaxHpForCharacter(character), 32);
    });

    test('hit dice default current to max and normalize overrides', () {
      final character = protocol.CharacterData(
        currentHitDice: const {'d10': 5},
        hitDiceMaxOverrides: const {'d10': 4},
        derived: protocol.CharacterDerivedData(
          hitDiceSummary: const {'d10': 3},
        ),
      );

      expect(effectiveHitDiceMaxFromCharacter(character), const {'d10': 4});
      expect(
        effectiveCurrentHitDice(
          character.currentHitDice,
          effectiveHitDiceMaxFromCharacter(character),
        ),
        const {'d10': 4},
      );
      expect(
        normalizeCurrentHitDiceForSave(const {'d10': 4}, const {'d10': 4}),
        isNull,
      );
    });
  });

  test('hp label hides zero temporary hp', () {
    expect(
      formatHpLabel(
        protocol.CharacterData(
          temporaryHp: 0,
          derived: protocol.CharacterDerivedData(maxHp: 20),
        ),
      ),
      '20 / 20',
    );
    expect(
      formatHpLabel(
        protocol.CharacterData(
          currentHp: 12,
          temporaryHp: 4,
          derived: protocol.CharacterDerivedData(maxHp: 20),
        ),
      ),
      '12 / 20 (4)',
    );
  });

  testWidgets('CombatStatsRow calls hp callback only for hp button',
      (tester) async {
    var hpTapCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CombatStatsRow(
            character: protocol.CharacterData(
              derived: protocol.CharacterDerivedData(
                maxHp: 20,
                initiative: 2,
                armorClass: 15,
                speed: 30,
              ),
            ),
            onHpPressed: () {
              hpTapCount += 1;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.bolt));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.shield_outlined));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.directions_run));
    await tester.pump();

    expect(hpTapCount, 1);
    expect(find.text('30'), findsOneWidget);
  });

  test('CharacterSheetController saves normalized hp values', () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 5,
        temporaryHp: 3,
        derived: protocol.CharacterDerivedData(maxHp: 20),
      ),
    );
    final container = ProviderContainer(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      characterSheetControllerProvider(1),
      (_, __) {},
    );
    addTearDown(subscription.close);

    await container.read(characterSheetControllerProvider(1).future);

    await container
        .read(characterSheetControllerProvider(1).notifier)
        .saveHitPoints(
          currentHp: 20,
          temporaryHp: 0,
        );

    expect(repository.saveCallCount, 1);
    expect(repository.savedCharacter?.currentHp, isNull);
    expect(repository.savedCharacter?.temporaryHp, isNull);
  });

  test('CharacterSheetController clears death saves when hp rises above 0',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 0,
        deathSaveSuccesses: 2,
        deathSaveFailures: 1,
        derived: protocol.CharacterDerivedData(maxHp: 20),
      ),
    );
    final container = ProviderContainer(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      characterSheetControllerProvider(1),
      (_, __) {},
    );
    addTearDown(subscription.close);

    await container.read(characterSheetControllerProvider(1).future);

    await container
        .read(characterSheetControllerProvider(1).notifier)
        .saveHitPoints(
          currentHp: 5,
          temporaryHp: 0,
        );

    expect(repository.savedCharacter?.deathSaveSuccesses, isNull);
    expect(repository.savedCharacter?.deathSaveFailures, isNull);
  });

  testWidgets('HP sheet at 0 hp shows death saves instead of hp summary',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HitPointsCalculatorSheet(
            character: protocol.CharacterData(
              currentHp: 0,
              deathSaveSuccesses: 1,
              deathSaveFailures: 2,
              derived: protocol.CharacterDerivedData(maxHp: 20),
            ),
            onSave: ({required currentHp, required temporaryHp}) async {},
            onSaveDeathSavingThrows: ({
              required successes,
              required failures,
            }) async {},
            onSaveSettings: ({
              required classEntries,
              required hpPerLevelBonus,
              required hpFlatBonus,
              required currentHitDice,
              required hitDiceMaxOverrides,
            }) async {},
          ),
        ),
      ),
    );

    expect(find.text('Успехи'), findsOneWidget);
    expect(find.text('Провалы'), findsOneWidget);
    expect(find.byKey(const Key('death_saves_skull_button')), findsOneWidget);
    expect(find.text('Текущие'), findsNothing);
  });

  testWidgets('HP sheet removes clear button and expands tune settings',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HitPointsCalculatorSheet(
            character: protocol.CharacterData(
              derived: protocol.CharacterDerivedData(
                maxHp: 20,
                hitDiceSummary: const {'d10': 2},
              ),
              classEntries: [
                protocol.CharacterClassEntryData(
                  classData: protocol.ClassData(name: 'Воин', hitDieValue: 10),
                  level: 2,
                  classOrder: 0,
                ),
              ],
            ),
            onSave: ({required currentHp, required temporaryHp}) async {},
            onSaveDeathSavingThrows: ({
              required successes,
              required failures,
            }) async {},
            onSaveSettings: ({
              required classEntries,
              required hpPerLevelBonus,
              required hpFlatBonus,
              required currentHitDice,
              required hitDiceMaxOverrides,
            }) async {},
          ),
        ),
      ),
    );

    expect(find.text('Очистить'), findsNothing);

    await tester.ensureVisible(find.byKey(const Key('hit_points_tune_button')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('hit_points_tune_button')));
    await tester.pump();

    expect(find.text('Настройка максимума'), findsOneWidget);
    expect(find.text('Бонус за уровень'), findsOneWidget);
    expect(find.text('Кости хитов'), findsOneWidget);
  });
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository(this.character);

  protocol.CharacterData character;
  protocol.CharacterData? savedCharacter;
  int saveCallCount = 0;

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    return character;
  }

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    saveCallCount += 1;
    savedCharacter = character;
    this.character = character;
    return character;
  }
}
