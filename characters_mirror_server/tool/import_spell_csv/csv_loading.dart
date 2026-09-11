part of '../import_spell_csv.dart';

Future<List<_CsvSpell>> _loadCsvSpells(String path) async {
  final file = File(path);
  if (!await file.exists()) {
    throw ArgumentError('CSV file was not found: $path');
  }

  final content = await file.readAsString(encoding: utf8);
  final rows = _parseCsv(content);
  if (rows.isEmpty) {
    throw ArgumentError('CSV file is empty: $path');
  }

  final header = rows.first;
  final indexByName = {
    for (var i = 0; i < header.length; i++) header[i].trim(): i,
  };
  final requiredColumns = {
    'name',
    'description',
    'source',
    'level',
    'castingTime',
    'range',
    'duration',
    'concentration',
    'ritual',
    'higherLevel',
    'availableTo',
    'availableToSubclasses',
    'materialDescription',
    'materialCost',
    'materialConsumed',
    'requiresVerbal',
    'requiresSomatic',
    'requiresMaterial',
    'schoolValue',
    'durationType',
  };
  final missingColumns = [
    for (final column in requiredColumns)
      if (!indexByName.containsKey(column)) column,
  ];
  if (missingColumns.isNotEmpty) {
    throw ArgumentError('CSV is missing columns: ${missingColumns.join(', ')}');
  }

  String value(List<String> row, String column) {
    final index = indexByName[column]!;
    return index < row.length ? row[index] : '';
  }

  final spells = <_CsvSpell>[];
  for (var rowIndex = 1; rowIndex < rows.length; rowIndex++) {
    final row = rows[rowIndex];
    if (row.every((value) => value.trim().isEmpty)) {
      continue;
    }

    spells.add(
      _CsvSpell(
        rowNumber: rowIndex + 1,
        name: _requiredText(value(row, 'name'), rowIndex, 'name'),
        description: _nullableText(value(row, 'description')),
        source: _nullableText(value(row, 'source')),
        level: _requiredInt(value(row, 'level'), rowIndex, 'level'),
        castingTime: _nullableText(value(row, 'castingTime')),
        range: _nullableText(value(row, 'range')),
        duration: _nullableText(value(row, 'duration')),
        concentration: _nullableBool(value(row, 'concentration')),
        ritual: _nullableBool(value(row, 'ritual')),
        higherLevel: _nullableText(value(row, 'higherLevel')),
        availableTo: _splitList(value(row, 'availableTo')),
        availableToSubclasses: _splitList(value(row, 'availableToSubclasses')),
        materialDescription: _nullableText(value(row, 'materialDescription')),
        materialCost: _nullableMaterialCost(value(row, 'materialCost')),
        materialConsumed: _nullableBool(value(row, 'materialConsumed')),
        requiresVerbal: _nullableBool(value(row, 'requiresVerbal')),
        requiresSomatic: _nullableBool(value(row, 'requiresSomatic')),
        requiresMaterial: _nullableBool(value(row, 'requiresMaterial')),
        schoolValue: _nullableText(value(row, 'schoolValue')),
        durationType: _nullableText(value(row, 'durationType')),
      ),
    );
  }

  return spells;
}

void _validateCsvSpells(List<_CsvSpell> spells) {
  final duplicateNames = _duplicates(spells.map((spell) => spell.name));
  if (duplicateNames.isNotEmpty) {
    throw StateError(
        'CSV contains duplicate spell names: ${duplicateNames.join(', ')}');
  }
  if (spells.length != _expectedSpellCount) {
    throw StateError(
      'CSV contains ${spells.length} spells, expected $_expectedSpellCount.',
    );
  }
}
