import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_section_header.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/app_surface_card.dart';
import 'package:characters_mirror_flutter/features/character_creation/steps/summary_step/widgets/summary_line.dart';
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
    required this.backgroundChoiceSummary,
    super.key,
  });

  final String raceChoiceSummary;
  final String classChoiceSummary;
  final String backgroundChoiceSummary;

  @override
  Widget build(BuildContext context) {
    return _SummarySectionCard(
      title: 'Выборы',
      child: Column(
        children: [
          SummaryLine(label: 'Выборы расы', value: raceChoiceSummary),
          SummaryLine(label: 'Выборы класса', value: classChoiceSummary),
          SummaryLine(
            label: 'Выборы предыстории',
            value: backgroundChoiceSummary,
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
            choice.selectedText ??
            choice.optionKey ??
            choice.selectedLanguage?.name ??
            choice.selectedToolKey ??
            choice.selectedSpellKey ??
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

String _formatName(String value) {
  final normalized = value.replaceAllMapped(
    RegExp(r'([a-z])([A-Z])'),
    (match) => '${match.group(1)} ${match.group(2)}',
  );
  return normalized.isEmpty
      ? normalized
      : normalized[0].toUpperCase() + normalized.substring(1);
}
