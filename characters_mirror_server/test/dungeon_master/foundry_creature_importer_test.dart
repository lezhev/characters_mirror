import 'dart:convert';
import 'dart:io';

import 'package:characters_mirror_server/src/dungeon_master/foundry_creature_importer.dart';
import 'package:characters_mirror_server/src/dungeon_master/foundry_description.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:test/test.dart';

String fixture(String name) =>
    File('test/fixtures/foundry/$name.json').readAsStringSync();

void main() {
  final importer = FoundryCreatureImporter();
  for (final sample in [
    ('Goblin', 'Гоблин', 7, 15, '1/4'),
    ('Imp', 'Бес', 10, 13, '1'),
    ('Iron Consul', 'Железный консул', 45, 16, '2'),
    ('Mage', 'Маг', 40, 12, '6'),
    ('Adult Red Dragon', 'Взрослый красный дракон', 256, 19, '17'),
  ]) {
    test('${sample.$1}: real Foundry statistics and every item survive', () {
      final raw = fixture(sample.$1);
      final source = jsonDecode(raw) as Map<String, dynamic>;
      final parsed = importer.parse(raw);
      final normalized =
          jsonDecode(parsed.normalizedJson) as Map<String, dynamic>;
      expect(parsed.name, sample.$2);
      expect(parsed.challengeRating, sample.$5);
      expect(normalized['combat']['hpMax'], sample.$3);
      expect(normalized['combat']['armorClass'], sample.$4);
      expect(normalized['items'], hasLength((source['items'] as List).length));
      expect(normalized['identity']['originalName'], source['name']);
    });
  }

  test('canonical hash ignores object key order and whitespace, retains arrays',
      () {
    final raw = fixture('Adult Red Dragon');
    final source = jsonDecode(raw) as Map<String, dynamic>;
    final reordered =
        Map<String, dynamic>.fromEntries(source.entries.toList().reversed);
    final hash = importer.parse(raw).importHash;
    expect(hash, matches(RegExp(r'^[a-f0-9]{64}$')));
    expect(importer.parse(fixture('Adult Red Dragon (1)')).importHash, hash);
    expect(importer.parse(jsonEncode(reordered)).importHash, hash);
    source['items'] = (source['items'] as List).reversed.toList();
    expect(importer.parse(jsonEncode(source)).importHash, isNot(hash));
  });

  test('goblin equipment, weapons and nimble escape retain independent entries',
      () {
    final json = jsonDecode(importer.parse(fixture('Goblin')).normalizedJson);
    expect(
        (json['items'] as List).map((item) => item['name']),
        containsAll([
          'Скимитар',
          'Короткий лук',
          'Проворное бегство',
          'Кожаный доспех',
          'Щит'
        ]));
    expect(json['identity']['challengeRatingValue'], 0.25);
    expect(json['combat']['initiativeBonus'], 2);
  });

  test('imp 2.3.1 defenses retain bypasses and custom exceptions', () {
    final parsed = importer.parse(fixture('Imp'));
    final json = jsonDecode(parsed.normalizedJson);
    final source = jsonDecode(fixture('Imp'));
    expect(parsed.sourceVersion, '2.3.1');
    expect(json['defenses']['damageResistances'],
        source['system']['traits']['dr']);
    expect(
        json['defenses']['damageImmunities'], source['system']['traits']['di']);
  });

  test('consul source and commanders voice survive', () {
    final json =
        jsonDecode(importer.parse(fixture('Iron Consul')).normalizedJson);
    expect(json['identity']['sourceBook'], 'BGDIA');
    expect((json['items'] as List).map((item) => item['name']),
        contains('Командирский голос'));
  });

  test('mage spells, descriptions and slots 1–5 survive', () {
    final json = jsonDecode(importer.parse(fixture('Mage')).normalizedJson);
    final spells = (json['items'] as List)
        .where((item) => item['itemType'] == 'spell')
        .toList();
    final source = jsonDecode(fixture('Mage'));
    expect(
        spells,
        hasLength((source['items'] as List)
            .where((item) => item['type'] == 'spell')
            .length));
    expect(spells.every((spell) => (spell['description'] as String).isNotEmpty),
        true);
    for (var i = 1; i <= 5; i++) {
      expect(json['spellSlots']['spell$i']['value'], [4, 3, 3, 3, 1][i - 1]);
    }
    final missile =
        spells.singleWhere((item) => item['name'] == 'Волшебная стрела');
    expect(missile['damageParts'].toString(), contains('@item.level'));
    expect(missile['spellLevel'], 1);
    expect(missile['spellProperties']['components'], isNotEmpty);
  });

  test('dragon damage, recharge, legendary actions and lair are preserved', () {
    final json =
        jsonDecode(importer.parse(fixture('Adult Red Dragon')).normalizedJson);
    final items = json['items'] as List;
    final breath =
        items.singleWhere((item) => item['name'] == 'Огненное дыхание');
    expect(breath['damageParts'][0][0], '18d6');
    expect(breath['recharge']['value'], 5);
    expect(items.any((item) => item['activationType'] == 'legendary'), true);
    expect(items.any((item) => item['activationType'] == 'lair'), true);
    expect(json['resources']['legact']['max'], 3);
    expect(json['resources']['legres']['max'], 3);
    expect(json['resources']['lair']['value'], true);
    final fright =
        items.singleWhere((item) => item['name'] == 'Пугающее присутствие');
    expect(fright['saveDc'], 16);
    expect(fright['description'], contains('19'));
  });

  for (final raw in [
    '',
    '   ',
    '{oops',
    '[]',
    '{}',
    '{"name":"test"}',
    'null'
  ]) {
    test('rejects malformed or incomplete import ${raw.length}', () {
      expect(() => importer.parse(raw), throwsA(isA<DmCreatureException>()));
    });
  }

  test('rejects other actor types and unsupported system/version', () {
    final source = jsonDecode(fixture('Goblin')) as Map<String, dynamic>;
    source['type'] = 'character';
    expect(() => importer.parse(jsonEncode(source)),
        throwsA(isA<DmCreatureException>()));
    source['type'] = 'npc';
    source['_stats']['systemId'] = 'pf2e';
    expect(() => importer.parse(jsonEncode(source)),
        throwsA(isA<DmCreatureException>()));
    source['_stats']['systemId'] = 'dnd5e';
    source['_stats']['systemVersion'] = '4.0.0';
    expect(() => importer.parse(jsonEncode(source)),
        throwsA(isA<DmCreatureException>()));
  });

  test('byte-size boundaries include multibyte UTF-8 and forbid nesting bombs',
      () {
    final raw = fixture('Goblin');
    final padding = FoundryCreatureImporter.maxBytes - utf8.encode(raw).length;
    expect(importer.parse(raw + ' ' * (padding - 1)).name, 'Гоблин');
    expect(importer.parse(raw + ' ' * padding).name, 'Гоблин');
    expect(() => importer.parse(raw + ' ' * (padding + 1)),
        throwsA(isA<DmCreatureException>()));
    expect(
        () => importer.parse('я' * (FoundryCreatureImporter.maxBytes ~/ 2 + 1)),
        throwsA(isA<DmCreatureException>()));
    expect(() => importer.parse('${'[' * 65}0${']' * 65}'),
        throwsA(isA<DmCreatureException>()));
  });

  test(
      'unknown item types remain and optional absence warns instead of failing',
      () {
    final source = jsonDecode(fixture('Goblin')) as Map<String, dynamic>;
    source['items'][0]['type'] = 'future-item';
    final json = jsonDecode(importer.parse(jsonEncode(source)).normalizedJson);
    expect(json['items'][0]['itemType'], 'future-item');
    expect(json['diagnostics'], isNotEmpty);
    source['system'] = <String, dynamic>{};
    source.remove('items');
    final minimal =
        jsonDecode(importer.parse(jsonEncode(source)).normalizedJson);
    expect(minimal['combat']['armorClass'], null);
    expect(minimal['combat']['hpMax'], null);
    expect(minimal['items'], isEmpty);
    expect(minimal['diagnostics'], contains(contains('КД')));
  });

  test(
      'initiative settings and unrecognized armor formula never become false defaults',
      () {
    final source = jsonDecode(fixture('Goblin')) as Map<String, dynamic>;
    source['system']['attributes']['init']['bonus'] = '';
    expect(
        jsonDecode(importer.parse(jsonEncode(source)).normalizedJson)['combat']
            ['initiativeBonus'],
        2);
    source['system']['attributes']['init']['bonus'] = '3';
    expect(
        jsonDecode(importer.parse(jsonEncode(source)).normalizedJson)['combat']
            ['initiativeBonus'],
        5);
    source['system']['attributes']['init']['bonus'] = '1d4';
    source['system']['attributes']
        ['ac'] = {'calc': 'custom', 'flat': null, 'formula': 'weird(@armor)'};
    final json = jsonDecode(importer.parse(jsonEncode(source)).normalizedJson);
    expect(json['combat']['initiativeBonus'], null);
    expect(json['combat']['initiativeExtraBonus'], '1d4');
    expect(json['combat']['armorClass'], null);
    expect(json['combat']['armorClassFormula'], 'weird(@armor)');
    expect(json['diagnostics'], isNotEmpty);
  });

  test(
      'plain text removes active markup and retains secret, rolls and linked labels',
      () {
    final plain = foundryDescriptionText(
        '<p>[[/r 18d6]] &amp; @Compendium[pack.id]{испуганы}</p>'
        '<section class="secret">секрет Мастера</section><script>alert(1)</script><img src="https://bad.invalid/x" onerror="run()">');
    expect(plain, contains('18d6 & испуганы'));
    expect(plain, contains('секрет Мастера'));
    expect(plain, isNot(contains('<')));
    expect(plain, isNot(contains('alert')));
    expect(plain, isNot(contains('onerror')));
  });
}
