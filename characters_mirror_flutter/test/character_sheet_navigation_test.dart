import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/serverpod/data/reference_repositories.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/character_sheet.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/character_sheet_settings_page.dart';
import 'package:characters_mirror_flutter/features/settings/settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

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
      expect(find.text('Описание персонажа'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.inventory));
      await tester.pumpAndSettle();

      expect(_textField('Снаряжение'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.note));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Добавить заметку'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.auto_fix_high));
      await tester.pumpAndSettle();

      expect(find.text('Спасбросок'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.sports_martial_arts));
      await tester.pumpAndSettle();

      expect(find.text('Атаки'), findsOneWidget);
      expect(repository.getCharacterCallCount, 1);
    });

    testWidgets('shows status stack and concentration across sheet tabs',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            activeConcentrationSpellName: 'Bless',
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

      expect(find.text('Атаки'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('character-status-stack')),
        findsOneWidget,
      );
      await _showStatusLabels(tester);

      expect(
        find.byKey(const ValueKey('active-concentration-row')),
        findsOneWidget,
      );
      expect(find.text('Bless'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      expect(find.text('Описание персонажа'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('active-concentration-row')),
        findsOneWidget,
      );

      await tester.tap(
        find.byKey(const ValueKey('active-concentration-cancel')),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const ValueKey('active-concentration-row')),
        findsNothing,
      );
      expect(
        repository.charactersById[1]?.activeConcentrationSpellName,
        isNull,
      );
    });

    testWidgets('hides status stack on attributes page', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      expect(
        find.byKey(const ValueKey('character-status-stack')),
        findsOneWidget,
      );

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Характеристики'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('character-status-stack')),
        findsNothing,
      );
    });

    testWidgets('status stack visibility toggle collapses and expands',
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

      expect(find.byKey(const ValueKey('status-visibility-toggle')),
          findsOneWidget);
      expect(
          find.byKey(const ValueKey('status-conditions-button')), findsNothing);
      expect(find.byKey(const ValueKey('status-inspiration-toggle')),
          findsNothing);

      await tester.tap(find.byKey(const ValueKey('status-visibility-toggle')));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('status-conditions-button')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('status-inspiration-toggle')),
          findsOneWidget);
      expect(find.text('Состояния'), findsNothing);
      expect(find.text('Вдохновение'), findsNothing);
      expect(find.text('Развернуть'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('status-visibility-toggle')));
      await tester.pumpAndSettle();

      expect(find.byKey(const ValueKey('status-visibility-toggle')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('status-conditions-button')),
          findsOneWidget);
      expect(find.byKey(const ValueKey('status-inspiration-toggle')),
          findsOneWidget);
      expect(find.text('Состояния'), findsOneWidget);
      expect(find.text('Вдохновение'), findsOneWidget);
      expect(find.text('Свернуть'), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('status-visibility-toggle')));
      await tester.pumpAndSettle();

      expect(
          find.byKey(const ValueKey('status-conditions-button')), findsNothing);
      expect(find.byKey(const ValueKey('status-inspiration-toggle')),
          findsNothing);
    });

    testWidgets('status stack toggles inspiration', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);
      await _showStatusIcons(tester);

      await tester.tap(find.byKey(const ValueKey('status-inspiration-toggle')));
      await tester.pumpAndSettle();

      expect(repository.charactersById[1]?.inspiration, isTrue);
      expect(find.byIcon(Icons.flare), findsOneWidget);

      await tester.tap(find.byKey(const ValueKey('status-inspiration-toggle')));
      await tester.pumpAndSettle();

      expect(repository.charactersById[1]?.inspiration, isNull);
    });

    testWidgets('condition dialog adds and stack removes condition',
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
      await _showStatusLabels(tester);

      await tester.tap(find.byKey(const ValueKey('status-conditions-button')));
      await tester.pumpAndSettle();

      final poisonedOption =
          find.byKey(const ValueKey('condition-option-poisoned'));
      await tester.ensureVisible(poisonedOption);
      await tester.tap(poisonedOption);
      await tester.tap(find.byKey(const ValueKey('save-conditions')));
      await tester.pumpAndSettle();

      expect(repository.charactersById[1]?.activeConditions,
          contains(protocol.ConditionType.poisoned));
      expect(find.text('Отравлен'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('active-condition-remove-poisoned')),
      );
      await tester.pumpAndSettle();

      expect(repository.charactersById[1]?.activeConditions, isNull);
      expect(find.text('Отравлен'), findsNothing);
    });

    testWidgets('status stack shows and removes exhaustion', (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            exhaustionLevel: 2,
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);
      await _showStatusLabels(tester);

      expect(find.text('Истощение 2'), findsOneWidget);

      await tester.tap(
        find.byKey(const ValueKey('active-condition-remove-exhaustion')),
      );
      await tester.pumpAndSettle();

      expect(repository.charactersById[1]?.exhaustionLevel, isNull);
      expect(find.text('Истощение 2'), findsNothing);
    });

    testWidgets('switches tabs with horizontal swipes', (tester) async {
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

      await tester.drag(find.byType(PageView), const Offset(-700, 0));
      await tester.pumpAndSettle();

      expect(find.text('Описание персонажа'), findsOneWidget);

      await tester.drag(find.byType(PageView), const Offset(700, 0));
      await tester.pumpAndSettle();

      expect(find.text('Атаки'), findsOneWidget);
    });

    testWidgets('wraps sheet swipes between fight and spells', (tester) async {
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

      await tester.drag(find.byType(PageView), const Offset(700, 0));
      await tester.pumpAndSettle();

      expect(find.text('Спасбросок'), findsOneWidget);

      await tester.drag(find.byType(PageView), const Offset(-700, 0));
      await tester.pumpAndSettle();

      expect(find.text('Атаки'), findsOneWidget);
    });

    testWidgets('ignores mouse edge swipes on character sheet', (tester) async {
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

      await _dragWithPointerKind(
        tester,
        find.byType(PageView),
        const Offset(700, 0),
        PointerDeviceKind.mouse,
      );

      expect(find.text('Атаки'), findsOneWidget);
      expect(find.text('Спасбросок'), findsNothing);
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
                id: 'entry-1',
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

      await tester.tap(find.text('Класс и раса'));
      await tester.pumpAndSettle();

      expect(find.text('Описание выбранного подкласса.'), findsOneWidget);
      expect(find.text('Описание выбранной подрасы.'), findsOneWidget);
      expect(find.text('Кость хитов'), findsOneWidget);
      expect(find.text('d10'), findsOneWidget);
    });

    testWidgets('character alignment field fits narrow sheet widths',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            alignmentValue: protocol.CharacterAlignment.lawfulNeutral,
          ),
        },
      );

      await _pumpCharacterSheet(
        tester,
        repository,
        surfaceSize: const Size(360, 800),
      );

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      await tester.drag(_characterPageScrollable(), const Offset(0, -500));
      await tester.pumpAndSettle();

      expect(find.text('Принципиальный'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('character alignment dialog updates selected value',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            alignmentValue: protocol.CharacterAlignment.lawfulGood,
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      await tester.drag(_characterPageScrollable(), const Offset(0, -500));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Выбрать мировоззрение'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Х-З').first);
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.alignmentValue,
        protocol.CharacterAlignment.chaoticEvil,
      );
      expect(find.byType(AlertDialog), findsNothing);

      await tester.tap(find.byTooltip('Выбрать мировоззрение'));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Без мировоззрения').first);
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.alignmentValue,
        protocol.CharacterAlignment.unaligned,
      );
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('burger opens attributes page and returns to previous tab',
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
      expect(find.byTooltip('Добавить заметку'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text('Характеристики'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('attribute-card-strength')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey('attribute-card-intelligence')),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('attribute-card-charisma')),
        300,
      );
      expect(
        find.byKey(const ValueKey('attribute-card-charisma')),
        findsOneWidget,
      );
      await tester.scrollUntilVisible(
        find.byIcon(Icons.close_rounded),
        -300,
      );
      expect(find.text('Акробатика'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byIcon(Icons.menu), findsNothing);
      expect(find.byIcon(Icons.close_rounded), findsOneWidget);

      final closeButton = find.byIcon(Icons.close_rounded);
      await tester.ensureVisible(closeButton);
      await tester.pumpAndSettle();
      await tester.tap(closeButton, warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byTooltip('Добавить заметку'), findsOneWidget);
      expect(find.byType(NavigationBar), findsOneWidget);
    });

    testWidgets('settings action opens character settings route',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );

      await _pumpCharacterSheetRouter(tester, repository);

      await tester.tap(find.byTooltip('Настройки персонажа'));
      await tester.pumpAndSettle();

      expect(find.text('Настройки персонажа'), findsNWidgets(2));
      expect(find.text('Внешний вид'), findsOneWidget);
      expect(find.text('Как в системе'), findsOneWidget);
      expect(find.text('Синхронизировано'), findsOneWidget);

      await tester.tap(find.byTooltip('Назад'));
      await tester.pumpAndSettle();

      expect(find.text('Атаки'), findsOneWidget);
    });

    testWidgets('character settings route keeps pending sync status',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
          ),
        },
      );

      await _pumpCharacterSheetRouter(
        tester,
        repository,
        offlineRecord: OfflineCharacterRecord(
          userId: 7,
          localId: 1,
          serverId: 1,
          character: protocol.CharacterData(id: 1, name: 'Тестовый герой'),
          status: OfflineCharacterSyncStatus.dirty,
          operation: OfflineCharacterSyncOperation.upsert,
        ),
      );

      await tester.tap(find.byTooltip('Настройки персонажа'));
      await tester.pumpAndSettle();

      expect(find.text('Внешний вид'), findsOneWidget);
      expect(find.text('Ожидает синхронизации'), findsOneWidget);
    });

    testWidgets('notes tab shows, adds, edits, and deletes notes',
        (tester) async {
      final repository = _FakeCharacterRepository(
        charactersById: {
          1: protocol.CharacterData(
            id: 1,
            name: 'Тестовый герой',
            notes: [
              protocol.CharacterNoteData(
                id: 'note-1',
                text: 'Первая заметка',
              ),
            ],
          ),
        },
      );

      await _pumpCharacterSheet(tester, repository);

      await tester.tap(find.byIcon(Icons.note));
      await tester.pumpAndSettle();

      expect(find.byTooltip('Добавить заметку'), findsOneWidget);
      expect(find.text('Первая заметка'), findsOneWidget);

      await tester.enterText(_noteField('Заметка 1'), 'Обновленная заметка');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.notes?.map((note) => note.text).toList(),
        const ['Обновленная заметка'],
      );

      await tester.tap(find.byTooltip('Добавить заметку'));
      await tester.pumpAndSettle();
      await tester.enterText(_noteField('Заметка 2'), 'Новая заметка');
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.notes?.map((note) => note.text).toList(),
        const ['Обновленная заметка', 'Новая заметка'],
      );

      await tester.tap(find.text('Удалить').first);
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.notes?.map((note) => note.text).toList(),
        const ['Обновленная заметка', 'Новая заметка'],
      );
      expect(find.text('Точно?'), findsOneWidget);

      await tester.tap(find.text('Точно?'));
      await tester.pumpAndSettle();

      expect(
        repository.charactersById[1]?.notes?.map((note) => note.text).toList(),
        const ['Новая заметка'],
      );
    });

    testWidgets('notes tab keeps multiple unsaved blank notes focusable',
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

      await tester.tap(find.byIcon(Icons.note));
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Добавить заметку'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Добавить заметку'));
      await tester.pumpAndSettle();
      await tester.tap(_noteField('Заметка 1'));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(repository.charactersById[1]?.notes, isNull);
      expect(_noteField('Заметка 1'), findsOneWidget);
      expect(_noteField('Заметка 2'), findsOneWidget);
    });
  });
}

