import 'feature_modifier_evaluator.dart';
import 'spells/spell_protocol_values.dart';

T _enum<T extends Enum>(List<T> values, dynamic value) =>
    value is int ? values[value] : values.byName(value as String);

FeatureModifierSpec featureModifierSpecFromProtocol(
  Map<String, dynamic> row, {
  required String sourceFeatureKey,
  required String sourceClassKey,
  String? sourceName,
}) {
  final value = row['value'] as Map;
  final conditions = <FeatureModifierCondition>{};
  final choices = <String>{};
  for (final condition in (row['conditions'] as List? ?? []).cast<Map>()) {
    if (condition['type'] == 'selectedChoiceOption' || condition['type'] == 5) {
      choices.add('${condition['choiceGroupKey']}::${condition['optionKey']}');
    } else {
      conditions.add(_enum(FeatureModifierCondition.values, condition['type']));
    }
  }
  return FeatureModifierSpec(
    referenceKey: row['referenceKey'] as String,
    sourceFeatureKey: sourceFeatureKey,
    sourceClassKey: sourceClassKey,
    sourceName: sourceName,
    target: _enum(FeatureModifierTarget.values, row['target']),
    operation: _enum(FeatureModifierOperation.values, row['operation']),
    valueKind: _enum(FeatureModifierValueKind.values, value['kind']),
    staticValue: value['staticValue'] as int?,
    progression: spellProtocolIntMap<int>(value['progression']),
    numerator: value['numerator'] as int?,
    denominator: value['denominator'] as int?,
    rounding: value['rounding'] == null
        ? null
        : _enum(FeatureModifierRounding.values, value['rounding']),
    abilityModifierKeys:
        (value['abilityModifiers'] as List? ?? []).cast<String>(),
    spellKey: row['spellKey'] as String?,
    minimumCastLevel: row['minimumCastLevel'] as int?,
    conditions: conditions,
    requiredChoiceOptions: choices,
  );
}

/// Hydrates only active canonical sources; class and subclass ID spaces stay separate.
List<Map<String, dynamic>> activeFeatureModifierRows(
  Map<String, dynamic> character,
  Iterable<Map<String, dynamic>> modifiers, {
  Iterable<Map<String, dynamic>>? classFeatures,
  Iterable<Map<String, dynamic>>? subclassFeatures,
}) {
  final classes = {
    for (final feature in classFeatures ?? const <Map<String, dynamic>>[])
      feature['id']: feature
  };
  final subclasses = {
    for (final feature in subclassFeatures ?? const <Map<String, dynamic>>[])
      feature['id']: feature
  };
  final entries = (character['classEntries'] as List? ?? []).cast<Map>();
  final result = <Map<String, dynamic>>[];
  final keys = <String>{};
  for (final modifier in modifiers) {
    final classId = modifier['classFeatureId'];
    final subclassId = modifier['subclassFeatureId'];
    if ((classId == null) == (subclassId == null)) continue;
    final isClass = classId != null;
    final relation = isClass ? 'classFeature' : 'subclassFeature';
    final feature = (isClass ? classFeatures : subclassFeatures) != null
        ? (isClass ? classes[classId] : subclasses[subclassId])
        : (modifier[relation] as Map?)?.cast<String, dynamic>();
    if (feature == null || feature['id'] != (classId ?? subclassId)) continue;
    final entry = entries
        .where((entry) => isClass
            ? ((entry['classData'] as Map?)?['id'] == feature['parentClassId'])
            : ((entry['subclass'] as Map?)?['id'] ==
                feature['parentSubclassId']))
        .firstOrNull;
    if (entry == null) continue;
    final level = entry['level'] as int? ?? 0;
    if (level < 1 || level < (feature['level'] as int? ?? 1)) continue;
    if (!isClass) {
      final subclass = entry['subclass'] as Map;
      if (subclass['parentClassId'] != (entry['classData'] as Map?)?['id'] ||
          level < (subclass['levelRequired'] as int? ?? 1)) continue;
    }
    final key = modifier['referenceKey'] as String?;
    if (key == null || key.isEmpty || !keys.add(key)) continue;
    result.add({
      ...modifier,
      relation: {
        for (final field in [
          'id',
          'referenceKey',
          'name',
          'level',
          isClass ? 'parentClassId' : 'parentSubclassId'
        ])
          if (feature[field] != null) field: feature[field],
      }
    });
  }
  return result;
}

/// One protocol adapter for server, offline derived data and spell presentation.
({List<FeatureModifierSpec> modifiers, FeatureModifierContext context})
    characterFeatureModifierInput(
  Map<String, dynamic> character, {
  Iterable<Map<String, dynamic>>? modifiers,
  Iterable<Map<String, dynamic>>? classFeatures,
  Iterable<Map<String, dynamic>>? subclassFeatures,
  int? proficiencyBonus,
  Map<String, int>? abilityModifiers,
  bool abilityCheckIncludesProficiency = false,
}) {
  final derived = (character['derived'] as Map?) ?? const {};
  final rows = activeFeatureModifierRows(
      character,
      modifiers ??
          (derived['featureModifiers'] as List? ?? [])
              .cast<Map>()
              .map((row) => row.cast<String, dynamic>()),
      classFeatures: classFeatures,
      subclassFeatures: subclassFeatures);
  final entries = (character['classEntries'] as List? ?? []).cast<Map>();
  String classKey(Map entry) {
    final data = entry['classData'] as Map?;
    return data?['referenceKey'] as String? ?? 'class:${data?['id']}';
  }

  final levels = <String, int>{};
  for (final entry in entries) {
    final key = classKey(entry);
    levels[key] = (levels[key] ?? 0) + (entry['level'] as int? ?? 0);
  }
  final specs = <FeatureModifierSpec>[];
  for (final row in rows) {
    final isClass = row['classFeatureId'] != null;
    final feature = row[isClass ? 'classFeature' : 'subclassFeature'] as Map;
    final entry = entries.firstWhere((entry) => isClass
        ? ((entry['classData'] as Map?)?['id'] == feature['parentClassId'])
        : ((entry['subclass'] as Map?)?['id'] == feature['parentSubclassId']));
    final sourceKey = feature['referenceKey'] as String? ??
        '${isClass ? 'classFeature' : 'subclassFeature'}:${feature['id']}';
    specs.add(featureModifierSpecFromProtocol(
      row,
      sourceFeatureKey: sourceKey,
      sourceClassKey: classKey(entry),
      sourceName: feature['name'] as String?,
    ));
  }
  final totalLevel = levels.values.fold<int>(0, (sum, level) => sum + level);
  return (
    modifiers: specs,
    context: FeatureModifierContext(
      proficiencyBonus: proficiencyBonus ??
          derived['proficiencyBonus'] as int? ??
          (totalLevel > 0 ? 2 + ((totalLevel - 1) ~/ 4) : 2),
      classLevelsByKey: levels,
      activeFeatureKeys: {for (final spec in specs) spec.sourceFeatureKey},
      abilityModifiers: abilityModifiers ??
          spellProtocolStringMap<int>(derived['abilityModifiers']),
      isArmored: character['equippedArmor'] != null,
      hasShield: character['equippedShield'] != null,
      abilityCheckIncludesProficiency: abilityCheckIncludesProficiency,
      selectedChoiceOptionKeys: {
        for (final choice in (character['choices'] as List? ?? []).cast<Map>())
          if (choice['groupKey'] != null && choice['optionKey'] != null)
            '${(choice['groupKey'] as String).trim()}::${(choice['optionKey'] as String).trim()}',
      },
    )
  );
}
