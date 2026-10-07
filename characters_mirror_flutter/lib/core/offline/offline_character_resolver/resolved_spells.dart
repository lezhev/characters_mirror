part of '../offline_character_resolver.dart';

Future<List<ResolvedCharacterSpellData>> _resolveCharacterSpells(
    OfflineCacheDatabase cache,
    CharacterData character,
    List<ClassFeatureData> classFeatures,
    List<SubclassFeatureData> subclassFeatures,
    List<ChoiceOptionData> options) async {
  final spells = await cache.getReferenceList(
          'spell', offlineAllKey, SpellData.fromJson) ??
      [];
  final grants = await cache.getReferenceList(
          'class_spell_grant', offlineAllKey, ClassSpellGrantData.fromJson) ??
      [];
  final groups = await cache.getReferenceList(
          'choice_group', offlineAllKey, ChoiceGroupData.fromJson) ??
      [];
  return feature_modifiers
      .resolveCharacterSpellCollection(
        character: character.copyWith(derived: null).toJson(),
        spells: spells.map((s) => s.toJson()),
        classGrants: grants.map((s) => s.toJson()),
        classFeatures: classFeatures.map((s) => s.toJson()),
        subclassFeatures: subclassFeatures.map((s) => s.toJson()),
        selectedOptions: options.map((s) => s.toJson()),
        choiceGroups: groups.map((s) => s.toJson()),
      )
      .map((s) => ResolvedCharacterSpellData.fromJson(s.toJson()))
      .toList();
}
