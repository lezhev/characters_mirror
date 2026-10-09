// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
part of '../character_sheet_state.dart';

extension CharacterSheetControllerSpellRecovery on CharacterSheetController {
  Future<void> recoverSpellSlots(
      SpellSlotRecoverySource source, Map<int, int> slots) async {
    final current = _requireCharacter();
    final action = CharacterSemanticActionData(
      sourceType: CharacterFeatureSourceType.values.byName(source.sourceType),
      sourceId: source.sourceId,
      recoveryEffectId: source.effectId,
      resourceKey: source.resourceKey,
      slotSource: source.slotSource.name,
      slotsToRestore: slots.isEmpty ? null : slots,
      recoveryTriggerId:
          current.spellRecoveryTriggers?[source.key]?.sourceActionId,
    );
    await _saveSemanticAction(applyCharacterSpellSlotRecovery(current, action),
        type: CharacterSyncOperationType.recoverSpellSlots, action: action);
  }
}
