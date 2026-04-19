import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_proficiency_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/mechanics/helpers/mechanics_labels.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/mechanics/widgets/proficiency_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MechanicsPage extends ConsumerWidget {
  const MechanicsPage({
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
        error: (error, _) => _MechanicsErrorState(
          message: humanReadableError(error),
          onRetry: () => ref
              .read(characterSheetControllerProvider(characterId).notifier)
              .reload(),
        ),
        data: (character) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: PageSizeLimiter(
              child: ListView(
                children: [
                  _MechanicsHeader(onClose: onClose),
                  const SizedBox(height: 12),
                  for (final ability in Ability.values) ...[
                    _AbilityGroup(
                      character: character,
                      ability: ability,
                      onSaveDetails: ({
                        required score,
                        required customBonus,
                        required savingThrowProficient,
                      }) {
                        return ref
                            .read(
                              characterSheetControllerProvider(characterId)
                                  .notifier,
                            )
                            .saveAbilityDetails(
                              ability: ability,
                              score: _normalizedScore(score),
                              customBonus: _normalizedBonus(customBonus),
                              savingThrowProficient: savingThrowProficient,
                            );
                      },
                      onSaveProficiency: (skill, level) => ref
                          .read(
                            characterSheetControllerProvider(characterId)
                                .notifier,
                          )
                          .saveSkillProficiency(skill, level),
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

class _MechanicsHeader extends StatelessWidget {
  const _MechanicsHeader({
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

class _AbilityGroup extends StatelessWidget {
  const _AbilityGroup({
    required this.character,
    required this.ability,
    required this.onSaveDetails,
    required this.onSaveProficiency,
  });

  final CharacterData character;
  final Ability ability;
  final Future<void> Function({
    required int? score,
    required int? customBonus,
    required bool savingThrowProficient,
  }) onSaveDetails;
  final Future<void> Function(
    Skill skill,
    CharacterSkillProficiencyLevel level,
  ) onSaveProficiency;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final baseScore = _baseScore(character, ability);
    final customBonus = character.customAbilityBonuses?[ability.name] ?? 0;
    final derivedScore = _derivedScore(character, ability);
    final modifier = _abilityModifierFor(character, ability);
    final savingThrowProficiencies = savingThrowProficiencySet(
      character.manualSavingThrowProficiencies ??
          character.derived?.savingThrowProficiencies,
    );
    final savingThrowProficient = savingThrowProficiencies.contains(ability);
    final savingThrowBonus =
        character.derived?.savingThrowBonuses?[ability.name] ?? modifier;
    final skills = [
      for (final skill in Skill.values)
        if (abilityForSkill(skill) == ability) skill,
    ];
    final skillLevels = skillProficiencyLevelMap(
      character.manualSkillProficiencies ??
          character.derived?.skillProficiencyLevels,
    );
    final skillBonuses =
        character.derived?.skillBonuses ?? const <String, int>{};

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _showAbilityDetailsDialog(
                      context: context,
                      ability: ability,
                      baseScore: baseScore,
                      customBonus: customBonus,
                      derivedScore: derivedScore,
                      modifier: modifier,
                      savingThrowBonus: savingThrowBonus,
                      savingThrowProficient: savingThrowProficient,
                      onSave: onSaveDetails,
                    ),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      foregroundColor: colorScheme.onSurface,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      mechanicsAbilityLabel(ability),
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  signedBonus(modifier),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(width: 12),
                ProficiencyToggle(
                  level: savingThrowProficient
                      ? CharacterSkillProficiencyLevel.proficient
                      : CharacterSkillProficiencyLevel.none,
                  allowExpertise: false,
                  onChanged: (level) => onSaveDetails(
                    score: baseScore,
                    customBonus: customBonus,
                    savingThrowProficient:
                        level != CharacterSkillProficiencyLevel.none,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 44,
                  child: Text(
                    signedBonus(savingThrowBonus),
                    textAlign: TextAlign.right,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            if (skills.isNotEmpty) ...[
              const SizedBox(height: 8),
              for (final skill in skills) ...[
                _SkillRow(
                  skill: skill,
                  level:
                      skillLevels[skill] ?? CharacterSkillProficiencyLevel.none,
                  bonus: skillBonuses[skill.name] ?? 0,
                  onChanged: (level) => onSaveProficiency(skill, level),
                ),
                if (skill != skills.last) const Divider(height: 1),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _SkillRow extends StatelessWidget {
  const _SkillRow({
    required this.skill,
    required this.level,
    required this.bonus,
    required this.onChanged,
  });

  final Skill skill;
  final CharacterSkillProficiencyLevel level;
  final int bonus;
  final ValueChanged<CharacterSkillProficiencyLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          ProficiencyToggle(
            level: level,
            onChanged: onChanged,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              skillLabel(skill),
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 44,
            child: Text(
              signedBonus(bonus),
              textAlign: TextAlign.right,
              style: theme.textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class _AbilityDetailsDialog extends StatefulWidget {
  const _AbilityDetailsDialog({
    required this.ability,
    required this.baseScore,
    required this.customBonus,
    required this.derivedScore,
    required this.modifier,
    required this.savingThrowBonus,
    required this.savingThrowProficient,
    required this.onSave,
  });

  final Ability ability;
  final int baseScore;
  final int customBonus;
  final int derivedScore;
  final int modifier;
  final int savingThrowBonus;
  final bool savingThrowProficient;
  final Future<void> Function({
    required int? score,
    required int? customBonus,
    required bool savingThrowProficient,
  }) onSave;

  @override
  State<_AbilityDetailsDialog> createState() => _AbilityDetailsDialogState();
}

class _AbilityDetailsDialogState extends State<_AbilityDetailsDialog> {
  late final TextEditingController _scoreController;
  late final TextEditingController _bonusController;
  late bool _savingThrowProficient;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _scoreController = TextEditingController(text: '${widget.baseScore}');
    _bonusController = TextEditingController(
      text: widget.customBonus == 0 ? '' : '${widget.customBonus}',
    );
    _savingThrowProficient = widget.savingThrowProficient;
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _bonusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text(mechanicsAbilityLabel(widget.ability)),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _scoreController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                labelText: 'Значение',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bonusController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[-0-9]')),
                LengthLimitingTextInputFormatter(3),
              ],
              decoration: const InputDecoration(
                labelText: 'Пользовательский бонус',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ProficiencyToggle(
                  level: _savingThrowProficient
                      ? CharacterSkillProficiencyLevel.proficient
                      : CharacterSkillProficiencyLevel.none,
                  allowExpertise: false,
                  onChanged: (level) {
                    setState(() {
                      _savingThrowProficient =
                          level != CharacterSkillProficiencyLevel.none;
                    });
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Спасбросок',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Text(
                  signedBonus(widget.savingThrowBonus),
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Модификатор',
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Text(
                  '${widget.derivedScore} (${signedBonus(widget.modifier)})',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          onPressed: _isSaving ? null : _save,
          child: _isSaving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Сохранить'),
        ),
      ],
    );
  }

  Future<void> _save() async {
    setState(() {
      _isSaving = true;
    });
    try {
      await widget.onSave(
        score: int.tryParse(_scoreController.text.trim()),
        customBonus: int.tryParse(_bonusController.text.trim()),
        savingThrowProficient: _savingThrowProficient,
      );
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
      rethrow;
    }
  }
}

class _MechanicsErrorState extends StatelessWidget {
  const _MechanicsErrorState({
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

Future<void> _showAbilityDetailsDialog({
  required BuildContext context,
  required Ability ability,
  required int baseScore,
  required int customBonus,
  required int derivedScore,
  required int modifier,
  required int savingThrowBonus,
  required bool savingThrowProficient,
  required Future<void> Function({
    required int? score,
    required int? customBonus,
    required bool savingThrowProficient,
  }) onSave,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => _AbilityDetailsDialog(
      ability: ability,
      baseScore: baseScore,
      customBonus: customBonus,
      derivedScore: derivedScore,
      modifier: modifier,
      savingThrowBonus: savingThrowBonus,
      savingThrowProficient: savingThrowProficient,
      onSave: onSave,
    ),
  );
}

int _baseScore(CharacterData character, Ability ability) {
  return character.baseAbilityScores?[ability.name] ?? 10;
}

int _derivedScore(CharacterData character, Ability ability) {
  return character.derived?.abilityScores?[ability.name] ??
      _baseScore(character, ability);
}

int _abilityModifierFor(CharacterData character, Ability ability) {
  return character.derived?.abilityModifiers?[ability.name] ??
      _abilityModifier(_derivedScore(character, ability));
}

int? _normalizedScore(int? score) {
  if (score == null) {
    return null;
  }
  return score.clamp(1, 30);
}

int? _normalizedBonus(int? bonus) {
  if (bonus == null || bonus == 0) {
    return null;
  }
  return bonus.clamp(-30, 30);
}

int _abilityModifier(int score) => ((score - 10) / 2).floor();
