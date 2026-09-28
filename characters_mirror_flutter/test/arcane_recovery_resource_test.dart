import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  for (final fixture in [
    (level: 1, slots: <int, int>{1: 2}),
    (level: 5, slots: <int, int>{1: 4, 2: 3, 3: 2}),
  ]) {
    test('Wizard ${fixture.level} keeps Arcane Recovery structured offline',
        () async {
      const classId = 7;
      const featureId = 120;
      final wizard = ClassData(
        id: classId,
        name: 'Wizard',
        spellcastingProgression: SpellcastingProgression.full,
      );
      final feature = ClassFeatureData(
        id: featureId,
        parentClassId: classId,
        name: 'Магическое восстановление',
        level: 1,
        resources: [
          FeatureResourceDefinitionData(
            key: 'arcaneRecovery',
            kind: FeatureResourceKind.uses,
            maxRule: FeatureResourceMaxRule.fixed,
            maxValue: 1,
            resetOn: RestType.special,
            activationTrigger: FeatureResourceTrigger.shortRest,
            usageResetOn: RestType.longRest,
          ),
          FeatureResourceDefinitionData(
            key: 'invalidSpecialMax',
            kind: FeatureResourceKind.uses,
            maxRule: FeatureResourceMaxRule.special,
            maxValue: 5,
            becomesUnlimitedAtLevel: 1,
          ),
        ],
        resourceEffects: [
          FeatureResourceEffectData(
            type: FeatureResourceEffectType.restore,
            targetType: FeatureResourceTargetType.spellSlots,
            targetResourceKey: 'spellSlots',
            amountRule: FeatureResourceMaxRule.special,
          ),
          FeatureResourceEffectData(
            type: FeatureResourceEffectType.modify,
            targetResourceKey: 'arcaneRecovery',
            setMaxRule: FeatureResourceMaxRule.special,
          ),
        ],
      );
      await cache.putReference(
        offlineClassStepKind,
        offlineClassStepKey(classId, selectedLevel: fixture.level),
        ClassStepView(
          classData: wizard,
          selectedLevel: fixture.level,
          currentLevelFeatures: [feature],
        ),
        (value) => value.toJson(),
      );
      await cache.putReferenceList(
        'spell_slot_progression',
        offlineAllKey,
        [
          SpellSlotProgressionData(
            tableKey: 'standard',
            level: fixture.level,
            spellSlots: fixture.slots,
          ),
        ],
        (value) => value.toJson(),
      );

      final derived = await buildOfflineDerivedData(
        cache,
        CharacterData(
          classEntries: [
            CharacterClassEntryData(
              classData: wizard,
              level: fixture.level,
              isStartingClass: true,
            ),
          ],
        ),
      );

      final activeFeature = derived.activeFeatures!.single;
      final resource = activeFeature.resources!.single;
      expect(
        (
          resource.key,
          resource.max,
          resource.resetOn,
          resource.activationTrigger,
          resource.usageResetOn,
        ),
        (
          'arcaneRecovery',
          1,
          RestType.special,
          FeatureResourceTrigger.shortRest,
          RestType.longRest,
        ),
      );
      expect(derived.spellSlots, fixture.slots);

      final cachedStep = await cache.getReference<ClassStepView>(
        offlineClassStepKind,
        offlineClassStepKey(classId, selectedLevel: fixture.level),
        ClassStepView.fromJson,
      );
      final effect = cachedStep!.currentLevelFeatures!.single.resourceEffects!
          .singleWhere(
              (value) => value.type == FeatureResourceEffectType.restore);
      expect(
        (
          effect.type,
          effect.targetType,
          effect.targetResourceKey,
          effect.amountRule,
        ),
        (
          FeatureResourceEffectType.restore,
          FeatureResourceTargetType.spellSlots,
          'spellSlots',
          FeatureResourceMaxRule.special,
        ),
      );
    });
  }
}
