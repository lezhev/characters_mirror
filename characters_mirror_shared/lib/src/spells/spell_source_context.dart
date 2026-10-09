class SpellSourceContext {
  const SpellSourceContext(
      {required this.sourceKey,
      required this.label,
      this.classDataId,
      this.castingAbility,
      this.known = true,
      this.prepared = true,
      this.alwaysPrepared = false,
      this.granted = false,
      this.canUseSlots = true,
      this.activation,
      this.resourceSourceType,
      this.resourceSourceId,
      this.castAtSpellLevel,
      this.freeCastsFormula,
      this.freeCastsPerRest});
  final String sourceKey;
  final String label;
  final int? classDataId;
  final String? castingAbility;
  final bool known;
  final bool prepared;
  final bool alwaysPrepared;
  final bool granted;
  final bool canUseSlots;
  final Map<String, dynamic>? activation;
  final String? resourceSourceType;
  final int? resourceSourceId;
  final int? castAtSpellLevel;
  final String? freeCastsFormula;
  final String? freeCastsPerRest;

  factory SpellSourceContext.fromJson(Map<String, dynamic> json) =>
      SpellSourceContext(
          sourceKey: json['sourceKey'] as String,
          label: json['label'] as String,
          classDataId: json['classDataId'] as int?,
          castingAbility: json['castingAbility'] as String?,
          known: json['known'] as bool? ?? true,
          prepared: json['prepared'] as bool? ?? true,
          alwaysPrepared: json['alwaysPrepared'] == true,
          granted: json['granted'] == true,
          canUseSlots: json['canUseSlots'] as bool? ?? true,
          activation: (json['activation'] as Map?)?.cast<String, dynamic>(),
          resourceSourceType: json['resourceSourceType'] as String?,
          resourceSourceId: json['resourceSourceId'] as int?,
          castAtSpellLevel: json['castAtSpellLevel'] as int?,
          freeCastsFormula: json['freeCastsFormula'] as String?,
          freeCastsPerRest: json['freeCastsPerRest'] as String?);
  Map<String, dynamic> toJson() => {
        'sourceKey': sourceKey,
        'label': label,
        if (classDataId != null) 'classDataId': classDataId,
        if (castingAbility != null) 'castingAbility': castingAbility,
        'known': known,
        'prepared': prepared,
        'alwaysPrepared': alwaysPrepared,
        'granted': granted,
        'canUseSlots': canUseSlots,
        if (activation != null) 'activation': activation,
        if (resourceSourceType != null)
          'resourceSourceType': resourceSourceType,
        if (resourceSourceId != null) 'resourceSourceId': resourceSourceId,
        if (castAtSpellLevel != null) 'castAtSpellLevel': castAtSpellLevel,
        if (freeCastsFormula != null) 'freeCastsFormula': freeCastsFormula,
        if (freeCastsPerRest != null) 'freeCastsPerRest': freeCastsPerRest
      };
}

class ResolvedCharacterSpell {
  const ResolvedCharacterSpell(
      {required this.spellKey, required this.spell, required this.sources});
  final String spellKey;
  final Map<String, dynamic> spell;
  final List<SpellSourceContext> sources;
  bool get isCastable => sources.any((s) => s.prepared || s.alwaysPrepared);
  Map<String, dynamic> toJson() => {
        'spellKey': spellKey,
        'spell': spell,
        'sources': sources.map((s) => s.toJson()).toList()
      };
}
