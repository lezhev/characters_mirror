import 'feature_display_property_resolver.dart';
import 'feature_modifier_evaluator.dart';
import 'armor_class_resolver.dart';
import 'feature_modifier_protocol.dart';

List<FeatureDisplayPropertyValue> featureModifierDisplayPropertiesFromProtocol({
  required Iterable<Map<String, dynamic>> modifiers,
  required int sourceLevel,
  int? characterLevel,
  int? proficiencyBonus,
  Map<String, int> abilityModifiers = const {},
  Set<String> selectedChoiceOptionKeys = const {},
}) =>
    resolveFeatureModifierDisplayProperties(
      modifiers: modifiers.map((row) => featureModifierSpecFromProtocol(row,
          sourceFeatureKey: 'feature', sourceClassKey: 'source')),
      context: FeatureModifierContext(
        proficiencyBonus: proficiencyBonus ??
            2 + (((characterLevel ?? sourceLevel).clamp(1, 20) - 1) ~/ 4),
        classLevelsByKey: {'source': sourceLevel},
        activeFeatureKeys: {'feature'},
        abilityModifiers: abilityModifiers,
        selectedChoiceOptionKeys: selectedChoiceOptionKeys,
      ),
    );

List<FeatureDisplayPropertyValue> resolveFeatureModifierDisplayProperties({
  required Iterable<FeatureModifierSpec> modifiers,
  required FeatureModifierContext context,
}) {
  final result = <FeatureDisplayPropertyValue>[];
  final rows = {
    for (final modifier in modifiers) modifier.referenceKey: modifier
  };
  for (final modifier in rows.values) {
    final label = switch (modifier.target) {
      FeatureModifierTarget.armorClass =>
        modifier.operation == FeatureModifierOperation.baseArmorClass &&
                modifier.conditions.contains(FeatureModifierCondition.unarmored)
            ? 'КД без доспехов'
            : 'Класс доспеха',
      FeatureModifierTarget.hitPointMaximum => 'Максимум хитов',
      FeatureModifierTarget.spellHealing => 'Дополнительное лечение',
      _ => null,
    };
    if (label == null) continue;
    final spellTarget = isSpellModifierTarget(modifier.target);
    final evaluated = evaluateFeatureModifiers(
      modifiers: [modifier],
      context: context,
      spellContext: spellTarget
          ? FeatureModifierSpellContext(
              spellKey: modifier.spellKey,
              castLevel: modifier.minimumCastLevel ?? 1,
            )
          : null,
    );
    if (evaluated.isEmpty) continue;
    final resolved = evaluated.single;
    String value;
    if (modifier.operation == FeatureModifierOperation.baseArmorClass) {
      value =
          '${armorClassBaseFormula(resolved, context.abilityModifiers)} = ${resolved.value}';
    } else if (modifier.valueKind == FeatureModifierValueKind.castLevel) {
      final offset = modifier.staticValue ?? 0;
      value = 'Уровень ячейки';
      if (offset != 0) value += offset > 0 ? ' + $offset' : ' - ${-offset}';
      if (modifier.minimumCastLevel case final minimum?) {
        value += ' (от $minimum-го уровня)';
      }
    } else {
      value = modifier.operation == FeatureModifierOperation.add &&
              resolved.value > 0
          ? '+${resolved.value}'
          : '${resolved.value}';
    }
    result.add(FeatureDisplayPropertyValue(
      key: 'modifier:${modifier.referenceKey}',
      label: label,
      value: value,
      sortOrder: 100 + modifier.target.index,
    ));
  }
  result.sort((a, b) {
    final order = a.sortOrder!.compareTo(b.sortOrder!);
    return order != 0 ? order : a.key.compareTo(b.key);
  });
  return result;
}
