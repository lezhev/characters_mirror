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

      expect(find.text('Страница персонажа'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.inventory));
      await tester.pumpAndSettle();

      expect(find.text('Страница инвентаря'), findsOneWidget);

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
