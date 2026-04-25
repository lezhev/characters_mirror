import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:flutter/material.dart';

class ProficiencyToggle extends StatelessWidget {
  const ProficiencyToggle({
    required this.level,
    required this.onChanged,
    this.allowExpertise = true,
    super.key,
  });

  final CharacterSkillProficiencyLevel level;
  final bool allowExpertise;
  final ValueChanged<CharacterSkillProficiencyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final active = level != CharacterSkillProficiencyLevel.none;
    final expertise = level == CharacterSkillProficiencyLevel.expertise;
    final backgroundColor = expertise
        ? colorScheme.secondaryContainer
        : active
            ? colorScheme.primaryContainer
            : Colors.transparent;
    final borderColor = expertise
        ? colorScheme.secondary
        : active
            ? colorScheme.primary
            : colorScheme.outlineVariant;

    return Semantics(
      button: true,
      label: _semanticsLabel(level),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () => onChanged(_nextLevel()),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: borderColor,
              width: expertise ? 2 : 1.5,
            ),
          ),
          child: _ToggleMark(level: level),
        ),
      ),
    );
  }

  CharacterSkillProficiencyLevel _nextLevel() {
    switch (level) {
      case CharacterSkillProficiencyLevel.none:
        return CharacterSkillProficiencyLevel.proficient;
      case CharacterSkillProficiencyLevel.proficient:
        return allowExpertise
            ? CharacterSkillProficiencyLevel.expertise
            : CharacterSkillProficiencyLevel.none;
      case CharacterSkillProficiencyLevel.expertise:
        return CharacterSkillProficiencyLevel.none;
    }
  }
}

class _ToggleMark extends StatelessWidget {
  const _ToggleMark({
    required this.level,
  });

  final CharacterSkillProficiencyLevel level;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    switch (level) {
      case CharacterSkillProficiencyLevel.none:
        return const SizedBox.shrink();
      case CharacterSkillProficiencyLevel.proficient:
        return Icon(
          Icons.check,
          size: 18,
          color: colorScheme.onPrimaryContainer,
        );
      case CharacterSkillProficiencyLevel.expertise:
        return Text(
          'x2',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w700,
              ),
        );
    }
  }
}

String _semanticsLabel(CharacterSkillProficiencyLevel level) {
  switch (level) {
    case CharacterSkillProficiencyLevel.none:
      return 'Нет владения';
    case CharacterSkillProficiencyLevel.proficient:
      return 'Владение';
    case CharacterSkillProficiencyLevel.expertise:
      return 'Экспертиза';
  }
}
