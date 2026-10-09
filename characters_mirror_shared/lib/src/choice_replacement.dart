/// All inputs are canonical groups/options. The caller supplies current eligibility.
List<Map<String, dynamic>> replaceProgressionChoices(
    Iterable<Map<String, dynamic>> choices,
    Iterable<Map<String, dynamic>> replacements,
    Iterable<Map<String, dynamic>> groups,
    {required String classEntryId,
    required int classLevel,
    bool Function(Map<String, dynamic>, Map<String, dynamic>)? isEligible}) {
  final catalog = {for (final group in groups) group['referenceKey']: group};
  // The catalog is scoped to this class step. Old snapshots may lack binding.
  final result = choices
      .map((row) => <String, dynamic>{
            ...row,
            if (row['classEntry'] == null &&
                catalog[row['groupKey']]?['progressionKey'] != null)
              'classEntry': {'id': classEntryId},
          })
      .toList();
  final counts = <dynamic, int>{};
  final replaced = <dynamic>{};
  for (final replacement in replacements) {
    final group = catalog[replacement['groupKey']];
    final index = result.indexWhere((choice) =>
        choice['id'] == replacement['selectionId'] &&
        (choice['classEntry'] as Map?)?['id'] == classEntryId);
    if (group == null ||
        index < 0 ||
        group['level'] != classLevel ||
        !replaced.add(replacement['selectionId']))
      throw ArgumentError('Unavailable replacement.');
    final key = group['referenceKey'];
    counts[key] = (counts[key] ?? 0) + 1;
    if (counts[key]! > (group['replacementsAllowed'] as int? ?? 0)) {
      throw ArgumentError('Too many replacements.');
    }
    final old = result[index];
    final oldGroup = catalog[old['groupKey']];
    final lines = group['replacementProgressionKeys'] as List? ??
        [group['progressionKey']];
    if (oldGroup == null ||
        oldGroup['progressionKey'] == null ||
        !lines.contains(oldGroup['progressionKey']) ||
        (oldGroup['level'] as int? ?? 1) >= classLevel)
      throw ArgumentError('Wrong progression line.');
    final option = (group['options'] as List? ?? [])
        .whereType<Map>()
        .where((option) =>
            (option['optionKey'] ?? option['referenceKey']) ==
            replacement['optionKey'])
        .firstOrNull;
    final oldOption = (oldGroup['options'] as List? ?? [])
        .whereType<Map>()
        .where((option) =>
            (option['optionKey'] ?? option['referenceKey']) ==
            replacement['optionKey'])
        .firstOrNull;
    if (option == null ||
        old['optionKey'] == replacement['optionKey'] ||
        isEligible?.call(group, option.cast<String, dynamic>()) == false ||
        oldOption != null &&
            isEligible?.call(oldGroup, oldOption.cast<String, dynamic>()) ==
                false) {
      throw ArgumentError('Unavailable replacement option.');
    }
    if (group['allowDuplicates'] != true &&
        result.any((choice) =>
            choice['id'] != old['id'] &&
            (choice['classEntry'] as Map?)?['id'] == classEntryId &&
            (lines.contains(catalog[choice['groupKey']]?['progressionKey']) ||
                choice['groupKey'] == group['referenceKey']) &&
            choice['optionKey'] == replacement['optionKey']))
      throw ArgumentError('Duplicate progression choice.');
    result[index] = {
      ...old,
      'optionKey': replacement['optionKey'],
      'replacementHistory': [
        ...?old['replacementHistory'] as List?,
        {
          'classLevel': classLevel,
          'previousOptionKey': old['optionKey'],
          'replacementGroupKey': replacement['groupKey']
        }
      ]
    };
  }
  return result;
}

/// Keeps the acquisition group while resolving a later option in the same line.
/// [groups] must contain only groups unlocked for this character.
Map<String, dynamic>? resolveProgressionChoiceOption(
    Map<String, dynamic> choice,
    Iterable<Map<String, dynamic>> groups,
    Iterable<Map<String, dynamic>> options) {
  final catalog = {for (final group in groups) group['referenceKey']: group};
  final group = catalog[choice['groupKey']];
  if (group == null) return null;
  final own = options
      .where((o) =>
          o['choiceGroupId'] == group['id'] &&
          o['optionKey'] == choice['optionKey'])
      .firstOrNull;
  if (own != null) return own;
  final history = choice['replacementHistory'] as List? ?? [];
  if (history.isEmpty || group['progressionKey'] == null) return null;
  final replacementLevel = (history.last as Map)['classLevel'] as int;
  final authorityKey = (history.last as Map)['replacementGroupKey'];
  final snapshots = catalog.values
      .where((g) =>
          (authorityKey == null
              ? g['progressionKey'] == group['progressionKey']
              : g['referenceKey'] == authorityKey &&
                  (g['replacementProgressionKeys'] as List? ??
                          [g['progressionKey']])
                      .contains(group['progressionKey'])) &&
          (g['level'] as int? ?? 1) >= replacementLevel)
      .toList()
    ..sort(
        (a, b) => (a['level'] as int? ?? 1).compareTo(b['level'] as int? ?? 1));
  for (final snapshot in snapshots) {
    final option = options
        .where((o) =>
            o['choiceGroupId'] == snapshot['id'] &&
            o['optionKey'] == choice['optionKey'])
        .firstOrNull;
    if (option != null) return {...option, 'choiceGroupId': group['id']};
  }
  return null;
}

List<Map<String, dynamic>> rollbackProgressionChoices(
        Iterable<Map<String, dynamic>> choices,
        {required String classEntryId,
        required int targetLevel}) =>
    [
      for (final choice in choices) _rollback(choice, classEntryId, targetLevel)
    ];

Map<String, dynamic> _rollback(
    Map<String, dynamic> choice, String entryId, int target) {
  if ((choice['classEntry'] as Map?)?['id'] != entryId) return {...choice};
  final history = [...?choice['replacementHistory'] as List?];
  var option = choice['optionKey'];
  while (history.isNotEmpty && (history.last as Map)['classLevel'] > target) {
    option = (history.removeLast() as Map)['previousOptionKey'];
  }
  return {
    ...choice,
    'optionKey': option,
    'replacementHistory': history.isEmpty ? null : history
  };
}
