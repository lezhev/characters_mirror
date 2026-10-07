import 'dart:convert';
import 'dart:io';

import 'package:characters_mirror_shared/characters_mirror_shared.dart';

/// Audits a read-only reference export; it never connects to a database.
void main(List<String> args) {
  if (args.length != 1) {
    throw ArgumentError(
        'Expected the path to a reference catalog JSON export.');
  }
  final data =
      jsonDecode(File(args.single).readAsStringSync()) as Map<String, dynamic>;
  List<Map<String, dynamic>> rows(String key) =>
      (data[key] as List? ?? []).cast<Map<String, dynamic>>();
  final spells = rows('spells');
  const resolver = SpellPresentationResolver();
  var fallbackCount = 0;
  for (final spell in spells) {
    final key = spell['referenceKey'];
    for (final level in [1, 5, 11, 17]) {
      final presentation = resolver.resolve(spell,
          context: SpellPresentationContext(
              casterLevel: level,
              castLevel: spell['level'] as int?,
              attackBonus: 7,
              saveDc: 15));
      if (presentation.description !=
              spellDescriptionText(spell['description'] as String?) ||
          presentation.displayDescription(compact: true) !=
                  spellDescriptionText(spell['shortDescription'] as String?) &&
              presentation.displayDescription(compact: true) !=
                  presentation.description) {
        throw StateError('Description fallback changed for $key.');
      }
      if (presentation.name.isEmpty || presentation.description == null) {
        throw StateError('Missing presentation for $key.');
      }
    }
    if (resolver.resolve(spell).highlights.isEmpty) fallbackCount++;
  }
  bool hasScaling(Map<String, dynamic> s, String mode) =>
      effectiveSpellDamageParts(s).any((p) => p.scaling?['mode'] == mode);
  final cases = <String, bool Function(Map<String, dynamic>)>{
    'damage': (s) => effectiveSpellDamageParts(s).isNotEmpty,
    'healing': (s) => s['isHealing'] == true && s['healingDice'] != null,
    'save': (s) => s['savingThrowAbility'] != null,
    'attack': (s) => s['attackType'] != null && s['attackType'] != 'none',
    'concentration': (s) => s['concentration'] == true,
    'ritual': (s) => s['ritual'] == true,
    'area': (s) =>
        s['areaOfEffectType'] != null && s['areaOfEffectType'] != 'none',
    'utility': (s) => resolver.resolve(s).highlights.isEmpty,
    'cantripScaling': (s) => s['level'] == 0 && hasScaling(s, 'casterLevel'),
    'slotUpcast': (s) => hasScaling(s, 'slotLevel'),
  };
  final matrix = <Map<String, dynamic>>[];
  final missingStructuredFields = <String>[];
  void sample(String category, Map<String, dynamic> spell) {
    final p = resolver.resolve(spell,
        context: SpellPresentationContext(
            casterLevel: 11,
            castLevel:
                (spell['level'] as int? ?? 0) > 5 ? spell['level'] as int : 5,
            castingAbility: 'intelligence',
            attackBonus: 7,
            saveDc: 15));
    matrix.add({
      'category': category,
      'key': spell['referenceKey'],
      'id': spell['id'],
      'name': p.name,
      'metadata': p.metadata,
      'descriptionLength': p.description?.length,
      'highlights': [
        for (final h in p.highlights)
          {'kind': h.kind.name, 'label': h.label, 'value': h.value}
      ]
    });
  }

  for (final entry in cases.entries) {
    var spell = spells.where(entry.value).firstOrNull;
    if (spell == null && entry.key == 'cantripScaling') {
      missingStructuredFields.add('cantrip casterLevel scaling');
      spell = spells
          .where(
              (s) => s['level'] == 0 && effectiveSpellDamageParts(s).isNotEmpty)
          .firstOrNull;
    }
    if (spell == null && entry.key == 'slotUpcast') {
      missingStructuredFields.add('slotLevel scaling');
      spell = spells
          .where((s) =>
              (s['level'] as int? ?? 0) > 0 &&
              s['higherLevel'] != null &&
              effectiveSpellDamageParts(s).isNotEmpty)
          .firstOrNull;
    }
    if (spell == null) throw StateError('No real catalog sample: ${entry.key}');
    sample(entry.key, spell);
  }
  final long = [...spells]..sort((a, b) => (b['description'] as String)
      .length
      .compareTo((a['description'] as String).length));
  sample('longDescription', long.first);

  final classes = {for (final c in rows('classes')) c['id']: c};
  final subclasses = {for (final c in rows('subclasses')) c['id']: c};
  final features = {for (final c in rows('classFeatures')) c['id']: c};
  final subfeatures = {for (final c in rows('subclassFeatures')) c['id']: c};
  final options = {for (final c in rows('selectedOptions')) c['id']: c};
  final groups = {for (final c in rows('choiceGroups')) c['id']: c};
  final byId = {for (final s in spells) s['id']: s};
  var grantsChecked = 0;
  for (final grant in rows('classGrants')) {
    final subfeature = subfeatures[grant['sourceSubclassFeatureId']];
    final subclass = subclasses[
        grant['sourceSubclassId'] ?? subfeature?['parentSubclassId']];
    final feature = features[grant['sourceFeatureId']];
    final classId = grant['sourceClassId'] ??
        feature?['parentClassId'] ??
        subclass?['parentClassId'];
    final c = classes[classId];
    if (c == null) throw StateError('Unattributed grant ${grant['id']}');
    final result = resolveCharacterSpellCollection(
        character: {
          'classEntries': [
            {
              'id': 'audit',
              'classData': c,
              'subclass': subclass,
              'level': grant['grantedAtLevel'],
              'classOrder': 0
            }
          ]
        },
        spells: spells,
        classGrants: [grant],
        classFeatures: rows('classFeatures'),
        subclassFeatures: rows('subclassFeatures'),
        selectedOptions: [
          if (options[grant['choiceOptionId']] case final option?) option
        ],
        choiceGroups: rows('choiceGroups'));
    final key = byId[grant['spellId']]?['referenceKey'];
    final resolved = result.where((s) => s.spellKey == key).firstOrNull;
    if (resolved == null ||
        !resolved.sources.any((s) =>
            s.classDataId == classId &&
            s.castingAbility == c['spellcastingAbilityValue'] &&
            s.granted &&
            s.alwaysPrepared == (grant['alwaysPrepared'] == true))) {
      throw StateError(
          'Grant did not resolve with its canonical source: ${grant['id']}');
    }
    grantsChecked++;
  }
  for (final option in options.values) {
    final keys = (option['grantedSpellKeys'] as List? ?? []).cast<String>();
    if (keys.isEmpty) continue;
    final group = groups[option['choiceGroupId']]!;
    final subfeature = subfeatures[group['sourceSubclassFeatureId']];
    final subclass = subclasses[
        group['sourceSubclassId'] ?? subfeature?['parentSubclassId']];
    final feature = features[group['sourceFeatureId']];
    final classId = group['sourceClassId'] ??
        feature?['parentClassId'] ??
        subclass?['parentClassId'];
    final c = classes[classId];
    final result = resolveCharacterSpellCollection(
        character: {
          'classEntries': [
            if (c != null)
              {
                'id': 'audit',
                'classData': c,
                'subclass': subclass,
                'level': 20,
                'classOrder': 0
              }
          ]
        },
        spells: spells,
        classFeatures: rows('classFeatures'),
        subclassFeatures: rows('subclassFeatures'),
        selectedOptions: [option],
        choiceGroups: rows('choiceGroups'));
    if (!keys.every((key) => result.any((s) =>
        s.spellKey == key &&
        s.sources.any((source) =>
            source.granted &&
            (c == null ||
                source.classDataId == classId &&
                    source.castingAbility ==
                        c['spellcastingAbilityValue']))))) {
      throw StateError('Choice grant did not resolve: ${option['id']}');
    }
  }
  if (rows('classGrants').isNotEmpty) {
    sample('granted', byId[rows('classGrants').first['spellId']]!);
  }
  stdout.writeln(const JsonEncoder.withIndent('  ').convert({
    'spellsChecked': spells.length,
    'presentationContextsPerSpell': 4,
    'metadataDescriptionFallbackRows': fallbackCount,
    'missingStructuredFields': missingStructuredFields,
    'classGrantsChecked': grantsChecked,
    'choiceSpellKeysChecked': options.values.fold<int>(
        0, (sum, o) => sum + (o['grantedSpellKeys'] as List? ?? []).length),
    'matrix': matrix,
  }));
}
