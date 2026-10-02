part of '../hit_points_calculator_test.dart';

void _registerHitPointsSheetTests() {
  testWidgets('HP actions clamp the evaluated expression before applying',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final cases = <(String, int)>[
      ('5000', 5000),
      ('50000', 10000),
      ('999999', 10000),
      ('7000+8000', 10000),
    ];

    for (final (expression, expectedAmount) in cases) {
      int? appliedAmount;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HitPointsCalculatorSheet(
              character: protocol.CharacterData(
                derived: protocol.CharacterDerivedData(maxHp: 20),
              ),
              onApplyAction: ({required action, required amount}) async {
                appliedAmount = amount;
              },
              onSaveDeathSavingThrows: (
                  {required successes, required failures}) async {},
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

      final field = find.byKey(const ValueKey('hit_point_expression_field'));
      await tester.enterText(field, expression);
      final damageButton = find.widgetWithText(FilledButton, 'Урон');
      await tester.ensureVisible(damageButton);
      await tester.tap(damageButton);
      await tester.pump();

      expect(appliedAmount, expectedAmount, reason: expression);
    }
  });

  testWidgets('HP expression input caps large paste', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HitPointsCalculatorSheet(
            character: protocol.CharacterData(
              derived: protocol.CharacterDerivedData(maxHp: 20),
            ),
            onApplyAction: ({required action, required amount}) async {},
            onSaveDeathSavingThrows: (
                {required successes, required failures}) async {},
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

    final field = find.byKey(const ValueKey('hit_point_expression_field'));
    await tester.enterText(field, '1' * 1000);
    await tester.pump();

    expect(tester.widget<TextField>(field).controller!.text.length, 64);
    expect(tester.takeException(), isNull);
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
            onApplyAction: ({required action, required amount}) async {},
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
            onApplyAction: ({required action, required amount}) async {},
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

  testWidgets('HP sheet stays interactive while save is pending',
      (tester) async {
    tester.view.physicalSize = const Size(1000, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final firstSave = Completer<void>();
    var saveCount = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HitPointsCalculatorSheet(
            character: protocol.CharacterData(
              derived: protocol.CharacterDerivedData(maxHp: 20),
            ),
            onApplyAction: ({required action, required amount}) {
              saveCount += 1;
              return saveCount == 1 ? firstSave.future : Future.value();
            },
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

    await tester.tap(find.widgetWithText(OutlinedButton, '1'));
    await tester.pump();
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Урон'));
    await tester.tap(find.widgetWithText(FilledButton, 'Урон'));
    await tester.pump();

    expect(saveCount, 1);
    expect(find.text('19'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Урон'));
    await tester.pump();

    expect(saveCount, 2);
    expect(find.text('18'), findsOneWidget);

    firstSave.complete();
  });
}
