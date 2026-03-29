import 'package:characters_mirror_flutter/app/pages/creation_flow/state/character_creation_state.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_app_bar.dart';
import 'package:characters_mirror_flutter/app/pages/creation_flow/widgets/creation_nav_bar.dart';
import 'package:characters_mirror_flutter/app/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class IntroductionStep extends ConsumerWidget {
  const IntroductionStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CreationAppBar(
        title: "Создание персонажа",
        onBack: () {
          ref.read(characterCreationProvider.notifier).reset();
          context.go('/characters');
        },
        onStepTap: (target) => ref
            .read(characterCreationProvider.notifier)
            .goToStep(context, target),
      ),
      body: PageSizeLimiter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Как будет устроено создание персонажа',
                  style: textTheme.headlineSmall,
                ),
                const Gap(8),
                Text(
                  'Этот экран открывает создание персонажа и знакомит с тем, как будет развиваться процесс в приложении. Сейчас доступен один сценарий: он проводит по основным шагам последовательно и помогает собрать персонажа без ручной навигации по всем настройкам.',
                  style: textTheme.bodyLarge,
                ),
                const Gap(12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.outlineVariant,
                    ),
                  ),
                  child: Text(
                    'Со временем здесь появится выбор нескольких creation flow: с дополнительными пояснениями для новичков, с более свободной ручной настройкой и с поддержкой новых редакций D&D.',
                    style: textTheme.bodyMedium,
                  ),
                ),
                const Gap(24),
                Text(
                  'Доступный сценарий',
                  style: textTheme.headlineSmall,
                ),
                const Gap(12),
                _FlowCard(
                  icon: Icons.auto_awesome_outlined,
                  title: 'Пошаговое создание персонажа',
                  badge: 'Доступно сейчас',
                  badgeColor: colorScheme.primary,
                  badgeTextColor: colorScheme.onPrimary,
                  description:
                      'Текущий маршрут последовательно проводит по ключевым этапам: выбору расы, класса, характеристик, предыстории и персональных деталей.',
                  bullets: const [
                    'Подходит для стандартного создания персонажа без лишних развилок.',
                    'Сохраняет текущий порядок шагов и уже встроен в существующий flow.',
                    'Позволяет сосредоточиться на решениях, а не на навигации по экрану.',
                  ],
                  highlighted: true,
                ),
                const Gap(24),
                Text(
                  'Что появится позже',
                  style: textTheme.headlineSmall,
                ),
                const Gap(12),
                _FlowCard(
                  icon: Icons.school_outlined,
                  title: 'Режим для новичков',
                  badge: 'Запланировано',
                  badgeColor: colorScheme.surfaceContainerHighest,
                  badgeTextColor: colorScheme.onSurface,
                  description:
                      'Отдельный сценарий для тех, кто только знакомится с созданием персонажей и хочет больше контекста на каждом шаге.',
                  bullets: const [
                    'Пояснения по правилам и базовым терминам рядом с выбором.',
                    'Подсказки, зачем нужен каждый шаг и на что он влияет дальше.',
                    'Более мягкое ведение по процессу без необходимости знать систему заранее.',
                  ],
                ),
                const Gap(12),
                _FlowCard(
                  icon: Icons.tune_outlined,
                  title: 'Ручная настройка после пропуска',
                  badge: 'Запланировано',
                  badgeColor: colorScheme.surfaceContainerHighest,
                  badgeTextColor: colorScheme.onSurface,
                  description:
                      'Сценарий для тех, кто хочет пропустить guided-flow и затем самостоятельно выбрать все параметры персонажа вручную.',
                  bullets: const [
                    'Быстрый вход без прохождения каждого шага по очереди.',
                    'Подходит для опытных игроков с уже готовой концепцией персонажа.',
                    'Даёт возможность собрать итоговый вариант через прямой выбор нужных параметров.',
                  ],
                ),
                const Gap(12),
                _FlowCard(
                  icon: Icons.menu_book_outlined,
                  title: 'Выбор редакции D&D',
                  badge: 'Запланировано',
                  badgeColor: colorScheme.surfaceContainerHighest,
                  badgeTextColor: colorScheme.onSurface,
                  description:
                      'Позже страница сможет учитывать разные редакции системы и предлагать подходящий сценарий создания под выбранные правила.',
                  bullets: const [
                    'Подготовит основу для поддержки новых редакций без перегрузки текущего маршрута.',
                    'Поможет разделять доступные правила и варианты выбора по системе.',
                    'Сделает старт создания персонажа понятнее, когда в приложении появится несколько редакций.',
                  ],
                ),
                const Gap(24),
                Text(
                  'Сейчас можно начать с текущего пошагового сценария, а когда появятся новые варианты, эта страница станет точкой выбора подходящего creation flow.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
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
              ref.read(characterCreationProvider.notifier).nextStep(context);
            },
            route: 'race',
          ),
        ),
      ),
    );
  }
}

class _FlowCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String badge;
  final Color badgeColor;
  final Color badgeTextColor;
  final String description;
  final List<String> bullets;
  final bool highlighted;

  const _FlowCard({
    required this.icon,
    required this.title,
    required this.badge,
    required this.badgeColor,
    required this.badgeTextColor,
    required this.description,
    required this.bullets,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: highlighted
          ? colorScheme.primaryContainer.withValues(alpha: 0.42)
          : colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: highlighted ? colorScheme.primary : colorScheme.outlineVariant,
          width: highlighted ? 1.4 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: highlighted
                        ? colorScheme.primary.withValues(alpha: 0.12)
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: highlighted
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: textTheme.titleMedium,
                      ),
                      const Gap(6),
                      _FlowBadge(
                        label: badge,
                        color: badgeColor,
                        textColor: badgeTextColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(16),
            Text(
              description,
              style: textTheme.bodyMedium,
            ),
            const Gap(12),
            ...bullets.map(
              (bullet) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: highlighted
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Text(
                        bullet,
                        style: textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _FlowBadge({
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
