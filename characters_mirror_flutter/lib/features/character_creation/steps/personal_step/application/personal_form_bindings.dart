import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:flutter/material.dart';

class PersonalFormBindings {
  PersonalFormBindings({
    required CharacterCreation notifier,
    required CharacterData character,
  }) : _notifier = notifier {
    nameController = TextEditingController(text: character.name ?? '');
    ageController = TextEditingController(text: character.age ?? '');
    heightController = TextEditingController(text: character.height ?? '');
    weightController = TextEditingController(text: character.weight ?? '');
    eyesController = TextEditingController(text: character.eyes ?? '');
    skinController = TextEditingController(text: character.skin ?? '');
    hairController = TextEditingController(text: character.hair ?? '');
    appearanceController =
        TextEditingController(text: character.appearance ?? '');
    backstoryController = TextEditingController(text: character.backstory ?? '');
    goalsController = TextEditingController(text: character.goals ?? '');
    alliesOrganizationsController =
        TextEditingController(text: character.alliesOrganizations ?? '');
    personalityTraitsController =
        TextEditingController(text: character.personalityTraits ?? '');
    idealsController = TextEditingController(text: character.ideals ?? '');
    bondsController = TextEditingController(text: character.bonds ?? '');
    flawsController = TextEditingController(text: character.flaws ?? '');
    notesController = TextEditingController(text: character.notes ?? '');

    nameFocusNode = FocusNode();
    ageFocusNode = FocusNode();
    heightFocusNode = FocusNode();
    weightFocusNode = FocusNode();
    eyesFocusNode = FocusNode();
    skinFocusNode = FocusNode();
    hairFocusNode = FocusNode();
    alignmentFocusNode = FocusNode();
    appearanceFocusNode = FocusNode();
    backstoryFocusNode = FocusNode();
    goalsFocusNode = FocusNode();
    alliesOrganizationsFocusNode = FocusNode();
    personalityTraitsFocusNode = FocusNode();
    idealsFocusNode = FocusNode();
    bondsFocusNode = FocusNode();
    flawsFocusNode = FocusNode();
    notesFocusNode = FocusNode();

    _attachAutosave(nameFocusNode, saveName);
    _attachAutosave(ageFocusNode, saveAge);
    _attachAutosave(heightFocusNode, saveHeight);
    _attachAutosave(weightFocusNode, saveWeight);
    _attachAutosave(eyesFocusNode, saveEyes);
    _attachAutosave(skinFocusNode, saveSkin);
    _attachAutosave(hairFocusNode, saveHair);
    _attachAutosave(appearanceFocusNode, saveAppearance);
    _attachAutosave(backstoryFocusNode, saveBackstory);
    _attachAutosave(goalsFocusNode, saveGoals);
    _attachAutosave(alliesOrganizationsFocusNode, saveAlliesOrganizations);
    _attachAutosave(personalityTraitsFocusNode, savePersonalityTraits);
    _attachAutosave(idealsFocusNode, saveIdeals);
    _attachAutosave(bondsFocusNode, saveBonds);
    _attachAutosave(flawsFocusNode, saveFlaws);
    _attachAutosave(notesFocusNode, saveNotes);
  }

  final CharacterCreation _notifier;

  late final TextEditingController nameController;
  late final TextEditingController ageController;
  late final TextEditingController heightController;
  late final TextEditingController weightController;
  late final TextEditingController eyesController;
  late final TextEditingController skinController;
  late final TextEditingController hairController;
  late final TextEditingController appearanceController;
  late final TextEditingController backstoryController;
  late final TextEditingController goalsController;
  late final TextEditingController alliesOrganizationsController;
  late final TextEditingController personalityTraitsController;
  late final TextEditingController idealsController;
  late final TextEditingController bondsController;
  late final TextEditingController flawsController;
  late final TextEditingController notesController;

  late final FocusNode nameFocusNode;
  late final FocusNode ageFocusNode;
  late final FocusNode heightFocusNode;
  late final FocusNode weightFocusNode;
  late final FocusNode eyesFocusNode;
  late final FocusNode skinFocusNode;
  late final FocusNode hairFocusNode;
  late final FocusNode alignmentFocusNode;
  late final FocusNode appearanceFocusNode;
  late final FocusNode backstoryFocusNode;
  late final FocusNode goalsFocusNode;
  late final FocusNode alliesOrganizationsFocusNode;
  late final FocusNode personalityTraitsFocusNode;
  late final FocusNode idealsFocusNode;
  late final FocusNode bondsFocusNode;
  late final FocusNode flawsFocusNode;
  late final FocusNode notesFocusNode;

