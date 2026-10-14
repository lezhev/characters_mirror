import 'dart:convert';

import 'package:characters_mirror_shared/dungeon_master.dart';
import 'package:crypto/crypto.dart';
import '../generated/protocol.dart';
import '../validation/rules.dart';
import '../validation/validation_exception.dart';
import 'foundry_combat.dart';
import 'foundry_items.dart';
import 'foundry_json_reader.dart';

class ParsedFoundryCreature {
  ParsedFoundryCreature({
    required this.name,
    required this.normalizedJson,
    required this.importHash,
    this.sourceVersion,
    this.challengeRating,
  });

  final String name;
  final String normalizedJson;
  final String importHash;
  final String? sourceVersion;
  final String? challengeRating;
}

class FoundryCreatureImporter {
  static const maxBytes = creatureImportMaxBytes;

  ParsedFoundryCreature parse(String rawJson) {
    if (rawJson.trim().isEmpty) _fail('empty_file', 'Файл пуст.');
    if (rawJson.length > maxBytes || utf8.encode(rawJson).length > maxBytes) {
      _fail('file_too_large', 'Размер JSON превышает 5 МиБ.');
    }
    _checkNesting(rawJson);
    Object? decoded;
    try {
      decoded = jsonDecode(rawJson);
    } on FormatException {
      _fail(
          'invalid_json', 'Не удалось прочитать JSON. Проверьте формат файла.');
    }
    if (decoded is! FoundryJson) {
      _fail('invalid_actor',
          'Ожидался объект Foundry Actor, а не массив или скаляр.');
    }
    if (decoded['system'] == null &&
        decoded.containsKey('ac') &&
        decoded.containsKey('hp') &&
        decoded.containsKey('cr')) {
      _fail('unsupported_format',
          'Это статблок 5etools, а не Foundry Actor. Нужен экспорт Foundry VTT JSON.');
    }
    try {
      _validateTree(decoded);
    } on InputValidationException {
      _fail('invalid_field',
          'В JSON превышены ограничения длины поля или размера коллекции.');
    }
    final reader = FoundryJsonReader();
    final originalName = reader.text(decoded['name'], 'name');
    if (originalName == null ||
        originalName.trim().isEmpty ||
        decoded['system'] is! FoundryJson) {
      _fail('invalid_actor', 'У Actor должны быть название и объект system.');
    }
    if (decoded['type'] != 'npc') {
      _fail(
          'unsupported_actor', 'Поддерживается только Foundry Actor типа npc.');
    }
    final stats = reader.object(decoded['_stats'], '_stats');
    final version = reader.text(stats['systemVersion'], '_stats.systemVersion');
    if (stats['systemId'] != 'dnd5e' ||
        (version != null &&
            !{'2.1.0', '2.1.5', '2.3.1', '3.2.1'}.contains(version))) {
      _fail('unsupported_format',
          'Поддерживаются Foundry dnd5e 2.1.0, 2.1.5, 2.3.1 и совместимые Actor 3.2.1 (D&D 2014).');
    }
    if (version == null) {
      reader.diagnostics
          .add('Версия dnd5e не указана; использована схема Foundry 2.x.');
    }
    final system = decoded['system']! as FoundryJson;
    final details = reader.object(system['details'], 'system.details');
    final traits = reader.object(system['traits'], 'system.traits');
    final abilities = reader.object(system['abilities'], 'system.abilities');
    final rawItems = decoded['items'];
    if (rawItems != null && rawItems is! List) {
      _fail('invalid_items', 'items должен быть массивом.');
    }
    final items = <FoundryJson>[];
    for (final item in (rawItems as List? ?? [])) {
      if (item is! FoundryJson) {
        _fail('invalid_items', 'Каждый элемент items должен быть объектом.');
      }
      items.add(item);
    }
    if (version == '3.2.1') {
      if (system['attributes'] is! FoundryJson ||
          system['abilities'] is! FoundryJson ||
          rawItems is! List) {
        _fail('unsupported_format',
            'Actor dnd5e 3.2.1 не содержит совместимые attributes, abilities и items.');
      }
      for (final item in items) {
        final itemSystem = item['system'];
        if (itemSystem is! FoundryJson ||
            (itemSystem['activities'] != null &&
                (itemSystem['activities'] is! Map ||
                    (itemSystem['activities'] as Map).isNotEmpty))) {
          _fail('unsupported_format',
              'Схема activities в dnd5e 3.2.1 не поддерживается текущим импортёром.');
        }
      }
      reader.diagnostics.add(
          'Версия dnd5e 3.2.1: импортированы совместимые поля Actor и legacy items; игровые эффекты не вычисляются.');
    }
    final nameMatch =
        RegExp(r'^(.*?)\s+\[([^\]]+)\]$').firstMatch(originalName);
    final name = nameMatch?.group(1) ?? originalName;
    final cr = reader.number(details['cr'], 'details.cr');
    final rating = cr == null || cr < 0 ? null : _rating(cr);
    final normalized = NormalizedCreature.fromJson({
      'schemaVersion': 1,
      'identity': {
        'name': name,
        'originalName': originalName,
        'englishName': nameMatch?.group(2),
        'creatureType': details['type'],
        'size': traits['size'],
        'alignment': reader.text(details['alignment'], 'details.alignment'),
        'challengeRating': rating,
        'challengeRatingValue': cr,
        'sourceBook': details['source'],
        'tokenUrl': reader.object(
                    decoded['prototypeToken'], 'prototypeToken')['texture']
                is FoundryJson
            ? (reader.object(
                reader.object(
                    decoded['prototypeToken'], 'prototypeToken')['texture'],
                'token.texture')['src'])
            : decoded['img'],
      },
      'combat': foundryCombat(system, items, reader),
      'abilities': {
        for (final ability in ['str', 'dex', 'con', 'int', 'wis', 'cha'])
          ability: _ability(ability, abilities, reader),
      },
      'defenses': {
        'damageResistances': reader.object(traits['dr'], 'traits.dr'),
        'damageImmunities': reader.object(traits['di'], 'traits.di'),
        'damageVulnerabilities': reader.object(traits['dv'], 'traits.dv'),
        'conditionImmunities': reader.object(traits['ci'], 'traits.ci'),
        if (traits['dm'] != null)
          'damageModifiers': reader.object(traits['dm'], 'traits.dm'),
      },
      'otherStats': {
        'skills': reader.object(system['skills'], 'system.skills'),
        'languages': reader.object(traits['languages'], 'traits.languages'),
        'senses': reader.object(
            reader.object(system['attributes'], 'attributes')['senses'],
            'attributes.senses'),
        'proficiencyBonus': reader.number(
            reader.object(system['attributes'], 'attributes')['prof'],
            'attributes.prof'),
        'bonuses': reader.object(system['bonuses'], 'system.bonuses'),
      },
      'resources': reader.object(system['resources'], 'system.resources'),
      'spellSlots': reader.object(system['spells'], 'system.spells'),
      'items': [
        for (var i = 0; i < items.length; i++) foundryItem(items[i], i, reader)
      ],
      'diagnostics': reader.diagnostics,
    });
    return ParsedFoundryCreature(
        name: name,
        sourceVersion: version,
        challengeRating: rating,
        normalizedJson: jsonEncode(normalized.toJson()),
        importHash: sha256
            .convert(utf8.encode(jsonEncode(_canonical(decoded))))
            .toString());
  }

