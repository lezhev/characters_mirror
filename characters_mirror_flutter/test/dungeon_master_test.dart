import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';

import 'package:characters_mirror_client/characters_mirror_client.dart'
    as protocol;
import 'package:characters_mirror_flutter/core/router/app_router.dart';
import 'package:characters_mirror_flutter/features/auth/auth.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/characters/application/characters_list_state.dart';
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as auth;
import 'package:characters_mirror_flutter/features/dungeon_master/data/dm_creature_repository.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/data/dm_creature_file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:file_selector/file_selector.dart';
import 'widget_test.dart' show FakeAuthService, FakeCharacterRepository;

void main() {
  for (final scopes in [
    <String>[],
    ['gm'],
    ['admin']
  ]) {
    testWidgets('entry visibility and narrow header for scopes $scopes',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(380, 720));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final fixture = DmFixture(scopes: scopes);
      await tester.pumpWidget(fixture.app());
      await tester.pumpAndSettle();
      expect(
          find.text('Мастер'), scopes.isEmpty ? findsNothing : findsOneWidget);
      expect(tester.takeException(), isNull);
      if (scopes.isNotEmpty) {
        await tester.tap(find.text('Мастер'));
        await tester.pumpAndSettle();
        expect(find.text('Библиотека пуста'), findsOneWidget);
        expect(fixture.routerLocation, '/dm');
      }
    });
  }

  testWidgets('direct DM route rejects ordinary user', (tester) async {
    final fixture = DmFixture(scopes: []);
    await tester.pumpWidget(fixture.app());
    await tester.pumpAndSettle();
    fixture.container!.read(routerProvider).go('/dm');
    await tester.pumpAndSettle();
    expect(fixture.routerLocation, '/characters');
    expect(fixture.repository.listCalls, 0);
  });

  testWidgets('cancelled system picker does not import or show error',
      (tester) async {
    final fixture = DmFixture();
    await fixture.openDm(tester);
    await tester.tap(find.text('Импортировать'));
    await tester.pumpAndSettle();
    expect(fixture.repository.importCalls, 0);
    expect(find.byType(SnackBar), findsNothing);
    expect(find.text('Библиотека пуста'), findsOneWidget);
  });

  testWidgets('import, detail, raw JSON, confirmed deletion and cancellation',
      (tester) async {
    final fixture = DmFixture()..picker.raw = '{"test":"original"}';
    await fixture.openDm(tester);
    await tester.tap(find.text('Импортировать'));
    await tester.pumpAndSettle();
    expect(find.text('Маг'), findsOneWidget);
    expect(find.textContaining('HP 40'), findsOneWidget);
    await tester.tap(find.text('Маг'));
    await tester.pumpAndSettle();
    expect(fixture.routerLocation, '/dm/creatures/1');
    expect(find.text('КД: 12'), findsOneWidget);
    expect(find.text('HP: 40 / 40'), findsOneWidget);
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -600));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Исходный JSON'));
    await tester.tap(find.text('Исходный JSON'));
    await tester.pumpAndSettle();
    expect(find.textContaining('original'), findsOneWidget);
    fixture.container!.read(routerProvider).go('/dm');
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Удалить'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Отмена'));
    await tester.pumpAndSettle();
    expect(fixture.repository.deleteCalls, 0);
    await tester.tap(find.byTooltip('Удалить'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Удалить'));
    await tester.pumpAndSettle();
    expect(fixture.repository.deleteCalls, 1);
    expect(find.text('Библиотека пуста'), findsOneWidget);
  });

  testWidgets('import and delete errors keep truthful state', (tester) async {
    final fixture = DmFixture()..picker.raw = '{}';
    fixture.repository.failImport = true;
    await fixture.openDm(tester);
    await tester.tap(find.text('Импортировать'));
    await tester.pumpAndSettle();
    expect(find.text('Ошибка тестового импорта'), findsOneWidget);
    expect(find.text('Библиотека пуста'), findsOneWidget);
    fixture.repository.failImport = false;
    await tester.tap(find.text('Импортировать'));
    await tester.pumpAndSettle();
    fixture.repository.failDelete = true;
    await tester.tap(find.byTooltip('Удалить'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Удалить'));
    await tester.pumpAndSettle();
    expect(find.text('Маг'), findsOneWidget);
    expect(find.text('Ошибка тестового удаления'), findsOneWidget);
  });

  testWidgets('batch summary shows file names, duplicates and read failures',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(380, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final fixture = DmFixture()
      ..picker.files = [
        XFile.fromData(Uint8List.fromList(utf8.encode('{"test":"mage"}')),
            path: 'Mage.json', name: 'Mage.json'),
        XFile.fromData(Uint8List.fromList(utf8.encode('{"test":"mage"}')),
            path: 'Mage (1).json', name: 'Mage (1).json'),
        XFile.fromData(Uint8List.fromList([0xff]),
            path: 'broken.json', name: 'broken.json'),
      ];
    await fixture.openDm(tester);
    await tester.tap(find.text('Импортировать'));
    await tester.pumpAndSettle();
    expect(find.text('Результаты импорта'), findsOneWidget);
    expect(find.text('Импортировано: 1 · Уже в библиотеке: 1 · Ошибок: 1'),
        findsOneWidget);
    expect(find.text('Mage.json'), findsOneWidget);
    expect(find.text('Mage (1).json'), findsOneWidget);
    expect(find.text('broken.json'), findsOneWidget);
    expect(find.textContaining('Файл должен быть сохранён в UTF-8.'),
        findsOneWidget);
    expect(fixture.repository.importCalls, 2);
    expect(fixture.repository.rows, hasLength(1));
    expect(tester.takeException(), null);
    await tester.tap(find.text('Закрыть'));
    await tester.pumpAndSettle();
    expect(find.text('Результаты импорта'), findsNothing);
    expect(find.text('Маг'), findsOneWidget);
  });

  testWidgets('batch shows progress and disables repeat import',
      (tester) async {
    final gate = Completer<void>();
    final fixture = DmFixture()
      ..picker.files = [
        XFile.fromData(Uint8List.fromList(utf8.encode('first')),
            path: 'first.json', name: 'first.json'),
        XFile.fromData(Uint8List.fromList(utf8.encode('second')),
            path: 'second.json', name: 'second.json'),
      ];
    fixture.repository.importGate = gate.future;
    await fixture.openDm(tester);
    await tester.tap(find.text('Импортировать'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('Импорт: 0 из 2 · first.json'), findsOneWidget);
    expect(
        tester
            .widget<FilledButton>(find.byKey(const ValueKey('dm-import')))
            .onPressed,
        null);
    expect(fixture.repository.importCalls, 1);
    gate.complete();
    await tester.pumpAndSettle();
    expect(find.text('Результаты импорта'), findsOneWidget);
    expect(find.text('Импортировано: 2 · Уже в библиотеке: 0 · Ошибок: 0'),
        findsOneWidget);
    expect(fixture.repository.rows, hasLength(2));
  });
}

class DmFixture {
  DmFixture({List<String> scopes = const ['gm']})
      : service = FakeAuthService.signedIn(auth.UserInfo(
            userIdentifier: 'dm-widget',
            userName: 'Мастер',
            created: DateTime(2026),
            scopeNames: scopes,
            blocked: false));
  final FakeAuthService service;
  final repository = FakeDmRepository();
  final picker = FakeDmPicker();
  ProviderContainer? container;
  String get routerLocation => container!
      .read(routerProvider)
      .routerDelegate
      .currentConfiguration
      .last
      .matchedLocation;

  Widget app() => ProviderScope(
          overrides: [
            authServiceProvider.overrideWithValue(service),
            characterRepositoryProvider
                .overrideWithValue(FakeCharacterRepository()),
            charactersListControllerProvider.overrideWith(
                (ref) => CharactersListController(FakeCharacterRepository())),
            dmCreatureRepositoryProvider.overrideWithValue(repository),
            dmCreatureFilePickerProvider.overrideWithValue(picker),
          ],
          child: Consumer(builder: (context, ref, _) {
            container = ProviderScope.containerOf(context);
            return MaterialApp.router(routerConfig: ref.watch(routerProvider));
          }));

  Future<void> openDm(WidgetTester tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    container!.read(routerProvider).go('/dm');
    await tester.pumpAndSettle();
  }
}

class FakeDmPicker implements DmCreatureFilePicker {
  String? raw;
  List<XFile>? files;
  @override
  Future<List<XFile>> pickJsonFiles() async =>
      files ??
      (raw == null
          ? []
          : [
              XFile.fromData(Uint8List.fromList(utf8.encode(raw!)),
                  path: 'Mage.json', name: 'Mage.json'),
            ]);
}

class FakeDmRepository implements DmCreatureRepository {
  final rows = <protocol.DmCreatureSummary>[];
  final _imported = <String, protocol.DmCreatureSummary>{};
  int _nextId = 1;
  int listCalls = 0, importCalls = 0, deleteCalls = 0;
  bool failImport = false, failDelete = false;
  Future<void>? importGate;
  String raw = '{}';
  @override
  Future<List<protocol.DmCreatureSummary>> list() async {
    listCalls++;
    return [...rows];
  }

  @override
  Future<protocol.DmCreatureImportResult> import(String rawJson) async {
    importCalls++;
    if (importGate != null) await importGate;
    if (failImport) {
      throw protocol.DmCreatureException(
          code: 'test', message: 'Ошибка тестового импорта');
    }
    raw = rawJson;
    final existing = _imported[rawJson];
    if (existing != null) {
      return protocol.DmCreatureImportResult(
          creature: existing, duplicate: true);
    }
    final summary = protocol.DmCreatureSummary(
        id: _nextId++,
        name: 'Маг',
        challengeRating: '6',
        hpMax: 40,
        createdAt: DateTime(2026, 10, 13));
    rows.add(summary);
    _imported[rawJson] = summary;
    return protocol.DmCreatureImportResult(creature: summary, duplicate: false);
  }

  @override
  Future<void> delete(int id) async {
    deleteCalls++;
    if (failDelete) {
      throw protocol.DmCreatureException(
          code: 'test', message: 'Ошибка тестового удаления');
    }
    rows.removeWhere((row) => row.id == id);
    _imported.removeWhere((_, row) => row.id == id);
  }

  @override
  Future<protocol.DmCreatureRecord> get(int id) async => protocol.DmCreatureRecord(
      id: id,
      userId: 1,
      name: 'Маг',
      sourceType: 'foundry_dnd5e',
      rawJson: raw,
      normalizedJson:
          '{"schemaVersion":1,"identity":{"name":"Маг"},"combat":{"armorClass":12,"hpMax":40,"hpInitial":40},"abilities":{},"defenses":{},"otherStats":{},"resources":{},"spellSlots":{},"items":[],"diagnostics":[]}',
      importHash: 'hash',
      schemaVersion: 1,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026));
}
