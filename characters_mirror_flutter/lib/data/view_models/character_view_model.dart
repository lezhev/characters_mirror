// import 'package:characters_mirror_client/characters_mirror_client.dart';
// import 'package:characters_mirror_flutter/data/repositories/character_repository.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class CharacterViewModel extends AutoDisposeNotifier<CharacterViewState> {
//   late final _repo = ref.read(characterRepositoryProvider);

//   @override
//   CharacterViewState build() => CharacterViewState.initial();

//   Future<void> loadCharacters() async {
//     state = state.copyWith(isLoading: true);
//     try {
//       final characters = await _repo.getAll();
//       state = state.copyWith(characters: characters, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(error: e.toString(), isLoading: false);
//     }
//   }

//   void startEditing(CharacterData character) {
//     state = state.copyWith(editingCharacter: character);
//   }

//   void cancelEditing() {
//     state = state.copyWith(editingCharacter: null);
//   }

//   Future<void> saveCharacter({
//     required String name,
//     String? source,
//     int? version,
//     int? experience,
//     Map<String, int>? attributes,
//     RaceData? race,
//     SubraceData? subrace,
//     List<ClassData>? classes,
//     List<SubclassData>? subclasses,
//     List<ClassFeatureData>? classFeatures,
//     BackgroundData? background,
//     String? alignment,
//     int? armorClass,
//     int? speed,
//     int? coins,
//     List<String>? skillProficiencies,
//     List<String>? skillExpertises,
//     int? maxHp,
//     int? temporaryHp,
//     int? currentHp,
//     SpellData? preparedSpells,
//     SpellData? writtenSpells,
//     ItemData? items,
//     MagicItemData? magicItems,
//     ArmorData? armor,
//     WeaponData? weapons,
//   }) async {
//     final character = state.editingCharacter;
//     final now = DateTime.now();

//     final data = (character == null)
//         ? CharacterData(
//             name: name,
//             source: source,
//             version: version,
//             createdAt: now,
//             updatedAt: now,
//             experience: experience,
//             attributes: attributes,
//             race: race,
//             subrace: subrace,
//             classes: classes,
//             subclasses: subclasses,
//             classFeatures: classFeatures,
//             background: background,
//             alignment: alignment,
//             armorClass: armorClass,
//             speed: speed,
//             coins: coins,
//             skillProficiencies: skillProficiencies,
//             skillExpertises: skillExpertises,
//             maxHp: maxHp,
//             temporaryHp: temporaryHp,
//             currentHp: currentHp,
//             preparedSpells: preparedSpells,
//             writtenSpells: writtenSpells,
//             items: items,
//             magicItems: magicItems,
//             armor: armor,
//             weapons: weapons,
            
//           )
//         : character.copyWith(
//             name: name,
//             source: source,
//             version: version,
//             updatedAt: now,
//             experience: experience,
//             attributes: attributes,
//             race: race,
//             subrace: subrace,
//             classes: classes,
//             subclasses: subclasses,
//             classFeatures: classFeatures,
//             background: background,
//             alignment: alignment,
//             armorClass: armorClass,
//             speed: speed,
//             coins: coins,
//             skillProficiencies: skillProficiencies,
//             skillExpertises: skillExpertises,
//             maxHp: maxHp,
//             temporaryHp: temporaryHp,
//             currentHp: currentHp,
//             preparedSpells: preparedSpells,
//             writtenSpells: writtenSpells,
//             items: items,
//             magicItems: magicItems,
//             armor: armor,
//             weapons: weapons,
//           );

//     try {
//       if (character == null) {
//         await _repo.add(data);
//       } else {
//         await _repo.update(data);
//       }
//       await loadCharacters();
//       cancelEditing();
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }

//   Future<void> deleteCharacter(int id) async {
//     try {
//       await _repo.delete(id);
//       await loadCharacters();
//     } catch (e) {
//       state = state.copyWith(error: e.toString());
//     }
//   }
// }

// class CharacterViewState {
//   final List<CharacterData> characters;
//   final CharacterData? editingCharacter;
//   final bool isLoading;
//   final String? error;

//   CharacterViewState({
//     required this.characters,
//     this.editingCharacter,
//     required this.isLoading,
//     this.error,
//   });

//   factory CharacterViewState.initial() =>
//       CharacterViewState(characters: [], isLoading: false);

//   CharacterViewState copyWith({
//     List<CharacterData>? characters,
//     CharacterData? editingCharacter,
//     bool? isLoading,
//     String? error,
//   }) =>
//       CharacterViewState(
//         characters: characters ?? this.characters,
//         editingCharacter: editingCharacter ?? this.editingCharacter,
//         isLoading: isLoading ?? this.isLoading,
//         error: error ?? this.error,
//       );
// }
