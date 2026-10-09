/// Stable, typed requirement kinds understood by the choice eligibility rules.
enum ChoiceRequirementKind {
  minimumClassLevel,
  minimumCharacterLevel,
  abilityScore,
  knownSpell,
  knownCantrip,
  feature,
  selectedChoiceOption,
  existingSkill,
  existingTool,
}

/// Spell selection facts use Stage 1 semantics: spellbook entries are known,
/// prepared entries are not automatically known, and cantrips are separate.
class ChoiceSpellSelectionFact {
  const ChoiceSpellSelectionFact({required this.key, required this.kind});

  final String key;
  final String kind;
}

({Set<String> knownSpellKeys, Set<String> knownCantripKeys})
    collectChoiceSpellFacts(Iterable<ChoiceSpellSelectionFact> selections) {
  final knownSpells = <String>{};
  final knownCantrips = <String>{};
  for (final selection in selections) {
    final key = selection.key.trim();
    if (key.isEmpty) continue;
    switch (selection.kind) {
      case 'knownCantrip':
        knownCantrips.add(key);
      case 'knownSpell':
      case 'spellbookSpell':
        knownSpells.add(key);
      case 'preparedSpell':
        break;
    }
  }
  return (
    knownSpellKeys: Set.unmodifiable(knownSpells),
    knownCantripKeys: Set.unmodifiable(knownCantrips)
  );
}

/// A single conjunctive requirement for a choice option.
class ChoiceRequirement {
  const ChoiceRequirement({
    required this.kind,
    this.classKey,
    this.ability,
    this.value,
    this.referenceKey,
    this.choiceGroupKey,
    this.optionKey,
    this.negate = false,
  });

  final ChoiceRequirementKind kind;
  final String? classKey;
  final String? ability;
  final int? value;
  final String? referenceKey;
  final String? choiceGroupKey;
  final String? optionKey;
  final bool negate;
}

/// Minimal facts needed to evaluate choice availability.
class ChoiceEligibilityContext {
  ChoiceEligibilityContext({
    this.totalCharacterLevel = 0,
    Map<String, int> classLevelsByReferenceKey = const {},
    Map<String, int> abilityScores = const {},
    Set<String> knownSpellKeys = const {},
    Set<String> knownCantripKeys = const {},
    Set<String> featureKeys = const {},
    Set<String> selectedChoiceOptionKeys = const {},
    Set<String> skillKeys = const {},
    Set<String> toolKeys = const {},
  })  : classLevelsByReferenceKey = Map.unmodifiable(classLevelsByReferenceKey),
        abilityScores = Map.unmodifiable(abilityScores),
        knownSpellKeys = Set.unmodifiable(knownSpellKeys),
        knownCantripKeys = Set.unmodifiable(knownCantripKeys),
        featureKeys = Set.unmodifiable(featureKeys),
        selectedChoiceOptionKeys = Set.unmodifiable(selectedChoiceOptionKeys),
        skillKeys = Set.unmodifiable(skillKeys),
        toolKeys = Set.unmodifiable(toolKeys);

  final int totalCharacterLevel;
  final Map<String, int> classLevelsByReferenceKey;
  final Map<String, int> abilityScores;
  final Set<String> knownSpellKeys;
  final Set<String> knownCantripKeys;
  final Set<String> featureKeys;
  final Set<String> selectedChoiceOptionKeys;
  final Set<String> skillKeys;
  final Set<String> toolKeys;
}

class ChoiceRequirementFailure {
  const ChoiceRequirementFailure({
    required this.requirement,
    required this.reason,
    this.actualValue,
  });

  final ChoiceRequirement requirement;
  final String reason;
  final int? actualValue;
}

bool choiceRequirementIsWellFormed(ChoiceRequirement requirement) {
  final key = requirement.referenceKey?.trim();
  return switch (requirement.kind) {
    ChoiceRequirementKind.minimumClassLevel =>
      (requirement.classKey?.trim().isNotEmpty ?? false) &&
          _validClassLevel(requirement.value),
    ChoiceRequirementKind.minimumCharacterLevel =>
      _validClassLevel(requirement.value),
    ChoiceRequirementKind.abilityScore =>
      (requirement.ability?.trim().isNotEmpty ?? false) &&
          _validValue(requirement.value),
    ChoiceRequirementKind.knownSpell ||
    ChoiceRequirementKind.knownCantrip ||
    ChoiceRequirementKind.feature ||
    ChoiceRequirementKind.existingSkill ||
    ChoiceRequirementKind.existingTool =>
      key != null && key.isNotEmpty,
    ChoiceRequirementKind.selectedChoiceOption =>
      (requirement.choiceGroupKey?.trim().isNotEmpty ?? false) &&
          (requirement.optionKey?.trim().isNotEmpty ?? false),
  };
}

