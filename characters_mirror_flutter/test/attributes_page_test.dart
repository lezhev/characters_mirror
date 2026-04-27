import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_results_overlay.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/attributes_page.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/widgets/expertise_flag_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
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
                'strength': 12,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 1,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 3,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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

    testWidgets('modifier button shows a d20 roll result', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                'strength': 16,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 3,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 3,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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

    testWidgets('skill toggle keeps size and position across all states',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            derived: protocol.CharacterDerivedData(
              abilityScores: const {
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 5,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              skillBonuses: const {
                'athletics': 2,
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
                'strength': 10,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 0,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 12,
                'dexterity': 10,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 1,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 3,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 18,
                'dexterity': 8,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 12,
                'dexterity': -1,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 15,
                'dexterity': 0,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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
                'strength': 16,
                'dexterity': 8,
                'constitution': 10,
                'intelligence': 10,
                'wisdom': 10,
                'charisma': 10,
              },
              abilityModifiers: const {
                'strength': 3,
                'dexterity': -1,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
              },
              savingThrowBonuses: const {
                'strength': 5,
                'dexterity': 1,
                'constitution': 0,
                'intelligence': 0,
                'wisdom': 0,
                'charisma': 0,
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

protocol.CharacterSkillProficiencyLevel? _savedSkillLevel(
  _FakeCharacterRepository repository,
  protocol.Skill skill,
) {
  final savedSkills = repository.charactersById[1]?.manualSkillProficiencies;
  return savedSkills?.firstWhere((state) => state.skill == skill).level;
}

Future<void> _pumpAttributesPage(
  WidgetTester tester,
  _FakeCharacterRepository repository, {
  Size surfaceSize = const Size(800, 900),
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: darkTheme,
        home: RollResultsOverlay(
          child: Scaffold(
            body: AttributesPage(
              characterId: 1,
              onClose: _noop,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void _noop() {}

Finder _skillToggleTapTarget(WidgetTester tester, protocol.Skill skill) {
  final toggle = find.byKey(ValueKey('skill-toggle-${skill.name}'));
  return find.descendant(
    of: toggle,
    matching: find.byType(InkResponse),
  );
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository({
    required Map<int, protocol.CharacterData> charactersById,
  }) : _charactersById = Map<int, protocol.CharacterData>.from(charactersById);

  final Map<int, protocol.CharacterData> _charactersById;

  Map<int, protocol.CharacterData> get charactersById => _charactersById;

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    final character = _charactersById[characterId];
    if (character == null) {
      throw Exception('Character not found');
    }
    return character;
  }

  @override
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    final id = character.id ?? 1;
    final saved = character.copyWith(id: id);
    _charactersById[id] = saved;
    return saved;
  }

  @override
  Future<List<protocol.CharacterData>> getAll() async {
    return _charactersById.values.toList();
  }

  @override
  Future<protocol.CharacterData?> getById(int id) async {
    return _charactersById[id];
  }

  @override
  Future<protocol.CharacterData> upsert(protocol.CharacterData entity) {
    return saveCharacter(entity);
  }

  @override
  Future<void> delete(int id) async {
    _charactersById.remove(id);
  }
}
