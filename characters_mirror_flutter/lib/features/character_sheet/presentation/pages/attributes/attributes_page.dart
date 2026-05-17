import 'dart:math' as math;

import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/roll_value_button.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/helpers/sheet_autosave.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/widgets/expertise_flag_preview.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/widgets/saving_throw_proficiency_toggle.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AttributesPage extends ConsumerWidget {
  const AttributesPage({
    required this.characterId,
    required this.onClose,
    super.key,
  });

  final int characterId;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterSheetControllerProvider(characterId));

    return SafeArea(
      child: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _AttributesErrorState(
          message: humanReadableError(error),
          onRetry: () => ref
              .read(characterSheetControllerProvider(characterId).notifier)
              .reload(),
        ),
        data: (character) {
          final scoreValueWidth = _measureTextWidth(
            context,
            [
              for (final ability in Ability.values)
                '${_attributeScore(character, ability)}',
            ],
            Theme.of(context).textTheme.titleSmall,
          );
          final modifierButtonWidth = _measureCompactButtonWidth(
            context,
            [
              for (final ability in Ability.values)
                signedBonus(_abilityModifierFor(character, ability)),
            ],
          );
          final skillLevels = skillProficiencyLevelMap(
            character.manualSkillProficiencies ??
                character.derived?.skillProficiencyLevels,
          );
          final skillBonuses = character.derived?.skillBonuses ?? const {};
          final proficiencyButtonWidth = _measureCompactButtonWidth(
            context,
            [
              for (final ability in Ability.values)
                signedBonus(
                  character.derived?.savingThrowBonuses?[ability.name] ??
                      _abilityModifierFor(character, ability),
                ),
              for (final skill in Skill.values)
                signedBonus(skillBonuses[skill.name] ?? 0),
            ],
          );

          return Padding(
            padding: const EdgeInsets.all(12),
            child: PageSizeLimiter(
              child: ListView(
                children: [
                  _AttributesHeader(onClose: onClose),
                  const SizedBox(height: 12),
                  for (final ability in Ability.values) ...[
                    _AttributeCard(
                      character: character,
                      ability: ability,
                      skillLevels: skillLevels,
                      skillBonuses: skillBonuses,
                      scoreValueWidth: scoreValueWidth,
                      skillButtonWidth: proficiencyButtonWidth,
                      modifierButtonWidth: modifierButtonWidth,
                      savingThrowButtonWidth: proficiencyButtonWidth,
                      onSaveProficiency: (savingThrowProficient) {
                        runCharacterSheetSave(
                          context,
                          ref
                              .read(
                                characterSheetControllerProvider(characterId)
                                    .notifier,
                              )
                              .saveSavingThrowProficiency(
                                ability,
                                savingThrowProficient,
                              ),
                        );
                        return Future.value();
                      },
                      onSaveSkillProficiency: (skill, level) {
                        runCharacterSheetSave(
                          context,
                          ref
                              .read(
                                characterSheetControllerProvider(characterId)
                                    .notifier,
                              )
                              .saveSkillProficiency(skill, level),
                        );
                        return Future.value();
                      },
                    ),
                    if (ability != Ability.values.last)
                      const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AttributesHeader extends StatelessWidget {
  const _AttributesHeader({
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            'Характеристики',
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.headlineSmall,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}

class _AttributeCard extends StatelessWidget {
  const _AttributeCard({
    required this.character,
    required this.ability,
    required this.skillLevels,
    required this.skillBonuses,
    required this.scoreValueWidth,
    required this.skillButtonWidth,
    required this.modifierButtonWidth,
    required this.savingThrowButtonWidth,
    required this.onSaveProficiency,
    required this.onSaveSkillProficiency,
  });

  final CharacterData character;
  final Ability ability;
  final Map<Skill, CharacterSkillProficiencyLevel> skillLevels;
  final Map<String, int> skillBonuses;
  final double scoreValueWidth;
  final double skillButtonWidth;
  final double modifierButtonWidth;
  final double savingThrowButtonWidth;
  final Future<void> Function(bool savingThrowProficient) onSaveProficiency;
  final Future<void> Function(
    Skill skill,
    CharacterSkillProficiencyLevel level,
  ) onSaveSkillProficiency;

  @override
  Widget build(BuildContext context) {
    final derivedScore = _attributeScore(character, ability);
    final modifier = _abilityModifierFor(character, ability);
    final skills = [
      for (final skill in Skill.values)
        if (abilityForSkill(skill) == ability) skill,
    ];
    final savingThrowProficiencies = savingThrowProficiencySet(
      character.manualSavingThrowProficiencies ??
          character.derived?.savingThrowProficiencies,
    );
    final savingThrowProficient = savingThrowProficiencies.contains(ability);
    final savingThrowBonus =
        character.derived?.savingThrowBonuses?[ability.name] ?? modifier;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = theme.scaffoldBackgroundColor;

    return Card(
      key: ValueKey('attribute-card-${ability.name}'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 520;
          final abilityLabel = compact
              ? shortAbilityLabel(ability).toUpperCase()
              : attributesAbilityLabel(ability).toUpperCase();
          final savingThrowLabel = compact ? 'Спас.' : 'Спасбросок';
          final savingThrowLabelWidth = _measureTextWidth(
            context,
            [savingThrowLabel],
            theme.textTheme.labelSmall,
          );
          final interGroupSpacing = compact ? 8.0 : 12.0;
          final centerGroupSpacing = compact ? 8.0 : 12.0;
          final endGroupSpacing = compact ? 6.0 : 8.0;
          final flagColumnLeft = savingThrowLabelWidth + endGroupSpacing;
          final rightSectionWidth = math.max(
            flagColumnLeft +
                SavingThrowProficiencyToggle.size +
                endGroupSpacing +
                savingThrowButtonWidth,
            flagColumnLeft +
                SkillProficiencyToggle.size +
                endGroupSpacing +
                skillButtonWidth,
          );

          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      flex: compact ? 1 : 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          abilityLabel,
                          maxLines: 1,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: interGroupSpacing),
                    Expanded(
                      flex: compact ? 2 : 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: scoreValueWidth,
                              child: Text(
                                '$derivedScore',
                                key:
                                    ValueKey('attribute-score-${ability.name}'),
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                            SizedBox(width: centerGroupSpacing),
                            RollValueButton(
                              key: ValueKey(
                                'attribute-modifier-${ability.name}',
                              ),
                              label: signedBonus(modifier),
                              mode: RollValueMode.modifier,
                              width: modifierButtonWidth,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: compact ? 3 : 3,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: rightSectionWidth,
                          height: SavingThrowProficiencyToggle.size,
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            clipBehavior: Clip.none,
                            children: [
                              SizedBox(
                                width: savingThrowLabelWidth,
                                child: Text(
                                  savingThrowLabel,
                                  maxLines: 1,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: flagColumnLeft,
                                child: SavingThrowProficiencyToggle(
                                  key: ValueKey(
                                    'attribute-save-toggle-${ability.name}',
                                  ),
                                  value: savingThrowProficient,
                                  onChanged: (value) {
                                    onSaveProficiency(value);
                                  },
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: RollValueButton(
                                  key: ValueKey(
                                    'attribute-saving-${ability.name}',
                                  ),
                                  label: signedBonus(savingThrowBonus),
                                  mode: RollValueMode.modifier,
                                  width: savingThrowButtonWidth,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (skills.isNotEmpty) ...[
                _SkillDivider(color: backgroundColor),
                for (var index = 0; index < skills.length; index++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: _SkillRow(
                      skill: skills[index],
                      bonus: skillBonuses[skills[index].name] ?? 0,
                      level: skillLevels[skills[index]] ??
                          CharacterSkillProficiencyLevel.none,
                      skillButtonWidth: skillButtonWidth,
                      rightSectionWidth: rightSectionWidth,
                      flagColumnLeft: flagColumnLeft,
                      onChanged: (nextLevel) {
                        onSaveSkillProficiency(skills[index], nextLevel);
                      },
                    ),
                  ),
                  if (index != skills.length - 1)
                    _SkillDivider(color: backgroundColor),
                ],
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  const _SkillRow({
    required this.skill,
    required this.bonus,
    required this.level,
    required this.skillButtonWidth,
    required this.rightSectionWidth,
    required this.flagColumnLeft,
    required this.onChanged,
  });

  final Skill skill;
  final int bonus;
  final CharacterSkillProficiencyLevel level;
  final double skillButtonWidth;
  final double rightSectionWidth;
  final double flagColumnLeft;
  final ValueChanged<CharacterSkillProficiencyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final toggleLeft = flagColumnLeft -
        ((SkillProficiencyToggle.size - SavingThrowProficiencyToggle.size) / 2);
    final trailingWidth =
        rightSectionWidth - toggleLeft - SkillProficiencyToggle.size;

    return Row(
      key: ValueKey('skill-row-${skill.name}'),
      children: [
        Expanded(
          child: Text(
            skillLabel(skill),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: rightSectionWidth,
          child: Row(
            children: [
              SizedBox(width: toggleLeft),
              SkillProficiencyToggle(
                key: ValueKey('skill-toggle-${skill.name}'),
                level: level,
                onTap: () {
                  onChanged(nextSkillProficiencyLevel(level));
                },
              ),
              SizedBox(
                width: trailingWidth,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RollValueButton(
                    key: ValueKey('skill-bonus-${skill.name}'),
                    label: signedBonus(bonus),
                    mode: RollValueMode.modifier,
                    width: skillButtonWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SkillDivider extends StatelessWidget {
  const _SkillDivider({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 4,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}

class _AttributesErrorState extends StatelessWidget {
  const _AttributesErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}

int _attributeScore(CharacterData character, Ability ability) {
  return character.derived?.abilityScores?[ability.name] ??
      character.baseAbilityScores?[ability.name] ??
      10;
}

int _abilityModifierFor(CharacterData character, Ability ability) {
  return character.derived?.abilityModifiers?[ability.name] ??
      _abilityModifier(_attributeScore(character, ability));
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();

double _measureCompactButtonWidth(
  BuildContext context,
  List<String> labels,
) {
  final textStyle = Theme.of(context).textTheme.labelLarge;
  final widest = _measureTextWidth(context, labels, textStyle);

  return widest + 28;
}

double _measureTextWidth(
  BuildContext context,
  List<String> labels,
  TextStyle? textStyle,
) {
  final textScaler = MediaQuery.textScalerOf(context);
  final textDirection = Directionality.of(context);
  var widest = 0.0;

  for (final label in labels) {
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: textStyle,
      ),
      textDirection: textDirection,
      textScaler: textScaler,
      maxLines: 1,
    )..layout();

    if (painter.width > widest) {
      widest = painter.width;
    }
  }

  return widest;
}
