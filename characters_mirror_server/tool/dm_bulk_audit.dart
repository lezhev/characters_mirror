import 'dart:convert';
import 'dart:io';
import 'package:characters_mirror_server/src/dungeon_master/foundry_creature_importer.dart';
import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/dungeon_master.dart';
import 'dm_bulk_audit/bulk_inventory.dart';
import 'dm_bulk_audit/fidelity_checks.dart';

Future<void> main(List<String> args) async {
  if (args.length != 2) {
    stderr.writeln(
        'Usage: dart run tool/dm_bulk_audit.dart INPUT_JSON OUTPUT_SUMMARY_JSON');
    exitCode = 64;
    return;
  }
  final wall = Stopwatch()..start();
  final inventory = await BulkInventory.load(args[0]);
  final description = inventory.describe();
  final issues = <String, AuditJson>{};
  var success = 0,
      warnings = 0,
      errors = 0,
      unsupported = 0,
      lostItems = 0,
      serialized = 0,
      sourceItems = 0,
      normalizedItems = 0;
  var normalizeUs = 0,
      serializeUs = 0,
      maxUs = 0,
      maxNormalizeUs = 0,
      acceptedNormalizeUs = 0;
  final outcomes = <AuditJson>[];
  final importer = FoundryCreatureImporter();
  void issue(String category, int index, AuditJson source, String field,
      String reason) {
    final bucket = issues.putIfAbsent(category,
        () => {'incidents': 0, 'records': <int>{}, 'examples': <AuditJson>[]});
    bucket['incidents'] = (bucket['incidents'] as int) + 1;
    (bucket['records'] as Set<int>).add(index);
    final examples = bucket['examples'] as List<AuditJson>;
    if (examples.length < 5) {
      examples.add({
        'index': index,
        'name': source['name'],
        'source': source['source'] ??
            object(object(source['system'])['details'])['source'],
        'field': field,
        'reason': reason
      });
    }
  }

  for (var index = 0; index < inventory.entries.length; index++) {
    final raw = inventory.raw(index);
    AuditJson source = {};
    final elapsed = Stopwatch()..start();
    var status = 'error';
    try {
      source = object(jsonDecode(raw));
      sourceItems +=
          source['items'] is List ? (source['items'] as List).length : 0;
      final timing = Stopwatch()..start();
      ParsedFoundryCreature parsed;
      var accepted = false;
      try {
        parsed = importer.parse(raw);
        accepted = true;
      } finally {
        final duration = timing.elapsedMicroseconds;
        normalizeUs += duration;
        if (duration > maxNormalizeUs) maxNormalizeUs = duration;
        if (accepted) acceptedNormalizeUs += duration;
      }
      final serialization = Stopwatch()..start();
      final normalized = NormalizedCreature.decode(parsed.normalizedJson);
      final encoded = jsonEncode(normalized.toJson());
      final decoded = NormalizedCreature.decode(encoded);
      if (!sameJson(normalized.toJson(), decoded.toJson())) {
        throw const FormatException('Normalized round-trip mismatch.');
      }
      if (jsonDecode(jsonEncode({'rawJson': raw}))['rawJson'] != raw) {
        throw const FormatException(
            'Original raw JSON changed during serialization.');
      }
      serializeUs += serialization.elapsedMicroseconds;
      serialized++;
      normalizedItems += decoded.items.length;
      final failures = checkFidelity(source, decoded);
      for (final failure in failures) {
        issue(failure.category, index, source, failure.field, failure.reason);
        if (failure.category == 'item_loss') {
          lostItems +=
              ((source['items'] as List).length - decoded.items.length).abs();
        }
      }
      for (final diagnostic in decoded.diagnostics) {
        issue(diagnosticCategory(diagnostic), index, source,
            diagnostic.split(':').first, diagnostic);
      }
      if (failures.isNotEmpty) {
        errors++;
      } else if (decoded.diagnostics.isNotEmpty) {
        warnings++;
        status = 'warning';
      } else {
        success++;
        status = 'success';
      }
    } on DmCreatureException catch (e) {
      final fiveTools = source['system'] == null &&
          source.containsKey('ac') &&
          source.containsKey('hp') &&
          source.containsKey('cr');
      if (fiveTools) {
        unsupported++;
        status = 'unsupported';
      } else {
        errors++;
      }
      final category = fiveTools
          ? 'non_foundry_format'
          : e.code == 'unsupported_format'
              ? 'foundry_version'
              : e.code == 'invalid_actor'
                  ? 'missing_required_fields'
                  : 'other_error';
      issue(category, index, source,
          fiveTools ? 'system / type / _stats' : e.code, e.message);
    } catch (e) {
      errors++;
      issue(e is FormatException ? 'serialization' : 'other_error', index,
          source, 'document', e.runtimeType.toString());
    }
    final duration = elapsed.elapsedMicroseconds;
    if (duration > maxUs) maxUs = duration;
    outcomes.add({'index': index, 'status': status});
    if ((index + 1) % 500 == 0) {
      stdout.writeln('Processed ${index + 1}/${inventory.entries.length}');
    }
  }
  for (final bucket in issues.values) {
    bucket['records'] = (bucket['records'] as Set<int>).length;
  }
  final result = {
    'inventory': description,
    'results': {
      'success': success,
      'warning': warnings,
      'error': errors,
      'unsupported': unsupported,
      'lostItems': lostItems,
      'sourceItems': sourceItems,
      'normalizedItems': normalizedItems,
      'serializedDocuments': serialized
    },
    'issues': issues,
    'outcomes': outcomes,
    'performance': {
      'wallMs': wall.elapsedMicroseconds / 1000,
      'normalizationMs': normalizeUs / 1000,
      'meanNormalizationMs': normalizeUs / 1000 / inventory.entries.length,
      'maxNormalizationMs': maxNormalizeUs / 1000,
      'acceptedNormalizationMs': acceptedNormalizeUs / 1000,
      'maxRecordProcessingMs': maxUs / 1000,
      'serializationMs': serializeUs / 1000,
      'peakRssBytes': ProcessInfo.maxRss
    },
    'inputUnchanged':
        inventory.checksum == (await BulkInventory.load(args[0])).checksum
  };
  await File(args[1]).parent.create(recursive: true);
  await File(args[1])
      .writeAsString(const JsonEncoder.withIndent('  ').convert(result));
  stdout.writeln(jsonEncode({
    'results': result['results'],
    'performance': result['performance'],
    'output': args[1]
  }));
}