  FoundryJson _ability(
      String name, FoundryJson abilities, FoundryJsonReader reader) {
    final source = reader.object(abilities[name], 'abilities.$name');
    return {
      'score': reader.nonNegative(source['value'], 'abilities.$name.value'),
      'saveProficiency':
          reader.number(source['proficient'], 'abilities.$name.proficient'),
      'bonuses': reader.object(source['bonuses'], 'abilities.$name.bonuses'),
    };
  }

  String _rating(num value) => switch (value) {
        0.125 => '1/8',
        0.25 => '1/4',
        0.5 => '1/2',
        _ => value == value.roundToDouble()
            ? value.toInt().toString()
            : value.toString(),
      };

  Object? _canonical(Object? value) {
    if (value is FoundryJson) {
      final keys = value.keys.toList()..sort();
      return {for (final key in keys) key: _canonical(value[key])};
    }
    if (value is List) return value.map(_canonical).toList();
    // JSON has one numeric domain; 1 and 1.0 represent identical data.
    if (value is num && value.isFinite && value == value.roundToDouble()) {
      return value.toInt();
    }
    return value;
  }

  void _validateTree(Object? value) {
    if (value is FoundryJson) {
      Rules.largeCollection('object', value);
      for (final entry in value.entries) {
        Rules.shortText('key', entry.key);
        _validateTree(entry.value);
      }
    } else if (value is List) {
      Rules.largeCollection('array', value);
      for (final entry in value) {
        _validateTree(entry);
      }
    } else if (value is String) {
      Rules.longText('text', value);
    } else if (value is num && !value.isFinite) {
      _fail('invalid_number', 'JSON содержит недопустимое числовое значение.');
    }
  }

  void _checkNesting(String raw) {
    var depth = 0;
    var quoted = false;
    var escaped = false;
    for (final unit in raw.codeUnits) {
      if (quoted) {
        if (escaped) {
          escaped = false;
        } else if (unit == 92) {
          escaped = true;
        } else if (unit == 34) {
          quoted = false;
        }
      } else if (unit == 34) {
        quoted = true;
      } else if (unit == 123 || unit == 91) {
        if (++depth > 64) {
          _fail('invalid_json',
              'JSON имеет слишком большую глубину вложенности.');
        }
      } else if (unit == 125 || unit == 93) {
        depth--;
      }
    }
  }

  Never _fail(String code, String message) =>
      throw DmCreatureException(code: code, message: message);
}