Finder _noteField(String label) {
  return _textField(label);
}

Finder _textField(String label) {
  return find.byWidgetPredicate(
    (widget) => widget is TextField && widget.decoration?.labelText == label,
  );
}

Finder _characterPageScrollable() {
  return find.byType(ListView).first;
}

Future<void> _showStatusIcons(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('status-visibility-toggle')));
  await tester.pumpAndSettle();
}

Future<void> _showStatusLabels(WidgetTester tester) async {
  await _showStatusIcons(tester);
  await tester.tap(find.byKey(const ValueKey('status-visibility-toggle')));
  await tester.pumpAndSettle();
}

Future<void> _pumpCharacterSheet(
  WidgetTester tester,
  _FakeCharacterRepository repository, {
  Size surfaceSize = const Size(1280, 800),
  OfflineCharacterRecord? offlineRecord,
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
        if (offlineRecord != null)
          offlineCharacterRecordProvider(1).overrideWith(
            (ref) async => offlineRecord,
          ),
      ],
      child: MaterialApp(
        theme: darkTheme,
        home: const CharacterSheet(characterId: 1),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpCharacterSheetRouter(
  WidgetTester tester,
  _FakeCharacterRepository repository, {
  Size surfaceSize = const Size(1280, 800),
  OfflineCharacterRecord? offlineRecord,
}) async {
  await tester.binding.setSurfaceSize(surfaceSize);
  addTearDown(() => tester.binding.setSurfaceSize(null));

  final router = GoRouter(
    initialLocation: '/characters/sheet/1',
    routes: [
      GoRoute(
        path: '/characters/sheet/:id',
        builder: (_, state) {
          final characterId = int.parse(state.pathParameters['id']!);
          return CharacterSheet(characterId: characterId);
        },
      ),
      GoRoute(
        path: '/characters/sheet/:id/settings',
        builder: (_, state) {
          final characterId = int.parse(state.pathParameters['id']!);
          return CharacterSheetSettingsPage(characterId: characterId);
        },
      ),
    ],
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        characterRepositoryProvider.overrideWithValue(repository),
        userSettingsRepositoryProvider.overrideWithValue(
          UserSettingsRepository(storage: _FakeStorage()),
        ),
        if (offlineRecord != null)
          offlineCharacterRecordProvider(1).overrideWith(
            (ref) async => offlineRecord,
          ),
      ],
      child: MaterialApp.router(
        theme: darkTheme,
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _dragWithPointerKind(
  WidgetTester tester,
  Finder target,
  Offset offset,
  PointerDeviceKind kind,
) async {
  final start = tester.getCenter(target);
  final gesture = await tester.createGesture(kind: kind);
  await gesture.down(start);
  await tester.pump();
  await gesture.moveTo(start + offset);
  await tester.pump();
  await gesture.up();
  await tester.pumpAndSettle();
}

class _FakeCharacterRepository extends CharacterRepository {
  _FakeCharacterRepository({
    required Map<int, protocol.CharacterData> charactersById,
  }) : _charactersById = Map<int, protocol.CharacterData>.from(charactersById);

  final Map<int, protocol.CharacterData> _charactersById;
  int getCharacterCallCount = 0;

  Map<int, protocol.CharacterData> get charactersById => _charactersById;

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

class _FakeStorage implements Storage {
  final Map<String, Object> values = {};

  @override
  Future<int?> getInt(String key) async {
    return values[key] as int?;
  }

  @override
  Future<String?> getString(String key) async {
    return values[key] as String?;
  }

  @override
  Future<void> remove(String key) async {
    values.remove(key);
  }

  @override
  Future<void> setInt(String key, int value) async {
    values[key] = value;
  }

  @override
  Future<void> setString(String key, String value) async {
    values[key] = value;
  }
}
