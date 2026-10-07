import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import 'spellcasting_source.dart';

bool spellHasAttack(SpellData spell) => spell.attackType != null
    ? spell.attackType != SpellAttackType.none
    : spell.requiresAttackRoll == true;
bool spellHasSave(SpellData spell) =>
    normalizeSpellAbility(spell.savingThrowAbility) != null ||
    spell.requiresSavingThrow == true;

List<SpellSourceContext> characterSpellcastingSources(
        CharacterData character) =>
    [
      for (final entry in character.classEntries ?? <CharacterClassEntryData>[])
        if (entry.classData != null)
          SpellSourceContext(
              sourceKey: 'class:${entry.classData!.id}',
              label: entry.classData!.name ?? 'Класс',
              classDataId: entry.classData!.id,
              castingAbility: effectiveSpellcastingClass(
                      entry.classData!, entry.subclass, entry.level ?? 0)
                  .spellcastingAbilityValue
                  ?.name),
    ].where((s) => s.castingAbility != null).toList();

List<ResolvedCharacterSpellData> characterResolvedSpells(
    CharacterData character) {
  final resolved = character.derived?.resolvedSpells;
  if (resolved != null) return resolved;
  // Compatibility for cached pre-projection snapshots; new resolver snapshots
  // include canonical granted spell rows as well as selections.
  return resolveCharacterSpellCollection(
      character: character.toJson(),
      spells: [
        for (final s
            in character.spellSelections ?? <CharacterSpellSelectionData>[])
          if (s.spell != null) s.spell!.toJson()
      ]).map((s) => ResolvedCharacterSpellData.fromJson(s.toJson())).toList();
}

SpellPresentationContext characterSpellPresentationContext(
    CharacterData character, SpellSourceContext source,
    {int? castLevel}) {
  return spellPresentationContextForCharacter(
      character.toJson(), source.castingAbility,
      castLevel: castLevel);
}
