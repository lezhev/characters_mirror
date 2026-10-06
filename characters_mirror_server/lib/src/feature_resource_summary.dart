import 'package:characters_mirror_shared/characters_mirror_shared.dart'
    as shared;
import 'generated/protocol.dart';

List<CharacterResourceViewData> referenceResourceSummaries(
    List<FeatureResourceDefinitionData>? definitions,
    {required String? name,
    required int sourceLevel,
    required Map<String, int> abilityModifiers}) {
  final result = <CharacterResourceViewData>[];
  for (final d in definitions ?? const <FeatureResourceDefinitionData>[]) {
    if (d.choiceOptionId != null) continue;
    final unlimited = d.becomesUnlimitedAtLevel != null &&
        sourceLevel >= d.becomesUnlimitedAtLevel!;
    final maximum = shared.featureResourceSummaryMaximum(
        rule: d.maxRule.name,
        value: d.maxValue,
        abilityModifier: abilityModifiers[d.maxAbility?.name] ?? 0,
        sourceLevel: sourceLevel,
        characterLevel: sourceLevel,
        proficiencyBonus: 2 + ((sourceLevel - 1) ~/ 4),
        progression: [
          for (final row in d.progressionValues ??
              const <FeatureResourceProgressionValueData>[])
            (level: row.level, value: row.value)
        ]);
    if (maximum == null || (!unlimited && maximum <= 0)) continue;
    result.add(CharacterResourceViewData(
        key: d.key,
        name: d.name ?? name,
        kind: d.kind,
        current: unlimited ? 0 : maximum,
        max: unlimited ? 0 : maximum,
        isUnlimited: unlimited ? true : null,
        resetOn: d.resetOn,
        usageResetOn: d.usageResetOn,
        activationTrigger: d.activationTrigger));
  }
  return result..sort((a, b) => a.key.compareTo(b.key));
}
