import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/offline/offline_cache_database.dart';
import 'package:characters_mirror_flutter/core/offline/offline_character_resolver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late OfflineCacheDatabase cache;

  setUp(() {
    cache = OfflineCacheDatabase.openInMemory();
  });

  tearDown(() {
    cache.close();
  });

  test('fixed reference skills contribute to offline derived proficiencies',
      () async {
    final character = CharacterData(
      race: RaceData(
        skillProficiencies: const [Skill.athletics],
        languages: const [Language.common],
        armorProficiencies: const [ArmorCategory.heavy],
      ),
      subrace: SubraceData(
        parentRaceId: 1,
        skillProficiencies: const [Skill.stealth],
        armorProficiencies: const [ArmorCategory.shield],
      ),
      background: BackgroundData(skillProficiencies: const [Skill.insight]),
    );

    final derived = await buildOfflineDerivedData(cache, character);
    final levels = {
      for (final state in derived.skillProficiencyLevels ??
          const <CharacterSkillProficiencyState>[])
        state.skill: state.level,
    };

    expect(
      levels[Skill.athletics],
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(
      levels[Skill.stealth],
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(
      levels[Skill.insight],
      CharacterSkillProficiencyLevel.proficient,
    );
    expect(
      levels[Skill.arcana],
      CharacterSkillProficiencyLevel.none,
    );
    expect(derived.languages, [Language.common.name]);
    expect(
      derived.armorTraining,
      unorderedEquals([
        ArmorCategory.heavy.name,
        ArmorCategory.shield.name,
      ]),
    );
  });

  test('multiclass saving throws match server starting-class semantics',
      () async {
    final fighter = ClassData(
      name: 'Fighter',
      savingThrowProficiencies: const [
        Ability.strength,
        Ability.constitution,
      ],
    );
    final wizard = ClassData(
      name: 'Wizard',
      savingThrowProficiencies: const [
        Ability.intelligence,
        Ability.wisdom,
      ],
    );
    final character = CharacterData(
      classEntries: [
        CharacterClassEntryData(
          classData: wizard,
          level: 1,
          isStartingClass: false,
          classOrder: 1,
        ),
        CharacterClassEntryData(
          classData: fighter,
          level: 1,
          isStartingClass: true,
          classOrder: 0,
        ),
      ],
      manualSavingThrowProficiencyOverrides: [
        CharacterSavingThrowProficiencyOverrideData(
          ability: Ability.constitution,
          state: CharacterSavingThrowProficiencyOverride.remove,
        ),
        CharacterSavingThrowProficiencyOverrideData(
          ability: Ability.dexterity,
          state: CharacterSavingThrowProficiencyOverride.add,
        ),
      ],
    );

    final derived = await buildOfflineDerivedData(cache, character);

    expect(
      derived.savingThrowProficiencies,
      unorderedEquals([Ability.strength, Ability.dexterity]),
    );
  });

  test('saving throw fallback uses the lowest class order', () async {
    final fighter = ClassData(
      name: 'Fighter',
      savingThrowProficiencies: const [
        Ability.strength,
        Ability.constitution,
      ],
    );
    final wizard = ClassData(
      name: 'Wizard',
      savingThrowProficiencies: const [
        Ability.intelligence,
        Ability.wisdom,
      ],
    );
    final character = CharacterData(
      classEntries: [
        CharacterClassEntryData(
          classData: wizard,
          level: 1,
          classOrder: 2,
        ),
        CharacterClassEntryData(
          classData: fighter,
          level: 1,
          classOrder: 1,
        ),
      ],
    );

    final derived = await buildOfflineDerivedData(cache, character);

    expect(
      derived.savingThrowProficiencies,
      unorderedEquals([Ability.strength, Ability.constitution]),
    );
  });
}
