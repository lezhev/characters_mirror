import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

CharacterData applyCharacterSpellCast(
    CharacterData character, CharacterSemanticActionData action) {
  final patch = applySpellCast(character.toJson(), action.toJson());
  return character.copyWith(
      currentSpellSlots: patch.containsKey('currentSpellSlots')
          ? _slots(patch['currentSpellSlots'])
          : character.currentSpellSlots,
      currentPactSlots: patch.containsKey('currentPactSlots')
          ? _slots(patch['currentPactSlots'])
          : character.currentPactSlots,
      activeConcentrationSpellName:
          patch['activeConcentrationSpellName'] as String?);
}

CharacterData adjustCharacterSpellSlots(
    CharacterData character, CharacterSemanticActionData action) {
  if (action.level == null || action.delta == null || action.delta == 0) {
    throw StateError('Invalid slot action.');
  }
  final patch = SpellSlotPools.fromCharacter(character.toJson()).adjusted(
      spellActionSlotSource(character.toJson(), action.toJson()),
      action.level!,
      action.delta!);
  return character.copyWith(
      currentSpellSlots: _slots(patch['currentSpellSlots']),
      currentPactSlots: _slots(patch['currentPactSlots']));
}

Map<int, int>? _slots(dynamic value) =>
    value == null ? null : spellProtocolIntMap<int>(value);
