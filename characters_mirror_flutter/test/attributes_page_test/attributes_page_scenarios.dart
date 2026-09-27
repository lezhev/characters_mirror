part of '../attributes_page_test.dart';

void _registerAttributesPageTests() {
  group('AttributesPage', () {
    testWidgets('renders ability card content with grouped values',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 12,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 1,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 3,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowProficiencies: const [protocol.Ability.strength],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final strengthCard = find.byKey(
        const ValueKey('attribute-card-strength'),
      );

      expect(find.text('Характеристики'), findsOneWidget);
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('СИЛА'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('12'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('+1'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('Спасбросок'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('+3'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.byKey(
            const ValueKey('attribute-save-toggle-strength'),
          ),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('Атлетика'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('saving throw toggle persists updated proficiency',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowProficiencies: const [],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final strengthCard = find.byKey(
        const ValueKey('attribute-card-strength'),
      );
      final toggle = find.descendant(
        of: strengthCard,
        matching: find.byKey(
          const ValueKey('attribute-save-toggle-strength'),
        ),
      );

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.manualSavingThrowProficiencies,
        const [protocol.Ability.strength],
      );
    });

    testWidgets('saving throw bonus updates before delayed save completes',
        (tester) async {
      final repository = _DelayedCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              proficiencyBonus: 2,
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowProficiencies: const [],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      await tester.tap(
        find.byKey(const ValueKey('attribute-save-toggle-strength')),
      );
      await tester.pump();

      final strengthCard = find.byKey(
        const ValueKey('attribute-card-strength'),
      );
      expect(repository.pendingSaveCount, 0);
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('+2'),
        ),
        findsOneWidget,
      );

      await _pumpCharacterSheetAutosave(tester);
      expect(repository.pendingSaveCount, 1);

      repository.completeSave(0);
      await tester.pumpAndSettle();
    });

    testWidgets('modifier button shows a d20 roll result', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 16,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 3,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 3,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      await tester.tap(
        find.byKey(const ValueKey('attribute-modifier-strength')),
      );
      await tester.pump();

      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.startsWith('d20 + 3 = ') ?? false),
        ),
        findsOneWidget,
      );
    });

    testWidgets('skill toggle cycles standard dnd proficiency states',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              skillProficiencyLevels: const [],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final toggle = _skillToggleTapTarget(tester, protocol.Skill.athletics);

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(
        _savedSkillLevel(repository, protocol.Skill.athletics),
        protocol.CharacterSkillProficiencyLevel.proficient,
      );

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(
        _savedSkillLevel(repository, protocol.Skill.athletics),
        protocol.CharacterSkillProficiencyLevel.expertise,
      );

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(
        _savedSkillLevel(repository, protocol.Skill.athletics),
        protocol.CharacterSkillProficiencyLevel.none,
      );
    });

    testWidgets('skill bonus updates through proficiency states optimistically',
        (tester) async {
      final repository = _DelayedCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              proficiencyBonus: 2,
              abilityScores: const {
                protocol.Ability.strength: 12,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 1,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              skillBonuses: const {
                protocol.Skill.athletics: 1,
              },
              skillProficiencyLevels: const [],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final toggle = _skillToggleTapTarget(tester, protocol.Skill.athletics);
      final bonus = find.byKey(const ValueKey('skill-bonus-athletics'));

      await tester.tap(toggle);
      await tester.pump();

      expect(
        find.descendant(of: bonus, matching: find.text('+3')),
        findsOneWidget,
      );
      expect(repository.pendingSaveCount, 0);

      await tester.tap(toggle);
      await tester.pump();

      expect(
        find.descendant(of: bonus, matching: find.text('+5')),
        findsOneWidget,
      );
      expect(repository.pendingSaveCount, 0);

      await _pumpCharacterSheetAutosave(tester);
      expect(repository.pendingSaveCount, 1);

      await tester.tap(toggle);
      await tester.pump();

      expect(
        find.descendant(of: bonus, matching: find.text('+1')),
        findsOneWidget,
      );
      expect(repository.pendingSaveCount, 1);

      await _pumpCharacterSheetAutosave(tester);
      expect(repository.pendingSaveCount, 1);

      repository.completeSave(0);
      await tester.pump();
      expect(repository.pendingSaveCount, 2);

      repository.completeSave(1);
      await tester.pumpAndSettle();
    });

    testWidgets('skill toggle keeps size and position across all states',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              skillProficiencyLevels: const [],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final toggleKey = find.byKey(const ValueKey('skill-toggle-athletics'));
      final toggle = _skillToggleTapTarget(tester, protocol.Skill.athletics);
      final initialSize = tester.getSize(toggleKey);
      final initialCenter = tester.getCenter(toggleKey);

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(tester.getSize(toggleKey), initialSize);
      expect(tester.getCenter(toggleKey), initialCenter);

      await tester.tap(toggle);
      await tester.pumpAndSettle();

      expect(tester.getSize(toggleKey), initialSize);
      expect(tester.getCenter(toggleKey), initialCenter);
      expect(
        find.descendant(
          of: toggleKey,
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets('attribute and skill flags align in one vertical column',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final attributeToggle = find.byKey(
        const ValueKey('attribute-save-toggle-strength'),
      );
      final athleticsToggle = find.byKey(
        const ValueKey('skill-toggle-athletics'),
      );
      final acrobaticsToggle = find.byKey(
        const ValueKey('skill-toggle-acrobatics'),
      );

      expect(
        tester.getCenter(attributeToggle).dx,
        tester.getCenter(athleticsToggle).dx,
      );
      expect(
        tester.getCenter(attributeToggle).dx,
        tester.getCenter(acrobaticsToggle).dx,
      );
    });

    testWidgets('saving throw flag uses the skill flag tap target size',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final attributeToggle = find.byKey(
        const ValueKey('attribute-save-toggle-strength'),
      );
      final skillToggle = find.byKey(
        const ValueKey('skill-toggle-athletics'),
      );

      expect(tester.getSize(attributeToggle), tester.getSize(skillToggle));
    });

    testWidgets('skills are separated by full-width background dividers',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final dexterityCard = find.byKey(
        const ValueKey('attribute-card-dexterity'),
      );
      final divider = find
          .descendant(
            of: dexterityCard,
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is SizedBox &&
                  widget.height == 4 &&
                  widget.width == double.infinity,
            ),
          )
          .first;

      final cardLeft = tester.getTopLeft(dexterityCard).dx;
      final cardRight = tester.getTopRight(dexterityCard).dx;
      final dividerLeft = tester.getTopLeft(divider).dx;
      final dividerRight = tester.getTopRight(divider).dx;

      expect(
        dividerLeft,
        cardLeft + 4,
      );
      expect(
        dividerRight,
        cardRight - 4,
      );
      expect(
        find.descendant(
          of: dexterityCard,
          matching: find.byKey(const ValueKey('skill-row-acrobatics')),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: dexterityCard,
          matching: find.byKey(const ValueKey('skill-row-stealth')),
        ),
        findsOneWidget,
      );
    });

    testWidgets('saving throw and skill bonus buttons share width',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 5,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              skillBonuses: const {
                protocol.Skill.athletics: 2,
              },
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final savingThrowBonus = find.byKey(
        const ValueKey('attribute-saving-strength'),
      );
      final skillBonus = find.byKey(
        const ValueKey('skill-bonus-athletics'),
      );

      expect(tester.getSize(savingThrowBonus), tester.getSize(skillBonus));
    });

    testWidgets('uses selected star halo for expertise state', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 10,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 0,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              skillProficiencyLevels: [
                protocol.CharacterSkillProficiencyState(
                  skill: protocol.Skill.athletics,
                  level: protocol.CharacterSkillProficiencyLevel.expertise,
                ),
              ],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final toggle = find.byKey(const ValueKey('skill-toggle-athletics'));

      expect(
        find.descendant(of: toggle, matching: find.byType(CustomPaint)),
        findsOneWidget,
      );
      expect(find.byType(SkillProficiencyToggle), findsWidgets);
      expect(
        _savedSkillLevel(repository, protocol.Skill.athletics),
        isNull,
        reason: 'Repository should remain unchanged until user interaction.',
      );
    });

    testWidgets('uses compact labels on narrow width', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 12,
                protocol.Ability.dexterity: 10,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 1,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 3,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowProficiencies: const [protocol.Ability.strength],
            ),
          ),
        },
      );

      await _pumpAttributesPage(
        tester,
        repository,
        surfaceSize: const Size(420, 900),
      );

      final strengthCard = find.byKey(
        const ValueKey('attribute-card-strength'),
      );

      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('СИЛ'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('Спас.'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: strengthCard,
          matching: find.text('СИЛА'),
        ),
        findsNothing,
      );
    });

    testWidgets('keeps equal widths for modifier and saving buttons',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 18,
                protocol.Ability.dexterity: 8,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 12,
                protocol.Ability.dexterity: -1,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 15,
                protocol.Ability.dexterity: 0,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowProficiencies: const [protocol.Ability.strength],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final strengthModifier = find.byKey(
        const ValueKey('attribute-modifier-strength'),
      );
      final dexterityModifier = find.byKey(
        const ValueKey('attribute-modifier-dexterity'),
      );
      final strengthSaving = find.byKey(
        const ValueKey('attribute-saving-strength'),
      );
      final dexteritySaving = find.byKey(
        const ValueKey('attribute-saving-dexterity'),
      );

      expect(
        tester.getSize(strengthModifier).width,
        tester.getSize(dexterityModifier).width,
      );
      expect(
        tester.getSize(strengthSaving).width,
        tester.getSize(dexteritySaving).width,
      );
    });

    testWidgets('keeps modifier buttons vertically aligned for 8 and 16',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                protocol.Ability.strength: 16,
                protocol.Ability.dexterity: 8,
                protocol.Ability.constitution: 10,
                protocol.Ability.intelligence: 10,
                protocol.Ability.wisdom: 10,
                protocol.Ability.charisma: 10,
              },
              abilityModifiers: const {
                protocol.Ability.strength: 3,
                protocol.Ability.dexterity: -1,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowBonuses: const {
                protocol.Ability.strength: 5,
                protocol.Ability.dexterity: 1,
                protocol.Ability.constitution: 0,
                protocol.Ability.intelligence: 0,
                protocol.Ability.wisdom: 0,
                protocol.Ability.charisma: 0,
              },
              savingThrowProficiencies: const [
                protocol.Ability.strength,
                protocol.Ability.dexterity,
              ],
            ),
          ),
        },
      );

      await _pumpAttributesPage(tester, repository);

      final strengthModifier = find.byKey(
        const ValueKey('attribute-modifier-strength'),
      );
      final dexterityModifier = find.byKey(
        const ValueKey('attribute-modifier-dexterity'),
      );

      expect(
        tester.getTopLeft(strengthModifier).dx,
        tester.getTopLeft(dexterityModifier).dx,
      );
    });
  });
}
