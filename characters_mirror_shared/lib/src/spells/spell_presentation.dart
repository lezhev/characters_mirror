import '../feature_modifier_evaluator.dart';

enum SpellHighlightKind {
  damage,
  healing,
  attack,
  save,
  condition,
  target,
  area,
  scaling
}

class SpellHighlight {
  const SpellHighlight(this.kind, this.label, this.value,
      {this.damageParts = const []});
  final SpellHighlightKind kind;
  final String label;
  final String value;
  final List<SpellDamageHighlight> damageParts;
}

class SpellDamageHighlight {
  const SpellDamageHighlight(
      {required this.formula, this.damageType, this.notes});
  final String formula;
  final String? damageType;
  final String? notes;
}

/// Context is intentionally independent of widgets and effect execution.
class SpellPresentationContext {
  const SpellPresentationContext(
      {this.casterLevel = 1,
      this.castLevel,
      this.castingAbility,
      this.abilityModifier,
      this.attackBonus,
      this.saveDc,
      this.featureModifiers = const [],
      this.modifierContext});
  final int casterLevel;
  final int? castLevel;
  final String? castingAbility;
  final int? abilityModifier;
  final int? attackBonus;
  final int? saveDc;
  final List<FeatureModifierSpec> featureModifiers;
  final FeatureModifierContext? modifierContext;
}

class SpellPresentation {
  const SpellPresentation(
      {required this.name,
      required this.level,
      required this.school,
      required this.metadata,
      required this.components,
      required this.highlights,
      this.description,
      this.shortDescription,
      this.higherLevel,
      this.materialDescription,
      this.materialCost,
      this.materialConsumed = false});
  final String name;
  final int level;
  final String? school;
  final List<String> metadata;
  final List<String> components;
  final List<SpellHighlight> highlights;
  final String? description;
  final String? shortDescription;
  final String? higherLevel;
  final String? materialDescription;
  final int? materialCost;
  final bool materialConsumed;

  List<SpellHighlight> get collapsedHighlights => highlights.take(3).toList();
  String? displayDescription({bool compact = false}) =>
      compact ? shortDescription ?? description : description;
  String get levelLabel => level == 0 ? 'Заговор' : '$level уровень';
  String get identityLabel =>
      [levelLabel, if (school != null) school!].join(' · ');
}

/// Decode line breaks only in presentation; do not unescape arbitrary content.
String? spellDescriptionText(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  return value.replaceAll(r'\r\n', '\n').replaceAll(r'\n', '\n');
}
