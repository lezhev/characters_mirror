part of '../hit_points_calculator_test.dart';

void _registerHitPointsCalculatorTests() {
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

  test('hp label supports compact density levels', () {
    final character = protocol.CharacterData(
      currentHp: 12,
      temporaryHp: 4,
      derived: protocol.CharacterDerivedData(maxHp: 20),
    );

    expect(formatHpLabel(character), '12 / 20 (4)');
    expect(
      formatHpLabel(
        character,
        density: HpLabelDensity.withoutTemporary,
      ),
      '12 / 20',
    );
    expect(
      formatHpLabel(
        character,
        density: HpLabelDensity.currentOnly,
      ),
      '12',
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
            onInitiativePressed: () {},
            onInitiativeLongPressed: () {},
            onArmorClassPressed: () {},
            onSpeedPressed: () {},
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

  testWidgets('CombatStatsRow cards shorten hp by card width', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(600, 300);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CombatStatsRow(
            character: protocol.CharacterData(
              currentHp: 12,
              temporaryHp: 4,
              derived: protocol.CharacterDerivedData(
                maxHp: 20,
                initiative: 2,
                armorClass: 15,
                speed: 30,
              ),
            ),
            onHpPressed: () {},
            onInitiativePressed: () {},
            onInitiativeLongPressed: () {},
            onArmorClassPressed: () {},
            onSpeedPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('12 / 20 (4)'), findsOneWidget);
    expect(find.text('12 / 20'), findsNothing);

    tester.view.physicalSize = const Size(500, 300);
    await tester.pump();

    expect(find.text('12 / 20'), findsOneWidget);
    expect(find.text('12 / 20 (4)'), findsNothing);

    tester.view.physicalSize = const Size(340, 300);
    await tester.pump();

    expect(find.text('12'), findsOneWidget);
    expect(find.text('12 / 20'), findsNothing);
    expect(
      tester.getTopLeft(find.byIcon(Icons.directions_run)).dy,
      greaterThan(tester.getTopLeft(find.byIcon(Icons.favorite)).dy),
    );
  });

  testWidgets('CombatStatsRow long press can push initiative roll result',
      (tester) async {
    final character = protocol.CharacterData(
      derived: protocol.CharacterDerivedData(
        maxHp: 20,
        initiative: 2,
        armorClass: 15,
        speed: 30,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: RollResultsOverlay(
          child: Builder(
            builder: (context) {
              return Scaffold(
                body: CombatStatsRow(
                  character: character,
                  onHpPressed: () {},
                  onInitiativePressed: () {},
                  onInitiativeLongPressed: () {
                    final result = DiceRoller(
                      rollDie: (_) => 12,
                    ).rollModifier(formatInitiativeLabel(character));
                    RollResultsOverlay.show(context, result.displayText);
                  },
                  onArmorClassPressed: () {},
                  onSpeedPressed: () {},
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.longPress(find.byIcon(Icons.bolt));
    await tester.pump();

    expect(find.text('d20 + 2 = 12 + 2 = 14'), findsOneWidget);
  });

  testWidgets('initiative and armor class sheets autosave bonuses',
      (tester) async {
    int? initiativeBonus;
    int? armorClassBonus;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InitiativeSettingsSheet(
            character: protocol.CharacterData(
              customInitiativeBonus: 1,
              derived: protocol.CharacterDerivedData(initiative: 4),
            ),
            onSave: (bonus) async {
              initiativeBonus = bonus;
            },
          ),
        ),
      ),
    );

    expect(
      find.text(
        'Быстрый бросок инициативы: удерживайте карточку инициативы на листе персонажа.',
      ),
      findsOneWidget,
    );
    await tester.enterText(
      find.byKey(const ValueKey('initiative-bonus-field')),
      '3',
    );
    await tester.pump(const Duration(milliseconds: 600));
    expect(initiativeBonus, 3);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ArmorClassSettingsSheet(
            character: protocol.CharacterData(
              customArmorClassBonus: 1,
              derived: protocol.CharacterDerivedData(armorClass: 14),
            ),
            onSave: (bonus) async {
              armorClassBonus = bonus;
            },
          ),
        ),
      ),
    );

    expect(find.text('Итоговая КД: 14'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('armor-class-bonus-field')),
      '2',
    );
    await tester.pump();
    expect(find.text('Итоговая КД: 15'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 600));
    expect(armorClassBonus, 2);
  });

  testWidgets('movement speed sheet autosaves values and selected speed',
      (tester) async {
    MovementSpeedsDraft? savedDraft;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MovementSpeedSettingsSheet(
            character: protocol.CharacterData(
              walkingSpeed: 30,
              swimmingSpeed: 15,
              climbingSpeed: 15,
              flyingSpeed: 0,
              displayedSpeedKind: protocol.CharacterSpeedKind.walking,
            ),
            onSave: (draft) async {
              savedDraft = draft;
            },
          ),
        ),
      ),
    );

    expect(find.text('Ходьба'), findsOneWidget);
    expect(find.text('Плаванье'), findsOneWidget);
    expect(find.text('Лазанье'), findsOneWidget);
    expect(find.text('Полёт'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('flying-speed-field')),
      '60',
    );
    await tester.tap(find.byType(Radio<protocol.CharacterSpeedKind>).last);
    await tester.pump(const Duration(milliseconds: 600));

    expect(savedDraft?.flyingSpeed, 60);
    expect(savedDraft?.displayedSpeedKind, protocol.CharacterSpeedKind.flying);
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

  test('CharacterSheetController initializes movement speeds from defaults',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        race: protocol.RaceData(speed: 30),
        subrace: protocol.SubraceData(parentRaceId: 1, speedOverride: 40),
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
        .ensureMovementSpeedsInitialized();

    expect(repository.savedCharacter?.walkingSpeed, 40);
    expect(repository.savedCharacter?.swimmingSpeed, 20);
    expect(repository.savedCharacter?.climbingSpeed, 20);
    expect(repository.savedCharacter?.flyingSpeed, 0);
    expect(
      repository.savedCharacter?.displayedSpeedKind,
      protocol.CharacterSpeedKind.walking,
    );
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

  test('CharacterSheetController long rest saves hp without resources',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 3,
        temporaryHp: 7,
        deathSaveSuccesses: 2,
        deathSaveFailures: 1,
        currentSpellSlots: const {1: 0},
        currentHitDice: const {'d10': 2},
        derived: protocol.CharacterDerivedData(
          abilityModifiers: const {'constitution': 0},
          spellSlots: const {1: 2},
        ),
        classEntries: [
          protocol.CharacterClassEntryData(
            classData: protocol.ClassData(hitDieValue: 10),
            level: 2,
          ),
        ],
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
        .restoreResources(protocol.RestType.longRest);

    expect(repository.saveCallCount, 1);
    expect(repository.savedCharacter?.currentHp, isNull);
    expect(repository.savedCharacter?.temporaryHp, isNull);
    expect(repository.savedCharacter?.deathSaveSuccesses, isNull);
    expect(repository.savedCharacter?.deathSaveFailures, isNull);
    expect(repository.savedCharacter?.currentSpellSlots, isNull);
    expect(repository.savedCharacter?.currentHitDice, isNull);
  });

  test('CharacterSheetController long rest restores feature resources',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 4,
        currentSpellSlots: const {1: 0},
        resourceStates: [
          protocol.CharacterResourceStateData(
            sourceType: protocol.CharacterFeatureSourceType.classFeature,
            sourceId: 10,
            resourceKey: 'second-wind',
            current: 0,
          ),
        ],
        derived: protocol.CharacterDerivedData(
          abilityModifiers: const {'constitution': 0},
          spellSlots: const {1: 2},
          activeFeatures: [
            protocol.CharacterFeatureViewData(
              sourceType: protocol.CharacterFeatureSourceType.classFeature,
              sourceId: 10,
              resources: [
                protocol.CharacterResourceViewData(
                  key: 'second-wind',
                  kind: protocol.FeatureResourceKind.uses,
                  current: 0,
                  max: 1,
                  resetOn: protocol.RestType.shortRest,
                ),
              ],
            ),
          ],
        ),
        classEntries: [
          protocol.CharacterClassEntryData(
            classData: protocol.ClassData(hitDieValue: 10),
            level: 1,
          ),
        ],
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
        .restoreResources(protocol.RestType.longRest);

    final saved = repository.savedCharacter;
    final resource = saved?.derived?.activeFeatures?.single.resources?.single;
    expect(saved?.currentHp, isNull);
    expect(saved?.currentSpellSlots, isNull);
    expect(saved?.resourceStates, isNull);
    expect(resource?.current, 1);
  });

  test('CharacterSheetController long rest restores half hit dice minimum one',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHitDice: const {'d8': 0},
        derived: protocol.CharacterDerivedData(
          abilityModifiers: const {'constitution': 0},
        ),
        classEntries: [
          protocol.CharacterClassEntryData(
            classData: protocol.ClassData(hitDieValue: 8),
            level: 1,
          ),
        ],
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
        .restoreResources(protocol.RestType.longRest);

    expect(repository.savedCharacter?.currentHitDice, isNull);
  });

  test('CharacterSheetController long rest restores largest hit dice first',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHitDice: const {'d6': 0, 'd10': 0},
        derived: protocol.CharacterDerivedData(
          abilityModifiers: const {'constitution': 0},
        ),
        classEntries: [
          protocol.CharacterClassEntryData(
            classData: protocol.ClassData(hitDieValue: 6),
            level: 3,
            classOrder: 1,
          ),
          protocol.CharacterClassEntryData(
            classData: protocol.ClassData(hitDieValue: 10),
            level: 3,
            classOrder: 0,
          ),
        ],
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
        .restoreResources(protocol.RestType.longRest);

    expect(
      repository.savedCharacter?.currentHitDice,
      const {'d6': 0},
    );
  });

  test('CharacterSheetController short rest only restores short rest resources',
      () async {
    final repository = _FakeCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 3,
        temporaryHp: 7,
        deathSaveSuccesses: 2,
        deathSaveFailures: 1,
        currentSpellSlots: const {1: 0},
        currentHitDice: const {'d10': 0},
        resourceStates: [
          protocol.CharacterResourceStateData(
            sourceType: protocol.CharacterFeatureSourceType.classFeature,
            sourceId: 10,
            resourceKey: 'second-wind',
            current: 0,
          ),
        ],
        derived: protocol.CharacterDerivedData(
          activeFeatures: [
            protocol.CharacterFeatureViewData(
              sourceType: protocol.CharacterFeatureSourceType.classFeature,
              sourceId: 10,
              resources: [
                protocol.CharacterResourceViewData(
                  key: 'second-wind',
                  kind: protocol.FeatureResourceKind.uses,
                  current: 0,
                  max: 1,
                  resetOn: protocol.RestType.shortRest,
                ),
              ],
            ),
          ],
        ),
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
        .restoreResources(protocol.RestType.shortRest);

    final saved = repository.savedCharacter;
    final resource = saved?.derived?.activeFeatures?.single.resources?.single;
    expect(saved?.currentHp, 3);
    expect(saved?.temporaryHp, 7);
    expect(saved?.deathSaveSuccesses, 2);
    expect(saved?.deathSaveFailures, 1);
    expect(saved?.currentSpellSlots, const {1: 0});
    expect(saved?.currentHitDice, const {'d10': 0});
    expect(saved?.resourceStates, isNull);
    expect(resource?.current, 1);
  });

  test('CharacterSheetController coalesces rapid saves to latest value',
      () async {
    final repository = _ControlledCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 12,
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
    final notifier =
        container.read(characterSheetControllerProvider(1).notifier);

    final first = notifier.saveHitPoints(currentHp: 11, temporaryHp: 0);
    final second = notifier.saveHitPoints(currentHp: 10, temporaryHp: 0);
    final third = notifier.saveHitPoints(currentHp: 8, temporaryHp: 0);

    expect(repository.savedCharacters, hasLength(1));
    expect(repository.savedCharacters.single.currentHp, 11);

    repository.completeSave(0);
    await Future<void>.delayed(Duration.zero);

    expect(repository.savedCharacters, hasLength(2));
    expect(repository.savedCharacters.last.currentHp, 8);

    repository.completeSave(1);
    await first;
    await second;
    await third;

    final character =
        container.read(characterSheetControllerProvider(1)).requireValue;
    expect(character.currentHp, 8);
  });

  test('CharacterSheetController ignores stale save failures', () async {
    final repository = _ControlledCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 12,
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
    final notifier =
        container.read(characterSheetControllerProvider(1).notifier);

    final first = notifier.saveHitPoints(currentHp: 11, temporaryHp: 0);
    final second = notifier.saveHitPoints(currentHp: 8, temporaryHp: 0);

    repository.failSave(0);
    await Future<void>.delayed(Duration.zero);

    expect(repository.savedCharacters, hasLength(2));
    expect(repository.savedCharacters.last.currentHp, 8);

    repository.completeSave(1);
    await first;
    await second;

    final character =
        container.read(characterSheetControllerProvider(1)).requireValue;
    expect(character.currentHp, 8);
  });

  test('CharacterSheetController rolls back latest failed save', () async {
    final repository = _ControlledCharacterRepository(
      protocol.CharacterData(
        id: 1,
        currentHp: 12,
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

    final save = container
        .read(characterSheetControllerProvider(1).notifier)
        .saveHitPoints(currentHp: 8, temporaryHp: 0);
    repository.failSave(0);

    await expectLater(save, throwsException);
    final character =
        container.read(characterSheetControllerProvider(1)).requireValue;
    expect(character.currentHp, 12);
  });
}
