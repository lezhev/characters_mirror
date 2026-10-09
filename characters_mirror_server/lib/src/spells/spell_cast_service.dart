import 'package:characters_mirror_shared/characters_mirror_shared.dart';
import '../generated/protocol.dart';
import '../validation/rules.dart';

CharacterData applyCharacterSpellCast(
    CharacterData character, CharacterSemanticActionData action) {
  Rules.shortText('semanticAction.spellKey', action.spellKey);
  Rules.shortText('semanticAction.spellSourceKey', action.spellSourceKey);
  Rules.shortText('semanticAction.slotSource', action.slotSource);
  final patch = applySpellCast(character.toJson(), action.toJson());
  final name = patch['activeConcentrationSpellName'] as String?;
  Rules.shortText('activeConcentrationSpellName', name);
  return character.copyWith(
      spellActivationUses: patch.containsKey('spellActivationUses')
          ? (patch['spellActivationUses'] as Map?)?.cast<String, int>()
          : character.spellActivationUses,
      resourceStates: patch.containsKey('resourceStates')
          ? (patch['resourceStates'] as List)
              .map((r) => CharacterResourceStateData.fromJson(
                  (r as Map).cast<String, dynamic>()))
              .toList()
          : character.resourceStates,
      currentSpellSlots: patch.containsKey('currentSpellSlots')
          ? _slots(patch['currentSpellSlots'])
          : character.currentSpellSlots,
      currentPactSlots: patch.containsKey('currentPactSlots')
          ? _slots(patch['currentPactSlots'])
          : character.currentPactSlots,
      activeConcentrationSpellName: name);
}

CharacterData adjustCharacterSpellSlots(
    CharacterData character, CharacterSemanticActionData action) {
  final pools = SpellSlotPools.fromCharacter(character.toJson());
  final source = spellActionSlotSource(character.toJson(), action.toJson());
  if (action.level == null || action.delta == null || action.delta == 0) {
    throw const SpellCastFailure('invalid_action',
        'Spell slot adjustment requires level and non-zero delta.');
  }
  final patch = pools.adjusted(source, action.level!, action.delta!);
  return character.copyWith(
      currentSpellSlots: _slots(patch['currentSpellSlots']),
      currentPactSlots: _slots(patch['currentPactSlots']));
}

Map<int, int>? _slots(dynamic value) =>
    value == null ? null : spellProtocolIntMap<int>(value);
