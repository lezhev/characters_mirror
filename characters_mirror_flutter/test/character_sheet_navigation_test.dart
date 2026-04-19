import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/character_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  group('Character sheet navigation', () {
    testWidgets('uses icon-only navigation bar destinations', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      final navigationBar =
          tester.widget<NavigationBar>(find.byType(NavigationBar));

      expect(
        navigationBar.labelBehavior,
        NavigationDestinationLabelBehavior.alwaysHide,
      );
      expect(find.text('Бой'), findsNothing);
      expect(find.text('Персонаж'), findsNothing);
      expect(find.text('Инвентарь'), findsNothing);
      expect(find.text('Заметки'), findsNothing);
      expect(find.text('Заклинания'), findsNothing);
    });

    testWidgets('switches tabs and keeps fight page state alive',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      expect(find.text('Атаки'), findsOneWidget);
      expect(repository.getCharacterCallCount, 1);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      expect(find.text('Класс и раса'), findsOneWidget);
      expect(find.text('Класс не выбран'), findsOneWidget);
      expect(find.text('Раса не выбрана'), findsOneWidget);
      expect(find.text('Короткие поля'), findsOneWidget);
      expect(find.text('История и характер'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.inventory));
      await tester.pumpAndSettle();

      expect(find.text('Инвентарь'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.note));
      await tester.pumpAndSettle();

      expect(find.text('Страница заметок'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.auto_fix_high));
      await tester.pumpAndSettle();

      expect(find.text('Страница заклинаний'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.sports_martial_arts));
      await tester.pumpAndSettle();

      expect(find.text('Атаки'), findsOneWidget);
      expect(repository.getCharacterCallCount, 1);
    });

    testWidgets('character tab opens class and race details', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            age: '24',
            height: '180',
            alignmentValue: protocol.CharacterAlignment.chaoticGood,
            race: protocol.RaceData(
              id: 1,
              name: 'Человек',
            ),
            subrace: protocol.SubraceData(
              id: 2,
              parentRaceId: 1,
              name: 'Вариант',
              description: 'Описание выбранной подрасы.',
            ),
            classEntries: [
              protocol.CharacterClassEntryData(
                id: 1,
                classOrder: 0,
                level: 3,
                classData: protocol.ClassData(
                  id: 1,
                  name: 'Воин',
                  hitDieValue: 10,
                  primaryAbilities: const [protocol.Ability.strength],
                  savingThrowProficiencies: const [
                    protocol.Ability.strength,
                    protocol.Ability.constitution,
                  ],
                  armorTraining: const [protocol.ArmorCategory.heavy],
                  weaponTraining: const [
                    protocol.WeaponCategory.martialMelee,
                  ],
                  toolTraining: const ['Игровые кости'],
                ),
                subclass: protocol.SubclassData(
                  id: 1,
                  parentClassId: 1,
                  name: 'Чемпион',
                  description: 'Описание выбранного подкласса.',
                ),
              ),
            ],
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      expect(find.text('Воин 3 уровень • Чемпион'), findsOneWidget);
      expect(find.text('Человек • Вариант'), findsOneWidget);
      expect(find.text('24'), findsOneWidget);
      expect(find.text('Хаотичный добрый'), findsOneWidget);

      await tester.tap(find.text('Класс и раса'));
      await tester.pumpAndSettle();

      expect(find.text('Описание выбранного подкласса.'), findsOneWidget);
      expect(find.text('Описание выбранной подрасы.'), findsOneWidget);
      expect(find.text('Кость хитов'), findsOneWidget);
      expect(find.text('d10'), findsOneWidget);
    });

    testWidgets('burger opens mechanics page and returns to previous tab',
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
              skillBonuses: const {},
              savingThrowProficiencies: const [],
            ),
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      await tester.tap(find.byIcon(Icons.note));
      await tester.pumpAndSettle();
      expect(find.text('Страница заметок'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Характеристики'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byIcon(Icons.menu), findsNothing);
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Страница заметок'), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });
  });
}

Future<void> _pumpCharacterSheet(
  WidgetTester tester,
  _FakeCharacterRepository repository,
) async {
  await tester.binding.setSurfaceSize(const Size(1280, 800));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
      ],
      child: MaterialApp(
        theme: darkTheme,
        home: const CharacterSheet(characterId: 1),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository({
    required Map<int, protocol.CharacterData> charactersById,
  }) : _charactersById = Map<int, protocol.CharacterData>.from(charactersById);

  final Map<int, protocol.CharacterData> _charactersById;
  int getCharacterCallCount = 0;

  @override
  Future<protocol.CharacterData> getCharacter(int characterId) async {
    getCharacterCallCount += 1;

    final character = _charactersById[characterId];
    if (character == null) {
      throw Exception('Character not found');
    }
    return character;
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
  Future<protocol.CharacterData> saveCharacter(
    protocol.CharacterData character,
  ) async {
    final id = character.id ?? 1;
    final saved = character.copyWith(id: id);
    _charactersById[id] = saved;
    return saved;
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
