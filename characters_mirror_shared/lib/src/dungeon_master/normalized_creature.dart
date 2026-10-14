import 'dart:convert';

typedef CreatureJson = Map<String, Object?>;

const creatureImportMaxBytes = 5 * 1024 * 1024;

/// Versioned application contract, independent of Foundry and CharacterData.
/// Variable Foundry properties remain JSON values; core UI fields have typed
/// accessors. Maps and lists are deeply immutable after decoding.
class NormalizedCreature {
  NormalizedCreature.fromJson(CreatureJson json)
      : schemaVersion = _version(json),
        identity = creatureObject(json['identity']),
        combat = creatureObject(json['combat']),
        abilities = creatureObject(json['abilities']),
        defenses = creatureObject(json['defenses']),
        otherStats = creatureObject(json['otherStats']),
        resources = creatureObject(json['resources']),
        spellSlots = creatureObject(json['spellSlots']),
        items = List.unmodifiable(_items(json['items'])),
        diagnostics = List.unmodifiable(_diagnostics(json['diagnostics']));

  factory NormalizedCreature.decode(String value) {
    final json = jsonDecode(value);
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Creature document must be an object.');
    }
    return NormalizedCreature.fromJson(json);
  }

  final int schemaVersion;
  final CreatureJson identity;
  final CreatureJson combat;
  final CreatureJson abilities;
  final CreatureJson defenses;
  final CreatureJson otherStats;
  final CreatureJson resources;
  final CreatureJson spellSlots;
  final List<NormalizedCreatureItem> items;
  final List<String> diagnostics;

  String get name => creatureString(identity['name']) ?? '';
  int? get armorClass => creatureInt(combat['armorClass']);
  int? get hpMax => creatureInt(combat['hpMax']);
  int? get hpInitial => creatureInt(combat['hpInitial']);
  int? get initiativeBonus => creatureInt(combat['initiativeBonus']);
  String? get challengeRating => creatureString(identity['challengeRating']);

  CreatureJson toJson() => {
        'schemaVersion': schemaVersion,
        'identity': identity,
        'combat': combat,
        'abilities': abilities,
        'defenses': defenses,
        'otherStats': otherStats,
        'resources': resources,
        'spellSlots': spellSlots,
        'items': items.map((item) => item.fields).toList(),
        'diagnostics': diagnostics,
      };

  static int _version(CreatureJson json) {
    if (json['schemaVersion'] != 1) {
      throw const FormatException('Unsupported creature schema version.');
    }
    return 1;
  }

  static Iterable<NormalizedCreatureItem> _items(Object? value) {
    if (value is! List) throw const FormatException('Invalid creature items.');
    return value.map((item) => NormalizedCreatureItem(creatureObject(item)));
  }

  static Iterable<String> _diagnostics(Object? value) {
    if (value is! List || value.any((entry) => entry is! String)) {
      throw const FormatException('Invalid import diagnostics.');
    }
    return value.cast<String>();
  }
}

class NormalizedCreatureItem {
  NormalizedCreatureItem(CreatureJson fields)
      : fields = creatureObject(fields) {
    if (fields['name'] is! String ||
        fields['itemType'] is! String ||
        fields['description'] is! String) {
      throw const FormatException('Invalid normalized item.');
    }
  }

  final CreatureJson fields;
  String get name => fields['name']! as String;
  String get itemType => fields['itemType']! as String;
  String get description => fields['description']! as String;
  String? get activationType => creatureString(fields['activationType']);
  int? get spellLevel => creatureInt(fields['spellLevel']);
}

String? creatureString(Object? value) => value is String ? value : null;

int? creatureInt(Object? value) =>
    value is num && value.isFinite && value == value.roundToDouble()
        ? value.toInt()
        : null;

CreatureJson creatureObject(Object? value) {
  if (value is! Map<String, Object?>) {
    throw const FormatException('Expected a creature object.');
  }
  return Map.unmodifiable(
      value.map((key, value) => MapEntry(key, _freeze(value))));
}

Object? _freeze(Object? value) {
  if (value is Map<String, Object?>) return creatureObject(value);
  if (value is List) return List<Object?>.unmodifiable(value.map(_freeze));
  if (value == null || value is String || value is num || value is bool)
    return value;
  throw const FormatException('Expected a JSON value.');
}
