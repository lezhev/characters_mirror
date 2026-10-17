import 'dart:convert';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dm_statblock_test.dart' show creature, item;

Map<String, Object?> spell(String name, String mode, int? level,
        {Map<String, Object?> extra = const {}}) =>
    item(name, 'spell', 'action', extra: {
      'spellLevel': level,
      'spellProperties': {
        'preparation': {'mode': mode}
      },
      ...extra,
    });
DmMagicView magic(DmStatblock view) =>
    view.groups.singleWhere((g) => g.id == 'spells').magic!;

void main() {
  test('limited at-will metadata is not labelled unlimited', () {
    final view = DmStatblock.fromCreature(creature(items: [
      spell('Ограничено', 'atwill', 1, extra: {
        'uses': {'max': 2, 'per': 'lr'}
      })
    ]));
    expect(
        magic(view).spells.single.title, 'Ограниченное применение · 1-й круг');
    expect(magic(view).spells.single.usage, '2 / продолжительный отдых');
  });
  test('casting modes and separate limited maxima never borrow ordinary slots',
      () {
    final input = creature(spellSlots: {
      'spell1': {'max': 4},
      'pact': {'max': 2, 'level': 3}
    }, items: [
      spell('Заговор', 'always', 0),
      spell('Обычное', 'prepared', 1),
      spell('Неограниченное', 'atwill', 1),
      spell('Врождённое', 'innate', 1),
      spell('Три в день', 'innate', 1, extra: {
        'uses': {'max': '3', 'per': 'day'}
      }),
      spell('Одно за отдых', 'innate', 1, extra: {
        'uses': {'max': '1', 'per': 'sr'}
      }),
      spell('Договор', 'pact', 1),
      spell('Неизвестное', 'custom', 1),
      spell('Без уровня', 'prepared', null),
    ]);
    final before = jsonEncode(input.toJson());
    final view = DmStatblock.fromCreature(input);
    final groups = magic(view).spells;
    String usage(String name) =>
        groups.singleWhere((g) => g.items.any((i) => i.name == name)).usage;
    expect(usage('Обычное'), '4 ячейки');
    expect(usage('Заговор'), 'Неограниченно');
    expect(usage('Неограниченное'), 'Неограниченно');
    expect(usage('Врождённое'), '');
    expect(usage('Три в день'), '3 / сутки');
    expect(usage('Одно за отдых'), '1 / короткий отдых');
    expect(usage('Договор'), '2 ячейки · 3-й круг ячеек');
    expect(usage('Неизвестное'), '');
    expect(usage('Без уровня'), '');
    expect(groups, hasLength(9));
    expect(
        groups.expand((g) => g.items).map((i) => i.id).toSet(), hasLength(9));
    expect(view.groups.any((g) => g.id == 'resources'), false);
    expect(jsonEncode(input.toJson()), before);
  });

  test('current slots cannot become caps and unlinked resources stay visible',
      () {
    final view = DmStatblock.fromCreature(creature(spellSlots: {
      'spell1': {'value': 99},
      'spell2': {'max': 3}
    }, resources: {
      'primary': {'max': 7, 'value': 1, 'label': 'Особый ресурс'}
    }, items: [
      spell('Магия', 'prepared', 1)
    ]));
    expect(magic(view).spells.single.usage, '');
    final resources = view.groups
        .singleWhere((g) => g.id == 'resources')
        .blocks
        .expand((b) => b.lines)
        .map((l) => l.text);
    expect(
        resources,
        containsAll(
            ['Особый ресурс (макс.): 7', 'Ячейки 2-го уровня (макс.): 3']));
  });

  test('an explicit spell resource link moves its cap only once', () {
    final view = DmStatblock.fromCreature(creature(resources: {
      'primary': {'label': 'Магические заряды', 'max': 5, 'value': 1},
      'secondary': {'label': 'Другое', 'max': 8}
    }, items: [
      spell('Заряд', 'prepared', 2, extra: {
        'consume': {
          'type': 'attribute',
          'target': 'resources.primary.value',
          'amount': 2
        }
      })
    ]));
    expect(magic(view).spells.single.usage,
        'Магические заряды: 5 (макс.) · расход 2');
    final resources = view.groups
        .singleWhere((g) => g.id == 'resources')
        .blocks
        .expand((b) => b.lines)
        .map((l) => l.text);
    expect(resources, ['Другое (макс.): 8']);
  });

  test(
      'unknown header fields are hidden independently, formulas are not evaluated',
      () {
    final input = creature(abilities: {
      'int': {'score': 16}
    }, otherStats: {
      'proficiencyBonus': 2,
      'bonuses': {
        'spell': {'dc': '1d4'}
      }
    }, items: [
      spell('Магия', 'prepared', 1)
    ]);
    final header = magic(DmStatblock.fromCreature(input, sourceActor: {
      'system': {
        'attributes': {'spellcasting': 'int'}
      }
    })).header;
    expect(
        header.map((l) => l.text), ['Характеристика: ИНТ', 'Бонус атаки: +5']);
    expect(magic(DmStatblock.fromCreature(input)).header, isEmpty);
  });

  test('different melee and ranged spell bonuses do not fabricate one total',
      () {
    final view = DmStatblock.fromCreature(
        creature(abilities: {
          'cha': {'score': 16}
        }, otherStats: {
          'proficiencyBonus': 2,
          'bonuses': {
            'msak': {'attack': '2'},
            'rsak': {'attack': '3'}
          }
        }, items: [
          spell('Магия', 'innate', 1)
        ]),
        sourceActor: {
          'system': {
            'attributes': {'spellcasting': 'cha'}
          }
        });
    expect(magic(view).header.map((l) => l.text),
        ['Характеристика: ХАР', 'СЛ заклинаний: 13']);
  });

  test('name alone and ambiguous features are not moved to caster rules', () {
    final entries = [
      item('Заклинания', 'feat', ''),
      item('Spellcasting', 'feat', ''),
      spell('Магия', 'prepared', 1)
    ];
    final view = DmStatblock.fromCreature(
        creature(abilities: {
          'int': {'score': 16}
        }, items: entries),
        sourceActor: {
          'system': {
            'attributes': {'spellcasting': 'int'},
            'details': {'spellLevel': 9}
          }
        });
    expect(magic(view).rules, isEmpty);
    expect(
        view.groups
            .singleWhere((g) => g.id == 'traits')
            .blocks
            .expand((b) => b.items),
        hasLength(2));
    final noCaster = DmStatblock.fromCreature(
        creature(items: [entries.first, entries.last]));
    expect(magic(noCaster).rules, isEmpty);
  });

  test('text-only caster retains its original feature as primary information',
      () {
    final source = item('Заклинания', 'feat', '', extra: {
      'description': 'Нестандартное правило без отдельных заклинаний.'
    });
    final view =
        DmStatblock.fromCreature(creature(items: [source]), sourceActor: {
      'system': {
        'attributes': {'spellcasting': 'int'},
        'details': {'spellLevel': 9}
      }
    });
    expect(view.groups.any((g) => g.id == 'spells'), false);
    expect(
        view.groups
            .singleWhere((g) => g.id == 'traits')
            .blocks
            .expand((b) => b.items)
            .single
            .description,
        source['description']);
  });

  test('both casting rule sources are linked only to their corresponding modes',
      () {
    final view = DmStatblock.fromCreature(
        creature(abilities: {
          'cha': {'score': 16}
        }, items: [
          item('Spellcasting', 'feat', ''),
          item('Innate Spellcasting', 'feat', ''),
          spell('Обычное', 'prepared', 1),
          spell('Врождённое', 'innate', 1)
        ]),
        sourceActor: {
          'system': {
            'attributes': {'spellcasting': 'cha'},
            'details': {'spellLevel': 2}
          }
        });
    expect(magic(view).rules.map((i) => i.name),
        ['Spellcasting', 'Innate Spellcasting']);
    expect(view.groups.any((g) => g.id == 'traits'), false);
    expect(
        view.groups
            .expand((g) => g.blocks)
            .expand((b) => b.items)
            .map((i) => i.id)
            .toSet(),
        hasLength(4));
  });
}
