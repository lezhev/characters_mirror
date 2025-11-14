import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'character_creation_state.freezed.dart';
part 'character_creation_state.g.dart';

enum Step {
  introduction,
  race,
  classStep,
  background,
  attributes,
  personal,
  summary
}

@freezed
sealed class CharacterCreationState with _$CharacterCreationState {
  const factory CharacterCreationState({
    required CharacterData character,
    required Step step,
  }) = _CharacterCreationState;

  factory CharacterCreationState.initial() => CharacterCreationState(
      character: CharacterData(), step: Step.introduction);
}

@Riverpod(keepAlive: true)
class CharacterCreation extends _$CharacterCreation {
  @override
  CharacterCreationState build() => CharacterCreationState.initial();
  //TODO: add dispose
  String _nextStep() {
    switch (state.step) {
      case Step.introduction:
        return 'race';
      case Step.race:
        return 'classStep';
      case Step.classStep:
        return 'background';
      case Step.background:
        return 'attributes';
      case Step.attributes:
        return 'personal';
      case Step.personal:
        return 'summary';
      case Step.summary:
        return 'summary';
    }
  }

  String _previousStep() {
    switch (state.step) {
      case Step.introduction:
        return '';
      case Step.race:
        return 'introduction';
      case Step.classStep:
        return 'race';
      case Step.background:
        return 'classStep';
      case Step.attributes:
        return 'background';
      case Step.personal:
        return 'attributes';
      case Step.summary:
        return 'personal';
    }
  }

  void nextStep(BuildContext context) {
    final next = _nextStep();
    context.push('/create/$next');
    state = state.copyWith(
      step: Step.values.firstWhere((e) => e.name == next),
    );
  }

  void prevStep(BuildContext context) {
    context.pop();
    state = state.copyWith(
      step: Step.values.firstWhere((e) => e.name == _previousStep()),
    );
  }

  void goToStep(BuildContext context, Step step) {
    context.push('/create/${step.name}');
    state = state.copyWith(step: step);
  }

  // === Обновление данных персонажа ===
  void setName(String name) =>
      _updateCharacter(state.character.copyWith(name: name));

  void setExperience(int? experience) =>
      _updateCharacter(state.character.copyWith(experience: experience));

  void setAlignment(String? alignment) =>
      _updateCharacter(state.character.copyWith(alignment: alignment));

  void setCoins(int? coins) =>
      _updateCharacter(state.character.copyWith(coins: coins));

// === Атрибуты ===
  void setAttribute(String key, int value) {
    final updated = Map<String, int>.from(state.character.attributes ?? {});
    updated[key] = value;
    _updateCharacter(state.character.copyWith(attributes: updated));
  }

  void setAttributes(Map<String, int> newAttributes) =>
      _updateCharacter(state.character.copyWith(attributes: newAttributes));

// === Раса / Подраса ===
  void setRace(RaceData? race) =>
      _updateCharacter(state.character.copyWith(race: race));

  void setSubrace(SubraceData? subrace) =>
      _updateCharacter(state.character.copyWith(subrace: subrace));

// === Классы / Черты класса ===
  void setClasses(List<ClassData>? classes) =>
      _updateCharacter(state.character.copyWith(classes: classes));

  void addClass(ClassData classData) {
    final updated = <ClassData>[...?state.character.classes, classData];
    _updateCharacter(state.character.copyWith(classes: updated));
  }

  void removeClass(ClassData classData) {
    final updated = <ClassData>[...?state.character.classes]..remove(classData);
    _updateCharacter(state.character.copyWith(classes: updated));
  }

  void setClassFeatures(List<ClassFeatureData>? features) =>
      _updateCharacter(state.character.copyWith(classFeatures: features));

// === Предыстория ===
  void setBackground(BackgroundData? background) =>
      _updateCharacter(state.character.copyWith(background: background));

// === Параметры боя ===
  void setArmorClass(int? value) =>
      _updateCharacter(state.character.copyWith(armorClass: value));

