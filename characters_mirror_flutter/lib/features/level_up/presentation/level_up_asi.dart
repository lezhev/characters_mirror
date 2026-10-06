import 'package:characters_mirror_client/characters_mirror_client.dart';
import 'package:characters_mirror_flutter/features/character_sheet/presentation/pages/attributes/helpers/attributes_labels.dart';
import 'package:flutter/material.dart';

class LevelUpAsi extends StatelessWidget {
  const LevelUpAsi(
      {super.key,
      required this.scores,
      required this.allocation,
      required this.onTap,
      required this.onFeat,
      this.catalogSupportsAllocation = true});
  final Map<Ability, int> scores;
  final Map<Ability, int> allocation;
  final void Function(Ability) onTap;
  final VoidCallback onFeat;
  final bool catalogSupportsAllocation;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spent = allocation.values.fold<int>(0, (a, b) => a + b);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(children: [
        Expanded(
            child: Text('Характеристики · $spent / 2',
                style: theme.textTheme.titleMedium)),
        TextButton(onPressed: onFeat, child: const Text('Выбрать черту'))
      ]),
      GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.25,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
          children: [
            for (final ability in Ability.values)
              Builder(builder: (context) {
                final bonus = allocation[ability] ?? 0;
                final score = scores[ability] ?? 10;
                return Semantics(
                    button: true,
                    selected: bonus > 0,
                    label:
                        '${attributesAbilityLabel(ability)}, $score, прибавка $bonus',
                    child: Material(
                        color: bonus == 2
                            ? theme.colorScheme.primaryContainer
                            : theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                                color: bonus > 0
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.outlineVariant,
                                width: bonus == 2
                                    ? 3
                                    : bonus == 1
                                        ? 2
                                        : 1)),
                        child: InkWell(
                            key: ValueKey('asi-${ability.name}'),
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => onTap(ability),
                            child: Center(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                  Text(
                                      '${shortAbilityLabel(ability).toUpperCase()}${bonus == 0 ? '' : ' +$bonus'}',
                                      style: theme.textTheme.labelLarge),
                                  Text(bonus == 0
                                      ? '$score'
                                      : '$score → ${score + bonus}'),
                                ])))));
              })
          ]),
      if (!catalogSupportsAllocation)
        const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Text(
                'Для этой комбинации нет варианта в данных класса. Выберите другую комбинацию.')),
    ]);
  }
}
