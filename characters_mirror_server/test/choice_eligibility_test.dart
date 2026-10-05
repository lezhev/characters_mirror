import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  test('class and character levels are evaluated separately', () {
    final context = ChoiceEligibilityContext(
      totalCharacterLevel: 6,
      classLevelsByReferenceKey: {'warlock': 3, 'fighter': 3},
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.minimumCharacterLevel,
            value: 5,
          ),
        ],
        context: context,
      ).isEligible,
      isTrue,
    );
    for (final warlockLevel in [3, 4]) {
      expect(
        evaluateChoiceOptionEligibility(
          requirements: const [
            ChoiceRequirement(
              kind: ChoiceRequirementKind.minimumClassLevel,
              classKey: 'warlock',
              value: 5,
            ),
          ],
          context: ChoiceEligibilityContext(
            totalCharacterLevel: 6,
            classLevelsByReferenceKey: {'warlock': warlockLevel},
          ),
        ).isEligible,
        isFalse,
      );
    }
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.minimumClassLevel,
            classKey: 'warlock',
            value: 5,
          ),
        ],
        context: ChoiceEligibilityContext(
          classLevelsByReferenceKey: {'warlock': 5},
        ),
      ).isEligible,
      isTrue,
    );
  });

  test('ability requirements expose a structured failure', () {
    const requirement = ChoiceRequirement(
      kind: ChoiceRequirementKind.abilityScore,
      ability: 'charisma',
      value: 13,
    );
    final failure = evaluateChoiceOptionEligibility(
      requirements: const [requirement],
      context: ChoiceEligibilityContext(abilityScores: {'charisma': 12}),
    ).failedRequirements.single;
    expect(failure.reason, 'abilityScore');
    expect(failure.actualValue, 12);
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [requirement],
        context: ChoiceEligibilityContext(abilityScores: {'charisma': 13}),
      ).isEligible,
      isTrue,
    );
  });

  test('known spell semantics count spellbook entries but exclude prepared',
      () {
    final facts = collectChoiceSpellFacts([
      const ChoiceSpellSelectionFact(key: 'hex', kind: 'spellbookSpell'),
      const ChoiceSpellSelectionFact(key: 'light', kind: 'knownCantrip'),
      const ChoiceSpellSelectionFact(key: 'shield', kind: 'preparedSpell'),
    ]);
    expect(facts.knownSpellKeys, contains('hex'));
    expect(facts.knownSpellKeys, isNot(contains('shield')));
    expect(facts.knownCantripKeys, contains('light'));
    expect(facts.knownSpellKeys, isNot(contains('light')));
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.knownCantrip,
            referenceKey: 'light',
          ),
        ],
        context: ChoiceEligibilityContext(
          knownCantripKeys: facts.knownCantripKeys,
        ),
      ).isEligible,
      isTrue,
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.knownSpell,
            referenceKey: 'light',
          ),
        ],
        context: ChoiceEligibilityContext(
          knownSpellKeys: facts.knownSpellKeys,
        ),
      ).isEligible,
      isFalse,
    );
  });

  test('stable feature and dependent choice keys determine availability', () {
    const dependent = ChoiceRequirement(
      kind: ChoiceRequirementKind.selectedChoiceOption,
      choiceGroupKey: 'pact',
      optionKey: 'blade',
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [dependent],
        context: ChoiceEligibilityContext(),
      ).isEligible,
      isFalse,
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [dependent],
        context: ChoiceEligibilityContext(
          selectedChoiceOptionKeys: {
            encodeSelectedChoiceOptionKey('pact', 'blade'),
          },
        ),
      ).isEligible,
      isTrue,
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.feature,
            referenceKey: 'warlock.pact_magic',
          ),
        ],
        context: ChoiceEligibilityContext(featureKeys: {'warlock.pact_magic'}),
      ).isEligible,
      isTrue,
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.feature,
            referenceKey: 'warlock.pact_magic',
          ),
        ],
        context: ChoiceEligibilityContext(),
      ).isEligible,
      isFalse,
    );
  });

  test('requirements use AND and malformed data fails closed', () {
    const requirements = [
      ChoiceRequirement(
        kind: ChoiceRequirementKind.minimumCharacterLevel,
        value: 5,
      ),
      ChoiceRequirement(
        kind: ChoiceRequirementKind.knownSpell,
        referenceKey: 'hex',
      ),
    ];
    final unavailable = evaluateChoiceOptionEligibility(
      requirements: requirements,
      context: ChoiceEligibilityContext(totalCharacterLevel: 5),
    );
    expect(unavailable.isEligible, isFalse);
    expect(unavailable.failedRequirements.single.reason, 'knownSpell');
    expect(
      evaluateChoiceOptionEligibility(
        requirements: requirements,
        context: ChoiceEligibilityContext(
          totalCharacterLevel: 5,
          knownSpellKeys: {'hex'},
        ),
      ).isEligible,
      isTrue,
    );
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(kind: ChoiceRequirementKind.minimumClassLevel),
        ],
        context: ChoiceEligibilityContext(),
      ).failedRequirements.single.reason,
      'invalidRequirement',
    );
  });

  test('legacy skill and tool requirements use the same evaluator', () {
    expect(
      evaluateChoiceOptionEligibility(
        requirements: const [
          ChoiceRequirement(
            kind: ChoiceRequirementKind.existingSkill,
            referenceKey: 'perception',
          ),
          ChoiceRequirement(
            kind: ChoiceRequirementKind.existingTool,
            referenceKey: 'thieves_tools',
          ),
        ],
        context: ChoiceEligibilityContext(
          skillKeys: {'perception'},
          toolKeys: {'thieves_tools'},
        ),
      ).isEligible,
      isTrue,
    );
  });
}
