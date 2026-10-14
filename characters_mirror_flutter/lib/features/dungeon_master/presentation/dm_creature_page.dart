import 'package:characters_mirror_flutter/core/ui/widgets/page_size_limiter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/dm_library_controller.dart';
import 'widgets/dm_creature_sections.dart';
import 'widgets/dm_error_view.dart';
import 'widgets/dm_raw_json_section.dart';

class DmCreaturePage extends ConsumerWidget {
  const DmCreaturePage({super.key, required this.creatureId});
  final int creatureId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(dmCreatureDetailProvider(creatureId));
    return Scaffold(
      appBar: AppBar(
          title: Text(detail.valueOrNull?.record.name ?? 'Существо'),
          leading: IconButton(
              tooltip: 'К библиотеке',
              onPressed: () => context.go('/dm'),
              icon: const Icon(Icons.arrow_back))),
      body: PageSizeLimiter(
          maxWidth: 1000,
          child: detail.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => DmErrorView(
                message: dmErrorMessage(error),
                onRetry: () =>
                    ref.invalidate(dmCreatureDetailProvider(creatureId))),
            data: (detail) {
              final creature = detail.creature;
              return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child:
                                  Wrap(spacing: 24, runSpacing: 8, children: [
                                Text(
                                    'КД: ${creature.armorClass ?? 'неизвестно'}'),
                                Text(
                                    'HP: ${creature.hpInitial ?? '?'} / ${creature.hpMax ?? '?'}'),
                                Text(
                                    'Инициатива: ${creature.initiativeBonus ?? 'неизвестно'}'),
                              ]))),
                      DmJsonSection(
                          title: 'Общие сведения', fields: creature.identity),
                      DmJsonSection(title: 'Настройки боя', fields: {
                        for (final entry in creature.combat.entries)
                          if (!{
                            'armorClass',
                            'hpMax',
                            'hpInitial',
                            'initiativeBonus',
                            'movement',
                            'senses'
                          }.contains(entry.key))
                            entry.key: entry.value
                      }),
                      DmJsonSection(
                          title: 'Характеристики и спасброски',
                          fields: creature.abilities),
                      DmJsonSection(
                          title: 'Навыки, языки и чувства',
                          fields: creature.otherStats),
                      DmJsonSection(title: 'Скорости и чувства', fields: {
                        'movement': creature.combat['movement'],
                        'senses': creature.combat['senses']
                      }),
                      DmJsonSection(
                          title: 'Сопротивления, иммунитеты и уязвимости',
                          fields: creature.defenses),
                      DmItemSection(
                          title: 'Действия, особенности и предметы',
                          items: creature.items
                              .where((item) => item.itemType != 'spell')
                              .toList()),
                      DmItemSection(
                          title: 'Заклинания',
                          items: creature.items
                              .where((item) => item.itemType == 'spell')
                              .toList()),
                      DmJsonSection(
                          title: 'Ячейки заклинаний',
                          fields: creature.spellSlots),
                      DmJsonSection(
                          title: 'Ресурсы', fields: creature.resources),
                      Card(
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text('Диагностика импорта',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(height: 12),
                                    if (creature.diagnostics.isEmpty)
                                      const Text('Предупреждений нет.'),
                                    for (final diagnostic
                                        in creature.diagnostics)
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: SelectableText(diagnostic)),
                                  ]))),
                      DmRawJsonSection(
                          key: ValueKey(detail.record.id),
                          rawJson: detail.record.rawJson),
                    ],
                  ));
            },
          )),
    );
  }
}
