import 'dart:convert';
import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/theme/app_theme.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/dm_library_controller.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_item.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_technical_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dm_statblock_test.dart' show creature, item;

import 'support/dm_statblock_harness.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(loadDmAuditFonts);
  testWidgets('optional headings and dividers follow actual visible blocks',
      (tester) async {
    final view = DmStatblock.fromCreature(creature());
    await tester.pumpWidget(app(view));
    await tester.pump();
    expect(find.byType(Divider), findsNothing);
    expect(find.text('Защита, чувства и языки'), findsOneWidget);
    for (final text in [
      'Заклинания',
      'Ресурсы',
      'Особенности',
      'Нет данных',
      'Нет заклинаний'
    ]) {
      expect(find.text(text), findsNothing);
    }
    final withItem = DmStatblock.fromCreature(
        creature(items: [item('Особенность', 'feat', '')]));
    await tester.pumpWidget(app(withItem));
    await tester.pump();
    expect(find.byType(Divider), findsOneWidget);
    expect(find.text('Особенности'), findsOneWidget);
  });
  testWidgets(
      'long description expands fully, collapses and preserves a sibling',
      (tester) async {
    final description =
        List.filled(40, 'Длинное русское описание без обрезки.').join('\n');
    final view = DmStatblock.fromCreature(creature(items: [
      item('Особенность', 'feat', '', extra: {'description': description}),
      item('Соседняя', 'feat', '')
    ]));
    await tester.pumpWidget(app(view));
    await tester.pump();
    expect(find.text(description), findsNothing);
    await tester.ensureVisible(find.text('Особенность'));
    await tester.tap(find.text('Особенность'));
    await tester.pumpAndSettle();
    expect(find.text(description), findsOneWidget);
    expect(find.text('Соседняя'), findsOneWidget);
    await tester.ensureVisible(find.text('Особенность'));
    await tester.tap(find.text('Особенность'));
    await tester.pumpAndSettle();
    expect(find.text(description), findsNothing);
    expect(tester.takeException(), null);
  });
  testWidgets(
      'technical information is initially lazy and unknown fields stay there',
      (tester) async {
    final normalized = creature(combat: {
      'hpMax': 40,
      'hpInitial': 7
    }, items: [
      item('Особенность', 'feat', '', extra: {'newField': 'technical-only'})
    ]);
    final record = DmCreatureRecord(
        id: 1,
        userId: 1,
        name: normalized.name,
        sourceType: 'foundry_dnd5e',
        sourceVersion: '2.1.0',
        rawJson: '{"unknown":"kept"}',
        normalizedJson: jsonEncode(normalized.toJson()),
        importHash: 'hash',
        schemaVersion: 1,
        createdAt: DateTime(2026),
        updatedAt: DateTime(2026));
    final detail = DmCreatureDetail(record, normalized);
    await tester.pumpWidget(
        app(detail.statblock, technical: DmTechnicalSection(detail: detail)));
    await tester.pump();
    expect(find.text('Исходный JSON'), findsNothing);
    expect(find.textContaining('technical-only'), findsNothing);
    await tester.ensureVisible(find.text('Технические сведения'));
    await tester.tap(find.text('Технические сведения'));
    await tester.pumpAndSettle();
    expect(find.text('HP в экспорте: 7'), findsOneWidget);
    expect(find.text('Исходный JSON'), findsOneWidget);
    await tester.ensureVisible(find.text('Нормализованные данные'));
    await tester.tap(find.text('Нормализованные данные'));
    await tester.pumpAndSettle();
    expect(find.textContaining('technical-only'), findsOneWidget);
    await tester.ensureVisible(find.text('Исходный JSON'));
    await tester.tap(find.text('Исходный JSON'));
    await tester.pumpAndSettle();
    expect(find.textContaining('kept'), findsOneWidget);
    expect(tester.takeException(), null);
  });
  for (final width in [320.0, 380.0, 1100.0]) {
    for (final dark in [false, true]) {
      testWidgets('long name and all item groups fit width $width dark $dark',
          (tester) async {
        await tester.binding.setSurfaceSize(Size(width, 800));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        final view = DmStatblock.fromCreature(creature(identity: {
          'name':
              'Очень длинное название существа с особыми свойствами и длинным подтипом'
        }, abilities: {
          for (final k in ['str', 'dex', 'con', 'int', 'wis', 'cha'])
            k: {'score': 10}
        }, items: [
          item('Сложное действие с очень длинным названием', 'feat', 'action',
              extra: {
                'damageParts': [
                  ['8d10 + 7', 'fire']
                ]
              }),
          item('Щит', 'equipment', '', extra: {
            'sourceSystem': {'equipped': false, 'quantity': 0}
          })
        ]));
        await tester
            .pumpWidget(app(view, theme: dark ? darkTheme : lightTheme));
        await tester.pump();
        expect(find.byType(DmStatblockItem), findsNWidgets(2));
        expect(find.text('СИЛ'), findsOneWidget);
        expect(tester.takeException(), null);
        await tester.ensureVisible(find.text('Щит'));
        await tester.tap(find.text('Щит'));
        await tester.pumpAndSettle();
        expect(find.text('Полное описание Щит'), findsOneWidget);
        expect(find.text('Игровые параметры'), findsNothing);
        expect(find.text('Надето: Нет'), findsNothing);
        expect(find.text('Количество: 0'), findsNothing);
        final shield = view.blocks
            .expand((b) => b.items)
            .singleWhere((i) => i.name == 'Щит');
        expect(shield.lines.map((l) => l.text),
            containsAll(['Надето: Нет', 'Количество: 0']));
        expect(tester.takeException(), null);
      });
    }
  }
}
