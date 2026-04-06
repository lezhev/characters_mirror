import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/race_step/state/race_state.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RaceChoiceSetCard extends ConsumerWidget {
  const RaceChoiceSetCard({
    required this.choiceSet,
    required this.selectedOptions,
    super.key,
  });

  final RaceChoiceSetData choiceSet;
  final List<RaceChoiceOptionData> selectedOptions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final options = [...?choiceSet.choiceOptions]..sort(compareChoiceOptions);
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    final isAbilityChoice = choiceSet.kind == RaceChoiceKind.abilityBonusChoice;
    final selectedKeys = {
      for (final option in selectedOptions)
        if (option.optionKey?.trim().isNotEmpty == true) option.optionKey!.trim(),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            raceChoiceKindLabel(choiceSet.kind),
            style: textTheme.titleSmall,
          ),
          if ((choiceSet.description ?? '').trim().isNotEmpty) ...[
            const Gap(6),
            Text(
              choiceSet.description!,
              style: textTheme.bodyMedium,
            ),
          ],
          const Gap(8),
          Text(
            isAbilityChoice
                ? 'Этот выбор применяется на шаге характеристик.'
                : 'Выберите ${choiceSet.pickCount ?? 1}.',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Gap(8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((option) {
              final optionKey = option.optionKey?.trim();
              final isSelected =
                  optionKey != null && selectedKeys.contains(optionKey);

              return InkWell(
                onTap: isAbilityChoice
                    ? null
                    : () => ref
                        .read(raceStateProvider.notifier)
                        .toggleChoiceOption(choiceSet, option),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline,
                    ),
                    color: isSelected
                        ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                        : Colors.transparent,
                  ),
                  child: Text(
                    choiceOptionLabel(option),
                    style: textTheme.bodySmall,
                  ),
                ),
              );
            }).toList(),
          ),
          if (selectedOptions.any(
            (option) => (option.description ?? '').trim().isNotEmpty,
          )) ...[
            const Gap(10),
            ...selectedOptions
                .where((option) => (option.description ?? '').trim().isNotEmpty)
                .map(
                  (option) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      option.description!,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

int compareChoiceOptions(RaceChoiceOptionData a, RaceChoiceOptionData b) {
  final sortCompare = (a.sortOrder ?? 0).compareTo(b.sortOrder ?? 0);
  if (sortCompare != 0) {
    return sortCompare;
  }
  return choiceOptionLabel(a).compareTo(choiceOptionLabel(b));
}

String raceChoiceKindLabel(RaceChoiceKind? kind) {
  switch (kind) {
    case RaceChoiceKind.abilityBonusChoice:
      return 'Бонусы к характеристикам';
    case RaceChoiceKind.skillProficiencyChoice:
      return 'Навыки';
    case RaceChoiceKind.languageChoice:
      return 'Языки';
    case RaceChoiceKind.toolProficiencyChoice:
      return 'Инструменты';
    case RaceChoiceKind.cantripChoice:
      return 'Заговоры';
    case RaceChoiceKind.dragonbornAncestryChoice:
      return 'Драконье наследие';
    default:
      return 'Выбор';
  }
}

String? choiceSetGroupKey(int? choiceSetId) {
  if (choiceSetId == null) {
    return null;
  }
  return 'race_choice_$choiceSetId';
}

String choiceOptionLabel(RaceChoiceOptionData option) {
  final explicitName = option.name?.trim();
  if (explicitName != null && explicitName.isNotEmpty) {
    return explicitName;
  }

  if (option.spell?.name?.trim().isNotEmpty == true) {
    return option.spell!.name!.trim();
  }
  if (option.skill != null) {
    return formatRaceName(enumToken(option.skill));
  }
  if (option.language != null) {
    return formatRaceName(enumToken(option.language));
  }
  if (option.ability != null && option.bonusValue != null) {
    return '${formatRaceName(enumToken(option.ability))} +${option.bonusValue}';
  }
  if (option.ability != null) {
    return formatRaceName(enumToken(option.ability));
  }
  if (option.damageType != null) {
    return formatRaceName(enumToken(option.damageType));
  }
  if ((option.toolKey ?? '').trim().isNotEmpty) {
    return option.toolKey!.trim();
  }
  if ((option.optionKey ?? '').trim().isNotEmpty) {
    return option.optionKey!.trim();
  }
  return 'Выбор';
}

String spellGrantLabel(RaceFeatureSpellGrantData grant) {
  final parts = <String>[
    grant.spell?.name ?? 'Заклинание',
    if (grant.castAtSpellLevel != null) 'ур. ${grant.castAtSpellLevel}',
    if (grant.freeCastsFormula?.trim().isNotEmpty == true)
      'бесплатно: ${grant.freeCastsFormula}',
    if (grant.freeCastsPerRest != null)
      'за ${formatRaceName(enumToken(grant.freeCastsPerRest))}',
    if (grant.canAlsoCastWithSpellSlots == true) 'можно через ячейки',
  ];
  return parts.join(' • ');
}

String enumToken(Object? value) {
  if (value == null) {
    return 'unknown';
  }
  final raw = value.toString();
  if (raw.trim().isEmpty) {
    return 'unknown';
  }
  final parts = raw.split('.');
  return parts.isEmpty ? raw : parts.last;
}

String formatRaceName(String value) {
  final normalized = value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );
  if (normalized.isEmpty) {
    return normalized;
  }
  return normalized[0].toUpperCase() + normalized.substring(1);
}