class ChoiceOptionEligibility {
  const ChoiceOptionEligibility(this.failedRequirements);

  final List<ChoiceRequirementFailure> failedRequirements;

  bool get isEligible => failedRequirements.isEmpty;
}

/// Evaluates requirements as AND. Missing/malformed requirement data fails closed.
ChoiceOptionEligibility evaluateChoiceOptionEligibility({
  required Iterable<ChoiceRequirement> requirements,
  required ChoiceEligibilityContext context,
}) {
  final failures = <ChoiceRequirementFailure>[];
  for (final requirement in requirements) {
    final result = _evaluate(requirement, context);
    if (!requirement.negate || result?.reason == 'invalidRequirement') {
      if (result != null) failures.add(result);
    } else if (result == null) {
      failures.add(_failure(requirement, 'negatedRequirement'));
    }
  }
  return ChoiceOptionEligibility(List.unmodifiable(failures));
}

ChoiceRequirementFailure? _evaluate(
  ChoiceRequirement requirement,
  ChoiceEligibilityContext context,
) {
  int? actual;
  final key = requirement.referenceKey?.trim();
  switch (requirement.kind) {
    case ChoiceRequirementKind.minimumClassLevel:
      final classKey = requirement.classKey?.trim();
      if (classKey == null ||
          classKey.isEmpty ||
          !_validValue(requirement.value)) {
        return _failure(requirement, 'invalidRequirement');
      }
      actual = context.classLevelsByReferenceKey[classKey] ?? 0;
      if (actual >= requirement.value!) return null;
      return _failure(requirement, 'minimumClassLevel', actual);
    case ChoiceRequirementKind.minimumCharacterLevel:
      if (!_validValue(requirement.value)) {
        return _failure(requirement, 'invalidRequirement');
      }
      actual = context.totalCharacterLevel;
      if (actual >= requirement.value!) return null;
      return _failure(requirement, 'minimumCharacterLevel', actual);
    case ChoiceRequirementKind.abilityScore:
      final ability = requirement.ability?.trim();
      if (ability == null ||
          ability.isEmpty ||
          !_validValue(requirement.value)) {
        return _failure(requirement, 'invalidRequirement');
      }
      actual = context.abilityScores[ability] ?? 0;
      if (actual >= requirement.value!) return null;
      return _failure(requirement, 'abilityScore', actual);
    case ChoiceRequirementKind.knownSpell:
      if (key == null || key.isEmpty) {
        return _failure(requirement, 'invalidRequirement');
      }
      return context.knownSpellKeys.contains(key)
          ? null
          : _failure(requirement, 'knownSpell');
    case ChoiceRequirementKind.knownCantrip:
      if (key == null || key.isEmpty) {
        return _failure(requirement, 'invalidRequirement');
      }
      return context.knownCantripKeys.contains(key)
          ? null
          : _failure(requirement, 'knownCantrip');
    case ChoiceRequirementKind.feature:
      if (key == null || key.isEmpty) {
        return _failure(requirement, 'invalidRequirement');
      }
      return context.featureKeys.contains(key)
          ? null
          : _failure(requirement, 'feature');
    case ChoiceRequirementKind.selectedChoiceOption:
      final group = requirement.choiceGroupKey?.trim();
      final option = requirement.optionKey?.trim();
      if (group == null || group.isEmpty || option == null || option.isEmpty) {
        return _failure(requirement, 'invalidRequirement');
      }
      return context.selectedChoiceOptionKeys.contains(
        encodeSelectedChoiceOptionKey(group, option),
      )
          ? null
          : _failure(requirement, 'selectedChoiceOption');
    case ChoiceRequirementKind.existingSkill:
      if (key == null || key.isEmpty) {
        return _failure(requirement, 'invalidRequirement');
      }
      return context.skillKeys.contains(key)
          ? null
          : _failure(requirement, 'existingSkill');
    case ChoiceRequirementKind.existingTool:
      if (key == null || key.isEmpty) {
        return _failure(requirement, 'invalidRequirement');
      }
      return context.toolKeys.contains(key)
          ? null
          : _failure(requirement, 'existingTool');
  }
}

bool _validValue(int? value) => value != null && value >= 1 && value <= 30;

bool _validClassLevel(int? value) => value != null && value >= 1 && value <= 20;

String encodeSelectedChoiceOptionKey(String groupKey, String optionKey) =>
    '$groupKey\u0000$optionKey';

ChoiceRequirementFailure _failure(
  ChoiceRequirement requirement,
  String reason, [
  int? actualValue,
]) =>
    ChoiceRequirementFailure(
      requirement: requirement,
      reason: reason,
      actualValue: actualValue,
    );
