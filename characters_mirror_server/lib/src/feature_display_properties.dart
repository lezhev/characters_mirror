import 'package:characters_mirror_server/src/generated/protocol.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as shared;

List<FeatureDisplayPropertyView> resolveDisplayPropertyViews({
  required Iterable<FeatureDisplayPropertyData> definitions,
  required int sourceLevel,
  int? characterLevel,
  int? subclassLevel,
  Map<String, int> abilityModifiers = const {},
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
      abilityModifiers: abilityModifiers,
    ))
      FeatureDisplayPropertyView(
        key: resolved.key,
        label: resolved.label,
        value: resolved.value,
        sortOrder: resolved.sortOrder,
      ),
  ];
}
