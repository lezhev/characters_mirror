import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as shared;

List<FeatureDisplayPropertyView> resolveDisplayPropertyViews({
  required Iterable<FeatureDisplayPropertyData> definitions,
  required int sourceLevel,
  int? characterLevel,
  int? subclassLevel,
  int? proficiencyBonus,
  Map<String, int> abilityModifiers = const {},
  Iterable<FeatureModifierData> modifiers = const [],
  Set<String> selectedChoiceOptionKeys = const {},
}) {
  return [
    for (final resolved in shared.resolveFeatureDisplayProperties(
      definitions: [
        for (final definition in definitions)
          shared.FeatureDisplayPropertyDefinition(
            key: definition.key,
            label: definition.label,
            valueKind: switch (definition.valueKind) {
              FeatureDisplayPropertyValueKind.staticValue =>
                shared.FeatureDisplayPropertyValueKind.staticValue,
              FeatureDisplayPropertyValueKind.progression =>
                shared.FeatureDisplayPropertyValueKind.progression,
              FeatureDisplayPropertyValueKind.formula =>
                shared.FeatureDisplayPropertyValueKind.formula,
            },
            staticValue: definition.staticValue,
            progression: definition.progression,
            formula: definition.formula,
            sortOrder: definition.sortOrder,
          ),
      ],
      sourceLevel: sourceLevel,
      characterLevel: characterLevel,
      subclassLevel: subclassLevel,
      proficiencyBonus: proficiencyBonus,
      abilityModifiers: abilityModifiers,
    ))
      FeatureDisplayPropertyView(
        key: resolved.key,
        label: resolved.label,
        value: resolved.value,
        sortOrder: resolved.sortOrder,
        formula: resolved.formula,
      ),
    ...resolveModifierDisplayPropertyViews(
      modifiers: modifiers,
      sourceLevel: sourceLevel,
      characterLevel: characterLevel,
      proficiencyBonus: proficiencyBonus,
      abilityModifiers: abilityModifiers,
      selectedChoiceOptionKeys: selectedChoiceOptionKeys,
    ),
  ];
}

List<FeatureDisplayPropertyView> resolveModifierDisplayPropertyViews({
  required Iterable<FeatureModifierData> modifiers,
  required int sourceLevel,
  int? characterLevel,
  int? proficiencyBonus,
  Map<String, int> abilityModifiers = const {},
  Set<String> selectedChoiceOptionKeys = const {},
}) =>
    [
      for (final property
          in shared.featureModifierDisplayPropertiesFromProtocol(
        modifiers: modifiers.map((modifier) => modifier.toJson()),
        sourceLevel: sourceLevel,
        characterLevel: characterLevel,
        proficiencyBonus: proficiencyBonus,
        abilityModifiers: abilityModifiers,
        selectedChoiceOptionKeys: selectedChoiceOptionKeys,
      ))
        FeatureDisplayPropertyView(
            key: property.key,
            label: property.label,
            value: property.value,
            sortOrder: property.sortOrder,
            formula: property.formula),
    ];
