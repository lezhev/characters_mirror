import 'dart:ui' show PointerDeviceKind;
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_item.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dm_statblock_test.dart' show creature, item;

Widget app(Widget child) =>
    MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child)));

void main() {
  for (final dark in [false, true]) {
    testWidgets(
        'item padding and secondary typography stay stable on hover dark $dark',
        (tester) async {
      const itemKey = ValueKey('padded-action');
      const action = DmItemView(
          id: 'padding',
          name: 'Укус',
          section: DmSection.actions,
          summary: 'Краткая сводка',
          description: 'Полное описание действия для выделения и копирования.',
          lines: []);
      await tester.pumpWidget(MaterialApp(
          theme: dark ? ThemeData.dark() : ThemeData.light(),
          home: const Scaffold(
              body: SingleChildScrollView(
                  child: DmStatblockItem(key: itemKey, item: action)))));
      final tile = find.byKey(itemKey);
      final title = find.text(action.name), summary = find.text(action.summary);
      final theme = Theme.of(tester.element(tile));
      final expectedStyle = theme.textTheme.bodySmall!
          .copyWith(color: theme.colorScheme.onSurfaceVariant);
      final origin = tester.getTopLeft(tile);
      final titlePosition = tester.getTopLeft(title);
      expect(titlePosition.dx - origin.dx, 12);
      expect(titlePosition.dy - origin.dy, 8);
      expect(tester.widget<Text>(summary).style, expectedStyle);
      final header = find.descendant(of: tile, matching: find.byType(InkWell));
      expect(tester.widget<InkWell>(header).borderRadius,
          BorderRadius.circular(8));
      final headerPadding =
          find.descendant(of: header, matching: find.byType(Padding)).first;
      expect(tester.widget<Padding>(headerPadding).padding,
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8));
      final summaryPosition = tester.getTopLeft(summary);
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: tester.getCenter(header));
      await tester.pumpAndSettle();
      expect(tester.getTopLeft(title), titlePosition);
      expect(tester.getTopLeft(summary), summaryPosition);
      await tester.tap(title);
      await tester.pumpAndSettle();
      final description = find.byType(SelectableText);
      expect(
          tester.widget<SelectableText>(description).data, action.description);
      expect(tester.widget<SelectableText>(description).style, expectedStyle);
      expect(tester.getTopLeft(description).dx, titlePosition.dx);
      expect(tester.getTopLeft(title).dx, titlePosition.dx);
      final expandedTitlePosition = tester.getTopLeft(title);
      final bodyPadding =
          find.ancestor(of: description, matching: find.byType(Padding)).first;
      expect(tester.widget<Padding>(bodyPadding).padding,
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8));
      expect(find.text(action.summary), findsNothing);
      await mouse.removePointer();
      await tester.pumpAndSettle();
      expect(tester.getTopLeft(title), expandedTitlePosition);
      expect(tester.getTopLeft(description).dx, titlePosition.dx);
      await tester.tap(title);
      await tester.pumpAndSettle();
      expect(tester.getTopLeft(summary), summaryPosition);
      expect(find.byType(SelectableText), findsNothing);
    });
  }
  testWidgets('a new source resets a reused disclosure to closed',
      (tester) async {
    DmItemView action(String description) => DmItemView(
        id: 'same',
        name: 'Правила',
        section: DmSection.other,
        summary: '',
        description: description,
        lines: const []);
    await tester
        .pumpWidget(app(DmStatblockItem(item: action('Первый источник'))));
    await tester.tap(find.text('Правила'));
    await tester.pumpAndSettle();
    expect(find.text('Первый источник'), findsOneWidget);
    await tester
        .pumpWidget(app(DmStatblockItem(item: action('Новый источник'))));
    await tester.pump();
    expect(find.text('Новый источник'), findsNothing);
  });

  testWidgets('one legendary cap leaves no empty metric or rules disclosure',
      (tester) async {
    final view = DmStatblock.fromCreature(creature(resources: {
      'legres': {'max': 2}
    }));
    await tester.pumpWidget(app(DmStatblockView(statblock: view)));
    expect(find.text('Сопротивления'), findsOneWidget);
    expect(find.text('Легендарные действия'), findsNothing);
    expect(find.text('Правила использования'), findsNothing);
    expect(find.text('в день'), findsNothing);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('a description without summary still expands unchanged',
      (tester) async {
    const description =
        '<p>Исходный текст: 7, 14, 2d6.</p>\nБез разбора и сверки.';
    await tester.pumpWidget(app(const DmStatblockItem(
        item: DmItemView(
            id: 'opaque',
            name: 'Особенность',
            section: DmSection.traits,
            summary: '',
            description: description,
            lines: []))));
    await tester.tap(find.text('Особенность'));
    await tester.pumpAndSettle();
    expect(find.text(description), findsOneWidget);
    expect(find.text('Игровые параметры'), findsNothing);
  });
  testWidgets('expanded action displays only the original description',
      (tester) async {
    final action = DmStatblock.fromCreature(creature(items: [
      item('Укус', 'feat', 'action', extra: {
        'description': 'Урон: 2d6 (огонь)\nУсловие полностью сохранено.',
        'damageParts': [
          ['2d6', 'fire']
        ],
        'range': {'value': 30, 'units': 'ft'}
      })
    ])).blocks.expand((b) => b.items).single;
    await tester.pumpWidget(app(DmStatblockItem(item: action)));
    expect(find.text(action.summary), findsOneWidget);
    await tester.tap(find.text('Укус'));
    await tester.pumpAndSettle();
    expect(find.text(action.description), findsOneWidget);
    expect(find.text(action.summary), findsNothing);
    expect(find.text('Игровые параметры'), findsNothing);
    expect(find.text('Дистанция: 30 фт.'), findsNothing);
  });

  for (final summary in ['', 'Сводка без описания']) {
    testWidgets(
        'empty description has no toggle and retains summary "$summary"',
        (tester) async {
      await tester.pumpWidget(app(DmStatblockItem(
          item: DmItemView(
              id: 'empty',
              name: 'Пустое',
              section: DmSection.actions,
              summary: summary,
              description: '',
              lines: const []))));
      expect(find.byIcon(Icons.expand_more), findsNothing);
      await tester.tap(find.text('Пустое'));
      await tester.pump();
      if (summary.isNotEmpty) expect(find.text(summary), findsOneWidget);
    });
  }

  testWidgets('legendary header, one disclosure and readable action cost',
      (tester) async {
    final view = DmStatblock.fromCreature(creature(resources: {
      'legact': {'max': 3},
      'legres': {'max': 3}
    }, items: [
      item('Легендарные действия', 'feat', '', extra: {
        'description':
            'Дракон может совершить 3 легендарных действия в конце хода другого существа. Восстанавливает их в начале своего хода.'
      }),
      item('Устойчивость', 'feat', '', extra: {
        'uses': {'max': 3, 'per': 'day'},
        'consume': {
          'type': 'attribute',
          'target': 'resources.legres.value',
          'amount': 1
        }
      }),
      item('Крылья', 'feat', 'legendary', extra: {'activationCost': 2})
    ]));
    await tester.pumpWidget(app(DmStatblockView(statblock: view)));
    expect(find.text('Правила использования'), findsOneWidget);
    expect(find.text('Действия (макс.): 3'), findsNothing);
    expect(find.text('Легендарные сопротивления (макс.): 3'), findsNothing);
    expect(find.text('за раунд'), findsOneWidget);
    expect(find.text('в день'), findsOneWidget);
    expect(find.text('2 действия'), findsOneWidget);
    expect(find.text('Устойчивость'), findsNothing);
    await tester.ensureVisible(find.text('Правила использования'));
    await tester.tap(find.text('Правила использования'));
    await tester.pumpAndSettle();
    expect(find.text('Устойчивость'), findsOneWidget);
    expect(find.text('Полное описание Устойчивость'), findsOneWidget);
  });

  testWidgets('linked caster rules and slots have one visual location',
      (tester) async {
    final view = DmStatblock.fromCreature(
        creature(abilities: {
          'int': {'score': 17}
        }, otherStats: {
          'proficiencyBonus': 3
        }, items: [
          item('Заклинания', 'feat', '', extra: {
            'description': 'Исходные правила с нестандартным условием.'
          }),
          item('Свет', 'spell', 'action', extra: {
            'spellLevel': 0,
            'spellProperties': {
              'preparation': {'mode': 'always'}
            }
          }),
          item('Щит', 'spell', 'reaction', extra: {
            'spellLevel': 1,
            'spellProperties': {
              'preparation': {'mode': 'prepared'}
            }
          })
        ]),
        sourceActor: {
          'system': {
            'attributes': {'spellcasting': 'int'},
            'details': {'spellLevel': 9}
          }
        });
    await tester.pumpWidget(app(DmStatblockView(statblock: view)));
    expect(find.text('Особенности'), findsNothing);
    expect(find.text('Правила заклинателя'), findsOneWidget);
    expect(find.text('Заговоры'), findsOneWidget);
    expect(find.text('Неограниченно'), findsOneWidget);
    expect(find.text('1-й круг'), findsOneWidget);
    expect(find.text('4 ячейки'), findsOneWidget);
    expect(find.text('Ячейки 1-го уровня (макс.): 4'), findsNothing);
    expect(find.text('СЛ заклинаний'), findsOneWidget);
    expect(find.text('14'), findsOneWidget);
    expect(find.text('+6'), findsOneWidget);
    await tester.ensureVisible(find.text('Правила заклинателя'));
    await tester.tap(find.text('Правила заклинателя'));
    await tester.pumpAndSettle();
    expect(find.text('Исходные правила с нестандартным условием.'),
        findsOneWidget);
  });
}
