part of '../character_data_endpoint.dart';

Future<List<ResolvedCharacterSpellData>> _resolveCharacterSpells(
    _CharacterResolveContext context,
    CharacterData character,
    _ResolvedDerivedSources sources,
    List<String> keys,
    {Transaction? transaction}) async {
  final spells = await context.spells(keys.toSet(), transaction: transaction);
  final grants = await context.classSpellGrants(transaction: transaction);
  final groups = await context.choiceGroups(transaction: transaction);
  return resolveCharacterSpellCollection(
    character: character.copyWith(derived: null).toJson(),
    spells: spells.map((s) => s.toJson()),
    classGrants: grants.map((s) => s.toJson()),
    classFeatures: sources.currentClassFeatures.map((s) => s.toJson()),
    subclassFeatures: sources.currentSubclassFeatures.map((s) => s.toJson()),
    selectedOptions: sources.selectedOptions.map((s) => s.toJson()),
    choiceGroups: groups.map((s) => s.toJson()),
  ).map((s) => ResolvedCharacterSpellData.fromJson(s.toJson())).toList();
}
