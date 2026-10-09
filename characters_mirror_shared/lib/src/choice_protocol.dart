import 'choice_eligibility.dart';

Set<String> choiceCantripCandidateKeys(
        Iterable<Map<String, dynamic>> options) =>
    {
      for (final option in options)
        for (final row in (option['requirements'] as List? ?? []).cast<Map>())
          if ((row['type'] == 'knownCantrip' || row['type'] == 4) &&
              row['referenceKey'] is String)
            row['referenceKey'] as String,
    };

ChoiceRequirement choiceRequirementFromProtocol(Map<String, dynamic> data) =>
    ChoiceRequirement(
      kind: data['type'] is int
          ? ChoiceRequirementKind.values[data['type'] as int]
          : ChoiceRequirementKind.values.byName(data['type'] as String),
      classKey: data['classKey'] as String?,
      ability: data['ability'] as String?,
      value: data['value'] as int?,
      referenceKey: data['referenceKey'] as String?,
      choiceGroupKey: data['choiceGroupKey'] as String?,
      optionKey: data['optionKey'] as String?,
      negate: data['negate'] == true,
    );

ChoiceOptionEligibility choiceRequirementsEligibilityFromProtocol(
        Iterable<Map<String, dynamic>> requirements,
        ChoiceEligibilityContext context) =>
    evaluateChoiceOptionEligibility(
      requirements: requirements.map(choiceRequirementFromProtocol),
      context: context,
    );

ChoiceOptionEligibility choiceOptionEligibilityFromProtocol(
        Map<String, dynamic> option, ChoiceEligibilityContext context) =>
    evaluateChoiceOptionEligibility(requirements: [
      for (final row in (option['requirements'] as List? ?? []).cast<Map>())
        choiceRequirementFromProtocol(row.cast<String, dynamic>()),
      if (option['requiredExistingSkill'] case final String skill)
        ChoiceRequirement(
            kind: ChoiceRequirementKind.existingSkill, referenceKey: skill),
      if (option['requiredExistingToolKey'] case final String tool
          when tool.trim().isNotEmpty)
        ChoiceRequirement(
            kind: ChoiceRequirementKind.existingTool,
            referenceKey: tool.trim()),
    ], context: context);

String? automaticChoiceOptionKey(
    Iterable<Map<String, dynamic>> options, ChoiceEligibilityContext context) {
  final eligible = options
      .where((option) =>
          option['automaticSelection'] == true &&
          choiceOptionEligibilityFromProtocol(option, context).isEligible)
      .toList();
  return eligible.length == 1 ? eligible.single['optionKey'] as String : null;
}

Set<String> knownChoiceCantripKeys({
  required Map<String, dynamic> character,
  Iterable<Map<String, dynamic>> otherOptions = const [],
  Iterable<Map<String, dynamic>> otherFeatures = const [],
  Set<String> cantripReferenceKeys = const {},
  Iterable<String> otherGrantedCantripKeys = const [],
}) {
  final selections = (character['spellSelections'] as List? ?? []).cast<Map>();
  final result = <String>{
    ...otherGrantedCantripKeys,
    for (final row in selections)
      if (row['kind'] == 'knownCantrip' && row['spellKey'] is String)
        (row['spellKey'] as String).trim(),
    for (final row in [...otherOptions, ...otherFeatures])
      for (final key
          in (row['grantedSpellKeys'] as List? ?? []).whereType<String>())
        if (cantripReferenceKeys.contains(key)) key,
  };
  final totalLevel = (character['classEntries'] as List? ?? [])
      .cast<Map>()
      .fold<int>(0, (sum, entry) => sum + (entry['level'] as int? ?? 0));
  for (final race
      in [character['race'], character['subrace']].whereType<Map>()) {
    for (final feature in (race['features'] as List? ?? []).cast<Map>()) {
      if ((feature['level'] as int? ?? 1) > totalLevel.clamp(1, 20)) continue;
      for (final grant in (feature['spellGrants'] as List? ?? []).cast<Map>()) {
        if ((grant['grantedAtLevel'] as int? ?? 1) > totalLevel.clamp(1, 20))
          continue;
        final spell = grant['spell'] as Map?;
        final key = spell?['referenceKey'] as String?;
        if (spell?['level'] == 0 && key != null) result.add(key);
      }
    }
  }
  return result;
}
