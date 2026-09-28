import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:characters_mirror_flutter/core/offline/offline_reference_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() => cache = OfflineCacheDatabase.openInMemory());
  tearDown(() => cache.close());

  test('class feature language grants are deduplicated across class entries',
      () async {
    await _cacheClassFeature(cache, 1, 31, Language.druidic);
    await _cacheClassFeature(cache, 2, 94, Language.thievesCant);
    final druid = _entry(1, 'Druid');
    final rogue = _entry(2, 'Rogue');

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(classEntries: [druid, rogue]),
    );

    final languages = derived.languages ?? const <Language>[];
    expect(languages, containsAll([Language.druidic, Language.thievesCant]));
    expect(languages.toSet().length, languages.length);
  });

  test('other classes do not receive class feature language grants', () async {
    await _cacheClassFeature(cache, 1, 31, Language.druidic);
    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(classEntries: [_entry(3, 'Fighter')]),
    );

    expect(derived.languages, isNot(contains(Language.druidic)));
  });

  test(
      'offline sheet keeps the resolved display properties from its class view',
      () async {
    const classId = 15;
    await cache.putReference(
      offlineClassStepKind,
      offlineClassStepKey(classId, selectedLevel: 12),
      ClassStepView(
        classData: ClassData(id: classId, name: 'Fixture class'),
        selectedLevel: 12,
        currentLevelFeatures: [
          ClassFeatureData(
            id: 90,
            parentClassId: classId,
            name: 'Fixture feature',
            level: 1,
          ),
        ],
        currentLevelFeatureViews: [
          ClassStepFeatureView(
            classFeature: ClassFeatureData(
              id: 90,
              parentClassId: classId,
              name: 'Fixture feature',
              level: 1,
            ),
            displayProperties: [
              FeatureDisplayPropertyView(
                key: 'progression',
                label: 'Параметр',
                value: '+3',
                sortOrder: 1,
              ),
            ],
          ),
        ],
      ),
      (value) => value.toJson(),
    );

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [
          CharacterClassEntryData(
            classData: ClassData(id: classId, name: 'Fixture class'),
            level: 12,
            isStartingClass: true,
          ),
        ],
      ),
    );

    expect(
      derived.activeFeatures!.single.displayProperties?.single.value,
      '+3',
    );
  });

  test('barbarian unarmored defense allows a shield and preserves custom AC',
      () async {
    await _cacheArmorCatalog(cache);
    await _cacheFeature(
        cache, 1, 1, UnarmoredDefenseRule.dexterityConstitution);

    final derived = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [_entry(1, 'Barbarian')],
        baseAbilityScores: {
          'dexterity': 16,
          'constitution': 14,
        },
        equippedShield: CharacterEquipmentSelectionData(
          name: 'Shield',
          referenceKey: 'shield',
        ),
        customArmorClassBonus: 1,
      ),
    );

    expect(derived.armorClass, 19);
  });

  test('monk unarmored defense is suppressed by a shield and armor', () async {
    await _cacheArmorCatalog(cache);
    await cache.putReferenceList<ArmorData>(
      'armor',
      offlineAllKey,
      [
        ArmorData(
          name: 'Chain Mail',
          referenceKey: 'chain_mail',
          categoryValue: ArmorCategory.heavy,
          baseAC: 16,
          dexBonus: false,
        ),
        ArmorData(
          name: 'Shield',
          referenceKey: 'shield',
          categoryValue: ArmorCategory.shield,
          bonusAC: 2,
        ),
      ],
      (value) => value.toJson(),
    );
    await _cacheFeature(cache, 4, 46, UnarmoredDefenseRule.dexterityWisdom);

    final unshielded = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [_entry(4, 'Monk')],
        baseAbilityScores: {'dexterity': 16, 'wisdom': 20},
      ),
    );

    final shielded = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [_entry(4, 'Monk')],
        baseAbilityScores: {'dexterity': 16, 'wisdom': 20},
        equippedShield: CharacterEquipmentSelectionData(
          name: 'Shield',
          referenceKey: 'shield',
        ),
      ),
    );
    final armored = await buildOfflineDerivedData(
      cache,
      CharacterData(
        classEntries: [_entry(4, 'Monk')],
        baseAbilityScores: {'dexterity': 16, 'wisdom': 20},
        equippedArmor: CharacterEquipmentSelectionData(
          name: 'Chain Mail',
          referenceKey: 'chain_mail',
        ),
      ),
    );

    expect(unshielded.armorClass, 18);
    expect(unshielded.armorClassSource, 'Защита без доспехов');
    expect(unshielded.armorClassFormula, contains('Мудрость (5)'));
    expect(shielded.armorClass, 15);
    expect(shielded.armorClassSource, 'Без доспеха');
    expect(shielded.armorClassFormula, contains('Щит (2)'));
    expect(armored.armorClass, 16);
    expect(armored.armorClassSource, 'Chain Mail');
    expect(armored.armorClassFormula, '16');
  });
}

CharacterClassEntryData _entry(int classId, String name) =>
    CharacterClassEntryData(
      id: 'class-$classId',
      classData: ClassData(id: classId, name: name, hitDieValue: 8),
      level: 1,
      isStartingClass: true,
      classOrder: 0,
    );

Future<void> _cacheClassFeature(
  OfflineCacheDatabase cache,
  int classId,
  int featureId,
  Language language,
) {
  return _cacheFeatures(
    cache,
    classId,
    [
      ClassFeatureData(
          id: featureId,
          parentClassId: classId,
          level: 1,
          grantedLanguages: [language])
    ],
  );
}

Future<void> _cacheFeature(
  OfflineCacheDatabase cache,
  int classId,
  int featureId,
  UnarmoredDefenseRule rule,
) {
  return _cacheFeatures(
    cache,
    classId,
    [
      ClassFeatureData(
          id: featureId,
          parentClassId: classId,
          level: 1,
          unarmoredDefenseRule: rule)
    ],
  );
}

Future<void> _cacheFeatures(
  OfflineCacheDatabase cache,
  int classId,
  List<ClassFeatureData> features,
) {
  return cache.putReference<ClassStepView>(
    offlineClassStepKind,
    offlineClassStepKey(classId),
    ClassStepView(
      classData: ClassData(id: classId),
      selectedLevel: 1,
      currentLevelFeatures: features,
    ),
    (value) => value.toJson(),
  );
}

Future<void> _cacheArmorCatalog(OfflineCacheDatabase cache) =>
    cache.putReferenceList<ArmorData>(
      'armor',
      offlineAllKey,
      [
        ArmorData(
          name: 'Chain Mail',
          referenceKey: 'chain_mail',
          categoryValue: ArmorCategory.heavy,
          baseAC: 16,
          dexBonus: false,
        ),
        ArmorData(
          name: 'Shield',
          referenceKey: 'shield',
          categoryValue: ArmorCategory.shield,
          bonusAC: 3,
        ),
      ],
      (value) => value.toJson(),
    );
