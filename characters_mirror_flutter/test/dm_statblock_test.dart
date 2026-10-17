import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock.dart';
import 'package:characters_mirror_flutter/features/dungeon_master/application/statblock/dm_statblock_values.dart';
import 'package:flutter_test/flutter_test.dart';

NormalizedCreature creature(
        {Map<String, Object?> identity = const {},
        Map<String, Object?> combat = const {},
        Map<String, Object?> abilities = const {},
        Map<String, Object?> defenses = const {},
        Map<String, Object?> otherStats = const {},
        Map<String, Object?> resources = const {},
        Map<String, Object?> spellSlots = const {},
        List<Map<String, Object?>> items = const []}) =>
    NormalizedCreature.fromJson({
      'schemaVersion': 1,
      'identity': {'name': 'Существо', ...identity},
      'combat': combat,
      'abilities': abilities,
      'defenses': defenses,
      'otherStats': otherStats,
      'resources': resources,
      'spellSlots': spellSlots,
      'items': items,
      'diagnostics': <String>[]
    });
Map<String, Object?> item(String name, String type, String activation,
        {Map<String, Object?> extra = const {}}) =>
    {
      'name': name,
      'itemType': type,
      'activationType': activation,
      'description': 'Полное описание $name',
      ...extra
    };

void main() {
  test(
      'inactive armor formulas stay technical; custom formula references use readable labels',
      () {
    final natural = DmStatblock.fromCreature(creature(combat: {
      'armorClass': 19,
      'armorClassSource': 'natural',
      'armorClassFormula': '@attributes.ac.armor + @abilities.dex.mod + 9'
    }));
    expect(
        natural.blocks
            .expand((b) => b.lines)
            .any((l) => l.label == 'Формула КД'),
        false);
    final custom = DmStatblock.fromCreature(creature(combat: {
      'armorClassSource': 'custom',
      'armorClassFormula': '10 + @abilities.dex.mod'
    }));
    expect(custom.blocks.expand((b) => b.lines).map((l) => l.text),
        containsAll(['КД: —', 'Формула КД: 10 + модификатор ЛОВ']));
  });
  test(
      'spell details retain school timing components materials and limited usage',
      () {
    final view = DmStatblock.fromCreature(creature(items: [
      item('Ритуал', 'spell', 'minute', extra: {
        'spellLevel': 1,
        'activationCost': 10,
        'range': {'units': 'self'},
        'uses': {'max': '3', 'value': 0, 'per': 'day'},
        'recharge': {'value': 5, 'charged': false},
        'spellProperties': {
          'school': 'div',
          'duration': {'value': '1', 'units': 'hour'},
          'components': {
            'vocal': true,
            'somatic': true,
            'material': true,
            'concentration': true,
            'ritual': true
          },
          'materials': {'value': 'Жемчужина', 'cost': 100, 'consumed': false},
          'preparation': {'mode': 'innate'}
        },
      })
    ]));
    final spell = view.blocks.expand((b) => b.items).single;
    expect(spell.section, DmSection.spells);
    expect(spell.summary, contains('Уровень 1'));
    expect(
        spell.lines.map((l) => l.text),
        containsAll([
          'Школа: Прорицание',
          'Активация: мин. · 10',
          'Дистанция: на себя',
          'Длительность: 1 ч.',
          'Компоненты: В, С, М',
          'Материалы: Жемчужина',
          'Стоимость материалов: 100 зм',
          'Материалы расходуются: Нет',
          'Концентрация: Да',
          'Ритуал: Да',
          'Использования (макс.): 3 / сутки',
          'Перезарядка: 5–6'
        ]));
  });
  test(
      'save DC follows explicit scaling without treating extra attack bonus as total',
      () {
    final view = DmStatblock.fromCreature(
        creature(identity: {
          'challengeRatingValue': 6
        }, abilities: {
          'int': {'score': 17}
        }, items: [
          item('Заклинание', 'spell', 'action', extra: {
            'saveAbility': 'dex',
            'saveDc': 99,
            'saveScaling': 'spell',
            'spellLevel': 3,
          })
        ]),
        sourceActor: {
          'system': {
            'attributes': {'spellcasting': 'int'}
          }
        });
    expect(view.blocks.expand((b) => b.items).single.lines.map((l) => l.text),
        contains('Спасбросок: ЛОВ СЛ 14'));
  });
  test(
      'ammo stays equipment, ranged attacks do not lose a known base bonus, zero long range is a default',
      () {
    final view = DmStatblock.fromCreature(creature(identity: {
      'challengeRatingValue': 1
    }, abilities: {
      'dex': {'score': 14}
    }, items: [
      item('Лук', 'weapon', 'action', extra: {
        'actionType': 'rwak',
        'attackAbility': 'dex',
        'sourceSystem': {'proficient': true},
        'consume': {'type': 'ammo', 'target': 'arrows'}
      }),
      item('Стрелы', 'consumable', 'action', extra: {
        'sourceItemId': 'arrows',
        'actionType': 'rwak',
        'sourceSystem': {'consumableType': 'ammo', 'attackBonus': ''}
      }),
      item('Меч', 'weapon', 'action', extra: {
        'range': {'value': 5, 'long': 0, 'units': 'ft'}
      }),
    ]));
    final items = view.blocks.expand((b) => b.items);
    expect(items.singleWhere((i) => i.name == 'Стрелы').section,
        DmSection.equipment);
    expect(items.singleWhere((i) => i.name == 'Лук').lines.map((l) => l.text),
        contains('Атака: +4 к попаданию'));
    expect(items.singleWhere((i) => i.name == 'Меч').lines.map((l) => l.text),
        contains('Дистанция: 5 фт.'));
  });
  test('missing fields stay unknown; only four mandatory sections', () {
    final view = DmStatblock.fromCreature(creature());
    expect(view.blocks.map((b) => b.section), [
      DmSection.identity,
      DmSection.combat,
      DmSection.abilities,
      DmSection.senses
    ]);
    expect(view.abilities.map((a) => a.score), everyElement('—'));
    expect(view.abilities.map((a) => a.modifier), everyElement('—'));
    expect(view.blocks[1].lines.map((l) => l.value), everyElement('—'));
  });
  test('recursive visibility preserves meaningful zero and false', () {
    expect(
        dmHasValue({
          'a': [null, {}, ' ']
        }),
        false);
    expect(dmHasValue({'a': 0}), true);
    expect(dmHasValue({'a': false}), true);
    expect(dmHasValue('+0'), true);
    final view = DmStatblock.fromCreature(creature(combat: {
      'hpMax': 0,
      'armorClass': 0,
      'initiativeBonus': 0,
      'movement': {'walk': 0, 'units': 'ft'}
    }, defenses: {
      'damageImmunities': {'value': [], 'custom': '', 'bypasses': []}
    }, resources: {
      'legact': {'max': 0, 'value': 0},
      'lair': {'value': false, 'initiative': 20}
    }, abilities: {
      'str': {'score': 0},
      'dex': {'score': 9}
    }));
    expect(view.abilities[0].modifier, '-5');
    expect(view.abilities[1].modifier, '-1');
    expect(
        view.blocks[1].lines.map((l) => l.text),
        containsAll(
            ['HP: 0', 'КД: 0', 'Инициатива: +0', 'Скорость: пешком 0 фт.']));
    expect(
        view.blocks.any((b) =>
            b.section == DmSection.defenses ||
            b.section == DmSection.resources ||
            b.section == DmSection.lair),
        false);
  });
  test('every item occurs once in metadata groups including ambiguous fallback',
      () {
    final entries = [
      item('Пассивная', 'feat', ''),
      item('Удар', 'weapon', 'action'),
      item('Бонус', 'feat', 'bonus'),
      item('Реакция', 'feat', 'reaction'),
      item('Легендарное', 'weapon', 'legendary'),
      item('Мифическое', 'feat', 'mythic'),
      item('Логово', 'feat', 'lair'),
      item('Регион', 'feat', 'regional'),
      item('Магия', 'spell', 'reaction'),
      item('Меч в сумке', 'weapon', ''),
      item('Особое', 'feat', 'special'),
      item('Неясная атака', 'feat', '', extra: {'actionType': 'mwak'}),
      item('Чужой', 'unknown', '')
    ];
    final flattened = DmStatblock.fromCreature(creature(items: entries))
        .blocks
        .expand((b) => b.items)
        .toList();
    expect(flattened, hasLength(entries.length));
    expect(flattened.map((i) => i.id).toSet(), hasLength(entries.length));
    expect({
      for (final i in flattened) i.name: i.section
    }, {
      'Пассивная': DmSection.traits,
      'Удар': DmSection.actions,
      'Бонус': DmSection.bonus,
      'Реакция': DmSection.reactions,
      'Легендарное': DmSection.legendary,
      'Мифическое': DmSection.mythic,
      'Логово': DmSection.lair,
      'Регион': DmSection.regional,
      'Магия': DmSection.spells,
      'Меч в сумке': DmSection.equipment,
      'Особое': DmSection.other,
      'Неясная атака': DmSection.other,
      'Чужой': DmSection.other
    });
    expect(flattened.map((i) => i.description),
        everyElement(startsWith('Полное описание')));
  });
  test('duplicate source IDs have stable distinct keys', () {
    final input = creature(items: [
      item('Один', 'feat', '', extra: {'sourceItemId': 'same'}),
      item('Два', 'feat', '', extra: {'sourceItemId': 'same'})
    ]);
    List<String> keys() => DmStatblock.fromCreature(input)
        .blocks
        .expand((b) => b.items)
        .map((i) => i.id)
        .toList();
    expect(keys().toSet(), hasLength(2));
    expect(keys(), keys());
  });
  test('base saves skills and passive perception use known stats', () {
    final view = DmStatblock.fromCreature(creature(identity: {
      'challengeRatingValue': 6
    }, abilities: {
      'int': {
        'score': 17,
        'saveProficiency': 1,
        'bonuses': {'save': '+0'}
      },
      'wis': {'score': 12, 'saveProficiency': 0}
    }, otherStats: {
      'skills': {
        'arc': {
          'value': 1,
          'ability': 'int',
          'bonuses': {'check': ''}
        },
        'prc': {
          'value': 2,
          'ability': 'wis',
          'bonuses': {'check': '1', 'passive': '2'}
        },
        'his': {
          'value': 0,
          'ability': 'int',
          'bonuses': {'check': ''}
        }
      }
    }));
    final lines = view.blocks.expand((b) => b.lines).map((l) => l.text);
    expect(
        lines,
        containsAll([
          'Спасбросок ИНТ: +6',
          'Магия: +6',
          'Восприятие: +8',
          'Пассивное Восприятие: 20'
        ]));
    expect(lines, isNot(contains('История: +3')));
  });
  test('unsupported bonuses stay visible without fabricated totals', () {
    final view = DmStatblock.fromCreature(creature(abilities: {
      'dex': {
        'score': 14,
        'saveProficiency': 1,
        'bonuses': {'save': '1d4'}
      }
    }, otherStats: {
      'proficiencyBonus': 2
    }));
    expect(view.blocks.expand((b) => b.lines).map((l) => l.text),
        containsAll(['Спасбросок ЛОВ: —', 'Доп. бонус ЛОВ: 1d4']));
  });
  test('resources use caps and overrides, never current values', () {
    final view = DmStatblock.fromCreature(
        creature(combat: {
          'hpMax': 40,
          'hpInitial': 7
        }, resources: {
          'legact': {'max': 3, 'value': 1},
          'legres': {'max': 3, 'value': 0}
        }, spellSlots: {
          'spell1': {'value': 1, 'override': null},
          'spell2': {'value': 99, 'override': 0}
        }),
        sourceActor: {
          'system': {
            'details': {'spellLevel': 9}
          }
        });
    expect(
        view.blocks.expand((b) => b.lines).map((l) => l.text),
        containsAll([
          'HP: 40',
          'Действия (макс.): 3',
          'Легендарные сопротивления (макс.): 3',
          'Ячейки 1-го уровня (макс.): 4',
          'Ячейки 2-го уровня (макс.): 0',
          'Ячейки 5-го уровня (макс.): 1'
        ]));
    expect(
        view.blocks
            .singleWhere((b) => b.section == DmSection.resources)
            .lines
            .any((l) => l.label.startsWith('Действия')),
        false);
    expect(
        DmStatblock.fromCreature(creature(spellSlots: {
          'spell1': {'value': 4}
        })).blocks.any((b) => b.section == DmSection.resources),
        false);
  });
  test('defense exceptions and special communication survive', () {
    final view = DmStatblock.fromCreature(creature(defenses: {
      'damageResistances': {
        'value': ['piercing'],
        'bypasses': ['mgc', 'sil'],
        'custom': 'пока бодрствует'
      }
    }, otherStats: {
      'languages': {
        'value': ['infernal'],
        'custom': 'телепатия 120 фт.'
      },
      'senses': {'special': 'не видит за стеной'}
    }));
    expect(
        view.blocks.expand((b) => b.lines).map((l) => l.text),
        containsAll([
          'Сопротивления урону: колющий; пока бодрствует; кроме: магическое оружие, серебро',
          'Языки: Инфернальный; телепатия 120 фт.',
          'Чувства: не видит за стеной'
        ]));
  });
  test('attack extra combines with modifier and proficiency once', () {
    final view = DmStatblock.fromCreature(creature(identity: {
      'challengeRatingValue': 1
    }, abilities: {
      'dex': {'score': 14}
    }, items: [
      item('Лук', 'weapon', 'action', extra: {
        'actionType': 'rwak',
        'attackBonus': '1',
        'damageParts': [
          ['1d6 + @mod', 'piercing']
        ],
        'range': {'value': 80, 'long': 320, 'units': 'ft'},
        'sourceSystem': {'proficient': true, 'weaponType': 'simpleR'}
      })
    ]));
    expect(
        view.blocks.expand((b) => b.items).single.lines.map((l) => l.text),
        containsAll([
          'Атака: +5 к попаданию',
          'Урон: 1d6 + 2 (колющий)',
          'Дистанция: 80/320 фт.'
        ]));
  });
  test('unsafe images and Foundry paths use neutral fallback', () {
    for (final value in [
      'icons/x.png',
      'javascript:alert(1)',
      'file:///x',
      'https://user:pass@example.com/x'
    ]) {
      expect(dmSafeImage(value), null);
    }
    expect(dmSafeImage('https://example.com/x')?.host, 'example.com');
  });
}
