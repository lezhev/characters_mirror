part of '../character_data_endpoint.dart';

/// Materialize implicit counters before maxima change. A level change is not rest.
CharacterData _preserveLevelChangeResources(
    CharacterData before, CharacterData draft,
    {bool fillNewResources = true}) {
  final oldPools = SpellSlotPools.fromCharacter(before.toJson());
  final newSlots = draft.derived?.spellSlots ?? <int, int>{};
  final oldSlots = oldPools.standardMax;
  final oldPactAvailable =
      oldPools.pactCurrent.values.fold<int>(0, (sum, value) => sum + value);
  final newPactSlots = draft.derived?.pactSlots ?? <int, int>{};
  final oldDice = before.derived?.hitDiceSummary ?? const <String, int>{};
  final newDice = draft.derived?.hitDiceSummary ?? const <String, int>{};
  final oldResources = {
    for (final feature
        in before.derived?.activeFeatures ?? const <CharacterFeatureViewData>[])
      for (final r in feature.resources ?? const <CharacterResourceViewData>[])
        _resourceStateKey(feature.sourceType, feature.sourceId, r.key): r
  };
  return draft.copyWith(
    currentHp: min(before.currentHp ?? before.derived?.maxHp ?? 0,
        draft.derived?.maxHp ?? before.currentHp ?? before.derived?.maxHp ?? 0),
    currentSpellSlots: {
      for (final e in newSlots.entries)
        if (e.value > 0)
          e.key: (oldSlots[e.key] ?? 0) > 0
              ? min(
                  oldPools.standardCurrent[e.key] ?? oldSlots[e.key]!, e.value)
              : fillNewResources
                  ? e.value
                  : min(oldPools.standardCurrent[e.key] ?? oldSlots[e.key] ?? 0,
                      e.value)
    },
    currentPactSlots: newPactSlots.isEmpty
        ? null
        : {
            for (final e in newPactSlots.entries)
              e.key: min(
                  oldPools.pactMax.isNotEmpty
                      ? oldPactAvailable
                      : (fillNewResources ? e.value : 0),
                  e.value),
          },
    currentHitDice: {
      for (final e in newDice.entries)
        e.key: (oldDice[e.key] ?? 0) > 0
            ? min(before.currentHitDice?[e.key] ?? oldDice[e.key]!, e.value)
            : fillNewResources
                ? e.value
                : min(before.currentHitDice?[e.key] ?? oldDice[e.key] ?? 0,
                    e.value)
    },
    resourceStates: [
      for (final feature in draft.derived?.activeFeatures ??
          const <CharacterFeatureViewData>[])
        for (final r
            in feature.resources ?? const <CharacterResourceViewData>[])
          if (r.isUnlimited != true)
            CharacterResourceStateData(
                sourceType: feature.sourceType,
                sourceId: feature.sourceId,
                resourceKey: r.key,
                current: min(
                    oldResources[_resourceStateKey(
                                feature.sourceType, feature.sourceId, r.key)]
                            ?.current ??
                        (fillNewResources ? r.max : 0),
                    r.max))
    ],
  );
}