  void setSpeed(int? value) =>
      _updateCharacter(state.character.copyWith(speed: value));

  void setMaxHp(int? value) =>
      _updateCharacter(state.character.copyWith(maxHp: value));

  void setTemporaryHp(int? value) =>
      _updateCharacter(state.character.copyWith(temporaryHp: value));

  void setCurrentHp(int? value) =>
      _updateCharacter(state.character.copyWith(currentHp: value));

// === Навыки ===
  void setSkillProficiencies(List<String>? skills) =>
      _updateCharacter(state.character.copyWith(skillProficiencies: skills));

  void addSkillProficiency(String skill) {
    final updated = <String>[...?state.character.skillProficiencies, skill];
    _updateCharacter(state.character.copyWith(skillProficiencies: updated));
  }

  void removeSkillProficiency(String skill) {
    final updated = <String>[...?state.character.skillProficiencies]
      ..remove(skill);
    _updateCharacter(state.character.copyWith(skillProficiencies: updated));
  }

  void setSkillExpertises(List<String>? skills) =>
      _updateCharacter(state.character.copyWith(skillExpertises: skills));

  void addSkillExpertise(String skill) {
    final updated = <String>[...?state.character.skillExpertises, skill];
    _updateCharacter(state.character.copyWith(skillExpertises: updated));
  }

  void removeSkillExpertise(String skill) {
    final updated = <String>[...?state.character.skillExpertises]
      ..remove(skill);
    _updateCharacter(state.character.copyWith(skillExpertises: updated));
  }

// === Снаряжение и предметы ===
  void setItems(List<ItemData>? items) =>
      _updateCharacter(state.character.copyWith(items: items));

  void addItem(ItemData item) {
    final updated = <ItemData>[...?state.character.items, item];
    _updateCharacter(state.character.copyWith(items: updated));
  }

  void setMagicItems(List<MagicItemData>? items) =>
      _updateCharacter(state.character.copyWith(magicItems: items));

  void addMagicItem(MagicItemData item) {
    final updated = <MagicItemData>[...?state.character.magicItems, item];
    _updateCharacter(state.character.copyWith(magicItems: updated));
  }

  void setWeapons(List<WeaponData>? weapons) =>
      _updateCharacter(state.character.copyWith(weapons: weapons));

  void addWeapon(WeaponData weapon) {
    final updated = <WeaponData>[...?state.character.weapons, weapon];
    _updateCharacter(state.character.copyWith(weapons: updated));
  }

  void setArmor(List<ArmorData>? armor) =>
      _updateCharacter(state.character.copyWith(armor: armor));

  void addArmor(ArmorData armor) {
    final updated = <ArmorData>[...?state.character.armor, armor];
    _updateCharacter(state.character.copyWith(armor: updated));
  }

  void setPreparedSpells(List<SpellData>? spells) =>
      _updateCharacter(state.character.copyWith(preparedSpells: spells));

  void addPreparedSpell(SpellData spell) {
    final updated = <SpellData>[...?state.character.preparedSpells, spell];
    _updateCharacter(state.character.copyWith(preparedSpells: updated));
  }

  void setWrittenSpells(List<SpellData>? spells) =>
      _updateCharacter(state.character.copyWith(writtenSpells: spells));

  void addWrittenSpell(SpellData spell) {
    final updated = <SpellData>[...?state.character.writtenSpells, spell];
    _updateCharacter(state.character.copyWith(writtenSpells: updated));
  }

// === Метаданные ===
  void setVersion(int? version) =>
      _updateCharacter(state.character.copyWith(version: version));

  void setCreatedAt(DateTime? date) =>
      _updateCharacter(state.character.copyWith(createdAt: date));

  void setUpdatedAt(DateTime? date) =>
      _updateCharacter(state.character.copyWith(updatedAt: date));

// === Вспомогательный метод ===
  void _updateCharacter(CharacterData updated) {
    state = state.copyWith(character: updated);
  }

  void reset() {
    state = CharacterCreationState.initial();
  }
}
