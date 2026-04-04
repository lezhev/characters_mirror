import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/error_widget.dart';
import 'package:characters_mirror_flutter/features/character_creation/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/features/character_creation/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/features/character_sheet/application/character_sheet_state.dart';
import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummaryStep extends HookConsumerWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaving = useState(false);
    final state = ref.watch(characterCreationProvider);
    final classEntries =
        state.character.classEntries ?? const <CharacterClassEntryData>[];
    final choices = state.character.choices ?? const <CharacterChoiceData>[];
    final classEntry = classEntries.isNotEmpty ? classEntries.first : null;
    final classChoiceSummary = _choiceSummary(
      choices.where(_isClassChoice).toList(),
    );
    final backgroundChoiceSummary = _choiceSummary(
      choices.where((choice) => choice.sourceType == ChoiceSourceType.background).toList(),
    );
    final raceChoiceSummary = _choiceSummary(
      choices
          .where((choice) =>
              choice.sourceType == ChoiceSourceType.race ||
              choice.sourceType == ChoiceSourceType.subrace)
          .toList(),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CreationAppBar.height),
        child: CreationAppBar(
          title: "Создание персонажа",
          onBack: () {
            ref.read(characterCreationProvider.notifier).reset();
            context.go('/characters');
          },
          onStepTap: (target) => ref
              .read(characterCreationProvider.notifier)
              .goToStep(context, target),
        ),
      ),
      body: PageSizeLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Сводка персонажа',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const Gap(12),
                _SummaryLine(
                    label: 'Имя', value: state.character.name ?? 'Без имени'),
                _SummaryLine(
                    label: 'Раса',
                    value: state.character.race?.name ?? 'Не выбрана'),
                _SummaryLine(
                  label: 'Подраса',
                  value: state.character.subrace?.name ?? 'Не выбрана',
                ),
                _SummaryLine(
                  label: 'Класс',
                  value: classEntry?.classData?.name ?? 'Не выбран',
                ),
                _SummaryLine(
                  label: 'Подкласс',
                  value: classEntry?.subclass?.name ?? 'Не выбран',
                ),
                _SummaryLine(
                  label: 'Уровень класса',
                  value: '${classEntry?.level ?? 0}',
                ),
                _SummaryLine(
                  label: 'Предыстория',
                  value: state.character.background?.name ?? 'Не выбрана',
                ),
                _SummaryLine(
                  label: 'Выборы расы',
                  value: raceChoiceSummary,
                ),
                _SummaryLine(
                  label: 'Выборы класса',
                  value: classChoiceSummary,
                ),
                _SummaryLine(
                  label: 'Выборы предыстории',
                  value: backgroundChoiceSummary,
                ),
                const Gap(12),
                Text(
                  'Базовые характеристики',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Gap(8),
                ...(state.character.baseAbilityScores ?? const <String, int>{})
                    .entries
                    .map(
                      (entry) => _SummaryLine(
                        label: _formatName(entry.key),
                        value: '${entry.value}',
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: CreationNavBar(
            onPressedNext: () {
              _finishCreation(
                context: context,
                ref: ref,
                character: state.character,
                isSaving: isSaving,
              );
            },
            route: 'character',
          ),
        ),
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 180,
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
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

Future<void> _finishCreation({
  required BuildContext context,
  required WidgetRef ref,
  required CharacterData character,
  required ValueNotifier<bool> isSaving,
}) async {
  if (isSaving.value) return;

  final messenger = ScaffoldMessenger.of(context);
  isSaving.value = true;

  try {
    final saved =
        await ref.read(characterRepositoryProvider).saveCharacter(character);
    final characterId = saved.id;
    if (characterId == null) {
      throw StateError(
        'Сервер сохранил персонажа без идентификатора.',
      );
    }

    ref.read(characterCreationProvider.notifier).reset();

    if (!context.mounted) return;
    context.go('/characters/sheet/$characterId');
  } catch (error) {
    if (!context.mounted) return;
    messenger.showSnackBar(
      SnackBar(
        content: Text(humanReadableError(error)),
      ),
    );
  } finally {
    if (context.mounted) {
      isSaving.value = false;
    }
  }
}

bool _isClassChoice(CharacterChoiceData choice) {
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

String _choiceSummary(List<CharacterChoiceData> choices) {
  if (choices.isEmpty) return 'Нет';

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
