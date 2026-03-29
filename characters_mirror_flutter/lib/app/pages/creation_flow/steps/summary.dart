import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SummaryStep extends ConsumerWidget {
  const SummaryStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(characterCreationProvider);
    final classEntry =
        state.classEntries.isNotEmpty ? state.classEntries.first : null;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(CreationAppBar.height),
        child: CreationAppBar(
          title: "Создание персонажа",
          onBack: () {
            ref.read(characterCreationProvider.notifier).reset();
            context.go('/characters');
          },
          onStepTap: (target) =>
              ref.read(characterCreationProvider.notifier).goToStep(context, target),
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
                _SummaryLine(label: 'Имя', value: state.character.name ?? 'Без имени'),
                _SummaryLine(label: 'Раса', value: state.character.race?.name ?? 'Не выбрана'),
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
                  label: 'Выборы класса',
                  value: '${state.choices.length}',
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
            onPressedNext: () {},
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
