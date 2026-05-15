import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/language_labels.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/widgets/summary_line.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SummaryIdentitySection extends StatelessWidget {
  const SummaryIdentitySection({
    required this.character,
    required this.classEntry,
    super.key,
  });

  final CharacterData character;
  final CharacterClassEntryData? classEntry;

  @override
  Widget build(BuildContext context) {
    return _SummarySectionCard(
      title: 'Сводка персонажа',
      child: Column(
        children: [
          SummaryLine(label: 'Имя', value: character.name ?? 'Без имени'),
          SummaryLine(
              label: 'Раса', value: character.race?.name ?? 'Не выбрана'),
          SummaryLine(
            label: 'Подраса',
            value: character.subrace?.name ?? 'Не выбрана',
          ),
          SummaryLine(
            label: 'Класс',
            value: classEntry?.classData?.name ?? 'Не выбран',
          ),
          SummaryLine(
            label: 'Подкласс',
            value: classEntry?.subclass?.name ?? 'Не выбран',
          ),
          SummaryLine(
            label: 'Уровень класса',
            value: '${classEntry?.level ?? 0}',
          ),
          SummaryLine(
            label: 'Предыстория',
            value: character.background?.name ?? 'Не выбрана',
          ),
        ],
      ),
    );
  }
}

class SummaryChoicesSection extends StatelessWidget {
  const SummaryChoicesSection({
    required this.raceChoiceSummary,
    required this.classChoiceSummary,
    required this.classSkillSummary,
    required this.classSpellSummary,
    required this.backgroundChoiceSummary,
    required this.backgroundSkillSummary,
    super.key,
  });

  final String raceChoiceSummary;
  final String classChoiceSummary;
  final String classSkillSummary;
  final String classSpellSummary;
  final String backgroundChoiceSummary;
  final String backgroundSkillSummary;

  @override
  Widget build(BuildContext context) {
    return _SummarySectionCard(
      title: 'Выборы',
      child: Column(
        children: [
          SummaryLine(label: 'Выборы расы', value: raceChoiceSummary),
          SummaryLine(label: 'Выборы класса', value: classChoiceSummary),
          SummaryLine(label: 'Навыки класса', value: classSkillSummary),
          SummaryLine(label: 'Заклинания класса', value: classSpellSummary),
          SummaryLine(
            label: 'Выборы предыстории',
            value: backgroundChoiceSummary,
          ),
          SummaryLine(
            label: 'Навыки предыстории',
            value: backgroundSkillSummary,
          ),
        ],
      ),
    );
  }
}

class SummaryAbilitiesSection extends StatelessWidget {
  const SummaryAbilitiesSection({
    required this.baseAbilityScores,
    super.key,
  });

  final Map<String, int> baseAbilityScores;

  @override
  Widget build(BuildContext context) {
    return _SummarySectionCard(
      title: 'Базовые характеристики',
      child: Column(
        children: [
          for (final entry in baseAbilityScores.entries)
            SummaryLine(
              label: _formatName(entry.key),
              value: '${entry.value}',
            ),
        ],
      ),
    );
  }
}

class _SummarySectionCard extends StatelessWidget {
  const _SummarySectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: title, showDivider: false),
        const Gap(12),
        AppSurfaceCard(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ],
    );
  }
}

String formatChoiceSummary(List<CharacterChoiceData> choices) {
  if (choices.isEmpty) {
    return 'Нет';
  }

  final labels = choices
      .map(
        (choice) =>
            (choice.selectedLanguage == null
                ? null
                : languageLabel(choice.selectedLanguage!)) ??
            choice.selectedText ??
            choice.optionKey ??
            choice.selectedToolKey ??
            choice.selectedAbility?.name,
      )
      .whereType<String>()
      .where((value) => value.trim().isNotEmpty)
      .toList();

  if (labels.isEmpty) {
    return '${choices.length} выбрано';
  }

  return labels.join(', ');
}

String formatSpellSelectionSummary(
  List<CharacterSpellSelectionData> selections,
) {
  if (selections.isEmpty) {
    return 'Нет';
  }

  final labels = selections
      .map(
        (selection) =>
            selection.spell?.name ??
            selection.spellKey ??
            selection.spell?.referenceKey,
      )
      .whereType<String>()
      .where((value) => value.trim().isNotEmpty)
      .toList();

  if (labels.isEmpty) {
    return '${selections.length} выбрано';
  }

  return labels.join(', ');
}

String formatSkillSelectionSummary(
  List<CharacterSkillSelectionData> selections,
) {
  if (selections.isEmpty) {
    return 'Нет';
  }

  final labels = selections
      .map((selection) => selection.skill)
      .whereType<Skill>()
      .map(skillLabel)
      .where((value) => value.trim().isNotEmpty)
      .toList();

  if (labels.isEmpty) {
    return '${selections.length} выбрано';
  }

  return labels.join(', ');
}

bool isClassChoice(CharacterChoiceData choice) {
  switch (choice.sourceType) {
    case ChoiceSourceType.classData:
    case ChoiceSourceType.subclass:
    case ChoiceSourceType.classFeature:
    case ChoiceSourceType.subclassFeature:
      return true;
    case ChoiceSourceType.race:
    case ChoiceSourceType.subrace:
    case ChoiceSourceType.background:
    case null:
      return false;
  }
}

