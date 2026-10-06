const selectedFeatureChoiceContract = [
  <String, Object?>{
    'groupKey': 'decision_a',
    'groupTitle': 'Refinement A',
    'optionKey': 'a',
    'name': 'Selected A',
    'shortDescription': 'Short A',
  },
  <String, Object?>{
    'groupKey': 'decision_b',
    'groupTitle': 'Refinement B',
    'optionKey': 'b',
    'name': 'Selected B',
  },
];

List<Map<String, Object?>> selectedChoiceProjection(
  Iterable<Map<String, dynamic>> choices,
) => [
  for (final choice in choices)
    {
      for (final key in [
        'groupKey',
        'groupTitle',
        'optionKey',
        'name',
        'shortDescription',
      ])
        if (choice[key] != null) key: choice[key],
    },
];