  void saveName() => _notifier.setName(nameController.text);
  void saveAge() => _notifier.setAge(ageController.text);
  void saveHeight() => _notifier.setHeight(heightController.text);
  void saveWeight() => _notifier.setWeight(weightController.text);
  void saveEyes() => _notifier.setEyes(eyesController.text);
  void saveSkin() => _notifier.setSkin(skinController.text);
  void saveHair() => _notifier.setHair(hairController.text);
  void saveAppearance() => _notifier.setAppearance(appearanceController.text);
  void saveBackstory() => _notifier.setBackstory(backstoryController.text);
  void saveGoals() => _notifier.setGoals(goalsController.text);

  void saveAlliesOrganizations() =>
      _notifier.setAlliesOrganizations(alliesOrganizationsController.text);

  void savePersonalityTraits() =>
      _notifier.setPersonalityTraits(personalityTraitsController.text);

  void saveIdeals() => _notifier.setIdeals(idealsController.text);
  void saveBonds() => _notifier.setBonds(bondsController.text);
  void saveFlaws() => _notifier.setFlaws(flawsController.text);
  void saveNotes() => _notifier.setNotes(notesController.text);

  void flush() {
    saveName();
    saveAge();
    saveHeight();
    saveWeight();
    saveEyes();
    saveSkin();
    saveHair();
    saveAppearance();
    saveBackstory();
    saveGoals();
    saveAlliesOrganizations();
    savePersonalityTraits();
    saveIdeals();
    saveBonds();
    saveFlaws();
    saveNotes();
  }

  void submitShortField({
    required BuildContext context,
    required VoidCallback save,
    FocusNode? nextFocus,
  }) {
    save();
    if (nextFocus != null) {
      nextFocus.requestFocus();
    } else {
      FocusScope.of(context).unfocus();
    }
  }

  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    eyesController.dispose();
    skinController.dispose();
    hairController.dispose();
    appearanceController.dispose();
    backstoryController.dispose();
    goalsController.dispose();
    alliesOrganizationsController.dispose();
    personalityTraitsController.dispose();
    idealsController.dispose();
    bondsController.dispose();
    flawsController.dispose();
    notesController.dispose();

    nameFocusNode.dispose();
    ageFocusNode.dispose();
    heightFocusNode.dispose();
    weightFocusNode.dispose();
    eyesFocusNode.dispose();
    skinFocusNode.dispose();
    hairFocusNode.dispose();
    alignmentFocusNode.dispose();
    appearanceFocusNode.dispose();
    backstoryFocusNode.dispose();
    goalsFocusNode.dispose();
    alliesOrganizationsFocusNode.dispose();
    personalityTraitsFocusNode.dispose();
    idealsFocusNode.dispose();
    bondsFocusNode.dispose();
    flawsFocusNode.dispose();
    notesFocusNode.dispose();
  }

  String alignmentLabel(CharacterAlignment value) {
    switch (value) {
      case CharacterAlignment.lawfulGood:
        return 'Законопослушный добрый';
      case CharacterAlignment.neutralGood:
        return 'Нейтральный добрый';
      case CharacterAlignment.chaoticGood:
        return 'Хаотичный добрый';
      case CharacterAlignment.lawfulNeutral:
        return 'Законопослушный нейтральный';
      case CharacterAlignment.trueNeutral:
        return 'Истинно нейтральный';
      case CharacterAlignment.chaoticNeutral:
        return 'Хаотичный нейтральный';
      case CharacterAlignment.lawfulEvil:
        return 'Законопослушный злой';
      case CharacterAlignment.neutralEvil:
        return 'Нейтральный злой';
      case CharacterAlignment.chaoticEvil:
        return 'Хаотичный злой';
      case CharacterAlignment.unaligned:
        return 'Без мировоззрения';
    }
  }

  void _attachAutosave(FocusNode node, VoidCallback save) {
    node.addListener(() {
      if (!node.hasFocus) {
        save();
      }
    });
  }
}
