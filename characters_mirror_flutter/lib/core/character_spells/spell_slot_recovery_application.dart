import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_shared/characters_mirror_shared.dart';

CharacterData applyCharacterSpellSlotRecovery(
    CharacterData character, CharacterSemanticActionData action) {
  final patch = applySpellSlotRecovery(character.toJson(), action.toJson());
  return character.copyWith(
    currentSpellSlots: patch['currentSpellSlots'] == null
        ? null
        : spellProtocolIntMap<int>(patch['currentSpellSlots']),
    currentPactSlots: patch['currentPactSlots'] == null
        ? null
        : spellProtocolIntMap<int>(patch['currentPactSlots']),
    resourceStates: (patch['resourceStates'] as List)
        .cast<Map>()
        .map((s) =>
            CharacterResourceStateData.fromJson(s.cast<String, dynamic>()))
        .toList(),
    spellRecoveryTriggers: (patch['spellRecoveryTriggers'] as Map?)?.map(
        (k, v) => MapEntry(
            k as String,
            SpellSlotRecoveryTriggerData.fromJson(
                (v as Map).cast<String, dynamic>()))),
  );
}

CharacterData applyCharacterSpellRecoveryEvent(CharacterData character,
        {required String event,
        required String sourceActionId,
        CharacterSemanticActionData? action}) =>
    CharacterData.fromJson({
      ...character.toJson(),
      ...spellSlotRecoveryEventPatch(character.toJson(),
          event: event,
          sourceActionId: sourceActionId,
          castAction: action?.toJson()),
    });
