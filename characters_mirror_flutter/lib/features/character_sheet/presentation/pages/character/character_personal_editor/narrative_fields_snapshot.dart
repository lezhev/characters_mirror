part of '../character_personal_editor.dart';

class _NarrativeTextField extends StatelessWidget {
  const _NarrativeTextField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.isLast = false,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: AppAutosizeTextField(
        label: label,
        controller: controller,
        focusNode: focusNode,
        minLines: 3,
        maxRunes: AppInputLimits.longText,
        onChanged: onChanged,
      ),
    );
  }
}

class _PersonalInfoSnapshot {
  const _PersonalInfoSnapshot({
    required this.name,
    required this.age,
    required this.height,
    required this.weight,
    required this.eyes,
    required this.skin,
    required this.hair,
    required this.alignmentValue,
    required this.appearance,
    required this.backstory,
    required this.goals,
    required this.alliesOrganizations,
    required this.personalityTraits,
    required this.ideals,
    required this.bonds,
    required this.flaws,
  });

  factory _PersonalInfoSnapshot.fromCharacter(CharacterData character) {
    return _PersonalInfoSnapshot(
      name: character.name ?? '',
      age: character.age ?? '',
      height: character.height ?? '',
      weight: character.weight ?? '',
      eyes: character.eyes ?? '',
      skin: character.skin ?? '',
      hair: character.hair ?? '',
      alignmentValue: character.alignmentValue,
      appearance: character.appearance ?? '',
      backstory: character.backstory ?? '',
      goals: character.goals ?? '',
      alliesOrganizations: character.alliesOrganizations ?? '',
      personalityTraits: character.personalityTraits ?? '',
      ideals: character.ideals ?? '',
      bonds: character.bonds ?? '',
      flaws: character.flaws ?? '',
    );
  }

  final String name;
  final String age;
  final String height;
  final String weight;
  final String eyes;
  final String skin;
  final String hair;
  final CharacterAlignment? alignmentValue;
  final String appearance;
  final String backstory;
  final String goals;
  final String alliesOrganizations;
  final String personalityTraits;
  final String ideals;
  final String bonds;
  final String flaws;

  @override
  bool operator ==(Object other) {
    return other is _PersonalInfoSnapshot &&
        other.name == name &&
        other.age == age &&
        other.height == height &&
        other.weight == weight &&
        other.eyes == eyes &&
        other.skin == skin &&
        other.hair == hair &&
        other.alignmentValue == alignmentValue &&
        other.appearance == appearance &&
        other.backstory == backstory &&
        other.goals == goals &&
        other.alliesOrganizations == alliesOrganizations &&
        other.personalityTraits == personalityTraits &&
        other.ideals == ideals &&
        other.bonds == bonds &&
        other.flaws == flaws;
  }

  @override
  int get hashCode => Object.hash(
        name,
        age,
        height,
        weight,
        eyes,
        skin,
        hair,
        alignmentValue,
        appearance,
        backstory,
        goals,
        alliesOrganizations,
        personalityTraits,
        ideals,
        bonds,
        flaws,
      );
}