Map<String, int> buildSummaryAbilityScores(
  CharacterData character,
  List<CharacterChoiceData> choices,
) {
  final scores = <String, int>{
    ...?character.baseAbilityScores,
  };

  final raceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.race,
    character.race?.id,
  );
  final subraceChoices = _racialChoicesForSource(
    choices,
    ChoiceSourceType.subrace,
    character.subrace?.id,
  );
  final activeBonusMode = _resolveActiveBonusMode(raceChoices);
  final usesFlexibleBonuses =
      activeBonusMode == _BonusMode.flexiblePlusTwoOne ||
          activeBonusMode == _BonusMode.flexibleThreePlusOne;

  if (!usesFlexibleBonuses) {
    _applyFixedRaceBonuses(scores, _abilityBonusesFromRace(character.race));
  }
  _applyRacialChoiceBonuses(
    scores,
    _filterChoicesForActiveBonusMode(raceChoices, activeBonusMode),
  );

  if (!usesFlexibleBonuses) {
    _applyFixedRaceBonuses(
      scores,
      _abilityBonusesFromSubrace(character.subrace),
    );
  }
  _applyRacialChoiceBonuses(
    scores,
    _filterChoicesForActiveBonusMode(subraceChoices, activeBonusMode),
  );

  return scores;
}

enum _BonusMode { racial, flexiblePlusTwoOne, flexibleThreePlusOne }

_BonusMode _resolveActiveBonusMode(List<CharacterChoiceData> raceChoices) {
  for (final choice in raceChoices) {
    if (choice.groupKey != 'race_bonus_mode') continue;

    switch (choice.selectedText) {
      case 'flexiblePlusTwoOne':
        return _BonusMode.flexiblePlusTwoOne;
      case 'flexibleThreePlusOne':
        return _BonusMode.flexibleThreePlusOne;
      case 'racial':
      default:
        return _BonusMode.racial;
    }
  }

  return _BonusMode.racial;
}

List<CharacterChoiceData> _filterChoicesForActiveBonusMode(
  List<CharacterChoiceData> choices,
  _BonusMode activeMode,
) {
  return choices.where((choice) {
    final groupKey = choice.groupKey;
    if (groupKey == null || groupKey == 'race_bonus_mode') {
      return false;
    }

    final isFlexible = groupKey.startsWith('race_flexible_bonus');
    switch (activeMode) {
      case _BonusMode.racial:
        return !isFlexible;
      case _BonusMode.flexiblePlusTwoOne:
        return groupKey == 'race_flexible_bonus_plus2' ||
            groupKey == 'race_flexible_bonus_plus1';
      case _BonusMode.flexibleThreePlusOne:
        return groupKey == 'race_flexible_bonus_three_plus1';
    }
  }).toList();
}

List<CharacterChoiceData> _racialChoicesForSource(
  List<CharacterChoiceData> choices,
  ChoiceSourceType sourceType,
  int? sourceId,
) {
  if (sourceId == null) {
    return const [];
  }

  return choices.where((choice) {
    return choice.sourceType == sourceType && choice.sourceId == sourceId;
  }).toList();
}

void _applyFixedRaceBonuses(Map<String, int> scores, Map<String, int> bonuses) {
  bonuses.forEach((key, value) {
    final score = scores[key];
    if (score == null) return;
    scores[key] = score + value;
  });
}

void _applyRacialChoiceBonuses(
  Map<String, int> scores,
  List<CharacterChoiceData> choices,
) {
  for (final choice in choices) {
    final bonus = choice.selectedCount ?? 0;
    final key = choice.selectedAbility?.name ?? choice.optionKey?.trim();
    if (key == null || key.isEmpty || bonus == 0) {
      continue;
    }

    final abilityKey = _normalizeAbilityKey(key);
    if (abilityKey == null) continue;

    final score = scores[abilityKey];
    if (score == null) continue;
    scores[abilityKey] = score + bonus;
  }
}

Map<String, int> _abilityBonusesFromRace(RaceData? race) {
  return {
    if (race?.strengthBonus != null)
      Ability.strength.name: race!.strengthBonus!,
    if (race?.dexterityBonus != null)
      Ability.dexterity.name: race!.dexterityBonus!,
    if (race?.constitutionBonus != null)
      Ability.constitution.name: race!.constitutionBonus!,
    if (race?.intelligenceBonus != null)
      Ability.intelligence.name: race!.intelligenceBonus!,
    if (race?.wisdomBonus != null) Ability.wisdom.name: race!.wisdomBonus!,
    if (race?.charismaBonus != null)
      Ability.charisma.name: race!.charismaBonus!,
  };
}

Map<String, int> _abilityBonusesFromSubrace(SubraceData? subrace) {
  return {
    if (subrace?.strengthBonus != null)
      Ability.strength.name: subrace!.strengthBonus!,
    if (subrace?.dexterityBonus != null)
      Ability.dexterity.name: subrace!.dexterityBonus!,
    if (subrace?.constitutionBonus != null)
      Ability.constitution.name: subrace!.constitutionBonus!,
    if (subrace?.intelligenceBonus != null)
      Ability.intelligence.name: subrace!.intelligenceBonus!,
    if (subrace?.wisdomBonus != null)
      Ability.wisdom.name: subrace!.wisdomBonus!,
    if (subrace?.charismaBonus != null)
      Ability.charisma.name: subrace!.charismaBonus!,
  };
}

String? _normalizeAbilityKey(String raw) {
  for (final ability in Ability.values) {
    if (ability.name == raw) {
      return ability.name;
    }
  }
  return null;
}

String _formatName(String value) {
  final normalized = value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );
  return normalized.isEmpty
      ? normalized
      : normalized[0].toUpperCase() + normalized.substring(1);
}
