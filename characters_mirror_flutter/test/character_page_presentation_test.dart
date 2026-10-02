import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repository_providers.dart';
import 'package:characters_mirror_flutter/features/character_portrait/character_portrait.dart';
import 'package:characters_mirror_flutter/features/character_portrait/application/character_portrait_controller.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('character overview orders summaries and avoids duplicate name',
      (tester) async {
    await _pumpPage(tester);

    expect(find.text('Mira'), findsOneWidget);
    expect(find.text('Уровень и опыт'), findsOneWidget);
    expect(find.text('3 уровень'), findsOneWidget);
    expect(find.text('450 опыта · порог не указан'), findsOneWidget);
    expect(find.text('Класс и раса'), findsOneWidget);
    expect(find.text('Владения персонажа'), findsOneWidget);
    expect(find.text('Описание персонажа'), findsOneWidget);
    expect(find.text('Портрет'), findsNothing);
    expect(find.text('Изображение персонажа'), findsNothing);
    expect(find.text('Изменить'), findsNothing);
    expect(find.text('Возраст'), findsOneWidget);
    expect(find.text('Рост'), findsOneWidget);
    expect(find.text('Вес'), findsOneWidget);
    expect(find.text('Глаза'), findsOneWidget);
    expect(find.text('Кожа'), findsOneWidget);
    expect(find.text('Волосы'), findsOneWidget);
    expect(find.text('Общий'), findsOneWidget);
    expect(
      tester.getRect(find.byType(CharacterPortrait)).right,
      lessThan(tester.getRect(find.text('Класс и раса')).left),
    );

    final titles = [
      'Уровень и опыт',
      'Класс и раса',
      'Владения персонажа',
      'Описание персонажа',
    ];
    final tops = [
      for (final title in titles) tester.getTopLeft(find.text(title)).dy,
    ];
    expect(tops, orderedEquals([...tops]..sort()));
    expect(find.byIcon(Icons.chevron_right), findsNWidgets(4));
    expect(tester.takeException(), isNull);
  });

  testWidgets('character overview fits narrow and wide viewports',
      (tester) async {
    for (final size in [const Size(360, 800), const Size(1100, 900)]) {
      await tester.binding.setSurfaceSize(size);
      await _pumpPage(tester);
      expect(tester.takeException(), isNull);
    }
    await tester.binding.setSurfaceSize(null);
  });

  testWidgets('summary cards keep their class, proficiency and editor routes',
      (tester) async {
    await _pumpPage(tester);

    await tester.tap(find.text('Класс и раса'));
    await tester.pumpAndSettle();
    expect(find.text('Класс'), findsWidgets);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Владения персонажа'));
    await tester.pumpAndSettle();
    expect(find.text('Владения персонажа'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Описание персонажа'));
    await tester.pumpAndSettle();
    expect(find.text('Личные данные'), findsOneWidget);
    expect(find.text('Внешность'), findsOneWidget);
  });
}

Future<void> _pumpPage(WidgetTester tester) async {
  final character = CharacterData(
    id: 1,
    name: 'Mira',
    age: '120',
    height: '142 см',
    weight: '52 кг',
    eyes: 'Серые',
    skin: 'Смуглая',
    hair: 'Чёрные',
    experience: 450,
    derived: CharacterDerivedData(
      totalLevel: 3,
      languages: [Language.common],
    ),
    classEntries: [
      CharacterClassEntryData(
        level: 3,
        classData: ClassData(name: 'Колдун'),
      ),
    ],
    race: RaceData(name: 'Дварф'),
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        characterSheetControllerProvider
            .overrideWith(() => _FakeCharacterSheetController(character)),
        characterPortraitControllerProvider
            .overrideWith(() => _FakePortraitController()),
        toolCatalogProvider.overrideWith((ref) async => []),
        weaponCatalogProvider.overrideWith((ref) async => []),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: const Text('Mira')),
          body: const CharacterPage(characterId: 1),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

class _FakeCharacterSheetController extends CharacterSheetController {
  _FakeCharacterSheetController(this.character);

  final CharacterData character;

  @override
  Future<CharacterData> build(int characterId) async => character;
}

class _FakePortraitController extends CharacterPortraitController {
  @override
  Future<Uri?> build(int characterId) async => null;
}
