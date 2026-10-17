import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock_values.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_item.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/presentation/widgets/dm_statblock_view.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/widgets/sheet_outline_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dm_statblock_test.dart' show creature, item;

void main() {
  test(
      'a configured alternative skill ability and ability-wide bonus stay visible once',
      () {
    final view = DmStatblock.fromCreature(creature(abilities: {
      'str': {'score': 16},
      'dex': {
        'score': 10,
        'bonuses': {'check': '2'}
      }
    }, otherStats: {
      'skills': {
        'acr': {
          'value': 0,
          'ability': 'str',
          'bonuses': {'check': '0'}
        },
        'ste': {
          'value': 0,
          'ability': 'dex',
          'bonuses': {'check': '0'}
        }
      }
    }));
    final lines =
        view.blocks.expand((b) => b.lines).map((l) => l.text).toList();
    expect(
        lines,
        containsAll([
          'Акробатика: +3',
          'Акробатика: характеристика: СИЛ',
          'Проверки ЛОВ: доп. бонус: 2'
        ]));
    expect(lines.where((l) => l.startsWith('Проверки ЛОВ:')), hasLength(1));
    expect(lines.any((l) => l.startsWith('Скрытность:')), false);
  });
  testWidgets('unopened actions dispose without creating a late ticker',
      (tester) async {
    final view = DmStatblock.fromCreature(
        creature(items: [item('Действие', 'feat', 'action')]));
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: DmStatblockItem(
                item: view.blocks.expand((b) => b.items).single))));
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
    expect(tester.takeException(), null);
  });
  test(
      'special total formulas and non-finite text never become numeric bonuses',
      () {
    expect(dmNumber('1e999'), null);
    final view = DmStatblock.fromCreature(creature(abilities: {
      'int': {'score': 12}
    }, otherStats: {
      'skills': {
        'his': {
          'value': 0,
          'ability': 'int',
          'total': '1d4',
          'bonuses': {'check': '0'}
        }
      }
    }));
    final lines = view.blocks.expand((b) => b.lines).map((l) => l.text);
    expect(lines, containsAll(['История: —', 'История: особый итог: 1d4']));
  });
  test('description and internal mechanics remain independent and unchanged',
      () {
    final view = DmStatblock.fromCreature(creature(items: [
      item('Действие', 'feat', 'action', extra: {
        'description': 'Урон: 2d6 (огонь)\nДополнительное условие сохраняется.',
        'damageParts': [
          ['2d6', 'fire']
        ],
        'range': {'value': 30, 'units': 'ft'}
      })
    ]));
    final action = view.blocks.expand((b) => b.items).single;
    expect((action.displayLines ?? action.lines).any((l) => l.label == 'Урон'),
        true);
    expect(
        (action.displayLines ?? action.lines)
            .any((l) => l.label == 'Дистанция'),
        true);
    expect(action.description,
        'Урон: 2d6 (огонь)\nДополнительное условие сохраняется.');
    expect(action.lines.any((l) => l.label == 'Урон'), true);
  });
  for (final zero in [0, 0.0, '0', '0.0', '+0', '-0.00', ' 0e0 ']) {
    test('technical zero $zero does not activate untrained skills or saves',
        () {
      final view = DmStatblock.fromCreature(creature(abilities: {
        'dex': {
          'score': 17,
          'saveProficiency': 0,
          'bonuses': {'save': zero}
        }
      }, otherStats: {
        'skills': {
          'acr': {
            'value': 0,
            'ability': 'dex',
            'total': zero,
            'bonuses': {'check': zero, 'passive': zero}
          }
        },
        'bonuses': {
          'abilities': {'check': zero, 'save': zero, 'skill': zero}
        }
      }));
      expect(view.blocks.any((b) => b.section == DmSection.saves), false);
    });
  }
  test(
      'trained +0 stays visible, included numeric bonuses are not repeated, formulas survive',
      () {
    final view = DmStatblock.fromCreature(creature(abilities: {
      'dex': {
        'score': 6,
        'saveProficiency': 1,
        'bonuses': {'save': '0'}
      }
    }, otherStats: {
      'proficiencyBonus': 2,
      'skills': {
        'acr': {
          'value': 1,
          'ability': 'dex',
          'bonuses': {'check': '0'}
        },
        'ste': {
          'value': 0,
          'ability': 'dex',
          'bonuses': {'check': '3'}
        },
        'his': {
          'value': 0,
          'ability': 'dex',
          'bonuses': {'check': '1d4'}
        }
      }
    }));
    final lines =
        view.blocks.expand((b) => b.lines).map((l) => l.text).toList();
    expect(
        lines,
        containsAll([
          'Спасбросок ЛОВ: +0',
          'Акробатика: +0',
          'Скрытность: +1',
          'История: —',
          'История: доп. бонус: 1d4'
        ]));
    expect(
        lines.any(
            (l) => l.contains('доп. бонус: 0') || l.contains('доп. бонус: 3')),
        false);
  });
  test('legendary features use resource links and grounded rules, appear once',
      () {
    final rules = item('Легендарные действия', 'feat', '', extra: {
      'description':
          'Дракон может совершить 3 легендарных действия в конце хода другого существа. Восстанавливает их в начале своего хода.'
    });
    final resistance =
        item('Легендарная устойчивость', 'feat', 'special', extra: {
      'consume': {
        'type': 'attribute',
        'target': 'resources.legres.value',
        'amount': 1
      },
      'description':
          'Если дракон проваливает испытание, он может сделать его успешным.'
    });
    final entries = [
      rules,
      resistance,
      item('Хвост', 'weapon', 'legendary'),
      item('Легендарная история', 'feat', '',
          extra: {'description': 'Рассказ о древних драконах.'})
    ];
    final view = DmStatblock.fromCreature(creature(resources: {
      'legact': {'max': 3},
      'legres': {'max': 3}
    }, items: entries));
    final all = view.blocks.expand((b) => b.items).toList();
    expect(all, hasLength(4));
    expect(all.map((i) => i.id).toSet(), hasLength(4));
    expect(all.singleWhere((i) => i.name == 'Легендарные действия').section,
        DmSection.legendary);
    expect(
        all
            .singleWhere((i) => i.name == 'Легендарная устойчивость')
            .section
            .name,
        'legendaryResistance');
    expect(all.singleWhere((i) => i.name == 'Легендарная история').section,
        DmSection.traits);
    expect(
        view.blocks
            .where((b) => b.section == DmSection.resources)
            .expand((b) => b.lines),
        isEmpty);
    expect(all.map((i) => i.description).toList()..sort(),
        entries.map((i) => i['description']).toList()..sort());
  });
  test('matching legendary name alone does not imply a relationship', () {
    final view = DmStatblock.fromCreature(creature(resources: {
      'legact': {'max': 3}
    }, items: [
      item('Легендарные действия', 'feat', '',
          extra: {'description': 'Не связанная с действиями заметка.'}),
      item('Хвост', 'weapon', 'legendary')
    ]));
    expect(
        view.blocks
            .expand((b) => b.items)
            .singleWhere((i) => i.name == 'Легендарные действия')
            .section,
        DmSection.traits);
  });
  testWidgets(
      'compact top uses sheet outline and keeps four stat cells together',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(380, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final view = DmStatblock.fromCreature(creature(combat: {
      'armorClass': 15,
      'hpMax': 7,
      'initiativeBonus': 2
    }, otherStats: {
      'proficiencyBonus': 2
    }, abilities: {
      'dex': {'score': 14, 'saveProficiency': 1}
    }));
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DmStatblockView(statblock: view))))));
    await tester.pump();
    expect(find.text('Боевые параметры'), findsNothing);
    expect(find.byType(SheetOutlineCard), findsWidgets);
    expect(find.byKey(const ValueKey('dm-stat-hp')), findsOneWidget);
    expect(find.byKey(const ValueKey('dm-stat-ac')), findsOneWidget);
    expect(find.byKey(const ValueKey('dm-stat-initiative')), findsOneWidget);
    expect(find.byKey(const ValueKey('dm-stat-proficiency')), findsOneWidget);
    expect(find.text('Спасброски: ЛОВ +4'), findsOneWidget);
    expect(
        tester.getSize(find.byKey(const ValueKey('dm-statblock-top'))).height,
        lessThan(450));
    final top = tester.getTopLeft(find.byKey(const ValueKey('dm-stat-ac'))).dy;
    for (final name in ['hp', 'initiative', 'proficiency']) {
      expect(tester.getTopLeft(find.byKey(ValueKey('dm-stat-$name'))).dy,
          closeTo(top, 0.1));
    }
    expect(tester.takeException(), null);
  });
  testWidgets(
      'expanded action hides summary, keeps description first and does not scroll',
      (tester) async {
    final description =
        List.filled(15, 'Полное описание с дополнительными условиями.')
            .join('\n');
    final view = DmStatblock.fromCreature(creature(items: [
      item('Укус', 'weapon', 'action', extra: {
        'description': description,
        'damageParts': [
          ['2d10 + 8', 'piercing'],
          ['2d6', 'fire']
        ],
        'attackAbility': 'str',
        'actionType': 'mwak',
        'sourceSystem': {'proficient': true}
      })
    ]));
    final action = view.blocks.expand((b) => b.items).single;
    final scroll = ScrollController();
    addTearDown(scroll.dispose);
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
                controller: scroll,
                child: Column(children: [
                  const SizedBox(height: 120),
                  DmStatblockItem(item: action),
                  const SizedBox(height: 800)
                ])))));
    await tester.pump();
    expect(find.text(action.summary), findsOneWidget);
    final before = scroll.offset;
    await tester.tap(find.text('Укус'));
    await tester.pumpAndSettle();
    expect(find.text(action.summary), findsNothing);
    expect(find.text(description), findsOneWidget);
    expect(scroll.offset, before);
    expect(find.text('Игровые параметры'), findsNothing);
    await tester.tap(find.text('Укус'));
    await tester.pumpAndSettle();
    expect(find.text(action.summary), findsOneWidget);
    expect(find.text(description), findsNothing);
    expect(tester.takeException(), null);
  });
}
