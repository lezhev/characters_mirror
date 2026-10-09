import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'package:test/test.dart';

void main() {
  final options = [
    {
      'optionKey': 'default',
      'automaticSelection': true,
      'requirements': [
        {
          'type': 'knownCantrip',
          'referenceKey': 'fixture_cantrip',
          'negate': true
        }
      ]
    },
    for (final key in ['alternative_a', 'alternative_b'])
      {
        'optionKey': key,
        'requirements': [
          {'type': 'knownCantrip', 'referenceKey': 'fixture_cantrip'},
          {'type': 'knownCantrip', 'referenceKey': key, 'negate': true},
        ]
      },
  ];
  test('automatic choice is selected only when a single option is eligible',
      () {
    expect(automaticChoiceOptionKey(options, ChoiceEligibilityContext()),
        'default');
    expect(
        automaticChoiceOptionKey(options,
            ChoiceEligibilityContext(knownCantripKeys: {'fixture_cantrip'})),
        isNull);
    expect(
        automaticChoiceOptionKey(
            options,
            ChoiceEligibilityContext(
                knownCantripKeys: {'fixture_cantrip', 'alternative_a'})),
        isNull);
  });
  const missing = ChoiceRequirement(
    kind: ChoiceRequirementKind.knownCantrip,
    referenceKey: 'fixture_cantrip',
    negate: true,
  );
  test('negative known-cantrip requirement permits only a new cantrip', () {
    expect(
        evaluateChoiceOptionEligibility(
                requirements: [missing], context: ChoiceEligibilityContext())
            .isEligible,
        isTrue);
    expect(
        evaluateChoiceOptionEligibility(
            requirements: [missing],
            context: ChoiceEligibilityContext(
                knownCantripKeys: {'fixture_cantrip'})).isEligible,
        isFalse);
  });
  test('negation never turns malformed metadata into an eligible option', () {
    expect(
        evaluateChoiceOptionEligibility(requirements: [
          const ChoiceRequirement(
              kind: ChoiceRequirementKind.knownCantrip, negate: true),
        ], context: ChoiceEligibilityContext())
            .isEligible,
        isFalse);
  });
  test('selected-choice prerequisites are reusable and validate their shape',
      () {
    const requirement = ChoiceRequirement(
      kind: ChoiceRequirementKind.selectedChoiceOption,
      choiceGroupKey: 'pact_boon',
      optionKey: 'tome',
    );
    expect(choiceRequirementIsWellFormed(requirement), isTrue);
    expect(
        evaluateChoiceOptionEligibility(
            requirements: [requirement],
            context: ChoiceEligibilityContext(
              selectedChoiceOptionKeys: {
                encodeSelectedChoiceOptionKey('pact_boon', 'tome'),
              },
            )).isEligible,
        isTrue);
    expect(
        choiceRequirementIsWellFormed(const ChoiceRequirement(
          kind: ChoiceRequirementKind.selectedChoiceOption,
          choiceGroupKey: 'pact_boon',
        )),
        isFalse);
  });
}
