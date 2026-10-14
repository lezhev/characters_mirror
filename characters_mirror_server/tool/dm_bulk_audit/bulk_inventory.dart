import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

typedef AuditJson = Map<String, dynamic>;

Object? canonicalValue(Object? value) {
  if (value is Map<String, dynamic>) {
    final keys = value.keys.toList()..sort();
    return {for (final key in keys) key: canonicalValue(value[key])};
  }
  if (value is List) return value.map(canonicalValue).toList();
  if (value is num && value.isFinite && value == value.roundToDouble()) {
    return value.toInt();
  }
  return value;
}

bool sameJson(Object? a, Object? b) =>
    jsonEncode(canonicalValue(a)) == jsonEncode(canonicalValue(b));

AuditJson object(Object? value) => value is AuditJson ? value : {};

class BulkInventory {
  BulkInventory(this.inputPath, this.sourceBytes, this.entries, this.format);
  static Future<BulkInventory> load(String path) async {
    final bytes = await File(path).readAsBytes();
    final text = utf8.decode(bytes);
    if (text.trimLeft().startsWith('[')) {
      final decoded = jsonDecode(text);
      if (decoded is! List) {
        throw const FormatException('Bulk input must be a JSON array.');
      }
      return BulkInventory(path, bytes, decoded, 'json_array');
    }
    final lines = const LineSplitter()
        .convert(text)
        .where((line) => line.trim().isNotEmpty)
        .toList();
    return BulkInventory(path, bytes, lines, 'json_lines');
  }

  final String inputPath;
  final List<int> sourceBytes;
  final List<dynamic> entries;
  final String format;
  String raw(int index) => entries[index] is String
      ? entries[index] as String
      : jsonEncode(entries[index]);
  String get checksum => sha256.convert(sourceBytes).toString();

  AuditJson describe() {
    final counts = <String, Map<String, int>>{};
    final missing = <String, int>{};
    final unusual = <String, int>{};
    final hashes = <String>{};
    final sizes = <int>[];
    var decodedObjects = 0, invalidJson = 0, foundryActors = 0, fiveTools = 0;
    void count(String group, Object? value) {
      final key = value == null
          ? '(absent)'
          : value is String
              ? value
              : jsonEncode(value);
      final bucket = counts.putIfAbsent(group, () => {});
      bucket[key] = (bucket[key] ?? 0) + 1;
    }

    for (var i = 0; i < entries.length; i++) {
      count('elementTypes', entries[i].runtimeType.toString());
      final text = raw(i);
      sizes.add(utf8.encode(text).length);
      try {
        final decoded = jsonDecode(text);
        hashes.add(sha256
            .convert(utf8.encode(jsonEncode(canonicalValue(decoded))))
            .toString());
        if (decoded is! AuditJson) {
          invalidJson++;
          continue;
        }
        decodedObjects++;
        final isFoundry =
            decoded['type'] == 'npc' && decoded['system'] is AuditJson;
        if (isFoundry) foundryActors++;
        if (decoded['system'] == null &&
            decoded.containsKey('ac') &&
            decoded.containsKey('hp') &&
            decoded.containsKey('cr')) {
          fiveTools++;
        }
        final stats = object(decoded['_stats']);
        final system = object(decoded['system']);
        count('coreVersions', stats['coreVersion']);
        count('systemVersions', stats['systemVersion']);
        count('systemIds', stats['systemId']);
        count('actorTypes', decoded['type']);
        count('challengeRatings',
            isFoundry ? object(system['details'])['cr'] : decoded['cr']);
        for (final key in ['name', 'type', 'system', '_stats', 'items']) {
          if (!decoded.containsKey(key) || decoded[key] == null) {
            missing[key] = (missing[key] ?? 0) + 1;
          }
        }
        for (final entry
            in {'name': decoded['name'], 'type': decoded['type']}.entries) {
          if (entry.value != null && entry.value is! String) {
            unusual[entry.key] = (unusual[entry.key] ?? 0) + 1;
          }
        }
        if (isFoundry) {
          final attributes = object(system['attributes']);
          for (final key in [
            'abilities',
            'attributes',
            'details',
            'traits',
            'skills',
            'spells',
            'resources'
          ]) {
            if (system[key] == null) {
              missing['system.$key'] = (missing['system.$key'] ?? 0) + 1;
            } else if (system[key] is! AuditJson) {
              unusual['system.$key'] = (unusual['system.$key'] ?? 0) + 1;
            }
          }
          count('armorModes', object(attributes['ac'])['calc']);
          for (final item
              in decoded['items'] is List ? decoded['items'] as List : []) {
            count('itemTypes', object(item)['type']);
          }
        }
      } on FormatException {
        invalidJson++;
      }
    }
    sizes.sort();
    return {
      'sourcePath': inputPath,
      'sourceSha256': checksum,
      'sourceBytes': sourceBytes.length,
      'format': format,
      'records': entries.length,
      'decodedObjects': decodedObjects,
      'invalidJson': invalidJson,
      'foundryActors': foundryActors,
      'fiveToolsStatblocks': fiveTools,
      'uniqueCanonicalDocuments': hashes.length,
      'duplicates': entries.length - invalidJson - hashes.length,
      'distributions': counts,
      'missingFields': missing,
      'unusualFields': unusual,
      'recordBytes': sizes.isEmpty
          ? {}
          : {
              'min': sizes.first,
              'max': sizes.last,
              'mean': sizes.reduce((a, b) => a + b) / sizes.length,
              'median': sizes[sizes.length ~/ 2],
              'p95': sizes[((sizes.length - 1) * .95).floor()]
            },
    };
  }
}
